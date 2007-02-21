Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id DF075DDDE7
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 22 Feb 2007 02:05:49 +1100 (EST)
In-Reply-To: <9F3F0A752CAEBE4FA7E906CC2FBFF57C06A165@MERCURY.inside.istor.com>
References: <9F3F0A752CAEBE4FA7E906CC2FBFF57C06A165@MERCURY.inside.istor.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <109A6A22-FDE5-4202-964C-0A1FC6392F94@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: understanding an IO question
Date: Wed, 21 Feb 2007 09:04:50 -0600
To: "Charles Krinke" <ckrinke@istor.com>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


On Feb 21, 2007, at 8:14 AM, Charles Krinke wrote:

> I apologize for not making myself clearer. This is a kernel driver
> issue, not a user space issue. The issue is addressing the  
> registers in
> a PCI device in its driver.
>
> We have a functioning code base that works with Linux 2.6.17.11 on our
> 8241 platform. We have built a new board using the 8541. Although the
> registers are addressable from uboot and can be read/written, once  
> Linux
> boots, the registers cannot be addressed.
>
> I suspect this to be in either TLB1 setup or Outbound Address
> Translation windows.
>
> So,... my questions really are
>
> 1. "Where are the TLB's setup in the 85xx chip during Linux
> initialization for devices that may be using PCI memory in the
> 0x8000_0000 - 0x9fff_ffff address space region?". I can see that some
> reset of TLB's occurs in head_fsl_booke.S and perhaps that is part of
> the answer. The other part may be in where TLB's are then setup again
> after they are reset in Linux.

You have to use ioremap() to get TLB and page mappings for any IO.   
We setup some initial kernel mappings to allow access to system  
memory but thats it.  Everything else should go through some mapping  
function.

> 2. "Are Outbound Address Translation windows reset by the arch/ppc/...
> Linux initialization and if so, where. If they are reset, where is the
> best place to put them back to the state I had set them up in uboot.

Nope, currently the address translation windows at the system level  
are not touched by arch/ppc (unless done in your own code).

Have you tried plain old ioremap() [not _nocached] ?

- k

>
> Charles
>
>
>
> -----Original Message-----
> From: Ami Levi Waves [mailto:ami@waves.com]
> Sent: Wednesday, February 21, 2007 12:51 AM
> To: Charles Krinke; linuxppc-embedded@ozlabs.org
> Subject: RE: understanding an IO question
>
> The way we do it:
>
> Fisrt open a memory device:
>
> 	Handle = open("/dev/mem", O_RDWR);
>
> Than map the address using:
>
> 	mmap(NULL, nAdress, PORT_READ | PROT_WRITE, MAP_SHARED, Handle,
> your
> base address);
>
> mmap returns a virtual pointer, pointing to your HW.
>
> Ami
>
>> -----Original Message-----
>> From: linuxppc-embedded-bounces+ami=waves.com@ozlabs.org
> [mailto:linuxppc-
>> embedded-bounces+ami=waves.com@ozlabs.org] On Behalf Of Charles  
>> Krinke
>> Sent: Wednesday, February 21, 2007 2:14 AM
>> To: linuxppc-embedded@ozlabs.org
>> Subject: understanding an IO question
>>
>> I have a board using an 8541 which is based on the mpc85xx_cds  
>> bsp. It
>> has one PCI device connected to the 8541, an ASIC we make that  
>> maps in
>> resources for its registers at 0x8400_0000 - 0x8400_0038.
>>
>> The driver for our ASIC works in an 8241 design and I am trying to  
>> get
>> its register access working in the 8541 and need a little additional
>> understanding.
>>
>> I can see in cat /proc/iomem where we have memory apparently  
>> allocated
>> for our registers, like this.
>>
>> cat /proc/iomem
>> 80000000-9fffffff : PCI1 host bridge
>>   84000000-84000038 : ichar
>>   88000000-8fffffff : ichar
>> e0003000-e00030ff : fsl-i2c.1
>> e0004500-e0004507 : serial
>>
>> In our driver, I do an ioremap_nocache with 0x8400_0000 as an  
>> argument
>> to the ioremap and am returned a virtual address of the form
>> 0xc905_8000. Unfortunately, I cannot seem to access my registers as
> they
>> all return zero when accessed with the iowrite32/ioread32 helper
>> functions.
>>
>> A little further. We do use the Outbound Address Translation window
>> feature in the 8541 to get to our PCI device and I do set this up in
>> uboot and I can read and write registers on our ASIC from uboot. Its
>> just in the Linux driver that I seem to be having trouble.
>>
>> So,... I am hoping someone could give me a couple of pointers on  
>> where
>> to look next for the missing piece of why I cannot access the
> registers
>> on our ASIC from Linux whereas things were working fine from uboot
>> before booting Linux.
>>
>> Charles
>> _______________________________________________
>> Linuxppc-embedded mailing list
>> Linuxppc-embedded@ozlabs.org
>> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
