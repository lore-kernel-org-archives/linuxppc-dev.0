Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 7058DDDE30
	for <linuxppc-dev@ozlabs.org>; Sat,  2 Jun 2007 05:58:25 +1000 (EST)
In-Reply-To: <46B96294322F7D458F9648B60E15112C30780F@zch01exm26.fsl.freescale.net>
References: <11798051102658-git-send-email-wei.zhang@freescale.com><11798051101543-git-send-email-wei.zhang@freescale.com><1179805110272-git-send-email-wei.zhang@freescale.com><1179805110278-git-send-email-wei.zhang@freescale.com><1179856792.27985.22.camel@rhino><46B96294322F7D458F9648B60E15112C234A2D@zch01exm26.fsl.freescale.net><F1C4E37E-FF0F-4A5F-AC49-860B4AAC4E28@kernel.crashing.org><46B96294322F7D458F9648B60E15112C30777C@zch01exm26.fsl.freescale.net><A7C2B8A9-AE89-4E00-9771-F3C21A610121@kernel.crashing.org>
	<18015.48278.312517.781244@cargo.ozlabs.ibm.com>
	<46B96294322F7D458F9648B60E15112C30780F@zch01exm26.fsl.freescale.net>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <CD8461E1-1881-407C-BE62-3679AECAE5AA@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH 3/5] Float the pci bus number on MPC8641HPCN board.
Date: Fri, 1 Jun 2007 14:58:00 -0500
To: Zhang Wei-r63237 <Wei.Zhang@freescale.com>
Cc: Paul Mackerras <paulus@samba.org>,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Jun 1, 2007, at 1:45 AM, Zhang Wei-r63237 wrote:

> Hi, Paul,
>
>> -----Original Message-----
>> From: Paul Mackerras [mailto:paulus@samba.org]
>>
>> Kumar Gala writes:
>>
>>>> That's my original doing. If there a PCI bridge card be
>> pluged into
>>>> PCI
>>>> slot of hose0, I can not ensue the bus_offset number of hose1.
>>>
>>> Ok, but can't we use hose0's last_busno and use that set hose1-
>>>> first_busno & hose1->bus_offset?
>>
>> Why do the bus numbers for hose0 and hose1 have to have any relation
>> to each other at all?  Aren't they separate PCI domains?
>
> There are lots of lagacy PCI codes in kernel, such as
> pci_bus_to_hose(busnr). If two hose's bus number have overlaps,
> pci_bus_to_hose() can not return the correct hose. And there will  
> effect
> /proc/pci and lspci tools.


So looking at the code it looks like pci_assign_all_buses should  
handle numbering the busses properly when we scan the busses, so  
what's the issue that causes that not to be correct?

- k
