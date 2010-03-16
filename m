Return-Path: <kaneshige.kenji@jp.fujitsu.com>
Received: from fgwmail5.fujitsu.co.jp (fgwmail5.fujitsu.co.jp [192.51.44.35])
	by ozlabs.org (Postfix) with ESMTP id AAE49B7D7E
	for <linuxppc-dev@ozlabs.org>; Tue, 16 Mar 2010 16:41:29 +1100 (EST)
Received: from m6.gw.fujitsu.co.jp ([10.0.50.76])
	by fgwmail5.fujitsu.co.jp (Fujitsu Gateway) with ESMTP id
	o2G5fRJq025397 for <linuxppc-dev@ozlabs.org> (envelope-from
	kaneshige.kenji@jp.fujitsu.com); Tue, 16 Mar 2010 14:41:28 +0900
Received: from smail (m6 [127.0.0.1])
	by outgoing.m6.gw.fujitsu.co.jp (Postfix) with ESMTP id B8DCB45DE50
	for <linuxppc-dev@ozlabs.org>; Tue, 16 Mar 2010 14:41:27 +0900 (JST)
Received: from s6.gw.fujitsu.co.jp (s6.gw.fujitsu.co.jp [10.0.50.96])
	by m6.gw.fujitsu.co.jp (Postfix) with ESMTP id 9C40445DE4F
	for <linuxppc-dev@ozlabs.org>; Tue, 16 Mar 2010 14:41:27 +0900 (JST)
Received: from s6.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
	by s6.gw.fujitsu.co.jp (Postfix) with ESMTP id 730AF1DB8016
	for <linuxppc-dev@ozlabs.org>; Tue, 16 Mar 2010 14:41:27 +0900 (JST)
Received: from m107.s.css.fujitsu.com (m107.s.css.fujitsu.com [10.249.87.107])
	by s6.gw.fujitsu.co.jp (Postfix) with ESMTP id 0AE991DB8012
	for <linuxppc-dev@ozlabs.org>; Tue, 16 Mar 2010 14:41:27 +0900 (JST)
Message-ID: <4B9F19E2.2090709@jp.fujitsu.com>
Date: Tue, 16 Mar 2010 14:40:50 +0900
From: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
MIME-Version: 1.0
To: Felix Radensky <felix@embedded-sol.com>
Subject: Re: Problem with PCI bus rescan on 460EX
References: <4B8E6FA3.70503@embedded-sol.com>	<20100310225100.GB27324@ldl.fc.hp.com>	<4B98A0CB.8090103@embedded-sol.com>	<4B9A07D2.4060801@jp.fujitsu.com>	<4B9AC885.3010107@embedded-sol.com>
	<4B9DC820.2060100@jp.fujitsu.com>
	<4B9DCF01.4050709@embedded-sol.com>
	<4B9DF72F.3040105@jp.fujitsu.com>
	<4B9E18A7.2080605@embedded-sol.com>
In-Reply-To: <4B9E18A7.2080605@embedded-sol.com>
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
> Hello, Kenji-san
>>
>> I think the device is expected to be ready to work if pci_enable_device()
>> returns without error. So I think pci_enable_device() should return an
>> error if it fails to enable the device (device is not ready to work). In
>> this case, detecting your bridge's failure seems PPC specific to me. So I
>> thought pcibios_enable_device() was the right to return an error. If
>> pcibios_enable_device() returned an error, pci_dev->enable_cnt would
>> decremented by pci_enable_device() (like pci_disable_device() does) and
>> this problem would not happen.
>>   
> 
> As far as I can see on 460EX pcibios_enable_device() just calls 
> pci_enable_resources()
> which does not return any error for my bridge, although it doesn't find 
> any memory or
> I/O resource it can enable. Do you think it is correct behavior ?
> 
> Another question is whether by bridge behaves correctly when no device 
> is connected
> to it. As you can see in dmesg output I've sent earlier
> 
> pci 0000:00:02.0:   bridge window [mem 0x00000000-0x000fffff]
> pci 0000:00:02.0:   bridge window [mem 0x00000000-0x000fffff 64bit pref]
> 
> and later PCI code disables these memory windows
> 
> pci 0000:00:02.0: disabling bridge window [mem 0xd00000000-0xd000fffff 
> pref] to [bus 01-01] (unused)
> pci 0000:00:02.0: disabling bridge window [mem 0xd00000000-0xd000fffff] 
> to [bus 01-01] (unused)
> 

I misunderstood the problem.
My understanding was memory resource was not enabled even though Linux set
the Memory Space bit in the command register. But it was not correct. The
bridge memory window was marked unused and Linux didn't try to set Memory
Space bit in the command register. Current my understanding is as follows.
Please correct me if I'm still misunderstanding something.

1) Your BIOS doesn't assign any resource to the bridge if its child PCI
   hot-plug slot is not occupied.

2) At the boot time, pci_assign_unassigned_resources() try to assign
   memory resouces to the bridge using pci_bus_assign_resource(), but
   it was disabled because there are no devices require memory resource.

3) And then pci_assign_unassigned_resouces() calls pci_enable_bridge(),
   but Memory Space bit in the command register was not set because no
   memory resource are assigned to the bridge. At the same time,
   pci_dev->enable_cnt was incremented.

4) At the rescan time, pci_setup_bridge() and pci_enable_bridge() doesn't
   work because the bridge is already marked "enabled" (i.e.
   pci_dev->enable_cnt is not zero).

I don't have any concrete idea how to fix that so far, but I can say my idea
(pcibios_enable_device() should return an error) was wrong.

BTW, on my PCI hotplug capable system (SHPC and PCIe), I/O and Memory windows
of the bridge are assigned by BIOS regardless of whether hotplug slot(s)
behind the bridge is occupied or not. Maybe that is the reason why I have
never encountered this problem before.

Thanks,
Kenji Kaneshige



> BTW, there's no problem accessing PCI_COMMAND register, as bus mastering 
> is enabled in the bridge.
> 
>>
>> On the other hand, as Ben suggested, handling this by specific hot-plug
>> driver would be one of the other candidate to fix the problem.
>>
>>
> 
> I'm not opposed to this idea, it's just that this bridge worked in an older
> system based on linux-2.6.22 and patched fakephp driver was used for 
> hotplug.
> There's existing userspace software that I don't really want to modify 
> heavily.
> But I'll do that if generic PCI rescan cannot be fixed.
> 
> Thanks a lot for your help.
> 
> Felix.
> -- 
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
