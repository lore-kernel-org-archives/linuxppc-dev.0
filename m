Return-Path: <marcelo.tosatti@cyclades.com>
Received: from parcelfarce.linux.theplanet.co.uk
	(parcelfarce.linux.theplanet.co.uk [195.92.249.252])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 438F267AC6
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 17 Jun 2005 07:55:49 +1000 (EST)
Date: Thu, 16 Jun 2005 13:47:17 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Dan Malek <dan@embeddededge.com>
Message-ID: <20050616164717.GA1915@logos.cnet>
References: <20050616144739.GA1559@logos.cnet>
	<8efaee2824f500e906c2c05526ea3214@embeddededge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <8efaee2824f500e906c2c05526ea3214@embeddededge.com>
Cc: linux-ppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: Re: map_page() and pinned TLB entries
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Thu, Jun 16, 2005 at 05:13:19PM -0400, Dan Malek wrote:
> 
> On Jun 16, 2005, at 10:47 AM, Marcelo Tosatti wrote:
> 
> >What would be an elegant way of dealing with this? We can insert
> >a conditional there such that only addresses not covered
> >by other mappings (in this case the 8Mbyte entry) get flushed.
> 
> I'd like to make _tlbie() a macro on 8xx that simply tests the VA
> and doesn't invalidate anything in the pinned space.  Of course,
> the code shouldn't be doing this anyway, and I think this
> should be treated as a bug if it happens. 

Well it is expected that mapin_ram() flushes the va for the 
PTE's being created.

That is the only well known occurence of _tlbie() on 
a possibly pinned region. 

I agree that adding a debugging check on _tlbie() to 
catch invalidations in pinned space is a good thing.

> If the Linux VM thinks it needs to be doing this, pinned space 
> isn't going to work. 

Well the VM does that now, but it can be changed to skip the
pinned region. 

>The _tlbie() is an exported symbol, I suspect for MOL, so
> we have to accommodate that.

What does MOL stand for? 

> Thanks.

There are two separate approaches:

a) Fix mapin_ram() to skip pinned regions
b) Fix _tlbie() to skip pinned regions and warn about such
misusage.

If b) is chosen alone, which is what you seem to suggest, we
will get tons of warnings (or traps) anyway from mapin_ram(). 

So having that said, isnt the correct way out of this to change
both a) and b)?
