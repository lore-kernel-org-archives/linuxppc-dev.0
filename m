Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE80D606A338
	for <linuxppc-dev@archiver.kernel.org>; Thu, 19 Nov 2026 09:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=dl0TFsym
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jVXzG0ZBSz2xSF;
	Thu, 19 Nov 2026 20:21:46 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795080106;
	cv=none; b=L3PHorafxKY/47f2hFze97VqhTGsN1H9JyQ5QH4h8mawoohKr4zVA6Yf2qj03ixAJAiXhfbiDPsYE4C9bXK88pCCLbyRymHAQagMI5FKl+bLl3Cf2pU9B5873PSGweYtldfs53wNj3cLitAiGA5HStgPpuP64woezS7k2cnalwzjxHYyTukcwb4YTNsNQQ+kYOkAb+NY3BqtRUYl6VBRaJEho7MbvXcxGkCtOI6pRdl0tKeHo54Yl8gU8ySZF/walLphctLY7fj5QKjcZppEDEKecRbudYhvuFTdEjXnOXmDZA3w4Zt60x8a4UEJzhVYdK75d8nHZLRmXhCdDE9SHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795080106; c=relaxed/relaxed;
	bh=jRrBY3O8lGpChM2JaZsoRDnKgs4Xyr+hdH9kVm1Qt40=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=k5EraGsdHHgY/WUBLbBYY8EYyerKVp7YasXCK9f4Fleq8TXOED2/hxYbQIue/K4Q3IKP86Rp/DNa9e69v8Kg3RLWCqynum8a//bSXMEqJwlUydQOB26vVec3ZdcIneR4saAKuJ8YAQUMVcNCxHBt+kaWktocMS9WOdDbLiK1BYeU9/SHVNytLdgtLfSXsuQJEDaxcHWn2ie78Nt7u352ZT2qm5wYmWwx04kf5Jnnd2eeX25azrofjOOHUyvRDgwGmzIBr/0TcIccAB72c0syBs9dg8TOXvULgLuHdnGm8pCdA4XYI6w0wQS3gh0/LJD2APE7L47JPFo1DKgPJiRicw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=dl0TFsym; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=sshegde@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=dl0TFsym;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=sshegde@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jVXzF1Ctmz2xLG
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Nov 2026 20:21:44 +1100 (AEDT)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AJ6udar3598516;
	Thu, 19 Nov 2026 09:21:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=jRrBY3
	O8lGpChM2JaZsoRDnKgs4Xyr+hdH9kVm1Qt40=; b=dl0TFsymlzK4ko56OuLIPG
	ISXnQf25I6Ei8ytrexUtRc5JGELhSUfDKJ5h3oEQugfuIhvq1lwDYAZ3CN4Mb4Tk
	UQV3CuEzkvX8Iig4WTgAKylxGzipW3nHYxnV8JM7TQunJ9zusj6rj6VoM2ppbqNd
	umkzG2GObWBNOnq2BGV6Qz6a4D4DwJAGsaer2aRGsB3wWM6LlII0ohw+1azGgYDb
	rv4XPIOllGVfntffKdf9YUxLZ70W6Rh7NUc06TIhhhquMSYY+vX8Y+1UavCAJirh
	shh18TfQYlOlA9nsq4FinQZrmnOVSFqQ1gAiD+zz6hVxdFX7PDtFlBdJFb38ho6Q
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4j105nfx93-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 19 Nov 2026 09:21:34 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6AJ7JvZK2580352;
	Thu, 19 Nov 2026 09:21:33 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4hy2bvpn11-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 19 Nov 2026 09:21:31 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6AJ9LR3h31261272
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 19 Nov 2026 09:21:27 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 63E9320040;
	Thu, 19 Nov 2026 09:21:27 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1C6BB2004B;
	Thu, 19 Nov 2026 09:21:24 +0000 (GMT)
Received: from [9.124.217.219] (unknown [9.124.217.219])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 19 Nov 2026 09:21:23 +0000 (GMT)
Message-ID: <0cde289c-e86b-4469-ac35-c47d3c860671@linux.ibm.com>
Date: Thu, 19 Nov 2026 14:51:22 +0530
X-Mailing-List: linuxppc-dev@lists.ozlabs.org
List-Id: <linuxppc-dev.lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev+help@lists.ozlabs.org>
List-Owner: <mailto:linuxppc-dev+owner@lists.ozlabs.org>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>,
  <https://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Subscribe: <mailto:linuxppc-dev+subscribe@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-digest@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-nomail@lists.ozlabs.org>
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] cacheinfo: Allow architectures to provide custom
 cache IDs
