Return-Path: <sjitindarsingh@gmail.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vTxqn3KjLzDqHV
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Feb 2017 14:47:01 +1100 (AEDT)
Message-ID: <1487908013.23895.31.camel@gmail.com>
Subject: Re: [RFC NO-MERGE 2/2] arch/powerpc/CAS: Update to new
 option-vector-5 format for CAS
From: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
To: Paul Mackerras <paulus@ozlabs.org>
Cc: linuxppc-dev@ozlabs.org, benh@kernel.crashing.org, mpe@ellerman.id.au,
 ruscur@russell.cc, sam.bobroff@au1.ibm.com
Date: Fri, 24 Feb 2017 14:46:53 +1100
In-Reply-To: <20170223044402.GB6330@fergus.ozlabs.ibm.com>
References: <1487657171-17260-1-git-send-email-sjitindarsingh@gmail.com>
 <1487657171-17260-2-git-send-email-sjitindarsingh@gmail.com>
 <20170223044402.GB6330@fergus.ozlabs.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2017-02-23 at 15:44 +1100, Paul Mackerras wrote:
> On Tue, Feb 21, 2017 at 05:06:11PM +1100, Suraj Jitindar Singh wrote:
> > 
> > The CAS process has been updated to change how the host to guest
> Once again, explain CAS; perhaps "The ibm,client-architecture-support
> (CAS) negotiation process has been updated for POWER9 to ..."
> 
> > 
> > negotiation is done for the new hash/radix mmu as well as the nest
> > mmu,
> > process tables and guest translation shootdown (GTSE).
> > 
> > The host tells the guest which options it supports in
> > ibm,arch-vec-5-platform-support. The guest then chooses a subset of
> > these
> > to request in the CAS call and these are agreed to in the
> > ibm,architecture-vec-5 property of the chosen node.
> > 
> > Thus we read ibm,arch-vec-5-platform-support and make our selection
> > before
> > calling CAS. We then parse the ibm,architecture-vec-5 property of
> > the
> > chosen node to check whether we should run as hash or radix.
> > 
> > Signed-off-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
> > ---
> >  arch/powerpc/include/asm/prom.h | 16 ++++---
> >  arch/powerpc/kernel/prom_init.c | 99
> > +++++++++++++++++++++++++++++++++++++++--
> >  arch/powerpc/mm/init_64.c       | 31 ++++++++++---
> >  3 files changed, 130 insertions(+), 16 deletions(-)
> > 
> > diff --git a/arch/powerpc/include/asm/prom.h
> > b/arch/powerpc/include/asm/prom.h
> > index 8af2546..19d2e84 100644
> > --- a/arch/powerpc/include/asm/prom.h
> > +++ b/arch/powerpc/include/asm/prom.h
> > @@ -158,12 +158,16 @@ struct of_drconf_cell {
> >  #define OV5_PFO_HW_ENCR		0x1120	/* PFO
> > Encryption Accelerator */
> >  #define OV5_SUB_PROCESSORS	0x1501	/* 1,2,or 4 Sub-
> > Processors supported */
> >  #define OV5_XIVE_EXPLOIT	0x1701	/* XIVE exploitation
> > supported */
> > -#define OV5_MMU_RADIX_300	0x1880	/* ISA v3.00 radix
> > MMU supported */
> > -#define OV5_MMU_HASH_300	0x1840	/* ISA v3.00 hash
> > MMU supported */
> > -#define OV5_MMU_SEGM_RADIX	0x1820	/* radix mode (no
> > segmentation) */
> > -#define OV5_MMU_PROC_TBL	0x1810	/* hcall selects SLB
> > or proc table */
> > -#define OV5_MMU_SLB		0x1800	/* always use SLB
> > */
> > -#define OV5_MMU_GTSE		0x1808	/* Guest
> > translation shootdown */
> > +/* MMU Base Architecture */
> > +#define OV5_MMU_HASH_300	0x1800	/* ISA v3.00 Hash
> > MMU Only */
> This is actually legacy HPT as well as ISA v3.00 HPT.

True

> 
> > 
> > +#define OV5_MMU_RADIX_300	0x1840	/* ISA v3.00 Radix
> > MMU Only */
> > +#define OV5_MMU_EITHER_300	0x1880	/* ISA v3.00 Hash
> > or Radix Supported */
> I wonder if it would work better to have a define for the 2-bit field
> with subsidiary definitions for the field values.  Something like
> 
> #define OV5_MMU_SELECTION	0x18c0
> #define  OV5_MMU_HPT			0x00
> #define  OV5_MMU_RADIX			0x40
> #define  OV5_MMU_EITHER			0x80

