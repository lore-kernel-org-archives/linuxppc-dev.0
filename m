Return-Path: <paulus@ozlabs.org>
Date: Mon, 9 Sep 2013 16:00:29 +1000
From: Paul Mackerras <paulus@samba.org>
To: Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>
Subject: Re: [RFC PATCH v3 07/12] powerpc/book3s: Flush SLB/TLBs if we get
 SLB/TLB machine check errors on power7.
Message-ID: <20130909060029.GG6248@drongo>
References: <20130826192616.2855.18749.stgit@mars>
 <20130826193212.2855.38138.stgit@mars>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20130826193212.2855.38138.stgit@mars>
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>,
 Jeremy Kerr <jeremy.kerr@au1.ibm.com>, Anton Blanchard <anton@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Aug 27, 2013 at 01:02:12AM +0530, Mahesh J Salgaonkar wrote:
> From: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
> 
> If we get a machine check exception due to SLB or TLB errors, then flush
> SLBs/TLBs and reload SLBs to recover. We do this in real mode before turning
> on MMU. Otherwise we would run into nested machine checks.
> 
> If we get a machine check when we are in guest, then just flush the
> SLBs and continue. This patch handles errors for power7. The next
> patch will handle errors for power8

Some comments...

> +/* PPC bit number conversion */
> +#define PPC_BIT(bit)		(0x8000000000000000UL >> (bit))
> +#define PPC_BITLSHIFT(be)	(63 - (be))
> +#define PPC_BITMASK(bs, be)	((PPC_BIT(bs) - PPC_BIT(be)) | PPC_BIT(bs))

This will break if anyone is so incautious as to use this in a 32-bit
kernel.  It would be kinder to do:

#define PPC_BITLSHIFT(be)	(BITS_PER_LONG - 1 - (be))
#define PPC_BIT(bit)		(1ul << PPC_BITLSHIFT(bit))

> +/* SRR1 bits for machine check (On Power7 and Power8) */
> +#define P7_SRR1_MC_IFETCH(srr1)	((srr1) & PPC_BITMASK(43, 45)) /* P8 too */
> +
> +#define P7_SRR1_MC_IFETCH_UE		(0x1 << PPC_BITLSHIFT(45)) /* P8 too */
> +#define P7_SRR1_MC_IFETCH_SLB_PARITY	(0x2 << PPC_BITLSHIFT(45)) /* P8 too */
> +#define P7_SRR1_MC_IFETCH_SLB_MULTIHIT	(0x3 << PPC_BITLSHIFT(45)) /* P8 too */
> +#define P7_SRR1_MC_IFETCH_SLB_BOTH	(0x4 << PPC_BITLSHIFT(45)) /* P8 too */
> +#define P7_SRR1_MC_IFETCH_TLB_MULTIHIT	(0x5 << PPC_BITLSHIFT(45)) /* P8 too */
> +#define P7_SRR1_MC_IFETCH_UE_TLB_RELOAD	(0x6 << PPC_BITLSHIFT(45)) /* P8 too */
> +#define P7_SRR1_MC_IFETCH_UE_IFU_INTERNAL	(0x7 << PPC_BITLSHIFT(45))
> +
> +/* SRR1 bits for machine check (On Power8) */
> +#define P8_SRR1_MC_IFETCH_ERAT_MULTIHIT	(0x4 << PPC_BITLSHIFT(45))

How do we tell the difference between that and P7_SRR1_MC_IFETCH_SLB_BOTH?

> +/* flush SLBs and reload */
> +static void flush_and_reload_slb(void)
> +{
> +	struct slb_shadow *slb;
> +	unsigned long i, n;
> +
> +	if (!mmu_has_feature(MMU_FTR_SLB))
> +		return;

This seems unnecessary when we can only call this on POWER7.

Paul.
