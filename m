Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41Z2hP5P5MzDqmj
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Jul 2018 23:41:25 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: John Allen <jallen@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 nfont@linux.vnet.ibm.com
Cc: John Allen <jallen@linux.ibm.com>
Subject: Re: [PATCH v2 2/2] powerpc/pseries: Wait for completion of hotplug
 events during PRRN handling
In-Reply-To: <20180717194048.3057-3-jallen@linux.ibm.com>
References: <20180717194048.3057-1-jallen@linux.ibm.com>
 <20180717194048.3057-3-jallen@linux.ibm.com>
Date: Mon, 23 Jul 2018 23:41:24 +1000
Message-ID: <87k1pmhxx7.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

John Allen <jallen@linux.ibm.com> writes:

> While handling PRRN events, the time to handle the actual hotplug events
> dwarfs the time it takes to perform the device tree updates and queue the
> hotplug events. In the case that PRRN events are being queued continuously,
> hotplug events have been observed to be queued faster than the kernel can
> actually handle them. This patch avoids the problem by waiting for a
> hotplug request to complete before queueing more hotplug events.

So do we need the hotplug work queue at all? Can we just call
handle_dlpar_errorlog() directly?

Or are we using the work queue to serialise things? And if so would a
mutex be better?

It looks like prrn_update_node() is called via at least, prrn_work_fn()
and post_mobility_fixup().

The latter is called from migration_store(), which seems like it would
be harmless. But also from pseries_suspend_enable_irqs() which I'm less
clear on.

cheers

> diff --git a/arch/powerpc/platforms/pseries/mobility.c b/arch/powerpc/platforms/pseries/mobility.c
> index 8a8033a249c7..49930848fa78 100644
> --- a/arch/powerpc/platforms/pseries/mobility.c
> +++ b/arch/powerpc/platforms/pseries/mobility.c
> @@ -242,6 +242,7 @@ static int add_dt_node(__be32 parent_phandle, __be32 drc_index)
>  static void prrn_update_node(__be32 phandle)
>  {
>  	struct pseries_hp_errorlog *hp_elog;
> +	struct completion hotplug_done;
>  	struct device_node *dn;
>  
>  	/*
> @@ -263,7 +264,9 @@ static void prrn_update_node(__be32 phandle)
>  	hp_elog->id_type = PSERIES_HP_ELOG_ID_DRC_INDEX;
>  	hp_elog->_drc_u.drc_index = phandle;
>  
> -	queue_hotplug_event(hp_elog, NULL, NULL);
> +	init_completion(&hotplug_done);
> +	queue_hotplug_event(hp_elog, &hotplug_done, NULL);
> +	wait_for_completion(&hotplug_done);
>  
>  	kfree(hp_elog);
>  }
> -- 
> 2.17.1
