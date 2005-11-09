Return-Path: <marcelo.tosatti@cyclades.com>
Received: from hera.kernel.org (hera.kernel.org [140.211.167.34])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id BAD0A686D3
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 10 Nov 2005 04:25:40 +1100 (EST)
Date: Wed, 9 Nov 2005 09:21:34 -0200
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Tom Rini <trini@kernel.crashing.org>
Message-ID: <20051109112134.GA8588@logos.cnet>
References: <20051107151011.GA17161@logos.cnet>
	<b4fb08107c7bd17161f36e023035080a@embeddedalley.com>
	<200511081259.26525.david.jander@protonic.nl>
	<20051108175658.GO3839@smtp.west.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20051108175658.GO3839@smtp.west.cox.net>
Cc: David Jander <david.jander@protonic.nl>, linuxppc-embedded@ozlabs.org
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

On Tue, Nov 08, 2005 at 10:56:58AM -0700, Tom Rini wrote:
> On Tue, Nov 08, 2005 at 01:59:26PM +0200, David Jander wrote:
> > On Tuesday 08 November 2005 01:55, Dan Malek wrote:
> > > On Nov 7, 2005, at 10:10 AM, Marcelo Tosatti wrote:
> > > > The following is an attempt to fix swapping on 8xx by not touching
> > > > _PAGE_ACCESSED bit if the page is not present.
> > >
> > > Ugh ....  I suppose.  I hate assembler code macros .......
> > > Somehow, "swapping" and "8xx" just don't belong together.
> > 
> > Well, at least it sounds ugly together, but it is also at least conceiveable. 
> > There seem to be people who use PCMCIA for an IDE interface, so swapping may 
> > become desireable in some cases.
> 
> I think Dan might be in the camp that says a properly designed embedded
> system won't need to swap.  And when I hear about how people do try and
> swap on systems like this, I really start agreeing.  Maybe we could make
> 8xx just select SWAP=n? :)

TimeSys shipped their kernel with swapping fix as far as I know (Jason
plyed with it recently).

We'd better not assume what people try to do with their old 8xx's :)

> > > I'm tempted to add a configuration option that is the complete
> > > opposite of this and assumes are really embedded system.
> > > Mark pages as always accessed, data pages as always dirty,
> > > and you can eliminate lots of TLB faults in systems that are
> > > fairly static.
> > 
> > It sounds tempting indeed, but should you really notice a performance increase 
> > out of this?
> 
> Compared to 8xx in 2.6 today?  Absolutely.
> 
> -- 
> Tom Rini
> http://gate.crashing.org/~trini/
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
