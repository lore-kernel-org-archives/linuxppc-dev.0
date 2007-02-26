Return-Path: <torvalds@linux-foundation.org>
Received: from smtp.osdl.org (smtp.osdl.org [65.172.181.24])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "smtp.osdl.org", Issuer "OSDL Hostmaster" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 3B66ADDEC1
	for <linuxppc-dev@ozlabs.org>; Tue, 27 Feb 2007 08:17:47 +1100 (EST)
Date: Mon, 26 Feb 2007 13:17:45 -0800 (PST)
From: Linus Torvalds <torvalds@linux-foundation.org>
To: David Woodhouse <dwmw2@infradead.org>
Subject: Re: Make sure we populate the initroot filesystem late enough
In-Reply-To: <1172523468.3560.2.camel@shinybook.infradead.org>
Message-ID: <Pine.LNX.4.64.0702261315080.12485@woody.linux-foundation.org>
References: <1172462466.3971.46.camel@shinybook.infradead.org>
	<35684e789e5c2447eab393c8946efcb9@bga.com>
	<1172523468.3560.2.camel@shinybook.infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, LKML <linux-kernel@vger.kernel.org>,
	Milton Miller <miltonm@bga.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>



On Mon, 26 Feb 2007, David Woodhouse wrote:
> 
> Now I'm starting to wonder if it's something the firmware sets up to DMA
> to a certain region of memory, which makes it non-deterministic. And the
> other things we're blaming are only making a difference because they
> change the layout of what we have in memory.

USB controller issues? We used to have these really hard-to-debug problems 
with the USB controller being active and having had the BIOS set up the 
command queues etc. Really subtle. It's why we now have PCI quirks for 
shutting up (most) USB controllers very early.

If there is some USB controller that we miss, or that sets up its command 
chain to some unexpected area (so that USB is active and corrupting memory 
even very early on), that could explain it.

		Linus
