Return-Path: <B38951@freescale.com>
Received: from am1outboundpool.messaging.microsoft.com
 (am1ehsobe006.messaging.microsoft.com [213.199.154.209])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 8E18A2C00E2
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Apr 2013 19:15:02 +1000 (EST)
From: Jia Hongtao-B38951 <B38951@freescale.com>
To: Wood Scott-B07421 <B07421@freescale.com>
Subject: RE: [PATCH V5] powerpc/85xx: Add machine check handler to fix PCIe
 erratum on mpc85xx
Date: Thu, 11 Apr 2013 09:14:51 +0000
Message-ID: <412C8208B4A0464FA894C5F0C278CD5D01C35D42@039-SN1MPN1-003.039d.mgd.msft.net>
References: <1365409614-2634-1-git-send-email-hongtao.jia@freescale.com>
 (from hongtao.jia@freescale.com on Mon Apr  8 03:26:54 2013)
 <1365630703.8381.23@snotra>
In-Reply-To: <1365630703.8381.23@snotra>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Li Yang-R58472 <r58472@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



> -----Original Message-----
> From: Wood Scott-B07421
> Sent: Thursday, April 11, 2013 5:52 AM
> To: Jia Hongtao-B38951
> Cc: linuxppc-dev@lists.ozlabs.org; galak@kernel.crashing.org; Wood Scott-
> B07421; Li Yang-R58472; Jia Hongtao-B38951
> Subject: Re: [PATCH V5] powerpc/85xx: Add machine check handler to fix
> PCIe erratum on mpc85xx
>=20
> On 04/08/2013 03:26:54 AM, Jia Hongtao wrote:
> > @@ -826,6 +829,124 @@ u64 fsl_pci_immrbar_base(struct pci_controller
> > *hose)
> >  	return 0;
> >  }
> >
> > +#ifdef CONFIG_E500
> > +
> > +#define OP_LWZ  32
> > +#define OP_LWZU 33
> > +#define OP_LBZ  34
> > +#define OP_LBZU 35
> > +#define OP_LHZ  40
> > +#define OP_LHZU 41
> > +#define OP_LHA  42
> > +#define OP_LHAU 43
>=20
> Can you move these to asm/ppc-opcode.h (or possibly
> asm/ppc-disassemble.h if we don't want to mix the two methods of
> describing instructions)?

Yes, mix the two methods is not appropriate.
asm/ppc-disassemble.h is a nice choice.

>=20
> > +static int mcheck_handle_load(struct pt_regs *regs, u32 inst)
> > +{
> > +	unsigned int rd, ra, d;
> > +
> > +	rd =3D get_rt(inst);
> > +	ra =3D get_ra(inst);
> > +	d =3D get_d(inst);
> > +
> > +	switch (get_op(inst)) {
> > +	case OP_LWZ:
> > +		regs->gpr[rd] =3D 0xffffffff;
> > +		break;
> > +
> > +	case OP_LWZU:
> > +		regs->gpr[rd] =3D 0xffffffff;
> > +		regs->gpr[ra] +=3D (s16)d;
> > +		break;
> > +
> > +	case OP_LBZ:
> > +		regs->gpr[rd] =3D 0xff;
> > +		break;
> > +
> > +	case OP_LBZU:
> > +		regs->gpr[rd] =3D 0xff;
> > +		regs->gpr[ra] +=3D (s16)d;
> > +		break;
> > +
> > +	case OP_LHZ:
> > +		regs->gpr[rd] =3D 0xffff;
> > +		break;
> > +
> > +	case OP_LHZU:
> > +		regs->gpr[rd] =3D 0xffff;
> > +		regs->gpr[ra] +=3D (s16)d;
> > +		break;
> > +
> > +	case OP_LHA:
> > +		regs->gpr[rd] =3D 0xffff;
> > +		break;
> > +
> > +	case OP_LHAU:
> > +		regs->gpr[rd] =3D 0xffff;
> > +		regs->gpr[ra] +=3D (s16)d;
> > +		break;
>=20
> The X and (especially for PCI) BRX versions are important -- probably
> more so than the U versions.  I doubt we need the A variant.

Then I will add X and BRX variant and remove A variant.

>=20
> If you do support the A variant, why are you not sign-extending the
> value?

Just curious, sign-extending the value means fill rd with 0xffffffff?

>=20
> Is this erratum present on any 64-bit chips?

No. This erratum only happened in e500 core chips.

>=20
> -Scott

Thanks.
-Hongtao
