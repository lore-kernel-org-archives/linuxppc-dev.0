Return-Path: <linuxppc-dev+bounces-29453-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EDE8CC6B1A
	for <linuxppc-dev@archiver.kernel.org>; Wed, 14 Oct 2026 04:18:49 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j4HyH502Rz2yYK;
	Wed, 14 Oct 2026 15:18:47 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1791951527;
	cv=none; b=kd/A5UrqQDbzQ4PKToDLi6bCBkBRMV1npn0KExiMov5Cyjia7Oa88qrw2WgHXPz+citIXmcP1UyXuFOPZYgZFIaq1deBHGfeEHA6d9M4B6jPCnZo/G2aGjfLzgm3Fvl2GVM6FAZlo19/Ot434EuBKO4Y+i7ZIaxobZCAbz25lnd9yPL9ycWWdN6iKI9n51ElVx7cO5HHxKnMKyVVpK9FFNnTC1BTLS5Zr2IEsAbiczQewMRkH7JWjKCe3BmQDZV6sGBK3spe+/I1OXN6kzHW1qP/mr6pCXQz4XqXmcijEa3zXiPYXd+INQxna9E7SEA772E6p7XHkZmVaXUiSwNoXA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1791951527; c=relaxed/relaxed;
	bh=rtd3EoTSGwNNvIYdDclcR6RR5tnU8UkvIS0m5BBVYI0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MeteT5+n4G+41Sd9+l4YuxjeuuQqcPZQoNVujDDWGbMgr5YGkGTRA0IyLiEIjd1MOBpbQbTnbJFsYBaB/EuY0inD6W6mDdAlBB7vpgOwAv/KCd8APb0PcljP7rgspjdYpFYjt8EONm51fb+bHHNFM+q620Xo2MS6eiXxHOEG5yDQ1PippRXCCoPBxxtcPWO/tY90a91uN98UKuQyP0NBr6MTdntGS2ZJgygI2mbkODkdXtpm/Q9pDofrao0zJUB6n95cJ4WnPMfnF0lSGzAx6DaLBOmJ0/5e9V35p2Dr/4Y+p12aN6/XKC7+o/28uobzIjQ0Ds1WW/V3ItbK6DP6qA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=PshrBJo6; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=sshegde@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=PshrBJo6;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=sshegde@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j4HyG6RqKz2yVd
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Oct 2026 15:18:46 +1100 (AEDT)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69DME0Rg150374;
	Wed, 14 Oct 2026 04:18:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=rtd3Eo
	TSGwNNvIYdDclcR6RR5tnU8UkvIS0m5BBVYI0=; b=PshrBJo6gC+ZQjpOZegPFw
	f0FP33M/SisjzFZi0EgDEV8dOqqASbK4fcV85XEf1LtVcBOlJao1ySU7w4dZqc3Z
	zjas1CeRyxkACqaHau/oX44A5iqhhhKvAT5yK4XDsywcYaCy2CL/M2aJxlhEaaIn
	66Gbb+3c5t8vK3Ib63yW9yeD6Eu4V0jQ+CefFcNVoNQYmBsHuyFVBmnrRB8J1o34
	7UzUDUDWeV8HmzaEe7EWx3YRwgjm0MsPIdADItQ/jzM14cF4kxYuLzW4XtsEdMdh
	Ohs8HYpnTII4RRzd+FvybwVxV0gnWdjxNUSkyCVQNAz9P8b2TjL95G6t/j9ZE1jg
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h7dwhjag6-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 14 Oct 2026 04:18:27 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69E215xT3303971;
	Wed, 14 Oct 2026 04:18:26 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4h9qb6u2ay-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 14 Oct 2026 04:18:26 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69E4IMQu35651996
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 14 Oct 2026 04:18:22 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CF13E20043;
	Wed, 14 Oct 2026 04:18:22 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B9C8520040;
	Wed, 14 Oct 2026 04:18:19 +0000 (GMT)
Received: from [9.124.213.187] (unknown [9.124.213.187])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 14 Oct 2026 04:18:19 +0000 (GMT)
Message-ID: <baad6173-30e0-45de-ac0a-fd403c869add@linux.ibm.com>
Date: Wed, 14 Oct 2026 09:48:18 +0530
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
Subject: Re: [PATCH 0/4] powerpc/topology: Introduce llc_override debugfs
To: Srikar Dronamraju <srikar@linux.ibm.com>,
        Tim Chen <tim.c.chen@linux.intel.com>
Cc: christophe.leroy@csgroup.eu, linux-kernel@vger.kernel.org,
        ritesh.list@gmail.com, kprateek.nayak@amd.com, yu.c.chen@intel.com,
        vineethr@linux.ibm.com, vincent.guittot@linaro.org, npiggin@gmail.com,
        mpe@ellerman.id.au, maddy@linux.ibm.com, linuxppc-dev@lists.ozlabs.org,
        peterz@infradead.org
References: <20261012102037.2477378-1-sshegde@linux.ibm.com>
 <0cbd60fcf328ffcb317739f60d327da3af6145f1.camel@linux.intel.com>
 <dfd8312d-a59c-4480-b054-d94d2e66110e@linux.ibm.com>
 <4d0f2f4631f2f836bb1aec140c2c8e3e11d7ba20.camel@linux.intel.com>
 <5f107344-7ddf-402e-809c-7229ff6fb6d5@linux.ibm.com>
 <as79e9ZRXp28QLkG@linux.ibm.com>
