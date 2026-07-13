Return-Path: <linuxppc-dev+bounces-24114-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D2BBC43458
	for <linuxppc-dev@archiver.kernel.org>; Mon, 13 Jul 2026 13:13:12 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gzNCp5htlz2xqJ;
	Mon, 13 Jul 2026 23:13:10 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783948390;
	cv=none; b=D7qo7CDZw2puFytpiP3ecdvnYMlh9sQqB0xQVpOGbpiAwLcymp9P6AYsw0faMtAkGx5ulr16Vz6kTBmZweU/V85AwDqNeoagwzk+arh00Sqfo7GWCHar0OAtbIei/D8frqk5/CZlcH9I0n9eUp/iGI4BBqCJxXu6KbhryAjpIH1/3YmlIAZPMHfGIOSiNajPDYep1SdKH+zRiYvKeBqgR4ofETDpYdBEwD9GlHqaub4C09ctUJveXprw2wfdEg+Kb40Si3go7C24KNmSi7KWDOl8RWSvPU3l4BwrwZhhcFEi92vFNpgnk1MHSRyZNwgTdbNmybSXh2L7CcjQIOjrYA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783948390; c=relaxed/relaxed;
	bh=gC7mVKKzf/jLdX89sE75QXlLkbKsrtw6/LIe267vOac=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ayOlvca+u7vIbApw2Iw6nrrdUuIQqQsVOsTRF9/tp94uIYNmj0rlzKqx/+Nto3D4PCht8k7Ze6OQZUIkE+JQsVNCD53FTI96WKkyieMnV36CSUqkTlQvwLBuWp1FcmqS6CBkhv5642n1YsPWJB1miz+qJjVcG+rjQOoPsBe41IDNsRp/bVPp6noC518hl9e6l+NqQRMDV1RSV2VtdfbN04aLyXW1HsGFzkCOSJ2cZIoORirWOxbfKGjqtXS9jreTUG++43eXnByFrS8ILTg3vHykyZsBL/Wy0uHjbWhkG9EWyah+KDzkkwneIcxRxrs+KUODKM8gHtcsbHmkHJVLHw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=WtNfkdYi; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=sourabhjain@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=WtNfkdYi;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=sourabhjain@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gzNCn207mz2xRw
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Jul 2026 23:13:08 +1000 (AEST)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66DCD1XP2437292;
	Mon, 13 Jul 2026 13:12:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=gC7mVK
	Kzf/jLdX89sE75QXlLkbKsrtw6/LIe267vOac=; b=WtNfkdYi0RQqOEmwiYwafW
	dKTh0XVZE+M1y79DnVzPFCvN4H/OHGyjrYLk9jFvWl/JULQ1GdcTE0YrG7wmCIwq
	OdsTZZ4wDRbkkpR1dDOjsXU3mpy9pMebqgsjTCFSNLvRU87Y1ti75GWcfmiQRORr
	U9D12FnO6TMrwdHfrHhf1UtfaLM+wUKuHqQU+9Nsb7fw1I5rWphBtq8VwcfTMQJr
	s5XMoWhO/ZZ0A0ISUBzYeEuXT+2IjyuoPSHW4PXAlv0zrg+MMcg7qNdcUilfpQK8
	JvbJHT8yu4xAE7PYkjr65okSQ2r0WL2yHEhPjf3ChckIdpBFFXYh1L35luYx0RoA
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fbepx8rgw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 Jul 2026 13:12:58 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66DD4fPJ027507;
	Mon, 13 Jul 2026 13:12:57 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fc0hvwvdt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 Jul 2026 13:12:56 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66DDCqBK42008912
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 13 Jul 2026 13:12:52 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7AE922004B;
	Mon, 13 Jul 2026 13:12:52 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4974C20040;
	Mon, 13 Jul 2026 13:12:50 +0000 (GMT)
Received: from [9.123.14.142] (unknown [9.123.14.142])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 13 Jul 2026 13:12:50 +0000 (GMT)
Message-ID: <34522476-3b48-4af9-b09d-11eed8b22597@linux.ibm.com>
Date: Mon, 13 Jul 2026 18:42:07 +0530
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
Subject: Re: [PATCH v2 1/4] powerpc/mmu: do MMU type discovery before
 crashkernel reservation
To: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
        linuxppc-dev@lists.ozlabs.org, maddy@linux.ibm.com, mpe@ellerman.id.au
Cc: npiggin@gmail.com, chleroy@kernel.org, shivangu@linux.ibm.com,
        hbathini@linux.ibm.com, mahesh@linux.ibm.com, adityag@linux.ibm.com,
        venkat88@linux.ibm.com
References: <20260708143357.673251-1-sourabhjain@linux.ibm.com>
 <20260708143357.673251-2-sourabhjain@linux.ibm.com>
 <1pdbwokc.ritesh.list@gmail.com>
