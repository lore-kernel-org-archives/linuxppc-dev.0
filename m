Return-Path: <tglx@linutronix.de>
Date: Tue, 27 Apr 2010 15:42:11 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
To: Guillaume Knispel <gknispel@proformatique.com>
Subject: Re: [PATCH 1/2] genirq: reliably replay pending edge-triggered irq
In-Reply-To: <1271941798-9659-2-git-send-email-gknispel@proformatique.com>
Message-ID: <alpine.LFD.2.00.1004271537130.2951@localhost.localdomain>
References: <1271941798-9659-1-git-send-email-gknispel@proformatique.com>
	<1271941798-9659-2-git-send-email-gknispel@proformatique.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Lars-Peter Clausen <lars@metafoo.de>, Russell King <linux@arm.linux.org.uk>,
	Haavard Skinnemoen <hskinnemoen@atmel.com>,
	Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
	Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Michael Buesch <mb@bu3sch.de>, Ingo Molnar <mingo@elte.hu>,
	Linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 22 Apr 2010, Guillaume Knispel wrote:

> When the critical section in handle_edge_irq() is executed after
> IRQ_DISABLED has been set in the one in disable_irq(), the interrupt is

  in the one ? -ENOPARSE

> acked and masked at controller level and IRQ_PENDING is set.
> ---
>  arch/arm/Kconfig                                   |    4 ----
>  arch/arm/configs/acs5k_defconfig                   |    1 -
>  arch/arm/configs/acs5k_tiny_defconfig              |    1 -

   Changing the defconfigs should be a separate patch and I'm not
   going to push such a thing through the genirq tree. The stale
   entries do not hurt.

> diff --git a/arch/x86/kernel/apic/io_apic.c b/arch/x86/kernel/apic/io_apic.c
> index 127b871..9bec343 100644
> --- a/arch/x86/kernel/apic/io_apic.c
> +++ b/arch/x86/kernel/apic/io_apic.c
> @@ -1423,7 +1423,7 @@ int setup_ioapic_entry(int apic_id, int irq,
>  	entry->polarity = polarity;
>  
>  	/* Mask level triggered irqs.
> -	 * Use IRQ_DELAYED_DISABLE for edge triggered irqs.
> +	 * Edge triggered irqs can be resent by software.

  That change is unrelated and should be done in a seperate patch.

Thanks,

	tglx
