Return-Path: <maddy@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vybgr0VK6zDqH6
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  5 Apr 2017 16:35:35 +1000 (AEST)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v356XWWY019410
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 5 Apr 2017 02:35:26 -0400
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
 by mx0a-001b2d01.pphosted.com with ESMTP id 29mq0f193q-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 05 Apr 2017 02:35:25 -0400
Received: from localhost
 by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <maddy@linux.vnet.ibm.com>;
 Wed, 5 Apr 2017 16:35:23 +1000
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v356ZDL846530776
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 5 Apr 2017 16:35:21 +1000
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v356Yi2e002676
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 5 Apr 2017 16:34:45 +1000
Subject: Re: [PATCH v6 02/11] powerpc/powernv: Autoload IMC device driver
 module
To: Daniel Axtens <dja@axtens.net>, mpe@ellerman.id.au
References: <1491231308-15282-1-git-send-email-maddy@linux.vnet.ibm.com>
 <1491231308-15282-3-git-send-email-maddy@linux.vnet.ibm.com>
 <87pogtkmyf.fsf@possimpible.ozlabs.ibm.com>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 ego@linux.vnet.ibm.com, bsingharora@gmail.com,
 benh@kernel.crashing.org, paulus@samba.org, anton@samba.org,
 sukadev@linux.vnet.ibm.com, mikey@neuling.org,
 stewart@linux.vnet.ibm.com, eranian@google.com,
 Hemant Kumar <hemant@linux.vnet.ibm.com>,
 Anju T Sudhakar <anju@linux.vnet.ibm.com>
From: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Date: Wed, 5 Apr 2017 12:04:20 +0530
MIME-Version: 1.0
In-Reply-To: <87pogtkmyf.fsf@possimpible.ozlabs.ibm.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Message-Id: <a5ffa4ae-35aa-2149-b0e7-3b7604f7a17a@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On Tuesday 04 April 2017 06:28 AM, Daniel Axtens wrote:
> Hi all,
>
> I'm trying to get my head around these patches - at this point I'm just
> doing a first pass, so I may have more substantive structural comments
> later on. In the mean time - here are some minor C nits:
>
>> + * Copyright	(C) 2016 Madhavan Srinivasan, IBM Corporation.
>> + *		(C) 2016 Hemant K Shaw, IBM Corporation.
> Should these be bumped to 2017?

Facepalm. my bad. Will fix it.
>> +
>> +		do {
>> +			pages = PAGE_SIZE * i;
>> +			pcni->vbase[i++] = (u64)phys_to_virt(pcni->pbase +
>> +							     pages);
>> +		} while (i < (pcni->size / PAGE_SIZE));
>> +	}
> I had to scroll back up to the top of this function to make sure I
> understood what this loop does. Would it be better to write it as:
>
> for (i = 0; i < (pcni->size / PAGE_SIZE); i++) {
>      pages = PAGE_SIZE * i;
>      pcni->vbase[i] = (u64)....
> }
Idea is to map all of the nest counter area since event
offset could be anywhere within this region.
Will document that here.

>
> And, just checking - this is expected to work on both 4 and 64kB pages?
Yes. thats the intended. That said, i need to fix the
IMC_NEST_MAX_PAGES value for 4K page size.
Reason being, there was a recent change in the
size of memory allocated for nest counters in the
HOMER region for the microcode.

>
>> +
>> +	return 0;
>> +err:
>> +	return -ENODEV;
> You're not releasing any resources here - would it be better to just
> replace the gotos with this return? I haven't checked to see if you
> change the function later on to allocate memory - if so please ignore :)

We check in multiple places in the function and return on fail.
Thats why we made it as a generic return with goto.


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
> Should this function be tagged __init?

Yes. Thats right. Will make the changes.

Thanks for review
Maddy

>
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
