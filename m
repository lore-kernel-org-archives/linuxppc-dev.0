Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 5864ADE1B0
	for <linuxppc-dev@ozlabs.org>; Wed, 15 Oct 2008 22:49:59 +1100 (EST)
Subject: Re: [PROBLEM] Soft lockup on Linux 2.6.27, 2 patches, Cell/PPC64
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
In-Reply-To: <Pine.LNX.4.64.0810151343480.1133@vixen.sonytel.be>
References: <48F17DE6.106@gmail.com>
	<Pine.LNX.4.64.0810130945260.17287@vixen.sonytel.be>
	<Pine.LNX.4.64.0810141130340.16020@vixen.sonytel.be>
	<1224046194.8157.428.camel@pasglop>
	<Pine.LNX.4.64.0810151050330.1133@vixen.sonytel.be>
	<1224062907.8157.446.camel@pasglop>
	<Pine.LNX.4.64.0810151135330.1133@vixen.sonytel.be>
	<1224070653.8157.452.camel@pasglop>
	<Pine.LNX.4.64.0810151343480.1133@vixen.sonytel.be>
Content-Type: text/plain
Date: Wed, 15 Oct 2008 22:49:52 +1100
Message-Id: <1224071392.8157.455.camel@pasglop>
Mime-Version: 1.0
Cc: Linux/PPC Development <linuxppc-dev@ozlabs.org>,
	Aaron Tokhy <atokhy@gmail.com>
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 2008-10-15 at 13:46 +0200, Geert Uytterhoeven wrote:
> On Wed, 15 Oct 2008, Benjamin Herrenschmidt wrote:
> > > > Well, at the time of the sample, the other CPU indeed -seems- to be in
> > > > an IRQ disabled section yes. 
> > > 
> > > This is not really a sample. The hardirqs enable/disable is actually tracked
> > > using the TRACE_{EN,DIS}ABLE_INTS macros.
> > 
> > That's what I meant. IE. the hardirq state was updated by the stuck CPU
> > but sampled by the non-stuck one. ie. the non-stuck one could have
> > sampled a transcient value where it happened to have hard irq
> > disabled...
> 
> These states are per_cpu.

I know, but that doesn't prevent another CPU from peeking at them :-)
The question is, was the message printed by the CPU that locked up or by
the other one that detected the lockup ?

> They do call TRACE_DISABLE_INTS, which records the interrupt being disabled.
> So this makes the actual state recording useless...

Well, they record that when they disable it. They don't enable it. Can
you find a spot where the IRQ is enabled and it's not recorded or a case
where it's not disabled and recorded as disabled ?

Cheers,
Ben.
