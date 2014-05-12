Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 041F21400AB
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 May 2014 12:59:40 +1000 (EST)
Message-ID: <1399863559.17624.66.camel@pasglop>
Subject: Re: [PATCH] powerpc: reduce multi-hit of pcibios_setup_device() in
 hotplug
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Wei Yang <weiyang@linux.vnet.ibm.com>
Date: Mon, 12 May 2014 12:59:19 +1000
In-Reply-To: <1399530602-4231-1-git-send-email-weiyang@linux.vnet.ibm.com>
References: <1399530602-4231-1-git-send-email-weiyang@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Bjorn Helgaas <bhelgaas@google.com>, linuxppc-dev@lists.ozlabs.org,
 aik@au1.ibm.com, gwshan@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2014-05-08 at 14:30 +0800, Wei Yang wrote:
> During the EEH hotplug event, pcibios_setup_device() will be invoked two
> times. And the last time will trigger a warning of re-attachment of iommu
> group.
> 
> The two times are:
> 
>     pci_device_add
>         ...
>         pcibios_add_device
>         pcibios_setup_device   <- 1st time
>     pcibios_add_pci_devices
>         ...
>         pcibios_setup_bus_devices
>         pcibios_setup_device   <- 2rd time
> 
> As we see, in pcibios_add_pci_devices() the pci_bus passed in as a parameter
> is initialized and already added in the system. Which means the
> pcibios_setup_device() in pcibios_add_device() will be called. Then the
> pcibios_setup_device() in pcibios_setup_bus_devices() is the 2nd time to be
> called on the same pci_dev.

(CC'ing Bjorn to make sure I get the mess right :-)

So the patch makes me a bit nervous because we have convoluted
dependencies on some of that in the actual PCI hotplug code (the
real thing which rescans busses etc...).

I *think* the patch might be right (though incomplete) on those
grounds, but I'd like you to verify and test the various hotplug
cases in pHyp and I think issue comes from pcibios_add_device() being
somewhat a late addition.

Basically, what happens I think is at boot time:

 - bus->is_added is false, dev->is_added is false during initial probe
   of a given device. So pcibios_add_device() does nothing.

 - shortly afterward, the core calls pcibios_fixup_bus(), still with
bus->is_added set to false, which *will* do the setup because
dev->is_added is also false for all devices.

 - we set bus->is_added

 - we call pci_bus_add_devices() which sets all the dev->is_added

So far so good. Now, when we hotplug something (and there are some
distinction here depending on what hotplug path we take which is why I'd
like you to scrutinize things a bit more), we mostly hit powerpc's
pcibios_add_pci_devices().

Now this function will operate differently on a "devtree" style probe
(phyp/kvm guest) vs. a "normal" probe (other bare metal machines).

The normal case is what you are trying to fix here. It does an explicit
pcibios_setup_bus_devices() on the bus being rescanned. I think you are
right this isn't necessary. This bus has bus->is_added set to true and
thus pcibios_add_device() will do the setup for any new devices. 

That makes me think that we need a similar fix in pci_of_scan.c for
when we call of_rescan_bus(). The fix would be probably in
__of_scan_bus(), to move the call to pcibios_setup_bus_devices() inside
the if (!rescan_existing) statement, since if we are scanning an
existing bus (which thus has bus->is_added set), we know
pcibios_add_devices() will have done the updates.

In fact I wonder if we could just use bus->is_added for the test in
there and get rid of the "rescan_existing" argument completely. Worth
adding something like WARN_ON(rescan_existing != bus->is_added); and
do a few tests of hotplug to see what it looks like.

Now there are two different hotplug path at least in the pseries code,
so have a look make sure we aren't missing anything here and please test
all cases !

Cheers,
Ben.
