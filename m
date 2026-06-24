Return-Path: <linuxppc-dev+bounces-22961-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91A17CDE002
	for <linuxppc-dev@archiver.kernel.org>; Wed, 24 Jun 2026 15:14:56 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gllq23r5nz2yYq;
	Thu, 25 Jun 2026 01:14:54 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782314094;
	cv=none; b=XcdeTqThpmNnItkywK7ZWKY/myRV7xv5uyzA7ZGabLguaE5ACJT//vjvkEohHBfdk1PQ4VRpcbPWc8AKigCk6qMW9EumNJTVEOIy2ozFwdaDW3TwaoXUC35uV4H+Nz1TgvmzW/iuhtdWFH5RBMH4fdKcSg4HSSkVI0xvK5OUXb5Q0RB71vwk90omuMqPbwAfiS3Jg44PD5jtILHUHOBRVmbJXijos1NHJyoKahLSZmGssyxaulrGwZ3RHxI05CzBkqBbBmwtQZIcSx/HIjvOzmXZAiiVlHQ+rawUU5dJjihoKlL4r6EFgDabAyui+gMruUronH/0qQAxsAccn6lWxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782314094; c=relaxed/relaxed;
	bh=xJObyXnpUVDmMYy0V086nGwmhU2/l7D2rZmg64phSSo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mV+yfLjB/jzf4iCqsj6zEurJeKO/+buAwcVV/VwX9aFkxguPk6t92FaZRDKzpHlbJkeljC6VkZxlmICVBj/Au0Pjmg5Er0K1z1wZq99CsDbWFG1i/+6d6HlPKp5By65qbi6KW0Gc01Sfhv7OpA1RRM4M2RGs3Fb3o1J4ZdNyL8rI6AwXOWpVqDjNhrUiuY/l7rSrIMM21RJo3CZcLEjg9k1aJ9MLec0vWboocvJOLtEVVApeGRm5kYDwBWL70pOYNcGQ+Ka0mg/GaLfedtrOPr9fzjnn/hGOCwHwmY3720Xt99hs3zLG/bWulX7ke/mK1Km+BgP3PqcrL22oPEkL4g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=KXrb63Ci; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=gbatra@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=KXrb63Ci;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=gbatra@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gllq12jNSz2yRF
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Jun 2026 01:14:52 +1000 (AEST)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65OEmOGm1191241;
	Wed, 24 Jun 2026 15:14:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=xJObyX
	npUVDmMYy0V086nGwmhU2/l7D2rZmg64phSSo=; b=KXrb63CibSHEeSLrnbOveX
	qgC8ITrNWgu7AdDSz/iWUnLl/ZoMw9KwfEILtYYMD9a8eB+rOBZswqiqn7S5doT2
	YzhasyYrafIOzz1jajrs9o7yc73oASJj4glLgnzhWqAqxZ0sUcSpmYHwT9iHbIRP
	HCvUnCCa8fIom8eNalYQ8/LuIa5NRHWWmgl+WJX5aUgURp/q3jYvG6/cIQkE4/25
	17RGgB1DlN1SCCSumdqk7/wuSRq5urFPaJiTaP4auPpw9vzDxM9FJRTFdj3D/se1
	+t58/AZ7FTj8Rww00/TnPJwJOkbyqGPQZNRE9UZ6akoQULI8sjWQcvMF6MZjYf3Q
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ewjgsvkh6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Jun 2026 15:14:31 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65OF4dQE024622;
	Wed, 24 Jun 2026 15:14:30 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4ex7vyrxun-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Jun 2026 15:14:30 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
	by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65OFETRN27263700
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 24 Jun 2026 15:14:30 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B6CDE58050;
	Wed, 24 Jun 2026 15:14:29 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B492458045;
	Wed, 24 Jun 2026 15:14:28 +0000 (GMT)
Received: from [9.67.85.162] (unknown [9.67.85.162])
	by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 24 Jun 2026 15:14:28 +0000 (GMT)
Message-ID: <436eeb18-1412-450f-a259-25356ddf80d1@linux.ibm.com>
Date: Wed, 24 Jun 2026 10:14:28 -0500
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
Subject: Re: [PATCH v2] powerpc/pseries/iommu: Add check for
 iommu_pseries_alloc_group()
