Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id BAA3ADDDF3
	for <linuxppc-dev@ozlabs.org>; Wed, 15 Oct 2008 20:28:41 +1100 (EST)
Subject: Re: [PROBLEM] Soft lockup on Linux 2.6.27, 2 patches, Cell/PPC64
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
In-Reply-To: <Pine.LNX.4.64.0810151050330.1133@vixen.sonytel.be>
References: <48F17DE6.106@gmail.com>
	<Pine.LNX.4.64.0810130945260.17287@vixen.sonytel.be>
	<Pine.LNX.4.64.0810141130340.16020@vixen.sonytel.be>
	<1224046194.8157.428.camel@pasglop>
	<Pine.LNX.4.64.0810151050330.1133@vixen.sonytel.be>
Content-Type: text/plain
Date: Wed, 15 Oct 2008 20:28:27 +1100
Message-Id: <1224062907.8157.446.camel@pasglop>
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

On Wed, 2008-10-15 at 11:25 +0200, Geert Uytterhoeven wrote:
> On Wed, 15 Oct 2008, Benjamin Herrenschmidt wrote:
> > On Tue, 2008-10-14 at 11:32 +0200, Geert Uytterhoeven wrote:
> > > which points again to smp_call_function_single...
> > 
> > Yup, it doesn't bring more information. At this stage, your 'other' CPU
> > is stuck with interrupts disabled. Hard to tell what's happening without
> > some HW assist. Do you have ways to trigger a non-maskable interrupt
> > such as a 0x100 ? That would allow to catch the other guy in xmon and
> > see what it was doing...
> 
> Interrupts are not disabled on the other CPU thread, at least not according to
> the irqs_disabled() check I added to the printing of the `spinlock lockup'
> message in __spin_lock_debug().
> 
> As the log also said
> 
> | hardirqs last  enabled at (5018779): [<c000000000007c1c>] restore+0x1c/0xe4
> | hardirqs last disabled at (5018780): [<c000000000003600>] decrementer_common+0x100/0x180
> 
> I started blinking the LEDs on decrementer interupts, which do arrive on both
> CPU threads.

Hrm, ok I though the log shows the decrementer interrupt of the thread
that's still working. If you are confident they are both taking
interrupts, then there's indeed something to track down.

> However, I'm a bit puzzled by these `hardirqs last enabled/disabled' messages,
> as they do indicate interrupts are off...

Well, at the time of the sample, the other CPU indeed -seems- to be in
an IRQ disabled section yes. 

Cheers,
Ben.
