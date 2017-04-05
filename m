Return-Path: <maddy@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vyXkQ3R53zDqH6
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  5 Apr 2017 14:22:38 +1000 (AEST)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v354KX2B037151
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 5 Apr 2017 00:22:36 -0400
Received: from e28smtp03.in.ibm.com (e28smtp03.in.ibm.com [125.16.236.3])
 by mx0a-001b2d01.pphosted.com with ESMTP id 29mq0ew2xu-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 05 Apr 2017 00:22:35 -0400
Received: from localhost
 by e28smtp03.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <maddy@linux.vnet.ibm.com>;
 Wed, 5 Apr 2017 09:52:32 +0530
Received: from d28av06.in.ibm.com (d28av06.in.ibm.com [9.184.220.48])
 by d28relay09.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v354MTSF9961696
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 5 Apr 2017 09:52:29 +0530
Received: from d28av06.in.ibm.com (localhost [127.0.0.1])
 by d28av06.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v354MRu1008317
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 5 Apr 2017 09:52:29 +0530
Subject: Re: [PATCH v6 01/11] powerpc/powernv: Data structure and macros
 definitions
To: Daniel Axtens <dja@axtens.net>, mpe@ellerman.id.au
References: <1491231308-15282-1-git-send-email-maddy@linux.vnet.ibm.com>
 <1491231308-15282-2-git-send-email-maddy@linux.vnet.ibm.com>
 <87h925kkn1.fsf@possimpible.ozlabs.ibm.com>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 ego@linux.vnet.ibm.com, bsingharora@gmail.com,
 benh@kernel.crashing.org, paulus@samba.org, anton@samba.org,
 sukadev@linux.vnet.ibm.com, mikey@neuling.org,
 stewart@linux.vnet.ibm.com, eranian@google.com,
 Hemant Kumar <hemant@linux.vnet.ibm.com>,
 Anju T Sudhakar <anju@linux.vnet.ibm.com>
From: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Date: Wed, 5 Apr 2017 09:52:26 +0530
MIME-Version: 1.0
In-Reply-To: <87h925kkn1.fsf@possimpible.ozlabs.ibm.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Message-Id: <204d2af0-aa83-19c3-7a1a-cf1b7215ac4a@linux.vnet.ibm.com>
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
>> +#define IMC_MAX_CHIPS			32
>> +#define IMC_MAX_PMUS			32
>> +#define IMC_MAX_PMU_NAME_LEN		256
> I've noticed this is used as both the maximum length for event names and
> event value strings. Would another name suit better?

This is used in the value string length comparison also. So yes, will
change the name to suit better.

Thanks for review
Maddy

>
>> +
>> +#define IMC_NEST_MAX_PAGES		16
>> +
>> +#define IMC_DTB_COMPAT			"ibm,opal-in-memory-counters"
>> +#define IMC_DTB_NEST_COMPAT		"ibm,imc-counters-nest"
>> +
>> +/*
>> + * Structure to hold per chip specific memory address
>> + * information for nest pmus. Nest Counter data are exported
>> + * in per-chip reserved memory region by the PORE Engine.
>> + */
>> +struct perchip_nest_info {
>> +	u32 chip_id;
>> +	u64 pbase;
>> +	u64 vbase[IMC_NEST_MAX_PAGES];
>> +	u64 size;
>> +};
>> +
>> +/*
>> + * Place holder for nest pmu events and values.
>> + */
>> +struct imc_events {
>> +	char *ev_name;
>> +	char *ev_value;
>> +};
>> +
>> +/*
>> + * Device tree parser code detects IMC pmu support and
>> + * registers new IMC pmus. This structure will
>> + * hold the pmu functions and attrs for each imc pmu and
>> + * will be referenced at the time of pmu registration.
>> + */
>> +struct imc_pmu {
>> +	struct pmu pmu;
>> +	int domain;
>> +	const struct attribute_group *attr_groups[4];
>> +};
>> +
>> +/*
>> + * Domains for IMC PMUs
>> + */
>> +#define IMC_DOMAIN_NEST		1
>> +#define IMC_DOMAIN_UNKNOWN	-1
>> +
>> +#endif /* PPC_POWERNV_IMC_PMU_DEF_H */
>> -- 
>> 2.7.4
