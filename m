Return-Path: <linuxppc-dev+bounces-28043-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFB7FC9830B
	for <linuxppc-dev@archiver.kernel.org>; Wed, 23 Sep 2026 16:21:29 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hqhzr1z35z2y2L;
	Thu, 24 Sep 2026 02:21:28 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790180488;
	cv=none; b=jzHclbfkg8w4L5iOHt+MXDH4UpQKW/YBe/+yfrIc/gF+R4oDRoWIdudVxFy07GOshqs0hHZvKFepXgqfQ0/97YFl4YjGsBhbX5Xes6VAMUdmTjRJKY1F+m0aJ8Ho00YMHkC0ygKcuf+Wgh2OKUbQX9ybgcgk2gQPWE7DKt98v1pds5wXTVGjta47wapZNnhG1cdJ4CpGfucodbNc10qawe1gblKuQo3ypCtsMm3EyKjGA+le4s8tgDuaC4EgJYBiDRn5Q/S5toTRxi7/VZjLUIrltT2FGN4g4bu7vaYHhWbFNvBSYbe9QC22yn0f9V1GYAr3H/X39PczN+pHV7oDCA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790180488; c=relaxed/relaxed;
	bh=ZcoRdxXPrmS1d20YMAKxezeFtqcplaGpZnLH1kTYytA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BgSQv6qjNTMVUta83i7YbaPY4POeiFptRX9hUiq/+z0Nfv1nqGjPJ5VeSu6WqLrbX81TDfS0wxPKWNenbmzqS+DqTIHCs47wzfBHzt5uyAIdP65nejYKDmG8BtfQGtQ/3H8rAAEFuEheRjtYTrlo7v722+l4DZq1i7HnsRDwni8Pv+raseLshffcpmEsCUq5+oEyIZeeVPLmu94MRmVEDz4LtEbc45uCr/fGykaigvINtG8nhma4ebiRNFMqalUL1MZ99ICXFlXJHsN2CdtiCha37AvghrDPTs68e3FJLTru6bbL8ALk0gNQyoF6gZEMY0/tXi4+QJxYVv9B1k5xAQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=FamIbBis; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=anushree.mathur2@ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=FamIbBis;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=anushree.mathur2@ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hqhzq36TQz2xmh
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Sep 2026 02:21:26 +1000 (AEST)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68NGA7873708720;
	Wed, 23 Sep 2026 16:21:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=ZcoRdx
	XPrmS1d20YMAKxezeFtqcplaGpZnLH1kTYytA=; b=FamIbBis1gZIaiY2B3esux
	xdxYUEIPPjGYkg6wgF4Axa4byh1LeYFSyuouTz7ENbApxpXy8C+cePnjD8sgmA8T
	cJLY3F8gMuQ9Kdcv93t0h88LIB+WOYE3frcPXxCyDdm7jeA5oyMVkfqAzt/iIlQv
	pmnuLAddV9laXAcQk9OTVlAv639+jfvJwUOeibKGydzg4zqHbW08FNZufnNnHuWk
	U5MoPO2Az4X16TyGfE1uUJ4tHSsZJUfERMOi1nfXGjbwfScZwZlWemJ1cAQ8a7fJ
	qMP80CGl5iuaJTQHJn8BhALycA+lSR6fdTAJWQaPdypIEJfE2scOgUJvC14Kkwhw
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gske1kyb8-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 23 Sep 2026 16:21:14 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68NGHX3k608643;
	Wed, 23 Sep 2026 16:21:14 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gvbt2spde-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 23 Sep 2026 16:21:14 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68NGLCTq66584896
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 23 Sep 2026 16:21:13 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AE31558058;
	Wed, 23 Sep 2026 16:21:12 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D08D15805D;
	Wed, 23 Sep 2026 16:21:08 +0000 (GMT)
Received: from [9.39.19.48] (unknown [9.39.19.48])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTPS;
	Wed, 23 Sep 2026 16:21:08 +0000 (GMT)