Content-Language: en-US
From: Sourabh Jain <sourabhjain@linux.ibm.com>
In-Reply-To: <1pdbwokc.ritesh.list@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: H-BVYv1IcwggKNisDUP4Rkz7jRACjSGY
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEzMDEzOCBTYWx0ZWRfXzF7n4mYsgL4O
 rUGU6MpFVcHrUUpsMPMcgnEFAwbW+dGl87P3QTPkUIBVKXuIaQ/71bAXAeFZbp5iTXQmJ3bC9zh
 4NeYQTgeg2cPIRsd0XFhadS6ELX5n6A=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEzMDEzOCBTYWx0ZWRfXw89nWri2SLl2
 Dub0DmaJ9TvuCisTl/xrd9wvtFfTtHsVcWF22Q0ARTuXoMx2onLwf92VfjyWfB2k4MDgXIoWW8M
 NGAs4FXacxXL8YyeJz7mGJPqP9lsYUn4MCWEyD3gHq1MXO4jvAkrHZz/zk21jurfj1iEGSB76tk
 cFfku4mUINVaqBWxg5jQaqBRJEp6MHV/zyEFyiJ/Hf1Iv82fl2i+VJsoo8Qdw8rGBG/HBaTw7b+
 w6tqQULvx2AsrbzXdCMBaLFzl7jrXTzgZIr66fMtzT3rrgTBcO4VKVFAKXlbDwKkOKmcarfmFXe
 /TEsSVI8dAeIh3bK+2BiCcHtRQF1t7vkc9MMD6hTIjmio46MoCjI2NPg+eax6LzlFXvDUCA3c90
 b/EeCDvllElpn2gQWrjXlEpz0tHEL6wMpW91b9wxpOUilqmla8654z1gCOykVFMdhl2tLGbhgW5
 RMLHjU55CoD50S1iv8g==
X-Authority-Analysis: v=2.4 cv=XbS5Co55 c=1 sm=1 tr=0 ts=6a54e45a cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8
 a=pGLkceISAAAA:8 a=Yc4ceVhvGxwi43HeICAA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: dKZMARIlUMwGxlEkSRwqU4lblRibgqYD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-13_03,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 spamscore=0 phishscore=0 lowpriorityscore=0
 priorityscore=1501 adultscore=0 malwarescore=0 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607130138



On 10/07/26 08:14, Ritesh Harjani (IBM) wrote:
> Minor nits
>
> Sourabh Jain <sourabhjain@linux.ibm.com> writes:
>
>> Crashkernel reservation on high memory depends on the MMU type, so
>> finalize the MMU type before calling arch_reserve_crashkernel().
>>
>> With the changes introduced here, early_radix_enabled() becomes usable
>> and will be used in arch_reserve_crashkernel() in the upcoming patch.
>>
>> early_radix_enabled() depends on cur_cpu_spec->mmu_features to find
>> out if the radix MMU is enabled. The radix MMU bit in mmu_features is
>> discovered from the FDT and kernel configs. To make sure the MMU type is
>> finalized before arch_reserve_crashkernel() is called, the function that
>> scans the FDT and sets mmu_features, along with some bits from
>> mmu_early_type_finalize(), has been moved above
>> arch_reserve_crashkernel().
>>
> Can you also add a short description of why can't we move
> arch_reserve_crashkernel() to a later point instead of breaking
> mmu_early_init_devtree() and moving the xx_type_finalize() part above?

The main reason is that the crashkernel requires one large contiguous memory
block to be reserved at a specific memory offset. To ensure this 
allocation succeeds,
the crashkernel memory is reserved before any other components reserve 
memory.

> If I am not wrong, it is since move_device_tree() checks whether the FDT
> overlaps the crash kernel reservation. So arch_reserve_crashkernel()
> must be called before move_device_tree().

I think the bootloader loads the device tree and may chose a location 
that may falls
within the crashkernel region. The purpose of move_device_tree() is to 
relocate
the device tree so that it no longer occupies the crashkernel memory. 
Otherwise,
that memory region would also need to be excluded from the crashkernel
reserved area (and also need special APIs to access device tree present in
reserved memory regions), similar to the RTAS region.

- Sourabh Jain

>
>
>> Signed-off-by: Sourabh Jain <sourabhjain@linux.ibm.com>
>> ---
>>   arch/powerpc/include/asm/book3s/64/mmu.h |  1 +
>>   arch/powerpc/include/asm/mmu.h           |  1 +
>>   arch/powerpc/kernel/prom.c               | 28 +++++++++++++-----------
>>   arch/powerpc/mm/init_64.c                | 27 ++++++++++++++---------
>>   4 files changed, 34 insertions(+), 23 deletions(-)
>>
>> diff --git a/arch/powerpc/include/asm/book3s/64/mmu.h b/arch/powerpc/include/asm/book3s/64/mmu.h
>> index 48631365b48c..7a3b2ff02041 100644
>> --- a/arch/powerpc/include/asm/book3s/64/mmu.h
>> +++ b/arch/powerpc/include/asm/book3s/64/mmu.h
>> @@ -208,6 +208,7 @@ extern int mmu_vmemmap_psize;
>>   
>>   /* MMU initialization */
>>   void mmu_early_init_devtree(void);
>> +void mmu_early_type_finalize(void);
> can you rename this as mmu_early_init_type().
>
> Otherwise the change looks good to me. With the above 2 addressed, feel
> free to add:
>
> Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
>
>


