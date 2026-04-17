Return-Path: <linuxppc-dev+bounces-19826-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1ED95F43680
	for <linuxppc-dev@archiver.kernel.org>; Fri, 17 Apr 2026 09:31:05 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fxqPh1Z0Tz2xpt;
	Fri, 17 Apr 2026 19:31:04 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1776418264;
	cv=none; b=T0lf39OpwBpYz2OHOsoBrDlDHF4bJ9bVG5lOyGCirc9E5NeV0AeIK9eeoYil9fSJVQqnMCqS+BKiVlq8MaLp/XDUc/t5lhoK1qvrjKp4yAmBmnQiIPHym3XLH0Hin8YK31HIfSimY6oiCl8xZoAE5nAoLsfIHmtXjhH3LRildo7BDaxWRW16tGSEE2JaoHRsU7prxpeRFH/99OxfXzynZ3Jr+3u4nIYJCiJiCQQpZCKZJKUWeCHxzCSR+k6YAfgpFzdbWE58qtbxn3uZUvWa11t9gJtBAdvvAtGt59KHT0MGHaO5pci6xy5kmdfyQoOXqYK9rMxh1PFSGFeAREfDKA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1776418264; c=relaxed/relaxed;
	bh=ylhcWAMoRMz5RLxhUd4Za9Ti0jJBJoVhrjk5Uufr7vA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UZfTrRpv71FCiMYaPE4rhhBu0cxG069t4r3ahZ65wuD7vaNToXqIRFok42LSz7LDYQZ0cvRhI90SOY168eFVGvkYK31kbK7d43/9ihVS6UUS9YwqQZgcs6IGc4x74+whOMUMHbbBReHbVX6xasX8eYpjBZUyF9IIuoM8D3BlRUuGdkLPUlpoL9oRE5NKt4Z1tpq/JFTX04kPLHjJDdV6440ARqd4Wm5d++gxsNj6fPfce8mEuCydRHaZ7yn8z8eMVgqmjeW0YB/yUn1zBJT4cGx8gFTddg9NtEdCDazwlWUPmt1PfkMT188dDnA/ZcwoDLuyLPwpAhITrlVVSmFbeg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=e73eTsvI; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=sourabhjain@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=e73eTsvI;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=sourabhjain@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fxqPf2D4Gz2xfX
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Apr 2026 19:31:01 +1000 (AEST)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63GJHOuX1860002;
	Fri, 17 Apr 2026 09:30:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=ylhcWA
	MoRMz5RLxhUd4Za9Ti0jJBJoVhrjk5Uufr7vA=; b=e73eTsvIhJ0awn0Or42Bp+
	aREr77SE06xCFCSpmxMqkpXR8AmtBAKls6MaSXZHYbDlmKgwJcwl0vXi0Gr9g9Sm
	5aKG6ONY2HQ/swDE5JTMjjKynGU9UZ9f/53skHHeWvW3g/AGIQF2EMoSIciHG/Im
	SvX4o09OE/z8sKS6MR5hiZ1EcWHCA51pF4rDTkMBaA/VAEMZpbpXmuGJLcCWXIb+
	h8QRIuS1QHWEs/UjZWh+clGw2HLUjWYDt1Y9vk3qC5Huyte1ghzAUAp5GHxK8UU4
	b3u3vuAt1UhgN77qcGRy6nMwZk9OhmXc0liKcdn1ei6hewUnRecna7/xRCJorvqA
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dh89prncm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 17 Apr 2026 09:30:44 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 63H8MfE6025621;
	Fri, 17 Apr 2026 09:30:43 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dg2ujxe9a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 17 Apr 2026 09:30:43 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 63H9UeYr48169468
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 17 Apr 2026 09:30:40 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 224D62004E;
	Fri, 17 Apr 2026 09:30:40 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id ADA5720043;
	Fri, 17 Apr 2026 09:30:37 +0000 (GMT)
