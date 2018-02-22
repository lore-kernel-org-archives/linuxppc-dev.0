Return-Path: <nfont@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3znG524w5PzF1Dp
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Feb 2018 00:52:38 +1100 (AEDT)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w1MDp0re035819
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Feb 2018 08:52:35 -0500
Received: from e13.ny.us.ibm.com (e13.ny.us.ibm.com [129.33.205.203])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2g9wexcheh-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Feb 2018 08:52:35 -0500
Received: from localhost
 by e13.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <nfont@linux.vnet.ibm.com>;
 Thu, 22 Feb 2018 08:52:34 -0500
Subject: Re: [RFC PATCH v0 2/2] powerpc, drmem: Rename DRMEM_LMB_RESERVED to
 DRMEM_LMB_ISOLATED
To: Bharata B Rao <bharata@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
Cc: mwb@linux.vnet.ibm.com
References: <1519209387-29767-1-git-send-email-bharata@linux.vnet.ibm.com>
 <1519209387-29767-3-git-send-email-bharata@linux.vnet.ibm.com>
From: Nathan Fontenot <nfont@linux.vnet.ibm.com>
Date: Thu, 22 Feb 2018 07:52:32 -0600
MIME-Version: 1.0
In-Reply-To: <1519209387-29767-3-git-send-email-bharata@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Message-Id: <29460a5c-9334-738d-cfdb-8fe5224c8a58@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 02/21/2018 04:36 AM, Bharata B Rao wrote:
> Memory hotplug code uses a temporary LMB flags bit DRMEM_LMB_RESERVED
> to mark the LMB which is currently undergoing hotplug or unplug.
> It is easy to confuse DRMEM_LMB_RESERVED to mean the LMB is reserved
> for which a separate flag bit already exists DRCONF_MEM_RESERVED. Since
> both DRMEM_LMB_RESERVED and DRCONF_MEM_RESERVED operate on the same
> LMB flags word, rename the former to DRMEM_LMB_ISOLATED.
> 
> Signed-off-by: Bharata B Rao <bharata@linux.vnet.ibm.com>

Reviewed-by: Nathan Fontenot <nfont@linux.vnet.ibm.com>

