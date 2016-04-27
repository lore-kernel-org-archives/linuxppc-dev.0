Return-Path: <linux+linuxppc-dev=lists.ozlabs.org@arm.linux.org.uk>
Received: from pandora.arm.linux.org.uk (pandora.arm.linux.org.uk
 [IPv6:2001:4d48:ad52:3201:214:fdff:fe10:1be6])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qvvt62lcXzDq5s
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Apr 2016 19:34:04 +1000 (AEST)
Date: Wed, 27 Apr 2016 10:31:45 +0100
From: Russell King - ARM Linux <linux@arm.linux.org.uk>
To: Petr Mladek <pmladek@suse.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Peter Zijlstra <peterz@infradead.org>,
 Steven Rostedt <rostedt@goodmis.org>,
 Daniel Thompson <daniel.thompson@linaro.org>,
 Jiri Kosina <jkosina@suse.com>, Ingo Molnar <mingo@redhat.com>,
 Thomas Gleixner <tglx@linutronix.de>,
 Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
 Chris Metcalf <cmetcalf@ezchip.com>, linux-kernel@vger.kernel.org,
 x86@kernel.org, linux-arm-kernel@lists.infradead.org,
 adi-buildroot-devel@lists.sourceforge.net,
 linux-cris-kernel@axis.com, linux-mips@linux-mips.org,
 linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
 linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
 Jan Kara <jack@suse.cz>, Ralf Baechle <ralf@linux-mips.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Martin Schwidefsky <schwidefsky@de.ibm.com>,
 David Miller <davem@davemloft.net>
Subject: Re: [PATCH v5 1/4] printk/nmi: generic solution for safe printk in NMI
Message-ID: <20160427093145.GJ19428@n2100.arm.linux.org.uk>
References: <1461239325-22779-1-git-send-email-pmladek@suse.com>
 <1461239325-22779-2-git-send-email-pmladek@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1461239325-22779-2-git-send-email-pmladek@suse.com>
Sender: Russell King - ARM Linux <linux@arm.linux.org.uk>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Apr 21, 2016 at 01:48:42PM +0200, Petr Mladek wrote:
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index cdfa6c2b7626..259543ec6dc9 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -66,6 +66,7 @@ config ARM
>  	select HAVE_KRETPROBES if (HAVE_KPROBES)
>  	select HAVE_MEMBLOCK
>  	select HAVE_MOD_ARCH_SPECIFIC
> +	select HAVE_NMI
>  	select HAVE_OPROFILE if (HAVE_PERF_EVENTS)
>  	select HAVE_OPTPROBES if !THUMB2_KERNEL
>  	select HAVE_PERF_EVENTS
> diff --git a/arch/arm/kernel/smp.c b/arch/arm/kernel/smp.c
> index baee70267f29..df90bc59bfce 100644
> --- a/arch/arm/kernel/smp.c
> +++ b/arch/arm/kernel/smp.c
> @@ -644,9 +644,11 @@ void handle_IPI(int ipinr, struct pt_regs *regs)
>  		break;
>  
>  	case IPI_CPU_BACKTRACE:
> +		printk_nmi_enter();
>  		irq_enter();
>  		nmi_cpu_backtrace(regs);
>  		irq_exit();
> +		printk_nmi_exit();
>  		break;
>  
>  	default:

For the above,

Acked-by: Russell King <rmk+kernel@arm.linux.org.uk>

-- 
RMK's Patch system: http://www.arm.linux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
