Return-Path: <nfont@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tdQrr68XFzDw1W
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Dec 2016 03:58:36 +1100 (AEDT)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 uBDGrrpI139377
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Dec 2016 11:58:33 -0500
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
 by mx0b-001b2d01.pphosted.com with ESMTP id 27afv7hkpm-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Dec 2016 11:58:33 -0500
Received: from localhost
 by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <nfont@linux.vnet.ibm.com>;
 Tue, 13 Dec 2016 09:58:32 -0700
Received: from b01cxnp22033.gho.pok.ibm.com (b01cxnp22033.gho.pok.ibm.com
 [9.57.198.23])
 by d03dlp02.boulder.ibm.com (Postfix) with ESMTP id BF7C03E4004C
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Dec 2016 09:58:29 -0700 (MST)
Subject: Re: [PATCH 2/2] powerpc/pseries: Update affinity for memory and cpus
 specified in a PRRN event
To: John Allen <jallen@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
References: <7125fe8e-60f9-2152-d159-0f4c07183547@linux.vnet.ibm.com>
 <ef52e969-62f8-7b2c-2928-07cb1081111b@linux.vnet.ibm.com>
From: Nathan Fontenot <nfont@linux.vnet.ibm.com>
Date: Tue, 13 Dec 2016 10:58:28 -0600
MIME-Version: 1.0
In-Reply-To: <ef52e969-62f8-7b2c-2928-07cb1081111b@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Message-Id: <b0b9c5a1-43b5-0fb6-477a-218b5f6f98b4@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 12/12/2016 03:07 PM, John Allen wrote:
> Extend the existing PRRN infrastructure to perform the actual affinity
> updating for cpus and memory in addition to the device tree updating. For
> cpus, dynamic affinity updating already appears to exist in the kernel in
> the form of arch_update_cpu_topology. For memory, we must place a READD
> operation on the hotplug queue for any phandle included in the PRRN event
> that is determined to be an LMB.
> 
> Signed-off-by: John Allen <jallen@linux.vnet.ibm.com>
> ---
> diff --git a/arch/powerpc/kernel/rtasd.c b/arch/powerpc/kernel/rtasd.c
> index a26a020..8836130 100644
> --- a/arch/powerpc/kernel/rtasd.c
> +++ b/arch/powerpc/kernel/rtasd.c
> @@ -21,6 +21,7 @@
>  #include <linux/cpu.h>
>  #include <linux/workqueue.h>
>  #include <linux/slab.h>
> +#include <linux/topology.h>
> 
>  #include <asm/uaccess.h>
>  #include <asm/io.h>
> @@ -282,6 +283,7 @@ static void prrn_work_fn(struct work_struct *work)
>  	 * the RTAS event.
>  	 */
>  	pseries_devicetree_update(-prrn_update_scope);
> +	arch_update_cpu_topology();
>  }
> 
>  static DECLARE_WORK(prrn_work, prrn_work_fn);
> @@ -434,7 +436,10 @@ static void do_event_scan(void)
>  		}
> 
>  		if (error == 0) {
> -			pSeries_log_error(logdata, ERR_TYPE_RTAS_LOG, 0);
> +			if (rtas_error_type((struct rtas_error_log *)logdata) !=
> +			    RTAS_TYPE_PRRN)
> +				pSeries_log_error(logdata, ERR_TYPE_RTAS_LOG,
> +						  0);
>  			handle_rtas_event((struct rtas_error_log *)logdata);
>  		}
> 
> diff --git a/arch/powerpc/platforms/pseries/mobility.c b/arch/powerpc/platforms/pseries/mobility.c
> index a560a98..e2ed2d6 100644
> --- a/arch/powerpc/platforms/pseries/mobility.c
> +++ b/arch/powerpc/platforms/pseries/mobility.c
> @@ -39,6 +39,7 @@ struct update_props_workarea {
>  #define ADD_DT_NODE	0x03000000
> 
>  #define MIGRATION_SCOPE	(1)
> +#define PRRN_SCOPE -2
> 
>  static int mobility_rtas_call(int token, char *buf, s32 scope)
>  {
> @@ -236,6 +237,49 @@ static int add_dt_node(__be32 parent_phandle, __be32 drc_index)
>  	return rc;
>  }
> 
> +void pseries_prrn_update_node(__be32 phandle)
> +{
> +	struct pseries_hp_errorlog *hp_elog;
> +	struct completion hotplug_done;
> +	struct device_node *dn;
> +	char *type;
> +	int rc = 0;
> +
> +	hp_elog = kzalloc(sizeof(*hp_elog), GFP_KERNEL);

Doing memory hotplug by index results in the struct pseries_hp_elog
only being about 64 bits. Since we are adding each action to the queue and
waiting for its completion do we need to allocate the struct. Seems like
we could just have a local pseries_hp_elog.

> +	if (!hp_elog)
> +		return;
> +
> +	dn = of_find_node_by_phandle(be32_to_cpu(phandle));
> +
> +	/*
> +	 * If the phandle was not found, assume phandle is the drc index of
> +	 * an LMB.
> +	 */
> +	if (!dn) {
> +		type = "memory";
> +		hp_elog->resource = PSERIES_HP_ELOG_RESOURCE_MEM;
> +		hp_elog->action = PSERIES_HP_ELOG_ACTION_READD;
> +		hp_elog->id_type = PSERIES_HP_ELOG_ID_DRC_INDEX;
> +		hp_elog->_drc_u.drc_index = cpu_to_be32(phandle);

Isn't the phandle already in BE format?

-Nathan

> +
> +		pr_info("Attempting to update %s at drc index %x\n", type,
> +			hp_elog->_drc_u.drc_index);
> +
> +		init_completion(&hotplug_done);
> +		queue_hotplug_event(hp_elog, &hotplug_done, &rc);
> +		wait_for_completion(&hotplug_done);
> +
> +		if (rc)
> +			pr_info("Failed to update %s at drc index %x\n", type,
> +				hp_elog->_drc_u.drc_index);
> +		else
> +			pr_info("Updated %s at drc index %x\n", type,
> +				hp_elog->_drc_u.drc_index);
> +	}
> +
> +	kfree(hp_elog);
> +}
> +
>  int pseries_devicetree_update(s32 scope)
>  {
>  	char *rtas_buf;
> @@ -274,6 +318,10 @@ int pseries_devicetree_update(s32 scope)
>  					break;
>  				case UPDATE_DT_NODE:
>  					update_dt_node(phandle, scope);
> +
> +					if (scope == PRRN_SCOPE)
> +						pseries_prrn_update_node(phandle);
> +
>  					break;
>  				case ADD_DT_NODE:
>  					drc_index = *data++;
> 
