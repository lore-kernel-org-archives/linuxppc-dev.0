Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de [212.227.17.8])
	by ozlabs.org (Postfix) with ESMTP id A5CDBB6FAA
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat,  4 Jun 2011 01:24:54 +1000 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH 7/7] [v2] drivers/misc: introduce Freescale hypervisor
	management driver
Date: Fri, 3 Jun 2011 17:24:44 +0200
References: <1306953337-15698-1-git-send-email-timur@freescale.com>
	<201106012340.14237.arnd@arndb.de> <4DE8008E.9030008@freescale.com>
In-Reply-To: <4DE8008E.9030008@freescale.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Message-Id: <201106031724.44957.arnd@arndb.de>
Cc: kumar.gala@freescale.com, linux-kernel@vger.kernel.org, akpm@kernel.org,
	linux-console@vger.kernel.org, greg@kroah.com,
	linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thursday 02 June 2011, Timur Tabi wrote:
> Arnd Bergmann wrote:
> > I think drivers/misc is not the right place for this, but I'm not completely
> > sure what is. drivers/firmware would be better at least, but virt/fsl might
> > also be ok.
> 
> I don't think it's correct to think of a hypervisor as firmware, so I don't
> think drivers/firmware is better.
> 
> I'm not sure that creating virt/fsl and putting the driver in there is a good
> idea, because it will be the only driver in that directory.  Unlike KVM, this
> driver is just a collection of front-ends to our hypervisor API.  The actual
> hypervisor is completely separate.  That's why I put it in drivers/misc, because
> it's just a single driver with a miscellaneous collection of interfaces.

Ok, fair enough. If nobody has a strong preference any other way, just make it
drivers/firmware then.

> We also don't want to have any Kconfig options that "turn on" hypervisor
> support.  I've intentionally made support for the hypervisor part of the normal
> platform code, and the device tree is used to determine whether that code is
> active or not.
> 
> So virt/fsl seems like overkill to me.

Ok. Obviously, you still have the option to move the code later if you require
more interfaces to talk to your hypervisor, and then you can still add virt/fsl,
so no problem.

> > I'm not convinced that an ioctl interface is the right way to work with
> > device tree properties. A more natural way would be to export it as
> > a file system, or maybe as a flattened device tree blob (the latter option
> > would require changing the hypervisor interface, which might not be
> > possible).
> 
> As Scott said, this is just a front-end to the hypervisor API, and we already
> have applications that depend on the ioctl interface.  Considering that this
> driver is specific to the Freescale hypervisor, so I don't see any harm in using
> ioctls.

Good interface design is always important, one of the reasons is serving as
an example for other people doing similar drivers. There are a lot of
companies writing hypervisors and they all need interfaces like this.

> > For an ioctl, please follow the normal pattern of defining a separate
> > structure for each case, no union.
> 
> Ok.  This will break our existing applications, but it's a minor fix.

Ok. Better to break it now than accidentally break it later because of
some side-effect of a strange interface, e.g. when the union would change in
size.

	Arnd
