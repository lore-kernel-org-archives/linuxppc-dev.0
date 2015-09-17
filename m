Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 0621E1A04E5
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Sep 2015 15:13:29 +1000 (AEST)
In-Reply-To: <1442293447-1843-1-git-send-email-dja@axtens.net>
To: Daniel Axtens <dja@axtens.net>, linuxppc-dev@ozlabs.org
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: mikey@neuling.org, imunsie@au1.ibm.com, andrew.donnellan@au1.ibm.com,
 Daniel Axtens <dja@axtens.net>
Subject: Re: [v2] cxl: Fix unbalanced pci_dev_get in cxl_probe
Message-Id: <20150917051328.A67EA140291@ozlabs.org>
Date: Thu, 17 Sep 2015 15:13:28 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2015-15-09 at 05:04:07 UTC, Daniel Axtens wrote:
> Currently the first thing we do in cxl_probe is to grab a reference
> on the pci device. Later on, we call device_register on our adapter.
> In our remove path, we call device_unregister, but we never call
> pci_dev_put. We therefore leak the device every time we do a
> reflash.
> 
> device_register/unregister is sufficient to hold the reference.
> Therefore, drop the call to pci_dev_get.
> 
> Here's why this is safe.
> The proposed cxl_probe(pdev) calls cxl_adapter_init:
>     a) init calls cxl_adapter_alloc, which creates a struct cxl,
>        conventionally called adapter. This struct contains a
>        device entry, adapter->dev.
> 
>     b) init calls cxl_configure_adapter, where we set
>        adapter->dev.parent = &dev->dev (here dev is the pci dev)
> 
> So at this point, the cxl adapter's device's parent is the PCI
> device that I want to be refcounted properly.
> 
>     c) init calls cxl_register_adapter
>        *) cxl_register_adapter calls device_register(&adapter->dev)
> 
> So now we're in device_register, where dev is the adapter device, and
> we want to know if the PCI device is safe after we return.
> 
> device_register(&adapter->dev) calls device_initialize() and then
> device_add().
> 
> device_add() does a get_device(). device_add() also explicitly grabs
> the device's parent, and calls get_device() on it:
> 
>          parent = get_device(dev->parent);
> 
> So therefore, device_register() takes a lock on the parent PCI dev,
> which is what pci_dev_get() was guarding. pci_dev_get() can therefore
> be safely removed.
> 
> Fixes: f204e0b8cedd ("cxl: Driver code for powernv PCIe based cards for userspace access")
> Cc: stable@vger.kernel.org
> Signed-off-by: Daniel Axtens <dja@axtens.net>
> Acked-by: Ian Munsie <imunsie@au1.ibm.com>

Applied to powerpc fixes, thanks.

https://git.kernel.org/powerpc/c/2925c2fdf1e0eb642482f5b3

cheers
