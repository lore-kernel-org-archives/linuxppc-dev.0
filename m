Return-Path: <B07421@freescale.com>
Received: from am1outboundpool.messaging.microsoft.com
 (am1ehsobe005.messaging.microsoft.com [213.199.154.208])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 3127C2C00FD
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 May 2013 07:27:49 +1000 (EST)
Date: Thu, 9 May 2013 16:27:36 -0500
From: Scott Wood <scottwood@freescale.com>
Subject: Re: [RFC][KVM][PATCH 1/1] kvm:ppc:booke-64: soft-disable interrupts
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <1368103062.25488.193.camel@pasglop> (from
 benh@kernel.crashing.org on Thu May  9 07:37:42 2013)
Message-ID: <1368134856.654.11@snotra>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; delsp=Yes; format=Flowed
Cc: Wood Scott-B07421 <B07421@freescale.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 Caraman Mihai Claudiu-B02008 <B02008@freescale.com>,
 "agraf@suse.de" <agraf@suse.de>,
 "kvm-ppc@vger.kernel.org" <kvm-ppc@vger.kernel.org>,
 "tiejun.chen" <tiejun.chen@windriver.com>,
 Bhushan Bharat-R65777 <R65777@freescale.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 05/09/2013 07:37:42 AM, Benjamin Herrenschmidt wrote:
> On Thu, 2013-05-09 at 17:44 +0800, tiejun.chen wrote:
> >
> > Actually in the case GS=3D1 even if EE=3D0, EXT/DEC/DBELL still occur =20
> as I
> > recall.
>=20
> Only if directed to the hypervisor.

This is always the case with KVM, right?  At least on booke...

> > > Case 1)
> > >   -> Local_irq_disable()  will set soft_enabled =3D 0
> > >   -> Now Externel interrupt happens, there we set PACA_IRQ_EE in
> > irq_happened, Also clears EE in SRR1 and rfi. So interrupts are hard
> > disabled. No more other interrupt gated by MSR.EE can happen. Looks
> > like the idea here is to not let a device keep on inserting =20
> interrupt
> > till the interrupt condition on device is cleared, right?
>=20
> The external interrupt line is level sensitive normally, so we have to
> mask MSR:EE in that case or the interrupt would keep re-occurring =20
> (note
> that FSL has this concept of auto-acked interrupts via the on die MPIC
> for which you can potentially use PACA_IRQ_EE_EDGE instead and avoid
> having to mask MSR:EE).

Note that if we do this, we can no longer leave the interrupt vector in =20
EPR, and would have to track (potentially multiple different) pending =20
external interrupts in software.

-Scott=