To: Haoxiang Li <haoxiang_li2024@163.com>, maddy@linux.ibm.com,
        mpe@ellerman.id.au, npiggin@gmail.com, chleroy@kernel.org,
        kees@kernel.org
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <20260623142918.2287696-1-haoxiang_li2024@163.com>
Content-Language: en-US
From: Gaurav Batra <gbatra@linux.ibm.com>
In-Reply-To: <20260623142918.2287696-1-haoxiang_li2024@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI0MDEyMyBTYWx0ZWRfXxmGKkZGF4xYS
 kU8fnUjpbn52XXRhkRuuqS6RjhdC+7JIbGYtrqkeMGXaRkpdr9rf2IZKG7fRYJvLBzPpbRSeBJ9
 rDdWQ2nFit0dqU2wRyRrMkrXteghjJzhX5+fOAVl2DnHYwAaYgqelGgfjpznfIBtDB5Nob+TYv3
 ljq1ZIjf6aS4QQIu7zFVT4QnUKOqReB48LAwPsUTzZcKLAOssOJRV+Dv7Ub3PkUQjmXdmpc5qoQ
 SB7s+JkptmMJHo6UJ0t4Rv0u/k3Wc3rDlodubr912EL/Aj3BHbGjK5pjaOm8GBFn+/9OvDQ5rPb
 z59Icr1he1XCEZPlv2uRMs09ul0oF8rvY5JBD9Q9liou4Ndl74L1n2ZPOL8sp1EeA9OktxmRn0c
 Ys4LOS3wQPdQgCm7TfX/iYBhdsDK2Q==
X-Proofpoint-GUID: flGtOn1WRBYVN29zXUOI11fP-G6lZn_7
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI0MDEyMyBTYWx0ZWRfXyxxipmOxS/4S
 uKBHBRl1mJqLhGLi3EFTeibCpCs/qWVqzN+MyY1Z0c4GPZwvcQvtqq0fmcc+Xj1zLrc/UN0Gtvm
 hU9wDToWapX2QrFWZ5IDnroW8KzHLok=
X-Authority-Analysis: v=2.4 cv=I/lVgtgg c=1 sm=1 tr=0 ts=6a3bf457 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8
 a=Byx-y9mGAAAA:8 a=4F6sIWIm2fMPugnQaUsA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: tXfybc9ehgZ0LobV8aQfU-2UaXgFZ72l
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-24_03,2026-06-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 phishscore=0 spamscore=0 adultscore=0 bulkscore=0
 suspectscore=0 malwarescore=0 classifier=typeunknown authscore=0 authtc=
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.22.0-2606150000 definitions=main-2606240123

looks good

Reviewed-by: Gaurav Batra <gbatra@linux.ibm.com>

On 6/23/26 9:29 AM, Haoxiang Li wrote:
> Add check for the return value of iommu_pseries_alloc_group()
> to prevent potential null pointer dereferences.
>
> Signed-off-by: Haoxiang Li <haoxiang_li2024@163.com>
> ---
> - Changes in v2:
>    - Add check for other callsites. Thanks, Gaurav!
> ---
>   arch/powerpc/platforms/pseries/iommu.c | 12 ++++++++++++
>   1 file changed, 12 insertions(+)
>
> diff --git a/arch/powerpc/platforms/pseries/iommu.c b/arch/powerpc/platforms/pseries/iommu.c
> index 3e1f915fe4f6..d97bde96dd4d 100644
> --- a/arch/powerpc/platforms/pseries/iommu.c
> +++ b/arch/powerpc/platforms/pseries/iommu.c
> @@ -684,6 +684,9 @@ static void pci_dma_bus_setup_pSeries(struct pci_bus *bus)
>   	pci->phb->dma_window_base_cur = 0x8000000ul;
>   
>   	pci->table_group = iommu_pseries_alloc_group(pci->phb->node);
> +	if (!pci->table_group)
> +		return;
> +
>   	tbl = pci->table_group->tables[0];
>   
>   	iommu_table_setparms(pci->phb, dn, tbl);
> @@ -872,6 +875,9 @@ static void pci_dma_bus_setup_pSeriesLP(struct pci_bus *bus)
>   
>   	if (!ppci->table_group) {
>   		ppci->table_group = iommu_pseries_alloc_group(ppci->phb->node);
> +		if (!ppci->table_group)
> +			return;
> +
>   		tbl = ppci->table_group->tables[0];
>   
>   		iommu_table_setparms_common(tbl, ppci->phb->bus->number,
> @@ -909,6 +915,9 @@ static void pci_dma_dev_setup_pSeries(struct pci_dev *dev)
>   
>   		pr_debug(" --> first child, no bridge. Allocating iommu table.\n");
>   		PCI_DN(dn)->table_group = iommu_pseries_alloc_group(phb->node);
> +		if (!PCI_DN(dn)->table_group)
> +			return;
> +
>   		tbl = PCI_DN(dn)->table_group->tables[0];
>   		iommu_table_setparms(phb, dn, tbl);
>   
> @@ -1875,6 +1884,9 @@ static void pci_dma_dev_setup_pSeriesLP(struct pci_dev *dev)
>   	pci = PCI_DN(pdn);
>   	if (!pci->table_group) {
>   		pci->table_group = iommu_pseries_alloc_group(pci->phb->node);
> +		if (!pci->table_group)
> +			return;
> +
>   		tbl = pci->table_group->tables[0];
>   
>   		iommu_table_setparms_common(tbl, pci->phb->bus->number,

