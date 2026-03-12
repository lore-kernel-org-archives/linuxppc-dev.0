Return-Path: <linuxppc-dev+bounces-18091-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3704AFED2EF
	for <linuxppc-dev@archiver.kernel.org>; Thu, 12 Mar 2026 08:36:22 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fWgv852P0z3cFm;
	Thu, 12 Mar 2026 19:36:20 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773304580;
	cv=none; b=bHB36GfNQW4zaPf462frTEkgKapX76G6i6n2GhnCdvD3jD8cFzu99q+R9AK2WG7VI1SLhWIsvTBG2pb9vNRAuzLhl+kvygY/ER6/iHdTGM3vFy2aatb6AlQ1HS2H+uRo1I0jpWUyaGzbTvPdzFw6Ue+DfZMvHwofkNT5y6bHYy8oqv5z8nZtyw6dQfRoE85kIOtsV2UsNMwyw3hOiV891Pjtx2LQ5LsvrkCA5YHc/8bFKv59hn6foK5amicahTbMqRFPHV/Qr13zFl0tPYsOJj9kR+KLKB81Py1eWZKtvlaOt7DN9DXE9Gkm40UCl1bwi9oqjynUq4brodvdFACqIw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773304580; c=relaxed/relaxed;
	bh=YnXZbJv+YGNf7BA8xT+50kBcCElEDF8VrsdWEPNNHsM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JsmJwanvDAPpGHYIWyBcDpQrJxmSRZnu9qLVt2NrLsk01GzTrn83LalRJK85yRlO34HhVGQdjHXoyWMogSotkhujyDOKbUgM3x0bxb4Wp03S+vxqjhdpWwyIlPkYg/9he8xQGCyQzZG1sJ31505/dCmIAH7C6sDdlczVybbbInHNt+lgP1A54oh2nejbnoi+d3VH+O+5yLCYiRWccOyREU+Oupsnis/6glGkIZ7EkKTTLn1R7bKDdpEh1NTW7ALXo491gwTEO/RKvvWpPJDtyWr7FqRsPoLEWGxjxstOh1tQhNoeXNgN+7EF2xMeLI3jyg7mvFZHb9Rz//gkUpzm1Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=Dgnos6AK; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=hbathini@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=Dgnos6AK;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=hbathini@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fWgv76zqSz3cFN
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Mar 2026 19:36:19 +1100 (AEDT)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62BMWPdR2279397;
	Thu, 12 Mar 2026 08:36:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=YnXZbJ
	v+YGNf7BA8xT+50kBcCElEDF8VrsdWEPNNHsM=; b=Dgnos6AK01fvJqa7n5OjkJ
	CIMS0+wp+7m6EKxMWNitt5cXex2UbMBLUUSxdTaedp5GpVpUHSWaVTbioj2Op+NQ
	GKk7eWpkkzZmNIv7KqfM/idcdoBj8OzVVdnfg2s3lE0GtTbh/PaCxGaSkSse3MfU
	5gwLsCXD3C+tCRIxFN9h1O+knxYF6ZAh2OYG6qDhECuuyHX4PdBMOVLurDC2WUvP
	2ljEcpa1Avzd9WylU1SnQUyN7uMek+1j6hq6rDVIwcrVTyaEDm1Ivb1e92n/PEXQ
	+DSP8kSvNPoIjIka4gcod0lMmmiCxako3wsao59+DKndsn823VGTb9OUFkJULYhA
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cuh91hrf9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 12 Mar 2026 08:36:12 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62C4D3UR014748;
	Thu, 12 Mar 2026 08:36:11 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4cuha89k9q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 12 Mar 2026 08:36:10 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62C8a7XH45089076
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 12 Mar 2026 08:36:07 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0722120043;
	Thu, 12 Mar 2026 08:36:07 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9ACDE2004B;
	Thu, 12 Mar 2026 08:36:05 +0000 (GMT)
Received: from [9.78.106.17] (unknown [9.78.106.17])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 12 Mar 2026 08:36:05 +0000 (GMT)
Message-ID: <37e21f51-5872-4498-aed6-6db4dd874b11@linux.ibm.com>
Date: Thu, 12 Mar 2026 14:06:04 +0530
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
Subject: Re: [PATCH v3 1/2] powerpc/crash: fix backup region offset update to
 elfcorehdr
To: Sourabh Jain <sourabhjain@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>,
        Mahesh Salgaonkar <mahesh@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
        Shivang Upadhyay <shivangu@linux.ibm.com>,
        Aditya Gupta <adityag@linux.ibm.com>
References: <20260312083051.1935737-1-sourabhjain@linux.ibm.com>
 <20260312083051.1935737-2-sourabhjain@linux.ibm.com>
