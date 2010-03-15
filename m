Return-Path: <felix@embedded-sol.com>
Received: from vega.surpasshosting.com (vega.surpasshosting.com [72.29.83.9])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id A43EBB7D8E
	for <linuxppc-dev@ozlabs.org>; Mon, 15 Mar 2010 17:09:02 +1100 (EST)
Message-ID: <4B9DCF01.4050709@embedded-sol.com>
Date: Mon, 15 Mar 2010 08:09:05 +0200
From: Felix Radensky <felix@embedded-sol.com>
MIME-Version: 1.0
To: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
Subject: Re: Problem with PCI bus rescan on 460EX
References: <4B8E6FA3.70503@embedded-sol.com>	<20100310225100.GB27324@ldl.fc.hp.com>	<4B98A0CB.8090103@embedded-sol.com>	<4B9A07D2.4060801@jp.fujitsu.com>	<4B9AC885.3010107@embedded-sol.com>
	<4B9DC820.2060100@jp.fujitsu.com>
In-Reply-To: <4B9DC820.2060100@jp.fujitsu.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linux-pci@vger.kernel.org, Alex Chiang <achiang@hp.com>,
	"linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello Kenji-san,

Kenji Kaneshige wrote:
> Felix Radensky wrote:
>> Hello Kenji-san,
>>
>> Kenji Kaneshige wrote:
>>> I'm not sure, but I guess pci_setup_bridge() didn't update IO 
>>> base/limit
>>> and Mem base/limit of the bridge (0000:00:02.0) because of the 
>>> following
>>> lines.
>>>
>>> static void pci_setup_bridge(struct pci_bus *bus)
>>> {
>>>        struct pci_dev *bridge = bus->self;
>>>        struct resource *res;
>>>        struct pci_bus_region region;
>>>        u32 l, bu, lu, io_upper16;
>>>
>>>        if (pci_is_enabled(bridge))    
>>> <===============================                              
>>> return;            <===============================
>>>
>>>        dev_info(&bridge->dev, "PCI bridge to [bus %02x-%02x]\n",
>>>                 bus->secondary, bus->subordinate);
>>>     ...
>>>
>>> It seems the bridge was already enabled by 
>>> pci_assign_unassigned_resources()
>>> at boot time. Does removing those lines make any change?
>>>
>>
>> Yes, with these lines removed bridge memory window is properly 
>> allocated.
>
> These lines are to prevent updating IO or memory windows when there are
> some devices working behind the bridge. So please note that removing
> these lines is just for debugging.
>
>
>> For some reason bridge memory is disabled, but if I enable it via 
>> setpci, and
>> also enable device memory, then everything works fine. If the system 
>> is booted
>> when device behind the bridge is plugged in, bridge memory is enabled.
>>
>
> Maybe because of the following lines, I guess.
>
> void pci_enable_bridges(struct pci_bus *bus)
> {
>        struct pci_dev *dev;
>        int retval;
>
>        list_for_each_entry(dev, &bus->devices, bus_list) {
>                if (dev->subordinate) {
>                        if (!pci_is_enabled(dev)) {        <=======
>                                retval = pci_enable_device(dev);<=======
>                                pci_set_master(dev);        <=======
>                        }
>         ...
>
>

Yes, but removing this check is not enough. The bridge is enabled after 
first scan, but it's
memory is disabled. So simply calling  pci_enable_device() will not 
help, it will return without
enabling memory. I had to call  pci_disable_device() before 
pci_enable_device() to make things
work.
> One possible cause is that pcibios_enable_device() for the bridge didn't
> return any error even though it didn't work properly (ex. cannot access
> to the command register, and so on) on your platform when there is no
> device behind the bridge. But it is just my guess.
Should pcibios_enable_device() return an error if it fails to enable 
bridge memory ?

Thanks.

Felix.
