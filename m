Return-Path: <michael@ellerman.id.au>
Message-ID: <1339123423.3330.5.camel@concordia>
Subject: Re: [PATCH 5/5] powerpc: iommu: Implement IOMMU pools to improve
 multiqueue adapter performance
From: Michael Ellerman <michael@ellerman.id.au>
To: Anton Blanchard <anton@samba.org>
Date: Fri, 08 Jun 2012 12:43:43 +1000
In-Reply-To: <20120604154519.48ea1aa9@kryten>
References: <20120604154213.173feecb@kryten> <20120604154519.48ea1aa9@kryten>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: olof@lixom.net, paulus@samba.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2012-06-04 at 15:45 +1000, Anton Blanchard wrote:
> At the moment all queues in a multiqueue adapter will serialise
> against the IOMMU table lock. This is proving to be a big issue,
> especially with 10Gbit ethernet.

..

> +
>  struct iommu_table {
>  	unsigned long  it_busno;     /* Bus number this table belongs to */
>  	unsigned long  it_size;      /* Size of iommu table in entries */
> @@ -61,10 +71,10 @@ struct iommu_table {
>  	unsigned long  it_index;     /* which iommu table this is */
>  	unsigned long  it_type;      /* type: PCI or Virtual Bus */
>  	unsigned long  it_blocksize; /* Entries in each block (cacheline) */
> -	unsigned long  it_hint;      /* Hint for next alloc */
> -	unsigned long  it_largehint; /* Hint for large allocs */
> -	unsigned long  it_halfpoint; /* Breaking point for small/large allocs */
> -	spinlock_t     it_lock;      /* Protects it_map */
> +	unsigned long  poolsize;
> +	unsigned long  nr_pools;
> +	struct iommu_pool large_pool;
> +	struct iommu_pool pools[IOMMU_NR_POOLS];
>  	unsigned long *it_map;       /* A simple allocation bitmap for now */
>  };
>  

Breaks the cell code with:

arch/powerpc/platforms/cell/iommu.c:521:15: error: 'struct iommu_table' has no member named 'it_hint'


cheers
