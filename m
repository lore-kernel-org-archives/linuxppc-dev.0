Return-Path: <thuth@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B1A991A02BD
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 May 2015 03:33:19 +1000 (AEST)
Date: Thu, 28 May 2015 19:33:10 +0200
From: Thomas Huth <thuth@redhat.com>
To: Greg Kurz <gkurz@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, Alexey Kardashevskiy <aik@ozlabs.ru>,
 Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>, David Gibson
 <david@gibson.dropbear.id.au>
Subject: Re: [PATCH 3/3] fbuffer: introduce the invert-region-x helper
Message-ID: <20150528193310.03a2460a@thh440s>
In-Reply-To: <20150528131324.5240.37470.stgit@bahia.lab.toulouse-stg.fr.ibm.com>
References: <20150528131309.5240.71135.stgit@bahia.lab.toulouse-stg.fr.ibm.com>
 <20150528131324.5240.37470.stgit@bahia.lab.toulouse-stg.fr.ibm.com>
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

On Thu, 28 May 2015 15:13:24 +0200
Greg Kurz <gkurz@linux.vnet.ibm.com> wrote:

> This patch simply moves the slow RX based logic from fb8-invert-screen
> to board-js2x helpers and implement a fast hv-logical-memop based helper
> for board-qemu. And we can drop hcall-invert-screen !
> 
> Signed-off-by: Greg Kurz <gkurz@linux.vnet.ibm.com>
> ---
>  board-js2x/slof/helper.fs               |    5 +++++
>  board-qemu/slof/helper.fs               |    4 ++++
>  board-qemu/slof/pci-device_1234_1111.fs |   10 +---------
>  slof/fs/fbuffer.fs                      |    4 +---
>  4 files changed, 11 insertions(+), 12 deletions(-)
> 
> diff --git a/board-js2x/slof/helper.fs b/board-js2x/slof/helper.fs
> index 918fdc4..ea2d584 100644
> --- a/board-js2x/slof/helper.fs
> +++ b/board-js2x/slof/helper.fs
> @@ -30,3 +30,8 @@
>  : invert-region ( addr len -- )
>     0 ?DO dup dup rb@ -1 xor swap rb! 1+ LOOP drop
>  ;
> +
> +

Maybe remove one of the two empty lines?

> +: invert-region-x ( addr len -- )
> +   /x / 0 ?DO dup dup rx@ -1 xor swap rx! xa1+ LOOP drop
> +;
> diff --git a/board-qemu/slof/helper.fs b/board-qemu/slof/helper.fs
> index da676c7..c807bc6 100644
> --- a/board-qemu/slof/helper.fs
> +++ b/board-qemu/slof/helper.fs
> @@ -36,3 +36,7 @@
>  : invert-region ( addr len -- )
>     over swap 0 swap 1 hv-logical-memop drop
>  ;
> +
> +: invert-region-x ( addr len -- )
> +   over swap /x / 3 swap 1 hv-logical-memop drop
> +;
> diff --git a/board-qemu/slof/pci-device_1234_1111.fs b/board-qemu/slof/pci-device_1234_1111.fs
> index a5c3584..26b0623 100644
> --- a/board-qemu/slof/pci-device_1234_1111.fs
> +++ b/board-qemu/slof/pci-device_1234_1111.fs
> @@ -188,16 +188,9 @@ a CONSTANT VBE_DISPI_INDEX_NB
>  : display-remove ( -- ) 
>  ;
>  
> -: hcall-invert-screen ( -- )
> -    frame-buffer-adr frame-buffer-adr 3
> -    screen-height screen-width * screen-depth * /x /
> -    1 hv-logical-memop
> -    drop
> -;
> -
>  : hcall-blink-screen ( -- )
>      \ 32 msec delay for visually noticing the blink
> -    hcall-invert-screen 20 ms hcall-invert-screen
> +    invert-screen 20 ms invert-screen
>  ;
>  
>  : display-install ( -- )
> @@ -211,7 +204,6 @@ a CONSTANT VBE_DISPI_INDEX_NB
>          disp-width char-width / disp-height char-height /
>          disp-depth 7 + 8 /                      ( width height #lines #cols depth )
>          fb-install
> -	['] hcall-invert-screen to invert-screen
>  	['] hcall-blink-screen to blink-screen
>           true to is-installed?
>      THEN
> diff --git a/slof/fs/fbuffer.fs b/slof/fs/fbuffer.fs
> index deeba6b..fcdd2fa 100644
> --- a/slof/fs/fbuffer.fs
> +++ b/slof/fs/fbuffer.fs
> @@ -170,9 +170,7 @@ CREATE bitmap-buffer 400 4 * allot
>  ;
>  
>  : fb8-invert-screen ( -- )
> -	frame-buffer-adr screen-height screen-width * screen-depth * 2dup /x / 0 ?DO
> -		dup rx@ -1 xor over rx! xa1+
> -	LOOP 3drop
> +	frame-buffer-adr screen-height screen-width * screen-depth * invert-region-x
>  ;
>  
>  : fb8-blink-screen ( -- ) fb8-invert-screen fb8-invert-screen ;

Reviewed-by: Thomas Huth <thuth@redhat.com>
