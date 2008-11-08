Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 49BC4DDDFB
	for <linuxppc-dev@ozlabs.org>; Sun,  9 Nov 2008 09:17:48 +1100 (EST)
Subject: Re: [PATCH 1/1] irq: Maintain user set affinity
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Yinghai Lu <yinghai@kernel.org>
In-Reply-To: <86802c440811081412u6d54beaam143801ce83225f40@mail.gmail.com>
References: <Pine.LNX.4.64.0811041030520.25054@blarg.am.freescale.net>
	<86802c440811081412u6d54beaam143801ce83225f40@mail.gmail.com>
Content-Type: text/plain
Date: Sun, 09 Nov 2008 09:17:24 +1100
Message-Id: <1226182645.13603.90.camel@pasglop>
Mime-Version: 1.0
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org, Linus Torvalds <torvalds@osdl.org>,
	tglx@linutronix.de
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat, 2008-11-08 at 14:12 -0800, Yinghai Lu wrote:
> On Tue, Nov 4, 2008 at 8:31 AM, Kumar Gala <galak@kernel.crashing.org> wrote:
> > From 819ad3ed4660f4238e053728a8b5aa93d22b13d7 Mon Sep 17 00:00:00 2001
> > From: Kumar Gala <galak@kernel.crashing.org>
> > Date: Tue, 4 Nov 2008 10:13:53 -0600
> > Subject: [PATCH 1/1] irq: Maintain user set affinity
> >
> > This addresses a regression in that if a user specified an affinity
> > for an interrupt that affinity information would get reset between
> > a request_irq(), free_irq() and request_irq() for the same irq.
> >
> > On example of this is bringing up an ethernet interface, taking
> > it down and bringing it back up again.
> >
> > Instead of always using the irq_default_affinity we use the
> > previous setting of the IRQs affinity with the assumption that
> > at boot the IRQs affinity will be set to irq_default_affinity.
> 
> why ?, the default_affinity is expected behavior...
> 
> for example: when MSI is used, second driver could get same irq if
> first driver is unloaded.

The default affinity should be set when the irq is allocated / assigned
to a device, not when it's requested.

Ben.
