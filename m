Return-Path: <dan@embeddededge.com>
Received: from penguin.netx4.com (embeddededge.com [209.113.146.155])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 38CA967BBC
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  1 Jul 2005 03:49:30 +1000 (EST)
In-Reply-To: <20050629171906.GD4262@logos.cnet>
References: <20050625145318.GA32117@logos.cnet>
	<f14f5f5aebd45879c39c6ce69f29c004@embeddededge.com>
	<20050626143004.GA5198@logos.cnet>
	<20050627133930.GA9109@logos.cnet>
	<f5d1cb54913dd31385d15fe1f2e5b12d@embeddededge.com>
	<1119940208.5133.204.camel@gaston>
	<3e7207cd8e98080f2f469a668e37a20f@embeddededge.com>
	<20050629171906.GD4262@logos.cnet>
Mime-Version: 1.0 (Apple Message framework v622)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <dfea8d3dcdd8ed3d89ec2445e39bfe88@embeddededge.com>
From: Dan Malek <dan@embeddededge.com>
Date: Thu, 30 Jun 2005 13:49:19 -0400
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: linux-ppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: Re: [PATCH] 8xx: map_page() skip pinned region and tlbie debugging
	aid
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


On Jun 29, 2005, at 1:19 PM, Marcelo Tosatti wrote:

> What do you mean "everyone should use ioremap() to map them"?

All software needs to invoke some kind of mapping function such
as ioremap() in the case of drivers or functions that access 
peripherals.
You should not assume someone has done the mapping for you,
as we did in the past for some optimizations.

> Once the physical->virtual mapping for device IO space are set
> with io_block_mapping() (or with ioremap() for dynamic virtual
> addresses), why would you want to ioremap() the physical address
> again???

You shouldn't know that io_block_mapping() has done anything
for you.  It is intended to be used as an optimization, not as a
replacement for ioremap().  The ioremap() function needs to be smart
enough to detect these optimizations and return efficient mappings
if that was done.  If a platform decides to not use these optimizations
(which is sometimes beneficial for debugging), your software using
ioremap() should still work just fine.

> PS: I've had a quick try at converting the IMMAP to use
> ioremap instead (and have that dynamic virtual address stored
> in a pointer), changed drivers to use that pointer instead of
> hardcoded "IMMAP". Didnt work immediately :) Its not that the
> idea?

Yes, and we have done lots of this in the 82xx/83xx/85xx cpm2
drivers in 2.6.  In fact, in 2.6 it has to be done.

Thanks.

	-- Dan
