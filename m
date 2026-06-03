Return-Path: <linuxppc-dev+bounces-21942-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0CA6CD6E4A
	for <linuxppc-dev@archiver.kernel.org>; Wed,  3 Jun 2026 05:11:06 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gVbQ074v1z2ySS;
	Wed, 03 Jun 2026 15:11:04 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780463464;
	cv=none; b=IxpOS4AztbBayYbeOwHxbzpNylbI/Y/XtSgYoV/nDiM2LtARPo7qA/u/WCA41if3ufUS5grNaydfYTNgT28qCtcjRUjAiVdug/kFyfJAwoblmU6ICVHP4df118Ry3kfdkDPBnknjJt1G956a7zTw/RIQuS4uYtUU8Nd8ueUCGYOPF2t+HQam6/8wCHsIiaDGkUYVR+bj/FOsYe2b0LMlGYRqrhNAQZFaC+WgrnUYaUjs4xLdwQ4QPn4Jkjquebo+IqWruFlwGcdIhmpI8ViXa1BvE1u7pf1mnWcNFBHHYZ8rxsiQQTqeGDQuzshi/7NbIby6RFMBI3zEyYRQdo1LTg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780463464; c=relaxed/relaxed;
	bh=txJdzTVa3WrsmBfmyCZM1/ehE0f7ezCs5eXEJszECSY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PZaSlj1X63hBgCazNjJWFE3qz4xRlRVaXzM1uPviwduGv2q/PXappVNEan2bjpQSOQbawg240YrqkSga60WZVqDVYnMqIs6jEwyxop4Zl5UOapIw69qO+0xcfi1S7ayYzlEf68cUIzgMHJJAnIDJ+rFBbl5fL5prYqK0k9AlJsyAGBt8nRn9sY6vT7H3Emz6ngbXSokAPYITiuo95c+PWBevFrL/G5qvnNfLKp9MSfRVaebOYHVnsKx35dgniIQinerKaU7eb86JmHEnOZ0y43sIO2iv7PKc4WMn9JWkStrdWdENc4wy0zlDLACfIespXBeLQCMbCDH2QPOpQeJopA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=KXgsalW6; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=harshpb@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=KXgsalW6;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=harshpb@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gVbPz4C9yz2yQH
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 03 Jun 2026 15:11:02 +1000 (AEST)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 652H6F8E1080233;
	Wed, 3 Jun 2026 05:10:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=txJdzT
	Va3WrsmBfmyCZM1/ehE0f7ezCs5eXEJszECSY=; b=KXgsalW6Oic5SSkfRi7Gkw
	F+YL02Zdh3canOnebUU4IExU0g0FvzyvBQ+12jVQQbNG0x4X0eSnvzqq3VovV1cR
	BuXbYrq7GFgmC7myzRAopqokRIyptQK3+nZNAbUuUZiOHskdWf6hycnmIKS4qotb
	gnMwW+lsunpolPJvygSpHu0YchrzVjU3eidZ6NWseNFAGr5VvohwDX4uGDWLF+JO
	XaB+xM5W3OvRpuTJhZslVD+gAcU+9c+ReJfKZOtsGnt1vocNXh1BCyXxZ6l7ZGQY
	UqS0gHZ9souXV2a3ZaBfhlg0O97U005Fz8c4sE3kDpEgGd9SBzl9kx8k+tBTg3Qw
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4efqht8ps6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 03 Jun 2026 05:10:49 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6535976Z006775;
	Wed, 3 Jun 2026 05:10:49 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4egb7k6n0k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 03 Jun 2026 05:10:49 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6535Al8f21365304
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 3 Jun 2026 05:10:47 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C40CA5803F;
	Wed,  3 Jun 2026 05:10:47 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 043BD58056;
	Wed,  3 Jun 2026 05:10:42 +0000 (GMT)
Received: from [9.39.24.115] (unknown [9.39.24.115])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  3 Jun 2026 05:10:41 +0000 (GMT)
Message-ID: <56c84e26-69ed-433b-baaf-7b53acc60391@linux.ibm.com>
Date: Wed, 3 Jun 2026 10:40:39 +0530
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
Subject: Re: [PATCH v3 1/5] KVM: PPC: Book3S HV: Validate arch_compat against
 host compatibility mode
Content-Language: en-GB
To: Madhavan Srinivasan <maddy@linux.ibm.com>,
        Vaibhav Jain <vaibhav@linux.ibm.com>,
        Ritesh Harjani
 <ritesh.list@gmail.com>,
        Amit Machhiwal <amachhiw@linux.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org,
        Anushree Mathur <anushree.mathur@linux.ibm.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <skhan@linuxfoundation.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, lkp@intel.com
