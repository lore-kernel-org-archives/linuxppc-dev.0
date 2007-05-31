Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 93FCEDE022
	for <linuxppc-dev@ozlabs.org>; Thu, 31 May 2007 23:44:21 +1000 (EST)
In-Reply-To: <46B96294322F7D458F9648B60E15112C234A2D@zch01exm26.fsl.freescale.net>
References: <11798051102658-git-send-email-wei.zhang@freescale.com>
	<11798051101543-git-send-email-wei.zhang@freescale.com>
	<1179805110272-git-send-email-wei.zhang@freescale.com>
	<1179805110278-git-send-email-wei.zhang@freescale.com>
	<1179856792.27985.22.camel@rhino>
	<46B96294322F7D458F9648B60E15112C234A2D@zch01exm26.fsl.freescale.net>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <F1C4E37E-FF0F-4A5F-AC49-860B4AAC4E28@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH 3/5] Float the pci bus number on MPC8641HPCN board.
Date: Thu, 31 May 2007 08:43:55 -0500
To: Zhang Wei-r63237 <Wei.Zhang@freescale.com>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On May 22, 2007, at 10:35 PM, Zhang Wei-r63237 wrote:

> Hi, Wade,
>
> That's a good question.
>
> The ppc_md.exclude_device() function will be called before PCI config
> access in indirect_read/write_config() of the file
> arch/powerpc/sysdev/indirect_pci.c. If the hose->bus_offset value  
> is 0,
> the primary bus number register of the host must be hose->first_busno.
> Otherwise, if the host primary bus number register is 0, the
> hose->bus_offset must be the same value of hose->first_buseno.
>
> When the pci scan bus, the bridge will be scaned twice. When the  
> second
> scan is finished, the host primary bus number register will be  
> write to
> hose->first_busno. The PCI bus(not the first PCI host) access will be
> wrong in the later access. I'll check it and correct the
> hose->bus_offset value in these codes.

Can this be fixed by just setting hose->bus_offset in add_bridge?

Doing this in exclude is very bad.

- k

>> -----Original Message-----
>> From: Wade Farnsworth [mailto:wfarnsworth@mvista.com]
>> Subject: Re: [PATCH 3/5] Float the pci bus number on
>> MPC8641HPCN board.
>>
>> On Tue, 2007-05-22 at 11:38 +0800, Zhang Wei wrote:
>>>  int mpc86xx_exclude_device(u_char bus, u_char devfn)
>>>  {
>>> +	struct pci_controller *hose;
>>> +
>>> +	hose = pci_bus_to_hose(bus);
>>> +	if (unlikely(!hose))
>>> +		return PCIBIOS_DEVICE_NOT_FOUND;
>>> +
>>> +	/* Correcting the hose->bus_offset value. */
>>> +	out_be32(hose->cfg_addr, 0x80000000 | ((hose->first_busno
>>> +					- hose->bus_offset) << 16));
>>> +	if (unlikely(in_le32(hose->cfg_data) == 0xffffffff))
>>> +		hose->bus_offset = hose->bus_offset ? 0 :
>> hose->first_busno;
>>> +
>>>  	return PCIBIOS_SUCCESSFUL;
>>>  }
>>
>> What is the purpose of this code and why put it in
>> mpc86xx_exclude_device?
>>
>> --Wade
>>
>>
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
