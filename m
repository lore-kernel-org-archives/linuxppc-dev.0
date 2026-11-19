Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46069606A331
	for <linuxppc-dev@archiver.kernel.org>; Thu, 19 Nov 2026 09:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=cVQTfpPD
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jVY070BjXz2xlP;
	Thu, 19 Nov 2026 20:22:31 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795080150;
	cv=none; b=OVghZZspACK+0pWTHhFtezqR9OEDGLbknkn3rOy/w0LuXbI2NCpXJ+DuqOVlLXpnTiR9pXmajSgIBoxlNDDPo5WyIvinrjXuRzoZI2Z9yBzjUOZjFPHtLquZgpvHkDXbCd4x9pVqLhu9lPIqiJk02SIJTOoPVtWhW9TIdkn/GVM5GUHgyQJh7ROP/noK3zBCYITETObOp6HwOB8bajZTT8Fy6kwptuI+U4fI5JXLqBgxq9YvbtWowzCvJlijQ9ksZn3ElhPFwJzRQFjr4IKyvpt+BAIpJlKalmSCUpUyQv8eUNUvOs4YJ8VwwmdICXOkbapholwauqdgEDGOrc1D0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795080150; c=relaxed/relaxed;
	bh=9IebbM/CrE1KAXTiPPp7lFp488j2ib1AnDlFm7+FEB4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ccShOrcUb+NhFsOioE4g8gkaQH0McJhLyaXwVDg1vigwHdz77mtF5eMiB07HPZtlEzjFT7VEwOm7Vs3eX8Dd2YsjSuvGVvXxWXxtq3uYNbOpbaqgRh1W4LxQ3TSqAflavkwh3DMitdqxoaTWRWddeUBBgEadDouQaUhuFvBWpR76uF1Kx4xEuntUTpzLhRWr5v7sVoJr+Ei7R2qD6xYSgPl3wevc8Zm8boKlCB3NEL+A0+yNztEhQ4TzEIF7lpP7bxrODS5nUYYRHfN+k/Eg8t7oHLEsHvdZJuwrc1cppNlJTCRD9ngC4o4iX81KplMyfsLYGNaZreL47sF41FkDTw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=cVQTfpPD; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=sshegde@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=cVQTfpPD;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=sshegde@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jVY061V5fz2xSF
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Nov 2026 20:22:29 +1100 (AEDT)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AJ6ugeN3470125;
	Thu, 19 Nov 2026 09:22:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=9IebbM
	/CrE1KAXTiPPp7lFp488j2ib1AnDlFm7+FEB4=; b=cVQTfpPD8PiGQ6TeaDhmYv
	ZRXseZNNGYPnVwGY8Xpvkwf3z3B5T1Oq6qw35+6GvqDeNVeivvg7+3qmiqoNDfVs
	s7hGsYp/ITjhc+efVOysZ3zddqUKtfmIBmA4TPA5duicYHHcdkOhn86ezcgoMCme
	XrKxrdyh8vIWhJ4jfgs6FwOpxfhXJezZO0hVrGNvGRUc63L8xQ1sXPeHQFhprhf0
	1TlXBAjUBDr4A60PPWq/SCLEZsj5pubU6XM/O7UlPDye5hSpR7wvGZvTTCNfzvc+
	Kn02/RS+qa1OWDgY0epEvwRAd3kdSU/3VYafKR+Mnx24ZfFKJeKvzchkG7hoFHRQ
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4j105vqrsm-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 19 Nov 2026 09:22:16 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6AJ756sl2161149;
	Thu, 19 Nov 2026 09:22:16 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4j1v9x8pd6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 19 Nov 2026 09:22:15 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6AJ9MC3j37028200
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 19 Nov 2026 09:22:12 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0BBCB20043;
	Thu, 19 Nov 2026 09:22:12 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D372E2005A;
	Thu, 19 Nov 2026 09:22:08 +0000 (GMT)
Received: from [9.124.217.219] (unknown [9.124.217.219])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 19 Nov 2026 09:22:08 +0000 (GMT)
Message-ID: <40484542-eb1d-4a9e-824c-f931a713328e@linux.ibm.com>
Date: Thu, 19 Nov 2026 14:52:07 +0530
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
Subject: Re: [PATCH 2/5] cacheinfo: Support unified caches described by
 d-cache properties
To: Srikar Dronamraju <srikar@linux.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        driver-core@lists.linux.dev, christophe.leroy@csgroup.eu,
        maddy@linux.ibm.com, gregkh@linuxfoundation.org, rafael@kernel.org,
        dakr@kernel.org, johan@kernel.org, sudeep.holla@kernel.org,
        ritesh.list@gmail.com, tim.c.chen@linux.intel.com, yu.c.chen@intel.com
References: <20261118163639.890546-1-sshegde@linux.ibm.com>
 <20261118163639.890546-3-sshegde@linux.ibm.com>
 <av6a6sRqMgMXE73n@linux.ibm.com>
