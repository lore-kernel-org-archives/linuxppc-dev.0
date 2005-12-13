Return-Path: <olof@lixom.net>
Date: Tue, 13 Dec 2005 08:58:07 -0800
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Message-ID: <20051213165807.GA7468@pb15.lixom.net>
References: <1134457469.6989.189.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1134457469.6989.189.camel@gaston>
From: Olof Johansson <olof@lixom.net>
Cc: linuxppc64-dev <linuxppc64-dev@ozlabs.org>,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>
Subject: Re: [PATCH] powerpc: Update MPIC workarounds
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Dec 13, 2005 at 06:04:29PM +1100, Benjamin Herrenschmidt wrote:
> From: Segher Boessenkool <segher@kernel.crashing.org>
> 
> Cleanup the MPIC IO-APIC workarounds, make them a bit more generic,
> smaller and faster. 

I really don't like all the hand-coded constants in this code. They're
all over the place, and there's no descriptions of what they are there
for. Lots of hardcoded offsets, etc. Since this is a cleanup, wouldn't
it be a good time to use symbolic constands and/or comment them up a
bit?

> Index: linux-work/arch/powerpc/sysdev/mpic.c
> ===================================================================
> --- linux-work.orig/arch/powerpc/sysdev/mpic.c	2005-12-06 16:17:43.000000000 +1100
> +++ linux-work/arch/powerpc/sysdev/mpic.c	2005-12-07 13:30:45.000000000 +1100
> @@ -175,57 +175,57 @@ static inline int mpic_is_ht_interrupt(s
>  	return mpic->fixups[source_no].base != NULL;
>  }
>  
> +
>  static inline void mpic_apic_end_irq(struct mpic *mpic, unsigned int source_no)
>  {
>  	struct mpic_irq_fixup *fixup = &mpic->fixups[source_no];
> -	u32 tmp;
>  
>  	spin_lock(&mpic->fixup_lock);
> -	writeb(0x11 + 2 * fixup->irq, fixup->base);
> -	tmp = readl(fixup->base + 2);
> -	writel(tmp | 0x80000000ul, fixup->base + 2);
> -	/* config writes shouldn't be posted but let's be safe ... */
> -	(void)readl(fixup->base + 2);
> +	writeb(0x11 + 2 * fixup->irq, fixup->base + 2);
> +	writel(fixup->data, fixup->base + 4);

This seems like a functional change: Previous code wrote at base, new at
base+2?


-Olof
