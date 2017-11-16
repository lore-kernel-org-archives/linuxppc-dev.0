Return-Path: <mwb@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yd8yJ19bYzDr6D
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Nov 2017 05:33:27 +1100 (AEDT)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 vAGIKsc6023200
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Nov 2017 13:33:25 -0500
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2e9erm4gvj-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Nov 2017 13:33:25 -0500
Received: from localhost
 by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <mwb@linux.vnet.ibm.com>;
 Thu, 16 Nov 2017 11:33:24 -0700
Subject: Re: RESEND [PATCH V3 3/4] hotplug/drc-info: Add code to search
 ibm,drc-info property
To: Nathan Fontenot <nfont@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
References: <546ed8ce-b6f4-74f8-ba5b-d9bcd0798094@linux.vnet.ibm.com>
 <aa5e5ef6-3a28-0d52-93f6-48fcde133bf2@linux.vnet.ibm.com>
From: Michael Bringmann <mwb@linux.vnet.ibm.com>
Date: Thu, 16 Nov 2017 12:33:22 -0600
MIME-Version: 1.0
In-Reply-To: <aa5e5ef6-3a28-0d52-93f6-48fcde133bf2@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Message-Id: <bfe9de35-af0a-58a2-eb26-19d3e147e71b@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


>> +
>> +static int rpaphp_check_drc_props_v2(struct device_node *dn, char *drc_name,
>> +				char *drc_type, unsigned int my_index)
>> +{
>> +	struct property *info;
>> +	unsigned int entries;
>> +	struct of_drc_info drc;
>> +	void *value;
> 
> This should be __be32 *

Okay.

> 
>> +	int j;
>> +
>> +	info = of_find_property(dn->parent, "ibm,drc-info", NULL);
>> +	if (info == NULL)
>> +		return -EINVAL;
>> +
>> +	value = info->value;
>> +	value = (void *)of_prop_next_u32(info, value, &entries);
>> +	if (!value)
>> +		return -EINVAL;
>> +
>> +	for (j = 0; j < entries; j++) {
>> +		of_one_drc_info(&info, &value, &drc);
>> +
>> +		/* Should now know end of current entry */
>> +
>> +		WARN_ON((my_index < drc.drc_index_start) ||
>> +			(((my_index-drc.drc_index_start)%
>> +				drc.sequential_inc) != 0));
>> +
>> +		if (my_index > drc.last_drc_index)
>> +			continue;
>> +
>> +		break;
>> +	}
>> +	/* Found it */
>> +
>> +	if (((drc_name == NULL) ||
>> +	     (drc_name && !strncmp(drc_name,
>> +				drc.drc_name_prefix,
>> +				strlen(drc.drc_name_prefix)))) &&
> 
> Shouldn't we be doing a string compare on the entire name, not just the prefix?
> 
> If I remember correctly the prefix is the same for every cpu.

The prefix may be a value like "CPU", "MEM", "PHB", or other.
I modeled the comparisons using 'drc_name_prefix' after the comparison
of the 'name_tmp' found in the array 'ibm,drc-names' and 'type_tmp'
found in the array 'ibm,drc-types'.  This is modeled in the new
function 'rpaphp_check_drc_props_v1' which was lifted from the original
function rpaphp_get_drc_props().

> 
> -Nathan
> 

-- 
Michael W. Bringmann
Linux Technology Center
IBM Corporation
Tie-Line  363-5196
External: (512) 286-5196
Cell:       (512) 466-0650
mwb@linux.vnet.ibm.com
