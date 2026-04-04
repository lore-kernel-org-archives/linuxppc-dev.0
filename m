Return-Path: <linuxppc-dev+bounces-19302-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D97A8E88D78
	for <linuxppc-dev@archiver.kernel.org>; Sat,  4 Apr 2026 03:20:38 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fngpF0F88z2yL8;
	Sat, 04 Apr 2026 14:20:37 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775272836;
	cv=none; b=a6zKL/LfW/owFVGdE6W9x/A+tq/fYpilVA/vLQwj3qiuP7vImXvmn4UFSFu1Lcay2+86CJEC86Lbumjl9499dkJE580uUnUEV1+JaZiHOJqBn9lA2V2PrJBLN9Qy7IC9gFkTptX6S6bW3ldKVxAg3yl8oLlyrB+YcAkxQPUmrQmv43qzrxW3mtKWT34MjnqagPW3FWJHrSGDBnG2zOAk8UifRMMuAnNkwpWu8Nypdov3TTBVdr/r9fnNoG71Cj6Mwt8Tm7oOKtkXixonZERkVCXKiHTWHcYtuV74tqhem/NORVqV0b28XNcaF2bGWxcSXztSWpJB+5B3nc1Q0u09MQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775272836; c=relaxed/relaxed;
	bh=f7+GFnuDISnAHiV3ZDmGpGZpYewsSRG08Mtv2Z+Rx6I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bWfoGWw5aYk5a5Z1ASgLKS8iUZjig4LMtnM6ImMtKzItx3IU//USApvk5RxoaaD+W+D/H09AMLBNxHgPJH8cqdtH3GRbfAvbfi+CxiTnOfmRpct2xWtoSuwJZt0u7KOvIc1usKUC+cW/ticZhOU/7OvTSksq/F1ZzS7Fwd5UeRf8f+KHLpFoSgfK9zCD7/+2pWNNXTSixwm5CAGZC308GzTsRKiWZfEKkwJYAC8jKqYS3CV90eTPhAHGK53ZiAnh1VKtaF3hXovPNtJMRZNql9sI5d2UkiPUZDTI2b26hoUo8sJ51QcQOtF9lmakHgQ+Sc+/IoNKmBq5YNGuAT8XEQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=thGTo2yv; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=sourabhjain@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=thGTo2yv;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=sourabhjain@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fngpC5h8Nz2xQr
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 04 Apr 2026 14:20:35 +1100 (AEDT)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6341HNtw2895882;
	Sat, 4 Apr 2026 03:20:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=f7+GFn
	uDISnAHiV3ZDmGpGZpYewsSRG08Mtv2Z+Rx6I=; b=thGTo2yvIRkQqJQvsI08aZ
	CLyIxYuk6kiK4xrNgdvJZ82h38X+Sd1bQQqpvBtF76+NaI7/qw6vvpXhqbJix5Oj
	aq7566zBTwDqsf75iNpLoOiX2g2OsZNwRNdVf/oj/epDNynJvAHk1mAK1wUi1CqF
	BOrUecoP1rny2BICnzgdFChhrxAWRapvkdbPsGkr/+GAqeZ4OqqsaHy568YauqRZ
	1xUBblfJfomXTH13yZ+12YA4CgrN79uX9elDYUhHT/RSMJyNvjRbacS5NJBz2HGQ
	Gu76G29igPm/5ScLqlb2x21ZP5Ikk/SxuLK58YY8loxNzt9+GNeFpBXdUpbRETPg
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dar2g88yd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 04 Apr 2026 03:20:24 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 6341vTpa030952;
	Sat, 4 Apr 2026 03:20:23 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4d6uhk8679-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 04 Apr 2026 03:20:23 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6343KJuY39715122
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 4 Apr 2026 03:20:19 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E68B820040;
	Sat,  4 Apr 2026 03:20:18 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6F3F52004E;
	Sat,  4 Apr 2026 03:20:15 +0000 (GMT)
Received: from [9.39.18.186] (unknown [9.39.18.186])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sat,  4 Apr 2026 03:20:15 +0000 (GMT)
Message-ID: <20edd82e-62ce-480c-a075-c604df6a3a27@linux.ibm.com>
Date: Sat, 4 Apr 2026 08:50:13 +0530
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
Subject: Re: [PATCH v2 1/2] powerpc/kdump: fix KASAN sanitization flag for
 core_$(BITS).o
To: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
        linuxppc-dev@lists.ozlabs.org
