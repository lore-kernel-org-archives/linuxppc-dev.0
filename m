Return-Path: <linuxppc-dev+bounces-26547-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D85E7C624D3
	for <linuxppc-dev@archiver.kernel.org>; Fri,  4 Sep 2026 10:06:13 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hbsYb5dy5z2y2M;
	Fri, 04 Sep 2026 20:06:11 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788516371;
	cv=none; b=EtdD0XEmHYl/Ydva0lC22yKWz1ODaVOcyWTnPk7uGIT4voc4Bba+jrTobDwf/PyaPqaIxKdGbFMMNLedefJcJEYZjsbAiH/UAtDytxSfPjQGzkG2tpCo4RCeO36VO64IZJkgsxj6ZSj2rFTurrT9znBrT636fmBxnrjuMDHE83G4MS42dSTNGn1omzHG+Q5jl1Dkv6p8+U0QjSwe7YVCkryxYW+aVrML0d46JO9ugDBBmXeiSANgY4ARassQDlaVv97gjx9Wjt6fdmsLrhfBVFHlMpX81b0nGmHquBvIyQblMOh11kQYmZLQ75ytLzRf+fviDNmZWgcJlLNVWfho6g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788516371; c=relaxed/relaxed;
	bh=HAJTgYBKg3fKvAiJ558+O1UQkjeF4ppuqg6h+ykwFro=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Th4rguWmbTWg8gNNH7928FNO2bgTegKxT/JpWHrzvWZsKu4/74StAksDATi7mwRA7tPbduMaK1MTqex5lyHLhtvGDT+VK+E33Bi/5et9PCNXpbXZuTDCxgjcYDqZJtkfSUwMaCXAXhKNIxU7ssMZf2DViJ2WdUcla9C8qejo2g/TmotEz/G1xGZpM7bV5DR1QYV4AKvqieUws35eEYm7Cx0OK/54svQdC33NOjpynGKZzJIZJkJW/cpEF09geGqzqtdejR6uPJ8o2aL130nW8hZgNlGJGwAS5XZKNLiobeRK8XTnMnvYdS5L7zzYHslAvDNNnjRKb1feGPEaS38EjQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=ZH4VTZD3; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=sshegde@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=ZH4VTZD3;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=sshegde@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hbsYb0MBgz2y2K;
	Fri, 04 Sep 2026 20:06:10 +1000 (AEST)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68464Mn73254224;
	Fri, 4 Sep 2026 10:06:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=HAJTgY
	BKg3fKvAiJ558+O1UQkjeF4ppuqg6h+ykwFro=; b=ZH4VTZD3C6bbWR6jJVA2KO
	t4xBPTjFCXNY5RF1IJCZnUTpGuMWBTkblp3LI/xyUNRKZx/53R8WY9dI3abUiaMW
	4Hs1G3MGDyygVhJb0PXiDXcjwxmKUxgj3ITwOhFNkm0zJZM7L9PJZhll0gQlcOvH
	TdcaSDaGmbLtvUMpYmqGxLBfcbfyK/wACDwFRipFlmC+VZHmfkoJh9aJd6uHZEjN
	aILJzg/J0UhP5vv7msRl+EoMdrrJ1zOnpr+U0OtLWpflAmPmewrvd6NoC9x6w7eb
	4+MM63jbdnilLQi9oUrNJeCrpWSMDemoOHuuCShHor3m5xDrZPxY8R07dCbquNIQ
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gbq3rt1pg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 04 Sep 2026 10:06:01 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6849uOEq010327;
	Fri, 4 Sep 2026 10:06:00 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gc9rqvjxp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 04 Sep 2026 10:06:00 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 684A5uWd44171664
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 4 Sep 2026 10:05:56 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 62EC72006A;
	Fri,  4 Sep 2026 10:05:56 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7E5402005A;
	Fri,  4 Sep 2026 10:05:53 +0000 (GMT)
Received: from [9.124.221.192] (unknown [9.124.221.192])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  4 Sep 2026 10:05:53 +0000 (GMT)
Message-ID: <f1d356ae-9f95-4139-903d-5ec1783278ca@linux.ibm.com>
Date: Fri, 4 Sep 2026 15:35:52 +0530
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
Subject: Re: [PATCH v3 1/3] powerpc/numa: Simplify find_primary_domain_index
To: Srikar Dronamraju <srikar@linux.ibm.com>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
Cc: skiboot@lists.ozlabs.org, arbab@linux.ibm.com, mahesh@linux.ibm.com,
        Ritesh Harjani <ritesh.list@gmail.com>,
        "Mike Rapoport (Microsoft)" <rppt@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