Message-ID: <bc0b1c90-aad9-4696-ac85-0bb4e44cc7ba@ibm.com>
Date: Wed, 23 Sep 2026 21:51:05 +0530
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
Subject: Re: [PATCH v4] ppc/fadump: collect dump when CPU_STATE_DATA is less
 than reserved
To: Shivang Upadhyay <shivangu@linux.ibm.com>, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Cc: sourabhjain@linux.ibm.com, adityag@linux.ibm.com, adri.vero.dev@gmail.com,
        anushree.mathur@linux.vnet.ibm.com, chleroy@kernel.org,
        maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com
References: <20260828094942.2439404-1-shivangu@linux.ibm.com>
Content-Language: en-US
From: Anushree Mathur <anushree.mathur2@ibm.com>
In-Reply-To: <20260828094942.2439404-1-shivangu@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: FTFi1BLt_yGbD9jw84GRHNcvlgUwcsdn
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIzMDA2NCBTYWx0ZWRfX/qHp2hq+1XoE
 KagiOZt5DklB0oeD1rUIeWifj96Pp9w2yyi1VZgIW84h/Zgim7L++EK7Pip8ZsJsnhmPE6sJ+87
 D3xsjO2QXJOTmcUQ+LE9HXpV5MC6exQdPCrImy8LbUDo3LVz214kMQsfJGsOtMf7oP+MlfeJhW6
 WUpmKf1IwUcgzq/wEvWYZ9kdFRDV3scVpfg3mGQwpV0t9+Cy4mfYL2xeMIV1tEDE0twwi320/dn
 YmajvUpX8PJ/5Q2C3ewSM7SyoV3VdGeHlZBxxulozCNDm2vRhdhRj+7bshUTvc10dMRx11tJybs
 qo66zxGn4ivPl3G104qz/c1jgnFaCUvULRDe7jjZP/FuFu8wnrucHBMk/+lSdKQ7Q4EtRHJ2gxN
 3Me8v1buL9XwzKrmr2ZMMhuxlw5qr9T/3d+/J3fmZB9e0kgGSxncXBjKns7wcy+i5/zxAYczYgW
 NHuuguA9nZxIgufJNnQ==
X-Authority-Analysis: v=2.4 cv=O/KsLx9W c=1 sm=1 tr=0 ts=6ab3fc7b cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=Tux-YmWtoYNaYMML6QAA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIzMDA2NCBTYWx0ZWRfXzgPirTs8C6Ww
 A/M/I+bFhTvDiSBIizEzao5jC4uc6qjDYVN3jD6jzBd2icgu6Yvx/ZYwtnlfoI2CJbljcaeUyFg
 9Fm1gw4bNCzc+gsupF4SofVf5bHJM3o=
X-Proofpoint-GUID: uVCPgsBQZymEcDmlOGD6EmuRraLPU1NJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-23_05,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 phishscore=0 impostorscore=0 suspectscore=0
 bulkscore=0 priorityscore=1501 lowpriorityscore=0 adultscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609230064


