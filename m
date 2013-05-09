Return-Path: <R65777@freescale.com>
Received: from tx2outboundpool.messaging.microsoft.com
 (tx2ehsobe003.messaging.microsoft.com [65.55.88.13])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 6C7312C00EC
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  9 May 2013 18:23:58 +1000 (EST)
From: Bhushan Bharat-R65777 <R65777@freescale.com>
To: Caraman Mihai Claudiu-B02008 <B02008@freescale.com>, Wood Scott-B07421
 <B07421@freescale.com>, tiejun.chen <tiejun.chen@windriver.com>
Subject: RE: [RFC][KVM][PATCH 1/1] kvm:ppc:booke-64: soft-disable interrupts
Date: Thu, 9 May 2013 08:23:49 +0000
Message-ID: <6A3DF150A5B70D4F9B66A25E3F7C888D0700E64A@039-SN2MPN1-011.039d.mgd.msft.net>
References: <51885F49.6060605@windriver.com> (from tiejun.chen@windriver.com
 on Mon May  6 20:56:25 2013) <1367892390.3398.12@snotra>
 <300B73AA675FCE4A93EB4FC1D42459FF3F00D0@039-SN2MPN1-013.039d.mgd.msft.net>
In-Reply-To: <300B73AA675FCE4A93EB4FC1D42459FF3F00D0@039-SN2MPN1-013.039d.mgd.msft.net>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "agraf@suse.de" <agraf@suse.de>,
 "kvm-ppc@vger.kernel.org" <kvm-ppc@vger.kernel.org>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



> -----Original Message-----
> From: Linuxppc-dev [mailto:linuxppc-dev-
> bounces+bharat.bhushan=3Dfreescale.com@lists.ozlabs.org] On Behalf Of Car=
aman
> Mihai Claudiu-B02008
> Sent: Wednesday, May 08, 2013 6:44 PM
> To: Wood Scott-B07421; tiejun.chen
> Cc: linuxppc-dev@lists.ozlabs.org; agraf@suse.de; kvm-ppc@vger.kernel.org=
;
> kvm@vger.kernel.org
> Subject: RE: [RFC][KVM][PATCH 1/1] kvm:ppc:booke-64: soft-disable interru=
pts
>=20
> > > This only disable soft interrupt for kvmppc_restart_interrupt() that
> > > restarts interrupts if they were meant for the host:
> > >
> > > a. SOFT_DISABLE_INTS() only for BOOKE_INTERRUPT_EXTERNAL |
> > > BOOKE_INTERRUPT_DECREMENTER | BOOKE_INTERRUPT_DOORBELL
> >
> > Those aren't the only exceptions that can end up going to the host.
> > We could get a TLB miss that results in a heavyweight MMIO exit, etc.
> >
> > > And shouldn't we handle kvmppc_restart_interrupt() like the original
> > > HOST flow?
> > >
> > > #define MASKABLE_EXCEPTION(trapnum, intnum, label, hdlr,
> > > ack)           \
> > >
> > > START_EXCEPTION(label);                                         \
> > >         NORMAL_EXCEPTION_PROLOG(trapnum, intnum,
> > > PROLOG_ADDITION_MASKABLE)\
> > >         EXCEPTION_COMMON(trapnum, PACA_EXGEN,
> > > *INTS_DISABLE*)             \
> > > 	...
> >
> > Could you elaborate on what you mean?
>=20
> I think Tiejun was saying that host has flags and replays only EE/DEC/DBE=
LL
> interrupts. There is special macro masked_interrupt_book3e in those excep=
tion
> handlers that sets paca->irq_happened.
>=20
> The list of replied interrupts is limited to asynchronous noncritical int=
errupts
> which can be masked by MSR[EE] (therefore no TLB miss). Now on KVM book3e=
 we
> don't want to put them in the irq_happened lazy state but rather to execu=
te them
> directly, so there is no reason for exception handling symmetry between h=
ost and
> guest.


Another Question:=20

The case is:=20

Case 1)
 -> Local_irq_disable()  will set soft_enabled =3D 0
 -> Now Externel interrupt happens, there we set PACA_IRQ_EE in irq_happene=
d, Also clears EE in SRR1 and rfi. So interrupts are hard disabled. No more=
 other interrupt gated by MSR.EE can happen. Looks like the idea here is to=
 not let a device keep on inserting interrupt till the interrupt condition =
on device is cleared, right?
 -> local_irq_enable() - This checks that irq_happened is set, and replays

Now the case 2)
Case 2)
-> Local_irq_disable()  will set soft_enabled =3D 0
 -> Now DEC interrupt happens. We set PACA_IRQ_DEC in irq_happened, But do =
not clear EE in SRR1 and rfi. So interrupts are not hard disabled.=20
 -> Now say EE interrupt happens, there we set PACA_IRQ_EE in irq_happened,=
 Also clears EE in SRR1 and rfi. So interrupts are hard disabled.=20
 -> local_irq_enable() - This checks that irq_happened is set.
IIUC, it replays only one interrupt? is not it?

-Bharat