Content-Language: en-US
From: Hari Bathini <hbathini@linux.ibm.com>
In-Reply-To: <20260312083051.1935737-2-sourabhjain@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: -EPnE-xe3fB9ZdnsSPXVVZysfrvH-_pt
X-Authority-Analysis: v=2.4 cv=E6/AZKdl c=1 sm=1 tr=0 ts=69b27afc cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=pGLkceISAAAA:8 a=ioXZ0sDC-riqs7QaW60A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzEyMDA2OCBTYWx0ZWRfX69lrcZxhzmc5
 so5y+cUM1Lxv05MZ9VGrlBU/BCZOxh2Bp0vnKjUvp8F2eLN6IPzib/FLmNEJqvaLbxb5XxKYXv7
 4t/EuIWNvqtewKZSCHCEi4Y13eM1rjGrvarGECy71quiKeq3kqRGOY1LBe+Dp0RrKpd1TFWLczi
 h+XPDWdEV6FidhvKPuzANEP2wyAU/IaVMf9smEEpMUdXckCcV9w6YpamgEolgCGkhqSY3W9qx2W
 eM4iGZypiJlNR+iMFb1JfkBuVrwvRpsZSiH8FNVymnfFZzLdMtuLxIZTvi3rjjh1D6GDstuLdej
 8cdgh/dorVKZsePWnF/PmO3adxe8yk9mE7Hed/uxoZ/05Wpc7VjnnkrzgkYDOKJTvy8RHDru7Ow
 clc4PP6PKak4UXCBwZYmXBkcUB6LlNTGtq8TTEtxo4LohiiPVdbybmb8xQNeWEzBV97XAup+daM
 r0HgIp5JCzRefy3cF9g==
X-Proofpoint-ORIG-GUID: -WWPO7PIKerqWdd2jW333o5QQ7t9PznO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-11_02,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 clxscore=1011 malwarescore=0 phishscore=0
 suspectscore=0 priorityscore=1501 spamscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603120068



On 12/03/26 2:00 pm, Sourabh Jain wrote:
> update_backup_region_phdr() in file_load_64.c iterates over all the
> program headers in the kdump kernel’s elfcorehdr and updates the
> p_offset of the program header whose physical address starts at 0.
> 
> However, the loop logic is incorrect because the program header pointer
> is not updated during iteration. Since elfcorehdr typically contains
> PT_NOTE entries first, the PT_LOAD program header with physical address
> 0 is never reached. As a result, its p_offset is not updated to point to
> the backup region.
> 
> Because of this behavior, the capture kernel exports the first 64 KB of
> the crashed kernel’s memory at offset 0, even though that memory
> actually lives in the backup region. When a crash happens, purgatory
> copies the first 64 KB of the crashed kernel’s memory into the backup
> region so the capture kernel can safely use it.
> 
> This has not caused problems so far because the first 64 KB is usually
> identical in both the crashed and capture kernels. However, this is
> just an assumption and is not guaranteed to always hold true.
> 
> Fix update_backup_region_phdr() to correctly update the p_offset of the
> program header with a starting physical address of 0 by correcting the
> logic used to iterate over the program headers.
> 

Thanks for fixing this.
Looks good to me.

Reviewed-by: Hari Bathini <hbathini@linux.ibm.com>

> Fixes: cb350c1f1f86 ("powerpc/kexec_file: Prepare elfcore header for crashing kernel")
> Cc: Hari Bathini <hbathini@linux.ibm.com>
> Cc: Madhavan Srinivasan <maddy@linux.ibm.com>
> Cc: Mahesh Salgaonkar <mahesh@linux.ibm.com>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
> Cc: Shivang Upadhyay <shivangu@linux.ibm.com>
> Reviewed-by: Aditya Gupta <adityag@linux.ibm.com>
> Signed-off-by: Sourabh Jain <sourabhjain@linux.ibm.com>
> ---
>   arch/powerpc/kexec/file_load_64.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/kexec/file_load_64.c b/arch/powerpc/kexec/file_load_64.c
> index e7ef8b2a2554..e631cf2eda2c 100644
> --- a/arch/powerpc/kexec/file_load_64.c
> +++ b/arch/powerpc/kexec/file_load_64.c
> @@ -391,7 +391,7 @@ static void update_backup_region_phdr(struct kimage *image, Elf64_Ehdr *ehdr)
>   	unsigned int i;
>   
>   	phdr = (Elf64_Phdr *)(ehdr + 1);
> -	for (i = 0; i < ehdr->e_phnum; i++) {
> +	for (i = 0; i < ehdr->e_phnum; i++, phdr++) {
>   		if (phdr->p_paddr == BACKUP_SRC_START) {
>   			phdr->p_offset = image->arch.backup_start;
>   			kexec_dprintk("Backup region offset updated to 0x%lx\n",