References: <20260522152744.55251-1-amachhiw@linux.ibm.com>
 <20260522152744.55251-2-amachhiw@linux.ibm.com>
 <pl2g6xbz.ritesh.list@gmail.com>
 <20260529141530.fc225a67-e9-amachhiw@linux.ibm.com>
 <cxyewhx8.ritesh.list@gmail.com> <87se74z4a6.fsf@vajain21.in.ibm.com>
 <72ef4cdb-8d9e-4319-9c94-b9a46a6f6194@linux.ibm.com>
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
In-Reply-To: <72ef4cdb-8d9e-4319-9c94-b9a46a6f6194@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: 7yQYkCC05MnmdFRCy-t2AeOhdZ4kCTJA
X-Authority-Analysis: v=2.4 cv=fv/sol4f c=1 sm=1 tr=0 ts=6a1fb75a cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=f7IdgyKtn90A:10
 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22
 a=pGLkceISAAAA:8 a=VnNF1IyMAAAA:8 a=3RF-NR_pMFLnH7bzSxUA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAzMDA0NiBTYWx0ZWRfX82nAmqYef0tv
 5uykKuLNcrKD9ygOY/mjusgC3rJo5IAI2JC0+hx9S1rhjOp9dGlfVgoJ97zO/lq6eMDx1f+RNOu
 H2HiCf9xS5QXpp6mFZdiosYTE0gsvbVt4dsTh2wVOxlcYJq+mlnCgVdT9BZi+PwfPQ6w5r1puvu
 1TnmA31VJMCC9YI2MSuUZa0oHhy9psDp7oLEyCpjXvvzypdQxmrtU3H1RMZ1cDl72o4hxogCxIQ
 CY/3x0qYc3Tv/A1UWF6PXdx1oBviaMf9EH3uqcq7g873+seDNxyr/BKLvu0u1JTBc+nNxK2n96k
 t3GXR96wFrgVDTiAigyY74oMdigOLlMSP58DvK08BM6z6shzzBoh5EjupD1gOJlrXcBGBTXthTj
 cNA6CdAbbjrXdf87zEi0hmtn8yptvpk6bmLDbV6t+TL3uNBgc1cmS0D4tFjakIk0IptrGT7vSTB
 /HOGu6wH5cF6CiBRSIA==
X-Proofpoint-ORIG-GUID: ISZfFh6dnZHLQDaPjT9vuZR-4lfUwLCm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-03_02,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 spamscore=0 phishscore=0 clxscore=1011
 impostorscore=0 suspectscore=0 bulkscore=0 lowpriorityscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606030046



On 03/06/26 10:03 am, Madhavan Srinivasan wrote:
> 
> On 6/3/26 9:03 AM, Vaibhav Jain wrote:
>> Hi Ritesh, thanks for looking into this patch. My responses to your
>> review comments inline below.
>>
>> Ritesh Harjani (IBM) <ritesh.list@gmail.com> writes:
>>
>>> Amit Machhiwal <amachhiw@linux.ibm.com> writes:
>>>
>>>> So, we would still want to prioritize the whole series
>>>> instead of just this one patch.
>>>>
>>> Patch-1 could go as a bug fix even in 7.1-rc6 (or maybe with 7.2
>>> bug fixes). - Maddy?
>>>
>>> So, you may want to add a fixes tag and maybe even cc stable if you are
>>> seeing this issue from older kernels maybe when nestedv2 got introduced?
>> This isnt a 'bug fix' per-se but rather strengthening of compat mode
>> checks so that any non compatible PVR being used by the VMM can be
>> caught early. The hypervisor anyway ultimately prevents non-compatible
>> PVRs from being used by the VMM. So there isnt a bug thats being fixed
>> in this patch.
>>
>> The rest of the patch series builds on top of this patch to advertise
>> the available compatible PVRs to the VMM so that it can further
>> preemptively prevent users from forcibly using a non-compatible PVR.
>>
>> Hence IMHO, this patch can be marked for stable tree and potential
>> candidate for 7.2 merge window. But dont see applicability of a 'fixes'
>> tag to this patch
> amit, can you just post this alone as a separate patch, so that we could
> pull it for 7.2 merge?
> 

FWIW, b4 am -P1 <mbox> should fetch this patch alone (and not the entire 
series), See b4 am --help for more options to select a subset of patches.

regards,
Harsh>
>>> However the new UAPI discussion might still require more discussion with
>>> the community and I don't think it is ready for 7.2 yet ;)
>> Somewhat agree with the above
>>
>>> -ritesh
>>>
> 


