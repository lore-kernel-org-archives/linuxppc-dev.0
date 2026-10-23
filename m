Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E0CB606A321
	for <linuxppc-dev@archiver.kernel.org>; Fri, 23 Oct 2026 07:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=YM3Uz6JK
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j9vb25WK9z2yFQ;
	Fri, 23 Oct 2026 18:21:34 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1792740094;
	cv=none; b=QwtPsxmDBckjshh78Dmx9b99Hqoo2WHK0mCicB509b6V28yOfksEVHIT7HjqnWKYfsh+dZTiqXm1fG+b5JHXYldJEZ9vO5Ds8DaiyLs+s6buLYAHXeKSJ1/I04pApDO6BZQBrvw/mD9TLuaMt0lEu8ZBaZG4neNJhdNAaz9WzC8nis30SVWlcd4vry7+AJVGzsI41CuvTHLoh+V2RRO6X9ofNXBGQUBQR+fE0NlZbc+ul6fSLJdOTx6QUycJ6gtK5HT/tN1psS6iK6txE/IxJiXrk+5auLj+hUpkmfAJxf7GJWna9BovPP+LJVEDKrAbq159qmgwaDpUFJhONCJo+g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1792740094; c=relaxed/relaxed;
	bh=WDR6ooeVIotixrIvIkb6JgGwf+BRY25SqpGfYwvLI0w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=k96wHArCqLBJacyNS2garpgPuC+qGUIvFMBiyU3E4zuEbqqf3SyTJIJt1+QuVWW6nG3w82WsTQ+FfuZhAsSidxKAvBwtmcyiKhqy+Okldgb4+FHEkpX0PZNDj3635ZAzFB9fV4GbR7Z1SaWJuc5C1RI6sD9ldLxpPioW4sFMVLL0OkD6VzdhSchtm+EL3R8OzbtY9WHdtWML90DV7NG4dIuwCQ6p69Cm+fTo0hkEIV8hPkleyKJmbZ/dYOdaZpSXZWNbTfH3uQEFqJf1y7oTaP0dThn8h3vh2QFPna3hEvejtgpmJOqtky4KDi5cZFQx3d32ik/2HMII/xuTd6WkyA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=YM3Uz6JK; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=sourabhjain@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=YM3Uz6JK;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=sourabhjain@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j9vb14Q8Rz2xfX
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Oct 2026 18:21:32 +1100 (AEDT)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69N7EYUC2353677;
	Fri, 23 Oct 2026 07:21:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=WDR6oo
	eVIotixrIvIkb6JgGwf+BRY25SqpGfYwvLI0w=; b=YM3Uz6JKVmYd7A+JX/jLsX
	6PJJd49hAFT6u6G26itEf8S6MdVHqodWTs7xWMVbbwk/WYfbhvQIC8/zn21PVN7v
	cPwCNNSJSr546JddSWw7H7fw3+ZVckFsb5nCBkCG/o83NlycIN+NOr5qjLvzJ4I8
	VrjLU1gLooI5DnwWiF1lYLIfL7QOrDDiQOcERsRxBHPEqZY3G5+2aNSs3sXkeIJm
	EXdJdgQh146JrC15EQzOt1+gdUVFRobq3vuPWJVwALSPI5ex+dvfz7jEL61Y1C2M
	/wfDd38PPMVorvKqgPlJ8PLUvTnwRCy/X/95SGqpjC8KZ+SAx8JohHkGnyksy1Aw
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hdw593tbd-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 23 Oct 2026 07:21:18 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69N7Js9L1759232;
	Fri, 23 Oct 2026 07:21:17 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4hfj1x42ke-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 23 Oct 2026 07:21:17 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69N7LDrJ49283334
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 23 Oct 2026 07:21:13 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8ADBB20040;
	Fri, 23 Oct 2026 07:21:13 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CBECC20043;
	Fri, 23 Oct 2026 07:21:10 +0000 (GMT)
Received: from [9.123.14.142] (unknown [9.123.14.142])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 23 Oct 2026 07:21:10 +0000 (GMT)
Message-ID: <84309e06-83ef-4ce7-9072-2aeaa164d4a6@linux.ibm.com>
Date: Fri, 23 Oct 2026 12:51:09 +0530
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
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] powerpc/kexec: Annotate umem_info members with
 __counted_by_ptr()
To: Thorsten Blum <blum@kernel.org>,
        Madhavan Srinivasan
 <maddy@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
        "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
        Shrikanth Hegde <sshegde@linux.ibm.com>, Kees Cook <kees@kernel.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Hari Bathini <hbathini@linux.ibm.com>,
        Aditya Gupta <adityag@linux.ibm.com>,
        Jinjie Ruan <ruanjinjie@huawei.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
