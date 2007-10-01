Return-Path: <dgibson@ozlabs.org>
Date: Mon, 1 Oct 2007 15:33:26 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH 1/2] qemu platform, v2
Message-ID: <20071001053326.GA15132@localhost.localdomain>
References: <boot-8-00.miltonm@bga.com> <qemu-8-01.miltonm@bga.com>
	<20070922095546.GA14185@lst.de>
	<200709221416.21580.rob@landley.net>
	<18165.60185.316393.213864@cargo.ozlabs.ibm.com>
	<4d27912d86d1373ca01d43bd296e237b@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4d27912d86d1373ca01d43bd296e237b@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	Milton Miller <miltonm@bga.com>, Rob Landley <rob@landley.net>,
	Christoph Hellwig <hch@lst.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Sep 28, 2007 at 06:53:28PM +0200, Segher Boessenkool wrote:
> >> I'd be following this more closely if compiling a device tree didn't 
> >> currently
> >> require an external utility (dtc or some such) that doesn't come with 
> >> the
> >> Linux kernel.  No other target platform I've built kernels for 
> >> requires such
> >> an environmental dependency.
> >
> > No?  You haven't built kernels for other platforms that have external
> > dependencies such as perl, gcc, make, binutils, etc.? :)
> 
> Two of the supported Linux archs cannot be built with a mainline
> compiler, even!
> 
> And I have to install GNU sed/awk to get builds to work, too.
> 
> OTOH, it would be nice if we didn't need DTC -- it itself doesn't
> build out-of-the-box on all systems, either ;-)
> 
> >>  (This is a problem both for hardwiring the
> >> device tree into the kernel and for building a new boot rom from the 
> >> linux
> >> kernel's ppc boot wrapper that would contain such a device tree to 
> >> feed to
> >> the kernel.)
> >
> > It's only really been a problem for ps3 so far, since the embedded
> > guys don't seem to have any difficulty with installing dtc.  We are
> > looking at what to do for ps3 and prep, and the answer may well
> > involve bundling dtc in the kernel source (it's not too big, around
> > 3400 lines).
> 
> If only a few platforms have this problem, we could instead include
> their .dtb files in the kernel source tree.

Including .dtbs in the kernel tree has a big practical problem:
they're binary, so can't be patch(1)ed, which makes updating them a
complete PITA.

I'm working on merging dtc into the kernel tree instead.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
