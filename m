Return-Path: <marcelo.tosatti@cyclades.com>
Received: from parcelfarce.linux.theplanet.co.uk
	(parcelfarce.linux.theplanet.co.uk [195.92.249.252])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id BE69F67B91
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 30 Jun 2005 08:04:40 +1000 (EST)
Date: Wed, 29 Jun 2005 14:19:06 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Dan Malek <dan@embeddededge.com>
Message-ID: <20050629171906.GD4262@logos.cnet>
References: <20050625145318.GA32117@logos.cnet>
	<f14f5f5aebd45879c39c6ce69f29c004@embeddededge.com>
	<20050626143004.GA5198@logos.cnet>
	<20050627133930.GA9109@logos.cnet>
	<f5d1cb54913dd31385d15fe1f2e5b12d@embeddededge.com>
	<1119940208.5133.204.camel@gaston>
	<3e7207cd8e98080f2f469a668e37a20f@embeddededge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3e7207cd8e98080f2f469a668e37a20f@embeddededge.com>
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

On Tue, Jun 28, 2005 at 09:53:26AM -0400, Dan Malek wrote:
> 
> On Jun 28, 2005, at 2:30 AM, Benjamin Herrenschmidt wrote:
> 
> >You should consider 8Mb pages the way we do BATs yes,
> 
> It's always been considered, just never fully implemented :-)
> 
> >Note that I'll soon send the patch I told you about that makes the
> >virtual address picked by io_block_mapping() dynamic, so we no longer
> >have to do crappy assumptions all over the place :)
> 
> Whatever, I'll never use it that way and no one else should either.

Why not? AFAICS the idea is to have the virtual mappings dynamic 
and not static - this is the _whole_ point of ioremap() instead
of io_block_mapping(), isnt it?

I fail to see any practical arguments against it...

> All of the io_block_mapping() calls should be used to set these 8M
> mapped IO spaces, everyone should use ioremap() to map them,
> and ioremap() has to be modified to find them for the 8xx.

What do you mean "everyone should use ioremap() to map them"? 

Once the physical->virtual mapping for device IO space are set
with io_block_mapping() (or with ioremap() for dynamic virtual 
addresses), why would you want to ioremap() the physical address
again??? 

PS: I've had a quick try at converting the IMMAP to use
ioremap instead (and have that dynamic virtual address stored
in a pointer), changed drivers to use that pointer instead of 
hardcoded "IMMAP". Didnt work immediately :) Its not that the 
idea?
