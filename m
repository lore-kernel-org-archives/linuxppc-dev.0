Return-Path: <Alexandre.Bounine@idt.com>
Received: from mxout1.idt.com (mxout1.idt.com [157.165.5.25])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mxout1.idt.com", Issuer "idt.com" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 74A76B7121
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 13 Nov 2010 03:30:54 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [PATCH][v3] fsl_rio: move machine_check handler into
	machine_check_e500 & machine_check_e500mc
Date: Fri, 12 Nov 2010 08:30:06 -0800
Message-ID: <0CE8B6BE3C4AD74AB97D9D29BD24E55201539084@CORPEXCH1.na.ads.idt.com>
In-Reply-To: <1289548520-24110-1-git-send-email-b21989@freescale.com>
References: <1289548520-24110-1-git-send-email-b21989@freescale.com>
From: "Bounine, Alexandre" <Alexandre.Bounine@idt.com>
To: "Shaohui Xie" <b21989@freescale.com>, <linuxppc-dev@lists.ozlabs.org>
Cc: akpm@linux-foundation.org, Kumar Gala <kumar.gala@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Shaohui Xie <b21989@freescale.com> wrote:
> diff --git a/arch/powerpc/kernel/traps.c b/arch/powerpc/kernel/traps.c
> index a45a63c..9ab7b97 100644
> --- a/arch/powerpc/kernel/traps.c
> +++ b/arch/powerpc/kernel/traps.c
> @@ -55,6 +55,7 @@
>  #endif
>  #include <asm/kexec.h>
>  #include <asm/ppc-opcode.h>
> +#include <asm/rio.h>
>=20
>  #if defined(CONFIG_DEBUGGER) || defined(CONFIG_KEXEC)
>  int (*__debugger)(struct pt_regs *regs) __read_mostly;
> @@ -425,6 +426,12 @@ int machine_check_e500mc(struct pt_regs *regs)
>  	unsigned long reason =3D mcsr;
>  	int recoverable =3D 1;
>=20
> +	if (reason & MCSR_BUS_RBERR) {
> +		recoverable =3D fsl_rio_mcheck_exception(regs);
> +		if (recoverable =3D=3D 1)
> +			goto silent_out;
> +	}
> +
>  	printk("Machine check in kernel mode.\n");
>  	printk("Caused by (from MCSR=3D%lx): ", reason);
>=20
> @@ -500,6 +507,7 @@ int machine_check_e500mc(struct pt_regs *regs)
>  		       reason & MCSR_MEA ? "Effective" : "Physical",
addr);
>  	}
>=20
> +silent_out:
>  	mtspr(SPRN_MCSR, mcsr);
>  	return mfspr(SPRN_MCSR) =3D=3D 0 && recoverable;
>  }
> @@ -507,6 +515,13 @@ int machine_check_e500mc(struct pt_regs *regs)
>  int machine_check_e500(struct pt_regs *regs)
>  {
>  	unsigned long reason =3D get_mc_reason(regs);
> +	int ret =3D 0;
> +
> +	if (reason & MCSR_BUS_RBERR) {
> +		ret =3D fsl_rio_mcheck_exception(regs);
> +		if (ret =3D=3D 1)
> +			return ret;
> +	}

Do we really need 'ret' variable here?
There is no further use of it by the rest of the code.
Maybe just return 1 here if fsl_rio_mcheck_exception() returns 1 ?

>=20
>  	printk("Machine check in kernel mode.\n");
>  	printk("Caused by (from MCSR=3D%lx): ", reason);
> @@ -536,7 +551,7 @@ int machine_check_e500(struct pt_regs *regs)
>  	if (reason & MCSR_BUS_RPERR)
>  		printk("Bus - Read Parity Error\n");
>=20
> -	return 0;
> +	return ret;
>  }
>  #elif defined(CONFIG_E200)
>  int machine_check_e200(struct pt_regs *regs)

Works for RapidIO as expected now.

Thank you,

Alex.
