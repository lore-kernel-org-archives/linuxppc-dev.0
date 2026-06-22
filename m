Return-Path: <linuxppc-dev+bounces-22880-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3187CDB46F
	for <linuxppc-dev@archiver.kernel.org>; Mon, 22 Jun 2026 16:51:09 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gkZ302Jdsz2yVZ;
	Tue, 23 Jun 2026 02:51:08 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782147068;
	cv=none; b=JN/vN10GDMj/6DhXS/9c1chp225Vmzig3EfDSoYUj3EYpjSvAWLym8KERCnem/MB4k62zQvNsZBAf1+GD16g//YzcgWiWtxT+toX/MWd8Ybdwi0N+Y89ckFGe2BI6dWNdA2pTe4sXPU3iybsFYLgRS4i9bxtcqh2NKQx/boEjZNnu8T/SHrcgxzYML3OOgwj9oi9VRXDdzZXdtMf7Y0wSR8VjlfsGG8oEeIYRMNWN+D2NZYZkP63AtDuWWwJf9jLiGKG4n5Tx+OfupNYslFIUaHH3nxeOg43K/z0BeUGYriUWD4vfToA3R8lUn/d8LdwRqOCq+LFYBOslsQdSRxBgg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782147068; c=relaxed/relaxed;
	bh=e6MnNsB1JI1tEP3sZIGbzy/1NRNN9uXqTvzw4G8VXsU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gveK92JHNPxNRASnm5XdxzT9Kzb4FlG0eXAC4/hZtJTacsdeYUrDhgUbeGYZyzBKUDRkAxlreOiYTufLHJQ6X11vNrHx7zxUuvBaTv45P6yecp21o/T0U1HXeHL8VKWR8VKugtruzowNYN/6f9p3apNDAPhPVK+MmLrcXsTDVtYYdf1Gyzh17gLaysXpwuYcgUs/k7b3z2fdKbDEanQGoUjChbc7tfQgkYhjB1Lca4wDlMDFDZMVR1xpl/zp1nWWOl37mWnPqZr0DgSTmjl8vnGnsSE2IrLXvA1H9RqOBZl/gcgoSlP+i5VofYm8gzeVjZla21fy1YtuUvNb6Vleqw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=h/mP/1Zj; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=gbatra@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=h/mP/1Zj;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=gbatra@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gkZ2z2yhjz2xl6
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Jun 2026 02:51:06 +1000 (AEST)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65MFmQ8w3357589;
	Mon, 22 Jun 2026 16:50:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=e6MnNs
	B1JI1tEP3sZIGbzy/1NRNN9uXqTvzw4G8VXsU=; b=h/mP/1ZjcfAiMKyHkQ/DM5
	NdWMGzAYSm8Bsy9Z5/smM44C+qEcqb8goRBsgE2cX5c5wSksVBss8Aq0x3hL4vqX
	ybFpFvRXIvCwawSwYBHfO0pCeaIFAP3hrEZS6JQr88RsEgd3Y4yCULOg6j7UsLEU
	81LRqh5B4ExGas1CzAM5wuoRFVAqE/1xLWBjo7hUM67pepXL5TtvGZ6OOIJtqGlO
	q/OJ2/zRgXcjOb1Fa1sLJlMerbQP0nmgC1ykYFkpyqicEAJiU126bfWFoCmLseFg
	Ik+3rQWrMltq9Qzo1s4q7ASXXHdJQ4j0XLIglNKLZSfwXnhDM0uVNP25Xw0OyLyQ
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ewg9hjmk7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 22 Jun 2026 16:50:49 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65MGnhxi019966;
	Mon, 22 Jun 2026 16:50:48 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4ex6ph73ek-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 22 Jun 2026 16:50:48 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
	by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65MGolnU4981472
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 22 Jun 2026 16:50:48 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A6D8358053;
	Mon, 22 Jun 2026 16:50:47 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9FBB458043;
	Mon, 22 Jun 2026 16:50:46 +0000 (GMT)
Received: from [9.67.100.115] (unknown [9.67.100.115])
	by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 22 Jun 2026 16:50:46 +0000 (GMT)
