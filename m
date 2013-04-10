Return-Path: <B07421@freescale.com>
Received: from co9outboundpool.messaging.microsoft.com
 (co9ehsobe003.messaging.microsoft.com [207.46.163.26])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id B33052C009E
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Apr 2013 07:51:53 +1000 (EST)
Date: Wed, 10 Apr 2013 16:51:43 -0500
From: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH V5] powerpc/85xx: Add machine check handler to fix PCIe
 erratum on mpc85xx
To: Jia Hongtao <hongtao.jia@freescale.com>
In-Reply-To: <1365409614-2634-1-git-send-email-hongtao.jia@freescale.com>
 (from hongtao.jia@freescale.com on Mon Apr  8 03:26:54 2013)
Message-ID: <1365630703.8381.23@snotra>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; delsp=Yes; format=Flowed
Cc: hongtao.jia@freescale.com, B07421@freescale.com,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 04/08/2013 03:26:54 AM, Jia Hongtao wrote:
> @@ -826,6 +829,124 @@ u64 fsl_pci_immrbar_base(struct pci_controller =20
> *hose)
>  	return 0;
>  }
>=20
> +#ifdef CONFIG_E500
> +
> +#define OP_LWZ  32
> +#define OP_LWZU 33
> +#define OP_LBZ  34
> +#define OP_LBZU 35
> +#define OP_LHZ  40
> +#define OP_LHZU 41
> +#define OP_LHA  42
> +#define OP_LHAU 43

Can you move these to asm/ppc-opcode.h (or possibly =20
asm/ppc-disassemble.h if we don't want to mix the two methods of =20
describing instructions)?

> +static int mcheck_handle_load(struct pt_regs *regs, u32 inst)
> +{
> +	unsigned int rd, ra, d;
> +
> +	rd =3D get_rt(inst);
> +	ra =3D get_ra(inst);
> +	d =3D get_d(inst);
> +
> +	switch (get_op(inst)) {
> +	case OP_LWZ:
> +		regs->gpr[rd] =3D 0xffffffff;
> +		break;
> +
> +	case OP_LWZU:
> +		regs->gpr[rd] =3D 0xffffffff;
> +		regs->gpr[ra] +=3D (s16)d;
> +		break;
> +
> +	case OP_LBZ:
> +		regs->gpr[rd] =3D 0xff;
> +		break;
> +
> +	case OP_LBZU:
> +		regs->gpr[rd] =3D 0xff;
> +		regs->gpr[ra] +=3D (s16)d;
> +		break;
> +
> +	case OP_LHZ:
> +		regs->gpr[rd] =3D 0xffff;
> +		break;
> +
> +	case OP_LHZU:
> +		regs->gpr[rd] =3D 0xffff;
> +		regs->gpr[ra] +=3D (s16)d;
> +		break;
> +
> +	case OP_LHA:
> +		regs->gpr[rd] =3D 0xffff;
> +		break;
> +
> +	case OP_LHAU:
> +		regs->gpr[rd] =3D 0xffff;
> +		regs->gpr[ra] +=3D (s16)d;
> +		break;

The X and (especially for PCI) BRX versions are important -- probably =20
more so than the U versions.  I doubt we need the A variant.

If you do support the A variant, why are you not sign-extending the =20
value?

Is this erratum present on any 64-bit chips?

-Scott=