Yep that's clearer

> 
> > 
> > +#define OV5_NMMU		0x1820	/* Nest MMU
> > Available */
> > +/* Hash Table Extensions */
> > +#define OV5_HASH_SEG_TBL	0x1980	/* In Memory Segment
> > Tables Available */
> > +#define OV5_HASH_GTSE		0x1940	/* Guest
> > Translation Shoot Down Avail */
> > +/* Radix Table Extensions */
> > +#define OV5_RADIX_GTSE		0x1A40	/* Guest
> > Translation Shoot Down Avail */
> >  
> >  /* Option Vector 6: IBM PAPR hints */
> >  #define OV6_LINUX		0x02	/* Linux is our OS */
> > diff --git a/arch/powerpc/kernel/prom_init.c
> > b/arch/powerpc/kernel/prom_init.c
> > index 37b5a29..8272104 100644
> > --- a/arch/powerpc/kernel/prom_init.c
> > +++ b/arch/powerpc/kernel/prom_init.c
> > @@ -168,6 +168,8 @@ static unsigned long __initdata
> > prom_tce_alloc_start;
> >  static unsigned long __initdata prom_tce_alloc_end;
> >  #endif
> >  
> > +static bool __initdata prom_radix_disable;
> > +
> >  /* Platforms codes are now obsolete in the kernel. Now only used
> > within this
> >   * file and ultimately gone too. Feel free to change them if you
> > need, they
> >   * are not shared with anything outside of this file anymore
> > @@ -626,6 +628,12 @@ static void __init early_cmdline_parse(void)
> >  		prom_memory_limit = ALIGN(prom_memory_limit,
> > 0x1000000);
> >  #endif
> >  	}
> > +
> > +	opt = strstr(prom_cmd_line, "disable_radix");
> > +	if (opt) {
> > +		prom_debug("Radix disabled from cmdline\n");
> > +		prom_radix_disable = true;
> > +	}
> >  }
> >  
> >  #if defined(CONFIG_PPC_PSERIES) || defined(CONFIG_PPC_POWERNV)
> > @@ -693,8 +701,10 @@ struct option_vector5 {
> >  	__be16 reserved3;
> >  	u8 subprocessors;
> >  	u8 byte22;
> > -	u8 intarch;
> > +	u8 xive;
> >  	u8 mmu;
> > +	u8 hash_ext;
> > +	u8 radix_ext;
> >  } __packed;
> >  
> >  struct option_vector6 {
> > @@ -849,9 +859,10 @@ struct ibm_arch_vec __cacheline_aligned
> > ibm_architecture_vec = {
> >  		.reserved2 = 0,
> >  		.reserved3 = 0,
> >  		.subprocessors = 1,
> > -		.intarch = 0,
> > -		.mmu = OV5_FEAT(OV5_MMU_RADIX_300) |
> > OV5_FEAT(OV5_MMU_HASH_300) |
> > -			OV5_FEAT(OV5_MMU_PROC_TBL) |
> > OV5_FEAT(OV5_MMU_GTSE),
> > +		.xive = 0,
> > +		.mmu = 0,
> > +		.hash_ext = 0,
> > +		.radix_ext = 0,
> >  	},
> >  
> >  	/* option vector 6: IBM PAPR hints */
> > @@ -990,6 +1001,83 @@ static int __init
> > prom_count_smt_threads(void)
> >  
> >  }
> >  
> > +static void __init prom_check_platform_support(void)
> This function gets quite deeply nested.  Can you split out some of it
> into a subroutine to make it look cleaner?

This did occur to me, will do.

