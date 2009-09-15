Return-Path: <nfont@austin.ibm.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 555C2B70AD
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 16 Sep 2009 00:15:20 +1000 (EST)
Received: from e6.ny.us.ibm.com (e6.ny.us.ibm.com [32.97.182.146])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e6.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id C2EE5DDD04
	for <linuxppc-dev@ozlabs.org>; Wed, 16 Sep 2009 00:15:19 +1000 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e6.ny.us.ibm.com (8.14.3/8.13.1) with ESMTP id n8FEJkmk026142
	for <linuxppc-dev@ozlabs.org>; Tue, 15 Sep 2009 10:19:46 -0400
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	n8FEFF9m254182
	for <linuxppc-dev@ozlabs.org>; Tue, 15 Sep 2009 10:15:16 -0400
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
	by d01av01.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n8FEFEu5007557
	for <linuxppc-dev@ozlabs.org>; Tue, 15 Sep 2009 10:15:15 -0400
Message-ID: <4AAFA16B.2040806@austin.ibm.com>
Date: Tue, 15 Sep 2009 09:15:07 -0500
From: Nathan Fontenot <nfont@austin.ibm.com>
MIME-Version: 1.0
To: Brian King <brking@linux.vnet.ibm.com>
Subject: Re: [PATCH 1/5] dynamic logical partitioning infrastructure
References: <4AAABC55.4070207@austin.ibm.com> <4AAABCE3.5090702@austin.ibm.com>
	<4AAE8BDE.3090002@linux.vnet.ibm.com>
In-Reply-To: <4AAE8BDE.3090002@linux.vnet.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Brian King wrote:
> Nathan Fontenot wrote:
>> +#include <linux/kernel.h>
>> +#include <linux/kref.h>
>> +#include <linux/notifier.h>
>> +#include <linux/proc_fs.h>
>> +#include <linux/spinlock.h>
>> +
>> +#include <asm/prom.h>
>> +#include <asm/machdep.h>
>> +#include <asm/uaccess.h>
>> +#include <asm/rtas.h>
>> +#include <asm/pSeries_reconfig.h>
>> +
>> +#define CFG_CONN_WORK_SIZE    4096
>> +static char workarea[CFG_CONN_WORK_SIZE];
>> +spinlock_t workarea_lock;
> 
> This can be:
> 
> static DEFINE_SPINLOCK(workarea_lock);
> 
> Then you can get rid of the runtime initializer.

Good catch,  I will fix it in the updated patches.

> 
>> +
>> +int release_drc(u32 drc_index)
>> +{
>> +    int dr_status, rc;
>> +
>> +    rc = rtas_call(rtas_token("get-sensor-state"), 2, 2, &dr_status,
>> +               DR_ENTITY_SENSE, drc_index);
>> +    if (rc || dr_status != DR_ENTITY_PRESENT)
>> +        return -1;
>> +
>> +    rc = rtas_set_indicator(ISOLATION_STATE, drc_index, ISOLATE);
>> +    if (rc)
>> +        return -1;
>> +
>> +    rc = rtas_set_indicator(ALLOCATION_STATE, drc_index, ALLOC_UNUSABLE);
>> +    if (rc) {
>> +        rtas_set_indicator(ISOLATION_STATE, drc_index, UNISOLATE);
>> +        return -1;
>> +    }
> 
> Is there a better return value here that might be more descriptive than -1?

Yes,  I could return the rtas error code to the user to allow the caller to
evaluate it if they wanted to.  For what I am doing I am only concerned with
success/failure so I did not deal with returning anything other than -1.

I'll update the next patch to return the rtas error for failures and 0
for success.

> 
> 
>> +
>> +    return 0;
>> +}
>> +
>> +static int pseries_dlpar_init(void)
>> +{
>> +    spin_lock_init(&workarea_lock);
>> +
>> +    if (!machine_is(pseries))
>> +        return 0;
> 
> What's the point of this if check if you return 0 either way?

Yes, it seems a bit odd here, but in patches later in this series I
add additional initialization steps after the machine_is() check
such that it makes sense to bail out here if the check fails.

> 
>> +
>> +    return 0;
>> +}
>> +__initcall(pseries_dlpar_init);
> 
> 
>> Index: powerpc/arch/powerpc/platforms/pseries/reconfig.c
>> ===================================================================
>> --- powerpc.orig/arch/powerpc/platforms/pseries/reconfig.c    2009-09-11
>> 12:43:39.000000000 -0500
>> +++ powerpc/arch/powerpc/platforms/pseries/reconfig.c    2009-09-11
>> 12:51:52.000000000 -0500
>> @@ -95,7 +95,7 @@
>>     return parent;
>> }
>>
>> -static BLOCKING_NOTIFIER_HEAD(pSeries_reconfig_chain);
>> +struct blocking_notifier_head pSeries_reconfig_chain =
>> BLOCKING_NOTIFIER_INIT(pSeries_reconfig_chain);
> 
> Can't this just be?
> 
> BLOCKING_NOTIFIER_HEAD(pSeries_reconfig_chain);
> 

I think I tried this and was having issues,  I don't remember what they
were though.  I will try to fix this in the updated patch.

-Nathan Fontenot
