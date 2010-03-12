Return-Path: <kaneshige.kenji@jp.fujitsu.com>
Received: from fgwmail8.fujitsu.co.jp (fgwmail8.fujitsu.co.jp [192.51.44.38])
	by ozlabs.org (Postfix) with ESMTP id 844AFB7D11
	for <linuxppc-dev@ozlabs.org>; Fri, 12 Mar 2010 20:31:40 +1100 (EST)
Received: from fgwmail6.fujitsu.co.jp (fgwmail6.fujitsu.co.jp [192.51.44.36])
	by fgwmail8.fujitsu.co.jp (Fujitsu Gateway) with ESMTP id
	o2C9N4KN028190 for <linuxppc-dev@ozlabs.org> (envelope-from
	kaneshige.kenji@jp.fujitsu.com); Fri, 12 Mar 2010 18:23:04 +0900
Received: from m6.gw.fujitsu.co.jp ([10.0.50.76])
	by fgwmail6.fujitsu.co.jp (Fujitsu Gateway) with ESMTP id
	o2C9N1jZ025445 for <linuxppc-dev@ozlabs.org> (envelope-from
	kaneshige.kenji@jp.fujitsu.com); Fri, 12 Mar 2010 18:23:02 +0900
Received: from smail (m6 [127.0.0.1])
	by outgoing.m6.gw.fujitsu.co.jp (Postfix) with ESMTP id 4299345DE53
	for <linuxppc-dev@ozlabs.org>; Fri, 12 Mar 2010 18:23:01 +0900 (JST)
Received: from s6.gw.fujitsu.co.jp (s6.gw.fujitsu.co.jp [10.0.50.96])
	by m6.gw.fujitsu.co.jp (Postfix) with ESMTP id 226E745DE4C
	for <linuxppc-dev@ozlabs.org>; Fri, 12 Mar 2010 18:23:01 +0900 (JST)
Received: from s6.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
	by s6.gw.fujitsu.co.jp (Postfix) with ESMTP id 018A31DB8017
	for <linuxppc-dev@ozlabs.org>; Fri, 12 Mar 2010 18:23:01 +0900 (JST)
Received: from m106.s.css.fujitsu.com (m106.s.css.fujitsu.com [10.249.87.106])
	by s6.gw.fujitsu.co.jp (Postfix) with ESMTP id A22B9E08004
	for <linuxppc-dev@ozlabs.org>; Fri, 12 Mar 2010 18:23:00 +0900 (JST)
Message-ID: <4B9A07D2.4060801@jp.fujitsu.com>
Date: Fri, 12 Mar 2010 18:22:26 +0900
From: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
MIME-Version: 1.0
To: Felix Radensky <felix@embedded-sol.com>
Subject: Re: Problem with PCI bus rescan on 460EX
References: <4B8E6FA3.70503@embedded-sol.com>
	<20100310225100.GB27324@ldl.fc.hp.com>
	<4B98A0CB.8090103@embedded-sol.com>
In-Reply-To: <4B98A0CB.8090103@embedded-sol.com>
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

I'm not sure, but I guess pci_setup_bridge() didn't update IO base/limit
and Mem base/limit of the bridge (0000:00:02.0) because of the following
lines.

static void pci_setup_bridge(struct pci_bus *bus)
{
        struct pci_dev *bridge = bus->self;
        struct resource *res;
        struct pci_bus_region region;
        u32 l, bu, lu, io_upper16;

        if (pci_is_enabled(bridge))	<===============================				
                return;			<===============================

        dev_info(&bridge->dev, "PCI bridge to [bus %02x-%02x]\n",
                 bus->secondary, bus->subordinate);
	...

It seems the bridge was already enabled by pci_assign_unassigned_resources()
at boot time. Does removing those lines make any change?

Thanks,
Kenji Kaneshige




Felix Radensky wrote:
> Hi Alex,
> 
> Resending, previous attempt was erroneously send as HTML.
> 
> Thanks a lot for replying.
> 
> Alex Chiang wrote:
>> * Felix Radensky <felix@embedded-sol.com>:
>>  
>>> The problem arises when device is plugged in after boot. After doing
>>> echo 1 > /sys/bus/pci/rescan
>>> the device is identified, but bridge memory window is not allocated,
>>> and reads from device memory regions return 0xffffffff. Below is
>>> relevant output:
>>>     
>>
>> Do you need firmware support on your platform for hotplug?
>>   
> I don't think so, but I've added powerpc guys to CC to make sure.
>> Can you please send full dmesg during successful boot, full dmesg
>> log during unsuccessful rescan, and contents of /proc/iomem and
>> /proc/ioports during success and failure cases?
>>
>> Be sure you have PCI_CONFIG_DEBUG turned on.
>>   
> Attached. I really appreciate your help. Thanks a lot.
> 
> Felix.
> 
