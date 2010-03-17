Return-Path: <kaneshige.kenji@jp.fujitsu.com>
Received: from fgwmail7.fujitsu.co.jp (fgwmail7.fujitsu.co.jp [192.51.44.37])
	by ozlabs.org (Postfix) with ESMTP id B1D83B7D4E
	for <linuxppc-dev@ozlabs.org>; Wed, 17 Mar 2010 12:03:47 +1100 (EST)
Received: from m5.gw.fujitsu.co.jp ([10.0.50.75])
	by fgwmail7.fujitsu.co.jp (Fujitsu Gateway) with ESMTP id
	o2H13jW0025136 for <linuxppc-dev@ozlabs.org> (envelope-from
	kaneshige.kenji@jp.fujitsu.com); Wed, 17 Mar 2010 10:03:45 +0900
Received: from smail (m5 [127.0.0.1])
	by outgoing.m5.gw.fujitsu.co.jp (Postfix) with ESMTP id 5102745DE54
	for <linuxppc-dev@ozlabs.org>; Wed, 17 Mar 2010 10:03:45 +0900 (JST)
Received: from s5.gw.fujitsu.co.jp (s5.gw.fujitsu.co.jp [10.0.50.95])
	by m5.gw.fujitsu.co.jp (Postfix) with ESMTP id 1930745DE4F
	for <linuxppc-dev@ozlabs.org>; Wed, 17 Mar 2010 10:03:45 +0900 (JST)
Received: from s5.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
	by s5.gw.fujitsu.co.jp (Postfix) with ESMTP id EA84FE18009
	for <linuxppc-dev@ozlabs.org>; Wed, 17 Mar 2010 10:03:44 +0900 (JST)
Received: from m105.s.css.fujitsu.com (m105.s.css.fujitsu.com [10.249.87.105])
	by s5.gw.fujitsu.co.jp (Postfix) with ESMTP id A1729E18004
	for <linuxppc-dev@ozlabs.org>; Wed, 17 Mar 2010 10:03:44 +0900 (JST)
Message-ID: <4BA02A49.9050101@jp.fujitsu.com>
Date: Wed, 17 Mar 2010 10:03:05 +0900
From: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
MIME-Version: 1.0
To: Felix Radensky <felix@embedded-sol.com>
Subject: Re: Problem with PCI bus rescan on 460EX
References: <4B8E6FA3.70503@embedded-sol.com>	<20100310225100.GB27324@ldl.fc.hp.com>	<4B98A0CB.8090103@embedded-sol.com>	<4B9A07D2.4060801@jp.fujitsu.com>	<4B9AC885.3010107@embedded-sol.com>
	<4B9DC820.2060100@jp.fujitsu.com>
	<4B9DCF01.4050709@embedded-sol.com>
	<4B9DF72F.3040105@jp.fujitsu.com>
	<4B9E18A7.2080605@embedded-sol.com>
	<4B9F19E2.2090709@jp.fujitsu.com>
	<4B9FFAD1.8030309@embedded-sol.com>
In-Reply-To: <4B9FFAD1.8030309@embedded-sol.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linux-pci@vger.kernel.org, yinghai@kernel.org, Alex Chiang <achiang@hp.com>,
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
> 
> Kenji Kaneshige wrote:
>>
>> I misunderstood the problem.
>> My understanding was memory resource was not enabled even though Linux 
>> set
>> the Memory Space bit in the command register. But it was not correct. The
>> bridge memory window was marked unused and Linux didn't try to set Memory
>> Space bit in the command register. Current my understanding is as 
>> follows.
>> Please correct me if I'm still misunderstanding something.
>>
>> 1) Your BIOS doesn't assign any resource to the bridge if its child PCI
>>   hot-plug slot is not occupied.
>>
>> 2) At the boot time, pci_assign_unassigned_resources() try to assign
>>   memory resouces to the bridge using pci_bus_assign_resource(), but
>>   it was disabled because there are no devices require memory resource.
>>
>> 3) And then pci_assign_unassigned_resouces() calls pci_enable_bridge(),
>>   but Memory Space bit in the command register was not set because no
>>   memory resource are assigned to the bridge. At the same time,
>>   pci_dev->enable_cnt was incremented.
>>
>> 4) At the rescan time, pci_setup_bridge() and pci_enable_bridge() doesn't
>>   work because the bridge is already marked "enabled" (i.e.
>>   pci_dev->enable_cnt is not zero).
>>
>> I don't have any concrete idea how to fix that so far, but I can say 
>> my idea
>> (pcibios_enable_device() should return an error) was wrong.
>>
>>
> I was wandering if setting is_hotplug_bridge property for this bridge 
> (e.g. via
> header quirk) can be an acceptable solution. This will allow passing 
> hpmemsize
> kernel parameter, to specify the amount of memory to assign to the bridge.
> I've tested this approach and it seems to work.

Looks good to me.

By the way, I think Yinghai's bridge resource reallocation patch series
might help you. It is in Jesse's PCI tree. Please take a look.

Thanks,
Kenji Kaneshige
