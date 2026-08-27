Return-Path: <linuxppc-dev+bounces-26127-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB493C5DF9D
	for <linuxppc-dev@archiver.kernel.org>; Thu, 27 Aug 2026 05:35:26 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hVqwr5zFgz2y2b;
	Thu, 27 Aug 2026 15:35:24 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1787808924;
	cv=none; b=ZSCJBl06SxPz4E0vf48bfmyTiTKR1oNA9rWmO7O0yanewhBo420r0pgaF+2cSGRHGKfBb1BYBmFItH53xQe9GMgcP9wE39PFrI5abVRv55JbIVAzVaZ9TxcqMUwq3EkkSUgtax3ZuuA7hl8ebXST1+un0xX71SHE52MXhNzL8EQdLWUES8g1ZLJNse0BXKpudk06o/UlKZ/Vrys7u+xLUsqeKR3xhLfOCkFnt/8l+dhUMfn0v1fx6sZHZMESvFJre84v/EB93cg7I7F7XbTM/IOy/OXEsraP4uWvUKrUQKfvKcHsHQ5Zpv8zrKt2y5e2FfJvGWdfdWyIcBKNUPuKZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1787808924; c=relaxed/relaxed;
	bh=PbfunTPv+ubg+Wq4QaYVc79N46RrIw5Rc8wiV1owOog=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Pmk3g9KKE41exiwv0vLjBQZ8zyxDENLWIu64ylnhuXIhHXpLhXLBDCGzsmWskH9FobXeK8G34ld61EWsdl8KsHZOMWGANkCmIho/Fw4PKYCfi4gTWeLnPIUZscdaDfwKvDBrdvW485BqjYqqtd/UgAIXfo1FZwzMj/LJBlm/z9r51Szx6nO6U/1e81LKp9qGtnFBmn7YxRGGjDN8iHIfEpeXdF1bNJcT+DfOsZNffj8w/eBey+/n37QHK0qpIjW9eoqXulsOPcmL8M0u11UgPQgPu7wkyakoO31jKr3OHyaH0akMAnx/2rPM4zbl/G6SaZ+F1Wu5mPQ4vywp8nC4zw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=JY/fGY2T; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=sourabhjain@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=JY/fGY2T;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=sourabhjain@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hVqwq4c2Vz2xwN
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Aug 2026 15:35:23 +1000 (AEST)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67R3VdpC1879080;
	Thu, 27 Aug 2026 05:35:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=PbfunT
	Pv+ubg+Wq4QaYVc79N46RrIw5Rc8wiV1owOog=; b=JY/fGY2TK8wY4aS1n85dbw
	TIPOBtLLE8q6XnNSHZ6bCACyCNHGSdd+58TfEZsQ2sXXNRijLvolq4n1V9zK2TKo
	rlZSRdkX2y1vZMYglBQ/3s7eDxyyxa6H/2ZhKAC9mNjBZxKS4+/M9WfassKmZG+o
	GkakOu3qs1ak+nGFMreu+oMB8oQWuyy2jm6G3wKd4PANKA1Cas/nXXvQ50GYTrHI
	9wo8qBDMI7oOFlK6jdYwUq3lhW59L9Um5+8QPtLZPg6B0fDsUMatLGzrv/6PE0AJ
	vHoS7hTLSV6ZoK606FVccgkR3iVfb1W/lWVpfpSNLJW/DqIytp7+m1q85nEDhWQg
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g73dxk22w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 27 Aug 2026 05:35:11 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67R5QHES016918;
	Thu, 27 Aug 2026 05:35:10 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g7rsye1hb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 27 Aug 2026 05:35:10 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67R5Z6P438928770
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 27 Aug 2026 05:35:07 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D1F1F20043;
	Thu, 27 Aug 2026 05:35:06 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DB91020040;
	Thu, 27 Aug 2026 05:35:02 +0000 (GMT)
Received: from [9.67.147.197] (unknown [9.67.147.197])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 27 Aug 2026 05:35:02 +0000 (GMT)
Message-ID: <1a0a3a16-b92e-47ec-8545-035022583de7@linux.ibm.com>
Date: Thu, 27 Aug 2026 11:05:00 +0530
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
Subject: Re: [PATCH v2] ppc/fadump: collect dump if the collected size is
 lesser than reserved
To: Shivang Upadhyay <shivangu@linux.ibm.com>, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Cc: adityag@linux.ibm.com, adri.vero.dev@gmail.com,
        anushree.mathur@linux.vnet.ibm.com, chleroy@kernel.org,
        maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com
References: <20260826125626.2108771-1-shivangu@linux.ibm.com>
Content-Language: en-US
From: Sourabh Jain <sourabhjain@linux.ibm.com>
In-Reply-To: <20260826125626.2108771-1-shivangu@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI3MDA0MyBTYWx0ZWRfX7+kJ/lKZR3KQ
 DsiBhreBPENg/WPseyN1laGu1Qz8zPzuUSnv7I0BSTmXEp3biLsU6oieE6NBt/6jk6pwe0py/+U
 g+pvbPGF4VcUGb+Mw1ktujUWWGFAFIk=
