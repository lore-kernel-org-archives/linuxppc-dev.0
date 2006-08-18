Return-Path: <benjamin.heyne@uni-dortmund.de>
Received: from unimail.uni-dortmund.de (mx1.HRZ.Uni-Dortmund.DE
	[129.217.128.51]) by ozlabs.org (Postfix) with ESMTP id B1A5467B32
	for <linuxppc-dev@ozlabs.org>; Fri, 18 Aug 2006 18:11:55 +1000 (EST)
Date: Fri, 18 Aug 2006 10:10:24 +0200
From: Benjamin Heyne <benjamin.heyne@uni-dortmund.de>
To: Tom Rini <trini@kernel.crashing.org>
Subject: Re: [PATCH] Gunzip call fix for PPC kernel images >4MB
Message-ID: <20060818101024.46a77c6b@bob.dt.e-technik.uni-dortmund.de>
In-Reply-To: <20060817050408.GJ3249@smtp.west.cox.net>
References: <20060816113137.7a8e5608@bob.dt.e-technik.uni-dortmund.de>
	<20060817050408.GJ3249@smtp.west.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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

And so it came to pass, that on Wed, 16 Aug 2006 22:04:08 -0700
Tom Rini <trini@kernel.crashing.org> wrote as thus:

> On Wed, Aug 16, 2006 at 11:31:37AM +0200, Benjamin Heyne wrote:
> 
> > If Kernel images for PPC grow >4MB inflating of the kernel fails.
> > Increasing the link/load address doesn't help. Problem is 
> > solved by replacing the fixed address of the gunzip() call in
> > misc-embedded.c with CONFIG_BOOT_LOAD.
> 
> The arch/ppc/boot code makes some assumptions such as that 4MB-8MB (except
> on 40x which is end of the wrapper code to 8MB, and BOOT_LOAD defaults
> to 4MB here) is free to use for malloc()'ing for the inflate routine.

Well, I just could find this assumptions hardcoded in misc - Not in misc-embedded.
But I am relatively new to kernel programming, so maybe I have missed something.

But despite of that: Shouldn't it be possible to shift this range without
having to change fixed addresses at several places?

> 
> It also assumes that the vmlinux.gz will live at BOOT_LOAD + a bit, when
> the wrapper is set to kick off linux.

As I understand it, the lowest address at which reasonable data starts is
BOOT_LOAD. The space below is used for inflating, right? At least this
seems to be the case for my target (Virtex, ML300) - Do other targets
behave differently?

> 
> Finally, in arch/ppc/boot/ (for both OF and !OF cases) gunzip looks
> like:
> void gunzip(void *dst, int dstlen, unsigned char *src, int *lenp)

Ok - The dstlen parameter just tells zlib_inflate() something about the
available space. If the inflated image grows larger, an error occurs.
Therefore, BOOT_LOAD should be a reasonable border because board data
starts beyond - not before.

> 
> So I see 2 problems here.
> 
> First, there are other calls to gunzip with dstlen hard-coded to 4MB, so
> the problem would still exist.

Well, the other one exists in misc.c - But this one doesn't apply to the
embedded target, right?

> 
> Second, and more complexly we want to make sure that we don't tell
> gunzip that the destination size grows into the area it would also be
> using to malloc buffers, unless someone can (and please do if possible)
> explain that it's really OK to uncompress into our zalloc space (there
> is no zfree so maybe it's going to be OK, but I don't know that the
> algorithm wouldn't try and reuse buffers which would be bad).
> 

Well, as I said I am new to kernel programming - So I don't
know exactly where the malloc space starts. I just assumed it would be 
beyond BOOT_START because it seemed to be reasonable (If you have a kernel
which inflated size is exactly 4MB, inflation should also work...does it?).

Probably I missed something - But I don't really see the problem. Would you
please clarify it a little bit?

Best regards
-- 
Benjamin Heyne
