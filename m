Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id B38FCB6EF3
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  6 Jun 2012 15:27:11 +1000 (EST)
Message-ID: <1338960416.7150.160.camel@pasglop>
Subject: Re: [PATCH v2 0/2] Add pcibios_device_change_notifier
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Hiroo Matsumoto <matsumoto.hiroo@jp.fujitsu.com>
Date: Wed, 06 Jun 2012 15:26:56 +1000
In-Reply-To: <4FBC4C86.9050206@jp.fujitsu.com>
References: <4FBC4C86.9050206@jp.fujitsu.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, jbarnes@virtuousgeek.org,
 Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2012-05-23 at 11:33 +0900, Hiroo Matsumoto wrote:
> This patchset is for PCI hotplug.
> 
> 
> pcibios_setup_bus_devices which sets DMA and IRQs of PCI device is called
> only when boot. DMA setting in probe for PCI driver, like dma_set_mask,
> does not work on powerpc platform. So it is need to set DMA and IRQs of
> PCI device when hotplug.
> 
> 1. Moving pcibios_setup_bus_devices code to pcibios_device_change_notifier
>    which is registered to bus notifier in pcibios_init.
> 2. Removing caller and callee of pcibios_setup_bus_devices bus notifier
>    works instead of pcibios_setup_bus_devices.
> 3. Using this bus notifier for microblaze because microblaze/PCI is similer
>    with powerpc/PCI.

This makes me a bit nervous (that doesn't mean it's not right, but
we need some careful auditing & testing here, which I won't be
able to do until I'm back from leave). Mostly due to the change in when
we do the work. 

pcibios_fixup_bus() used to be called early on in the initial scan pass.

Your code causes the code to be called -much- later when registering the
device with the device model. Are we 100% certain nothing will happen in
between that might rely on the stuff being setup already ? It might well
be ok, but I want us to triple check that.

Now, if we are ok to do the setup that late (basically right before the
driver probe() routine gets called), would it make sense to simplify
things even further ... and do it from pcibios_enable_device() ? Thus
avoiding the notifier business completely or is that pushing it too
far ?

Also you seem to add:

+               /* Setup OF node pointer in the device */
+               dev->dev.of_node = pci_device_to_OF_node(dev);

This shouldn't be needed anymore, the device node should be setup by the
core nowadays. Is this just a remnant of you rebasing an old patch or do
you have a good reason to add this statement ?

Cheers,
Ben.
