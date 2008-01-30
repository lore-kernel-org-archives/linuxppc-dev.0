Return-Path: <travis@sgi.com>
Received: from relay.sgi.com (relay1.sgi.com [192.48.171.29])
	by ozlabs.org (Postfix) with ESMTP id 4CA89DDF36
	for <linuxppc-dev@ozlabs.org>; Thu, 31 Jan 2008 08:57:37 +1100 (EST)
Message-ID: <47A0F2CB.3070204@sgi.com>
Date: Wed, 30 Jan 2008 13:57:31 -0800
From: Mike Travis <travis@sgi.com>
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH 2/6] percpu: Change Kconfig to HAVE_SETUP_PER_CPU_AREA
	linux-2.6.git
References: <20080130180940.022172000@sgi.com>
	<20080130180940.369732000@sgi.com> <20080130215015.GA28242@elte.hu>
In-Reply-To: <20080130215015.GA28242@elte.hu>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Tony Luck <tony.luck@intel.com>, linux-ia64@vger.kernel.org,
	linuxppc-dev@ozlabs.org, Sam Ravnborg <sam@ravnborg.org>,
	Rusty Russell <rusty@rustcorp.com.au>,
	linux-kernel@vger.kernel.org, Andi Kleen <ak@suse.de>, linux-mm@kvack.org,
	Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	David Miller <davem@davemloft.net>, Christoph Lameter <clameter@sgi.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Ingo Molnar wrote:
> * travis@sgi.com <travis@sgi.com> wrote:
> 
>> Change:
>> 	config ARCH_SETS_UP_PER_CPU_AREA
>> to:
>> 	config HAVE_SETUP_PER_CPU_AREA
> 
> undocumented change:
> 
>>  config ARCH_NO_VIRT_TO_BUS
>> --- a/init/main.c
>> +++ b/init/main.c
>> @@ -380,6 +380,8 @@ static void __init setup_per_cpu_areas(v
>>  
>>  	/* Copy section for each CPU (we discard the original) */
>>  	size = ALIGN(PERCPU_ENOUGH_ROOM, PAGE_SIZE);
>> +	printk(KERN_INFO
>> +	    "PERCPU: Allocating %lu bytes of per cpu data (main)\n", size);
>>  	ptr = alloc_bootmem_pages(size * nr_possible_cpus);
> 
> but looks fine to me.
> 
> 	Ingo

Sorry, I should have noted this.  The primary reason I put this in, is
that if the HAVE_SETUP_PER_CPU_AREA is not set when it should be, then
the incorrect (generic) setup_per_cpu_areas() is used and weird things
happen later on.  The above line documents that PERCPU has been allocated
by init/main.c version of this function in the startup messages.
(Since it's a static function, there is no "duplicate label" error in
the linker.)

Thanks,
Mike
