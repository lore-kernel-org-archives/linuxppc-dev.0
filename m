Return-Path: <acmay@acmay.homeip.net>
Received: from fed1rmmtao01.cox.net (fed1rmmtao01.cox.net [68.230.241.38])
	by ozlabs.org (Postfix) with ESMTP id 28A5D67A64
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  9 Mar 2005 05:01:37 +1100 (EST)
Date: Tue, 8 Mar 2005 10:01:49 -0800
From: Debian User <acmay@acmay.homeip.net>
To: Matt Porter <mporter@kernel.crashing.org>
Message-ID: <20050308180149.GA4293@acmay.homeip.net>
References: <4226F904.5010104@bitsim.se> <1109875809.25252.24.camel@mud>
	<422C27FE.6000709@bitsim.se> <20050307052732.A26339@cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20050307052732.A26339@cox.net>
Cc: Linux PPC Embedded list <linuxppc-embedded@ozlabs.org>,
	Jakob Viketoft <jakob.viketoft@bitsim.se>
Subject: Re: Adding machine types to the kernel tree...
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Mon, Mar 07, 2005 at 05:27:32AM -0700, Matt Porter wrote:
> On Mon, Mar 07, 2005 at 11:07:58AM +0100, Jakob Viketoft wrote:
> > Thanks for the comments!
> > 
> > Andrew May wrote:
> > > I think a huge first step would be to banish xparameters.h from all the
> > > kernel code.
....
> > 
> > I understand that there is numerous resentment against having this file 
> > in the kernel and I've been thinking of a solution without it. One such 
> > path would be serving the kernel with a OCP list of the devices used, 
> > but I'm unsure about the current status of OCP. Is this The Right Way to 
> > do it, or are OCP likely to be abandoned further along the 2.6 road?

Not so much resentment, as a realization that xparamters.h is where all
the work is going to flow from.

> > Matt (Porter), I've seen that you've "ported" this to the 2.6 kernel, 
> > what do you say?
> 
> Don't tie anything permanently to OCP. :) Eventually, 4xx will convert
> to platform devices like other similar SoC type subarches in ppc32 have
> already done.  The only reason it hasn't been done yet is that there
> are some other higher priority things on my plate at the moment.

I am still working with an old 2_4_devel kernel myself.
The something better is comming has always held me back from working
on things as well.

Even now OCP is being dropped for platform devices.
And birecs is being dropped for OF.
The kernel I am working with is a step behind both of those.

> However, it seems you are talking about passing information to
> the kernel from some bootrom or full featured firmware. That is
> a separate issue from how information is passed from the arch-code
> into drivers (this is what OCP and platform devices accomplish).
> For now, you could define a birec type for xparameters and
> standardize around passing the info in that.  In the future,
> birecs should be replaced by the "flattened OF device tree" method
> that has been discussed here a bit (I know Jon Masters is lurking
> around here, maybe with some code).

A simple fucntion that would take the xparameters.h and create the
birecs/OF data would be a nice way to go.
I would think the func could run on the host to generate a binary
blob that could be attached to the kernel or dropped in flash, for
simple bootloaders.
For a better bootloader it could run the func itself on the target
and put the data in ram, and then fixup the data if needed.

> Even the smallest bootloader rom could put the xparameters.h info in
> a location and point to it using the standard birec method when
> transferring control to the kernel. 

I am a U-boot person myself, but I think there will be a higher number
of users that just stick with the standard loader providied by the vendor
and do the wrapper thing in the kernel.

> I belive this would give Andrew the kind of flexibility he would like.

Yes, I think it would.
