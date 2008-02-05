Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 36F5CDDEFC
	for <linuxppc-dev@ozlabs.org>; Wed,  6 Feb 2008 07:48:04 +1100 (EST)
Subject: Re: [RFC][PATCH] PowerPC: 4xx PCIe indirect DCR spinlock fix.
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Valentine Barshak <vbarshak@ru.mvista.com>
In-Reply-To: <20080205183649.GA5136@ru.mvista.com>
References: <20080205183649.GA5136@ru.mvista.com>
Content-Type: text/plain
Date: Wed, 06 Feb 2008 07:47:41 +1100
Message-Id: <1202244461.7079.65.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Tue, 2008-02-05 at 21:36 +0300, Valentine Barshak wrote:
> Since we have mfdcri() and mtdcri() as macros, we can't use constructions, such
> as "mtdcri(base, reg, mfdcri(base, reg) | val)". In this case the mfdcri() stuff
> is not evaluated first. It's evaluated inside the mtdcri() macro and we have
> the dcr_ind_lock spinlock acquired twice. To avoid this error, I've added
> __mfdcri()/__mtdcri() inline functions that take the lock after register name
> fix-up.
> 
> Signed-off-by: Valentine Barshak <vbarshak@ru.mvista.com>

Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

> ---
>  include/asm-powerpc/dcr-native.h |   49 +++++++++++++++++++++++----------------
>  1 files changed, 30 insertions(+), 19 deletions(-)
> 
> diff -pruN linux-2.6.orig/include/asm-powerpc/dcr-native.h linux-2.6.bld/include/asm-powerpc/dcr-native.h
> --- linux-2.6.orig/include/asm-powerpc/dcr-native.h	2008-02-05 16:44:54.000000000 +0300
> +++ linux-2.6.bld/include/asm-powerpc/dcr-native.h	2008-02-05 19:11:55.000000000 +0300
> @@ -59,25 +59,36 @@ do {								\
>  /* R/W of indirect DCRs make use of standard naming conventions for DCRs */
>  extern spinlock_t dcr_ind_lock;
>  
> -#define mfdcri(base, reg)				\
> -({							\
> -	unsigned long flags; 				\
> -	unsigned int val;				\
> -	spin_lock_irqsave(&dcr_ind_lock, flags);	\
> -	mtdcr(DCRN_ ## base ## _CONFIG_ADDR, reg);	\
> -	val = mfdcr(DCRN_ ## base ## _CONFIG_DATA);	\
> -	spin_unlock_irqrestore(&dcr_ind_lock, flags);	\
> -	val;						\
> -})
> -
> -#define mtdcri(base, reg, data)				\
> -do {							\
> -	unsigned long flags; 				\
> -	spin_lock_irqsave(&dcr_ind_lock, flags);	\
> -	mtdcr(DCRN_ ## base ## _CONFIG_ADDR, reg);	\
> -	mtdcr(DCRN_ ## base ## _CONFIG_DATA, data);	\
> -	spin_unlock_irqrestore(&dcr_ind_lock, flags);	\
> -} while (0)
> +static inline unsigned __mfdcri(int base_addr, int base_data, int reg)
> +{
> +	unsigned long flags;
> +	unsigned int val;
> +
> +	spin_lock_irqsave(&dcr_ind_lock, flags);
> +	__mtdcr(base_addr, reg);
> +	val = __mfdcr(base_data);
> +	spin_unlock_irqrestore(&dcr_ind_lock, flags);
> +	return val;
> +}
> +
> +static inline void __mtdcri(int base_addr, int base_data, int reg,
> +			    unsigned val)
> +{
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&dcr_ind_lock, flags);
> +	__mtdcr(base_addr, reg);
> +	__mtdcr(base_data, val);
> +	spin_unlock_irqrestore(&dcr_ind_lock, flags);
> +}
> +
> +#define mfdcri(base, reg)	__mfdcri(DCRN_ ## base ## _CONFIG_ADDR,	\
> +					 DCRN_ ## base ## _CONFIG_DATA,	\
> +					 reg)
> +
> +#define mtdcri(base, reg, data)	__mtdcri(DCRN_ ## base ## _CONFIG_ADDR,	\
> +					 DCRN_ ## base ## _CONFIG_DATA,	\
> +					 reg, data)
>  
>  #endif /* __ASSEMBLY__ */
>  #endif /* __KERNEL__ */
