Return-Path: <B07421@freescale.com>
Received: from co1outboundpool.messaging.microsoft.com
 (co1ehsobe005.messaging.microsoft.com [216.32.180.188])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 501422C00C1
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Jul 2013 10:11:27 +1000 (EST)
Received: from mail133-co1 (localhost [127.0.0.1])	by
 mail133-co1-R.bigfish.com (Postfix) with ESMTP id AAA014C01A8	for
 <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Jul 2013 00:11:22 +0000 (UTC)
Received: from CO1EHSMHS021.bigfish.com (unknown [10.243.78.231])	by
 mail133-co1.bigfish.com (Postfix) with ESMTP id B3D5BB40048	for
 <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Jul 2013 00:11:20 +0000 (UTC)
Date: Tue, 23 Jul 2013 19:11:17 -0500
From: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH] Update compilation flags with core specific options
To: Catalin Udma <catalin.udma@freescale.com>
In-Reply-To: <1372764004-18896-1-git-send-email-catalin.udma@freescale.com>
 (from catalin.udma@freescale.com on Tue Jul  2 06:20:04 2013)
Message-ID: <1374624677.15592.48@snotra>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; delsp=Yes; format=Flowed
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 07/02/2013 06:20:04 AM, Catalin Udma wrote:
> If CONFIG_E500 is enabled, the compilation flags are updated
> specifying the target core -mcpu=3De5500/e500mc/8540
> Also remove -Wa,-me500, being incompatible with -mcpu=3De5500/e6500
> The assembler option is redundant if the -mcpu=3D flag is set.
> The patch fixes the kernel compilation problem for e5500/e6500
> when using gcc option -mcpu=3De5500/e6500.
>=20
> Signed-off-by: Catalin Udma <catalin.udma@freescale.com>
> ---
>  arch/powerpc/Makefile |   13 ++++++++++++-
>  1 files changed, 12 insertions(+), 1 deletions(-)
>=20
> diff --git a/arch/powerpc/Makefile b/arch/powerpc/Makefile
> index 0624909..82808b5 100644
> --- a/arch/powerpc/Makefile
> +++ b/arch/powerpc/Makefile
> @@ -140,6 +140,18 @@ ifeq ($(CONFIG_6xx),y)
>  KBUILD_CFLAGS		+=3D -mcpu=3Dpowerpc
>  endif
>=20
> +ifeq ($(CONFIG_E500),y)
> +ifeq ($(CONFIG_64BIT),y)
> +KBUILD_CFLAGS		+=3D -mcpu=3De5500
> +else
> +ifeq ($(CONFIG_PPC_E500MC),y)
> +KBUILD_CFLAGS		+=3D -mcpu=3De500mc
> +else
> +KBUILD_CFLAGS		+=3D -mcpu=3D8540
> +endif
> +endif
> +endif
> +
>  # Work around a gcc code-gen bug with -fno-omit-frame-pointer.
>  ifeq ($(CONFIG_FUNCTION_TRACER),y)
>  KBUILD_CFLAGS		+=3D -mno-sched-epilog
> @@ -147,7 +159,6 @@ endif
>=20
>  cpu-as-$(CONFIG_4xx)		+=3D -Wa,-m405
>  cpu-as-$(CONFIG_ALTIVEC)	+=3D -Wa,-maltivec
> -cpu-as-$(CONFIG_E500)		+=3D -Wa,-me500
>  cpu-as-$(CONFIG_E200)		+=3D -Wa,-me200
>=20
>  KBUILD_AFLAGS +=3D $(cpu-as-y)

This breaks the vdso for e500v1/v2 (userspace dies with SIGILL), since =20
KBUILD_CFLAGS doesn't get used when building asm files, and the vdso =20
uses mftbu/mftbl which are not being assembled to the form that =20
e500v1/v2 support.

We should be setting -mcpu=3Dwhatever and -msoft-float in both CFLAGS and =20
AFLAGS, since we don't call "as" directly, and target selection should =20
not differ based on whether we're building a C file or an asm file.

-Scott=
