Return-Path: <dale@farnsworth.org>
Date: 30 Mar 2006 19:53:09 -0000
Message-ID: <20060330195309.10006.qmail@farnsworth.org>
From: "Dale Farnsworth" <dale@farnsworth.org>
To: jcrigby@gmail.com, Linuxppc-embedded <Linuxppc-embedded@ozlabs.org>
Subject: Re: Kernel for MPC Lite 5200 will not compile
In-Reply-To: <4b73d43f0603300829q7d45a029qdb5d8006ccda7275@mail.gmail.com>
References: <442B11E8.7020107@246tNt.com>
	<20060330003419.3FF71353A37@atlas.denx.de>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

John Rigby <jcrigby@gmail.com> wrote:
> Sent this to Wolfgang last night.  Accidently omitted Syvain and the list.
> 
> The actual bestcomm "microcode" in Sylvain's tree is the same as the latest
> Freescale supported code.  The linux driver code that interfaces with it is
> code written by Dale Farnsworth and has Montavista copyright.  I don't know
> if it is based on old Freescale (Motorola) code or if it is Dale's creation
> (perhaps Dale can comment).

My bestcomm code is not based on the Freescale code.  I did have access to
the Freescale (Motorola) code when I wrote it, but I think you'll find that
there is *very little* similarity between the two code bases.

> I have just spent some time getting UDMA support into the ATA driver using
> the the bestcomm code in Sylvain's tree.  In the process I found some bugs
> in the code that may explain some problems people have seen with the FEC
> driver.  I'll try to get the patch out tomorrow.
> 
> The ATA driver is a port from a version that worked on an older kernel and
> used the supported Freescale Bestcomm code.  I did the port because it was
> my understanding that attempts to get the supported Freescale code into a
> public tree had met with resistance in the past.  (Second hand info, I'm
> actually fairly new to the 52xx world).
> 
> The pluses for the Freescale version is that several devices are supported
> that are not in Sylvain's tree.  The version in Sylvain's kernel has a
> generic api plus specific code for FEC.  My upcoming patch fixes some bugs,
> adds some missing functionality that I need for ATA and adds the specific
> ATA dma driver code.
> 
> The biggest minus for the Freescale version is that it is really opaque.
> Its implementation makes it hard to figure out what the code is actually
> doing.

Yes, this makes it difficult to maintain and is what has kept the
Freescale Bestcomm code from being accepted into the kernel.  I would
have preferred not to write an alternate version, but, at the time,
Motorola had a take-or-leave-it stance; they wouldn't consider accepting
patches to clean it up.  So then I planned to simply fork their version,
but found the code so convoluted that it was easier to start from scratch.

> If there is a chance of getting the Freescale Bestcomm code into Sylvain's
> tree (and on up the line to Linus) I would welcome that since I would not
> have to port other Bestcomm dependent drivers to the version in Sylvain's
> tree.  I would gladly port the current FEC code to the Freescale Bestcomm
> code to avoid the work of porting the other drivers.  Also we at Freescale
> would prefer to have one version of the Bestcomm code circulating.
> 
> So I guess my question for those with an opinion is what version of Bestcomm
> should be we use for 5200.

It would be better to have one version, and my bestcomm code could be
replaced in Linux by code derived from the current Freescale code.  The
challenges are political.  Neither Freescale nor the Linux community is
willing to relinquish control of their code to the other.  Potentially,
this can be addressed by having a Freescaler, who is responsive to the
Linux community, be a Linux maintainer for the bestcomm code.  There are
also licensing concerns though, since Freescale needs to also license
their code under non-GPL terms.

Until these challenges are resolved, I think we're stuck with two versions.

Thanks,
-Dale
