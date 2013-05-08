Return-Path: <B02008@freescale.com>
Received: from va3outboundpool.messaging.microsoft.com
 (va3ehsobe006.messaging.microsoft.com [216.32.180.16])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 813B72C0114
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  8 May 2013 23:14:19 +1000 (EST)
From: Caraman Mihai Claudiu-B02008 <B02008@freescale.com>
To: Wood Scott-B07421 <B07421@freescale.com>, tiejun.chen
 <tiejun.chen@windriver.com>
Subject: RE: [RFC][KVM][PATCH 1/1] kvm:ppc:booke-64: soft-disable interrupts
Date: Wed, 8 May 2013 13:14:11 +0000
Message-ID: <300B73AA675FCE4A93EB4FC1D42459FF3F00D0@039-SN2MPN1-013.039d.mgd.msft.net>
References: <51885F49.6060605@windriver.com> (from tiejun.chen@windriver.com
 on Mon May  6 20:56:25 2013) <1367892390.3398.12@snotra>
In-Reply-To: <1367892390.3398.12@snotra>
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

> > This only disable soft interrupt for kvmppc_restart_interrupt() that
> > restarts interrupts if they were meant for the host:
> >
> > a. SOFT_DISABLE_INTS() only for BOOKE_INTERRUPT_EXTERNAL |
> > BOOKE_INTERRUPT_DECREMENTER | BOOKE_INTERRUPT_DOORBELL
>=20
> Those aren't the only exceptions that can end up going to the host.  We
> could get a TLB miss that results in a heavyweight MMIO exit, etc.
>
> > And shouldn't we handle kvmppc_restart_interrupt() like the original
> > HOST flow?
> >
> > #define MASKABLE_EXCEPTION(trapnum, intnum, label, hdlr,
> > ack)           \
> >
> > START_EXCEPTION(label);                                         \
> >         NORMAL_EXCEPTION_PROLOG(trapnum, intnum,
> > PROLOG_ADDITION_MASKABLE)\
> >         EXCEPTION_COMMON(trapnum, PACA_EXGEN,
> > *INTS_DISABLE*)             \
> > 	...
>=20
> Could you elaborate on what you mean?

I think Tiejun was saying that host has flags and replays only EE/DEC/DBELL
interrupts. There is special macro masked_interrupt_book3e in those excepti=
on
handlers that sets paca->irq_happened.

The list of replied interrupts is limited to asynchronous noncritical
interrupts which can be masked by MSR[EE] (therefore no TLB miss). Now
on KVM book3e we don't want to put them in the irq_happened lazy state
but rather to execute them directly, so there is no reason for exception
handling symmetry between host and guest.

-Mike
