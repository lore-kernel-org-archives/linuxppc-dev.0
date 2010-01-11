Return-Path: <felix@embedded-sol.com>
Received: from vega.surpasshosting.com (vega.surpasshosting.com [72.29.83.9])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 7B948B7B6C
	for <linuxppc-dev@ozlabs.org>; Tue, 12 Jan 2010 03:46:05 +1100 (EST)
Message-ID: <4B4B55CF.9000707@embedded-sol.com>
Date: Mon, 11 Jan 2010 18:46:07 +0200
From: Felix Radensky <felix@embedded-sol.com>
MIME-Version: 1.0
To: Stef van Os <stef.van.os@Prodrive.nl>
Subject: Re: PCI-PCI bridge scanning broken on 460EX
References: <4B388D9D.7010404@embedded-sol.com><1262584539.2173.335.camel@pasglop>	<4B41ADF1.1000400@embedded-sol.com><4B49CE8A.7000609@embedded-sol.com>	<1263155906.724.2.camel@pasglop><4B4A4307.5050704@embedded-sol.com>	<1263159117.724.15.camel@pasglop>
	<4CD35CD1F8085945B597F80EEC89421303B8AD0C@exc01.bk.prodrive.nl>
	<4B4B1027.4020708@embedded-sol.com>
In-Reply-To: <4B4B1027.4020708@embedded-sol.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Stefan Roese <sr@denx.de>, Feng Kan <fkan@amcc.com>,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Stef

Felix Radensky wrote:
> Hi Stef,
>
> Stef van Os wrote:
>> Hello Felix,
>>
>> I had a problem similar to this on the 440GX, the PCI code was not
>> sending type 1 transactions when scanning behind bridges. Perhaps you
>> could try this:
>>
>> Index: linux/arch/powerpc/sysdev/ppc4xx_pci.c
>> ===================================================================
>> --- linux/arch/powerpc/sysdev/ppc4xx_pci.c      (revision 26)
>> +++ linux/arch/powerpc/sysdev/ppc4xx_pci.c      (revision 27)
>> @@ -569,7 +569,7 @@
>>         hose->last_busno = bus_range ? bus_range[1] : 0xff;
>>
>>         /* Setup config space */
>> -       setup_indirect_pci(hose, rsrc_cfg.start, rsrc_cfg.start + 0x4,
>> 0);
>> +       setup_indirect_pci(hose, rsrc_cfg.start, rsrc_cfg.start + 0x4,
>> PPC_INDIRECT_TYPE_SET_CFG_TYPE);
>>
>>         /* Disable all windows */
>>         writel(0, reg + PCIX0_POM0SA);
>>
>>
>>
>> With kind regards / Met vriendelijke groet,
>>
>> Stef van Os
>>
>> Prodrive B.V.
>>
>>   
>
> I think you patch is a valid one, and should be applied, but 
> unfortunately it doesn't fix by problem.
> BTW, in u-boot transaction type bit is set correctly.
>
>

It seems I was wrong. I've manually applied the patch at the wrong 
place. After patching the correct function
I'm not getting hard resets any more, which is a great improvement ! 
Thanks a lot, I really appreciate your help !

Unfortunately not all problems are gone. PLX is now identified 
correctly, but device behind it is not detected,
although u-boot detects it correctly. See below.

PCI: Probing PCI hardware
pci_bus 0000:00: scanning bus
pci 0000:00:02.0: found [3388:0020] class 000604 header type 01
pci 0000:00:02.0: calling pcibios_fixup_resources+0x0/0xf4
pci 0000:00:02.0: calling fixup_ppc4xx_pci_bridge+0x0/0x154
pci 0000:00:02.0: calling quirk_resource_alignment+0x0/0x200
pci 0000:00:02.0: supports D1 D2
pci 0000:00:02.0: PME# supported from D0 D1 D2 D3hot
pci 0000:00:02.0: PME# disabled
pci_bus 0000:00: fixups for bus
pci 0000:00:02.0: scanning behind bridge, config 010100, pass 0
pci_bus 0000:01: scanning bus
pci 0000:01:02.0: found [3388:0020] class 000604 header type 01
pci 0000:01:02.0: calling pcibios_fixup_resources+0x0/0xf4
pci 0000:01:02.0: calling fixup_ppc4xx_pci_bridge+0x0/0x154
pci 0000:01:02.0: calling quirk_resource_alignment+0x0/0x200
pci 0000:01:02.0: supports D1 D2
pci 0000:01:02.0: PME# supported from D0 D1 D2 D3hot
pci 0000:01:02.0: PME# disabled
pci_bus 0000:01: fixups for bus
pci 0000:00:02.0: PCI bridge to [bus 01-01]
pci 0000:00:02.0:   bridge window [mem 0x80000000-0x8c0fffff]
pci 0000:01:02.0: scanning behind bridge, config 010100, pass 0
pci 0000:01:02.0: bus configuration invalid, reconfiguring
pci 0000:01:02.0: scanning behind bridge, config 010100, pass 1
pci_bus 0000:01: bus scan returning with max=01
pci 0000:00:02.0: scanning behind bridge, config 010100, pass 1
pci_bus 0000:00: bus scan returning with max=01
pci 0000:00:02.0: disabling bridge window [mem 0xd80000000-0xd8c0fffff] 
to [bus 01-01] (unused)
pci 0000:00:02.0: PCI bridge to [bus 01-01]
pci 0000:00:02.0:   bridge window [io  disabled]
pci 0000:00:02.0:   bridge window [mem disabled]
pci 0000:00:02.0:   bridge window [mem pref disabled]
pci_bus 0000:00: resource 0 [io  0x0000-0xffff]
pci_bus 0000:00: resource 1 [mem 0xd80000000-0xdffffffff]
pci_bus 0000:01: resource 1 [??? 57982058496-58184433663 flags 0x0]

Any ideas what could be wrong now ?

Thanks a lot.

Felix.
