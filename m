Return-Path: <B04825@freescale.com>
Received: from VA3EHSOBE003.bigfish.com (va3ehsobe003.messaging.microsoft.com
	[216.32.180.13]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Cybertrust SureServer Standard Validation CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 3FFDAB6F9F
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri,  3 Jun 2011 07:28:57 +1000 (EST)
Message-ID: <4DE8008E.9030008@freescale.com>
Date: Thu, 2 Jun 2011 16:28:46 -0500
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 7/7] [v2] drivers/misc: introduce Freescale hypervisor
	management driver
References: <1306953337-15698-1-git-send-email-timur@freescale.com>
	<201106012340.14237.arnd@arndb.de>
In-Reply-To: <201106012340.14237.arnd@arndb.de>
Content-Type: text/plain; charset="ISO-8859-1"
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

Arnd Bergmann wrote:
> I think drivers/misc is not the right place for this, but I'm not completely
> sure what is. drivers/firmware would be better at least, but virt/fsl might
> also be ok.

I don't think it's correct to think of a hypervisor as firmware, so I don't
think drivers/firmware is better.

I'm not sure that creating virt/fsl and putting the driver in there is a good
idea, because it will be the only driver in that directory.  Unlike KVM, this
driver is just a collection of front-ends to our hypervisor API.  The actual
hypervisor is completely separate.  That's why I put it in drivers/misc, because
it's just a single driver with a miscellaneous collection of interfaces.

We also don't want to have any Kconfig options that "turn on" hypervisor
support.  I've intentionally made support for the hypervisor part of the normal
platform code, and the device tree is used to determine whether that code is
active or not.

So virt/fsl seems like overkill to me.

> I'm not convinced that an ioctl interface is the right way to work with
> device tree properties. A more natural way would be to export it as
> a file system, or maybe as a flattened device tree blob (the latter option
> would require changing the hypervisor interface, which might not be
> possible).

As Scott said, this is just a front-end to the hypervisor API, and we already
have applications that depend on the ioctl interface.  Considering that this
driver is specific to the Freescale hypervisor, so I don't see any harm in using
ioctls.

> For an ioctl, please follow the normal pattern of defining a separate
> structure for each case, no union.

Ok.  This will break our existing applications, but it's a minor fix.

-- 
Timur Tabi
Linux kernel developer at Freescale
