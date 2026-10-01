Return-Path: <linuxppc-dev+bounces-28623-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82E40CA5FC4
	for <linuxppc-dev@archiver.kernel.org>; Thu,  1 Oct 2026 03:31:22 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hwHWY020lz2y2Z;
	Thu, 01 Oct 2026 13:31:21 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790825480;
	cv=none; b=lzOCQdO0aD8LAWQI5kBl6vUYlfAWt+tTKciByDfTp69fIXju4l83RBflP8SWTc6jSSl/PF2Vdf9CSp5OC/9wHcJ5UmzIfv9EA841z4tzvmrOkI4UBeZVPvPPLWqDObnRQ1JXzqrkgwVCfyLeSKkMbmIMkRk2wo15ES9W5OQThgY9Ok6gYr9hHq2TKkSRIY+g3XjLnAf//G+1NFpeIWIjjQ06gsbzhihiRiai+ccF5ZB46gzld19xd70Km/Z4NUrajwXd/rSNFJ6FhruVCszm+Yf3J93TSzq9bpPjnPz/J3NowD6Sb8K8BYXInSp70LLfCzg1+hWUGgQPQMZaB2NF8w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790825480; c=relaxed/relaxed;
	bh=pjmlAdveYXAzNf8tFX47S408AIcY7O3Z0jzNl8ioBIU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=m7Z6tMpVRxWz3MKzo76vEWI+ArGTRdSDHpG/kgPuIf21QJY/fk5Ly91x49DAUtO3uqIMiVEnfdltkzz+BRY1nNPAH+bONfpsPyRNMN1vy1eIjzvic1NLg/mRh4xJ5d93nNto3LSY9VdAFh8DEu5S2gP4bxULDLzoxXftSDWvC/u0aY/t86+irvm0F7/+qrxIP3xXi25jLf4//jzMyPeVdl9EFe2r2ztgg7cJT6jgqOeF+4Rrut6mHbyghhvcvE/TPHoFApY30f0ZhwUCNBDovPe0nUZ4Nh1Z+tHsUjLJQICZcb/O2MiTjgjAg3yqHy0yPZp0/PNatJ6uPhJGFT2Rzw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=PLKtQ3wp; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=sourabhjain@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=PLKtQ3wp;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=sourabhjain@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hwHWW6dgpz2xsW
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 01 Oct 2026 13:31:19 +1000 (AEST)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69115jgv3277089;
	Thu, 1 Oct 2026 03:30:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=pjmlAd
	veYXAzNf8tFX47S408AIcY7O3Z0jzNl8ioBIU=; b=PLKtQ3wpHOrn2hzixnww/B
	kzqyz9rWrpbjrjTphvKO17xeSjC5c53OLaKbB07MD6e6XMiXqqI4k/cp/+TWDMLh
	qi2bIDCEGsSlJ8J2F6kzU3P7f7go7ROsMrGqR7gk42X1tUJumWmUMDJR1sqeBvx0
	UsPo5C4+6701TYgKeMUjHvvCDohzCBBmePBWgH2ouRFjwaK4ZtN6Ij3M+8to6g28
	ZuYXg7X0kn8iEZj/G/0PJmDQGg4fG8CMiUFo5K0Ger093Z+4paIPbo1+fqCtijCp
	V7sYZj66amPbVEkqBvWQ1xKGdS1/+HCp8a2k9VC+IYkhRxvYYtE9B6i+g+w4+KAg
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gx4fefu57-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 01 Oct 2026 03:30:51 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6910ltsm180421;
	Thu, 1 Oct 2026 03:30:51 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4h1aa7s2ud-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 01 Oct 2026 03:30:51 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6913UlTr48890122
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 1 Oct 2026 03:30:47 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6226D20040;
	Thu,  1 Oct 2026 03:30:47 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9525C20043;
	Thu,  1 Oct 2026 03:30:43 +0000 (GMT)
