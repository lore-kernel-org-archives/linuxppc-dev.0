Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id B40E02BDB3
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  1 Oct 2004 09:35:59 +1000 (EST)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: jonathan@jonmasters.org
In-Reply-To: <35fb2e59040930160254f00fce@mail.gmail.com>
References: <35fb2e59040930160254f00fce@mail.gmail.com>
Content-Type: text/plain
Message-Id: <1096586504.3124.20.camel@gaston>
Mime-Version: 1.0
Date: Fri, 01 Oct 2004 09:21:50 +1000
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: bi_recs
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Fri, 2004-10-01 at 09:02, Jon Masters wrote:
> Hi all,
> 
> Would someone (Tom, Matt, Cort, Paul or Dan?) please tell me what the
> status is of bi_recs?
> 
> I first discussed the idea of this at the FOSDEM and not much has come
> of it - but I would be happy to work on getting flexible system
> configuration to the kernel on ppc without OF as this will then allow
> a stock kernel without any need for builtin notions of memory layout.
> Am I missing something that's already been implemented?

bi_recs were supposed to evolve in that direction but that never happened.

On the other hand, on ppc64, I took a different approach and decided that
an OF tree would be mandatory, but you don't need OF to have one.

I rewrote prom_init (the interface to OF) so that instead of tapping kenrel
globals directly and generating struct device_node, it generates a flattened
version of the device-tree and passes that to the kernel. That means that
if you can provide a "blob" with such a tree in it, you can bypass prom_init.

The tree doesn't need to be complete (like it doesn't need to contain all
the PCI devices) and generating such a flattened tree from userland, from
a text file for example, should be easy, or generate one from whatever
infos your bootloader provides.

But on the other hand, I've given up a long time ago trying to enforce any
kind of sane model on ppc32 because the embedded folks only care about having
a quick ugly broken hack to work with their board, thus the explosion of
various incompatible boot_info structures that we have nowadays.

Ben.
