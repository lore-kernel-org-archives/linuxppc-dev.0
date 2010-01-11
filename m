Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 902501007D3
	for <linuxppc-dev@ozlabs.org>; Tue, 12 Jan 2010 07:53:52 +1100 (EST)
Subject: Re: PCI-PCI bridge scanning broken on 460EX
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Felix Radensky <felix@embedded-sol.com>
In-Reply-To: <4B4B55CF.9000707@embedded-sol.com>
References: <4B388D9D.7010404@embedded-sol.com>
	<1262584539.2173.335.camel@pasglop>	<4B41ADF1.1000400@embedded-sol.com>
	<4B49CE8A.7000609@embedded-sol.com>	<1263155906.724.2.camel@pasglop>
	<4B4A4307.5050704@embedded-sol.com>	<1263159117.724.15.camel@pasglop>
	<4CD35CD1F8085945B597F80EEC89421303B8AD0C@exc01.bk.prodrive.nl>
	<4B4B1027.4020708@embedded-sol.com> <4B4B55CF.9000707@embedded-sol.com>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 12 Jan 2010 07:53:19 +1100
Message-ID: <1263243199.724.146.camel@pasglop>
Mime-Version: 1.0
Cc: Stef van Os <stef.van.os@Prodrive.nl>, Stefan Roese <sr@denx.de>,
	Feng Kan <fkan@amcc.com>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> It seems I was wrong. I've manually applied the patch at the wrong 
> place. After patching the correct function
> I'm not getting hard resets any more, which is a great improvement ! 
> Thanks a lot, I really appreciate your help !

This is somewhat funny... I wonder how it would have managed to find
anything behind the root complex P2P bridge with broken type 1 cycles...
very very strange.

> Unfortunately not all problems are gone. PLX is now identified 
> correctly, but device behind it is not detected,
> although u-boot detects it correctly. See below.

You have removed all your changes to that code right ?

Also the log still looks weird:

> pci 0000:01:02.0: scanning behind bridge, config 010100, pass 0
> pci 0000:01:02.0: bus configuration invalid, reconfiguring
> pci 0000:01:02.0: scanning behind bridge, config 010100, pass 1
> pci_bus 0000:01: bus scan returning with max=01
> pci 0000:00:02.0: scanning behind bridge, config 010100, pass 1
> pci_bus 0000:00: bus scan returning with max=01

Unless you left some experimental changes in, the above isn't right, the
"config" value should have changed due to the write of ~ffffff to it

If the code running is indeed unmodified from upsteam, can you try with
just that change:

        /* Check if setup is sensible at all */
-        if (!pass &&
-            ((buses & 0xff) != bus->number || ((buses >> 8) & 0xff) <= bus->number)) {
+        if (((buses & 0xff) != bus->number || ((buses >> 8) & 0xff) <= bus->number)) {
                 dev_dbg(&dev->dev, "bus configuration invalid, reconfiguring\n");
                 broken = 1;
         }

(IE remove the check for !pass)

Cheers,
Ben.

> pci 0000:00:02.0: disabling bridge window [mem 0xd80000000-0xd8c0fffff] 
> to [bus 01-01] (unused)
> pci 0000:00:02.0: PCI bridge to [bus 01-01]
> pci 0000:00:02.0:   bridge window [io  disabled]
> pci 0000:00:02.0:   bridge window [mem disabled]
> pci 0000:00:02.0:   bridge window [mem pref disabled]
> pci_bus 0000:00: resource 0 [io  0x0000-0xffff]
> pci_bus 0000:00: resource 1 [mem 0xd80000000-0xdffffffff]
> pci_bus 0000:01: resource 1 [??? 57982058496-58184433663 flags 0x0]
> 
> Any ideas what could be wrong now ?
> 
> Thanks a lot.
> 
> Felix.
> 
