Return-Path: <joserz@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zB1Hg18sDzF0Wr
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  3 Jan 2018 04:28:30 +1100 (AEDT)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 w02HOATo069763
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 2 Jan 2018 12:28:28 -0500
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2f8crnv9uh-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 02 Jan 2018 12:28:28 -0500
Received: from localhost
 by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <joserz@linux.vnet.ibm.com>;
 Tue, 2 Jan 2018 12:28:27 -0500
Date: Tue, 2 Jan 2018 15:28:23 -0200
From: joserz@linux.vnet.ibm.com
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org, benh@au1.ibm.com,
 david@gibson.dropbear.id.au
Subject: Re: [PATCH v2 1/1] powerpc/pseries: increase pseries_dlpar_init
 initcall priority
References: <20171226125359.23706-1-joserz@linux.vnet.ibm.com>
 <20171226125359.23706-2-joserz@linux.vnet.ibm.com>
 <87373otreo.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <87373otreo.fsf@concordia.ellerman.id.au>
Message-Id: <20180102172823.sivg3f7nfk4j2dkk@pacoca>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Jan 02, 2018 at 10:46:07PM +1100, Michael Ellerman wrote:
> Jose Ricardo Ziviani <joserz@linux.vnet.ibm.com> writes:
> 
> > The hotplug engine uses its own workqueue to handle IRQ requests, the
> > problem is that such workqueue is initialized after init_ras_IRQ, which
> > will cause a kernel panic if any hotplug interruption is issued in that
> > period of time.
> >
> > This patch changes the dlpar initcall registration to make sure it will
> > be initialized before init_ras_IRQ.
> 
> Sorry I know this is already v2, but I don't think this is the best fix.
> 
> There's a dependency between the registration of the IRQ in the RAS
> code, and the creation of the work queue in the DLPAR code, but it's
> currently not explicit. That's the bug. So it'd be better to just make
> it explicit.
> 
> As a bonus we can add actual error checking of the workqueue allocation.
> 
> Something like below, can you test it please?

sure, no problem. I'll do it.

Thanks for reviewing it!!!

> 
> cheers
> 
> diff --git a/arch/powerpc/platforms/pseries/dlpar.c b/arch/powerpc/platforms/pseries/dlpar.c
> index 6e35780c5962..dd8b29e58a98 100644
> --- a/arch/powerpc/platforms/pseries/dlpar.c
> +++ b/arch/powerpc/platforms/pseries/dlpar.c
> @@ -574,11 +574,26 @@ static ssize_t dlpar_show(struct class *class, struct class_attribute *attr,
> 
>  static CLASS_ATTR_RW(dlpar);
> 
> -static int __init pseries_dlpar_init(void)
> +int __init dlpar_workqueue_init(void)
>  {
> +	if (pseries_hp_wq)
> +		return 0;
> +
>  	pseries_hp_wq = alloc_workqueue("pseries hotplug workqueue",
>  					WQ_UNBOUND, 1);
> +
> +	return pseries_hp_wq ? 0 : -ENOMEM;
> +}
> +
> +static int __init dlpar_sysfs_init(void)
> +{
> +	int rc;
> +
> +	rc = dlpar_workqueue_init();
> +	if (rc)
> +		return rc;
> +
>  	return sysfs_create_file(kernel_kobj, &class_attr_dlpar.attr);
>  }
> -machine_device_initcall(pseries, pseries_dlpar_init);
> +machine_device_initcall(pseries, dlpar_sysfs_init);
> 
> diff --git a/arch/powerpc/platforms/pseries/pseries.h b/arch/powerpc/platforms/pseries/pseries.h
> index 4470a3194311..1ae1d9f4dbe9 100644
> --- a/arch/powerpc/platforms/pseries/pseries.h
> +++ b/arch/powerpc/platforms/pseries/pseries.h
> @@ -98,4 +98,6 @@ static inline unsigned long cmo_get_page_size(void)
>  	return CMO_PageSize;
>  }
> 
> +int dlpar_workqueue_init(void);
> +
>  #endif /* _PSERIES_PSERIES_H */
> diff --git a/arch/powerpc/platforms/pseries/ras.c b/arch/powerpc/platforms/pseries/ras.c
> index 4923ffe230cf..879a92327010 100644
> --- a/arch/powerpc/platforms/pseries/ras.c
> +++ b/arch/powerpc/platforms/pseries/ras.c
> @@ -69,8 +69,9 @@ static int __init init_ras_IRQ(void)
>  	/* Hotplug Events */
>  	np = of_find_node_by_path("/event-sources/hot-plug-events");
>  	if (np != NULL) {
> -		request_event_sources_irqs(np, ras_hotplug_interrupt,
> -					   "RAS_HOTPLUG");
> +		if (dlpar_workqueue_init() == 0)
> +			request_event_sources_irqs(np, ras_hotplug_interrupt,
> +						"RAS_HOTPLUG");
>  		of_node_put(np);
>  	}
> 
> 
