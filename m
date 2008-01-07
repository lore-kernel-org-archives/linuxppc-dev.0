Return-Path: <Paul.Gortmaker@windriver.com>
Received: from mail.wrs.com (mail.windriver.com [147.11.1.11])
	by ozlabs.org (Postfix) with ESMTP id 48527DDEA2
	for <linuxppc-dev@ozlabs.org>; Tue,  8 Jan 2008 09:27:25 +1100 (EST)
Message-ID: <4782A748.5090502@windriver.com>
Date: Mon, 07 Jan 2008 17:27:20 -0500
From: Paul Gortmaker <paul.gortmaker@windriver.com>
MIME-Version: 1.0
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH 1/3] sbc8548: Add basic support for Wind River SBC8548
	as powerpc
References: <11982194332672-git-send-email-paul.gortmaker@windriver.com>
	<11982194344016-git-send-email-paul.gortmaker@windriver.com>
	<E22DFF32-E85B-4A58-89D4-E447BEB8BA28@kernel.crashing.org>
In-Reply-To: <E22DFF32-E85B-4A58-89D4-E447BEB8BA28@kernel.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Kumar Gala wrote:
>
> On Dec 21, 2007, at 12:43 AM, Paul Gortmaker wrote:
>
>> This adds the basic support for the Wind River SBC8548 board, 
>> implemented
>> as powerpc.  It closely follows the implementation of the MPC8548CDS.
>>
>>

[...]

>> +#ifdef CONFIG_PCI
>> +static int sbc8548_exclude_device(struct pci_controller *hose,
>> +                  u_char bus, u_char devfn)
>> +{
>> +    if (bus == 0 && PCI_SLOT(devfn) == 0)
>> +        return PCIBIOS_DEVICE_NOT_FOUND;
>> +    else
>> +        return PCIBIOS_SUCCESSFUL;
>> +}
>> +#endif
>
> see comment on the 8560 support, but I don't think you need to exclude 
> the PHBs anymore.  I've fixed this so we have a general quick for FSL 
> PHBs.
>

Right.  I wanted to also test on the 8548, since I can't really plug 
anything
into my 8560, and on the 8548, the PCI behaviour is unaltered by
clobbering these.  I'll send a patch removing it from both of the
sbc85xx boards in a bit.

Aside from this, and the 8548 dts-v1 conversion (already sent), I don't
think there were any other to-fix items for the sbc8548, so I won't
spam everyone with those 8548 patches again unless you need me to
rebase them or similar.

Thanks,
Paul.

>>
> - k
