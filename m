Return-Path: <nikunj@linux.vnet.ibm.com>
Received: from e28smtp04.in.ibm.com (e28smtp04.in.ibm.com [122.248.162.4])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id AB4971A0551
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 May 2015 14:17:14 +1000 (AEST)
Received: from /spool/local
 by e28smtp04.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <nikunj@linux.vnet.ibm.com>;
 Fri, 29 May 2015 09:47:12 +0530
Received: from d28relay05.in.ibm.com (d28relay05.in.ibm.com [9.184.220.62])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id BDD3B3940048
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 May 2015 09:47:07 +0530 (IST)
Received: from d28av05.in.ibm.com (d28av05.in.ibm.com [9.184.220.67])
 by d28relay05.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t4T4H6vB41091090
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 May 2015 09:47:07 +0530
Received: from d28av05.in.ibm.com (localhost [127.0.0.1])
 by d28av05.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t4T4H5Gb000812
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 May 2015 09:47:06 +0530
From: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
To: Greg Kurz <gkurz@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, Thomas Huth <thuth@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH 1/3] fbuffer: simplify address computations in
 fb8-toggle-cursor
In-Reply-To: <20150528131314.5240.44784.stgit@bahia.lab.toulouse-stg.fr.ibm.com>
References: <20150528131309.5240.71135.stgit@bahia.lab.toulouse-stg.fr.ibm.com>
 <20150528131314.5240.44784.stgit@bahia.lab.toulouse-stg.fr.ibm.com>
Date: Fri, 29 May 2015 09:47:04 +0530
Message-ID: <871ti03tmn.fsf@linux.vnet.ibm.com>
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

> The inner loop deals with a contiguous region. It could easily be replaced
> by faster board specific functions like hv-logical-memop in board-qemu.
> Since hv-logical-memop does not return an address, let's have the enclosing
> loop compute the next line address by itself and drop the confusing
> "char-width screen-depth * -" address adjustment.

Much better :-)

Reviewed-by: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>

>
> Signed-off-by: Greg Kurz <gkurz@linux.vnet.ibm.com>
> ---
>  slof/fs/fbuffer.fs |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/slof/fs/fbuffer.fs b/slof/fs/fbuffer.fs
> index 756f05a..faae6a9 100644
> --- a/slof/fs/fbuffer.fs
> +++ b/slof/fs/fbuffer.fs
> @@ -99,8 +99,8 @@ CREATE bitmap-buffer 400 4 * allot
>  : fb8-toggle-cursor ( -- )
>  	line# fb8-line2addr column# fb8-columns2bytes +
>  	char-height 0 ?DO
> -		char-width screen-depth * 0 ?DO dup dup rb@ -1 xor swap rb! 1+ LOOP
> -		screen-width screen-depth * + char-width screen-depth * -
> +		dup char-width screen-depth * 0 ?DO dup dup rb@ -1 xor swap rb! 1+ LOOP drop
> +		screen-width screen-depth * +
>  	LOOP drop
>  ;
