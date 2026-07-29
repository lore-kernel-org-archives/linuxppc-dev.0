Return-Path: <linuxppc-dev+bounces-24961-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1275AC53200
	for <linuxppc-dev@archiver.kernel.org>; Wed, 29 Jul 2026 04:01:52 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h8zDH3M8Yz2xnp;
	Wed, 29 Jul 2026 14:01:51 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785297711;
	cv=none; b=ktNJ47Z2YTZqFGrMjCOLOgjse60kxlyupnpBaioijpfP65q6bDKmMu6WPyDY5OJ3tIOCwgVGzjPxLwc4Oxg0fwliZFPCEQ839TyGa3lOdB9eyNQZh0dKWrRIZpd6VdLZmCroP4cMZpzN4aB2heC2nW85OWmrp6mcioLzVpGuO0sBs0Lj7vKarBHQYvacgX1iFf5NZqtqYTKXOX+7JuoagGuZLU1GcPk1jt+g23yt7EBDcIU7386YAtugyyqSU/NsF3tMTy9NMcesc5WNV/85E20+t7JNqS7DhF4fC6sWcaGDrmU3wWSO6XV8HgI52U40LiptrVV5U9973GWv643c7g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785297711; c=relaxed/relaxed;
	bh=UwdSfF4dwDDd1o9vVvZnzYG6sBNqbiXMz+g/lzThHS0=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=d34xGdrh6yo7GaH9Uvks+R9FjaWPBu4L1CZDpmxISHK4U6vZeTjqOfXOf7paTkp+IFR4yItjdzpAspEmxAXu9EjSmyihBlAtYNsl1v97ni6TMlgc5r0NZQbMFWlY36dLY9F6bDNi9TIijfYxER+UyPwmXyweg78MLM/AKYLE412Y8vh+UI7g4ntka4mAi2UnSlMWiNPIg8b/qZOS7hj7ZGqspuM6sZXBD/9gpOC1kio1rgfG+x5uHg4WPfFR7Ipp4Im40Eb6oS84+1KNp6fCic0TCb9X4wAiZj+Rkgr6OmtAm4TO9IPrJ7t8Kb/WjJt6VhYStovpuDbYDYWOLTsTkw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=EuEBipCF; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=sourabhjain@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=EuEBipCF;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=sourabhjain@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h8zDG2xn1z2xlQ
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Jul 2026 14:01:50 +1000 (AEST)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66T1K1R32716870;
	Wed, 29 Jul 2026 04:01:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=UwdSfF
	4dwDDd1o9vVvZnzYG6sBNqbiXMz+g/lzThHS0=; b=EuEBipCFL52gswbh/2I2UZ
	qky7AA33GZTkDgMmdBbKj6BcEHJpexn6WXrcE804sQf0i0rl79rBliTysi9kOAA4
	oosO/0NPSS4EYd+TW+qYSwR71jMzqZOSTYpuyfZ8z+69miVOcswM70NEqUShNwK0
	S5GHML0C8VdB+fJuhXIvUoe9TgNf4l9TZ1EkIDSiHggD/yaknl4Qab5dY9YJWQcv
	e5AlkFfRc9eeN7DMfm6FtVT+NdwMuEwuKbQ5BV2Fiwp3KiBk+ZPMff+5Vnh1JgM3
	ByQVS8QCoNYgPj6gFBchKrncYcRalCQq7PRYDaNjGaUtJRzOLAoouFcFxoS+XPng
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmuyj80kc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 Jul 2026 04:01:32 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66T3uJYi030661;
	Wed, 29 Jul 2026 04:01:31 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fn7uw570e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 Jul 2026 04:01:31 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66T41PLt30147048
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 29 Jul 2026 04:01:25 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AFECD20043;
	Wed, 29 Jul 2026 04:01:25 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 660E120040;
	Wed, 29 Jul 2026 04:01:21 +0000 (GMT)
Received: from [9.39.23.157] (unknown [9.39.23.157])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 29 Jul 2026 04:01:21 +0000 (GMT)
Message-ID: <796bfc49-3a39-43ad-b422-9a2241d10512@linux.ibm.com>
Date: Wed, 29 Jul 2026 09:31:20 +0530
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
Subject: Re: [PATCH v2 2/3] powerpc/kexec_file: Fix null-ptr-def in extra size
 calculation
To: Jinjie Ruan <ruanjinjie@huawei.com>, maddy@linux.ibm.com,
        mpe@ellerman.id.au, npiggin@gmail.com, chleroy@kernel.org,
        rppt@kernel.org, baoquan.he@linux.dev, hbathini@linux.ibm.com,
        adityag@linux.ibm.com, ritesh.list@gmail.com, bauerman@linux.ibm.com,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <20260729012948.2797865-1-ruanjinjie@huawei.com>
 <20260729012948.2797865-3-ruanjinjie@huawei.com>
