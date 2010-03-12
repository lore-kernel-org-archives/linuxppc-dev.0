Return-Path: <felix@embedded-sol.com>
Received: from vega.surpasshosting.com (vega.surpasshosting.com [72.29.83.9])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id B2D91B7D4B
	for <linuxppc-dev@ozlabs.org>; Sat, 13 Mar 2010 10:04:38 +1100 (EST)
Message-ID: <4B9AC885.3010107@embedded-sol.com>
Date: Sat, 13 Mar 2010 01:04:37 +0200
From: Felix Radensky <felix@embedded-sol.com>
MIME-Version: 1.0
To: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
Subject: Re: Problem with PCI bus rescan on 460EX
References: <4B8E6FA3.70503@embedded-sol.com>	<20100310225100.GB27324@ldl.fc.hp.com>	<4B98A0CB.8090103@embedded-sol.com>
	<4B9A07D2.4060801@jp.fujitsu.com>
In-Reply-To: <4B9A07D2.4060801@jp.fujitsu.com>
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
> I'm not sure, but I guess pci_setup_bridge() didn't update IO base/limit
> and Mem base/limit of the bridge (0000:00:02.0) because of the following
> lines.
>
> static void pci_setup_bridge(struct pci_bus *bus)
> {
>        struct pci_dev *bridge = bus->self;
>        struct resource *res;
>        struct pci_bus_region region;
>        u32 l, bu, lu, io_upper16;
>
>        if (pci_is_enabled(bridge))    
> <===============================               
>                return;            <===============================
>
>        dev_info(&bridge->dev, "PCI bridge to [bus %02x-%02x]\n",
>                 bus->secondary, bus->subordinate);
>     ...
>
> It seems the bridge was already enabled by 
> pci_assign_unassigned_resources()
> at boot time. Does removing those lines make any change?
>

Yes, with these lines removed bridge memory window is properly allocated.
For some reason bridge memory is disabled, but if I enable it via 
setpci, and
also enable device memory, then everything works fine. If the system is 
booted
when device behind the bridge is plugged in, bridge memory is enabled.

Thanks a lot for your help.

Felix.