References: <20260902123458.340456-5-srikar@linux.ibm.com>
 <20260902123458.340456-6-srikar@linux.ibm.com>
Content-Language: en-US
From: Shrikanth Hegde <sshegde@linux.ibm.com>
In-Reply-To: <20260902123458.340456-6-srikar@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=EIc2FVZC c=1 sm=1 tr=0 ts=6a9a980a cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=eDlDjDsLvsYrmFaFoiYA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA0MDA5MSBTYWx0ZWRfXwyWWIlbNsHBm
 QXCLk1QsebeKZB8AnivQGYN7dwutRtTBqjHoo2j3s1Bnn094N0R3OKlgkkq8aIWerARvhbOX3VX
 gMPq/FiXpdA+GUVIOoFx16Q66pqBwARsP5rM/Thea5eiJ27QbM2hrSelDN7tWZLvIySmqOguDd+
 l9yXdJTF00anyAfhQTbSgCyCYB6wrh4ICnWfJbvDQBI7/FBO7H7eL2sBDS3Kp14tD656UWw5Y2W
 3gWI+8Q5BC5ihk+Yzjco/avAI3PmF73PLCXQQBlFSbSKZQoNs8Ion/5V9xRH0zCCEGOxuzmmvOK
 DPTFtZ11KUqTA9U9MAS4+lmIaZTtZ8LfWW0lHYrjRCT+L07QmaNK/dile2Nfjlzkg/uI0bYugfa
 T4zdfDKAaVxV0LvV8ZlYxS0MH1C5alEmYhQRlQT5WQRXeZ19rud8DiNAZb+MYtxsY+a6LI9C+oD
 2bkxFG3RBnkDhuBTtVQ==
X-Proofpoint-GUID: _vvNfrb4YUhBjf_ZCh6dlG4WvITRi9BC
X-Proofpoint-ORIG-GUID: Mff89xAGMEEiMOICzw41UsY9Eum749AZ
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA0MDA5MSBTYWx0ZWRfX0sk+wHPuhAMc
 xkooS29DZvHVqb4EfU8TytB3SJiU5j6uZfULrw08CiT4pxw01G/pwdhFA2tZO+1iKlsk/22zSwy
 rtrvzqi/+TmXqRw3wzRGWOccPXfyt/c=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-04_02,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 suspectscore=0 priorityscore=1501 clxscore=1011
 phishscore=0 spamscore=0 adultscore=0 lowpriorityscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609040091



On 9/2/26 6:05 PM, Srikar Dronamraju wrote:
> Initialize the return value once and use a single exit path in
> find_primary_domain_index().
> 
> This is a small cleanup that keeps the existing behavior unchanged while
> making the control flow easier to follow.
> 

Reviewed-by: Shrikanth Hegde <sshegde@linux.ibm.com>

> Signed-off-by: Srikar Dronamraju <srikar@linux.ibm.com>
> ---
> Changelog from v1:
> - Handle comments from Christophe Leroy
> 
>   arch/powerpc/mm/numa.c | 7 ++-----
>   1 file changed, 2 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/powerpc/mm/numa.c b/arch/powerpc/mm/numa.c
> index f4cf3ae036de..c44a80d8fc11 100644
> --- a/arch/powerpc/mm/numa.c
> +++ b/arch/powerpc/mm/numa.c
> @@ -432,7 +432,7 @@ static void __init initialize_form2_numa_distance_lookup_table(void)
>   
>   static int __init find_primary_domain_index(void)
>   {
> -	int index;
> +	int index = -1;
>   	struct device_node *root;
>   
>   	/*
> @@ -502,12 +502,9 @@ static int __init find_primary_domain_index(void)
>   		distance_ref_points_depth = MAX_DISTANCE_REF_POINTS;
>   	}
>   
> -	of_node_put(root);
> -	return index;
> -
>   err:
>   	of_node_put(root);
> -	return -1;
> +	return index;
>   }
>   
>   static void __init get_n_mem_cells(int *n_addr_cells, int *n_size_cells)


