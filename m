Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 2D4F3DDFC0
	for <linuxppc-dev@ozlabs.org>; Fri,  8 Aug 2008 08:15:31 +1000 (EST)
Subject: Re: [RFC/PATCH 1/3] powerpc: add ioremap_bat() function for
	setting up BAT translated IO regions.
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Grant Likely <grant.likely@secretlab.ca>
In-Reply-To: <fa686aa40808061611p616208bp2baf9a0d5e095870@mail.gmail.com>
References: <20080806055214.30717.86092.stgit@trillian.secretlab.ca>
	<20080806060223.30717.35175.stgit@trillian.secretlab.ca>
	<1218061585.24157.246.camel@pasglop>
	<fa686aa40808061611p616208bp2baf9a0d5e095870@mail.gmail.com>
Content-Type: text/plain
Date: Fri, 08 Aug 2008 08:09:11 +1000
Message-Id: <1218146951.24157.305.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org, miltonm@bga.com
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 2008-08-06 at 17:11 -0600, Grant Likely wrote:
> I'm not sure what you're asking.  Are you asking about this particular
> test, or are you asking why I don't also test the size?

Badly worded. 

I meant BAT sizes are masks of bits. IE, they are power of 2 and the
BAT address must be aligned to that power of 2 (ie, the BAT matching
uses the size as a bit mask of relevant bits to compare).

Unless I misread, your code doesn't provide the necessary tests/rounding
of size and alignment of the virtual address.. does it ?
 
> I do this particular test to make absolute sure that the caller
> absolutely understands the limitations of the block mapping.  If they
> call this with something that isn't 128k aligned, then I make it fail
> immediately so the coder is forced to go and understand what they are
> allowed to do.  Basically, I'm reinforcing the fact that this is not
> the same as ioremap().
> 
> I haven't decided yet if I should test size in the same way.
> Thoughts?

Ben.
