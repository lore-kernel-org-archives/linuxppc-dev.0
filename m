Return-Path: <kaneshige.kenji@jp.fujitsu.com>
Received: from fgwmail6.fujitsu.co.jp (fgwmail6.fujitsu.co.jp [192.51.44.36])
	by ozlabs.org (Postfix) with ESMTP id 30E3EB7D76
	for <linuxppc-dev@ozlabs.org>; Mon, 15 Mar 2010 20:01:06 +1100 (EST)
Received: from m5.gw.fujitsu.co.jp ([10.0.50.75])
	by fgwmail6.fujitsu.co.jp (Fujitsu Gateway) with ESMTP id
	o2F914qM017315 for <linuxppc-dev@ozlabs.org> (envelope-from
	kaneshige.kenji@jp.fujitsu.com); Mon, 15 Mar 2010 18:01:04 +0900
Received: from smail (m5 [127.0.0.1])
	by outgoing.m5.gw.fujitsu.co.jp (Postfix) with ESMTP id E581E45DE55
	for <linuxppc-dev@ozlabs.org>; Mon, 15 Mar 2010 18:01:03 +0900 (JST)
Received: from s5.gw.fujitsu.co.jp (s5.gw.fujitsu.co.jp [10.0.50.95])
	by m5.gw.fujitsu.co.jp (Postfix) with ESMTP id B71F645DE51
	for <linuxppc-dev@ozlabs.org>; Mon, 15 Mar 2010 18:01:03 +0900 (JST)
Received: from s5.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
	by s5.gw.fujitsu.co.jp (Postfix) with ESMTP id 943D9E18002
	for <linuxppc-dev@ozlabs.org>; Mon, 15 Mar 2010 18:01:03 +0900 (JST)
Received: from m105.s.css.fujitsu.com (m105.s.css.fujitsu.com [10.249.87.105])
	by s5.gw.fujitsu.co.jp (Postfix) with ESMTP id 3854F1DB803F
	for <linuxppc-dev@ozlabs.org>; Mon, 15 Mar 2010 18:01:03 +0900 (JST)
Message-ID: <4B9DF72F.3040105@jp.fujitsu.com>
Date: Mon, 15 Mar 2010 18:00:31 +0900
From: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
MIME-Version: 1.0
To: Felix Radensky <felix@embedded-sol.com>
Subject: Re: Problem with PCI bus rescan on 460EX
References: <4B8E6FA3.70503@embedded-sol.com>	<20100310225100.GB27324@ldl.fc.hp.com>	<4B98A0CB.8090103@embedded-sol.com>	<4B9A07D2.4060801@jp.fujitsu.com>	<4B9AC885.3010107@embedded-sol.com>
	<4B9DC820.2060100@jp.fujitsu.com>
	<4B9DCF01.4050709@embedded-sol.com>
In-Reply-To: <4B9DCF01.4050709@embedded-sol.com>
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

Felix Radensky wrote:
> Hello Kenji-san,
> 
> Kenji Kaneshige wrote:
>> Felix Radensky wrote:
>>> Hello Kenji-san,
>>>
>>> Kenji Kaneshige wrote:
>>>> I'm not sure, but I guess pci_setup_bridge() didn't update IO 
>>>> base/limit
>>>> and Mem base/limit of the bridge (0000:00:02.0) because of the 
>>>> following
>>>> lines.
>>>>
>>>> static void pci_setup_bridge(struct pci_bus *bus)
>>>> {
>>>>        struct pci_dev *bridge = bus->self;
>>>>        struct resource *res;
>>>>        struct pci_bus_region region;
>>>>        u32 l, bu, lu, io_upper16;
>>>>
>>>>        if (pci_is_enabled(bridge))    
>>>> <===============================                              
>>>> return;            <===============================
>>>>
>>>>        dev_info(&bridge->dev, "PCI bridge to [bus %02x-%02x]\n",
>>>>                 bus->secondary, bus->subordinate);
>>>>     ...
>>>>
>>>> It seems the bridge was already enabled by 
>>>> pci_assign_unassigned_resources()
>>>> at boot time. Does removing those lines make any change?
>>>>
>>>
>>> Yes, with these lines removed bridge memory window is properly 
>>> allocated.
>>
>> These lines are to prevent updating IO or memory windows when there are
>> some devices working behind the bridge. So please note that removing
>> these lines is just for debugging.
>>
>>
>>> For some reason bridge memory is disabled, but if I enable it via 
>>> setpci, and
>>> also enable device memory, then everything works fine. If the system 
>>> is booted
>>> when device behind the bridge is plugged in, bridge memory is enabled.
>>>
>>
>> Maybe because of the following lines, I guess.
>>
>> void pci_enable_bridges(struct pci_bus *bus)
>> {
>>        struct pci_dev *dev;
>>        int retval;
>>
>>        list_for_each_entry(dev, &bus->devices, bus_list) {
>>                if (dev->subordinate) {
>>                        if (!pci_is_enabled(dev)) {        <=======
>>                                retval = pci_enable_device(dev);<=======
>>                                pci_set_master(dev);        <=======
>>                        }
>>         ...
>>
>>
> 
> Yes, but removing this check is not enough. The bridge is enabled after 
> first scan, but it's
> memory is disabled. So simply calling  pci_enable_device() will not 
> help, it will return without
> enabling memory. I had to call  pci_disable_device() before 
> pci_enable_device() to make things
> work.
>> One possible cause is that pcibios_enable_device() for the bridge didn't
>> return any error even though it didn't work properly (ex. cannot access
>> to the command register, and so on) on your platform when there is no
>> device behind the bridge. But it is just my guess.
> Should pcibios_enable_device() return an error if it fails to enable 
> bridge memory ?
> 

I think the device is expected to be ready to work if pci_enable_device()
returns without error. So I think pci_enable_device() should return an
error if it fails to enable the device (device is not ready to work). In
this case, detecting your bridge's failure seems PPC specific to me. So I
thought pcibios_enable_device() was the right to return an error. If
pcibios_enable_device() returned an error, pci_dev->enable_cnt would
decremented by pci_enable_device() (like pci_disable_device() does) and
this problem would not happen.

On the other hand, as Ben suggested, handling this by specific hot-plug
driver would be one of the other candidate to fix the problem.

Thanks,
Kenji Kaneshige