Content-Language: en-US
From: Shrikanth Hegde <sshegde@linux.ibm.com>
In-Reply-To: <as79e9ZRXp28QLkG@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE0MDAxNiBTYWx0ZWRfX0uDjNjO5J3cW
 Un+IVWVmX55fJXgAwGxwI0cW03YzGppKzi415WIgtDNev1M4njz9OiE4s3kpUWQOnMVz8qkGjBr
 H2cFajPEL1CsZmTGD2i5QViYJQbBebs=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE0MDAxNiBTYWx0ZWRfXySXZhbBAfHTL
 QZCQDM/jHw9ub6X60WwZjNpB1O5xX7/MDJR/w3eiYjeuKd3leA44qjMlWkpZA8FHq81XGJArWfD
 90dZfA9cExYsL4uv42l0LHbce0GMYJr4zfl1V97hvfLcEonYysFqR6+AXHzoQf30qtlfwp0bQ+z
 ib/AILNwB348nN90aW6ncCc8OMy8608CyJGH7rHpHL3vE9ziKTXGLPchYyrPSDI5zFELzw2G4A0
 LOo28zj8dtHueZ616g+LtXIljxhCR0h/f692AAbHGepd4q8KDMymDkGizBeYVAVwjpK/KDftxB5
 fFOArOgIxQmWZooPUxp/AxuJ2Vw5BFShgS63zKw0hRKh+NwrJA0Vrv8If8LhpAZKD8aZ1IpyojY
 vgs4y8nY67JmI12P0fvPp9ERJkHjzzjkhjXgUvtiFa0X+GWZTUrNPjJ7UAVISiwcXF4WxMoFfOB
 berwd9gotI00f0M/7QA==
X-Proofpoint-GUID: edQIIEEYGG0lSQo0Q3kbLKCBMxeawP0p
X-Authority-Analysis: v=2.4 cv=RoFQvymK c=1 sm=1 tr=0 ts=6acf0293 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=1qPKxZ1lXodfsSuZhD4A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: k6d73xMwrmR2h8MeWaLV3IH7LnORcOFn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 phishscore=0 adultscore=0 bulkscore=0
 impostorscore=0 suspectscore=0 malwarescore=0 clxscore=1015
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610140016



On 10/14/26 9:26 AM, Srikar Dronamraju wrote:
> * Shrikanth Hegde <sshegde@linux.ibm.com> [2026-10-14 08:46:11]:
> 
>> On 10/14/26 2:14 AM, Tim Chen wrote:
>>> On Tue, 2026-10-13 at 15:28 +0530, Shrikanth Hegde wrote:
>>>>
>>>
>>> - SMT: patch 3 adds SD_SHARE_LLC only to MC/PKG, so for "smt" the
>>>     flags are as before. I think it is possible for P9 to have
>>>     shared_caches between two cores:
>>>
>>>     /*
>>>      * P9 has a slightly odd architecture where pairs of cores share an L2 cache.
>>>      * This topology makes it *much* cheaper to migrate tasks between adjacent cores
>>>      * since the migrated task remains cache hot. We want to take advantage of this
>>>      * at the scheduler level so an extra topology level is required.
>>>      */
>>>
>>>     the CACHE level also has SD_SHARE_LLC, and highest_flag_domain() picks it, so sd_llc spans
>>>     cpu_l2_cache_map. shared_caches is only set when that map is wider
>>>     than the core's threads, e.g. a P9 core pair sharing an L2:
>>>
>>>       CPU:               0 1 2 3 | 4 5 6 7
>>>       cpu_smt_mask():    core A  | core B
>>>       sd_llc (CACHE):    0-7
>>>
>>>     The ids follow cpu_smt_mask(), so 0-3 and 4-7 get different ids
>>>     while sd_llc and sd_llc_size cover all eight, and
>>>     cpus_share_cache(0, 4) is false, which is incorrect.
>>>
>>
>> Yes. I doubt anyone wants to try this experiment on Power9.
>> But yes, functionally updating the flags is needed.
>>
>> @srikar,
>> That is also the reason for having the disabled. By default on P9,
>> llc will be at CACHE domain. But, one may want to experiment with =smt
>> which i doubt anyone will ever do.
>>
> 
> I think P9 is a very valid point, but I don't think we should look at disable
> as an option just for this.
> 
> I would say, lets keep it simple now, just have an option rather a toggle to
> have LLC as MC/PKG for experimentation purpose. Switch the toggle and it
> does back to regular LLC mode. Also we don't know how the future Power
> Systems LLCs will look like. So keeping it a simple toggle, will reduce pain
> and increase our flexibility for the future.
> 
> Whether the toggle will switch to MC or PKG could be decided based on the
> experiment results.
> 

Ok. So kernel parameter "llc_override=mc/pkg" exclusively for ppc.

llc_override=mc means LLC is at MC.
llc_override=pkg means LLC is at PKG.
No kernel parameter means no change.

Hope that sounds good.

Also this new kernel parameter sounds a distant relative of split_llc.