Received: from [9.123.14.142] (unknown [9.123.14.142])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  1 Oct 2026 03:30:43 +0000 (GMT)
Message-ID: <0b918888-502d-4388-ab54-2c7ae9f4ccbb@linux.ibm.com>
Date: Thu, 1 Oct 2026 09:00:42 +0530
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
Subject: Re: [PATCH v1 1/2] kho: check scratch vs CMA alignment at runtime
To: sashiko-reviews@lists.linux.dev
Cc: Aditya Gupta <adityag@linux.ibm.com>, Baoquan He <baoquan.he@linux.dev>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Pratyush Yadav <pratyush@kernel.org>, kexec@lists.infradead.org,
        "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
        Mahesh Salgaonkar <mahesh@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Hari Bathini
 <hbathini@linux.ibm.com>,
        Mike Rapoport <rppt@kernel.org>, linux-kernel@vger.kernel.org,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        linuxppc-dev@lists.ozlabs.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Graf <graf@amazon.com>,
        Shrikanth Hegde <sshegde@linux.ibm.com>,
        Shivang Upadhyay <shivangu@linux.ibm.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
References: <20260928083226.107807-1-sourabhjain@linux.ibm.com>
 <20260928083226.107807-2-sourabhjain@linux.ibm.com>
 <20260928084152.B52D21F000FF@smtp.kernel.org>
Content-Language: en-US
From: Sourabh Jain <sourabhjain@linux.ibm.com>
In-Reply-To: <20260928084152.B52D21F000FF@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=FYWiV5+6 c=1 sm=1 tr=0 ts=6abdd3ec cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=toarFsSee3Oy4yUGmnsA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAxMDAxMiBTYWx0ZWRfX/Jh3EjbZ8wxv
 Sv7TFll1B2s6sVRIU9krAsz97CCAiwokjotgx4PwyarIPLEmt8ZFcHRYIuZmQ9+m26hB67NrUNQ
 7vaogvq1+XSmOTYzSsxDKdzBKEfstFk=
X-Proofpoint-ORIG-GUID: pcyTEcOYXhbYSqPpZGgCGCNE4alEzn6r
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAxMDAxMiBTYWx0ZWRfX/Ofk6lSTNnIH
 y6OZe+dVah2hVq0Hfo6fyH6wj4VuEsH/KvSiMeNKEYnmywh0eAQrxO9R02Qvsc5XjrD+YHTM3YU
 4NEQjHJ3bPdOrKZdvTuImKkzmaj8ETS2dHIB9qQ6cdBB8DOtjt4sGXhsy1g5szXvvKI1jlsmPWo
 lcmmGACLia15sQCYqF0VEeGlVlGoko32JWy7Co5KWBSmCjpFm92D7krmrMN63lfB174gJcaMC6J
 sG9XqmQfjWeHraEnQPigFz3SezG0RHt12p+pmzRXSlljgvtZ/TwjAxTRQKb7/XE9K6nTQmya/lV
 1LIKbyXtGJhnYNc6kBE6vu/l+hWi8uzlbje4YBBEEL39zK1tIwKAh6ZvlApmtbVJ8YP1lTIQILE
 fIYFuaZcr9gkAK2+bQWxGkEVSkZvHL70Z0/DigSw7PErZaccrrdXEm/hXMMzdggtl1fBHfVw5Jh
 H2rFzmV6LyLy882N1ug==
X-Proofpoint-GUID: _7CZYJNCwE8Er-J640OwR5Oqwxj4uV0H
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-01_01,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 impostorscore=0 spamscore=0 phishscore=0
 priorityscore=1501 malwarescore=0 bulkscore=0 lowpriorityscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2610010012