Cc: Venkat Rao Bagalkote <venkat88@linux.ibm.com>,
        Aboorva Devarajan <aboorvad@linux.ibm.com>,
        Aditya Gupta <adityag@linux.ibm.com>, Daniel Axtens <dja@axtens.net>,
        Hari Bathini <hbathini@linux.ibm.com>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Shivang Upadhyay <shivangu@linux.ibm.com>,
        Mahesh Salgaonkar <mahesh@linux.ibm.com>
References: <20260403190123.1383198-1-sourabhjain@linux.ibm.com>
 <eckvmtik.ritesh.list@gmail.com>
Content-Language: en-US
From: Sourabh Jain <sourabhjain@linux.ibm.com>
In-Reply-To: <eckvmtik.ritesh.list@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: IgY2I70tV32jQ0cHrhviuSPgJY1I8TPV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA0MDAyNiBTYWx0ZWRfXzvd5JUwR2+eZ
 gig2Pvk5GnWIHaZr2MiH5vzyvAPBVBpNCDQeXh1gz3Jh7RZnJakJE4HPDiB0NjJmJszTocEwGVZ
 TosEZ51LKglTV1y3uGAuZa6VshUwgfodRiShjQ6M0giakjzXsZKijQPcKqZCIb5XGgeVwNsETgR
 i2XzLFQmxbQWjr82M7Chplh4GPUp4CkiI1WEyqkSGMb88+jTlnqGOSj/0BK+y94G4bzKBxVMnBl
 Hr2x3qiwQleG+R4pzanxXhXItEanigfrm80zIZL9idpClVsufkiPNbMUStC8F7UA198hMtt8IT4
 gtHjCHEDi04ZGDpZHOwmI/M4e5zSeqeRyDqkSVRx1Mz29EuDKkn7xRv9cn8jx2F5tJ9FvssaTIS
 zUhbjqCKgw16x7ebOVg0FHHL82Qx6ULHSedw8aF/DCDqgXAiGykNZcqh68Txl2EdbDzxMJMAhC2
 wYRDT1fsygtHGP7ZQ4A==
X-Authority-Analysis: v=2.4 cv=b+u/I9Gx c=1 sm=1 tr=0 ts=69d08378 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=JuTF4qcAAAAA:8 a=ZS8Cze6H77hOx2eYTWQA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=WlT8qwTXB_Kj6um4hl3b:22
X-Proofpoint-ORIG-GUID: TIMKH0XKirol0adekwxQ2EoVDYNsk1xy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-03_07,2026-04-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 bulkscore=0 adultscore=0 lowpriorityscore=0
 impostorscore=0 malwarescore=0 spamscore=0 priorityscore=1501 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2604040026



On 04/04/26 06:27, Ritesh Harjani (IBM) wrote:
> Sourabh Jain <sourabhjain@linux.ibm.com> writes:
>
>> KASAN instrumentation is intended to be disabled for the kexec core
>> code, but the existing Makefile entry misses the object suffix. As a
>> result, the flag is not applied correctly to core_$(BITS).o.
>>
>> So when KASAN is enabled, kexec_copy_flush and copy_segments in
>> kexec/core_64.c are instrumented, which can result in accesses to
>> shadow memory via normal address translation paths. Since these run
>> with the MMU disabled, such accesses may trigger page faults
>> (bad_page_fault) that cannot be handled in the kdump path, ultimately
>> causing a hang and preventing the kdump kernel from booting. The same
>> is true for kexec as well, since the same functions are used there.
>>
>> Update the entry to include the “.o” suffix so that KASAN
>> instrumentation is properly disabled for this object file.
>>
>> Fixes: 2ab2d5794f14 ("powerpc/kasan: Disable address sanitization in kexec paths")
>> Reported-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
>> Closes: https://lore.kernel.org/all/1dee8891-8bcc-46b4-93f3-fc3a774abd5b@linux.ibm.com/
>> Cc: Aboorva Devarajan <aboorvad@linux.ibm.com>
>> Cc: Aditya Gupta <adityag@linux.ibm.com>
>> Cc: Daniel Axtens <dja@axtens.net>
>> Cc: Hari Bathini <hbathini@linux.ibm.com>
>> Cc: Madhavan Srinivasan <maddy@linux.ibm.com>
>> Cc: Michael Ellerman <mpe@ellerman.id.au>
>> Cc: Shivang Upadhyay <shivangu@linux.ibm.com>
> I guess you missed adding:
> Cc: stable@vger.kernel.org

You’re right, I missed it.
I’ll include it in the next revision.

Thanks,
Sourabh Jain

