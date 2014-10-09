Return-Path: <linux@roeck-us.net>
Received: from bh-25.webhostbox.net (bh-25.webhostbox.net [208.91.199.152])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 474AA1A1A34
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Oct 2014 00:35:31 +1100 (EST)
Received: from mailnull by bh-25.webhostbox.net with sa-checked (Exim 4.82)
 (envelope-from <linux@roeck-us.net>) id 1XcDsP-000wHO-IX
 for linuxppc-dev@lists.ozlabs.org; Thu, 09 Oct 2014 13:35:29 +0000
Message-ID: <54368A30.9070101@roeck-us.net>
Date: Thu, 09 Oct 2014 06:14:24 -0700
From: Guenter Roeck <linux@roeck-us.net>
MIME-Version: 1.0
To: Pavel Machek <pavel@denx.de>
Subject: Re: [PATCH 08/44] kernel: Move pm_power_off to common code
References: <1412659726-29957-1-git-send-email-linux@roeck-us.net>
 <1412659726-29957-9-git-send-email-linux@roeck-us.net>
 <20141009103847.GC6787@amd>
In-Reply-To: <20141009103847.GC6787@amd>
Content-Type: text/plain; charset=windows-1252; format=flowed
Cc: linux-m32r-ja@ml.linux-m32r.org, linux-mips@linux-mips.org,
 linux-efi@vger.kernel.org, linux-ia64@vger.kernel.org,
 Steven Miao <realmz6@gmail.com>, linux-xtensa@linux-xtensa.org,
 Boris Ostrovsky <boris.ostrovsky@oracle.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>,
 David Howells <dhowells@redhat.com>, Max Filippov <jcmvbkbc@gmail.com>,
 Paul Mackerras <paulus@samba.org>, Ralf Baechle <ralf@linux-mips.org>,
 "H. Peter Anvin" <hpa@zytor.com>, Guan Xuetao <gxt@mprc.pku.edu.cn>,
 Thomas Gleixner <tglx@linutronix.de>, Lennox Wu <lennox.wu@gmail.com>,
 Hans-Christian Egtvedt <egtvedt@samfundet.no>, devel@driverdev.osuosl.org,
 linux-s390@vger.kernel.org, Jesper Nilsson <jesper.nilsson@axis.com>,
 lguest@lists.ozlabs.org, Russell King <linux@arm.linux.org.uk>,
 linux-c6x-dev@linux-c6x.org, Len Brown <len.brown@intel.com>,
 "David S. Miller" <davem@davemloft.net>, linux-hexagon@vger.kernel.org,
 Hirokazu Takata <takata@linux-m32r.org>, linux-sh@vger.kernel.org,
 "James E.J. Bottomley" <jejb@parisc-linux.org>, linux-acpi@vger.kernel.org,
 Ingo Molnar <mingo@redhat.com>, Geert Uytterhoeven <geert@linux-m68k.org>,
 Mark Salter <msalter@redhat.com>, xen-devel@lists.xenproject.org,
 Matt Turner <mattst88@gmail.com>, Chen Liqin <liqin.linux@gmail.com>,
 Jonas Bonn <jonas@southpole.se>, Haavard Skinnemoen <hskinnemoen@gmail.com>,
 devicetree@vger.kernel.org, James Hogan <james.hogan@imgtec.com>,
 user-mode-linux-devel@lists.sourceforge.net, linux-pm@vger.kernel.org,
 Aurelien Jacquiot <a-jacquiot@ti.com>,
 Heiko Carstens <heiko.carstens@de.ibm.com>, Jeff Dike <jdike@addtoit.com>,
 adi-buildroot-devel@lists.sourceforge.net, Chris Metcalf <cmetcalf@tilera.com>,
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
 Mikael Starvik <starvik@axis.com>, Richard Weinberger <richard@nod.at>,
 linux-m68k@lists.linux-m68k.org, linux-am33-list@redhat.com,
 Ivan Kokshaysky <ink@jurassic.park.msu.ru>, linux-tegra@vger.kernel.org,
 openipmi-developer@lists.sourceforge.net, linux-metag@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, Richard Henderson <rth@twiddle.net>,
 Chris Zankel <chris@zankel.net>, Michal Simek <monstr@monstr.eu>,
 Tony Luck <tony.luck@intel.com>, linux-parisc@vger.kernel.org,
 linux-cris-kernel@axis.com, Vineet Gupta <vgupta@synopsys.com>,
 "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-kernel@vger.kernel.org,
 Fenghua Yu <fenghua.yu@intel.com>, Richard Kuo <rkuo@codeaurora.org>,
 David Vrabel <david.vrabel@citrix.com>, linux-alpha@vger.kernel.org,
 Martin Schwidefsky <schwidefsky@de.ibm.com>,
 Koichi Yasutake <yasutake.koichi@jp.panasonic.com>,
 linuxppc-dev@lists.ozlabs.org, Helge Deller <deller@gmx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 10/09/2014 03:38 AM, Pavel Machek wrote:
> Hi!
>
>> @@ -184,6 +179,8 @@ machine_halt(void)
>>   void
>>   machine_power_off(void)
>>   {
>> +	do_kernel_poweroff();
>> +
>
> poweroff -> power_off for consistency.
>
Dunno; matter of personal preference. I started with that, but ultimately went
with poweroff to distinguish poweroff handler functions from existing code,
specifically kernel_power_off().

Does anyone else have an opinion ?

>
>> index c4f50a3..1da27d1 100644
>> --- a/arch/blackfin/kernel/reboot.c
>> +++ b/arch/blackfin/kernel/reboot.c
>> @@ -106,6 +107,7 @@ void machine_halt(void)
>>   __attribute__((weak))
>>   void native_machine_power_off(void)
>>   {
>> +	do_kernel_poweroff();
>>   	idle_with_irq_disabled();
>>   }
>>
>
> So here we handle do_kernel_poweroff() returning,
>
>> diff --git a/arch/cris/kernel/process.c b/arch/cris/kernel/process.c
>> index b78498e..eaafad0 100644
>> --- a/arch/cris/kernel/process.c
>> +++ b/arch/cris/kernel/process.c
>> @@ -60,6 +57,7 @@ void machine_halt(void)
>>
>>   void machine_power_off(void)
>>   {
>> +	do_kernel_poweroff();
>>   }
>>
>
>
> Here we don't.
>
>> diff --git a/arch/frv/kernel/process.c b/arch/frv/kernel/process.c
>> index 5d40aeb77..a673725 100644
>> --- a/arch/frv/kernel/process.c
>> +++ b/arch/frv/kernel/process.c
>> @@ -107,6 +104,8 @@ void machine_power_off(void)
>>   	gdbstub_exit(0);
>>   #endif
>>
>> +	do_kernel_poweroff();
>> +
>>   	for (;;);
>>   }
>>
>
> And here we do.
>
> What is right?
> 								Pavel

Up to the architecture maintainer to decide. My goal was to not change
existing behavior if no poweroff handler is registered.

Guenter
