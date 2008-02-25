Return-Path: <phdm@macqel.be>
Received: from mail.macqel.be (mail.macqel.be [194.78.208.39])
	by ozlabs.org (Postfix) with ESMTP id 966F0DDDEB
	for <linuxppc-dev@ozlabs.org>; Tue, 26 Feb 2008 01:47:25 +1100 (EST)
Date: Mon, 25 Feb 2008 15:47:22 +0100
From: Philippe De Muyter <phdm@macqel.be>
To: linuxppc-dev@ozlabs.org
Subject: E500 linux : are the 64-bit GPRs context-switched ?
Message-ID: <20080225144722.GA5011@ingate.macqel>
References: <20080221123534.GA17716@ingate.macqel>
	<20080222095022.GA635@ingate.macqel>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20080222095022.GA635@ingate.macqel>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Dear ppclinux gurus,

I have just compiled linux-2.6.24 for a MPC8540 target using a MPC8540
specific gcc.

After my first attempt using ARCH=ppc, leading to an infinity of messages :
"SPE used in kernel", I recompiled the whole kernel sources using
the default ARCH (ARCH=powerpc).  I now have a kernel that does not complain
about "SPE used in kernel", but user processes still crash ramdomly.

Searching around, I learned that the E500 GPR registers are 64-bits wide,
and gcc targetted for powerpc-linuxspe uses them sometimes.  In the other
PPC32 targets, those registers are 32-bits wide.

The specific E500 64-bit move instructions are `evstdd' and `evldd'.
I searched in the linux kernel sources (2.6.24) but did not find where
those GPR registers could be saved in 64-bit mode for context-switch.

Is there a patch pending somewhere to preserve the E500 GPR's in 64-bit mode
for context-switch ?

Philippe
