Return-Path: <dbaryshkov@gmail.com>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 46F67B6F73
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon,  4 Jul 2011 22:47:07 +1000 (EST)
Received: by wyh21 with SMTP id 21so3728457wyh.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 04 Jul 2011 05:47:02 -0700 (PDT)
Message-ID: <4E11B63C.4090306@gmail.com>
Date: Mon, 04 Jul 2011 16:46:52 +0400
From: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
MIME-Version: 1.0
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: enable access to HT Host-Bridge on Maple
References: <1309357060-20872-1-git-send-email-dbaryshkov@gmail.com>
	<F4E7EABC-B63F-4776-A8EB-8C93F64C2A3C@kernel.crashing.org>
	<BANLkTinarWc6n5KLJdx=kFC5wysw+8VQtw@mail.gmail.com>
	<288B47E0-3869-486D-B753-62EFA1EEF66D@kernel.crashing.org>
In-Reply-To: <288B47E0-3869-486D-B753-62EFA1EEF66D@kernel.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello,

On 03.07.2011 01:50, Segher Boessenkool wrote:
>>>> +static int u3_ht_root_write_config(struct pci_controller *hose, u8
>>>> offset,
>>>> + int len, u32 val)
>>>> +{
>>>> + volatile void __iomem *addr;
>>>> +
>>>> + addr = hose->cfg_addr + ((offset & ~3) << 2) + (4 - len - (offset
>>>> & 3));
>>>> +
>>>> + if (offset >= PCI_BASE_ADDRESS_0 && offset < PCI_CAPABILITY_LIST)
>>>> + return PCIBIOS_SUCCESSFUL;
>>>
>>> This is a workaround for something; at the very least it needs a
>>> comment,
>>> but probably it shouldn't be here at all.
>>
>> I'll add a comment. Basically these registers are unimplemented on u3/u4
>> bridges and at least some kinds of access to them cause system freeze.
>> I'll try to check what triggers what this night.
>
> I don't think the hardware freezes, but probably Linux isn't happy when it
> tries to write to the non-existent BARs. Or something like that.

I've run several experiments. At least writing to the ROM_ADDRESS (0x30) 
causes some kind of strange reboot (I see 'Error: Magic number in 
message area NVRAM is not valid.') errors on the service console and 
Linux consoles are silent. Writing to other BARs seem to cause no direct 
effect (reg remains =0), but causes very strange behaviour during boot. 
All PCI access cycles seem to return 0, strange DRAM ECC error pops up, 
etc. I'd prefer to leave these register writes disabled, even if it's 
the problem of some hardware revision (?).


-- 
With best wishes
Dmitry
