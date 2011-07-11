Return-Path: <dargaud@lpsc.in2p3.fr>
Received: from lpsc-mail.in2p3.fr (lpsc-mail.in2p3.fr [134.158.40.8])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id B3DB1B6F7C
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 12 Jul 2011 00:38:24 +1000 (EST)
Received: from lpsc0174x.localnet (lpsc0174x.in2p3.fr [134.158.40.174])
	by lpsc-mail.in2p3.fr (8.13.1/8.13.1/In2p3) with ESMTP id
	p6BEcJ4G013462
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Jul 2011 16:38:19 +0200
From: Guillaume Dargaud <dargaud@lpsc.in2p3.fr>
To: linuxppc-dev@lists.ozlabs.org
Subject: Re: Analysing a kernel panic
Date: Mon, 11 Jul 2011 16:38:18 +0200
References: <201107051619.50548.dargaud@lpsc.in2p3.fr>
	<201107080926.47588.dargaud@lpsc.in2p3.fr>
	<1310253395.8267.7.camel@pasglop>
In-Reply-To: <1310253395.8267.7.camel@pasglop>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Message-Id: <201107111638.18950.dargaud@lpsc.in2p3.fr>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> Ok, I'm not familiar with that PIC. You need to check what's going on
> between the PIC, your interrupt source and the kernel.
> 
> Normally, if it's an edge interrupt,  it's a single event that gets
> latched by the PIC. The kernel will then call ack() on that PIC driver
> (irq_chip) which should clear that latch -before- getting into your
> device driver for processing.
> 
> Also, the interrupt shall either be masked while processing or if it
> re-enters, the PIC code shall try to mask it (lazy masking) until the
> original handler completes at which point it gets unmasked. That shall
> be handled by the standard flow handlers, so it really depends on how
> you hookup your PIC in SW.

This should be all this:

static int xad_driver_probe(struct of_device* dev, const struct of_device_id *match) {
	struct device_node *dn = dev->node;
	Xad.irq = irq_of_parse_and_map(dn, 0);
	rc=request_irq(Xad.irq, XadIsr, IRQF_TRIGGER_RISING  | IRQF_DISABLED | IRQF_SHARED /*| IRQF_SAMPLE_RANDOM*/, 
"XadIsr", &Xad);

IIRC IRQF_DISABLED is obsolete (I've tried without).


What mystifies me is that:
- my same code on slightly different hardware works perfectly (the differences are not relevant to the driver but to the 
user application).
- a simplified standalone code works (so, non-linux).

-- 
Guillaume Dargaud
http://www.gdargaud.net/
