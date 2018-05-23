Return-Path: <mwb@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40rDgv4BVPzDrCm
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 May 2018 10:59:55 +1000 (AEST)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w4N0wsGu134860
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 May 2018 20:59:53 -0400
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2j4qsrym3d-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 May 2018 20:59:53 -0400
Received: from localhost
 by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <mwb@linux.vnet.ibm.com>;
 Tue, 22 May 2018 18:59:52 -0600
Subject: Re: [RFC v4 2/4] hotplug/drcinfo: Provide parser with callback
To: Nathan Fontenot <nfont@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
Cc: John Allen <jallen@linux.vnet.ibm.com>,
 Thomas Falcon <tlfalcon@linux.vnet.ibm.com>,
 Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
References: <2e2261b4-c0b3-3b6d-d649-541bc8802546@linux.vnet.ibm.com>
 <c9f225f4-591b-37b6-3d70-bf1ae7395a0c@linux.vnet.ibm.com>
From: Michael Bringmann <mwb@linux.vnet.ibm.com>
Date: Tue, 22 May 2018 19:59:49 -0500
MIME-Version: 1.0
In-Reply-To: <c9f225f4-591b-37b6-3d70-bf1ae7395a0c@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Message-Id: <b8d022d8-e1a4-c263-be16-0b0d1a2c7bfb@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

See below.

On 05/22/2018 04:23 PM, Nathan Fontenot wrote:
> On 05/22/2018 11:37 AM, Michael Bringmann wrote:
>> This patch provides a common parse function for the ibm,drc-info
>> property that can be modified by a callback function.  The caller
>> provides a pointer to the function and a pointer to their unique
>> data, and the parser provides the current lmb set from the struct.
>> The callback function may return codes indicating that the parsing
>> is complete, or should continue, along with an error code that may
>> be returned to the caller.
>>
>> Signed-off-by: Michael Bringmann <mwb@linux.vnet.ibm.com>
>> Fixes: 3f38000eda48 ("powerpc/firmware: Add definitions for new drc-info firmwar
>> e feature" -- end of patch series applied to powerpc next)
>> ---
>> Changes in V4:
>>   -- Update code to account for latest kernel checkins.
>>   -- Rebased to 4.17-rc5 kernel
>>   -- Some patch cleanup including file combination
>> ---
>>  arch/powerpc/include/asm/prom.h             |    7 +++++
>>  arch/powerpc/platforms/pseries/of_helpers.c |   37 +++++++++++++++++++++++++++
>>  2 files changed, 44 insertions(+)
>>
>> diff --git a/arch/powerpc/include/asm/prom.h b/arch/powerpc/include/asm/prom.h
>> index b04c5ce..2e947b3 100644
>> --- a/arch/powerpc/include/asm/prom.h
>> +++ b/arch/powerpc/include/asm/prom.h
>> @@ -94,6 +94,13 @@ struct of_drc_info {
>>  extern int of_read_drc_info_cell(struct property **prop,
>>  			const __be32 **curval, struct of_drc_info *data);
>>
>> +extern int drc_info_parser(struct device_node *dn,
>> +			int (*usercb)(struct of_drc_info *drc,
>> +					void *data,
>> +					void *optional_data,
>> +					int *ret_code),
>> +			char *opt_drc_type,
>> +			void *data);
> 
> After looking at the patch 3 in this series, I think a couple of comments and
> a small change may help. It was not clear at first what the call back function
> was supposed to return. After reading users of this routine it appears that the
> callback function is returning a bool value indicating whether or not the parser
> should continue. I documenting this and having the callback routine return a bool
> may make this clearer.

Okay.
> 
> Also, I see other places in the kernel name these types of routines as walk_*,
> perhaps a slight name change to walk_drc_info_entries() may also make it clearer
> what the code is doing.

Okay.
> 
> -Nathan

Michael
> 
>>
>>  /*
>>   * There are two methods for telling firmware what our capabilities are.
>> diff --git a/arch/powerpc/platforms/pseries/of_helpers.c b/arch/powerpc/platforms/pseries/of_helpers.c
>> index 11b2ef1..a588ee6 100644
>> --- a/arch/powerpc/platforms/pseries/of_helpers.c
>> +++ b/arch/powerpc/platforms/pseries/of_helpers.c
>> @@ -6,6 +6,9 @@
>>  #include <asm/prom.h>
>>
>>  #include "of_helpers.h"
>> +#include "pseries.h"
>> +
>> +#define	MAX_DRC_NAME_LEN 64
>>
>>  /**
>>   * pseries_of_derive_parent - basically like dirname(1)
>> @@ -87,3 +90,37 @@ int of_read_drc_info_cell(struct property **prop, const __be32 **curval,
>>  	return 0;
>>  }
>>  EXPORT_SYMBOL(of_read_drc_info_cell);
>> +
>> +int drc_info_parser(struct device_node *dn,
>> +		int (*usercb)(struct of_drc_info *drc,
>> +				void *data,
>> +				void *optional_data,
>> +				int *ret_code),
>> +		char *opt_drc_type,
>> +		void *data)
>> +{
>> +	struct property *info;
>> +	unsigned int entries;
>> +	struct of_drc_info drc;
>> +	const __be32 *value;
>> +	int j, done = 0, ret_code = -EINVAL;
>> +
>> +	info = of_find_property(dn, "ibm,drc-info", NULL);
>> +	if (info == NULL)
>> +		return -EINVAL;
>> +
>> +	value = info->value;
>> +	entries = of_read_number(value++, 1);
>> +
>> +	for (j = 0, done = 0; (j < entries) && (!done); j++) {
>> +		of_read_drc_info_cell(&info, &value, &drc);
>> +
>> +		if (opt_drc_type && strcmp(opt_drc_type, drc.drc_type))
>> +			continue;
>> +
>> +		done = usercb(&drc, data, NULL, &ret_code);
>> +	}
>> +
>> +	return ret_code;
>> +}
>> +EXPORT_SYMBOL(drc_info_parser);
>>
> 
> 

-- 
Michael W. Bringmann
Linux Technology Center
IBM Corporation
Tie-Line  363-5196
External: (512) 286-5196
Cell:       (512) 466-0650
mwb@linux.vnet.ibm.com
