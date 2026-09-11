Return-Path: <linuxppc-dev+bounces-27121-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 050F3C88E4C
	for <linuxppc-dev@archiver.kernel.org>; Fri, 11 Sep 2026 11:25:20 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hhBzf4y72z2yFj;
	Fri, 11 Sep 2026 21:25:18 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789125918;
	cv=none; b=agSFVmpt0Vmg93iJoafwKdvHyANTWq+okCIuydO1lehn4sPJF2tQ6rodtTQ7GK31LRMc+LNpWJnlJZCbhHmxMqYVoZuriCOJz5VxS1rgq6f/r8LHHYFKCymqqk5rQE193RYOjN+TGqlM5tlktAAgDZ0GzvfRmXWWr+b19OWLjOCUPJn36HusW+/rikFZ7zgoG0i5/AZbVTur/0IndsixXCI2n71u9QYL96B7lI/Ya24SDyMxJg26rrh31tKlGyE9yp8KgYBF7wAFDj011pQB9AXnxgAYNxqjmxxoHkuK/hA7XydHcsbUJ1fVDW3z5imCZvP4Ix9JDpaFt3PfzfiHOA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789125918; c=relaxed/relaxed;
	bh=8MEA0ImrHfJyzFxVjlcZl2076irTIK5Yuh8p0/MpTlI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Cr76sZva9CSeeRu8bM1ldsU86RvFszedTHFLNEHvOVW07YVxEvECm/rJRN+5mCt1JSSj8a2+NgMDrV9vt9ANErTN+yoG2UxHdH/s1/8CtEw1D3F0JO5YaAyXf3He5UphW96P6G8/f6t6RWIp/zSS2D4EwbQXTYAX/iBzS6/hZYfup2DItoe+fHuI+kMNE4yav/UgZ3ti4qNKiNML+81yInUXPB7lEdRuFAsWHcw2vNrUayQuyNbmDYItMhd+umel4XWi2hP7UKs23piuWj9BfBIgzV8ENC3fn2dKyHQhpmS02lcen6RLgCfz3mtJ6xj9eZ/YZtYsarmU5HzmfTR6HA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=jswDA/9p; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=sourabhjain@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=jswDA/9p;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=sourabhjain@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hhBzd04p9z2y32
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 Sep 2026 21:25:15 +1000 (AEST)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68BB1akD456837;
	Fri, 11 Sep 2026 11:25:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=8MEA0I
	mrHfJyzFxVjlcZl2076irTIK5Yuh8p0/MpTlI=; b=jswDA/9p1eHoCmOqxcZb/P
	q63CyADYl8uFvM4774oU4XvZO1hRiTT+oWxMZ+ezA3yM4zW1A51WODOXo4wN9VUK
	zUWKg9hNQN7PY0hEJA2NzVirsRinIo5ivdywEA2sCUyxAKXObz59uwq87ILpo9V4
	pwXiEarN43vRtWXcHIPFQbCICqWMXoUcamCjBAKCzJa36wjkXlp7k0pvfoeVhW7J
	CYQY1rKc/FBE/xvmfOCITVkpepiP3TQiT8GYkhKmgDXMYye3sM2VCdvjkI3GRGEK
	BO7m/hB4GzVTXXQ1EfhSU1seMAzn5PT/TOYRD7KNXb9RAVmEeVF890B/tzCWaoKA
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gkd8qb1jd-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 11 Sep 2026 11:25:09 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68BAo4NU1478005;
	Fri, 11 Sep 2026 11:25:09 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gkvvrdxy7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 11 Sep 2026 11:25:08 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68BBP4Uw52363610
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 11 Sep 2026 11:25:04 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B21DB2004B;
	Fri, 11 Sep 2026 11:25:04 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BF46320040;
	Fri, 11 Sep 2026 11:25:02 +0000 (GMT)
Received: from [9.43.53.28] (unknown [9.43.53.28])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 11 Sep 2026 11:25:02 +0000 (GMT)
Message-ID: <e4f2768a-ff45-4654-9557-a5284c788418@linux.ibm.com>
Date: Fri, 11 Sep 2026 16:55:01 +0530
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
Subject: Re: [mainline]kdump fails to save vmcore when crash is manually
 triggered
To: Venkat Rao Bagalkote <venkat88@linux.ibm.com>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Ritesh Harjani <riteshh@linux.ibm.com>,
        Hari Bathini <hbathini@linux.ibm.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>
