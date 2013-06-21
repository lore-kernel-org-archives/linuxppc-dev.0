Return-Path: <bigeasy@linutronix.de>
Received: from Galois.linutronix.de (www.linutronix.de [62.245.132.108])
 (using TLSv1 with cipher AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 882182C0315
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Jun 2013 19:05:04 +1000 (EST)
Message-ID: <51C4171C.9050908@linutronix.de>
Date: Fri, 21 Jun 2013 11:04:28 +0200
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
MIME-Version: 1.0
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: Re: [PATCH] of: Specify initrd location using 64-bit
References: <1371775956-16453-1-git-send-email-santosh.shilimkar@ti.com>
In-Reply-To: <1371775956-16453-1-git-send-email-santosh.shilimkar@ti.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Nicolas Pitre <nicolas.pitre@linaro.org>, linux-mips@linux-mips.org,
 Catalin Marinas <catalin.marinas@arm.com>,
 Aurelien Jacquiot <a-jacquiot@ti.com>, Will Deacon <will.deacon@arm.com>,
 Max Filippov <jcmvbkbc@gmail.com>, Paul Mackerras <paulus@samba.org>,
 Jonas Bonn <jonas@southpole.se>, Russell King <linux@arm.linux.org.uk>,
 linux-c6x-dev@linux-c6x.org, x86@kernel.org, arm@kernel.org,
 robherring2@gmail.com, Mark Salter <msalter@redhat.com>,
 Grant Likely <grant.likely@linaro.org>, linux-xtensa@linux-xtensa.org,
 James Hogan <james.hogan@imgtec.com>, devicetree-discuss@lists.ozlabs.org,
 Rob Herring <rob.herring@calxeda.com>, linux-arm-kernel@lists.infradead.org,
 Chris Zankel <chris@zankel.net>, Michal Simek <monstr@monstr.eu>,
 Vineet Gupta <vgupta@synopsys.com>, linux-kernel@vger.kernel.org,
 Ralf Baechle <ralf@linux-mips.org>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 06/21/2013 02:52 AM, Santosh Shilimkar wrote:
> diff --git a/arch/microblaze/kernel/prom.c b/arch/microblaze/kernel/prom.c
> index 0a2c68f..62e2e8f 100644
> --- a/arch/microblaze/kernel/prom.c
> +++ b/arch/microblaze/kernel/prom.c
> @@ -136,8 +136,7 @@ void __init early_init_devtree(void *params)
>  }
>  
>  #ifdef CONFIG_BLK_DEV_INITRD
> -void __init early_init_dt_setup_initrd_arch(unsigned long start,
> -		unsigned long end)
> +void __init early_init_dt_setup_initrd_arch(u64 start, u64 end)
>  {
>  	initrd_start = (unsigned long)__va(start);
>  	initrd_end = (unsigned long)__va(end);

I think it would better to go here for phys_addr_t instead of u64. This
would force you in of_flat_dt_match() to check if the value passed from
DT specifies a memory address outside of 32bit address space and the
kernel can't deal with this because its phys_addr_t is 32bit only due
to a Kconfig switch.

For x86, the initrd has to remain in the 32bit address space so passing
the initrd in the upper range would violate the ABI. Not sure if this
is true for other archs as well (ARM obviously not).

Sebastian
