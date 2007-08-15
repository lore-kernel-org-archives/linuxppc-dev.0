Return-Path: <glikely@secretlab.ca>
Received: from nz-out-0506.google.com (nz-out-0506.google.com [64.233.162.239])
	by ozlabs.org (Postfix) with ESMTP id 17D8CDDE36
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 16 Aug 2007 00:04:02 +1000 (EST)
Received: by nz-out-0506.google.com with SMTP id l1so771908nzf
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 15 Aug 2007 07:04:01 -0700 (PDT)
Message-ID: <fa686aa40708150703h375cc250uc9ec447574c91d1d@mail.gmail.com>
Date: Wed, 15 Aug 2007 08:03:57 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Stephen Neuendorffer" <stephen.neuendorffer@xilinx.com>
Subject: Re: Device Tree tool [was RE: [PATCH] Consolidate
	XILINX_VIRTEXboardsupport]
In-Reply-To: <20070814215438.3C7AA1B7006C@mail148-cpk.bigfish.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20070810153619.0471D190055@mail15-fra.bigfish.com>
	<20070814215438.3C7AA1B7006C@mail148-cpk.bigfish.com>
Cc: microblaze-uclinux@itee.uq.edu.au, linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On 8/14/07, Stephen Neuendorffer <stephen.neuendorffer@xilinx.com> wrote:
>
> > BTW: I'm currently hacking away to see if I can get a
> > microblaze system
> > booting
> > using a flat device tree...  I haven't decided if it's worth it to go
> > that
> > route in the end yet, but...
> >
> > Steve
>
> I've managed to get the first step working: a microblaze system
> advertising of_devices in 2.6 using a flat device tree.  The next task
> is to
> reimplement probe() for a driver or two (probably the xilinx_emac driver
> first).   My plan is to have the driver advertise both through
> of_platform_bus, and
> through the regular platform bus, and have a config option that either
> advertises
> the devices through of and links in the device tree, or using the
> exising
> platform_device mechanism.

That's fantastic.  Yes, I think that is the right approach to have
both platform_bus and of_platform bus bindings in the drivers.

>
> Grant:  Does this make sense (in terms of dealing with drivers) with
> your plans for
> moving Virtex platforms to arch/powerpc?  I'd like to avoid duplicating
> work on the
> drivers, if possible.

Absolutely

>
> Is there a concensus on how microblaze systems should get booted?
> Currently,
> I'm linking the device tree directly into the kernel itself, loading the
> whole
> mess using SystemAce and the start address jumps directly into the
> kernel, which
> is quite a bit different than the way powerpc works.  It's certainly
> simpler:
> maybe too simple.  At the same time, replicating
> the complexity of arch/powerpc with separate boot code may or may not be
> worth it...
> Any thoughts?

It is a good starting point, and I think it is important that this
remain an option (ie. for boards without a bootloader).  However, it
is a really good idea to support the notion of passing in a device
tree from a bootloader (u-boot).  As Michal mentioned, u-boot already
has the code to support this, and u-boot is able to update the device
tree directly.  The key feature here is being able to support multiple
FPGA designs from a single kernel image because the device tree gives
us some level of abstraction on the hardware design.

Cheers,
g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
