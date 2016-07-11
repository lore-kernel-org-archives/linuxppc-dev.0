Return-Path: <nfont@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rp8gH6fqJzDr2D
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Jul 2016 01:50:03 +1000 (AEST)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u6BFmiwl103640
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Jul 2016 11:50:02 -0400
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
 by mx0a-001b2d01.pphosted.com with ESMTP id 242wbn2t37-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Jul 2016 11:50:02 -0400
Received: from localhost
 by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <nfont@linux.vnet.ibm.com>;
 Mon, 11 Jul 2016 11:50:01 -0400
Subject: Re: [PATCH 2/3] powerpc/pseries: Add support for hotplug interrupt
 source
To: John Allen <jallen@linux.vnet.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org
References: <4cf3edf2-fc24-5989-ae5d-b451a2323cf2@linux.vnet.ibm.com>
 <a8defb03-2f61-a46c-a323-d3a722cef12c@linux.vnet.ibm.com>
Cc: Michael Roth <mdroth@linux.vnet.ibm.com>
From: Nathan Fontenot <nfont@linux.vnet.ibm.com>
Date: Mon, 11 Jul 2016 10:49:56 -0500
MIME-Version: 1.0
In-Reply-To: <a8defb03-2f61-a46c-a323-d3a722cef12c@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Message-Id: <5783C024.6030700@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 07/07/2016 10:03 AM, John Allen wrote:
> Add handler for new hotplug interrupt. For memory and CPU hotplug events,
> we will add the hotplug errorlog to the hotplug workqueue. Since PCI
> hotplug is not currently supported in the kernel, PCI hotplug events are
> written to the rtas_log_bug and are handled by rtas_errd.
> 
> Signed-off-by: John Allen <jallen@linux.vnet.ibm.com>

Reviewed-by: Nathan Fontenot <nfont@linux.vnet.ibm.com>

> ---
>  arch/powerpc/platforms/pseries/pseries.h |    2 ++
>  arch/powerpc/platforms/pseries/ras.c     |   38 ++++++++++++++++++++++++++++++
>  2 files changed, 40 insertions(+)
> 
> diff --git a/arch/powerpc/platforms/pseries/pseries.h b/arch/powerpc/platforms/pseries/pseries.h
> index ddb9aa5..bba3285 100644
> --- a/arch/powerpc/platforms/pseries/pseries.h
> +++ b/arch/powerpc/platforms/pseries/pseries.h
> @@ -56,6 +56,8 @@ extern int dlpar_detach_node(struct device_node *);
>  extern int dlpar_acquire_drc(u32 drc_index);
>  extern int dlpar_release_drc(u32 drc_index);
> 
> +void queue_hotplug_event(struct pseries_hp_errorlog *hp_errlog,
> +			 struct completion *hotplug_done, int *rc);
>  #ifdef CONFIG_MEMORY_HOTPLUG
>  int dlpar_memory(struct pseries_hp_errorlog *hp_elog);
>  #else
> diff --git a/arch/powerpc/platforms/pseries/ras.c b/arch/powerpc/platforms/pseries/ras.c
> index 9a3e27b..d11e8ca 100644
> --- a/arch/powerpc/platforms/pseries/ras.c
> +++ b/arch/powerpc/platforms/pseries/ras.c
> @@ -43,6 +43,7 @@ static int ras_check_exception_token;
>  /* EPOW events counter variable */
>  static int num_epow_events;
> 
> +static irqreturn_t ras_hotplug_interrupt(int irq, void *dev_id);
>  static irqreturn_t ras_epow_interrupt(int irq, void *dev_id);
>  static irqreturn_t ras_error_interrupt(int irq, void *dev_id);
> 
> @@ -65,6 +66,14 @@ static int __init init_ras_IRQ(void)
>  		of_node_put(np);
>  	}
> 
> +	/* Hotplug Events */
> +	np = of_find_node_by_path("/event-sources/hot-plug-events");
> +	if (np != NULL) {
> +		request_event_sources_irqs(np, ras_hotplug_interrupt,
> +					   "RAS_HOTPLUG");
> +		of_node_put(np);
> +	}
> +
>  	/* EPOW Events */
>  	np = of_find_node_by_path("/event-sources/epow-events");
>  	if (np != NULL) {
> @@ -190,6 +199,35 @@ static void rtas_parse_epow_errlog(struct rtas_error_log *log)
>  		num_epow_events++;
>  }
> 
> +static irqreturn_t ras_hotplug_interrupt(int irq, void *dev_id)
> +{
> +	struct pseries_errorlog *pseries_log;
> +	struct pseries_hp_errorlog *hp_elog;
> +
> +	spin_lock(&ras_log_buf_lock);
> +
> +	rtas_call(ras_check_exception_token, 6, 1, NULL,
> +		  RTAS_VECTOR_EXTERNAL_INTERRUPT, virq_to_hw(irq),
> +		  RTAS_HOTPLUG_EVENTS, 0, __pa(&ras_log_buf),
> +		  rtas_get_error_log_max());
> +
> +	pseries_log = get_pseries_errorlog((struct rtas_error_log *)ras_log_buf,
> +					   PSERIES_ELOG_SECT_ID_HOTPLUG);
> +	hp_elog = (struct pseries_hp_errorlog *)pseries_log->data;
> +
> +	/* Since PCI hotplug is not currently supported on pseries, put
> +	 * PCI hotplug events on the ras_log_buf to be handled by rtas_errd
> +	 */
> +	if (hp_elog->resource == PSERIES_HP_ELOG_RESOURCE_MEM ||
> +	    hp_elog->resource == PSERIES_HP_ELOG_RESOURCE_CPU)
> +		queue_hotplug_event(hp_elog, NULL, NULL);
> +	else
> +		log_error(ras_log_buf, ERR_TYPE_RTAS_LOG, 0);
> +
> +	spin_unlock(&ras_log_buf_lock);
> +	return IRQ_HANDLED;
> +}
> +
>  /* Handle environmental and power warning (EPOW) interrupts. */
>  static irqreturn_t ras_epow_interrupt(int irq, void *dev_id)
>  {
> 
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
> 