On 28/08/26 3:19 PM, Shivang Upadhyay wrote:
> During Fadump in Qemu VM, when maxcpus value is set to more than current
> cpus, following failure is observed.
>
>      [    0.045806] [      T1] rtas fadump: Dump taken by platform is
>          incomplete (0)
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
>
> Reported-by: Anushree Mathur <anushree.mathur@linux.vnet.ibm.com>
> Closes: https://lore.kernel.org/all/5e66daf4-3f55-4044-94a5-4f50bb040849@linux.ibm.com/T/#u
> Signed-off-by: Shivang Upadhyay <shivangu@linux.ibm.com>
> ---
>
> Changelog:
> v4:
>      removed extra blank line.
>
> v3: https://lore.kernel.org/all/20260827075803.2240934-1-shivangu@linux.ibm.com/
>      removed extra variable.
>
> v2: https://lore.kernel.org/all/20260826125626.2108771-1-shivangu@linux.ibm.com/
>      Only allowing lesser size for CPU_STATE_DATE Fadump region.
>
> v1: https://lore.kernel.org/qemu-devel/20260429065127.366813-1-shivangu@linux.ibm.com/
>
> ---
>   arch/powerpc/platforms/pseries/rtas-fadump.c | 16 ++++++++++++++--
>   1 file changed, 14 insertions(+), 2 deletions(-)
>
> diff --git a/arch/powerpc/platforms/pseries/rtas-fadump.c b/arch/powerpc/platforms/pseries/rtas-fadump.c
> index 3bb4ac2ab6cc..838e97c24308 100644
> --- a/arch/powerpc/platforms/pseries/rtas-fadump.c
> +++ b/arch/powerpc/platforms/pseries/rtas-fadump.c
> @@ -459,6 +459,8 @@ static int __init rtas_fadump_process(struct fw_dump *fadump_conf)
>   	/* Check if the dump data is valid. */
>   	for (int i = 0; i < be16_to_cpu(fdm_active->header.dump_num_sections); i++) {
>   		int type = be16_to_cpu(fdm_active->rgn[i].source_data_type);
> +		uint64_t bytes_dumped = be64_to_cpu(fdm_active->rgn[i].bytes_dumped);
> +		uint64_t source_len = be64_to_cpu(fdm_active->rgn[i].source_len);
>   		int rc = 0;
>   
>   		switch (type) {
> @@ -469,10 +471,20 @@ static int __init rtas_fadump_process(struct fw_dump *fadump_conf)
>   				pr_err("Dump taken by platform is not valid (%d)\n", i);
>   				rc = -EINVAL;
>   			}
> -			if (fdm_active->rgn[i].bytes_dumped != fdm_active->rgn[i].source_len) {
> +
> +			/*
> +			 * Make sure that dump is collected for entire region.
> +			 * CPU_STATE_DATA region is allowed to dump less than allocated space.
> +			 */
> +			if (!(bytes_dumped == source_len ||
> +			(type == RTAS_FADUMP_CPU_STATE_DATA && bytes_dumped <= source_len))) {
> +
>   				pr_err("Dump taken by platform is incomplete (%d)\n", i);
> +				pr_debug("type -> %d, bytes_dumped -> %llx, source_len -> %llx\n",
> +					 type, bytes_dumped, source_len);
>   				rc = -EINVAL;
>   			}
> +
>   			if (rc) {
>   				pr_warn("Region type: %u src addr: 0x%llx dest addr: 0x%llx\n",
>   					be16_to_cpu(fdm_active->rgn[i].source_data_type),
> @@ -482,7 +494,7 @@ static int __init rtas_fadump_process(struct fw_dump *fadump_conf)
>   			}
>   			break;
>   		case RTAS_FADUMP_PARAM_AREA:
> -			if (fdm_active->rgn[i].bytes_dumped != fdm_active->rgn[i].source_len ||
> +			if (bytes_dumped != source_len ||
>   			    fdm_active->rgn[i].error_flags != 0) {
>   				pr_warn("Failed to process additional parameters! Proceeding anyway..\n");
>   				fadump_conf->param_area = 0;

Hi Shivang,
Thanks for working on this fix, I have tested it with patched kernel on 
both PowerVM (ppc64le) lpar and guest, and it worked totally fine.

As reported earlier 
https://lore.kernel.org/lkml/5e66daf4-3f55-4044-94a5-4f50bb040849@linux.ibm.com/ 
without patch I was seeing multiple kernel OOPS and

     [    0.045806] [      T1] rtas fadump: Dump taken by platform is
         incomplete (0)

After applying the patch I am not seeing OOPS and not even this error :
"[    0.045806] [      T1] rtas fadump: Dump taken by platform is incomplete (0)"

Fadump got completed and I came back to guest console successfully.

Please feel free to add:

Tested-by: Anushree Mathur<anushree.mathur@linux.ibm.com>
Thank you,
Anushree Mathur


