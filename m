Return-Path: <sshtylyov@ru.mvista.com>
Received: from imap.sh.mvista.com (unknown [63.81.120.155])
	by ozlabs.org (Postfix) with ESMTP id 75EB1DDF4F
	for <linuxppc-dev@ozlabs.org>; Thu,  8 Mar 2007 01:38:30 +1100 (EST)
Message-ID: <45EECE5C.6030100@ru.mvista.com>
Date: Wed, 07 Mar 2007 17:38:20 +0300
From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
MIME-Version: 1.0
To: Tsutomu OWA <tsutomu.owa@toshiba.co.jp>
Subject: Re: [patch 2/6 -rt] powerpc 2.6.20-rt8: to convert spinlocks to raw
	ones.
References: <yyi8xe925vg.wl@toshiba.co.jp> <yyi649d25qz.wl@toshiba.co.jp>
In-Reply-To: <yyi649d25qz.wl@toshiba.co.jp>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: linuxppc-dev@ozlabs.org, mingo@elte.hu, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hello.

Tsutomu OWA wrote:

> --- linux-rt8/arch/powerpc/kernel/irq.c	2007-02-20 14:30:38.000000000 +0900
> +++ rt/arch/powerpc/kernel/irq.c	2007-03-05 18:54:34.000000000 +0900
> @@ -392,7 +392,7 @@ EXPORT_SYMBOL(do_softirq);
>  #ifdef CONFIG_PPC_MERGE
>  
>  static LIST_HEAD(irq_hosts);
> -static spinlock_t irq_big_lock = SPIN_LOCK_UNLOCKED;
> +static DEFINE_RAW_SPINLOCK(irq_big_lock);
>  static DEFINE_PER_CPU(unsigned int, irq_radix_reader);
>  static unsigned int irq_radix_writer;
>  struct irq_map_entry irq_map[NR_IRQS];

    I've already sent a patch fixing this one (along with many others) a month 
ago:

http://ozlabs.org/pipermail/linuxppc-dev/2007-February/031164.html

    I wonder iof it was ever considered... :-/

WBR, Sergei
