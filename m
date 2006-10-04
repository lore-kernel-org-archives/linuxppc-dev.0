Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17699.769.632098.479906@cargo.ozlabs.ibm.com>
Date: Wed, 4 Oct 2006 10:40:33 +1000
From: Paul Mackerras <paulus@samba.org>
To: Dan Malek <dan@embeddedalley.com>
Subject: Re: [PATCH 10/11] Add MPC8360EMDS board support
In-Reply-To: <EBD0615C-4F22-430F-BD23-1283DF98F1B3@embeddedalley.com>
References: <20060927155626.4d5ca19c@vitb.ru.mvista.com>
	<4879B0C6C249214CBE7AB04453F84E4D19D865@zch01exm20.fsl.freescale.net>
	<20060927165556.04c8d5d7@vitb.ru.mvista.com>
	<CE624A83-809E-4180-800E-660A578FFCFC@embeddedalley.com>
	<20060927112201.293fef44@localhost.localdomain>
	<EBD0615C-4F22-430F-BD23-1283DF98F1B3@embeddedalley.com>
Cc: Olof Johansson <olof@lixom.net>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Dan Malek writes:

> > ....   So you can boot the same kernel binary on
> > several boards, as long as the drivers are built in and the correct
> > device tree is used. Has everyone missed/forgotten that objective
> > completely?
> 
> That was never an objective when we started, although
> it seems some people involved in the implementation
> think it's the only objective.  It just happens to be a side
> effect when convenient.

I tend to look at it not as a direct objective in itself for the
embedded platforms, but more as something that will just happen
naturally when the code is written well.

I also don't think it's the role of the upstream kernel sources to
support every single embedded board out there.  I think stuff should
be upstream if it is either (a) useful to a lot of people as-is, or
(b) useful as a starting point for making a kernel that will work on a
specific board.

Most of the embedded stuff falls into category (b), which means that
it needs to be understandable and reusable, rather than being
specifically optimized for a particular board.  That means that ifdefs
are evil, because they obfuscate the code.  Also, ifdefs are often a
sign that a driver is only written to support one instance of a
particular device, which is a limitation on its reusability - it will
have to be modified when someone makes a chip or board that has two of
its device on it.

I have no problem whatever with someone taking the upstream sources
and optimizing it to the nth degree for their particular embedded
board.  I don't think that's appropriate for the upstream sources
though.

The device-tree concept offers a way to make drivers more readable and
reusable, by separating out the board-specific configuration
information (thus reducing ifdefs) and by encouraging the style of
code that naturally copes with any number of device instances.

> Now, we have something that is way more complex than
> we initially thought was necessary, trying to describe nearly
> everything addressable in the system instead of just the
> internal memory map.  I suspect the software to attain

How does the "internal memory map" differ from "everything addressable
in the system"?  I think it is useful if the device tree describes the
non-discoverable devices in the system; we have never said the device
tree has to contain devices that the kernel can discover for itself,
such as PCI devices.

> Highly configurable development/evaluation
> boards running a single binary aren't high volume
> products, and the additional resources required
> by such software could ensure real products aren't
> developed with PPCs.  We need to be sensitive
> to this.

Leo Li had an interesting idea, which is a preprocessor that would
take kernel code written to use the device tree, plus the specific
device tree for a board, and emit a version of the code with
everything hard-coded.  That would assist with getting the
uber-optimized version that you want for a product.

Paul.
