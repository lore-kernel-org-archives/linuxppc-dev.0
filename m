Return-Path: <trini@kernel.crashing.org>
Received: from fed1rmmtao11.cox.net (fed1rmmtao11.cox.net [68.230.241.28])
	by ozlabs.org (Postfix) with ESMTP id E301667A46
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  1 Apr 2005 05:04:41 +1000 (EST)
Date: Thu, 31 Mar 2005 12:04:39 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Kumar Gala <kumar.gala@freescale.com>
Message-ID: <20050331190439.GJ25923@smtp.west.cox.net>
References: <20050331163420.GI25923@smtp.west.cox.net>
	<b931159370eb09607fdee4a0f438d57f@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <b931159370eb09607fdee4a0f438d57f@freescale.com>
Cc: linuxppc-embedded Linux list <linuxppc-embedded@ozlabs.org>
Subject: Re: 440EP FPU patch
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Thu, Mar 31, 2005 at 12:45:44PM -0600, Kumar Gala wrote:
> Tom,
> 
> On Mar 31, 2005, at 10:34 AM, Tom Rini wrote:
> 
> >On Thu, Mar 31, 2005 at 09:26:18AM -0700, Wade Farnsworth wrote:
> > > On Fri, 2005-03-18 at 12:30, Tom Rini wrote:
> > > > On Fri, Mar 18, 2005 at 01:43:11PM -0500, Jason McMullan wrote:
> > > > > On Fri, 2005-03-18 at 10:06 -0600, Kumar Gala wrote:
> > > > > > Can you build your patch for the lopec_defconfig and fix the 
> >errors
> >> > > > associated with enabling altivec.
> > > > > >
> >> > > > Looks like you need to include asm/offset.h & asm/page.h in 
> >vector.S,
> >> > > > however there is another build error after that.
> > > > >
> >> > > Thanks! That also found a linking bug, fixed in this patch.. 
> >Please
> > > > > double check the call in 'AltiVecUnavalible' in head.S, and the 
> >re-load
> > > > > of 'ctr' at the end of load_up_altivec, as I do not have an 
> >AltiVec
> > > > > machine here.
> > > >
> >> > No dice:
> > > > VFS: Mounted root (nfs filesystem) readonly.
> > > > Freeing unused kernel memory: 100k init 4k prep
> > > > floating point used in kernel (task=c03816b0, pc=c000d664)
> >> > Doing some objdump'ing, that's the start of load_up_altivec.
> >>
> >> Hi Jason and Tom,
> > >
> >> Has there been any more progress on this patch?
> >
> >Sadly no.? We got to the point where it was reliably crashing on my
> >LoPEC (7400), but no time to try and fix it.? The problem should show 
> >up
> > on any classic PPC box..
> 
> Is it crashing on just avec code or everything?

That's a good question.  IIRC, I was using a userspace with an
altivec-using setjmp/longjmp, so it could have been Altivec-specific.
I don't have test kernels w/ the patch handy anymore to verify, sorry.

-- 
Tom Rini
http://gate.crashing.org/~trini/
