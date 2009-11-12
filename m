Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id D241EB6F1E
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 12 Nov 2009 20:32:49 +1100 (EST)
Subject: Re: Disable Caching for mmap() address
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Jonathan Haws <Jonathan.Haws@sdl.usu.edu>
In-Reply-To: <BB99A6BA28709744BF22A68E6D7EB51F03310B03B4@midas.usurf.usu.edu>
References: <BB99A6BA28709744BF22A68E6D7EB51F03310B03B4@midas.usurf.usu.edu>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 12 Nov 2009 20:32:43 +1100
Message-ID: <1258018363.2140.333.camel@pasglop>
Mime-Version: 1.0
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2009-11-09 at 16:21 -0700, Jonathan Haws wrote:
> All,
> 
> I would like to disable caching for an address that was returned from a call to mmap().  I am using this address for DMA operations in user space and want to make sure that the data cache is turned off for that buffer.
> 
> The way this works is the driver simply takes an address I provide and begins a DMA operation to that location in RAM (I have ensured that this is a physical address I am passing already).  When the DMA is complete, an interrupt fires and the ISR gives a semaphore that the user space application is pending on (RT_SEM from Xenomai).  I have tried simply calling a cache invalidate routine in the ISR before I give the semaphore, but the kernel crashes when I try to call that routine - my guess it because the kernel does not have direct access to that location in memory (only my application does, according to the MMU).
> 
> Anyway, all I want to do is make sure that the buffer is never stored in the cache and that I always fetch it from RAM.  How can I specify that using mmap() on the /dev/mem device, or is there a better way to accomplish this?

There is no "proper" way to do this, in large part because it's not
always legal to map memory non-cached for various reasons I don't
have time to explain right now...

You may be able to get it working though but using a specific driver
with an mmap function that tweaks the attributes or using mmap
of /dev/mem after opening it with O_SYNC (off the top of my mind)

But it's a bit fishy as the kernel has a cacheable mapping of most
of memory and so you may end up with cache aliases...

Cheers,
Ben.
