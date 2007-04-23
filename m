Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id 6AA22DDEF7
	for <linuxppc-dev@ozlabs.org>; Mon, 23 Apr 2007 13:31:21 +1000 (EST)
Date: Sun, 22 Apr 2007 22:50:25 -0500
To: Michael Ellerman <michael@ellerman.id.au>
Subject: Re: [PATCH 6/7] MPIC MSI allocator
Message-ID: <20070423035025.GA29839@lixom.net>
References: <1176968125.531108.326168797246.qpush@cradle>
	<20070419073555.D2C3EDDEFD@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070419073555.D2C3EDDEFD@ozlabs.org>
From: olof@lixom.net (Olof Johansson)
Cc: linuxppc-dev@ozlabs.org, linux-pci@atrey.karlin.mff.cuni.cz
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Apr 19, 2007 at 05:35:28PM +1000, Michael Ellerman wrote:
> To support MSI on MPIC we need a way to reserve and allocate hardware irq
> numbers, this patch implements an allocator for that.
> 
> New firmware platforms must define a "msi-available-ranges" property on their
> MPIC node for MSI to work. For BROKEN_U3 we do a best-guess setup.

It's time to rename BROKEN_U3. It used to be the config option to enable
a few workarounds, but now it's used to select whenever there's a U3 in
the system. Care to do it in the scope of this patch set?

> Index: msi-new/include/asm-powerpc/mpic.h
> ===================================================================
> --- msi-new.orig/include/asm-powerpc/mpic.h
> +++ msi-new/include/asm-powerpc/mpic.h
> @@ -292,6 +292,11 @@ struct mpic
>  	u32			*hw_set;
>  #endif
>  
> +#ifdef CONFIG_PCI_MSI
> +	spinlock_t		bitmap_lock;
> +	unsigned long		*hwirq_bitmap;
> +#endif

Besides the #ifdef there's nothing in the name that indicates that it's
used for msi. Better names could be useful.

> @@ -440,5 +445,11 @@ void mpic_set_clk_ratio(struct mpic *mpi
>  /* Enable/Disable EPIC serial interrupt mode */
>  void mpic_set_serial_int(struct mpic *mpic, int enable);
>  
> +#ifdef CONFIG_PCI_MSI
> +extern int mpic_msi_init_allocator(struct mpic *mpic);
> +extern irq_hw_number_t mpic_msi_alloc_hwirqs(struct mpic *mpic, int num);
> +extern void mpic_msi_free_hwirqs(struct mpic *mpic, int offset, int num);
> +#endif

These should go in mpic.h instead.


-Olof
