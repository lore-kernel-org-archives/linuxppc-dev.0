Return-Path: <mingo@elte.hu>
Received: from mx3.mail.elte.hu (mx3.mail.elte.hu [157.181.1.138])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 94804DDF18
	for <linuxppc-dev@ozlabs.org>; Thu, 31 Jan 2008 08:50:39 +1100 (EST)
Date: Wed, 30 Jan 2008 22:50:15 +0100
From: Ingo Molnar <mingo@elte.hu>
To: travis@sgi.com
Subject: Re: [PATCH 2/6] percpu: Change Kconfig to HAVE_SETUP_PER_CPU_AREA
	linux-2.6.git
Message-ID: <20080130215015.GA28242@elte.hu>
References: <20080130180940.022172000@sgi.com>
	<20080130180940.369732000@sgi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20080130180940.369732000@sgi.com>
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


* travis@sgi.com <travis@sgi.com> wrote:

> Change:
> 	config ARCH_SETS_UP_PER_CPU_AREA
> to:
> 	config HAVE_SETUP_PER_CPU_AREA

undocumented change:

>  config ARCH_NO_VIRT_TO_BUS
> --- a/init/main.c
> +++ b/init/main.c
> @@ -380,6 +380,8 @@ static void __init setup_per_cpu_areas(v
>  
>  	/* Copy section for each CPU (we discard the original) */
>  	size = ALIGN(PERCPU_ENOUGH_ROOM, PAGE_SIZE);
> +	printk(KERN_INFO
> +	    "PERCPU: Allocating %lu bytes of per cpu data (main)\n", size);
>  	ptr = alloc_bootmem_pages(size * nr_possible_cpus);

but looks fine to me.

	Ingo