To: Srikar Dronamraju <srikar@linux.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        driver-core@lists.linux.dev, christophe.leroy@csgroup.eu,
        maddy@linux.ibm.com, gregkh@linuxfoundation.org, rafael@kernel.org,
        dakr@kernel.org, johan@kernel.org, sudeep.holla@kernel.org,
        ritesh.list@gmail.com, tim.c.chen@linux.intel.com, yu.c.chen@intel.com
References: <20261118163639.890546-1-sshegde@linux.ibm.com>
 <20261118163639.890546-2-sshegde@linux.ibm.com>
 <av6Y_drdhr4B7RpD@linux.ibm.com>
From: Shrikanth Hegde <sshegde@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <av6Y_drdhr4B7RpD@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE5MDAzNSBTYWx0ZWRfX8jarueYzS2I6
 yS9x/2lUSK7lE96Xs3RcjPdQNN4t+4jhAfwDQe2Vd5UpoeFXhvHfc4V57apVbqOn2AseJ00VLwl
 JHnIzaxQNcfbOSUJs+zho8HykGAlEOJFVogVJXYz+wVyXNB/fuNyt3M9JaZmPPHz5XT5jz2N/wA
 QRlQYdBquqVLi3E+MBa9TEudvPOtEDue7kdboRVnNgEOJQLwosfZMFy5Qnz0z/JEjYEDtFY7QFW
 m3ZGwR95BPRdgi7j60OJNf5OH42zUHxGw1R8yJkrKIh2YXkWyvJi4JTcYYkBxw3QecV2nQI5zat
 HY5gYat1LtoqOknhOhIuvvVfcd1SaL3fXU4gqDbvAfUWXMP3l5QpHt/MYfXN321UxEAhPb8psMs
 /PPnH+t35g21dYnWI4k96edVdKcoPvZKKM6UpJ2m1saT1utF/KHPrrHuJ6o4DmVll96hVtBzyuC
 p8E/IQiLJ/qmmHSNWnw==
X-Authority-Analysis: v=2.4 cv=HN9WhYtv c=1 sm=1 tr=0 ts=6afebf9f cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8
 a=kDF6wjTLlwxvCUsGSk0A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: 7tscHM9lwJVHvHJKed4N8ahFMjzmBDkr
X-Proofpoint-ORIG-GUID: myTU5v3aVlT06ogBr-qKtBu1k3SqUwDB
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE5MDAzNSBTYWx0ZWRfX/Zkq6qt4zt8w
 5fmC4HvoDtLKhSqSMKafTfEmhYep6DTCDYfe1Fhir+P2PEhQXL25IUlbBJ5O/iTAKiGrbLLqRJ0
 V3U0kEbwswvH8AVO5LTAFnUA4KMvkW0=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-19_02,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 impostorscore=0 suspectscore=0 malwarescore=0
 adultscore=0 phishscore=0 lowpriorityscore=0 clxscore=1015 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611190035
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Srikar. Thanks for going through the patches.

