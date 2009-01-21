Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 6BC26DDDEF
	for <linuxppc-dev@ozlabs.org>; Thu, 22 Jan 2009 10:25:59 +1100 (EST)
Message-Id: <BF344A1E-26CB-4C3F-915D-61E5830C3670@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Aaron Pace <kodiakuppercut@gmail.com>
In-Reply-To: <bc81dc640901211000wc94dac3i802c8d6ae305d4a8@mail.gmail.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v929.2)
Subject: Re: Non-contiguous physical memory
Date: Wed, 21 Jan 2009 17:25:52 -0600
References: <bc81dc640901210718l18edbc6ehffbb6709c0daac3f@mail.gmail.com>
	<3725D962-7F25-4A77-8D87-9BBA0A78D406@kernel.crashing.org>
	<bc81dc640901211000wc94dac3i802c8d6ae305d4a8@mail.gmail.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Jan 21, 2009, at 12:00 PM, Aaron Pace wrote:

>>
>> Its possible in that Linux supports this.  However the PPC32 code  
>> does not
>> exist and would need to be added to support non-contiguous memory  
>> ranges.
>>
>> What exact PCI-E needs do you have?  Is PCI-E performance  
>> critical?  Is
>> (are) your pci device(s) 64-bit address capable?
>>
>> I ask because depending on the answers doing straight 4G and PCI  
>> above that
>> range might be sufficient for your needs.
>>
>> - k
>>
>
> Hello, thanks for responding.
> The first take at this used your idea of mapping the PCI-E ranges
> above the 4G boundary.
> We have a localbus bridge device on the PCI-E bus that only supports
> 32-bit MMIO, but I believe we could satisfactorily work around that
> problem using the ATMU registers.
> However, one question that I had that I wasn't able to verify to my
> satisfaction was whether I could ioremap a 36-bit physical address
> when building for ppc32, as the PCI-E devices have memory ranges that
> need to be accessible from userspace.  If that is possible, then this
> may be the way to go, although it would still be nice not to lose the
> 128 meg for the localbus & CCSR region.

you can get 36-bit physical addresses but you need to enable "Large  
physical address support".

- k