Message-ID: <d7334f31-f4b9-49db-a8f6-4c989b9fbdbf@linux.ibm.com>
Date: Mon, 22 Jun 2026 11:50:45 -0500
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
Subject: Re: [PATCH] powerpc/pseries/iommu: Add check for
 iommu_pseries_alloc_group()
To: Haoxiang Li <haoxiang_li2024@163.com>, maddy@linux.ibm.com,
        mpe@ellerman.id.au, npiggin@gmail.com, chleroy@kernel.org,
        kees@kernel.org
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <20260622163818.1273990-1-haoxiang_li2024@163.com>
Content-Language: en-US
From: Gaurav Batra <gbatra@linux.ibm.com>
In-Reply-To: <20260622163818.1273990-1-haoxiang_li2024@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: pyEeXqOOVAUdO5hlzeUG22FzfS4ob4pf
X-Proofpoint-GUID: ndTafzkt6FtWs8oN3gm75JK1EF32c2Kt
X-Authority-Analysis: v=2.4 cv=Y4XIdBeN c=1 sm=1 tr=0 ts=6a3967e9 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=Byx-y9mGAAAA:8
 a=5QX-PXLFSXAG-62KpMYA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIyMDE2NCBTYWx0ZWRfX6Zx3uvrUmw40
 jCD+WP2gtU1CO33UEcQocJ/T+G7CM+SOskSkLlAZ8nmgQqjFZFyhJ5vVliquTYBEXSn8KYjAS8z
 MXH6TdQl2VY1QbCXJC8XgkSmNSn8UEAYq7ispCUs958FDegqSFdqbptNzCbh8G5R3gCO74xm4Br
 qlBBhGUOv7QRUJo7dfNnw8G+Rcxb7dREQ8y0NWAkrB9bFWCUHkX3DF50VKYlpgDcxbIwIW5c2dh
 GnGIeXZxkqeFQr4Hypi6PHI/E+ihqsG9YK2Llg+/Hzhc0dr/eMUlAYjPijvqZsJN+gRzzwa4nVU
 i+0HkbBtt/fWNhfX1zSnkj9keCcO3UURImzlXDv9eSzfwg9IMtFi5tUcoyACCKN9ifsDXEkmCEP
 eHsJKoiUpYoA4MJP0VKbojE0m6oDCHv3zPaR+A19f73P5+YRwq8MD27kYmDM+uaoj61YAKcZKIL
 M2PCxTz6efqyyZl3CGw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIyMDE2NCBTYWx0ZWRfX6h2B0hY/oNda
 uQPGXr0ppf7L9ss4vm0f1HZOYgXmfDmgDYnMPCwLmil5T3I0LPiLPSoR+C89V1Up4GWSeGoHOoZ
 ROnlIItXHPtDlBqUwzzO66MzkuEJ1yY=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-22_03,2026-06-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 malwarescore=0 lowpriorityscore=0 spamscore=0
 clxscore=1011 suspectscore=0 impostorscore=0 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606220164

Hello Haoxiang,

Please add this check for pci_dma_bus_setup_pSeriesLP() as well.

Thanks,

Gaurav

On 6/22/26 11:38 AM, Haoxiang Li wrote:
> Add check for the return value of iommu_pseries_alloc_group()
> to prevent a potential null pointer dereference.
>
> Signed-off-by: Haoxiang Li <haoxiang_li2024@163.com>
> ---
>   arch/powerpc/platforms/pseries/iommu.c | 3 +++
>   1 file changed, 3 insertions(+)
>
> diff --git a/arch/powerpc/platforms/pseries/iommu.c b/arch/powerpc/platforms/pseries/iommu.c
> index 3e1f915fe4f6..3b49a0f76df9 100644
> --- a/arch/powerpc/platforms/pseries/iommu.c
> +++ b/arch/powerpc/platforms/pseries/iommu.c
> @@ -1875,6 +1875,9 @@ static void pci_dma_dev_setup_pSeriesLP(struct pci_dev *dev)
>   	pci = PCI_DN(pdn);
>   	if (!pci->table_group) {
>   		pci->table_group = iommu_pseries_alloc_group(pci->phb->node);
> +		if (!pci->table_group)
> +			return;
> +
>   		tbl = pci->table_group->tables[0];
>   
>   		iommu_table_setparms_common(tbl, pci->phb->bus->number,

