Return-Path: <hch@lst.de>
Received: from mail.lst.de (verein.lst.de [213.95.11.210])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 7BAF5DDE37
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Jul 2007 20:33:30 +1000 (EST)
Date: Wed, 11 Jul 2007 12:33:08 +0200
From: Christoph Hellwig <hch@lst.de>
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
Subject: Re: [PATCH] Consolidate mm_context_t definition in mmu.h
Message-ID: <20070711103308.GA15536@lst.de>
References: <1184079709.32199.6.camel@weaponx.rchland.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1184079709.32199.6.camel@weaponx.rchland.ibm.com>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org, david@gibson.dropbear.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Jul 10, 2007 at 10:01:49AM -0500, Josh Boyer wrote:
> +
> +#ifdef CONFIG_PPC64
> +typedef unsigned long mm_context_id_t;
> +
> +typedef struct {
> +	mm_context_id_t id;
> +	u16 user_psize;		/* page size index */
> +
> +#ifdef CONFIG_PPC_MM_SLICES
> +	u64 low_slices_psize;	/* SLB page size encodings */
> +	u64 high_slices_psize;  /* 4 bits per slice for now */
> +#else
> +	u16 sllp;		/* SLB page size encoding */
> +#endif
> +	unsigned long vdso_base;
> +} mm_context_t;
> +
> +#else /* !CONFIG_PPC64 */
> +
> +typedef struct {
> +	unsigned long id;
> +	unsigned long vdso_base;
> +} mm_context_t;

mm_context_id_t isn't actually used anywhere but in te mm_context_t
definition.  So if you kill it you have two common fields and a bunch
of additional ones for PPC64 leading to a defintion like:

typedef struct {
	unsigned long id;

#ifdef CONFIG_PPC64
	u16 user_psize;		/* page size index */

#ifdef CONFIG_PPC_MM_SLICES
	u64 low_slices_psize;	/* SLB page size encodings */
	u64 high_slices_psize;  /* 4 bits per slice for now */
#else
	u16 sllp;		/* SLB page size encoding */
#endif
#endif

	unsigned long vdso_base;
} mm_context_t;