Received: from [9.39.28.188] (unknown [9.39.28.188])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 17 Apr 2026 09:30:37 +0000 (GMT)
Message-ID: <dc17d2a4-058a-4ca7-b701-32a53c71f07f@linux.ibm.com>
Date: Fri, 17 Apr 2026 15:00:36 +0530
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
Subject: Re: [PATCH] powerpc/fadump: reject empty bootargs_append writes
To: Pengpeng Hou <pengpeng@iscas.ac.cn>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc: Nicholas Piggin <npiggin@gmail.com>,
        "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
        Hari Bathini <hbathini@linux.ibm.com>, Jiri Bohac <jbohac@suse.cz>,
        Shrikanth Hegde <sshegde@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260417073907.4985-1-pengpeng@iscas.ac.cn>
Content-Language: en-US
From: Sourabh Jain <sourabhjain@linux.ibm.com>
In-Reply-To: <20260417073907.4985-1-pengpeng@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: ZpuidKosRXgK6xFjk55b3s7C5Ioqw6nb
X-Proofpoint-ORIG-GUID: FgBNQs713CIGiH4qqfKSSI_ZCZl0tnqc
X-Authority-Analysis: v=2.4 cv=WbE8rUhX c=1 sm=1 tr=0 ts=69e1fdc4 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VwQbUJbxAAAA:8
 a=ISPHxN_rHVCBf9gf85UA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE3MDA5MiBTYWx0ZWRfXzZJRh73LJd6m
 sOfnU4KimGoboDbpWbqRA/IniEZ+4+85ZNQUGiMgaOJ2+979mCXqtEPV9t9p5/4ZuQWN+ncoyk0
 8WV5n6fNTy7hNu9Rev7m+W7v3E2WsOlQ0CusdTZ1vQKI/UDk1D0nIpBhZSypUl8ZSaao8jH0G2r
 WQPplU4UO9xefl2qZUTQLC8Q/VkAWIUNFThYG8R7VHwxA2EpU3tQCIYSn2pO9h48InZss56XDCD
 n8gCqgT2awh8rZo5tKOwkYMppXtNqf6haXR37Z6VVC4nlyivCHtWSngvWgh+hb4UL7S7xFY0Lt4
 u6KlBY6jllNGw9q0VgFAXuM3rpt0B3S53PUVCge22WWlKC2kfxpp76ubqGk1tPZLON1cwh5aNl3
 XVPZ+rsJ4nNlB2/ihlWZf/XeYReFVmxGEvfI1ke7AJnZLuyuRgIHFEjtMijB9eRTzcFnBZD1HdA
 qrJ842Y3bjravnwF1Hg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-16_04,2026-04-16_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 priorityscore=1501 spamscore=0 clxscore=1011
 phishscore=0 impostorscore=0 adultscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604170092



On 17/04/26 13:09, Pengpeng Hou wrote:
> bootargs_append_store() indexes params[count - 1] when stripping a
> trailing newline from the sysfs write buffer.
>
> kernfs passes zero-length writes through to the store callback, so an
> empty write makes that newline check read before the start of params.
>
> Reject empty writes before looking at the last input byte.
>
> Fixes: 683eab94da75 ("powerpc/fadump: setup additional parameters for dump capture kernel")
> Cc: stable@vger.kernel.org
>
> Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>
> ---
>   arch/powerpc/kernel/fadump.c | 3 +++
>   1 file changed, 3 insertions(+)
>
> diff --git a/arch/powerpc/kernel/fadump.c b/arch/powerpc/kernel/fadump.c
> index 4ebc333dd786..03ab5565e420 100644
> --- a/arch/powerpc/kernel/fadump.c
> +++ b/arch/powerpc/kernel/fadump.c
> @@ -1479,6 +1479,9 @@ static ssize_t bootargs_append_store(struct kobject *kobj,
>   	if (!fw_dump.fadump_enabled || fw_dump.dump_active)
>   		return -EPERM;
>   
> +	if (!count)
> +		return -EINVAL;

How you manage to call this function with count as 0?

> +
>   	if (count >= COMMAND_LINE_SIZE)
>   		return -EINVAL;
>   