> ---
>  arch/powerpc/include/asm/drmem.h                | 14 ++++-----
>  arch/powerpc/mm/drmem.c                         |  2 +-
>  arch/powerpc/platforms/pseries/hotplug-memory.c | 40 ++++++++++++-------------
>  3 files changed, 28 insertions(+), 28 deletions(-)
> 
> diff --git a/arch/powerpc/include/asm/drmem.h b/arch/powerpc/include/asm/drmem.h
> index ce242b9..b3fa3f7 100644
> --- a/arch/powerpc/include/asm/drmem.h
> +++ b/arch/powerpc/include/asm/drmem.h
> @@ -72,21 +72,21 @@ static inline u32 drmem_lmb_size(void)
>  	return drmem_info->lmb_size;
>  }
> 
> -#define DRMEM_LMB_RESERVED	0x80000000
> +#define DRMEM_LMB_ISOLATED	0x80000000
> 
> -static inline void drmem_mark_lmb_reserved(struct drmem_lmb *lmb)
> +static inline void drmem_mark_lmb_isolated(struct drmem_lmb *lmb)
>  {
> -	lmb->flags |= DRMEM_LMB_RESERVED;
> +	lmb->flags |= DRMEM_LMB_ISOLATED;
>  }
> 
> -static inline void drmem_remove_lmb_reservation(struct drmem_lmb *lmb)
> +static inline void drmem_remove_lmb_isolation(struct drmem_lmb *lmb)
>  {
> -	lmb->flags &= ~DRMEM_LMB_RESERVED;
> +	lmb->flags &= ~DRMEM_LMB_ISOLATED;
>  }
> 
> -static inline bool drmem_lmb_reserved(struct drmem_lmb *lmb)
> +static inline bool drmem_lmb_isolated(struct drmem_lmb *lmb)
>  {
> -	return lmb->flags & DRMEM_LMB_RESERVED;
> +	return lmb->flags & DRMEM_LMB_ISOLATED;
>  }
> 
>  u64 drmem_lmb_memory_max(void);
> diff --git a/arch/powerpc/mm/drmem.c b/arch/powerpc/mm/drmem.c
> index 3f18036..652bf3a 100644
> --- a/arch/powerpc/mm/drmem.c
> +++ b/arch/powerpc/mm/drmem.c
> @@ -35,7 +35,7 @@ static u32 drmem_lmb_flags(struct drmem_lmb *lmb)
>  	 * Return the value of the lmb flags field minus the reserved
>  	 * bit used internally for hotplug processing.
>  	 */
> -	return lmb->flags & ~DRMEM_LMB_RESERVED;
> +	return lmb->flags & ~DRMEM_LMB_ISOLATED;
>  }
> 
>  static struct property *clone_property(struct property *prop, u32 prop_sz)
> diff --git a/arch/powerpc/platforms/pseries/hotplug-memory.c b/arch/powerpc/platforms/pseries/hotplug-memory.c
> index c1578f5..2f5ca29 100644
> --- a/arch/powerpc/platforms/pseries/hotplug-memory.c
> +++ b/arch/powerpc/platforms/pseries/hotplug-memory.c
> @@ -467,7 +467,7 @@ static int dlpar_memory_remove_by_count(u32 lmbs_to_remove)
>  		/* Mark this lmb so we can add it later if all of the
>  		 * requested LMBs cannot be removed.
>  		 */
> -		drmem_mark_lmb_reserved(lmb);
> +		drmem_mark_lmb_isolated(lmb);
> 
>  		lmbs_removed++;
>  		if (lmbs_removed == lmbs_to_remove)
> @@ -478,7 +478,7 @@ static int dlpar_memory_remove_by_count(u32 lmbs_to_remove)
>  		pr_err("Memory hot-remove failed, adding LMB's back\n");
> 
>  		for_each_drmem_lmb(lmb) {
> -			if (!drmem_lmb_reserved(lmb))
> +			if (!drmem_lmb_isolated(lmb))
>  				continue;
> 
>  			rc = dlpar_add_lmb(lmb);
> @@ -486,20 +486,20 @@ static int dlpar_memory_remove_by_count(u32 lmbs_to_remove)
>  				pr_err("Failed to add LMB back, drc index %x\n",
>  				       lmb->drc_index);
> 
> -			drmem_remove_lmb_reservation(lmb);
> +			drmem_remove_lmb_isolation(lmb);
>  		}
> 
>  		rc = -EINVAL;
>  	} else {
>  		for_each_drmem_lmb(lmb) {
> -			if (!drmem_lmb_reserved(lmb))
> +			if (!drmem_lmb_isolated(lmb))
>  				continue;
> 
>  			dlpar_release_drc(lmb->drc_index);
>  			pr_info("Memory at %llx was hot-removed\n",
>  				lmb->base_addr);
> 
> -			drmem_remove_lmb_reservation(lmb);
> +			drmem_remove_lmb_isolation(lmb);
>  		}
>  		rc = 0;
>  	}
> @@ -608,7 +608,7 @@ static int dlpar_memory_remove_by_ic(u32 lmbs_to_remove, u32 drc_index)
>  		if (rc)
>  			break;
> 
> -		drmem_mark_lmb_reserved(lmb);
> +		drmem_mark_lmb_isolated(lmb);
>  	}
> 
>  	if (rc) {
> @@ -616,7 +616,7 @@ static int dlpar_memory_remove_by_ic(u32 lmbs_to_remove, u32 drc_index)
> 
> 
>  		for_each_drmem_lmb_in_range(lmb, start_lmb, end_lmb) {
> -			if (!drmem_lmb_reserved(lmb))
> +			if (!drmem_lmb_isolated(lmb))
>  				continue;
> 
>  			rc = dlpar_add_lmb(lmb);
> @@ -624,19 +624,19 @@ static int dlpar_memory_remove_by_ic(u32 lmbs_to_remove, u32 drc_index)
>  				pr_err("Failed to add LMB, drc index %x\n",
>  				       lmb->drc_index);
> 
> -			drmem_remove_lmb_reservation(lmb);
> +			drmem_remove_lmb_isolation(lmb);
>  		}
>  		rc = -EINVAL;
>  	} else {
>  		for_each_drmem_lmb_in_range(lmb, start_lmb, end_lmb) {
> -			if (!drmem_lmb_reserved(lmb))
> +			if (!drmem_lmb_isolated(lmb))
>  				continue;
> 
>  			dlpar_release_drc(lmb->drc_index);
>  			pr_info("Memory at %llx (drc index %x) was hot-removed\n",
>  				lmb->base_addr, lmb->drc_index);
> 
> -			drmem_remove_lmb_reservation(lmb);
> +			drmem_remove_lmb_isolation(lmb);
>  		}
>  	}
> 
> @@ -760,7 +760,7 @@ static int dlpar_memory_add_by_count(u32 lmbs_to_add)
>  		/* Mark this lmb so we can remove it later if all of the
>  		 * requested LMBs cannot be added.
>  		 */
> -		drmem_mark_lmb_reserved(lmb);
> +		drmem_mark_lmb_isolated(lmb);
> 
>  		lmbs_added++;
>  		if (lmbs_added == lmbs_to_add)
> @@ -771,7 +771,7 @@ static int dlpar_memory_add_by_count(u32 lmbs_to_add)
>  		pr_err("Memory hot-add failed, removing any added LMBs\n");
> 
>  		for_each_drmem_lmb(lmb) {
> -			if (!drmem_lmb_reserved(lmb))
> +			if (!drmem_lmb_isolated(lmb))
>  				continue;
> 
>  			rc = dlpar_remove_lmb(lmb);
> @@ -781,17 +781,17 @@ static int dlpar_memory_add_by_count(u32 lmbs_to_add)
>  			else
>  				dlpar_release_drc(lmb->drc_index);
> 
> -			drmem_remove_lmb_reservation(lmb);
> +			drmem_remove_lmb_isolation(lmb);
>  		}
>  		rc = -EINVAL;
>  	} else {
>  		for_each_drmem_lmb(lmb) {
> -			if (!drmem_lmb_reserved(lmb))
> +			if (!drmem_lmb_isolated(lmb))
>  				continue;
> 
>  			pr_info("Memory at %llx (drc index %x) was hot-added\n",
>  				lmb->base_addr, lmb->drc_index);
> -			drmem_remove_lmb_reservation(lmb);
> +			drmem_remove_lmb_isolation(lmb);
>  		}
>  		rc = 0;
>  	}
> @@ -874,14 +874,14 @@ static int dlpar_memory_add_by_ic(u32 lmbs_to_add, u32 drc_index)
>  			break;
>  		}
> 
> -		drmem_mark_lmb_reserved(lmb);
> +		drmem_mark_lmb_isolated(lmb);
>  	}
> 
>  	if (rc) {
>  		pr_err("Memory indexed-count-add failed, removing any added LMBs\n");
> 
>  		for_each_drmem_lmb_in_range(lmb, start_lmb, end_lmb) {
> -			if (!drmem_lmb_reserved(lmb))
> +			if (!drmem_lmb_isolated(lmb))
>  				continue;
> 
>  			rc = dlpar_remove_lmb(lmb);
> @@ -891,17 +891,17 @@ static int dlpar_memory_add_by_ic(u32 lmbs_to_add, u32 drc_index)
>  			else
>  				dlpar_release_drc(lmb->drc_index);
> 
> -			drmem_remove_lmb_reservation(lmb);
> +			drmem_remove_lmb_isolation(lmb);
>  		}
>  		rc = -EINVAL;
>  	} else {
>  		for_each_drmem_lmb_in_range(lmb, start_lmb, end_lmb) {
> -			if (!drmem_lmb_reserved(lmb))
> +			if (!drmem_lmb_isolated(lmb))
>  				continue;
> 
>  			pr_info("Memory at %llx (drc index %x) was hot-added\n",
>  				lmb->base_addr, lmb->drc_index);
> -			drmem_remove_lmb_reservation(lmb);
> +			drmem_remove_lmb_isolation(lmb);
>  		}
>  	}
> 
