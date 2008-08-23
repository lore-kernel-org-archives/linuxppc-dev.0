Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id B85BBDDEEB
	for <linuxppc-dev@ozlabs.org>; Sun, 24 Aug 2008 08:52:59 +1000 (EST)
Subject: Re: Random crashes with 2.6.27-rc3 on PPC
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Michael Buesch <mb@bu3sch.de>
In-Reply-To: <200808231610.46473.mb@bu3sch.de>
References: <200808231610.46473.mb@bu3sch.de>
Content-Type: text/plain
Date: Sun, 24 Aug 2008 08:52:49 +1000
Message-Id: <1219531969.21386.205.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, linux-kernel <linux-kernel@vger.kernel.org>
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat, 2008-08-23 at 16:10 +0200, Michael Buesch wrote:
> I am seeing random kernel and userland application
> crashes on a Powerbook running a 2.6.27-rc3 based kernel (wireless-testing.git).
> 
> The crashes did recently appear. It might be the case that they were
> introduced with the merge of 2.6.27-rc1 into wireless-testing.
> I'm not sure on that one, however. Just a guess. I still need to
> do more testing (also on vanilla upstream kernels).
> 
> The crashes are completely random and they look like bad hardware.
> However I cannot reproduce on 2.6.25.9 (That's a kernel I still had
> installed, so I tried that one). So it most likely is _not_ caused
> by faulty hardware.
> 
> The crashes are hard to reproduce, and happen about every 20 minutes
> when compiling a kernel tree. (gcc segfaults). Sometimes the kernel
> oopses in random places with pointer dereference faults.
> 
> Is this a known issue?
> I'm going to bisect this one, but it will take a lot of time, as reproducing
> takes about 20 minutes. So that's about an hour for one test round.
> 
> The kernel configuration is the following:

Random guess:

CONFIG_FRAME_POINTER=y
CONFIG_SCHED_NO_NO_OMIT_FRAME_POINTER=y

Note sure what those together do, check if you have any file compiled
with -fno-omit-frame-pointer and if you do, try to change things so
that you don't ... we found some miscompiles when that is set, exposed
by FTRACE typically (which you don't have enabled) but possibly by other
things.

Ben.
