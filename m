Return-Path: <marcelo.tosatti@cyclades.com>
Received: from parcelfarce.linux.theplanet.co.uk
	(parcelfarce.linux.theplanet.co.uk [195.92.249.252])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id B990967AED
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 11 Feb 2005 07:57:33 +1100 (EST)
Date: Thu, 10 Feb 2005 15:08:59 -0200
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Dan Malek <dan@embeddededge.com>
Message-ID: <20050210170859.GB20153@logos.cnet>
References: <EA78B62757AF1E4799828249310AC4CA071D281F@stca206a.bus.sc.rolm.com>
	<28F2CE72-0BF0-11D9-97DC-003065F9B7DC@embeddededge.com>
	<20050210150437.GA19134@logos.cnet>
	<c5f8c158f9254cbb0a8e085cf0fda8de@embeddededge.com>
	<20050210170658.GA20153@logos.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20050210170658.GA20153@logos.cnet>
Cc: "Smith, Craig" <craig.d.smith@siemens.com>,
	linux-ppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: Re: Linux 2.6.x on 8xx status
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Thu, Feb 10, 2005 at 03:06:58PM -0200, Marcelo Tosatti wrote:
> On Thu, Feb 10, 2005 at 02:26:52PM -0500, Dan Malek wrote:
> > 
> > On Feb 10, 2005, at 10:04 AM, Marcelo Tosatti wrote:
> > 
> > >Does anyone have a clue of what is/can be wrong with the TLB entry for 
> > >the
> > >address being flushed at __flush_dcache_icache()?
> > 
> > Not sure.  The problem is that the __flush_dcache_icache is passed a
> > user space virtual address that doesn't look like it is mapped for 
> > writing
> > or something.  I don't know, as an ooops isn't sufficient to debug the 
> > problem.
> > You have to catch it here and track down the current state of the TLB 
> > and
> > the page tables.  Of course, when I do this everything looks OK, 
> 
> How do you do track down the current TLB state? With a BDI? 
> 
> > so what I've been trying to do is catch the TLBmiss reload that actually causes 
> > this
> > to happen to see what it really tried to load into the tlb.
> 
> Shouldnt it be loading the TLB entry which "seem to be OK" accordingly to your
> analysis ?? 

So this assumption which you have made sometime ago is wrong, given that now you 
know TLB entry is not stale ?

"The symptom is we appear to have a stale TLB entry,
so at least one of the callouts from the generic VM
code isn't doing the right thing for us.  I'm still
puzzled as to why it doesn't affect other PPC processor." 
