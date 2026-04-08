Return-Path: <linuxppc-dev+bounces-19457-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E407FF513A
	for <linuxppc-dev@archiver.kernel.org>; Wed,  8 Apr 2026 02:26:24 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fr6Pq0GHtz2yYJ;
	Wed, 08 Apr 2026 12:26:23 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775615182;
	cv=none; b=Kx4OzQrBd5pWaeULOipVhDEf4uRMt3N3OHmab98GqJC2heESmuVIFknPcpKFUlAwA0fOc9MMoNPeKEUKiFWa728Xjx0WwdzPk8K/+tRMYls1iZEPbCVu50f2PgNxoM51TeUpADYqi4O6ZTZfh5XLr706rWOoWsiDSKet5yvliUXR2iKfwiDfLLO6j14CtiGbN+A6MPzgxahdxYQ3sJf0LRq46Vb8SOcuhU9OcaDi2B5L+sP0kTlnoDlRphgd9YJSloLrvjV3X3aRM3+4tGFGzA2t7SgtNa4JmZdZpa2Mobzjy0Onf304u4NOeHUzBnqms+MDehJtoaEalMN5fXOO3g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775615182; c=relaxed/relaxed;
	bh=NCrkRQYMSQ5j5g/0NQSdg/Tl5Y0NkQVe0j/X+3jUCLE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=epqi2i5mEE3YDoby+EiPUXoR7+CHcPTFM0fNk24PUjGVyhTYyz3yeSfBVBzeZpJtrjolTKJR4oXm+EeitZli04DAwKPMKt9VZtrxneqQ1U/bseHxTwGWStRDEwmshdb36j2OHMwLZMmOJFpXZqACrP1BBYDE/g2M/0Tltaj9oxAXlSe3Lu1KMzyO+siMZM7S0Bbp+JU9Cn4RvnuHtFFNR/r31p+isZ+K5baS+/s0aU7v4zZaIGi7yqs7eOxoBLUC9LvndoRgUnQhxQmNrZVhRLKMIvZe8Z27Iw/jIbducbCTOfwC388iojwVNKFuKooLAaF00JrnHNLVH+pvqyWgaQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=ic8UxVvr; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=hbathini@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=ic8UxVvr;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=hbathini@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fr6Pn4Bysz2xm5
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 08 Apr 2026 12:26:20 +1000 (AEST)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 637EnJLB2393155;
	Wed, 8 Apr 2026 02:26:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=NCrkRQ
	YMSQ5j5g/0NQSdg/Tl5Y0NkQVe0j/X+3jUCLE=; b=ic8UxVvr7J189fiB52e06O
	meE9KbiRtbgoIehouU+oQ3SWSjNq7kZw7nc4OFqNXZvSgHlruoku1JRVAxw6TvmT
	6LdgM6SsI9RZ0g7bLkxKTZUx+2p46ssm5l/twZ1zu5aSACWEriy7AiHtOdzR/i3X
	oDPPMp5nkDXUDYg17uO3iiAsEe4NYGsNVOQCe2rV7qYW0+G2c2Rj3q84Fem+xZLu
	OM9lfYXrmJGpEl62a8j9U8JgxbzEYWGUwFtJ+YH4yIjO8SzwslxLvCU5bH6p/Qyp
	s8X3iJcoLbDElCwEf+AnRX0DZlbMxeMFOYqWj8yjFeyFQO0+N4W4zaTmIiFN5vEg
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dcn2kdfuc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 08 Apr 2026 02:26:03 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 63801LVF013878;
	Wed, 8 Apr 2026 02:26:02 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4dcmf45qdw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 08 Apr 2026 02:26:02 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6382Pww742533184
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 8 Apr 2026 02:25:58 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AE89F20043;
	Wed,  8 Apr 2026 02:25:58 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CA79420040;
	Wed,  8 Apr 2026 02:25:56 +0000 (GMT)
Received: from [9.124.212.104] (unknown [9.124.212.104])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  8 Apr 2026 02:25:56 +0000 (GMT)
Message-ID: <c591ed58-4e80-44ae-8ffc-e85e20b4077c@linux.ibm.com>
Date: Wed, 8 Apr 2026 07:55:37 +0530
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
Subject: Re: [PATCH] powerpc32/bpf: fix loading fsession func metadata using
 PPC_LI32
To: adubey@linux.ibm.com, linuxppc-dev@lists.ozlabs.org
Cc: bpf@vger.kernel.org, maddy@linux.ibm.com, ast@kernel.org,
        andrii@kernel.org, daniel@iogearbox.net, shuah@kernel.org,
        linux-kselftest@vger.kernel.org, kernel test robot <lkp@intel.com>
