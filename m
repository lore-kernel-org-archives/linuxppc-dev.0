Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 3361D67B7A
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 30 Jun 2005 09:37:04 +1000 (EST)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
In-Reply-To: <20050629171906.GD4262@logos.cnet>
References: <20050625145318.GA32117@logos.cnet>
	<f14f5f5aebd45879c39c6ce69f29c004@embeddededge.com>
	<20050626143004.GA5198@logos.cnet> <20050627133930.GA9109@logos.cnet>
	<f5d1cb54913dd31385d15fe1f2e5b12d@embeddededge.com>
	<1119940208.5133.204.camel@gaston>
	<3e7207cd8e98080f2f469a668e37a20f@embeddededge.com>
	<20050629171906.GD4262@logos.cnet>
Content-Type: text/plain
Date: Thu, 30 Jun 2005 09:31:28 +1000
Message-Id: <1120087888.31924.19.camel@gaston>
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

On Wed, 2005-06-29 at 14:19 -0300, Marcelo Tosatti wrote:

> Once the physical->virtual mapping for device IO space are set
> with io_block_mapping() (or with ioremap() for dynamic virtual 
> addresses), why would you want to ioremap() the physical address
> again??? 
> 
> PS: I've had a quick try at converting the IMMAP to use
> ioremap instead (and have that dynamic virtual address stored
> in a pointer), changed drivers to use that pointer instead of 
> hardcoded "IMMAP". Didnt work immediately :) Its not that the 
> idea?

No, you are missing the point. The idea is:

 - Everything should use ioremap(), that is the proper interface for a
driver or whatever else to get a virtual address for a physical area.

 - The architecture may use io_block_mapping() to create large fixed
mappings (BATs, CAMs, 8M TLBs, ...) for some physical areas as an
optimisation. Those should be transparent to later code, that is you
shouldn't have to care about their existence when you are driver. You
just call ioremap. If that space was already part of a large fixed
mapping, then ioremap will just return an address within that range.

 - The debate between Dan and me here is about the semantics of
io_block_mapping(). Currently, it takes both the physical and virtual
address. Thus you hard-code your mappings at known virtual addresses. I
find this unnecessary and source of problems, and I want to add to
io_block_mapping() a way to "allocate" virtual addresses dynamically (by
simply moving down ioremap_bot like ioremap would do if called that
early). That way, there is no "magic" hard coded virtual addresses at
all anymore.

Ben.
