Return-Path: <Tiejun.Chen@windriver.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail.windriver.com",
	Issuer "Intel External Basic Issuing CA 3A" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id DA56DB71DB
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed,  3 Aug 2011 16:42:30 +1000 (EST)
Message-ID: <4E38EDD4.1040809@windriver.com>
Date: Wed, 3 Aug 2011 14:42:28 +0800
From: "tiejun.chen" <tiejun.chen@windriver.com>
MIME-Version: 1.0
To: Vineeth <vneethv@gmail.com>
Subject: Re: Fwd: MPC7410 Linux Kernel
References: <OFABB45B91.59E6539A-ONCA2578CC.006F5FB7-CA2578CC.0070CFA6@csc.com>
	<CAFbQSaDaL0UaiY4r+u=a72mmsCHxs7O5Z82MESrXXcWj2tNvbQ@mail.gmail.com>
	<OF7A7D0C50.273D2A69-ONCA2578CD.001B5783-CA2578CD.001D9FFE@csc.com>
	<CAFbQSaAhXUrb1peJ2E3Kkp1gd16JSn9OjneO826q_aMz+yzAqg@mail.gmail.com>
	<CAFbQSaC6BkZj+a4=-9Q2Cyj7w=4y5QYM22kaK1O=Uz5KW9iiuQ@mail.gmail.com>
	<4E37AB04.9070409@windriver.com>
	<CAFbQSaDhEpSqX4GQHjSTsmpwv3a36RE7WrXbn7ni=NVcTtVyiw@mail.gmail.com>
In-Reply-To: <CAFbQSaDhEpSqX4GQHjSTsmpwv3a36RE7WrXbn7ni=NVcTtVyiw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Vineeth wrote:
> Thanks for the reply.
> 
> We were referring kuroboxHG.dts which uses Sandpoint architecture; which is
> almost same as ours.
> 
> 1. one doubt in kuroboxHG is the ranges property in SOC node says EUMB is at
> 0xFC00_0000; and as per the datasheet of mpc107, the open pic address will
	
And for powerpc looks u-boot should initialize MPC107 and EUMB_ADDR should be
configured as well. And kernel doesn't reconfigure EUMB again. This is different
from original ppc implementation.

So I think you should check how u-boot did. Note not all targets use 0xfc000000
as EUMB_ADDR. At least for linkstation 0x8000000 is set as EUMB_ADDR. And so
maybe this value, 0xFC000000, should be one typo since kernel don't use this
node property as I previously said.

> be EUMB_BASE + 0x40000; but in kurobox its given as 0x80040000;
> 
> 2. We know that our UART is mapped at address 0xDB00_0100; which is
> connected in a PCI-LOCAL bridge whose base is at 0xDB00_0000
> How can i represent these things in dts ? Can the RANGES property of PCI
> node can mention this ?

How do u-boot resided on your target set EUMB_ADDR? Then you can migrate
kuroboxHG.dts with this base address.

Tiejun

> 
> 
> 
> 
> 
> 
> 
> On Tue, Aug 2, 2011 at 1:15 PM, tiejun.chen <tiejun.chen@windriver.com>wrote:
> 
>> Vineeth wrote:
>>> Hi,
>>>
>>> We are trying to port  linux 2.6.38 on MPC7410 based board (This is a
>>> preparatory design by our customer)
>>>
>>> System architecture is as follows,
>>>
>>> MPC7410 <=> MPC107 <=> PCI_to_LOCAL(plx9052) <=> UART
>> MPCXXX should be compatible with TSIXXX. So you can refer to mpc7448_hpc2.
>>
>>> Previously we were using ppc architecture and we had some issues with
>>> page_init() functions; which may be because of our configuration.As we
>> didnt
>>> get much support on ppc architecture we moved to powerpc.
>>>
>>> Now we moved to powerpc architecture. We have some doubts on writing the
>> dts
>>> file. Please find the dts file attached.
>>>
>>> when we checked the legacy_serial.c file, we found that
>>> legacy_serial_parents not expecting a pci-local or a pci bridge as
>> parent.
>>> is our understanding correct ? should we introduce a new pci parent in
>> that
>>> structure ?
>> So you can understand this after refer to the file,
>> arch/powerpc/boot/dts/mpc7448hpc2.dts.
>>
>> Tiejun
>>
>>>  We are confused about writing the ranges property of PCI node.we were
>>> referring booting_without_of doc but didnt get much info. Is there any
>> file
>>> which gives better idea about the ranges property ?
>>>
>>> Thanks
>>>  Vineeth
>>
> 