References: <20260408055301.232745-1-adubey@linux.ibm.com>
Content-Language: en-US
From: Hari Bathini <hbathini@linux.ibm.com>
In-Reply-To: <20260408055301.232745-1-adubey@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA4MDAxOSBTYWx0ZWRfX29N2OQr5AZHH
 Rtx0qo9mJ78R9/MgtqOhvF2V/LV2Z2z98HsIiIVm1YWw+2PdjQynL3IXjg/dVvONDVruin8Jq2o
 OW/EFLJib0k0AY2Upp/NbzEgoo2hvuywuvNiG3blbtnjztU8eOfqJbsIkTm5IdjsBZxuoTzBABg
 hxeFkaJC+W3WT+ukHCEs7ob20RqcvWLvUoPVJjzu35wdJK2yKOCt0emfkiSmfRtQJAK7bw6+lGh
 GwXQusS8/OOgAzyDSwtymTt7oppy4/8q72NSPw6Ffv9b2u5x30e8yGTk8KXUwJFVWkEc7HegHnI
 2BBtMzRyNxLplawGnqr0IXKtuIPGoBAoRKwc/IZq9LPZLwr66M2xd7Aar6GgDlZeUUr1CCIAUvU
 uD4Dor1TxgqLBQi94iE6oIQTFRize+e9E6rHxw2pXsz+rxVY0sOnm6jM6mvqZ54Fnzeymm7qO/h
 3HTjrMttimfadFGLFWg==
X-Proofpoint-ORIG-GUID: kmoZ6tMShq6BjguQsUWm3q1QDRX0uqOJ
X-Authority-Analysis: v=2.4 cv=e9k2j6p/ c=1 sm=1 tr=0 ts=69d5bcbb cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VwQbUJbxAAAA:8
 a=QyXUC8HyAAAA:8 a=VnNF1IyMAAAA:8 a=nt2x_24I-j7WEdVBZf8A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: kmoZ6tMShq6BjguQsUWm3q1QDRX0uqOJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-08_01,2026-04-07_05,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 impostorscore=0 malwarescore=0 suspectscore=0 spamscore=0
 bulkscore=0 adultscore=0 priorityscore=1501 phishscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604080019



On 08/04/26 11:23 am, adubey@linux.ibm.com wrote:
> From: Abhishek Dubey <adubey@linux.ibm.com>
> 
> PPC_RAW_LI32 is not a valid macro in the PowerPC BPF JIT. Use PPC_LI32,
> which correctly handles immediate loads for large values.
> Fixes the build error introduced when adding fsession support on ppc32.
> 

Thanks for the fix.

Reviewed-by: Hari Bathini <hbathini@linux.ibm.com>

> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202604040212.jIxEd2DW-lkp@intel.com/
> Fixes: 92258b5bf1ec ("powerpc32/bpf: Add fsession support")
> Signed-off-by: Abhishek Dubey <adubey@linux.ibm.com>
> ---
> Need to apply on tp of powerpc -next, as this fixes a build error reported on that branch
> 
>   arch/powerpc/net/bpf_jit_comp32.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/powerpc/net/bpf_jit_comp32.c b/arch/powerpc/net/bpf_jit_comp32.c
> index f3ae89e1d1d0..bfdc50740da8 100644
> --- a/arch/powerpc/net/bpf_jit_comp32.c
> +++ b/arch/powerpc/net/bpf_jit_comp32.c
> @@ -150,11 +150,11 @@ void store_func_meta(u32 *image, struct codegen_context *ctx,
>   	 * func_meta := argument count in first byte + cookie value
>   	 */
>   	/* Store lower word */
> -	EMIT(PPC_RAW_LI32(bpf_to_ppc(TMP_REG), (u32)func_meta));
> +	PPC_LI32(bpf_to_ppc(TMP_REG), (u32)func_meta);
>   	EMIT(PPC_RAW_STW(bpf_to_ppc(TMP_REG), _R1, func_meta_off));
>   
>   	/* Store upper word */
> -	EMIT(PPC_RAW_LI32(bpf_to_ppc(TMP_REG), (u32)(func_meta >> 32)));
> +	PPC_LI32(bpf_to_ppc(TMP_REG), (u32)(func_meta >> 32));
>   	EMIT(PPC_RAW_STW(bpf_to_ppc(TMP_REG), _R1, func_meta_off + 4));
>   }
>   


