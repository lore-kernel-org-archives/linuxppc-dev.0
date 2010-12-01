Return-Path: <B07421@freescale.com>
Received: from DB3EHSOBE002.bigfish.com (db3ehsobe002.messaging.microsoft.com
	[213.199.154.140])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Cybertrust SureServer Standard Validation CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 0B729B70CC
	for <linuxppc-dev@ozlabs.org>; Thu,  2 Dec 2010 08:16:40 +1100 (EST)
Received: from mail3-db3 (localhost.localdomain [127.0.0.1])	by
	mail3-db3-R.bigfish.com (Postfix) with ESMTP id 7691E29074C	for
	<linuxppc-dev@ozlabs.org>; Wed,  1 Dec 2010 21:16:36 +0000 (UTC)
Received: from DB3EHSMHS010.bigfish.com (unknown [10.3.81.253])	by
	mail3-db3.bigfish.com (Postfix) with ESMTP id 3BB0218A804C	for
	<linuxppc-dev@ozlabs.org>; Wed,  1 Dec 2010 21:16:22 +0000 (UTC)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw01.freescale.net (8.14.3/8.14.3) with ESMTP id
	oB1LIEMv008981	for
	<linuxppc-dev@ozlabs.org>; Wed, 1 Dec 2010 14:18:14 -0700 (MST)
Received: from az33exm25.fsl.freescale.net (az33exm25.am.freescale.net
	[10.64.32.16])	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id
	oB1LX4KN003559	for <linuxppc-dev@ozlabs.org>;
	Wed, 1 Dec 2010 15:33:04 -0600 (CST)
Date: Wed, 1 Dec 2010 15:16:12 -0600
From: Scott Wood <scottwood@freescale.com>
To: David Laight <David.Laight@ACULAB.COM>
Subject: Re: [MPC52xx]Latency issue with DMA on FEC
Message-ID: <20101201151612.3ce3f06e@udp111988uds.am.freescale.net>
In-Reply-To: <AE90C24D6B3A694183C094C60CF0A2F6D8ABDB@saturn3.aculab.com>
References: <1291215130.4881.55.camel@gandalf.stny.rr.com>
	<AE90C24D6B3A694183C094C60CF0A2F6D8ABDB@saturn3.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>,
	Eric Dumazet <eric.dumazet@gmail.com>,
	Jean-Michel Hautbois <jhautbois@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>, linux-rt-users@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 1 Dec 2010 15:09:54 +0000
David Laight <David.Laight@ACULAB.COM> wrote:

> The in_le32() not only contains the unwanted 'sync', but also
> a 'twi' (trap immediate - NFI exactly what this does) and 'isync'.

It turns a data dependency into a flow dependency.  It's basically equivalent to:

lwz	rX, ...
cmpw	rX, rX
bne	1f
1: isync

> The 'isync' is particularly horrid and unnecessary (aborts
> the instruction queue and refeches the opcode bytes)

The isync makes sure that the twi has completed before proceeding.

Note that the guarded, cache-inhibited load itself can be pretty
painful -- the core can't restart it, so it must complete before you
can take an interrupt.

> The very slow in_le32() might be there to give semi-synchronous
> traps on address fault - but unless the hardware is being probed
> that really isn't necessary.

There are times when you really want to be sure that the I/O is
finished before proceeding with something that isn't a load/store and
thus can't be serialized with normal barriers.

E.g. you're about to execute instructions in a physical address window
that you just set up (or even just create a non-guarded mapping to it
-- could get speculative accesses any time), or you just masked an
interrupt at the PIC (with a readback to flush) and are about to enable
MSR[EE].

Most of the time, though, it's overkill.  It should probably be an
alternate accessor form, or maybe a wait_for_io() wrapper -- if it can
be shown to make a real performance difference.

-Scott
