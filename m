Return-Path: <felix@embedded-sol.com>
Received: from vega.surpasshosting.com (vega.surpasshosting.com [72.29.83.9])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id A9AB9B6F1B
	for <linuxppc-dev@ozlabs.org>; Wed, 16 Dec 2009 23:00:03 +1100 (EST)
Message-ID: <4B28CBC4.4010501@embedded-sol.com>
Date: Wed, 16 Dec 2009 14:00:04 +0200
From: Felix Radensky <felix@embedded-sol.com>
MIME-Version: 1.0
To: Mahajan Vivek-B08308 <B08308@freescale.com>
Subject: Re: Problem with mini-PCI-E slot on P2020RDB
References: <4B27FEE3.80001@embedded-sol.com>	<0949C49693EF1A47A54B0F0113CDB4A607674F@zin33exm23.fsl.freescale.net>	<4B28A7C3.6040209@embedded-sol.com>
	<0949C49693EF1A47A54B0F0113CDB4A6076776@zin33exm23.fsl.freescale.net>
In-Reply-To: <0949C49693EF1A47A54B0F0113CDB4A6076776@zin33exm23.fsl.freescale.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org, Aggrwal Poonam-B10812 <B10812@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Mahajan Vivek-B08308 wrote:
>> From: Felix Radensky [mailto:felix@embedded-sol.com] 
>> Sent: Wednesday, December 16, 2009 2:56 PM
>> To: Mahajan Vivek-B08308
>> Cc: linuxppc-dev@ozlabs.org; Aggrwal Poonam-B10812; Kumar Gala
>> Subject: Re: Problem with mini-PCI-E slot on P2020RDB
>>
>> Hi,
>>     
>>> Looks like INTA is not being routed to IRQ0 properly for this PCIe 
>>> ctlr. Try changing the interrupt-map prop for the ctlr at 
>>>       
>> 0xffe0a000 
>>     
>>> to the following, temporarily:-
>>>
>>> interrupt-map = <
>>> /* IDSEL 0x0 */
>>> 0000 0x0 0x0 0x1 &mpic 0x1 0x1
>>> 0000 0x0 0x0 0x2 &mpic 0x2 0x1
>>> 0000 0x0 0x0 0x3 &mpic 0x3 0x1
>>> 0000 0x0 0x0 0x4 &mpic 0x0 0x1
>>>   
>>>       
>> Thanks for your help. With this change "nobody cared" message 
>> disappears, but interrupts are not coming at all.
>>
>> Is it a SoC problem or a board problem ?
>>     
>
> As per the p2020rm, PCIe legacy INTA is shared with IRQ0 for 
> this ctlr, which is the exactly the case with other SoC's 
> p2020ds, mpc8536ds, mpc8572ds. To me it seems like a board 
> issue and it needs to be followed up.
>
> I plugged in ralink rt2860 pcie wirless card in the mini-pcie 
> slot of p2020rdb, which ran fine becaused it used MSI by default.
> How hard is it to enable MSI in the atheros wireless driver.
>
>   

I've enabled MSI in ath9k driver, by simply adding pci_enable_msi() and
pci_disable_msi() at relevant places. The MSI interrupt is allocated.

irq: irq 0 on host /soc@ffe00000/msi@41600 mapped to virtual irq 18
phy0: Atheros AR9280 MAC/BB Rev:2 AR5133 RF Rev:d0: mem=0xf2160000, irq=18

cat /proc/interrupts
           CPU0
 18:          0   FSL-MSI   Edge      ath9k

lspci -v shows that MSI was enabled on device

But I don't get any interrupts. I've posted a question to ath9k list, 
maybe folks there
will have some ideas.

Thanks.

Felix.
