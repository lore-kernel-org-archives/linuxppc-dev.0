Return-Path: <Tiejun.Chen@windriver.com>
Received: from mail1.windriver.com (mail1.windriver.com [147.11.146.13])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mail1.windriver.com",
 Issuer "Intel External Basic Issuing CA 3A" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 41A8A2C00E4
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 May 2013 00:14:03 +1000 (EST)
From: "Chen, Tiejun" <Tiejun.Chen@windriver.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: RE: [RFC][KVM][PATCH 1/1] kvm:ppc:booke-64: soft-disable interrupts
Date: Thu, 9 May 2013 14:13:54 +0000
Message-ID: <82C960D7DF4A1F47B94FC1C67A29BEE36694AC3C@ALA-MBB.corp.ad.wrs.com>
References: <51885F49.6060605@windriver.com>	 (from
 tiejun.chen@windriver.com on Mon May  6 20:56:25 2013)
 <1367892390.3398.12@snotra>
 <300B73AA675FCE4A93EB4FC1D42459FF3F00D0@039-SN2MPN1-013.039d.mgd.msft.net>
 <6A3DF150A5B70D4F9B66A25E3F7C888D0700E64A@039-SN2MPN1-011.039d.mgd.msft.net>
 <518B7014.1090508@windriver.com> <1368103062.25488.193.camel@pasglop>
In-Reply-To: <1368103062.25488.193.camel@pasglop>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: Caraman Mihai Claudiu-B02008 <B02008@freescale.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 Wood Scott-B07421 <B07421@freescale.com>, "agraf@suse.de" <agraf@suse.de>,
 "kvm-ppc@vger.kernel.org" <kvm-ppc@vger.kernel.org>,
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

> -----Original Message-----
> From: Benjamin Herrenschmidt [mailto:benh@kernel.crashing.org]=20
> Sent: Thursday, May 09, 2013 8:38 PM
> To: Chen, Tiejun
> Cc: Bhushan Bharat-R65777; Caraman Mihai Claudiu-B02008; Wood=20
> Scott-B07421; linuxppc-dev@lists.ozlabs.org; agraf@suse.de;=20
> kvm-ppc@vger.kernel.org; kvm@vger.kernel.org
> Subject: Re: [RFC][KVM][PATCH 1/1] kvm:ppc:booke-64:=20
> soft-disable interrupts
>=20
> On Thu, 2013-05-09 at 17:44 +0800, tiejun.chen wrote:
> >=20
> > Actually in the case GS=3D1 even if EE=3D0, EXT/DEC/DBELL still=20
> occur as I=20
> > recall.
>=20
> Only if directed to the hypervisor.

Yes, this is our current booehv design with EPCR[EXTGS] =3D 0.

>=20
> > > Case 1)
> > >   -> Local_irq_disable()  will set soft_enabled =3D 0
> > >   -> Now Externel interrupt happens, there we set PACA_IRQ_EE in
> > irq_happened, Also clears EE in SRR1 and rfi. So interrupts=20
> are hard=20
> > disabled. No more other interrupt gated by MSR.EE can happen. Looks=20
> > like the idea here is to not let a device keep on inserting=20
> interrupt=20
> > till the interrupt condition on device is cleared, right?
>=20
> The external interrupt line is level sensitive normally, so=20
> we have to mask MSR:EE in that case or the interrupt would=20
> keep re-occurring (note that FSL has this concept of=20
> auto-acked interrupts via the on die MPIC for which you can=20
> potentially use PACA_IRQ_EE_EDGE instead and avoid having to=20
> mask MSR:EE).
>=20
> > I don't understand "the interrupt condition on device is cleared"
> > here.
>=20
> Well, the external interrupt line will remain asserted until=20
> the device (via the PIC) stops interrupting the processor :-)=20

Yes, the device keeps on interrupting the interrupt until the device clear =
its interrupted condition.

> Either because we mask at the PIC level (or raise the=20
> priority) or because the condition goes away.
> =20
> > I think regardless if you clear the device interrupt status, the=20
> > system still  receive a pending interrupt once EE or GS =3D 1.
>=20
> Why ? Depends on your PIC actually but if it's a sane one, it=20
> won't "remember" a level interrupt that is gone. An edge=20
> interrupt is a different matter and is latched.

But the interrupt controller like MPIC should leave this irq as pending if =
we don't ACK/EOI this irq at all if we just clear the device, right?

>=20
> Some MPIC implementations tend to generate a spurrious IRQ in=20
> the case of level IRQs going away. IE. they still remember an=20
> event occurred and interrupt the processor, but on IACK=20
> return the spurious vector. However that isn't guaranteed to=20

Yes, this is just what I mean. No matter if this vector is still valid, the=
 external interrupt exception always occur once EE =3D 1 again.

> be the case and it is perfectly ok (and a good
> idea) for the PIC to just stop asserting the external=20
> interrupt line if the original device interrupt goes away=20
> (and it's configured as level sensitive).

I don't remember MPIC can work with this way. So I'd like to look the manua=
l again :)

Tiejun=
