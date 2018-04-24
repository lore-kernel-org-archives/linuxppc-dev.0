Return-Path: <mwb@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40VxRR1xSmzF24K
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Apr 2018 07:34:11 +1000 (AEST)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w3OLY8O8048882
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Apr 2018 17:34:08 -0400
Received: from e37.co.us.ibm.com (e37.co.us.ibm.com [32.97.110.158])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2hjbpk26q9-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Apr 2018 17:34:07 -0400
Received: from localhost
 by e37.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <mwb@linux.vnet.ibm.com>;
 Tue, 24 Apr 2018 15:33:58 -0600
Subject: Re: [RFC v2 2/3] postmigration/memory: Review assoc lookup array
 changes
To: Nathan Fontenot <nfont@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
Cc: John Allen <jallen@linux.vnet.ibm.com>,
 Thomas Falcon <tlfalcon@linux.vnet.ibm.com>,
 Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
References: <02fbce66-e91a-e553-21da-b9deedc2c528@linux.vnet.ibm.com>
 <69529aa2-aa7d-5107-0fa8-a0c9ad06420a@linux.vnet.ibm.com>
From: Michael Bringmann <mwb@linux.vnet.ibm.com>
Date: Tue, 24 Apr 2018 16:33:53 -0500
MIME-Version: 1.0
In-Reply-To: <69529aa2-aa7d-5107-0fa8-a0c9ad06420a@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Message-Id: <b2b58e09-39a8-755d-9875-74eeb10b8a35@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On 04/24/2018 12:01 PM, Nathan Fontenot wrote:
>> +};
>> +
>> +static int pseries_update_ala_memory_aai(int aa_index,
>> +					struct property *dmprop)

>> +
>> +static int pseries_update_ala_memory(struct of_reconfig_data *pr)


> The two routines above should be updated to use the in-kernel drmem array instead
> of looking up the dynamic-memory property in the device tree.

Okay.

> 
> -Nathan

Thanks.
Michael

> 
>> +
>>  static int pseries_memory_notifier(struct notifier_block *nb,
>>  				   unsigned long action, void *data)
>>  {
>> @@ -1067,6 +1184,9 @@ static int pseries_memory_notifier(struct notifier_block *nb,
>>  	case OF_RECONFIG_UPDATE_PROPERTY:
>>  		if (!strcmp(rd->prop->name, "ibm,dynamic-memory"))
>>  			err = pseries_update_drconf_memory(rd);
>> +		if (!strcmp(rd->prop->name,
>> +				"ibm,associativity-lookup-arrays"))
>> +			err = pseries_update_ala_memory(rd);
>>  		break;
>>  	}
>>  	return notifier_from_errno(err);
>>
> 

-- 
Michael W. Bringmann
Linux Technology Center
IBM Corporation
Tie-Line  363-5196
External: (512) 286-5196
Cell:       (512) 466-0650
mwb@linux.vnet.ibm.com
