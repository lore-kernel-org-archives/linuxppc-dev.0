Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id A599EDDE0D
	for <linuxppc-dev@ozlabs.org>; Wed, 15 Oct 2008 15:50:02 +1100 (EST)
Subject: Re: [PROBLEM] Soft lockup on Linux 2.6.27, 2 patches, Cell/PPC64
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
In-Reply-To: <Pine.LNX.4.64.0810141130340.16020@vixen.sonytel.be>
References: <48F17DE6.106@gmail.com>
	<Pine.LNX.4.64.0810130945260.17287@vixen.sonytel.be>
	<Pine.LNX.4.64.0810141130340.16020@vixen.sonytel.be>
Content-Type: text/plain
Date: Wed, 15 Oct 2008 15:49:54 +1100
Message-Id: <1224046194.8157.428.camel@pasglop>
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

On Tue, 2008-10-14 at 11:32 +0200, Geert Uytterhoeven wrote:

> 
> which points again to smp_call_function_single...

Yup, it doesn't bring more information. At this stage, your 'other' CPU
is stuck with interrupts disabled. Hard to tell what's happening without
some HW assist. Do you have ways to trigger a non-maskable interrupt
such as a 0x100 ? That would allow to catch the other guy in xmon and
see what it was doing...

It could be something in the ps3vram driver causing the kernel to
lockup.... Now the question is whether the kernel is stuffed with
something like a deadlock with interrupts off, or is it a HW problem
causing a CPU to lockup on an access to the vram ?

I'm afraid only you guys have tools that would allow to debug that
sort of problem.

Cheers,
Ben.
