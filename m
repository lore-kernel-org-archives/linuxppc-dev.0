Return-Path: <B02008@freescale.com>
Received: from co1outboundpool.messaging.microsoft.com
 (co1ehsobe004.messaging.microsoft.com [216.32.180.187])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 63C452C010B
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Apr 2013 22:11:31 +1000 (EST)
From: Caraman Mihai Claudiu-B02008 <B02008@freescale.com>
To: Tiejun Chen <tiejun.chen@windriver.com>, "galak@kernel.crashing.org"
 <galak@kernel.crashing.org>
Subject: RE: [PATCH 1/1] kvm:book3e: Fix a build error
Date: Thu, 25 Apr 2013 12:11:17 +0000
Message-ID: <300B73AA675FCE4A93EB4FC1D42459FF3D9C33@039-SN2MPN1-013.039d.mgd.msft.net>
References: <1366890336-4282-1-git-send-email-tiejun.chen@windriver.com>
In-Reply-To: <1366890336-4282-1-git-send-email-tiejun.chen@windriver.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "kvm-ppc@vger.kernel.org" <kvm-ppc@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> -----Original Message-----
> From: kvm-ppc-owner@vger.kernel.org [mailto:kvm-ppc-
> owner@vger.kernel.org] On Behalf Of Tiejun Chen
> Sent: Thursday, April 25, 2013 2:46 PM
> To: galak@kernel.crashing.org
> Cc: linuxppc-dev@lists.ozlabs.org; kvm-ppc@vger.kernel.org;
> kvm@vger.kernel.org
> Subject: [PATCH 1/1] kvm:book3e: Fix a build error
>=20
> Commit cd66cc2e, "powerpc/85xx: Add AltiVec support for e6500", adds
> support for AltiVec on a Book-E class processor, but while compiling
> in the CONFIG_PPC_BOOK3E_64 and CONFIG_VIRTUALIZATION case, this
> introduce the following error:
>=20
> arch/powerpc/kernel/exceptions-64e.S:402: undefined reference to
> `kvmppc_handler_42_0x01B'
> arch/powerpc/kernel/built-in.o: In function `exc_altivec_assist_book3e':
> arch/powerpc/kernel/exceptions-64e.S:424: undefined reference to
> `kvmppc_handler_43_0x01B'
> make: *** [vmlinux] Error 1
>=20
> Looks we should add these altivec kvm handlers.
>=20
> Signed-off-by: Tiejun Chen <tiejun.chen@windriver.com>
> ---
>  arch/powerpc/kvm/bookehv_interrupts.S |    5 +++++
>  1 file changed, 5 insertions(+)
>=20
> diff --git a/arch/powerpc/kvm/bookehv_interrupts.S
> b/arch/powerpc/kvm/bookehv_interrupts.S
> index e8ed7d6..fa9c78a 100644
> --- a/arch/powerpc/kvm/bookehv_interrupts.S
> +++ b/arch/powerpc/kvm/bookehv_interrupts.S
> @@ -319,6 +319,11 @@ kvm_handler BOOKE_INTERRUPT_DEBUG, EX_PARAMS(DBG), \
>  	SPRN_DSRR0, SPRN_DSRR1, 0
>  kvm_handler BOOKE_INTERRUPT_DEBUG, EX_PARAMS(CRIT), \
>  	SPRN_CSRR0, SPRN_CSRR1, 0
> +/* altivec */
> +kvm_handler BOOKE_INTERRUPT_ALTIVEC_UNAVAIL, EX_PARAMS(GEN), \
> +	SPRN_SRR0, SPRN_SRR1, 0
> +kvm_handler BOOKE_INTERRUPT_ALTIVEC_ASSIST, EX_PARAMS(GEN), \
> +	SPRN_SRR0, SPRN_SRR1, 0
>  #else
>  /*
>   * For input register values, see
> arch/powerpc/include/asm/kvm_booke_hv_asm.h
> --
=20
It seems that you are not using kvm-ppc-queue branch.

I already have a patch ready for this (and AltiVec support is work
in progress) but we need first to pull e6500 kernel patches from
Linux tree into agraf.git.
=20
-Mike



=20
