Return-Path: <brking@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id E7EB2B70C4
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 15 Sep 2009 04:30:59 +1000 (EST)
Received: from e8.ny.us.ibm.com (e8.ny.us.ibm.com [32.97.182.138])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e8.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 5683BDDD01
	for <linuxppc-dev@ozlabs.org>; Tue, 15 Sep 2009 04:30:58 +1000 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e8.ny.us.ibm.com (8.14.3/8.13.1) with ESMTP id n8EIUD6T010317
	for <linuxppc-dev@ozlabs.org>; Mon, 14 Sep 2009 14:30:13 -0400
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	n8EIUtnb253370
	for <linuxppc-dev@ozlabs.org>; Mon, 14 Sep 2009 14:30:55 -0400
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
	by d01av01.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n8EIUtid027318
	for <linuxppc-dev@ozlabs.org>; Mon, 14 Sep 2009 14:30:55 -0400
Message-ID: <4AAE8BDE.3090002@linux.vnet.ibm.com>
Date: Mon, 14 Sep 2009 13:30:54 -0500
From: Brian King <brking@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Nathan Fontenot <nfont@austin.ibm.com>
Subject: Re: [PATCH 1/5] dynamic logical partitioning infrastructure
References: <4AAABC55.4070207@austin.ibm.com> <4AAABCE3.5090702@austin.ibm.com>
In-Reply-To: <4AAABCE3.5090702@austin.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Nathan Fontenot wrote:
> +#include <linux/kernel.h>
> +#include <linux/kref.h>
> +#include <linux/notifier.h>
> +#include <linux/proc_fs.h>
> +#include <linux/spinlock.h>
> +
> +#include <asm/prom.h>
> +#include <asm/machdep.h>
> +#include <asm/uaccess.h>
> +#include <asm/rtas.h>
> +#include <asm/pSeries_reconfig.h>
> +
> +#define CFG_CONN_WORK_SIZE    4096
> +static char workarea[CFG_CONN_WORK_SIZE];
> +spinlock_t workarea_lock;

This can be:

static DEFINE_SPINLOCK(workarea_lock);

Then you can get rid of the runtime initializer.

> +
> +int release_drc(u32 drc_index)
> +{
> +    int dr_status, rc;
> +
> +    rc = rtas_call(rtas_token("get-sensor-state"), 2, 2, &dr_status,
> +               DR_ENTITY_SENSE, drc_index);
> +    if (rc || dr_status != DR_ENTITY_PRESENT)
> +        return -1;
> +
> +    rc = rtas_set_indicator(ISOLATION_STATE, drc_index, ISOLATE);
> +    if (rc)
> +        return -1;
> +
> +    rc = rtas_set_indicator(ALLOCATION_STATE, drc_index, ALLOC_UNUSABLE);
> +    if (rc) {
> +        rtas_set_indicator(ISOLATION_STATE, drc_index, UNISOLATE);
> +        return -1;
> +    }

Is there a better return value here that might be more descriptive than -1?


> +
> +    return 0;
> +}
> +
> +static int pseries_dlpar_init(void)
> +{
> +    spin_lock_init(&workarea_lock);
> +
> +    if (!machine_is(pseries))
> +        return 0;

What's the point of this if check if you return 0 either way?

> +
> +    return 0;
> +}
> +__initcall(pseries_dlpar_init);


> Index: powerpc/arch/powerpc/platforms/pseries/reconfig.c
> ===================================================================
> --- powerpc.orig/arch/powerpc/platforms/pseries/reconfig.c    2009-09-11
> 12:43:39.000000000 -0500
> +++ powerpc/arch/powerpc/platforms/pseries/reconfig.c    2009-09-11
> 12:51:52.000000000 -0500
> @@ -95,7 +95,7 @@
>     return parent;
> }
> 
> -static BLOCKING_NOTIFIER_HEAD(pSeries_reconfig_chain);
> +struct blocking_notifier_head pSeries_reconfig_chain =
> BLOCKING_NOTIFIER_INIT(pSeries_reconfig_chain);

Can't this just be?

BLOCKING_NOTIFIER_HEAD(pSeries_reconfig_chain);

-- 
Brian King
Linux on Power Virtualization
IBM Linux Technology Center
