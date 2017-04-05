Return-Path: <maddy@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vybkP1GThzDqHG
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  5 Apr 2017 16:37:48 +1000 (AEST)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v356XVhv022108
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 5 Apr 2017 02:37:37 -0400
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
 by mx0b-001b2d01.pphosted.com with ESMTP id 29mee8xh62-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 05 Apr 2017 02:37:37 -0400
Received: from localhost
 by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <maddy@linux.vnet.ibm.com>;
 Wed, 5 Apr 2017 16:37:34 +1000
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v356bN7954591504
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 5 Apr 2017 16:37:31 +1000
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v356aw63004683
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 5 Apr 2017 16:36:59 +1000
Subject: Re: [PATCH v6 02/11] powerpc/powernv: Autoload IMC device driver
 module
To: Daniel Axtens <dja@axtens.net>, mpe@ellerman.id.au
References: <1491231308-15282-1-git-send-email-maddy@linux.vnet.ibm.com>
 <1491231308-15282-3-git-send-email-maddy@linux.vnet.ibm.com>
 <87inmlkknf.fsf@possimpible.ozlabs.ibm.com>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 ego@linux.vnet.ibm.com, bsingharora@gmail.com,
 benh@kernel.crashing.org, paulus@samba.org, anton@samba.org,
 sukadev@linux.vnet.ibm.com, mikey@neuling.org,
 stewart@linux.vnet.ibm.com, eranian@google.com,
 Hemant Kumar <hemant@linux.vnet.ibm.com>,
 Anju T Sudhakar <anju@linux.vnet.ibm.com>
From: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Date: Wed, 5 Apr 2017 12:06:31 +0530
MIME-Version: 1.0
In-Reply-To: <87inmlkknf.fsf@possimpible.ozlabs.ibm.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Message-Id: <05b9fddb-e6e5-102c-55af-e06cf3ca18f8@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On Tuesday 04 April 2017 07:18 AM, Daniel Axtens wrote:
> Hi,
>
>> +		do {
>> +			pages = PAGE_SIZE * i;
>> +			pcni->vbase[i++] = (u64)phys_to_virt(pcni->pbase +
>> +							     pages);
>> +		} while (i < (pcni->size / PAGE_SIZE));
> I also just noticed that there's no check here against
> IMC_NEST_MAX_PAGES: should that be inserted? (If for no other reason
> than to stop every static analysis tool complaining!)
Yes make sense. Can add that in the next version.

Thanks for review
Maddy


> Daniel
>
>> +	}
>> +
>> +	return 0;
>> +err:
>> +	return -ENODEV;
>> +}
>> +
>> +static const struct of_device_id opal_imc_match[] = {
>> +	{ .compatible = IMC_DTB_COMPAT },
>> +	{},
>> +};
>> +
>> +static struct platform_driver opal_imc_driver = {
>> +	.driver = {
>> +		.name = "opal-imc-counters",
>> +		.of_match_table = opal_imc_match,
>> +	},
>> +	.probe = opal_imc_counters_probe,
>> +};
>> +
>> +MODULE_DEVICE_TABLE(of, opal_imc_match);
>> +module_platform_driver(opal_imc_driver);
>> +MODULE_DESCRIPTION("PowerNV OPAL IMC driver");
>> +MODULE_LICENSE("GPL");
>> diff --git a/arch/powerpc/platforms/powernv/opal.c b/arch/powerpc/platforms/powernv/opal.c
>> index e0f856bfbfe8..85ea1296f030 100644
>> --- a/arch/powerpc/platforms/powernv/opal.c
>> +++ b/arch/powerpc/platforms/powernv/opal.c
>> @@ -14,6 +14,7 @@
>>   #include <linux/printk.h>
>>   #include <linux/types.h>
>>   #include <linux/of.h>
>> +#include <linux/of_address.h>
>>   #include <linux/of_fdt.h>
>>   #include <linux/of_platform.h>
>>   #include <linux/interrupt.h>
>> @@ -30,6 +31,7 @@
>>   #include <asm/opal.h>
>>   #include <asm/firmware.h>
>>   #include <asm/mce.h>
>> +#include <asm/imc-pmu.h>
>>   
>>   #include "powernv.h"
>>   
>> @@ -631,6 +633,15 @@ static void opal_pdev_init(const char *compatible)
>>   		of_platform_device_create(np, NULL, NULL);
>>   }
>>   
>> +static void opal_imc_init_dev(void)
>> +{
>> +	struct device_node *np;
>> +
>> +	np = of_find_compatible_node(NULL, NULL, IMC_DTB_COMPAT);
>> +	if (np)
>> +		of_platform_device_create(np, NULL, NULL);
>> +}
>> +
>>   static int kopald(void *unused)
>>   {
>>   	unsigned long timeout = msecs_to_jiffies(opal_heartbeat) + 1;
>> @@ -704,6 +715,9 @@ static int __init opal_init(void)
>>   	/* Setup a heatbeat thread if requested by OPAL */
>>   	opal_init_heartbeat();
>>   
>> +	/* Detect IMC pmu counters support and create PMUs */
>> +	opal_imc_init_dev();
>> +
>>   	/* Create leds platform devices */
>>   	leds = of_find_node_by_path("/ibm,opal/leds");
>>   	if (leds) {
>> -- 
>> 2.7.4
