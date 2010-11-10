Return-Path: <Alexandre.Bounine@idt.com>
Received: from mxout1.idt.com (mxout1.idt.com [157.165.5.25])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mxout1.idt.com", Issuer "idt.com" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id E14A1B7117
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 11 Nov 2010 09:55:37 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [PATCH 3/4][v2] fsl_rio: move machine_check handler into
	machine_check_e500 & machine_check_e500mc
Date: Wed, 10 Nov 2010 14:54:38 -0800
Message-ID: <0CE8B6BE3C4AD74AB97D9D29BD24E55201538B08@CORPEXCH1.na.ads.idt.com>
In-Reply-To: <1288777018-24259-1-git-send-email-b21989@freescale.com>
References: <1288777018-24259-1-git-send-email-b21989@freescale.com>
From: "Bounine, Alexandre" <Alexandre.Bounine@idt.com>
To: "Shaohui Xie" <b21989@freescale.com>, <akpm@linux-foundation.org>
Cc: Kumar Gala <kumar.gala@freescale.com>, linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Shaohui Xie <b21989@freescale.com> wrote:
>=20
> diff --git a/arch/powerpc/kernel/traps.c b/arch/powerpc/kernel/traps.c
> index a45a63c..2a5fb9d 100644
> --- a/arch/powerpc/kernel/traps.c
> +++ b/arch/powerpc/kernel/traps.c
> @@ -55,6 +55,7 @@
>  #endif
>  #include <asm/kexec.h>
>  #include <asm/ppc-opcode.h>
> +#include <linux/rio.h>
>=20
>  #if defined(CONFIG_DEBUGGER) || defined(CONFIG_KEXEC)
>  int (*__debugger)(struct pt_regs *regs) __read_mostly;
> @@ -500,6 +501,13 @@ int machine_check_e500mc(struct pt_regs *regs)
>  		       reason & MCSR_MEA ? "Effective" : "Physical",
addr);
>  	}
>=20
> +	if (reason & MCSR_BUS_RBERR) {
> +		printk("Bus - Read Data Bus Error\n");
> +#ifdef CONFIG_RAPIDIO
> +		recoverable =3D fsl_rio_mcheck_exception(regs);
> +#endif
> +	}
> +
>  	mtspr(SPRN_MCSR, mcsr);
>  	return mfspr(SPRN_MCSR) =3D=3D 0 && recoverable;
>  }
> @@ -527,8 +535,12 @@ int machine_check_e500(struct pt_regs *regs)
>  		printk("Bus - Write Address Error\n");
>  	if (reason & MCSR_BUS_IBERR)
>  		printk("Bus - Instruction Data Error\n");
> -	if (reason & MCSR_BUS_RBERR)
> +	if (reason & MCSR_BUS_RBERR) {
>  		printk("Bus - Read Data Bus Error\n");
> +#ifdef CONFIG_RAPIDIO
> +		fsl_rio_mcheck_exception(regs);
> +#endif
> +	}
>  	if (reason & MCSR_BUS_WBERR)
>  		printk("Bus - Read Data Bus Error\n");
>  	if (reason & MCSR_BUS_IPERR)

This implementation breaks an intended use of
fsl_rio_mcheck_exception():=20
1. for e500 it does not check the return value of the rio handler and
crashes the system even after RIO Mchk was serviced. Looks like e500mc
version handles it better but I have no HW to test it.
2. the RIO Mchk is expected to be handled quietly but here it has many
printk's. May be it is better to call the fsl_rio_mcheck_exception()
handler in very beginning and simply exit if it returns 1.

Alex.
=20
 =20