> 
> > 
> > +{
> > +	int prop_len, i;
> > +	bool radix_gtse = false, radix_mmu = false, hash_mmu =
> > false;
> > +
> > +	prop_len = prom_getproplen(prom.chosen,
> > +				   "ibm,arch-vec-5-platform-
> > support");
> > +	if (prop_len > 1) {
> > +		u8 val[prop_len];
> > +		prom_debug("Found ibm,arch-vec-5-platform-support, 
> > len: %d\n",
> > +			   prop_len);
> > +		prom_getprop(prom.chosen, "ibm,arch-vec-5-
> > platform-support",
> > +			     &val, sizeof(val));
> > +		for (i = 0; i < prop_len; i += 2) {
> > +			u8 b1 = val[i], b2 = val[i+1];
> > +			prom_debug("%d: nbyte = %x, val = %x\n",
> > i/2, b1, b2);
> > +			switch (b1) {
> > +			case OV5_INDX(OV5_XIVE_EXPLOIT):
> > +				/* Unimplemented - Ignore */
> > +				break;
> > +			case OV5_INDX(OV5_MMU_EITHER_300):
> > +				if (b2 ==
> > OV5_FEAT(OV5_MMU_EITHER_300)) {
> Here you're trying to check what's in the top 2 bits, so you should
> mask b2 before doing the comparisons, in case other bits (such as the
> nest MMU bit) are set.  Future versions of PAPR might define meanings
> for some of other bits, and you don't want all these comparisons to
> stop working then.

True

> 
> > 
> > +					/* Either Available */
> > +					prom_debug("MMU - either
> > supported\n");
> > +					radix_mmu =
> > !prom_radix_disable;
> > +					hash_mmu = true;
> > +				} else if (b2 ==
> > OV5_FEAT(OV5_MMU_RADIX_300)) {
> > +					/* Radix Only */
> > +					prom_debug("MMU - radix
> > only\n");
> > +					if (prom_radix_disable) {
> > +						prom_printf("WARNI
> > NG: Ignoring "
> > +							    "cmdli
> > ne option \""
> > +							    "disab
> > le_radix\"\n"
> You're allowed to have long lines for string constants; that's better
> than splitting them up like this, because splitting them makes it
> much
> harder to grep for the string.

Ok

> 
> > 
> > +							    );
> > +					}
> > +					radix_mmu = true;
> > +				} else if (b2 ==
> > OV5_FEAT(OV5_MMU_HASH_300)) {
> > +					/* Hash Only */
> > +					prom_debug("MMU - hash
> > only\n");
> > +					hash_mmu = true;
> > +				}
> > +				break;
> > +			case OV5_INDX(OV5_HASH_SEG_TBL):
> > +				/* Unimplemented - Ignore */
> > +				break;
> > +			case OV5_INDX(OV5_RADIX_GTSE):
> > +				if (val[i+1] &
> > OV5_FEAT(OV5_RADIX_GTSE)) {
> Why val[i+1] not b2?

Woops

> 
> > 
> > +					prom_debug("GTSE
> > supported\n");
> > +					radix_gtse = true;
> > +				}
> > +				break;
> > +			default:
> > +				prom_printf("WARNING: Invalid byte
> > index <%d>"
> > +					    " in ibm,arch-vec-5-
> > platform-"
> > +					    "support\n", val[i]);
> I don't think a warning here is appropriate; there could legitimately
> be other values here in future.

Good point, I guess it's not really important if there's anything else
in the vector.

> 
> > 
> > +				break;
> > +			}
> > +		}
> > +	} else {
> > +		prom_printf("WARNING: Invalid len <%d> of
> > ibm,arch-vec-5"
> > +			    "-platform-support\n", prop_len);
> This will be printed on all current machines, won't it?  I don't
> think
> a warning is appropriate if the property just doesn't exist.
> 

Good point. But if it doesn't exist what should we assume?
Atleast legacy hash support?

> > 
> > +	}
> > +
> > +	if (radix_mmu && radix_gtse) {
> > +		/* Radix preferred - but we require GTSE for now
> > */
> > +		prom_debug("Asking for radix with GTSE\n");
> > +		ibm_architecture_vec.vec5.mmu =
> > OV5_FEAT(OV5_MMU_RADIX_300);
> > +		ibm_architecture_vec.vec5.radix_ext =
> > OV5_FEAT(OV5_RADIX_GTSE);
> > +	} else if (hash_mmu) {
> > +		/* Default to hash mmu (if we can) */
> > +		prom_debug("Asking for hash\n");
> > +		ibm_architecture_vec.vec5.mmu =
> > OV5_FEAT(OV5_MMU_HASH_300);
> > +	} else {
> > +		/* Unsupported Configuration */
> > +		prom_printf("WARNING: unsupported host platform
> > MMU config\n");
> Won't we get this on all current machines, i.e. if the property
> doesn't exist?  We shouldn't print warnings just because we're
> running
> on an old machine (think about a POWER6 partition under PowerVM).

Should we just return an empty (for the new bits atleast) vector then?

> 
> > 
> > +	}
> > +}
> >  
> >  static void __init prom_send_capabilities(void)
> >  {
> > @@ -997,6 +1085,9 @@ static void __init
> > prom_send_capabilities(void)
> >  	prom_arg_t ret;
> >  	u32 cores;
> >  
> > +	/* Check ibm,arch-vec-5-platform-support and fixup vec5 if
> > required */
> > +	prom_check_platform_support();
> > +
> >  	root = call_prom("open", 1, 1, ADDR("/"));
> >  	if (root != 0) {
> >  		/* We need to tell the FW about the number of
> > cores we support.
> > diff --git a/arch/powerpc/mm/init_64.c b/arch/powerpc/mm/init_64.c
> > index 6aa3b76..17262da 100644
> > --- a/arch/powerpc/mm/init_64.c
> > +++ b/arch/powerpc/mm/init_64.c
> > @@ -359,15 +359,34 @@ static void early_check_vec5(void)
> >  
> >  	root = of_get_flat_dt_root();
> >  	chosen = of_get_flat_dt_subnode_by_name(root, "chosen");
> > -	if (chosen == -FDT_ERR_NOTFOUND)
> > +	if (chosen == -FDT_ERR_NOTFOUND) {
> > +		cur_cpu_spec->mmu_features &= ~MMU_FTR_TYPE_RADIX;
> >  		return;
> > +	}
> >  	vec5 = of_get_flat_dt_prop(chosen, "ibm,architecture-vec-
> > 5", &size);
> > -	if (!vec5)
> > +	if (!vec5) {
> > +		cur_cpu_spec->mmu_features &= ~MMU_FTR_TYPE_RADIX;
> >  		return;
> > -	if (size <= OV5_INDX(OV5_MMU_RADIX_300) ||
> > -	    !(vec5[OV5_INDX(OV5_MMU_RADIX_300)] &
> > OV5_FEAT(OV5_MMU_RADIX_300)))
> > -		/* Hypervisor doesn't support radix */
> > +	}
> > +	if (size <= OV5_INDX(OV5_MMU_RADIX_300)) {
> >  		cur_cpu_spec->mmu_features &= ~MMU_FTR_TYPE_RADIX;
> > +		return;
> > +	}
> > +
> > +	/* Check for supported configuration */
> > +	if (vec5[OV5_INDX(OV5_MMU_EITHER_300)] ==
> > OV5_FEAT(OV5_MMU_RADIX_300)) {
> Once again you need to look at just the top 2 bits, not the whole
> byte.

Yep

> 
> > 
> > +		/* Hypervisor only supports radix - check enabled
> > && GTSE */
> > +		WARN(!early_radix_enabled() ||
> I would not be at all surprised if a WARN at this early stage won't
> be
> handled properly and will just lead to a silent boot hang with no
> output.  Just do a printk or pr_warn.

This printed fine for me, but I can use a printk instead.

> 
> > 
> > +		     !(vec5[OV5_INDX(OV5_RADIX_GTSE)] &
> > +		       OV5_FEAT(OV5_RADIX_GTSE)),
> > +		     "WARNING: Unsupported MMU configuration in
> > vec5\n");
> > +		/* Do radix anyway - the hypervisor said we had to
> > */
> > +		cur_cpu_spec->mmu_features |= MMU_FTR_TYPE_RADIX;
> > +	} else if (vec5[OV5_INDX(OV5_MMU_EITHER_300)] ==
> > +		   OV5_FEAT(OV5_MMU_HASH_300)) {
> > +		/* Hypervisor only supports hash - disable radix
> > */
> > +		cur_cpu_spec->mmu_features &= ~MMU_FTR_TYPE_RADIX;
> > +	}
> >  }
> >  
> >  void __init mmu_early_init_devtree(void)
> > @@ -383,7 +402,7 @@ void __init mmu_early_init_devtree(void)
> >  	 * even though the ibm,architecture-vec-5 property created
> > by
> >  	 * skiboot doesn't have the necessary bits set.
> >  	 */
> > -	if (early_radix_enabled() && !(mfmsr() & MSR_HV))
> > +	if (!(mfmsr() & MSR_HV))
> >  		early_check_vec5();
> >  
> >  	if (early_radix_enabled())