On 11/19/26 12:06 PM, Srikar Dronamraju wrote:
> * Shrikanth Hegde <sshegde@linux.ibm.com> [2026-11-18 22:06:35]:
> 
>> On PowerPC, a firmware cache node does not always correspond to a single
>> hardware cache instance.
>>
>> ---
>>   drivers/base/cacheinfo.c  | 43 +++++++++++++++++++++++++++++++--------
>>   include/linux/cacheinfo.h |  1 +
>>   2 files changed, 35 insertions(+), 9 deletions(-)
>>
>> diff --git a/drivers/base/cacheinfo.c b/drivers/base/cacheinfo.c
>> index eb8a907f6d50..10a9bbce899e 100644
>> --- a/drivers/base/cacheinfo.c
>> +++ b/drivers/base/cacheinfo.c
>> @@ -243,22 +243,46 @@ static bool match_cache_node(struct device_node *cpu,
>>   #define arch_compact_of_hwid(_x)	(_x)
>>   #endif
>>   
>> +/*
>> + * Return an architecture-specific cache ID for @cpu and @level.
>> + *
>> + * Return 0 and store the ID in @id when the architecture provides the
>> + * cache identity. Return an error to use the generic firmware-derived
>> + * cache ID instead.
>> + *
> 
> If the return is only going to be bool, then does it make sense to return
> bool instead of a int, esp does it need to return -ENOENT
> or may be returning the id itself would be better.
>

It follows current signature of other hooks. I think we can keep as is.

  
>> + * The ID must uniquely identify a cache among caches of the same level
>> + * and type.
>> + */
>> +int __weak cacheinfo_get_arch_id(unsigned int cpu, unsigned int level,
>> +				 unsigned int *id)
>> +{
>> +	return -ENOENT;
>> +}
>> +
> 
> Can we use the #define, #ifndef way instead of the weak function
> or is there a reason why only weak would work?

Same comment here. All Other arch hooks in this file are defined as weak functions.
cacheinfo_get_arch_id doesn't need a special treatment.

> 
>>   static void cache_of_set_id(struct cacheinfo *this_leaf,
>> -			    struct device_node *cache_node)
>> +			    struct device_node *cache_node,
>> +			    unsigned int cpu)
>>   {
>> -	struct device_node *cpu;
>> +	struct device_node *cpu_node;
>>   	u32 min_id = ~0;
>> +	unsigned int arch_id;
>> +
>> +	if (!cacheinfo_get_arch_id(cpu, this_leaf->level, &arch_id)) {
>> +		this_leaf->id = arch_id;
>> +		this_leaf->attributes |= CACHE_ID;
>> +		return;
>> +	}
>>   
>> -	for_each_of_cpu_node(cpu) {
>> -		u64 id = of_get_cpu_hwid(cpu, 0);
>> +	for_each_of_cpu_node(cpu_node) {
>> +		u64 id = of_get_cpu_hwid(cpu_node, 0);
>>   
>>   		id = arch_compact_of_hwid(id);
>>   		if (FIELD_GET(GENMASK_ULL(63, 32), id)) {
>> -			of_node_put(cpu);
>> +			of_node_put(cpu_node);
>>   			return;
>>   		}
>>   
>> -		if (match_cache_node(cpu, cache_node))
>> +		if (match_cache_node(cpu_node, cache_node))
>>   			min_id = min(min_id, id);
>>   	}
>>   
>> @@ -269,7 +293,8 @@ static void cache_of_set_id(struct cacheinfo *this_leaf,
>>   }
>>   
>>   static void cache_of_set_props(struct cacheinfo *this_leaf,
>> -			       struct device_node *np)
>> +			       struct device_node *np,
>> +			       unsigned int cpu)
>>   {
>>   	/*
>>   	 * init_cache_level must setup the cache level correctly
>> @@ -283,7 +308,7 @@ static void cache_of_set_props(struct cacheinfo *this_leaf,
>>   	cache_get_line_size(this_leaf, np);
>>   	cache_nr_sets(this_leaf, np);
>>   	cache_associativity(this_leaf);
>> -	cache_of_set_id(this_leaf, np);
>> +	cache_of_set_id(this_leaf, np, cpu);
>>   }
>>   
>>   static int cache_setup_of_node(unsigned int cpu)
>> @@ -309,7 +334,7 @@ static int cache_setup_of_node(unsigned int cpu)
>>   			if (!np)
>>   				break;
>>   		}
> 
>> -		cache_of_set_props(this_leaf, np);
>> +		cache_of_set_props(this_leaf, np, cpu);
> 
> 
> Would it make sense to get the cacheinfo arch id here.
> That way we could avoid lot of this changes just to pass a CPU, or renaming
> of the variable etc. We will probably will need a check in cache_of_set_id
> to see if the this_leaf->id is set to bail out
> 

Since it is id set by arch, i think it is better to do this in cache_of_set_id.

I think some are sensible. It is better to name device node of cpu as cpu_node
rather than cpu.

>>   		this_leaf->fw_token = np;
>>   		index++;
>>   	}
>> diff --git a/include/linux/cacheinfo.h b/include/linux/cacheinfo.h
>> index 56fa646df0d1..d3557a1b464b 100644
>> --- a/include/linux/cacheinfo.h
>> +++ b/include/linux/cacheinfo.h
>> @@ -93,6 +93,7 @@ bool last_level_cache_is_shared(unsigned int cpu_x, unsigned int cpu_y);
>>   struct cacheinfo *get_cpu_cacheinfo_llc(unsigned int cpu);
>>   int fetch_cache_info(unsigned int cpu);
>>   int detect_cache_attributes(unsigned int cpu);
>> +int cacheinfo_get_arch_id(unsigned int cpu, unsigned int level, unsigned int *id);
>>   #ifndef CONFIG_ACPI_PPTT
>>   /*
>>    * acpi_get_cache_info() is only called on ACPI enabled
>> -- 
>> 2.54.0
>>
> 


