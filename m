Return-Path: <thuth@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 1805C1A1617
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 May 2015 03:19:35 +1000 (AEST)
Date: Thu, 28 May 2015 19:19:23 +0200
From: Thomas Huth <thuth@redhat.com>
To: Greg Kurz <gkurz@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, Alexey Kardashevskiy <aik@ozlabs.ru>,
 Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>, David Gibson
 <david@gibson.dropbear.id.au>
Subject: Re: [PATCH 2/3] fbuffer: introduce the invert-region helper
Message-ID: <20150528191923.4979e288@thh440s>
In-Reply-To: <20150528131319.5240.4785.stgit@bahia.lab.toulouse-stg.fr.ibm.com>
References: <20150528131309.5240.71135.stgit@bahia.lab.toulouse-stg.fr.ibm.com>
 <20150528131319.5240.4785.stgit@bahia.lab.toulouse-stg.fr.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 28 May 2015 15:13:19 +0200
Greg Kurz <gkurz@linux.vnet.ibm.com> wrote:

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

Reviewed-by: Thomas Huth <thuth@redhat.com>
