Return-Path: <rob@landley.net>
Received: from grelber.thyrsus.com
	(static-71-162-243-5.phlapa.fios.verizon.net [71.162.243.5])
	by ozlabs.org (Postfix) with ESMTP id E9B00DDE2D
	for <linuxppc-dev@ozlabs.org>; Mon, 24 Sep 2007 08:01:26 +1000 (EST)
From: Rob Landley <rob@landley.net>
To: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH 1/2] qemu platform, v2
Date: Sun, 23 Sep 2007 17:01:18 -0500
References: <boot-8-00.miltonm@bga.com> <200709221416.21580.rob@landley.net>
	<18165.60185.316393.213864@cargo.ozlabs.ibm.com>
In-Reply-To: <18165.60185.316393.213864@cargo.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200709231701.18802.rob@landley.net>
Cc: linuxppc-dev@ozlabs.org, Christoph Hellwig <hch@lst.de>,
	Milton Miller <miltonm@bga.com>, David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Saturday 22 September 2007 11:27:05 pm Paul Mackerras wrote:
> Rob Landley writes:
>
> Just to correct a few misconceptions:
> > 2) PowerPC uses a device tree supplied by the hardware to identify the
> > available hardware, even for stuff living on PCI busses which it could
> > theoretically probe for but doesn't.
>
> The device tree doesn't have to include anything that can be probed
> for.  On some platforms (e.g. pSeries) we choose to use the device
> tree rather than probing, but on most other platforms we probe.
>
> > I'd be following this more closely if compiling a device tree didn't
> > currently require an external utility (dtc or some such) that doesn't
> > come with the Linux kernel.  No other target platform I've built kernels
> > for requires such an environmental dependency.
>
> No?  You haven't built kernels for other platforms that have external
> dependencies such as perl, gcc, make, binutils, etc.? :)

Lemme clarify.

1) All of the other platforms have the _same_ requirements.  I never had to 
install anything to build "for arm", "for mips", "for sparc", or 
for "x86_64".

The minimal requirements are:  A compiler (gcc/binutils although I'm working 
on extending tcc to replace these), make, linux kernel, C library (uClibc), 
busybox, and bash.  That's it.  You can rebuild it under itself from source 
with that, on x86, x86-64, arm, mips...  Presumably sparc and m68k too (still 
debugging there).

2) Perl isn't needed to build any target platform I've tried.  (I even sent in 
some patches way back to turn a perl script into a sed script for User Mode 
Linux to _make_ this the case.)  Yes you need perl to build glibc, but not to 
build uClibc. :)

3) What I'm pointing out is that ppc needs an external dependency none of the 
other platforms I've tried need.  I consider this a bug.  I didn't start 
using "make headers_install" until it stopped needing an external unifdef.

> >  (This is a problem both for hardwiring the
> > device tree into the kernel and for building a new boot rom from the
> > linux kernel's ppc boot wrapper that would contain such a device tree to
> > feed to the kernel.)
>
> It's only really been a problem for ps3 so far, since the embedded
> guys don't seem to have any difficulty with installing dtc.

If the only target that interested me was ppc, then I'd happily install dtc 
for it.  But focusing on cross-platform support as I am, I notice when a 
platform has different requirements from any of the others.

> We are 
> looking at what to do for ps3 and prep, and the answer may well
> involve bundling dtc in the kernel source (it's not too big, around
> 3400 lines).

Sounds good to me...

> Paul.

Rob
-- 
"One of my most productive days was throwing away 1000 lines of code."
  - Ken Thompson.
