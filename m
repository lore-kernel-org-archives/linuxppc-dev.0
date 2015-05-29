Return-Path: <nikunj@linux.vnet.ibm.com>
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 09D861A0045
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 May 2015 14:26:49 +1000 (AEST)
Received: from /spool/local
 by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <nikunj@linux.vnet.ibm.com>;
 Fri, 29 May 2015 14:26:48 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id A7CC13578048
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 May 2015 14:26:45 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t4T4QaVx65470520
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 May 2015 14:26:44 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t4T4QCFD012008
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 May 2015 14:26:13 +1000
From: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
To: Greg Kurz <gkurz@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, Thomas Huth <thuth@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH 3/3] fbuffer: introduce the invert-region-x helper
In-Reply-To: <20150528131324.5240.37470.stgit@bahia.lab.toulouse-stg.fr.ibm.com>
References: <20150528131309.5240.71135.stgit@bahia.lab.toulouse-stg.fr.ibm.com>
 <20150528131324.5240.37470.stgit@bahia.lab.toulouse-stg.fr.ibm.com>
Date: Fri, 29 May 2015 09:55:53 +0530
Message-ID: <87vbfc2eni.fsf@linux.vnet.ibm.com>
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

> This patch simply moves the slow RX based logic from fb8-invert-screen
> to board-js2x helpers and implement a fast hv-logical-memop based helper
> for board-qemu. And we can drop hcall-invert-screen !
>
> Signed-off-by: Greg Kurz <gkurz@linux.vnet.ibm.com>

Apart for the extra lines that Thomas pointed:

Reviewed-by: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>

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