References: <c6b26023-c629-4f09-a449-dffeaba06082@linux.ibm.com>
Content-Language: en-US
From: Sourabh Jain <sourabhjain@linux.ibm.com>
In-Reply-To: <c6b26023-c629-4f09-a449-dffeaba06082@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: RLqjSO-hph7nLnzv45xJkiTbXhmrQ2vT
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTExMDE1NSBTYWx0ZWRfX4RfSrtvIZye8
 x7Yquo5CxrQphHJwwZiHpCL1mC/aIsDqd8xCW7/vPx7m3Yyj6CV0nVN5HeaoMvKLb4INJ//yYnh
 L1N7UE/MRAWVA8zf3OMxoxt2fRbfYpk=
X-Authority-Analysis: v=2.4 cv=E/dYNqdl c=1 sm=1 tr=0 ts=6aa3e515 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=Zwj9PYTxAAAA:20
 a=VnNF1IyMAAAA:8 a=X8FTyEh_R9LiEri5cKoA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=bA3UWDv6hWIuX7UZL3qL:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTExMDE1NSBTYWx0ZWRfX/i7x0NjJAaCB
 Y6slHIx1Ug4RVqHNgjwN0nqJN0kdSy2Ej2zfeDwBRFNgtOVAMnRNzrs4l8uQ0UPmzcWgGyaAQVw
 2edIdmBjNBeGx5w/7fEwSyzjAdQk7YoodNnsStWP/fcPoqmh3yhnB4jWtTr8kftX5j93iI648I7
 fSDEsLZiTKswxFH5pNu0VFbrOyFyjyfOGSYlHcVkd0/aLcpNiaL4RbiTaKmNypIDZ+bTLgnlfy8
 26CVXKxKjedj9xrAfUZyvpm9HZQtgUbIyDF1kf0zmfuMnF+CfSJkoWssnoxvkh1Oi+u3sBGdR9w
 M5gDt0J35HlUB/bDe0BJQI6Z4q4XyUKTAVJ0+qWcgvGFlpGONxKHuodtavooMSGXWNn1jNuFjBq
 FQX8Y7EysWIuR5uQnj2Gev96pFLxm8tgXqR6LcH64X+Cn0rgmOlwsB8Lv5KiN29KfXnwTMSRfAp
 /yu7Z+1wVgOGeewwu7Q==
X-Proofpoint-GUID: RLqjSO-hph7nLnzv45xJkiTbXhmrQ2vT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-11_04,2026-09-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 spamscore=0 bulkscore=0 clxscore=1015
 impostorscore=0 phishscore=0 adultscore=0 lowpriorityscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609110155

Hello,

I root-caused the issue. The issue is with the makedumpfile virtual-to-
physical address translation function when using a 4K page size.

While performing the virtual-to-physical address translation for
0xc00c000018000000, makedumpfile reads only one page (4K) at the PGD level:

code snippet of ppc64_vtop_level4()/makedumpfile.c
https://github.com/makedumpfile/makedumpfile/blob/505d15bcc65462c49572f077a75998c6ee8ff7dc/arch/ppc64.c#L400
```
         [...]
     level4 = (ulong *)inf    level4 = (ulong *)info->kernel_pgd;
     pgdir = (ulong *)((ulong *)level4 + PGD_OFFSET_L4(vaddr));
     if (!readmem(VADDR, PAGEBASE(level4), info->page_buf, PAGESIZE())) {
         ERRMSG("Can't read PGD page: 0x%llx\n", PAGEBASE(level4));
         return NOT_PADDR;
     }
     pgd_pte = swap64(ULONG((info->page_buf + PAGEOFFSET(pgdir))), swap);
         [...]
```

Whereas the PGD table for the current kernel can be up to 64K in size:

64K = 8192 entries × 8 bytes

Since makedumpfile reads only 4KB (PAGESIZE) from the PGD base address, it
only gets 512 PGD entries.

The correct entry for the vmemmap address `0xc00c000018000000` is 6144.

The above logic is also true for the memory map address read fail 
reported in the
original report, which is `c00c000020000000`.

Note: This failure is observed only with a 4K page size because, with a
64K page size, `makedumpfile` reads all 8192 entries since the page is
aligned with the table size. 64K = 8192 entries × 8 bytes.

I will fix this issue in makedumpfile tool. Thanks for the report.

- Sourabh Jain