On 28/09/26 14:11, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [High] kho: bypassed scratch alignment check during resume causes memory corruption
> --
>
> commit cbd7cb7f008e704b389d8dfe3306e1e83e49e8a8
> Author: Sourabh Jain <sourabhjain@linux.ibm.com>
>
> kho: check scratch vs CMA alignment at runtime
>
> KHO requires the scratch alignment to be at least CMA_MIN_ALIGNMENT_BYTES,
> which was previously enforced with a static_assert(). This commit replaces
> the static_assert() with a runtime check in kho_reserve_scratch() to allow
> KHO on configurations where the minimum alignment is not a constant.
>
>> diff --git a/kernel/liveupdate/kexec_handover.c b/kernel/liveupdate/kexec_handover.c
>> index 7c4d86daf86d5..dc76dd6b74da7 100644
>> --- a/kernel/liveupdate/kexec_handover.c
>> +++ b/kernel/liveupdate/kexec_handover.c
> [ ... ]
>
>> @@ -836,6 +828,21 @@ static void __init kho_reserve_scratch(void)
>>   	if (!kho_enable)
>>   		return;
>>   
>> +	/*
>> +	 * This is the minimal alignment required by deferred struct page init.
>> +	 * deferred_init_memmap_chunk frees memory to the buddy allocator, which looks
>> +	 * at the neighboring pages (up to MAX_PAGE_ORDER) to merge them.
>> +	 * If KHO scratch is not aligned to that value, buddy can access uninitialized
>> +	 * struct pages, which can cause a crash.
>> +	 */
>> +	if (WARN_ON_ONCE(SCRATCH_ALIGNMENT_BYTES < CMA_MIN_ALIGNMENT_BYTES)) {
>> +		pr_err("scratch alignment %lu < CMA minimum %lu, disabling\n",
>> +		       (unsigned long)SCRATCH_ALIGNMENT_BYTES,
>> +		       (unsigned long)CMA_MIN_ALIGNMENT_BYTES);
>> +		kho_enable = false;
>> +		return;
>> +	}
>> +
> [Severity: High]
> Does this new runtime check get bypassed during a KHO resume?
>
> During a KHO resume, kho_memory_init() skips kho_reserve_scratch():
>
> kernel/liveupdate/kexec_handover.c:kho_memory_init() {
> 	if (kho_in.scratch_phys)
> 		kho_mem_retrieve();
> 	else
> 		kho_reserve_scratch();
> }
>
> If a predecessor kernel passes a scratch region with a smaller alignment,
> and the successor kernel has a larger pageblock_order, bypassing this check
> means kho_init() will iterate over the provided scratch memory using the
> successor kernel's larger pageblock_nr_pages:
>
> kernel/liveupdate/kexec_handover.c:kho_init() {
> 		for (pfn = base_pfn; pfn < base_pfn + count;
> 		     pfn += pageblock_nr_pages)
> 			init_cma_reserved_pageblock(pfn_to_page(pfn));
> }
> Can this lead to init_cma_reserved_pageblock() overwriting state for pages
> outside the actual scratch region bounds, or cause a crash in the buddy
> allocator if __free_pages() is called on an unaligned PFN?

Yes, if the kexeced kernel has a higher pageblock_order than the
kernel that initiated the kexec with KHO, this can cause problems when
the code above hands scratch-memory pages back to the buddy allocator
in the kexeced kernel.

Would it make sense to handle this by keeping only the unaligned pages
reserved and handing the remaining pages back to the buddy?

Something like this:

diff --git a/kernel/liveupdate/kexec_handover.c 
b/kernel/liveupdate/kexec_handover.c
index 2e3a36054851..dea6e7790972 100644
--- a/kernel/liveupdate/kexec_handover.c
+++ b/kernel/liveupdate/kexec_handover.c
@@ -1928,7 +1928,8 @@ static __init int kho_init(void)

         for (int i = 0; i < kho_scratch_cnt; i++) {
                 unsigned long base_pfn = PHYS_PFN(kho_scratch[i].addr);
-               unsigned long count = kho_scratch[i].size >> PAGE_SHIFT;
+              unsigned long count = ALIGN_DOWN(kho_scratch[i].size >> 
PAGE_SHIFT,
+ pageblock_nr_pages);
                 unsigned long pfn;


Thanks,
Sourabh Jain



