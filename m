Return-Path: <rob@landley.net>
Received: from grelber.thyrsus.com
	(static-71-162-243-5.phlapa.fios.verizon.net [71.162.243.5])
	by ozlabs.org (Postfix) with ESMTP id 52A9DDDE24
	for <linuxppc-dev@ozlabs.org>; Sat, 29 Sep 2007 06:15:22 +1000 (EST)
From: Rob Landley <rob@landley.net>
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH 1/2] qemu platform, v2
Date: Fri, 28 Sep 2007 15:14:43 -0500
References: <boot-8-00.miltonm@bga.com>
	<18165.60185.316393.213864@cargo.ozlabs.ibm.com>
	<4d27912d86d1373ca01d43bd296e237b@kernel.crashing.org>
In-Reply-To: <4d27912d86d1373ca01d43bd296e237b@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200709281514.43592.rob@landley.net>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	Christoph Hellwig <hch@lst.de>, Milton Miller <miltonm@bga.com>,
	David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Friday 28 September 2007 11:53:28 am Segher Boessenkool wrote:
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

Strange definition of "supported"...

> And I have to install GNU sed/awk to get builds to work, too.

I extended busybox sed until it built everything I threw at it.  (I even added 
a "lie to autoconf" step that replies to --version to say "This is not gnu 
sed 4.0" so a regex in autoconf doesn't do something stupid.)

That's how I got into busybox development in the first place...

> OTOH, it would be nice if we didn't need DTC -- it itself doesn't
> build out-of-the-box on all systems, either ;-)

I've built x86, x86-64, mips, arm, and sparc.  None of them needed anything 
but the seven packages I mentioned.  I'm poking at adding m68k, alpha, bfin, 
and powerpc, but my free time's been spoken for recently.  (I'll become 
interested in sh or parisc when qemu grows support for it.  I'm only 
interested in bfin because I was given some free blackfin hardware at OLS.)

I've even poked at running s390 under Hercules but the setup was insane enough 
to throw it way the heck down on my todo list.  (Step 1: download and 
configure an IBM operating system image from the 1970's...  Oh yeah, fills me 
with enthusiasm...)

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

I've had it clarified that the recent qemu-ppc patches from Milton only 
require dtc to build the ROM image to boot qemu with.  The Linux kernel image 
you build hasn't got a device tree in it (although that means it needs one 
passed in from the rom image)...

Using some other patches that floated by, I did build a prep kernel a couple 
of weeks ago, which qemu happily handed control off to...  which then failed 
to boot because it couldn't parse the incomplete residual data left over from 
open hackware.  The solution the ppc list recommended?  Hardwire a device 
tree into said linux kernel using dtc...

>
> Segher

Rob
-- 
"One of my most productive days was throwing away 1000 lines of code."
  - Ken Thompson.
