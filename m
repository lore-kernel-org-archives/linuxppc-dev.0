Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 6CC28DDEB8
	for <linuxppc-dev@ozlabs.org>; Tue, 27 Feb 2007 17:48:44 +1100 (EST)
Subject: Re: Make sure we populate the initroot filesystem late enough
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
In-Reply-To: <Pine.LNX.4.64.0702261315080.12485@woody.linux-foundation.org>
References: <1172462466.3971.46.camel@shinybook.infradead.org>
	<35684e789e5c2447eab393c8946efcb9@bga.com>
	<1172523468.3560.2.camel@shinybook.infradead.org>
	<Pine.LNX.4.64.0702261315080.12485@woody.linux-foundation.org>
Content-Type: text/plain
Date: Tue, 27 Feb 2007 07:46:39 +0100
Message-Id: <1172558799.11949.41.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, David Woodhouse <dwmw2@infradead.org>,
	LKML <linux-kernel@vger.kernel.org>, Milton Miller <miltonm@bga.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> USB controller issues? We used to have these really hard-to-debug problems 
> with the USB controller being active and having had the BIOS set up the 
> command queues etc. Really subtle. It's why we now have PCI quirks for 
> shutting up (most) USB controllers very early.

On powermacs or powerbooks, the USB controller is shut down by the
firmware when we call the "quiesce" OF call from prom_init.c, which
happens before the kernel relocates itself to 0 and takes over memory.
Unless we fucked up something in there, I wouldn't expect that to be the
cause.
 
> If there is some USB controller that we miss, or that sets up its command 
> chain to some unexpected area (so that USB is active and corrupting memory 
> even very early on), that could explain it.

Did we setup the OHCI controller when the crash happen ? Maybe we broke
something subtle in the USB stack ?

Ben.
