Return-Path: <linuxppc-dev+bounces-21206-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE921CD4F5E
	for <linuxppc-dev@archiver.kernel.org>; Wed, 20 May 2026 06:30:58 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gL1rd3LcRz2xrC;
	Wed, 20 May 2026 16:30:57 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779258657;
	cv=none; b=OF+erDII7XAQUAof/XrsthGT71MP2vh8iP2x/omtugoHuKPO4SJ3r7OXcL7yjHq/3Fun2/2w525KD5NrwOCIBI4G/kg3uwyr39KLrAQp5rqqLibnr/y+LpOnYGyXmZWRxoFJX6+D6fiXsfGAzVLwITySJPfXcbo6HzGctj9ULhdMMWNHhDZR5EkCFoPqtpaAcI+n0NhCjvrMC2NP4Jb3q60iTXMjuGkOQJnuvlV49Ejrhb57LTcVaAv0UpHECr4GvxNVx3kilfUiP7orscvUbDmCcY1+Vb9upI6rI1RVmVGA2l0ta/360EE+zfRII+2vdWI5iumCufb/7aXtH1SGfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779258657; c=relaxed/relaxed;
	bh=J1wNi/OPNOG8LqsGjP23XYv/FtyLgW6nkJyEArHX9HA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=b9bJ1Kw0EBJBQnecwdWQGXh8ok7YiCL/9SlOEIMGTuNsnI4uyWfnEJnJEEzMkgUwf/7w2PdgLGRp1nUL9pLNH0f0P13GXyY3+90sPVtOweA2waIAnoPLKr2BWlv8lXMO0ojuYUTimXGqg5anBToGDOy6HP7YSVQlMaugO82js5V+ktvEro1wQ3hX0UH1OEQfLjRkrBKPhLGTUuxxxA2+D8WDk4A8xk1Xhd7Q3tTigvEGWWTKStNXZB/shn83XpjlGsimHIeVskBnpzTvYCrkHj6DjMtO1jNJZcYPn35MN6JPf0c25g6lKudHcVF9vMeUajTUtidbwLWKqNfUMucFHQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=grYkMKLJ; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=sayalip@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=grYkMKLJ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=sayalip@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gL1rc3rjXz2x9N
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 May 2026 16:30:56 +1000 (AEST)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64K1OW8H3727812;
	Wed, 20 May 2026 06:30:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=J1wNi/
	OPNOG8LqsGjP23XYv/FtyLgW6nkJyEArHX9HA=; b=grYkMKLJc3u2Jvfuxq8wND
	SMfU/PnxQo6FWQCC8RDCxwJ1LFTW73KCEUnBLZjxE1i3MEdDGZzmyLxz/RmA3epN
	HIAIM+RrhVOBs9CzhVXJUT5M2OrpztdKC3ScwRdOrAKL99P3dEjDiqEd/BhPhKZW
	KAoeXrvv1N6qjsh98WhRiZP/0i0Y3yGtho/BxR308ITwlpnihRByXcQhEYto5okg
	muIlpIrYjb9dmhX9MSkneIjC8cvJS1qJGj6DCCQS3md5ZOc/bFmwJ1tOiIIbCO+A
	NBXus+eiDlhtIUCwOqt4e7E/sPPq1kq8oQDFdWEyoOvqqSgIzMHPXygEbSmAt/3g
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e6h750p6y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 May 2026 06:30:52 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64K6O5OR024577;
	Wed, 20 May 2026 06:30:51 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4e75ky5tw2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 May 2026 06:30:51 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
	by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64K6UnZ429360880
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 20 May 2026 06:30:49 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F3C6A58066;
	Wed, 20 May 2026 06:30:48 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0860658056;
	Wed, 20 May 2026 06:30:43 +0000 (GMT)
Received: from [9.124.214.92] (unknown [9.124.214.92])
	by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 20 May 2026 06:30:41 +0000 (GMT)
Message-ID: <e683540e-3875-4b7f-ac25-c30ae3d2fc0e@linux.ibm.com>
Date: Wed, 20 May 2026 11:59:35 +0530
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
Subject: Re: [PATCH v2 0/2] LKDTM powerpc enhancements - Part2
To: kees@kernel.org, Michael Ellerman <mpe@kernel.org>
Cc: linux-kernel@vger.kernel.org, Ritesh Harjani <ritesh.list@gmail.com>,
        Mahesh Salgaonkar <mahesh@linux.ibm.com>, maddy@linux.ibm.com,
        linuxppc-dev@lists.ozlabs.org
