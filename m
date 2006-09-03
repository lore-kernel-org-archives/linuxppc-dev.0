Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 1381F67BF4
	for <linuxppc-dev@ozlabs.org>; Mon,  4 Sep 2006 07:55:01 +1000 (EST)
Subject: Re: Please pull powerpc.git 'merge' branch
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0609031432430.27779@g5.osdl.org>
References: <17654.26321.851991.285528@cargo.ozlabs.ibm.com>
	<Pine.LNX.4.64.0609031213310.27779@g5.osdl.org>
	<1157318122.32334.8.camel@localhost.localdomain>
	<Pine.LNX.4.64.0609031432430.27779@g5.osdl.org>
Content-Type: text/plain
Date: Mon, 04 Sep 2006 07:54:20 +1000
Message-Id: <1157320461.32334.18.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sun, 2006-09-03 at 14:33 -0700, Linus Torvalds wrote:
> 
> On Mon, 4 Sep 2006, Benjamin Herrenschmidt wrote:
> > 
> > I'll send a fix later today. I don't think the read32 is used that much
> > in practice, but yeah, that could have cause subtle issues on some
> > machine....
> 
> Well, it's not only read32 that is broken. read8 will obviously be NULL, 
> which may or may not mean that it is ever actually used.
> 
> Not knowing how this actually all ties together with users means that I 
> didn't just want to check in the obvious fix..

Those things are used to "interpret" kind of blobs provided by the
firmware that muck around various magic IOs and control bits in Apple
ASIC. The "read" variants are rarely used (except for GPIOs but it's a
different set of primitives), except in a few cases where those blobs
are doing read, then and/or a bit, then write back. Is difficult to tell
precisely on what machine and in what circumstances though the firmware
will have used those and thus in which case we have a subtle breakage or
on the contrary subtely hiding a problem... I would fix them for 2.6.18
anyway.

Ben.