On 23/04/26 17:29, Venkat Rao Bagalkote wrote:
> Hello!!
>
> IBM CI has reported vmcore save failures when kdump is tested by 
> triggering a kernel crash via sysrq.
>
>
> Below are the kernel and tool details:
>
> Upstream kernel version: 7.0.0+
> Upstream kernel commit-id: 2e68039281932e6dc37718a1ea7cbb8e2cda42e6
>
> kexec-tools 2.0.32.git
> makedumpfile: version 1.7.9 (released on 20 Apr 2026)
>
>
> Error:
>
> While booting to crash kernel, I see below continous prints in console 
> logs:
>
>
> [    0.037177] vmcore: Warning: Zero PT_NOTE entries found
> [    0.037181] vmcore: Warning: Zero PT_NOTE entries found
> [    0.037184] vmcore: Warning: Zero PT_NOTE entries found
> [    0.037186] vmcore: Warning: Zero PT_NOTE entries found
>
>
> And During vmcore collection, I see below error.
>
>
> [    9.948432] systemd[1]: Starting kdump-capture.service - Kdump 
> Vmcore Save Service...
>          Starting [0;1;39mkdump-capture.service[0m - Kdump Vmcore 
> Save Service...
>
> [    9.992306] kdump[408]: [0;1;38:5:185mKdump is using the default 
> log level(3).[0m
> [   10.158555] kdump[526]: saving to 
> /sysroot/var/crash/127.0.0.1-2026-04-23-06:06:27/
> [   10.164060] kdump[531]: saving vmcore-dmesg.txt to 
> /sysroot/var/crash/127.0.0.1-2026-04-23-06:06:27/
> [   10.198598] kdump[537]: saving vmcore-dmesg.txt complete
> [   10.200376] kdump[539]: saving vmcore
>
> Checking for memory holes                         : [  0.0 %] /
> Checking for memory holes                         : [100.0 %] |
> Excluding unnecessary pages                       : [  6.3 %] \       
>       WARNING: Invalid free page order: pfn=5a45fc, order=64424509439, 
> max order=12
> WARNING: Invalid free page order: pfn=621a02, 
> order=2166518513861132288, max order=12
> WARNING: Invalid free page order: pfn=6697b3, 
> order=6706141453275365419, max order=12
> WARNING: Invalid free page order: pfn=669b5d, order=69335804542976, 
> max order=12
> WARNING: Invalid free page order: pfn=66c5a8, 
> order=14125543804861677568, max order=12
> WARNING: Invalid free page order: pfn=66c661, order=845524441759747, 
> max order=12
> WARNING: Invalid free page order: pfn=67dadc, 
> order=17224182427472101376, max order=12
> WARNING: Invalid free page order: pfn=682b38, 
> order=3103260797896228864, max order=12
> WARNING: Invalid free page order: pfn=682efa, 
> order=14269216714183933953, max order=12
> WARNING: Invalid free page order: pfn=682efe, order=134217728, max 
> order=12
> WARNING: Invalid free page order: pfn=68c0a0, 
> order=3031209642551148544, max order=12
> WARNING: Invalid free page order: pfn=69709d, 
> order=17296239995740225536, max order=12
> WARNING: Invalid free page order: pfn=6aa909, 
> order=2166511968028983296, max order=12
> WARNING: Invalid free page order: pfn=6ae921, 
> order=6273236509957029888, max order=12
> WARNING: Invalid free page order: pfn=6c1456, 
> order=17296239987150290944, max order=12
> WARNING: Invalid free page order: pfn=6c35a4, 
> order=14197601399000268800, max order=12
> WARNING: Invalid free page order: pfn=6c5de2, 
> order=2166511933669244928, max order=12
> WARNING: Invalid free page order: pfn=6d58da, 
> order=17296239987150290944, max order=12
> WARNING: Invalid free page order: pfn=6d7987, 
> order=14557325072076374016, max order=12
> WARNING: Invalid free page order: pfn=6dbb95, 
> order=17944838645085110272, max order=12
> WARNING: Invalid free page order: pfn=709d7d, 
> order=6273234623090655232, max order=12
> WARNING: Invalid free page order: pfn=709e11, 
> order=3031203148023726080, max order=12
> WARNING: Invalid free page order: pfn=70c02f, 
> order=6705580187335000064, max order=12
> WARNING: Invalid free page order: pfn=715384, 
> order=14990794317172375552, max order=12
> WARNING: Invalid free page order: pfn=715aef, 
> order=5048255524311662592, max order=12
> WARNING: Invalid free page order: pfn=71a51e, 
> order=6199767839173706752, max order=12
> WARNING: Invalid free page order: pfn=71aab5, 
> order=5048255524311662592, max order=12
> WARNING: Invalid free page order: pfn=732e19, order=28147502510048512, 
> max order=12
> WARNING: Invalid free page order: pfn=739896, 
> order=17296239987150290944, max order=12
> WARNING: Invalid free page order: pfn=73b956, 
> order=17296239991445258240, max order=12
> WARNING: Invalid free page order: pfn=73e043, 
> order=2166511933669244928, max order=12
> WARNING: Invalid free page order: pfn=740049, 
> order=6705582074453032960, max order=12
> WARNING: Invalid free page order: pfn=760109, 
> order=6345294104196284416, max order=12
> WARNING: Invalid free page order: pfn=760260, 
> order=2166511968028983296, max order=12
> WARNING: Invalid free page order: pfn=774eb8, 
> order=3103267236521967616, max order=12
> WARNING: Invalid free page order: pfn=77949f, 
> order=3103260802191196160, max order=12
> WARNING: Invalid free page order: pfn=784ac6, order=1971974104455872, 
> max order=12
> WARNING: Invalid free page order: pfn=785196, 
> order=2166518513861132288, max order=12
> WARNING: Invalid free page order: pfn=790654, 
> order=14557325072177037312, max order=12
> WARNING: Invalid free page order: pfn=792cbe, 
> order=13837309858646983424, max order=12
> WARNING: Invalid free page order: pfn=792dbe, 
> order=13837309859722035968, max order=12
> WARNING: Invalid free page order: pfn=793779, 
> order=15351363758810792960, max order=12
> WARNING: Invalid free page order: pfn=7963af, 
> order=2166511933669244928, max order=12
> WARNING: Invalid free page order: pfn=7bda8a, 
> order=13837313428760297472, max order=12
> WARNING: Invalid free page order: pfn=7bfbfa, 
> order=14269094696377647104, max order=12
> WARNING: Invalid free page order: pfn=7c8498, 
> order=18088873534452400128, max order=12
> WARNING: Invalid free page order: pfn=7d4bf7, order=1441792, max order=12
> WARNING: Invalid free page order: pfn=7db498, 
> order=18088873534452400128, max order=12
> WARNING: Invalid free page order: pfn=7dba0d, 
> order=6345292217329909760, max order=12
> WARNING: Invalid free page order: pfn=7dc618, 
> order=3319440018652528640, max order=12
> WARNING: Invalid free page order: pfn=7e8788, 
> order=1113619897082537567, max order=12
> readpage_elf: Attempt to read non-existent page at 0x20000000.
> readmem: type_addr: 0, addr:c00c000020000000, size:32768
> __exclude_unnecessary_pages: Can't read the buffer of struct page.
> create_2nd_bitmap: Can't exclude unnecessary pages.
>
> makedumpfile Failed.
> [   10.687238] kdump[542]: [0;1;31msaving vmcore failed, exitcode:1[0m
> [   10.689073] kdump[544]: [0;1;31msaving vmcore failed[0m
> [   10.699975] kdump[549]: saving the /run/initramfs/kexec-dmesg.log 
> to /sysroot/var/crash/127.0.0.1-2026-04-23-06:06:27///
> [   10.701749] systemd[1]: [0;1;39mkdump-capture.service: Main 
> process exited, code=exited, status=1/FAILURE[0m
> [   10.701933] systemd[1]: [0;1;38:5:185mkdump-capture.service: 
> Failed with result 'exit-code'.[0m
> [[0;1;31mFAILED[0m] Failed to start 
> [0;1;39mkdump-capture.service[0m - Kdump Vmcore Save Service.
>
> [   10.702090] systemd[1]: [0;1;31mFailed to start 
> kdump-capture.service - Kdump Vmcore Save Service.[0m
> See 'systemctl status kdump-capture.service' for details.
>
> [   10.702249] systemd[1]: Startup finished in 3.351s (kernel) + 0 
> (initrd) + 7.350s (userspace) = 10.702s.
> [   10.702388] systemd[1]: kdump-capture.service: Triggering 
> OnFailure= dependencies.
> [   10.703543] systemd[1]: Stopped target timers.target - Timer Units.
>
>
>
> If you happen to fix, this please add below tag.
>
>
> Reported-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
>
>
> Regards,
>
> Venkat.
>
>