X-Authority-Analysis: v=2.4 cv=AYuB2XXG c=1 sm=1 tr=0 ts=6a8fcc8f cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=HLng7LQRm-ufaKjakIwA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: c-z67YWCwM-Sxyl86tPn2VC_yGDTp8S9
X-Proofpoint-GUID: ipjDirF0m3_YrVg7yQwnzhrHSel1RsyH
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI3MDA0MyBTYWx0ZWRfX0ROjx0Sd0wgb
 dB/Z6N5vY7D53h9UACi6IWKsShe/eNEF7qdz6TpTxisZj+OMhNRkNMG3sAM6N0mbM/GMeQ7TT85
 Z5JQAUz/ppx0CsdDSAHe+ALRY12tHJnuOP+Y4zrk95qSAqW43AB0ZwrAl+aCi47TJiZ+KolVexW
 H0+YuQyXp4kllEJmimpSLrzTbuzC8utr5vO97MhGYbJGz69/slpOaOSJPTeIxj/plth+h0EP/09
 7nmk+dlMFdvXV3LpxrJhEgnsvlY7WyiFYHSmuLKa+SpXOXgmzyiVb8KH4XHHZUhHAGx8OtrBl87
 OMAoKH0c+1e6ytZX+IjAwaKUE6NwVdLjXl2UgnVjx2bDdEQfhx4EWZwPpienKAmBPrEl+Z/zWY7
 22+Doyhf2xuffcgAABfYQj5SQlrub2r6kvXW5wsrPAJf3pPIKlBeNVvU4KqnnvN0NGRhjZzOUXz
 TgA+gPfCZadgSOsXwcQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-27_02,2026-08-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 clxscore=1015 adultscore=0 bulkscore=0
 impostorscore=0 priorityscore=1501 lowpriorityscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608270043




On 26/08/26 18:26, Shivang Upadhyay wrote:
> During Fadump in Qemu VM, when maxcpus value is set to more than current
> cpus, following failure is observed.
>
>      [0.000000] rtas: Dump taken by platform is incomplete (-1)
>
> This is because the CPU_STATE_DATA is allocated for maxcpus, while the
> data is only filled for current cpus. As per current implementation
> of Fadump, dumped_bytes and source_len for a region have to match,
> Which is failing for qemu's case, Even tough the dumped bytes are
> reported correctly for only the current cpus. After this /proc/vmcore
> generatition also fails.
>
> Allowing dumped_bytes to be lesser than or equal to allocated length, for
> CPU_STATE_DATA Fadump region.

The overall logic looks good to me. And as per PAPR, firmware only 
promises to
send CPU data of online CPUs, so it is OK to accept bytes dumped less 
than the
source_len for CPU_STATE_DATA.

>
> Reported-by: Anushree Mathur <anushree.mathur@linux.vnet.ibm.com>
> Signed-off-by: Shivang Upadhyay <shivangu@linux.ibm.com>
> ---
> ChangeLog:
>
> v2: Only allowing lesser size for CPU_STATE_DATE Fadump region.
>
> v1: https://lore.kernel.org/qemu-devel/20260429065127.366813-1-shivangu@linux.ibm.com/
> ---
>   arch/powerpc/platforms/pseries/rtas-fadump.c | 17 +++++++++++++++--
>   1 file changed, 15 insertions(+), 2 deletions(-)
>
> diff --git a/arch/powerpc/platforms/pseries/rtas-fadump.c b/arch/powerpc/platforms/pseries/rtas-fadump.c
> index 3bb4ac2ab6cc..ea1a0a8ac9eb 100644
> --- a/arch/powerpc/platforms/pseries/rtas-fadump.c
> +++ b/arch/powerpc/platforms/pseries/rtas-fadump.c
> @@ -459,7 +459,10 @@ static int __init rtas_fadump_process(struct fw_dump *fadump_conf)
>   	/* Check if the dump data is valid. */
>   	for (int i = 0; i < be16_to_cpu(fdm_active->header.dump_num_sections); i++) {
>   		int type = be16_to_cpu(fdm_active->rgn[i].source_data_type);
> +		uint64_t bytes_dumped = be64_to_cpu(fdm_active->rgn[i].bytes_dumped);
> +		uint64_t source_len = be64_to_cpu(fdm_active->rgn[i].source_len);
>   		int rc = 0;
> +		int region_collected;
>   
>   		switch (type) {
>   		case RTAS_FADUMP_CPU_STATE_DATA:
> @@ -469,8 +472,18 @@ static int __init rtas_fadump_process(struct fw_dump *fadump_conf)
>   				pr_err("Dump taken by platform is not valid (%d)\n", i);
>   				rc = -EINVAL;
>   			}
> -			if (fdm_active->rgn[i].bytes_dumped != fdm_active->rgn[i].source_len) {
> +			/*
> +			 * Make sure that dump is collected for entire region.
> +			 * CPU_STATE_DATA region is allowed to dump less than allocated space.
> +			 */
> +			region_collected = (bytes_dumped == source_len ||
> +	                         (type == RTAS_FADUMP_CPU_STATE_DATA && bytes_dumped <= source_len));

Do we really need region_collected variable? Can't we manage with rc only?

Is bytes_dumped < source_len is good enough instead of <=. There are a 
couple of warnings/errors reported by the checkpatch script.
Please address them in the next version.

- Sourabh Jain


> +
> +
> +			if (! region_collected) {
>   				pr_err("Dump taken by platform is incomplete (%d)\n", i);
> +				pr_debug("type -> %d, bytes_dumped -> %llx, source_len -> %llx\n",
> +				         type, bytes_dumped, source_len);
>   				rc = -EINVAL;
>   			}
>   			if (rc) {
> @@ -482,7 +495,7 @@ static int __init rtas_fadump_process(struct fw_dump *fadump_conf)
>   			}
>   			break;
>   		case RTAS_FADUMP_PARAM_AREA:
> -			if (fdm_active->rgn[i].bytes_dumped != fdm_active->rgn[i].source_len ||
> +			if (bytes_dumped != source_len ||
>   			    fdm_active->rgn[i].error_flags != 0) {
>   				pr_warn("Failed to process additional parameters! Proceeding anyway..\n");
>   				fadump_conf->param_area = 0;


