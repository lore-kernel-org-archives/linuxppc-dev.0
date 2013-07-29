Return-Path: <B07421@freescale.com>
Received: from co1outboundpool.messaging.microsoft.com
 (co1ehsobe006.messaging.microsoft.com [216.32.180.189])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id B2B812C00E1
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 Jul 2013 09:53:23 +1000 (EST)
Received: from mail15-co1 (localhost [127.0.0.1])	by mail15-co1-R.bigfish.com
 (Postfix) with ESMTP id 5F8A58600C9	for
 <linuxppc-dev@lists.ozlabs.org>; Mon,
 29 Jul 2013 23:53:18 +0000 (UTC)
Received: from CO1EHSMHS007.bigfish.com (unknown [10.243.78.227])	by
 mail15-co1.bigfish.com (Postfix) with ESMTP id DDF40DA0047	for
 <linuxppc-dev@lists.ozlabs.org>; Mon, 29 Jul 2013 23:53:15 +0000 (UTC)
Date: Mon, 29 Jul 2013 18:53:13 -0500
From: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH v2] powerpc: Update compilation flags with core specific
 options
To: Catalin Udma <catalin.udma@freescale.com>
References: <1374753254-10381-1-git-send-email-catalin.udma@freescale.com>
In-Reply-To: <1374753254-10381-1-git-send-email-catalin.udma@freescale.com>
 (from catalin.udma@freescale.com on Thu Jul 25 06:54:14 2013)
Message-ID: <1375141993.30721.67@snotra>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; delsp=Yes; format=Flowed
Cc: Catalin Udma <catalin.udma@freescale.com>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 07/25/2013 06:54:14 AM, Catalin Udma wrote:
> If CONFIG_E500 is enabled, the compilation flags are updated
> specifying the target core -mcpu=3De5500/e500mc/8540
> Also remove -Wa,-me500, being incompatible with -mcpu=3De5500/e6500
> The assembler option is redundant if the -mcpu=3D flag is set.
> The patch fixes the kernel compilation problem for e5500/e6500
> when using gcc option -mcpu=3De5500/e6500.
>=20
> Signed-off-by: Catalin Udma <catalin.udma@freescale.com>
> ---
> changes for v2:
>     - update also KBUILD_AFLAGS with -mcpu and -msoft-float flags
>=20
>  arch/powerpc/Makefile |   16 +++++++++++++++-
>  1 files changed, 15 insertions(+), 1 deletions(-)
>=20
> diff --git a/arch/powerpc/Makefile b/arch/powerpc/Makefile
> index 0624909..cb5cbe2 100644
> --- a/arch/powerpc/Makefile
> +++ b/arch/powerpc/Makefile
> @@ -140,6 +140,21 @@ ifeq ($(CONFIG_6xx),y)
>  KBUILD_CFLAGS		+=3D -mcpu=3Dpowerpc
>  endif
>=20
> +ifeq ($(CONFIG_E500),y)
> +ifeq ($(CONFIG_64BIT),y)
> +KBUILD_CFLAGS		+=3D -mcpu=3De5500
> +KBUILD_AFLAGS		+=3D -mcpu=3De5500 -msoft-float
> +else
> +ifeq ($(CONFIG_PPC_E500MC),y)
> +KBUILD_CFLAGS		+=3D -mcpu=3De500mc
> +KBUILD_AFLAGS		+=3D -mcpu=3De500mc -msoft-float
> +else
> +KBUILD_CFLAGS		+=3D -mcpu=3D8540
> +KBUILD_AFLAGS		+=3D -mcpu=3D8540 -msoft-float
> +endif
> +endif
> +endif

Instead of specifying -msoft-float here, shouldn't it go on the main =20
KBUILD_AFLAGS in arch/powerpc/Makefile, right next to where it's added =20
for KBUILD_CFLAGS?

-Scott=
