Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 0E22B67BDE
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  1 Jul 2005 09:35:37 +1000 (EST)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Dan Malek <dan@embeddededge.com>
In-Reply-To: <f39d04caf822fc8e66fa3bb25606f08f@embeddededge.com>
References: <20050625145318.GA32117@logos.cnet>
	<f14f5f5aebd45879c39c6ce69f29c004@embeddededge.com>
	<20050626143004.GA5198@logos.cnet> <20050627133930.GA9109@logos.cnet>
	<f5d1cb54913dd31385d15fe1f2e5b12d@embeddededge.com>
	<1119940208.5133.204.camel@gaston>
	<3e7207cd8e98080f2f469a668e37a20f@embeddededge.com>
	<20050629171906.GD4262@logos.cnet> <1120087888.31924.19.camel@gaston>
	<f39d04caf822fc8e66fa3bb25606f08f@embeddededge.com>
Content-Type: text/plain
Date: Fri, 01 Jul 2005 09:29:29 +1000
Message-Id: <1120174169.31924.55.camel@gaston>
Mime-Version: 1.0
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

On Thu, 2005-06-30 at 14:05 -0400, Dan Malek wrote:
> On Jun 29, 2005, at 7:31 PM, Benjamin Herrenschmidt wrote:
> 
> >  - The debate between Dan and me here is about the semantics of
> > io_block_mapping().
> 
> My point of discussion is this function needs to be much smarter than
> simply allocating a virtual address space.  We need to track the calls
> so that we can "grow" previous spaces.  A single io_block_mapping()
> should not always allocate a new BAT, CAM or otherwise wired entry.
> It has to know the alignment, size and amount of resource available.
> For example, if an io_block_mapping() requests a 4M space, and it
> isn't possible to wire such a size, we still need to keep track of that
> such that a subsequent 4M request is combined into a space that
> can be wired with an 8M entry.  We need to make it smart enough
> to coalesce the spaces to maximize the use of the available and
> minimal mapping resources.  If io_block_mapping() is just a simple
> functions that decrements a pointer and sets a value in a register,
> then you have already required the caller to know everything about
> the mapping details, so why bother performing "hidden" arithmetic
> that is likely to be known by the caller?  If we are going to change 
> this

Everyting ... but the virtual address, which is quite a bit :) My
problem is really with virtual addresses beeing hard coded, which makes
things complicated every time we try to do something with the kenrel
virtual space. But ....

> let's make it tru
> y useful, so it understands the capabilities of the
> processor, optimizes the resources, and keeps generic mapping
> information so ioremap() doesn't care if it is mapped by BATs, CAMs,
> or large pages.

 ... I do agree that making it even smarter so it can coalesce block
mappings with the same attributes would be "interesting".

Ben.
