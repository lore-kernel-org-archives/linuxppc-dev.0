Return-Path: <felix@embedded-sol.com>
Received: from vega.surpasshosting.com (vega.surpasshosting.com [72.29.83.9])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id D7239B7D5E
	for <linuxppc-dev@ozlabs.org>; Tue, 16 Mar 2010 19:39:52 +1100 (EST)
Message-ID: <4B9F43DB.1060801@embedded-sol.com>
Date: Tue, 16 Mar 2010 10:39:55 +0200
From: Felix Radensky <felix@embedded-sol.com>
MIME-Version: 1.0
To: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
Subject: Re: Problem with PCI bus rescan on 460EX
References: <4B8E6FA3.70503@embedded-sol.com>	<20100310225100.GB27324@ldl.fc.hp.com>	<4B98A0CB.8090103@embedded-sol.com>	<4B9A07D2.4060801@jp.fujitsu.com>	<4B9AC885.3010107@embedded-sol.com>	<4B9DC820.2060100@jp.fujitsu.com>	<4B9DCF01.4050709@embedded-sol.com>	<4B9DF72F.3040105@jp.fujitsu.com>	<4B9E18A7.2080605@embedded-sol.com>
	<4B9F19E2.2090709@jp.fujitsu.com>
In-Reply-To: <4B9F19E2.2090709@jp.fujitsu.com>
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

Hello, Kenji-san

Kenji Kaneshige wrote:
>
> I misunderstood the problem.
> My understanding was memory resource was not enabled even though Linux 
> set
> the Memory Space bit in the command register. But it was not correct. The
> bridge memory window was marked unused and Linux didn't try to set Memory
> Space bit in the command register. Current my understanding is as 
> follows.
> Please correct me if I'm still misunderstanding something.
>
> 1) Your BIOS doesn't assign any resource to the bridge if its child PCI
>   hot-plug slot is not occupied.
>
> 2) At the boot time, pci_assign_unassigned_resources() try to assign
>   memory resouces to the bridge using pci_bus_assign_resource(), but
>   it was disabled because there are no devices require memory resource.
>
> 3) And then pci_assign_unassigned_resouces() calls pci_enable_bridge(),
>   but Memory Space bit in the command register was not set because no
>   memory resource are assigned to the bridge. At the same time,
>   pci_dev->enable_cnt was incremented.
>
> 4) At the rescan time, pci_setup_bridge() and pci_enable_bridge() doesn't
>   work because the bridge is already marked "enabled" (i.e.
>   pci_dev->enable_cnt is not zero).
>
> I don't have any concrete idea how to fix that so far, but I can say 
> my idea
> (pcibios_enable_device() should return an error) was wrong.
>
> BTW, on my PCI hotplug capable system (SHPC and PCIe), I/O and Memory 
> windows
> of the bridge are assigned by BIOS regardless of whether hotplug slot(s)
> behind the bridge is occupied or not. Maybe that is the reason why I have
> never encountered this problem before.
>
> Thanks,
> Kenji Kaneshige
>
>
Yes, your understanding of the problem is correct. On this platform BIOS 
(bootloader, u-boot)
is not required to configure PCI, linux is capable of doing all 
configuration itself. But both u-boot
and linux do not assign memory resources to bridge if there's no device 
behind it.

Thanks a lot.

Felix.
