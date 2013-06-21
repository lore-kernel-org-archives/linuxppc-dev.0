Return-Path: <santosh.shilimkar@ti.com>
Message-ID: <51C48B5A.2040404@ti.com>
Date: Fri, 21 Jun 2013 13:20:26 -0400
From: Santosh Shilimkar <santosh.shilimkar@ti.com>
MIME-Version: 1.0
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, <robherring2@gmail.com>
Subject: Re: [PATCH] of: Specify initrd location using 64-bit
References: <1371775956-16453-1-git-send-email-santosh.shilimkar@ti.com>
 <51C4171C.9050908@linutronix.de>
In-Reply-To: <51C4171C.9050908@linutronix.de>
Content-Type: text/plain; charset="ISO-8859-1"
Cc: Nicolas Pitre <nicolas.pitre@linaro.org>, linux-mips@linux-mips.org,
 Catalin Marinas <catalin.marinas@arm.com>,
 Aurelien Jacquiot <a-jacquiot@ti.com>, Will Deacon <will.deacon@arm.com>,
 Max Filippov <jcmvbkbc@gmail.com>, Paul Mackerras <paulus@samba.org>,
 Jonas Bonn <jonas@southpole.se>, Russell King <linux@arm.linux.org.uk>,
 linux-c6x-dev@linux-c6x.org, x86@kernel.org, arm@kernel.org,
 Mark Salter <msalter@redhat.com>, Grant Likely <grant.likely@linaro.org>,
 linux-xtensa@linux-xtensa.org, James Hogan <james.hogan@imgtec.com>,
 devicetree-discuss@lists.ozlabs.org, Rob Herring <rob.herring@calxeda.com>,
 linux-arm-kernel@lists.infradead.org, Chris Zankel <chris@zankel.net>,
 Michal Simek <monstr@monstr.eu>, Vineet Gupta <vgupta@synopsys.com>,
 linux-kernel@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Friday 21 June 2013 05:04 AM, Sebastian Andrzej Siewior wrote:
> On 06/21/2013 02:52 AM, Santosh Shilimkar wrote:
>> diff --git a/arch/microblaze/kernel/prom.c b/arch/microblaze/kernel/prom.c
>> index 0a2c68f..62e2e8f 100644
>> --- a/arch/microblaze/kernel/prom.c
>> +++ b/arch/microblaze/kernel/prom.c
>> @@ -136,8 +136,7 @@ void __init early_init_devtree(void *params)
>>  }
>>  
>>  #ifdef CONFIG_BLK_DEV_INITRD
>> -void __init early_init_dt_setup_initrd_arch(unsigned long start,
>> -		unsigned long end)
>> +void __init early_init_dt_setup_initrd_arch(u64 start, u64 end)
>>  {
>>  	initrd_start = (unsigned long)__va(start);
>>  	initrd_end = (unsigned long)__va(end);
> 
> I think it would better to go here for phys_addr_t instead of u64. This
> would force you in of_flat_dt_match() to check if the value passed from
> DT specifies a memory address outside of 32bit address space and the
> kernel can't deal with this because its phys_addr_t is 32bit only due
> to a Kconfig switch.
> 
> For x86, the initrd has to remain in the 32bit address space so passing
> the initrd in the upper range would violate the ABI. Not sure if this
> is true for other archs as well (ARM obviously not).
> 
That pretty much means phys_addr_t. It will work for me as well but
in last thread from consistency with memory and reserved node, Rob
insisted to keep it as u64. So before I re-spin another version,
would like to here what Rob has to say considering the x86 requirement.

Rob,
Are you ok with phys_addr_t since your concern was about rest
of the memory specific bits of the device-tree code use u64 ?

Regards,
Santosh
