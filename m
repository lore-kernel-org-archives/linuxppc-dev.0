Return-Path: <mmporter@cox.net>
Received: from fed1rmmtao03.cox.net (fed1rmmtao03.cox.net [68.230.241.36])
	by ozlabs.org (Postfix) with ESMTP id 2FD3567A83
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  1 Apr 2005 06:11:11 +1000 (EST)
Date: Thu, 31 Mar 2005 13:10:44 -0700
From: Matt <mporter@kernel.crashing.org>
To: Tom Rini <trini@kernel.crashing.org>
Message-ID: <20050331131044.A29501@cox.net>
References: <20050316231800.GD8345@smtp.west.cox.net>
	<d0e9907f9780a7fce59b3f69af6ece99@freescale.com>
	<1111171391.2987.24.camel@ad.doubleclick.net>
	<20050318193045.GM8345@smtp.west.cox.net>
	<1112286378.24673.252.camel@rhino.az.mvista.com>
	<20050331163420.GI25923@smtp.west.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20050331163420.GI25923@smtp.west.cox.net>;
	from trini@kernel.crashing.org on Thu, Mar 31, 2005 at 09:34:21AM
	-0700
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

On Thu, Mar 31, 2005 at 09:34:21AM -0700, Tom Rini wrote:
> On Thu, Mar 31, 2005 at 09:26:18AM -0700, Wade Farnsworth wrote:
> > On Fri, 2005-03-18 at 12:30, Tom Rini wrote:
> > > On Fri, Mar 18, 2005 at 01:43:11PM -0500, Jason McMullan wrote:
> > > > On Fri, 2005-03-18 at 10:06 -0600, Kumar Gala wrote:
> > > > > Can you build your patch for the lopec_defconfig and fix the errors 
> > > > > associated with enabling altivec.
> > > > > 
> > > > > Looks like you need to include asm/offset.h & asm/page.h in vector.S, 
> > > > > however there is another build error after that.
> > > > 
> > > > Thanks! That also found a linking bug, fixed in this patch.. Please
> > > > double check the call in 'AltiVecUnavalible' in head.S, and the re-load
> > > > of 'ctr' at the end of load_up_altivec, as I do not have an AltiVec
> > > > machine here.
> > > 
> > > No dice:
> > > VFS: Mounted root (nfs filesystem) readonly.
> > > Freeing unused kernel memory: 100k init 4k prep
> > > floating point used in kernel (task=c03816b0, pc=c000d664)
> > > Doing some objdump'ing, that's the start of load_up_altivec.
> > 
> > Hi Jason and Tom,
> > 
> > Has there been any more progress on this patch?
> 
> Sadly no.  We got to the point where it was reliably crashing on my
> LoPEC (7400), but no time to try and fix it.  The problem should show up
> on any classic PPC box..

If nobody has time to work on this, then I intend  to put Wade's 440EP
support in as is (actually, he's planning on resubmitting with some
additional changes).  When somebody has time, they can redo the patch
against that.

-Matt
