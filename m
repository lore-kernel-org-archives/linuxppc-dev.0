Return-Path: <albert_herranz@yahoo.es>
Received: from smtp128.mail.ukl.yahoo.com (smtp128.mail.ukl.yahoo.com
	[77.238.184.59]) by ozlabs.org (Postfix) with SMTP id BA85BB7BBA
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 24 Nov 2009 06:59:17 +1100 (EST)
Message-ID: <4B0AE993.7050106@yahoo.es>
Date: Mon, 23 Nov 2009 20:59:15 +0100
From: Albert Herranz <albert_herranz@yahoo.es>
MIME-Version: 1.0
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [RFC PATCH 11/19] powerpc: gamecube/wii: flipper interrupt
	controller support
References: <1258927311-4340-1-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-4-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-5-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-6-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-7-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-8-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-9-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-10-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-11-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-12-git-send-email-albert_herranz@yahoo.es>
	<fa686aa40911221528y1980a95bw1dc8aa75a86c061e@mail.gmail.com>
In-Reply-To: <fa686aa40911221528y1980a95bw1dc8aa75a86c061e@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Grant Likely wrote:
> On Sun, Nov 22, 2009 at 3:01 PM, Albert Herranz <albert_herranz@yahoo.es> wrote:
>> Add support for the interrupt controller included in the "Flipper"
>> chipset of the Nintendo GameCube video game console.
>> The same interrupt controller is also present in the "Hollywood" chipset
>> of the Nintendo Wii.
>>
>> Signed-off-by: Albert Herranz <albert_herranz@yahoo.es>
>> ---
>>  arch/powerpc/platforms/embedded6xx/Kconfig       |    6 +
>>  arch/powerpc/platforms/embedded6xx/Makefile      |    1 +
>>  arch/powerpc/platforms/embedded6xx/flipper-pic.c |  247 ++++++++++++++++++++++
>>  arch/powerpc/platforms/embedded6xx/flipper-pic.h |   25 +++
>>  4 files changed, 279 insertions(+), 0 deletions(-)
>>  create mode 100644 arch/powerpc/platforms/embedded6xx/flipper-pic.c
>>  create mode 100644 arch/powerpc/platforms/embedded6xx/flipper-pic.h
>>
>> diff --git a/arch/powerpc/platforms/embedded6xx/Kconfig b/arch/powerpc/platforms/embedded6xx/Kconfig
>> index bfd88be..29a98c6 100644
>> --- a/arch/powerpc/platforms/embedded6xx/Kconfig
>> +++ b/arch/powerpc/platforms/embedded6xx/Kconfig
>> @@ -94,6 +94,7 @@ config MPC10X_STORE_GATHERING
>>  config GAMECUBE_COMMON
>>        bool
>>        select NOT_COHERENT_CACHE
>> +       select FLIPPER_PIC
>>
>>  config USBGECKO_UDBG
>>        bool "USB Gecko udbg console for the Nintendo GameCube/Wii"
>> @@ -108,3 +109,8 @@ config USBGECKO_UDBG
>>
>>          If in doubt, say N here.
>>
>> +config FLIPPER_PIC
>> +       bool
>> +       depends on GAMECUBE_COMMON
>> +       default y
> 
> You'll always want this driver when GAMECUBE common is set.  Don't add
> another Kconfig entry.
> 

Ok.

>> +
>> diff --git a/arch/powerpc/platforms/embedded6xx/Makefile b/arch/powerpc/platforms/embedded6xx/Makefile
>> index 0ab7492..35258fd 100644
>> --- a/arch/powerpc/platforms/embedded6xx/Makefile
>> +++ b/arch/powerpc/platforms/embedded6xx/Makefile
>> @@ -8,3 +8,4 @@ obj-$(CONFIG_PPC_HOLLY)         += holly.o
>>  obj-$(CONFIG_PPC_PRPMC2800)    += prpmc2800.o
>>  obj-$(CONFIG_PPC_C2K)          += c2k.o
>>  obj-$(CONFIG_USBGECKO_UDBG)    += usbgecko_udbg.o
>> +obj-$(CONFIG_FLIPPER_PIC)      += flipper-pic.o
> 
>> +unsigned int flipper_pic_get_irq(void)
>> +{
>> +       void __iomem *io_base = flipper_irq_host->host_data;
>> +       int irq;
>> +       u32 irq_status;
>> +
>> +       irq_status = in_be32(io_base + FLIPPER_ICR) &
>> +                    in_be32(io_base + FLIPPER_IMR);
>> +       if (irq_status == 0)
>> +               return -1;      /* no more IRQs pending */
> 
> NO_IRQ_IGNORE
> 

I'll fix that. Thanks.
I did it in the other interrupt controller but forgot about this.

>> +
>> +       __asm__ __volatile__("cntlzw %0,%1" : "=r"(irq) : "r"(irq_status));
>> +       return irq_linear_revmap(flipper_irq_host, 31 - irq);
>> +}
>> +
> 

Thanks.

Cheers,
Albert