Content-Language: en-US
From: Sourabh Jain <sourabhjain@linux.ibm.com>
In-Reply-To: <20260729012948.2797865-3-ruanjinjie@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI5MDAyNyBTYWx0ZWRfX3JTyAmVbhbGw
 hIFToukgYvx7Pv7J0faDOcNdRDM9n4SFQjFoQSgML1pYU87uh0JpDJHRxbbvCQo/X4UB/zE6VOo
 gT8rAjUedHHSKzp1S+NzUYsPiShqyzI=
X-Proofpoint-GUID: wwqt7-ON4CCqauqd3x4ymDKdszAT5x_H
X-Proofpoint-ORIG-GUID: 7EhR9ZSUvJcU5Mdq1ocIYYQTvOlOn2Dc
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI5MDAyNyBTYWx0ZWRfX1Q6BUbrCKDBw
 n1Xjys0hg3SFHygJT2WDjAVY1BJGsBQDAhQXdGdfMg+kY2wWMBwGV4Ai/E0PK6eG7hkWuTGTBpj
 sbcakkT8XGx+Ei5wY+eYvM28OmRvkXGB0FFZ2dRvmcQW+yxgybYdCQUYP5isuqk6AA0bNZGN4fH
 tRVY7ytcsAG5sxNUdwRmMg6t/ZTo9eMGYH1VzBYwUtVLq8FUCahBryhB92G806ERjkBK2VyeUVS
 LJ85O/jT7UlBcf8Hswr17J7XcjFw9EcgvOMr/6Bht+yJiIjVeZZr8xSSNJel3auvOv5e3aaeUUs
 g+Ao28lW9VdgGjWAxk0dIoLHF0s7e1pEW/bfGMAQHLjU+LFZMKLfuFVVaUMy4SZCDRDpnNuSYjh
 PAHflExtL79hFVKNLxn3zaH/2yo1eqEE5xYX5DJvSj9JPn467N3n8TFK/MDAzIYYh3U69ARJ4lV
 NB/Po4ynMtbt0eqIoGQ==
X-Authority-Analysis: v=2.4 cv=X5Vi7mTe c=1 sm=1 tr=0 ts=6a697b1c cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8
 a=VwQbUJbxAAAA:8 a=i0EeH86SAAAA:8 a=-myP8IA0lDaWtb26DoQA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-29_01,2026-07-28_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 lowpriorityscore=0 phishscore=0
 priorityscore=1501 malwarescore=0 spamscore=0 suspectscore=0 bulkscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607290027



On 29/07/26 06:59, Jinjie Ruan wrote:
> A static Sashiko AI review identified a potential NULL pointer
> dereference in kexec_extra_fdt_size_ppc64().
>
> On platforms without any reserved memory regions,
> get_reserved_memory_ranges() can return 0 while leaving 'rmem'
> unallocated as NULL. Passing it directly leads to a kernel panic when
> evaluating 'rmem->nr_ranges'.

Yes that is possible, so it is worth adding NULL check for rmem.
Feel free to add:
Reviewed-by: Sourabh Jain <sourabhjain@linux.ibm.com>

>
> Add a NULL check for 'rmem' to prevent this crash.
>
> Cc: Sourabh Jain <sourabhjain@linux.ibm.com>
> Cc: Hari Bathini <hbathini@linux.ibm.com>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: stable@vger.kernel.org
> Fixes: 0d3ff067331e ("powerpc/kexec_file: fix extra size calculation for kexec FDT")
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
> ---
>   arch/powerpc/kexec/file_load_64.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/powerpc/kexec/file_load_64.c b/arch/powerpc/kexec/file_load_64.c
> index 8c72e12ea44e..6075b1c88511 100644
> --- a/arch/powerpc/kexec/file_load_64.c
> +++ b/arch/powerpc/kexec/file_load_64.c
> @@ -664,7 +664,7 @@ unsigned int kexec_extra_fdt_size_ppc64(struct kimage *image, struct crash_mem *
>   		extra_size += (cpu_nodes - boot_cpu_node_count) * cpu_node_size();
>   
>   	/* Consider extra space for reserved memory ranges if any */
> -	if (rmem->nr_ranges > 0)
> +	if (rmem && rmem->nr_ranges > 0)
>   		extra_size += sizeof(struct fdt_reserve_entry) * rmem->nr_ranges;
>   
>   	return extra_size + kdump_extra_fdt_size_ppc64(image, cpu_nodes);


