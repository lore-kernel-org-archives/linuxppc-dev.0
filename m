MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <16582.38634.736636.748883@cargo.ozlabs.ibm.com>
Date: Wed, 9 Jun 2004 14:49:46 +1000
From: Paul Mackerras <paulus@samba.org>
To: Li Yang-r58472 <LeoLi@freescale.com>
Cc: Linuxppc-Embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: kernel source trees maintenance
In-Reply-To: <01139FC052A0D411900B00508B9535FC0F0D274C@ZCH07EXM04.corp.mot.com>
References: <01139FC052A0D411900B00508B9535FC0F0D274C@ZCH07EXM04.corp.mot.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Li Yang-r58472 writes:

> I am confused about the maintaining mechanism of kernel.org tree and
> linuxppc tree.  How a patch goes into linuxppc tree? And how patch
> from linuxppc tree goes into kernel.org tree?  Is there any patch
> that goes directly into kernel.org tree?  Who are the decision
> makers of merging a patch for both trees?

I am the overall ppc32 maintainer, meaning that I ultimately get to
say what goes into arch/ppc and include/asm-ppc.  Andrew Morton is the
maintainer of the 2.6 kernel.org tree, meaning that he gets to say
what goes in or doesn't, anywhere in the tree.

The only way that any patch gets into the 2.6 kernel.org tree is by
someone sending a patch to Andrew Morton.  In the ppc parts of the
tree, it would be me or one of the maintainers for the ppc subsystems:
Tom Rini for bootloader and 6xx/7xx/7xxx embedded stuff, Ben
Herrenschmidt for Power Macintosh stuff, Matt Porter for 4xx embedded
stuff, or Dan Malek or Tom Rini for 8xx embedded stuff.  There is
nothing to prevent other people from sending patches directly to
Andrew Morton, of course, but unless it's a completely trivial and
obvious patch, Andrew will ask me or one of the people listed above
for my/their opinion before accepting it.

As for the linuxppc trees, there are about 10 people that can make
changes in those trees.  Changes checked in to the linuxppc trees do
*not* automatically flow upstream to the kernel.org trees - I, or one
of the subsystem maintainers, has to prepare a patch with a suitably
detailed description and send it to Andrew Morton.  This means that a
change checked into linuxppc-2.5 is unlikely to go upstream unless
either (a) one of the ppc subsystem maintainers notices it and makes
the effort to send it upstream or (b) the author of the change
prepares a patch with description and asks one of the ppc subsystem
maintainers to send it upstream.

Patches can go directly into the kernel.org tree without first going
into linuxppc-2.5.  Such patches will automatically get imported to
the linuxppc-2.5 tree when someone does a pull from the kernel.org
tree (this is a manual process, but it's easy).  Since ppc patches are
going into the kernel.org tree quickly and easily these days, this is
actually the least-effort way to go in most cases.  One day perhaps we
will be able to get away from having any linuxppc tree and just work
with the kernel.org tree all the time.

Paul.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