References: <cover.1778975974.git.sayalip@linux.ibm.com>
 <fc776993-1ad7-49fd-834e-c1945da28ad9@kernel.org>
Content-Language: en-IN
From: Sayali Patil <sayalip@linux.ibm.com>
In-Reply-To: <fc776993-1ad7-49fd-834e-c1945da28ad9@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=ffCdDUQF c=1 sm=1 tr=0 ts=6a0d551c cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=2uRJyrLNzKtNGuPgDIwA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: nFhVK64gt4uEMd5KkY6fCfwGZOTUwkDw
X-Proofpoint-GUID: wiCdWB_54BHHpqjGeNL6vqXfHU-54c-4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIwMDA1NyBTYWx0ZWRfXzM4LBonaSmnO
 HlteZLDNr3bcJIEQ22hGU7gxJCmJSlOJr4IwSa3oXZkhc6KuQqjfUibpLs4U8G1fJStwcxBujcE
 d2cFxRKitLayTPWG3p3FZu3DMIWtcWNBm9hHK3pRvkoBzBP2iJsk+Sjw0thUPN7cuDYEAzx97Lh
 7VcNFjp7AU36jiYXUKO93yHWzniX/yDKpN0Nw5yUBnJ1DVmXuDoqoFM3aJrrUwYqgAkLoWZEHii
 216zE00/2R1KBzFYnp0qFPs3o3ojoywoyVgu6kVOaoNHIn9IZ6dyG1zGLDLdr/HhP5RDq/CyASN
 hXXSpt4d8KUYvZMxsgknSXFd7Ra/+RfWDvDDikJ3UHyfL7Ke8SKoQtOpdXYlWPeZM1d2kO4jokB
 z7E4Asfqf1Mu3N6FQCCZltfwpEdiNDv5GDM7KBWCUUUTKO+EG9Ow1W4Fy0eLG39sCCDh64K7BIE
 JR2w6i7YA2xRrU0VrGg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-20_01,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 phishscore=0 suspectscore=0 adultscore=0
 clxscore=1011 impostorscore=0 lowpriorityscore=0 bulkscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605200057



On 18/05/26 17:28, Michael Ellerman wrote:
> On 18/5/2026 16:56, Sayali Patil wrote:
>> Hi all,
>>
>> This series adds a new LKDTM trigger PPC_RADIX_TLBIEL, to validate
>> machine check handling on radix MMU systems and improves reliability of
>> the PPC_SLB_MULTIHIT test by adding isync instructions after slbmte
>> operations.
>>
>> Please review the patches and provide any feedback or suggestions
>> for improvement.
>>
>> Thanks,
>> Sayali
>>
>> ---
>>
>> v1->v2
>>   - Split the patch series into two parts.
>>   - Updated "lkdtm/powerpc: add PPC_RADIX_TLBIEL test for radix MCE
>>     validation" as per review comments:
>>     Wrapped Hash-MMU specific functions with #ifdef 
>> CONFIG_PPC_64S_HASH_MMU.
>>     Guarded powerpc_crashtypes registration with #ifdef 
>> CONFIG_PPC_BOOK3S_64
>>     Updated comment explaining the MCE trigger condition for radix MMU.
>>
>> v1: https://lore.kernel.org/all/ 
>> cover.1778057685.git.sayalip@linux.ibm.com/
>> ---
>>
>> Sayali Patil (2):
>>    lkdtm/powerpc: add isync after slbmte to enforce SLB update ordering
>>    lkdtm/powerpc: add PPC_RADIX_TLBIEL test for radix MCE validation
>>
>>   drivers/misc/lkdtm/Makefile             |  2 +-
>>   drivers/misc/lkdtm/core.c               |  2 +-
>>   drivers/misc/lkdtm/powerpc.c            | 49 +++++++++++++++++++++++++
>>   tools/testing/selftests/lkdtm/tests.txt |  1 +
>>   4 files changed, 52 insertions(+), 2 deletions(-)
> 
> Both changes look good to me.
> 
> You should send them to Kees, who maintains lkdtm. I've added him to Cc, 
> but that may not be sufficient to get his attention.
> 
> Reviewed-by: Michael Ellerman <mpe@kernel.org>
> 
> cheers
> 
Thanks for the review, Michael!

Hi Kees,

Could you please review these patches and let me know if you have any 
comments?

Thanks,
Sayali