References: <20261020114029.200922-2-blum@kernel.org>
Content-Language: en-US
From: Sourabh Jain <sourabhjain@linux.ibm.com>
In-Reply-To: <20261020114029.200922-2-blum@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: xswN8Vdk8p243iJ3MfEE7FinnZ-DD0I1
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIzMDAyOCBTYWx0ZWRfX/9fnSKfqsczf
 T/34aentEg4lk8wFX8GDEe+vlEfFpbnMY3gRwJpEVzGWWWBu72D1UdL7PirlVb6sLTMU1M1UOOX
 O40WxZmSOnIV1rUyiQ+dHTvnI3nQYfc=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIzMDAyOCBTYWx0ZWRfXzMhhaP/uYvMT
 h55nzxVGeP7uQIHId7eDPePb+ZK8VNG2jj9qNQDLVQIRo37Y9X68DShw5pAUJSFbT8g6nEDhpW8
 /o5pFAf5cYaeY5wGer2KWtlCJMpdryhpueF7eU75Wr3hRNdOelNKbnQALiNr0a5Z2Vla7dsRDM5
 xAFl8DrKStAgO2Dv2NTGpo11qjzWyTX62BGA83wsPtfg+j3CuSTawz/Tr2cht2tnM+togoPmzTe
 BYRNVuwUTutJAfa9Nrxpab1if9xygS8hyWZAAvb4ZqnhRGEPawEtNImkwKeN8mmrBt3w7/LlBqf
 0eNdRQ3vh8YZtsHq+e0VfPYrZ0U+oUt/HivdLiRc6m+ndXry9eFZzQv0RZv72FR+qwaifPg4rUa
 Zs8PSLby3dSy+nvsg01VYDhTRKt22VwLgsbmhkO0/xsgraK0UG+JE6D+3AEbEUkZhycO381jdEI
 MRUVI1iCf7OYn9Zmv0A==
X-Proofpoint-ORIG-GUID: sW66wudK0700NyCyqSmMOoJjZkfR6cGs
X-Authority-Analysis: v=2.4 cv=Ob4NnRTY c=1 sm=1 tr=0 ts=6adb0aee cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=0yJF51GdyllPhlXAo0gA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-23_02,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 phishscore=0 spamscore=0 suspectscore=0
 lowpriorityscore=0 clxscore=1015 impostorscore=0 priorityscore=1501
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610230028
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 20/10/26 17:10, Thorsten Blum wrote:
> Add __counted_by_ptr() to umem_info::buf and umem_info::ranges to
> improve access bounds checking via CONFIG_UBSAN_BOUNDS and
> CONFIG_FORTIFY_SOURCE.
>
> In check_realloc_usable_mem(), return early on krealloc() failure and
> use sizeof(*buf) when deriving max_entries from the allocation size.
>
> Signed-off-by: Thorsten Blum <blum@kernel.org>
> ---
> Changes in v2:
> - Preserve the original pointer/count assignment order (Sourabh Jain)
> - v1: https://lore.kernel.org/r/20260730130248.597249-2-thorsten.blum@linux.dev/
[...]
> ---
>   arch/powerpc/kexec/file_load_64.c | 21 +++++++++++----------
>   1 file changed, 11 insertions(+), 10 deletions(-)
>
> diff --git a/arch/powerpc/kexec/file_load_64.c b/arch/powerpc/kexec/file_load_64.c
> index bd80c5fb1b1f..7f45493e7c7a 100644
> --- a/arch/powerpc/kexec/file_load_64.c
> +++ b/arch/powerpc/kexec/file_load_64.c
> @@ -34,14 +34,14 @@
>   #include <asm/cputhreads.h>
>   
>   struct umem_info {
> -	__be64 *buf;		/* data buffer for usable-memory property */
> +	__be64 *buf __counted_by_ptr(max_entries); /* data buffer for usable-memory property */
>   	u32 size;		/* size allocated for the data buffer */
>   	u32 max_entries;	/* maximum no. of entries */
>   	u32 idx;		/* index of current entry */
>   
>   	/* usable memory ranges to look up */
>   	unsigned int nr_ranges;
> -	const struct range *ranges;
> +	const struct range *ranges __counted_by_ptr(nr_ranges);
>   };
>   
>   const struct kexec_file_ops * const kexec_file_loaders[] = {
> @@ -83,11 +83,12 @@ static __be64 *check_realloc_usable_mem(struct umem_info *um_info, int cnt)
>   
>   	new_size = um_info->size + MEM_RANGE_CHUNK_SZ;
>   	tbuf = krealloc(um_info->buf, new_size, GFP_KERNEL);
> -	if (tbuf) {
> -		um_info->buf = tbuf;
> -		um_info->size = new_size;
> -		um_info->max_entries = (um_info->size / sizeof(u64));
> -	}
> +	if (!tbuf)
> +		return NULL;
> +
> +	um_info->buf = tbuf;
> +	um_info->size = new_size;
> +	um_info->max_entries = um_info->size / sizeof(*um_info->buf);

Yeah, it is better to maintain the order. The changes look good to me. 
Feel free to add them.
Reviewed-by: Sourabh Jain <sourabhjain@linux.ibm.com>

>   
>   	return tbuf;
>   }
> @@ -288,12 +289,12 @@ static int update_usable_mem_fdt(void *fdt, struct crash_mem *usable_mem)
>   		return -EINVAL;
>   	}
>   
> -	um_info.buf  = NULL;
> +	um_info.buf = NULL;
>   	um_info.size = 0;
>   	um_info.max_entries = 0;
> -	um_info.idx  = 0;
> +	um_info.idx = 0;
>   	/* Memory ranges to look up */
> -	um_info.ranges = &(usable_mem->ranges[0]);
> +	um_info.ranges = usable_mem->ranges;
>   	um_info.nr_ranges = usable_mem->nr_ranges;
>   
>   	dn = of_find_node_by_path("/ibm,dynamic-reconfiguration-memory");