Content-Language: en-US
From: Shrikanth Hegde <sshegde@linux.ibm.com>
In-Reply-To: <av6a6sRqMgMXE73n@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: -EwAufk-Okzs8V5O55c77B5c3JpRl27L
X-Authority-Analysis: v=2.4 cv=HL9WhYtv c=1 sm=1 tr=0 ts=6afebfc9 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8
 a=E6V6OdINfws53FR3KKgA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: w2jB3gfNTagrZSv0EnkjvexbDGNRGHYM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE5MDAzNSBTYWx0ZWRfX3LtphBDLJgX1
 olPVJo74wnGn/5e5Ezh1WRYhosGqA82P3MwPKC1Zgi1kmbPDlKQtAQ2O991E9PMyERyMLyaNnRV
 km6bv3FasuWlmUSNjqj2gsGuk0DAMz9BuqjYImW4QMgjN1HrGeCsA+a29Hmo1JKLOTj/YO3xYSo
 PB5JugkUnufX4MRpzXlp1LbhLQE/DB7V4dpYSkYGP9AVDvfb2/k+ajogI11uyyqKZWlhz1CfXNp
 WoNjYpXH5wc03YFtbUVb3uRc6WOWb1FKCS886LiF7BJ6EhNl7zrtrDNXinWsmuoIZHqY2Opuver
 U468oCsWShKja1MF3kX9qKD/iNhTwcP/kW4glrftGgXRJJwO3IpT3Y80gJ1vILIlVEsX7FoRH61
 /bXCU5Ow+sLtnHBgJtPp2838Q3ffseLA2RcYj4t7Afyc4CqrTOy1xfdNi0VvevR0232IGb5q1Jm
 TxAjaGCp0+NOcU+9YYA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE5MDAzNSBTYWx0ZWRfX29m1+3cT+tQv
 ZjBWV+9ciDGglafufbn7FGEbjCFtV5c139gtmKd2dOPfjd5g5QzbDhWrqerpSs3fokGqOq5D+dB
 yIWn5wntVs3wB/HA21eVIQ7Tgz95pZo=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-19_02,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 spamscore=0 priorityscore=1501 impostorscore=0
 adultscore=0 clxscore=1015 lowpriorityscore=0 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611190035
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Srikar.

On 11/19/26 12:14 PM, Srikar Dronamraju wrote:
> * Shrikanth Hegde <sshegde@linux.ibm.com> [2026-11-18 22:06:36]:
> 
>> PowerPC device trees commonly describe a unified cache using d-cache-*
>> properties.
>>
>> For example, Power11 L2 and L3 cache nodes have cache-unified together
>> with properties such as:
>>
>>    d-cache-size
>>    d-cache-line-size
>>    d-cache-sets
>> ---
>>   drivers/base/cacheinfo.c | 24 +++++++++++++++++-------
>>   1 file changed, 17 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/base/cacheinfo.c b/drivers/base/cacheinfo.c
>> index 10a9bbce899e..4a23377e9312 100644
>> --- a/drivers/base/cacheinfo.c
>> +++ b/drivers/base/cacheinfo.c
>> @@ -148,11 +148,21 @@ static const struct cache_type_info cache_type_info[] = {
>>   	},
>>   };
>>   
>> -static inline int get_cacheinfo_idx(enum cache_type type)
>> +static inline int get_cacheinfo_idx(enum cache_type type, struct device_node *np)
>>   {
>> -	if (type == CACHE_TYPE_UNIFIED)
>> -		return 0;
>> -	return type;
>> +	if (type != CACHE_TYPE_UNIFIED)
>> +		return type;
>> +
>> +	/*
>> +	 * Some device-tree bindings describe unified caches using
>> +	 * d-cache-* properties. Select the data-cache property set
>> +	 * without changing the cache leaf type.
>> +	 */
>> +	if (!of_property_present(np, "cache-size") &&
> 
> Is it better to check if the device node np is NULL before doing the
> of_property_present?

When it arrives here, np is not NULL. So we don't need additional checks.

> 
>> +	    of_property_present(np, "d-cache-size"))
>> +		return CACHE_TYPE_DATA;
>> +
>> +	return 0;
>>   }
>>   
>>   static void cache_size(struct cacheinfo *this_leaf, struct device_node *np)
>> @@ -160,7 +170,7 @@ static void cache_size(struct cacheinfo *this_leaf, struct device_node *np)
>>   	const char *propname;
>>   	int ct_idx;
>>   
>> -	ct_idx = get_cacheinfo_idx(this_leaf->type);
>> +	ct_idx = get_cacheinfo_idx(this_leaf->type, np);
>>   	propname = cache_type_info[ct_idx].size_prop;
>>   
>>   	of_property_read_u32(np, propname, &this_leaf->size);
>> @@ -172,7 +182,7 @@ static void cache_get_line_size(struct cacheinfo *this_leaf,
>>   {
>>   	int i, lim, ct_idx;
>>   
>> -	ct_idx = get_cacheinfo_idx(this_leaf->type);
>> +	ct_idx = get_cacheinfo_idx(this_leaf->type, np);
>>   	lim = ARRAY_SIZE(cache_type_info[ct_idx].line_size_props);
>>   
>>   	for (i = 0; i < lim; i++) {
>> @@ -194,7 +204,7 @@ static void cache_nr_sets(struct cacheinfo *this_leaf, struct device_node *np)
>>   	const char *propname;
>>   	int ct_idx;
>>   
>> -	ct_idx = get_cacheinfo_idx(this_leaf->type);
>> +	ct_idx = get_cacheinfo_idx(this_leaf->type, np);
>>   	propname = cache_type_info[ct_idx].nr_sets_prop;
>>   
>>   	of_property_read_u32(np, propname, &this_leaf->number_of_sets);
>> -- 
>> 2.54.0
>>
> 


