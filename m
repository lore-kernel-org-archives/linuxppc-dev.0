Return-Path: <trini@kernel.crashing.org>
Received: from fed1rmmtao09.cox.net (fed1rmmtao09.cox.net [68.230.241.30])
	by ozlabs.org (Postfix) with ESMTP id 6B45C67B71
	for <linuxppc-dev@ozlabs.org>; Tue,  5 Sep 2006 04:36:51 +1000 (EST)
Date: Mon, 4 Sep 2006 11:36:49 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Benjamin Heyne <benjamin.heyne@uni-dortmund.de>
Subject: Re: [PATCH] Gunzip call fix for PPC kernel images >4MB
Message-ID: <20060904183649.GD9323@smtp.west.cox.net>
References: <20060816113137.7a8e5608@bob.dt.e-technik.uni-dortmund.de>
	<20060817050408.GJ3249@smtp.west.cox.net>
	<20060818101024.46a77c6b@bob.dt.e-technik.uni-dortmund.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20060818101024.46a77c6b@bob.dt.e-technik.uni-dortmund.de>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	Milton Miller <miltonm@bga.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Sorry about the late reply, this got burried in my inbox.

On Fri, Aug 18, 2006 at 10:10:24AM +0200, Benjamin Heyne wrote:
> And so it came to pass, that on Wed, 16 Aug 2006 22:04:08 -0700
> Tom Rini <trini@kernel.crashing.org> wrote as thus:
> 
> > On Wed, Aug 16, 2006 at 11:31:37AM +0200, Benjamin Heyne wrote:
> > 
> > > If Kernel images for PPC grow >4MB inflating of the kernel fails.
> > > Increasing the link/load address doesn't help. Problem is 
> > > solved by replacing the fixed address of the gunzip() call in
> > > misc-embedded.c with CONFIG_BOOT_LOAD.
> > 
> > The arch/ppc/boot code makes some assumptions such as that 4MB-8MB (except
> > on 40x which is end of the wrapper code to 8MB, and BOOT_LOAD defaults
> > to 4MB here) is free to use for malloc()'ing for the inflate routine.
> 
> Well, I just could find this assumptions hardcoded in misc - Not in misc-embedded.
> But I am relatively new to kernel programming, so maybe I have missed something.
> 
> But despite of that: Shouldn't it be possible to shift this range without
> having to change fixed addresses at several places?

Maybe, just maybe.  The code is quite a bit complex in parts and I'd
really rather not try and make changes here as it's also on its way out.

> > It also assumes that the vmlinux.gz will live at BOOT_LOAD + a bit, when
> > the wrapper is set to kick off linux.
> 
> As I understand it, the lowest address at which reasonable data starts is
> BOOT_LOAD. The space below is used for inflating, right? At least this
> seems to be the case for my target (Virtex, ML300) - Do other targets
> behave differently?

At various points in the cycle, all targets make assumptions about what
can and can't live where.  Relocation is one of the big issues here as
we have to accept and work when we're loaded above, or below, BOOT_LOAD
initially and move ourself and anything useful we've been passed in,
around.

> > Finally, in arch/ppc/boot/ (for both OF and !OF cases) gunzip looks
> > like:
> > void gunzip(void *dst, int dstlen, unsigned char *src, int *lenp)
> 
> Ok - The dstlen parameter just tells zlib_inflate() something about the
> available space. If the inflated image grows larger, an error occurs.
> Therefore, BOOT_LOAD should be a reasonable border because board data
> starts beyond - not before.

Yes, I'm saying it's possible that some of that range is not available
space, for uncompressing as it's used for buffers in zlib_inflate.

> > So I see 2 problems here.
> > 
> > First, there are other calls to gunzip with dstlen hard-coded to 4MB, so
> > the problem would still exist.
> 
> Well, the other one exists in misc.c - But this one doesn't apply to the
> embedded target, right?

You can't really change one without changing the rest as there's similar
issues in all.

> > Second, and more complexly we want to make sure that we don't tell
> > gunzip that the destination size grows into the area it would also be
> > using to malloc buffers, unless someone can (and please do if possible)
> > explain that it's really OK to uncompress into our zalloc space (there
> > is no zfree so maybe it's going to be OK, but I don't know that the
> > algorithm wouldn't try and reuse buffers which would be bad).
> 
> Well, as I said I am new to kernel programming - So I don't
> know exactly where the malloc space starts. I just assumed it would be 
> beyond BOOT_START because it seemed to be reasonable (If you have a kernel
> which inflated size is exactly 4MB, inflation should also work...does it?).

I'm sorry to say you didn't pick the easiest spot to cut your teeth on,
so to speak.  The malloc space always beyond BOOT_LOAD because we don't
know how high we can go.  We know that from 0 to BOOT_LOAD is valid (or
we would have failed by now).  We have to assume that BOOT_LOAD to the
end ourself is also valid, or we'd have blown up (and hopefully in a way
that the user would figure out they need to tweak BOOT_LOAD or make the
image smaller).  But beyond that we don't always have a way to know how
much memory we have.

-- 
Tom Rini
