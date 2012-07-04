Return-Path: <B02008@freescale.com>
Received: from am1outboundpool.messaging.microsoft.com
 (am1ehsobe003.messaging.microsoft.com [213.199.154.206])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id C80292C01FF
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  5 Jul 2012 01:37:47 +1000 (EST)
From: Caraman Mihai Claudiu-B02008 <B02008@freescale.com>
To: Alexander Graf <agraf@suse.de>
Subject: RE: [Qemu-ppc] [RFC PATCH 15/17] KVM: PPC64: bookehv: Add support
 for interrupt handling
Date: Wed, 4 Jul 2012 15:37:26 +0000
Message-ID: <300B73AA675FCE4A93EB4FC1D42459FF15A6E8@039-SN2MPN1-013.039d.mgd.msft.net>
References: <1340627195-11544-1-git-send-email-mihai.caraman@freescale.com>
 <1340627195-11544-16-git-send-email-mihai.caraman@freescale.com>
 <FB7DFF5C-5E14-4202-9180-7968294F6A56@suse.de>
In-Reply-To: <FB7DFF5C-5E14-4202-9180-7968294F6A56@suse.de>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: "qemu-ppc@nongnu.org" <qemu-ppc@nongnu.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
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
> owner@vger.kernel.org] On Behalf Of Alexander Graf
> Sent: Wednesday, July 04, 2012 6:14 PM
> To: Caraman Mihai Claudiu-B02008
> Cc: kvm-ppc@vger.kernel.org; kvm@vger.kernel.org; linuxppc-
> dev@lists.ozlabs.org; qemu-ppc@nongnu.org
> Subject: Re: [Qemu-ppc] [RFC PATCH 15/17] KVM: PPC64: bookehv: Add
> support for interrupt handling
>=20
>=20
> On 25.06.2012, at 14:26, Mihai Caraman wrote:
>=20
> > Add bookehv interrupt handling support for 64-bit hosts. Change common
> stack
> > layout to refer PPC_LR_STKOFF kernel constant. Dispatch the 64-bit
> execution
> > flow to the existing kvm_handler_common asm macro. Update input
> register
> > values documentation.
> > Only the bolted version of TLB miss exception handlers is supported
> now.
> >
> > Signed-off-by: Mihai Caraman <mihai.caraman@freescale.com>
> > ---
> > arch/powerpc/include/asm/kvm_booke_hv_asm.h |   12 +++-
> > arch/powerpc/kvm/bookehv_interrupts.S       |  120
> +++++++++++++++++++++++++--
> > 2 files changed, 122 insertions(+), 10 deletions(-)
> >
> > diff --git a/arch/powerpc/include/asm/kvm_booke_hv_asm.h
> b/arch/powerpc/include/asm/kvm_booke_hv_asm.h
> > index 30a600f..8be6f87 100644
> > --- a/arch/powerpc/include/asm/kvm_booke_hv_asm.h
> > +++ b/arch/powerpc/include/asm/kvm_booke_hv_asm.h
> > @@ -1,5 +1,5 @@
> > /*
> > - * Copyright 2010-2011 Freescale Semiconductor, Inc.
> > + * Copyright 2010-2012 Freescale Semiconductor, Inc.
> >  *
> >  * This program is free software; you can redistribute it and/or modify
> >  * it under the terms of the GNU General Public License, version 2, as
> > @@ -17,6 +17,7 @@
> >  * there are no exceptions for which we fall through directly to
> >  * the normal host handler.
> >  *
> > + * 32-bit host
> >  * Expected inputs (normal exceptions):
> >  *   SCRATCH0 =3D saved r10
> >  *   r10 =3D thread struct
> > @@ -33,6 +34,15 @@
> >  *   *(r8 + GPR9) =3D saved r9
> >  *   *(r8 + GPR10) =3D saved r10 (r10 not yet clobbered)
> >  *   *(r8 + GPR11) =3D saved r11
> > + *
> > + * 64-bit host
> > + * Expected inputs (exception types GEN/DBG/CRIT/MC):
> > + *  r13 =3D PACA_POINTER
> > + *  r10 =3D saved CR
> > + *  SPRN_SPRG_##type##_SCRATCH =3D saved r13
> > + *  *(r13 + PACA_EX##type + EX_R10) =3D saved r10
> > + *  *(r13 + PACA_EX##type + EX_R11) =3D saved r11
> > + * Only the bolted version of TLB miss exception handlers is supported
> now.
> >  */
> > .macro DO_KVM intno srr1
> > #ifdef CONFIG_KVM_BOOKE_HV
> > diff --git a/arch/powerpc/kvm/bookehv_interrupts.S
> b/arch/powerpc/kvm/bookehv_interrupts.S
> > index dff8ed4..04097de 100644
> > --- a/arch/powerpc/kvm/bookehv_interrupts.S
> > +++ b/arch/powerpc/kvm/bookehv_interrupts.S
> > @@ -12,10 +12,11 @@
> >  * along with this program; if not, write to the Free Software
> >  * Foundation, 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301,
> USA.
> >  *
> > - * Copyright (C) 2010-2011 Freescale Semiconductor, Inc.
> > + * Copyright (C) 2010-2012 Freescale Semiconductor, Inc.
> >  *
> >  * Author: Varun Sethi <varun.sethi@freescale.com>
> >  * Author: Scott Wood <scotwood@freescale.com>
> > + * Author: Mihai Caraman <mihai.caraman@freescale.com>
> >  *
> >  * This file is derived from arch/powerpc/kvm/booke_interrupts.S
> >  */
> > @@ -30,7 +31,11 @@
> > #include <asm/bitsperlong.h>
> > #include <asm/thread_info.h>
> >
> > +#ifdef CONFIG_64BIT
> > +#include <asm/exception-64e.h>
> > +#else
> > #include "../kernel/head_booke.h" /* for THREAD_NORMSAVE() */
> > +#endif
> >
> >
> > +#ifdef CONFIG_64BIT
> > +/*
> > + * For input register values, see
> arch/powerpc/include/asm/kvm_booke_hv_asm.h
> > + */
> > +.macro kvm_handler intno scratch, paca_ex, ex_r10, ex_r11, srr0, srr1,
> flags
> > + _GLOBAL(kvmppc_handler_\intno\()_\srr1)
>=20
> Is this code so vastly different from the 32bit variant that they can't
> be the same with a few simple ifdef's here and there?

As you can see from input register values things are quite different. I str=
ived
to keep the code common, the only divergence is in the kvm_handler definiti=
ons.

-Mike
