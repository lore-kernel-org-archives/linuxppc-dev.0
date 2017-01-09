Return-Path: <nfont@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3ty10K4PgpzDqT5
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Jan 2017 03:32:33 +1100 (AEDT)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 v09GFGuw037774
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 9 Jan 2017 11:32:31 -0500
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
 by mx0a-001b2d01.pphosted.com with ESMTP id 27vc3666vb-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 09 Jan 2017 11:32:31 -0500
Received: from localhost
 by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <nfont@linux.vnet.ibm.com>;
 Mon, 9 Jan 2017 09:32:30 -0700
Received: from b03cxnp08028.gho.boulder.ibm.com
 (b03cxnp08028.gho.boulder.ibm.com [9.17.130.20])
 by d03dlp02.boulder.ibm.com (Postfix) with ESMTP id 5B1E73E4005E
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  9 Jan 2017 09:32:27 -0700 (MST)
Subject: Re: [PATCH v3 2/3] powerpc/pseries: Introduce memory hotplug READD
 operation
To: John Allen <jallen@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
References: <a4c3e5c2-18d8-0f01-272b-a3ae23318469@linux.vnet.ibm.com>
 <9a232a88-7418-8365-4e15-13b13542be26@linux.vnet.ibm.com>
From: Nathan Fontenot <nfont@linux.vnet.ibm.com>
Date: Mon, 9 Jan 2017 10:32:26 -0600
MIME-Version: 1.0
In-Reply-To: <9a232a88-7418-8365-4e15-13b13542be26@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Message-Id: <1b0aa019-ab4d-5d4f-ce5e-36715ac6a076@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 01/06/2017 01:27 PM, John Allen wrote:
> Currently, memory must be hot removed and subsequently re-added in order
> to dynamically update the affinity of LMBs specified by a PRRN event.
> Earlier implementations of the PRRN event handler ran into issues in which
> the hot remove would occur successfully, but a hotplug event would be
> initiated from another source and grab the hotplug lock preventing the hot
> add from occurring. To prevent this situation, this patch introduces the
> notion of a hot "readd" action for memory which atomizes a hot remove and
> a hot add into a single, serialized operation on the hotplug queue.
> 
> Signed-off-by: John Allen <jallen@linux.vnet.ibm.com>

Reviewed-by: Nathan Fontenot <nfont@linux.vnet.ibm.com>

> ---
> diff --git a/arch/powerpc/include/asm/rtas.h b/arch/powerpc/include/asm/rtas.h
> index 9c23baa..076b892 100644
> --- a/arch/powerpc/include/asm/rtas.h
> +++ b/arch/powerpc/include/asm/rtas.h
> @@ -318,6 +318,7 @@ struct pseries_hp_errorlog {
> 
>  #define PSERIES_HP_ELOG_ACTION_ADD	1
>  #define PSERIES_HP_ELOG_ACTION_REMOVE	2
> +#define PSERIES_HP_ELOG_ACTION_READD	3
> 
>  #define PSERIES_HP_ELOG_ID_DRC_NAME	1
>  #define PSERIES_HP_ELOG_ID_DRC_INDEX	2
> diff --git a/arch/powerpc/platforms/pseries/hotplug-memory.c b/arch/powerpc/platforms/pseries/hotplug-memory.c
> index 0eb4b1d..06f10a8 100644
> --- a/arch/powerpc/platforms/pseries/hotplug-memory.c
> +++ b/arch/powerpc/platforms/pseries/hotplug-memory.c
> @@ -560,6 +560,44 @@ static int dlpar_memory_remove_by_index(u32 drc_index, struct property *prop)
>  	return rc;
>  }
> 
> +static int dlpar_memory_readd_by_index(u32 drc_index, struct property *prop)
> +{
> +	struct of_drconf_cell *lmbs;
> +	u32 num_lmbs, *p;
> +	int lmb_found;
> +	int i, rc;
> +
> +	pr_info("Attempting to update LMB, drc index %x\n", drc_index);
> +
> +	p = prop->value;
> +	num_lmbs = *p++;
> +	lmbs = (struct of_drconf_cell *)p;
> +
> +	lmb_found = 0;
> +	for (i = 0; i < num_lmbs; i++) {
> +		if (lmbs[i].drc_index == drc_index) {
> +			lmb_found = 1;
> +			rc = dlpar_remove_lmb(&lmbs[i]);
> +			if (!rc) {
> +				rc = dlpar_add_lmb(&lmbs[i]);
> +				if (rc)
> +					dlpar_release_drc(lmbs[i].drc_index);
> +			}
> +			break;
> +		}
> +	}
> +
> +	if (!lmb_found)
> +		rc = -EINVAL;
> +
> +	if (rc)
> +		pr_info("Failed to update memory at %llx\n",
> +			lmbs[i].base_addr);
> +	else
> +		pr_info("Memory at %llx was updated\n", lmbs[i].base_addr);
> +
> +	return rc;
> +}
>  #else
>  static inline int pseries_remove_memblock(unsigned long base,
>  					  unsigned int memblock_size)
> @@ -776,6 +814,9 @@ int dlpar_memory(struct pseries_hp_errorlog *hp_elog)
>  		else
>  			rc = -EINVAL;
>  		break;
> +	case PSERIES_HP_ELOG_ACTION_READD:
> +		rc = dlpar_memory_readd_by_index(drc_index, prop);
> +		break;
>  	default:
>  		pr_err("Invalid action (%d) specified\n", hp_elog->action);
>  		rc = -EINVAL;
> 
