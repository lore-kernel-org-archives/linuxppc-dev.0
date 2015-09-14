Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id E58BD1A2BD6
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 Sep 2015 20:16:54 +1000 (AEST)
Message-ID: <1442225813.21802.3.camel@ellerman.id.au>
Subject: Re: [PATCH] cxl: Fix unbalanced pci_dev_get in cxl_probe
From: Michael Ellerman <mpe@ellerman.id.au>
To: Daniel Axtens <dja@axtens.net>
Cc: linuxppc-dev@ozlabs.org, benh@kernel.crashing.org, mikey@neuling.org,
 imunsie@au.ibm.com, andrew.donnellan@au1.ibm.com
Date: Mon, 14 Sep 2015 20:16:53 +1000
In-Reply-To: <1441781775.7943.27.camel@axtens.net>
References: <1441775845-25870-1-git-send-email-dja@axtens.net>
 <1441781009.7943.22.camel@axtens.net> <1441781775.7943.27.camel@axtens.net>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2015-09-09 at 16:56 +1000, Daniel Axtens wrote:
> Ahaha so I was wrong, device_add does grab a reference. 
> 
> > Currently, cxl_probe(pdev):
> >  1) calls pci_dev_get(pdev)
> >  2) calls cxl_adapter_init
> >     a) init calls cxl_adapter_alloc, which creates a struct cxl, 
> >        conventionally called adapter. This struct contains a 
> >        device entry, adapter->dev.
> > 
> >     b) init calls cxl_configure_adapter, where we set 
> >        adapter->dev.parent = &dev->dev (here dev is the pci dev)
> > 
> > So at this point, the cxl adapter's device's parent is the pci device
> > that I want to be refcounted.
> > 
> >     c) init calls cxl_register_adapter (which inexplicably is in file.c)
> > 
> >        *) cxl_register_adapter calls device_register(&adapter->dev) 
> > 
> > So now we're in device_register, where dev is the adapter device, and we
> > want to know if the PCI device is safe after we return.
> > 
> > device_register(&adapter->dev) calls device_initialize() and then
> > device_add().
> > 
> > device_add() does a get_device(). That ends up being a kobject_get() on
> > the adapter device kobj, which will increment the kref on the adapter
> > device. 
> 
> I was right up to this point, but I didn't read enough of device_add.
> 
> device_add explicitly grabs the device's parent, and calls get_device on
> it:
> 
>          parent = get_device(dev->parent);
> 
> So it turns out we *are* protected against the device disappearing, my
> patch is correct and I don't need a v2.
> 
> Thanks to Ian for making me recheck device_add :)

Thanks for digging into it.

Do you mind massaging that explanation into something I can put into the
changelog?

cheers
