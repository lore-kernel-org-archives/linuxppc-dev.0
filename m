Return-Path: <owner-linuxppc-dev@lists.linuxppc.org>
From: "Dale Farnsworth" <dale@farnsworth.org>
Date: Mon, 10 Nov 2003 12:02:07 -0700
To: Wolfgang Denk <wd@denx.de>, linuxppc-dev@lists.linuxppc.org,
	Tom Rini <trini@kernel.crashing.org>
Subject: Re: MPC5200 Patches
Message-ID: <20031110190207.GA12163@zenos.farnsworth.org>
References: <20031103233143.GA19177@zenos.farnsworth.org> <20031107222025.3181CC5F59@atlas.denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20031107222025.3181CC5F59@atlas.denx.de>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Fri, Nov 07, 2003 at 10:20:20PM +0000, Wolfgang Denk wrote:
> The code is actually identical the the later version where Motorola
> replaced the headers with GPL preambles. I sent a tarball with the GPL
> bestcomm code to Tom Rini.

I just thought that applying a patch that had "Motorola Confidential
Proprietary" all over it wasn't a good idea. :-)

> > I did not publish the port because the ethernet support relies on
> > a Motorola-written DMA subsystem with a proprietary license that
> > doesn't permit redistribution. A month ago, Motorola finally sent
> > me an updated, GPLed version of the DMA controller code. I merged
> > the new version, but the DMA API has changed and I've been busy with
> > other things
>
> The main problem with the FEC code is that it does NOT use the offical
> bestcomm API but (for efficiency reasons?) meddles directly with
> internal bestcomm data. This is why the code breaks with each new
> release of the bestcomm code.

I think you're referring to the way the fec code accesses the ring
buffers.  Motorola supports direct access to the ring buffer and this
is the only release of the bestcomm that broke that access.  Previous
breakages were due to other changes in bestcomm API.

> The code I submitted contains some things; some code was developed by
> BenH, some by DENX. It would be sad if this stuff was just ignored.
> How about merging our code and your new stuff?

I have merged your code, benh's and mine and placed it at
ftp://source.mvista.com/pub/linuxppc/mpc5200/linuxppc_2_4_devel.mpc5200.patch

This patch doesn't require uboot.  I retained the uboot code and added
CONFIG_UBOOT, but haven't tested with it.

I would appreciate it if you could take some time to test it with your
hardware.  I find that USB and PCI are not working here, but they also
fail with your patch, so it may be my icecube hardware.

I haven't tested this merged code on the MGT5100, and in fact, I removed
the MGT5100 FEC support because the #ifdefs in fec.c were just too ugly.
I'll insert a compatibility layer to support the MGT5100 FEC if there
is sufficient interest.  Is anyone still using the MGT5100?

> For me the main issue is that MPC5200 support makes it into the
> official kernel trees as fast as possible.

Agreed, with reasonable quality.

Thanks,
-Dale

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
