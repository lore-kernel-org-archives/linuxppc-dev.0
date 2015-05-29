Return-Path: <nikunj@linux.vnet.ibm.com>
Received: from e28smtp08.in.ibm.com (e28smtp08.in.ibm.com [122.248.162.8])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 692E31A0C98
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 May 2015 14:18:02 +1000 (AEST)
Received: from /spool/local
 by e28smtp08.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <nikunj@linux.vnet.ibm.com>;
 Fri, 29 May 2015 09:47:59 +0530
Received: from d28relay05.in.ibm.com (d28relay05.in.ibm.com [9.184.220.62])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id 4382D1258056
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 May 2015 09:50:19 +0530 (IST)
Received: from d28av02.in.ibm.com (d28av02.in.ibm.com [9.184.220.64])
 by d28relay05.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t4T4HvGc56426690
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 May 2015 09:47:57 +0530
Received: from d28av02.in.ibm.com (localhost [127.0.0.1])
 by d28av02.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t4T3UQsG002057
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 May 2015 09:00:27 +0530
From: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
To: Greg Kurz <gkurz@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, Thomas Huth <thuth@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH 2/3] fbuffer: introduce the invert-region helper
In-Reply-To: <20150528131319.5240.4785.stgit@bahia.lab.toulouse-stg.fr.ibm.com>
References: <20150528131309.5240.71135.stgit@bahia.lab.toulouse-stg.fr.ibm.com>
 <20150528131319.5240.4785.stgit@bahia.lab.toulouse-stg.fr.ibm.com>
Date: Fri, 29 May 2015 09:47:55 +0530
Message-ID: <87y4k82f0s.fsf@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Greg Kurz <gkurz@linux.vnet.ibm.com> writes:

> The inner loop in fb8-toggle-cursor can be implemented with hv-logical-memop
> in board-qemu and get an incredible performance boost.
>
> Let's introduce a per-board helper:
> - board-js2x: slow RB based, taken from current fb8-toggle-cursor
> - board-qemu: faster hv-logical-memop based
>
> With standard graphical settings on board-qemu, we go from 512 hcall
> invocations per character down to 16.
>
> Suggested-by: Thomas Huth <thuth@redhat.com>
> Signed-off-by: Greg Kurz <gkurz@linux.vnet.ibm.com>

Reviewed-by: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>

> ---
>  board-js2x/slof/helper.fs |    4 ++++
>  board-qemu/slof/helper.fs |    3 +++
>  slof/fs/fbuffer.fs        |    2 +-
>  3 files changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/board-js2x/slof/helper.fs b/board-js2x/slof/helper.fs
> index 34d60da..918fdc4 100644
> --- a/board-js2x/slof/helper.fs
> +++ b/board-js2x/slof/helper.fs
> @@ -26,3 +26,7 @@
>     s" , " $cat
>     bdate2human $cat encode-string THEN
>  ;
> +
> +: invert-region ( addr len -- )
> +   0 ?DO dup dup rb@ -1 xor swap rb! 1+ LOOP drop
> +;
> diff --git a/board-qemu/slof/helper.fs b/board-qemu/slof/helper.fs
> index 96da498..da676c7 100644
> --- a/board-qemu/slof/helper.fs
> +++ b/board-qemu/slof/helper.fs
> @@ -33,3 +33,6 @@
>    swap -
>  ;
>
> +: invert-region ( addr len -- )
> +   over swap 0 swap 1 hv-logical-memop drop
> +;
> diff --git a/slof/fs/fbuffer.fs b/slof/fs/fbuffer.fs
> index faae6a9..deeba6b 100644
> --- a/slof/fs/fbuffer.fs
> +++ b/slof/fs/fbuffer.fs
> @@ -99,7 +99,7 @@ CREATE bitmap-buffer 400 4 * allot
>  : fb8-toggle-cursor ( -- )
>  	line# fb8-line2addr column# fb8-columns2bytes +
>  	char-height 0 ?DO
> -		dup char-width screen-depth * 0 ?DO dup dup rb@ -1 xor swap rb! 1+ LOOP drop
> +		dup char-width screen-depth * invert-region
>  		screen-width screen-depth * +
>  	LOOP drop
>  ;
