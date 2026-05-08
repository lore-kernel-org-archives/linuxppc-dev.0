Return-Path: <linuxppc-dev+bounces-20628-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D7CBCD3445
	for <linuxppc-dev@archiver.kernel.org>; Fri,  8 May 2026 17:25:32 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gBwxR1jbJz2xfR;
	Sat, 09 May 2026 03:25:31 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1778261131;
	cv=none; b=Qi5D/zE9I8AyHAVaTy6im5HZFg+ARrPlO9RnR+1lSl66x4NOYoSrwGCk+4qgPBtHETW/qebYdHlpk5Hy1DTW5kzWWUjKeLa9HuCIIb9iBJR2doneDCp6krq7v7NQO3lFdBgId1AL/am0FqNtJRAWJOEezdNJraSHQ+p5os+6pnCR8FFQsVAgqnSRjwPr2V+k9UYyFOZkwptcJLQ43Uvo/UepjZ2YT4jVKeg5evFzH0dfjuGcpIfqyg3vXKY4Y1B6G3gpdhf1NNWyoiX/qqtRH/Jpef9wdzRkgrZID7l82ozmnk30KD2law2fDOc705/VrQDW3mcsEwxTiU5v8cacaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1778261131; c=relaxed/relaxed;
	bh=Zk6qoaaQDBCL+3IQLE8U/WHI7VhYsVKNP26/kMYwb+A=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=chltwx5goM+fAduHJcTsC6sEI9CR/OgOPU+N6HRVadXqHAx7k7ybix44PRV7EJ0KDOATUDnEpSwNmnJLSY7fMHQLITzMpoko6IUGSTqv+DEdPUNXkPzG+IeCgOBqYIBnp/Z+qMETdRs1huZ8ZaB9OpSPcfvyW5s8LmMEkLvnAR1homjdBZO8QELEhz4J3JCmjGxSsKMNFnbcvUoFZsBwr1+ICn9Wcb+pIsKFiUsMSFDnBo9JKRia3kLGQl29iDQ7k2Hv1ivb3AFwhXqaSXf6bF3o4eMTGzZXjsFGtJxsKUMIGOUzfMexyPi/h8FeTTKPL0W9/+uWHL2sn9p+A5IPVA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=ZwmB+Evt; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=tyreld@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=ZwmB+Evt;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=tyreld@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gBwxP6JbDz2xdb
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 09 May 2026 03:25:29 +1000 (AEST)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 648FADPr837252
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 8 May 2026 17:25:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=Zk6qoa
	aQDBCL+3IQLE8U/WHI7VhYsVKNP26/kMYwb+A=; b=ZwmB+EvtCwKmWwq9paqMjY
	nHaGa0RNtaRpPtjOzR3yjXR+Eg8c5vtekUlKHWGbJUG5nDT4r6r759BhWU3rxL3v
	QM3x96m1AAyLSg6qdhLriBHrLjY8JBzj2tF0SdWoxyO87VSGE/UnZlCSbKoQkOTD
	jMKLekqFIu8Ad4YkLXa4Y7byLNhV601+DlK5sA26NQTvZlwK/1MvQP8XXFztnMud
	P7fYTUqr3rA8oQvvS947LAJ++qS5DYPag/qoZBnuKsOM2Prac1M4u4QX1tPZzwet
	xPHin8mfpPQd/1LRmQb1vXdeJqTvrp7Aqhl6psMNeL9T/e4R1EdwEcpo96wt+3wQ
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dw9x54vmg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 08 May 2026 17:25:27 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 648HOUOR017238
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 8 May 2026 17:25:26 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4dww3hh4p1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 08 May 2026 17:25:26 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
	by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 648HPPQo18481892
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 8 May 2026 17:25:26 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B5A685805E
	for <linuxppc-dev@lists.ozlabs.org>; Fri,  8 May 2026 17:25:25 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8DEC558056
	for <linuxppc-dev@lists.ozlabs.org>; Fri,  8 May 2026 17:25:25 +0000 (GMT)
Received: from [9.61.41.41] (unknown [9.61.41.41])
	by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP
	for <linuxppc-dev@lists.ozlabs.org>; Fri,  8 May 2026 17:25:25 +0000 (GMT)
