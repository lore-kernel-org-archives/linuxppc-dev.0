Return-Path: <trini@kernel.crashing.org>
Received: from fed1rmmtao01.cox.net (fed1rmmtao01.cox.net [68.230.241.38])
	by ozlabs.org (Postfix) with ESMTP id 3A9B2686B8
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  9 Nov 2005 04:56:59 +1100 (EST)
Date: Tue, 8 Nov 2005 10:56:58 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: David Jander <david.jander@protonic.nl>
Message-ID: <20051108175658.GO3839@smtp.west.cox.net>
References: <20051107151011.GA17161@logos.cnet>
	<b4fb08107c7bd17161f36e023035080a@embeddedalley.com>
	<200511081259.26525.david.jander@protonic.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200511081259.26525.david.jander@protonic.nl>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: fix swapping on 8xx?
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Tue, Nov 08, 2005 at 01:59:26PM +0200, David Jander wrote:
> On Tuesday 08 November 2005 01:55, Dan Malek wrote:
> > On Nov 7, 2005, at 10:10 AM, Marcelo Tosatti wrote:
> > > The following is an attempt to fix swapping on 8xx by not touching
> > > _PAGE_ACCESSED bit if the page is not present.
> >
> > Ugh ....  I suppose.  I hate assembler code macros .......
> > Somehow, "swapping" and "8xx" just don't belong together.
> 
> Well, at least it sounds ugly together, but it is also at least conceiveable. 
> There seem to be people who use PCMCIA for an IDE interface, so swapping may 
> become desireable in some cases.

I think Dan might be in the camp that says a properly designed embedded
system won't need to swap.  And when I hear about how people do try and
swap on systems like this, I really start agreeing.  Maybe we could make
8xx just select SWAP=n? :)

> > I'm tempted to add a configuration option that is the complete
> > opposite of this and assumes are really embedded system.
> > Mark pages as always accessed, data pages as always dirty,
> > and you can eliminate lots of TLB faults in systems that are
> > fairly static.
> 
> It sounds tempting indeed, but should you really notice a performance increase 
> out of this?

Compared to 8xx in 2.6 today?  Absolutely.

-- 
Tom Rini
http://gate.crashing.org/~trini/