Message-ID: <9cd14a95-163b-47d5-aa19-a54d3c517559@linux.ibm.com>
Date: Fri, 8 May 2026 10:25:25 -0700
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
List-Unsubscribe: <mailto:linuxppc-dev+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] ibmvfc: use async sub-queue for FPIN messages
To: linuxppc-dev@lists.ozlabs.org
References: <20260408-ibmvfc-fpin-support-v1-0-52b06c464e03@linux.ibm.com>
 <20260408-ibmvfc-fpin-support-v1-4-52b06c464e03@linux.ibm.com>
 <e59242e4-f353-44eb-ad48-b76a9101d4fb@linux.ibm.com>
 <87ecjmetcm.fsf@linux.ibm.com>
Content-Language: en-US
From: Tyrel Datwyler <tyreld@linux.ibm.com>
In-Reply-To: <87ecjmetcm.fsf@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA4MDE3MSBTYWx0ZWRfX5XE/AXBjSxUc
 6Gk/ENI7+ariKkthhbYW+Jv8IViO83/JBq7beg86pKyI1sqCsWk+ITQ9gLdK61FkyJlImVXAx1T
 Pb0HR73q6jdgSIwJthMDLhhdApaiX+kh7h6QZBzAaCgBnYPHrRnJ37VCPQU+dkt0NUzY3kNPUni
 Igg+y1e9vzKsVVNw/B9pX84Zng26Hl6Nj2vlPXB33ege38kz1qbffrFENM04TZIl2Hq09Ww95tC
 /sYsJMTvGsGxlyCmIOzqpEh+pqaoHURcAT+AmZh8zi8+cP72BGeBAozWkBDMITQAbv5b6oaNPrL
 OBKUpY3fV7Fn3TyGHxkgmE7qxxnbiUoBjZLMsICZe2RG+FTLA8/ELTDr0LvkKdBiyghaZVFMd6X
 0gYU6ytY5e+Yaq0haLUxhBjtMg4o65SaJKVf8Kp8qlBOTOkwJQsJD3Lr2Yp9xyL9nk8AuNCb3xR
 WzYDSdsUDtsZtF8sPVg==
X-Proofpoint-ORIG-GUID: GLjKTd4aHqd6CwgF8jIJp3VGjdDHog0p
X-Proofpoint-GUID: GLjKTd4aHqd6CwgF8jIJp3VGjdDHog0p
X-Authority-Analysis: v=2.4 cv=W7UIkxWk c=1 sm=1 tr=0 ts=69fe1c87 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=WkiKHRdk5crKdjcj-vAA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-07_02,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 lowpriorityscore=0 malwarescore=0
 suspectscore=0 spamscore=0 clxscore=1015 phishscore=0 bulkscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2605080171

On 5/7/26 3:40 PM, Dave Marquardt wrote:
> Tyrel Datwyler <tyreld@linux.ibm.com> writes:
> 
>> On 4/8/26 10:07 AM, Dave Marquardt via B4 Relay wrote:
>>> From: Dave Marquardt <davemarq@linux.ibm.com>
>>>

<snip>

>>> diff --git a/drivers/scsi/ibmvscsi/ibmvfc.c b/drivers/scsi/ibmvscsi/ibmvfc.c
>>> index 803fc3caa14d..26e39b367022 100644
>>> --- a/drivers/scsi/ibmvscsi/ibmvfc.c
>>> +++ b/drivers/scsi/ibmvscsi/ibmvfc.c
>>> @@ -1471,6 +1471,13 @@ static void ibmvfc_gather_partition_info(struct ibmvfc_host *vhost)
>>>  	of_node_put(rootdn);
>>>  }.
>>>  
>>> +static __be64 ibmvfc_npiv_chan_caps[] = {
>>> +	cpu_to_be64(IBMVFC_CAN_USE_CHANNELS | IBMVFC_USE_ASYNC_SUBQ |
>>> +		    IBMVFC_YES_SCSI | IBMVFC_CAN_HANDLE_FPIN),
>>> +	cpu_to_be64(IBMVFC_CAN_USE_CHANNELS),
>>> +};
>>> +#define IBMVFC_NPIV_CHAN_CAPS_SIZE (sizeof(ibmvfc_npiv_chan_caps)/sizeof(__be64))
>>> +
>>
>> I really don't understand what you are doing here? You seem to be definig
>> various sets of capabilities, but how does the driver decide which set to use?
>> As far as I can tell the index is increased and the capabilities decrease each
>> time a transport event is received. This looks like maybe its just a testing hack.
> 
> My thought was to deal with an older VIOS that doesn't support the async
> sub-queue and full FPIN. But I suppose the response should just not set the
> appropriate bits. I'll go re-read the NPIV spec and figure out if this
> is actually needed.
> 

Exactly, we should blanket set everything we support, and then rely on what the
VIOS advertises as support to then setup the proper facilities on our end.

-Tyrel

