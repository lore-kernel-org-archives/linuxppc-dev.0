Return-Path: <linuxppc-dev+bounces-20627-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6249CD342F
	for <linuxppc-dev@archiver.kernel.org>; Fri,  8 May 2026 17:04:47 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gBwTV29B5z2xfR;
	Sat, 09 May 2026 03:04:46 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1778259886;
	cv=none; b=gF40KJX7PRhtzJBzwkNvJqNap/RA8D1NbVxuMiqw2UYQNORJmdHCpW95IFeittaGkAKWOZA8NsWGE2he6/wvXuJt5olzip1BAvXkRmZPGgFRk1jynwx8SlrUhMxnI6AYtR/oCZ+IvJ/t+/Re8gRu8pQ1dnry1b9eWaE26w7ORPk/5o/vL0NjLge9LmImU8Z6LS0n+ptV3IIcV6a7syiD1/s1rK4dScMXTbjN8UdyJfa/PvK6JbhjT3CYR0LbsscEh8eqbGibS2SUHFl4PKGukvSASm80VYElfvxTfEvQarN93St8hExb3NR0bxbb4+yKXcuDwjRjiOi1lJf+N0ge3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1778259886; c=relaxed/relaxed;
	bh=pm01mJ4K62FdYynCNdzqL8WBTVGf1UC2lpHxGfSg6+g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=P6WExwobv9hLV/ALwPq/MZgN+vQD06ENkaRdG+4uxXslXnLg2xaUaGedy0cGiDgP7owz7loKSqLPBacG1/N5NiVZJ9oDRG5whqVFPjyJEtUgMioOjwGR+qefovUgwDhmg4kXJ/I5FG3VhH7OAzIrlw1vAsbta2paeh+5CFRA/LteWba2/55N+kKw0Ue7KxP718gYOtT6JCIwjUm8eTYXOquYMBO+E083uiWGYKEjRqay0bxjsZ8ocVkEP1gGbWE83Q93+VSUCqLPgfkr66jMrVDT0cgKoABlue9MYz3oYaIqZcZWmEk/7CicVFnm4L3RlJcOpziooDfhoZ/L+wRq9A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=sNDpbiXk; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=harshpb@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=sNDpbiXk;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=harshpb@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gBwTS6nznz2xdb
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 09 May 2026 03:04:44 +1000 (AEST)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 648DCWs12752196
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 8 May 2026 17:04:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=pm01mJ
	4K62FdYynCNdzqL8WBTVGf1UC2lpHxGfSg6+g=; b=sNDpbiXkX7MiRy1slxQFT6
	hcECKSrXRBkTQGWOrTIkpFCuVCObjHLeLA6guB/CMNXlId/Oiy1LeGwOUpx7F0ov
	CInfTZ6lZ1gfbT0NwD2Vnkz8flYE7OZEhtrugZ3ouX5YTTTrHCvAjT84ppRMkBf0
	vOOWWr2NLAshyw/OqNm6lfV42POvkWrkE+Kn1jOxf2sqRn9CevKaszrwdVsBleN2
	nkp5m5dYvUqS4sxulCFD5AovoIoqLq+Cm+ognlr8LE7ZIJhY+ECdhg5tN3UhMBvC
	vEzGsESV/NO/YLRjef6Vaws5UGIXjNEzEqrJzNqnwNRUZp+KplNUpUxQvK43uN9w
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dw9x54svq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 08 May 2026 17:04:41 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 648GsZo7000813;
	Fri, 8 May 2026 17:04:40 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4dwuywh7bv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 08 May 2026 17:04:40 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 648H4BYI29098502
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 8 May 2026 17:04:11 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C8A1F58066;
	Fri,  8 May 2026 17:04:38 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1757D5804B;
	Fri,  8 May 2026 17:04:35 +0000 (GMT)
Received: from [9.124.210.81] (unknown [9.124.210.81])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  8 May 2026 17:04:34 +0000 (GMT)
Message-ID: <bef91e40-8fdf-4f22-8dfa-6936eee3d671@linux.ibm.com>
Date: Fri, 8 May 2026 22:34:32 +0530
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
Subject: Re: [PATCH v2] powerpc/pseries/iommu: export DMA window data to user
 space
Content-Language: en-GB
To: Gaurav Batra <gbatra@linux.ibm.com>, maddy@linux.ibm.com
Cc: linuxppc-dev@lists.ozlabs.org, sbhat@linux.ibm.com, vaibhav@linux.ibm.com,
        ritesh.list@gmail.com, Brian King <brking@linux.ibm.com>
References: <20260507180646.40356-1-gbatra@linux.ibm.com>
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
In-Reply-To: <20260507180646.40356-1-gbatra@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA4MDE2NiBTYWx0ZWRfX2Sg+jD2SX/cA
 iOToB5UP1mWl9i7vok3i6EWrbKTesFoyBN46NHa3pFbwXP8wos9YB6trjqim5Gq5hG0fWygAr3P
 HWikaDgKt2XmEKbRxBxGMSCRTCQGvp9RCmdMfUXYtSTj0UaHIm62K1EYIBH2beHxCOaUJj3AeGr
 TyNiSs8TPwvqGNns01lFUfRKrV6WDeJQpkDZNrgUBw/BC4WSpgzLr3/SqfWPFMmaCcGHyxI6D1C
 GpAd2UO+BG2Z2Ix+hlJ2w/HiY9atXv7cqROeZCe1qnducJcDlg+fgmYq91firvAHUdYl5HQNv17
 97PfqnY0cMWOPdu514reYq8wQVJvIhKmaHnzh0Tl/YJVA6Gx5X0YATNBmtm33Ryftejt/3S8GYK
 +UdTJsz/6BPSO06KtQ3BqCh35iRIfOvXLHKdsb5Xti4rLvHTtivZLd8TvX4r8wmqMmCbNYX4t8J
 Zw88oI2CJL4aSaU/v4Q==
X-Proofpoint-ORIG-GUID: N-w6shWmNW7h0247JtU7U4cjaOXxQccy
X-Proofpoint-GUID: 78yJT5ymDAA-rlOniv7ba1K8cgUQeYTs
X-Authority-Analysis: v=2.4 cv=W7UIkxWk c=1 sm=1 tr=0 ts=69fe17a9 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=f7IdgyKtn90A:10
 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22
 a=VnNF1IyMAAAA:8 a=voM4FWlXAAAA:8 a=F4FAZSZcPPoyCp31FBkA:9 a=QEXdDO2ut3YA:10
 a=IC2XNlieTeVoXbcui8wp:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-07_02,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 lowpriorityscore=0 malwarescore=0
 suspectscore=0 spamscore=0 clxscore=1015 phishscore=0 bulkscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2605080166

Hi Gaurav,

On 07/05/26 11:36 pm, Gaurav Batra wrote:
> Export PowerPC DMA window information (both default 2GB and Dynamic
> larger window) to user space via sysfs. Each of these DMA windows has
> attributes like size of the window, page size backing the window, mode,
> etc. Each of these atributes is exported for user space consumption as a
> file.
> 
> PowerPC Host Bridge (PHB) can have multiple devices/functions sharing
> the same DMA window. For each PHB, iommu registration creates an iommu
> device under "/sys/devices/virtual/iommu".
> 
> These devices will have 2 groups created to export Default and DDW
> attributes.
> 
> Reviewed-by: Brian King <brking@linux.ibm.com>
> Reviewed-by: Vaibhav Jain <vaibhav@linux.ibm.com>
> Reviewed-by: Shivaprasad G Bhat <sbhat@linux.ibm.com>

I do not see R-b tags provided on the list after review comments.
Not sure if I am missing the email or were these provided privately ?
Sharing some review comments inline below ..

> Signed-off-by: Gaurav Batra <gbatra@linux.ibm.com>
> ---
> V1 -> V2 change log:
> 
> 1. Shiva: "weight" the it_map for the bitmap. This avoids using an extra
>     counter in the table. Please look into how iommu_debugfs_weight_get()
>     does this
> 
>     Response: Incorporated changes
> 
> 2. Vaibhav: If the DMA window is not available, show function should just
>     return ENOENT so that userspace know the error instantly instead of
>     having to parse the sysfs contents.
> 
>     Response: Incorporated changes, returning ENODATA
> 
> 3. Vaibhav: All the show functions have similar template. Please convert
>     them to macros expansion to reduce code volume.
> 
>     Response: Incorporated changes
> 
> 4. Vaibhav: These new attributes are PSeries specific but they are being
>     setup in ppc generic iommu code at arch/powerpc/kernel/iommu.c. Can
>     you move these attributes to arch/powerpc/platforms/pseries/iommu.c
> 
>     Response: I have split the attributes and moved them to pseries specific
>     files. The original group "spapr-tce-iommu", is moved to PowerNV code
>     base to retain the legacy functionality.
> 
>     I tested the changes both on Pseries and PowerNV.
> 
> 5. Vaibhav: It would be better to use function iommu_table_inuse_tces() as
>     a callback in iommu_table_ops which can be implemented by pseries and
>     powernv code differently.
> 
>     Response: the function is no longer needed after changes in #1
> 
> 6. Vaibhav: Since sysfs is ABI can you propose appropriate entries under
>     Documentation/ABI/testing
> 
>     Response: Added documentation
> 
>   ...sfs-devices-virtual-iommu-dma_window_attrs |  21 ++
>   .../arch/powerpc/dma_window_attributes.rst    |  65 +++++
>   arch/powerpc/include/asm/pci-bridge.h         |   4 +
>   arch/powerpc/kernel/iommu.c                   |  16 +-
>   arch/powerpc/platforms/powernv/pci-ioda.c     |  16 ++
>   arch/powerpc/platforms/pseries/iommu.c        | 261 ++++++++++++++++++
>   arch/powerpc/platforms/pseries/pci_dlpar.c    |   2 +
>   arch/powerpc/platforms/pseries/pseries.h      |   1 +
>   arch/powerpc/platforms/pseries/setup.c        |   2 +
>   9 files changed, 373 insertions(+), 15 deletions(-)
>   create mode 100644 Documentation/ABI/testing/sysfs-devices-virtual-iommu-dma_window_attrs
>   create mode 100644 Documentation/arch/powerpc/dma_window_attributes.rst
> 
> diff --git a/Documentation/ABI/testing/sysfs-devices-virtual-iommu-dma_window_attrs b/Documentation/ABI/testing/sysfs-devices-virtual-iommu-dma_window_attrs
> new file mode 100644
> index 000000000000..18ba63874276
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-devices-virtual-iommu-dma_window_attrs
> @@ -0,0 +1,21 @@
> +What:       /sys/devices/virtual/iommu/<iommu-isolation>/spapr-tce-ddw/*
> +Date:       Oct 2025
> +Contact:    linuxppc-dev@lists.ozlabs.org
> +Description:    read only
> +    For each IOMMU isolation unit spapr-tce-ddw sub-directory provides
> +    attributes to query information related to the bigger Dynamic DMA
> +    window (DDW) in the PowerPC virtualized platforms.
> +
> +    See Documentation/arch/powerpc/dma_window_attributes.rst for more
> +    information.
> +
> +What:       /sys/devices/virtual/iommu/<iommu-isolation>/spapr-tce-dma/*
> +Date:       Oct 2025
> +Contact:    linuxppc-dev@lists.ozlabs.org
> +Description:    read only
> +    For each IOMMU isolation unit spapr-tce-dma sub-directory provides
> +    attributes to query information related to the default 2GB DMA
> +    window in the PowerPC virtualized platforms.
> +
> +    See Documentation/arch/powerpc/dma_window_attributes.rst for more
> +    information.
> diff --git a/Documentation/arch/powerpc/dma_window_attributes.rst b/Documentation/arch/powerpc/dma_window_attributes.rst
> new file mode 100644
> index 000000000000..8bd9aec8539d
> --- /dev/null
> +++ b/Documentation/arch/powerpc/dma_window_attributes.rst
> @@ -0,0 +1,65 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +=====================
> +DMA Window Attributes
> +=====================
> +
> +In PowerPC architecture there are 2 types of DMA windows -
> +
> +1. Default 2GB DMA window which is backed by 4K page size
> +2. A bigger Dynamic DMA Window (DDW) which is backed by larger page size
> +   (64K or 2MB)
> +
> +A dedicated device will have both the DMA windows instantiated but an SR-IOV
> +device will only have the bigger Dynamic DMA Window.
> +
> +The attributes of these 2 DMA windows are exported to user space via sysfs.
> +Each IOMMU isolation unit will have its directory created under
> +/sys/devices/virtual/iommu.
> +
> +As an exapmple, iommu-phb0001

s/exapmple/example ?

> +
> +Under each IOMMU isolation unit, there will be a group of attributes for
> +"Default 2GB DMA Window" and "Dynamic DMA Window" - spapr-tce-dma and
> +spapr-tce-ddw respectively.
> +
> +Attributes under each group
> +
> +spapr-tce-ddw:
> +direct_address  dynamic_address       dynamic_size  window_type
> +direct_size     dynamic_pages_mapped  page_size
> +
> +spapr-tce-dma:
> +dynamic_address  dynamic_pages_mapped  dynamic_size  page_size
> +
> +
> +The bigger Dynamic DMA Window is configured into pre-mapped and/or dynamically
> +allocated TCEs. If the DDW is in "Hybrid" mode, then both the Direct
> +(pre-mapped) and Dynamic part of the DMA window will have valid values. Hybrid
> +mode is valid only for SR-IOV devices.
> +
> +DMA Window properties:
> +
> +direct_address              Starting address of the pre-mapped DMA window
> +direct_size                 Size of the pre-mapped DMA Window
> +dynamic_address             Starting address of the dynamic allocations
> +dynamic_size                Size of the dynamic allocation window
> +dynamic_pages_mapped        Pages mapped for DMA by dynamic allocations
> +page_size                   Page size backing the DMA window
> +window_type                 Type of the DMA Window (Direct/Dynamic/Hybrid)
> +
> +
> +An example of DDW attributes for an SR-IOV device::
> +
> +    $ cd /sys/devices/virtual/iommu/iommu-phb0001/spapr-tce-ddw
> +
> +    $ grep . *
> +
> +    direct_address:0x800000000000000   <-- Starting addr of pre-mapped Window
> +    direct_size:137438953472           <-- Size of pre-mapped Window (128GB)
> +    dynamic_address:0x800002000000000  <-- Starting addr of Dynamic allocations
> +    dynamic_size:412316860416          <-- Size of dynamic allocation window (384GB)
> +    dynamic_pages_mapped:270           <-- Pages mapped by dynamic allocations
> +    page_size:2097152                  <-- DMA window page size (2MB)
> +    window_type:Hybrid                 <-- window has both pre-mapped and
> +                                           dynamic sections
> diff --git a/arch/powerpc/include/asm/pci-bridge.h b/arch/powerpc/include/asm/pci-bridge.h
> index 1dae53130782..9b09178aca5e 100644
> --- a/arch/powerpc/include/asm/pci-bridge.h
> +++ b/arch/powerpc/include/asm/pci-bridge.h
> @@ -124,6 +124,10 @@ struct pci_controller {
>   	resource_size_t dma_window_base_cur;
>   	resource_size_t dma_window_size;
>   
> +#if defined(CONFIG_PPC_PSERIES) || defined(CONFIG_PPC_POWERNV)
> +	const struct attribute_group **iommu_groups;
> +#endif
> +
>   #ifdef CONFIG_PPC64
>   	unsigned long buid;
>   	struct pci_dn *pci_data;
> diff --git a/arch/powerpc/kernel/iommu.c b/arch/powerpc/kernel/iommu.c
> index 0ce71310b7d9..d6242e3f77da 100644
> --- a/arch/powerpc/kernel/iommu.c
> +++ b/arch/powerpc/kernel/iommu.c
> @@ -1269,24 +1269,10 @@ static const struct iommu_ops spapr_tce_iommu_ops = {
>   	.device_group = spapr_tce_iommu_device_group,
>   };
>   
> -static struct attribute *spapr_tce_iommu_attrs[] = {
> -	NULL,
> -};
> -
> -static struct attribute_group spapr_tce_iommu_group = {
> -	.name = "spapr-tce-iommu",
> -	.attrs = spapr_tce_iommu_attrs,
> -};
> -
> -static const struct attribute_group *spapr_tce_iommu_groups[] = {
> -	&spapr_tce_iommu_group,
> -	NULL,
> -};
> -
>   void ppc_iommu_register_device(struct pci_controller *phb)
>   {
>   	iommu_device_sysfs_add(&phb->iommu, phb->parent,
> -				spapr_tce_iommu_groups, "iommu-phb%04x",
> +				phb->iommu_groups, "iommu-phb%04x",
>   				phb->global_number);
>   	iommu_device_register(&phb->iommu, &spapr_tce_iommu_ops,
>   				phb->parent);
> diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
> index 1c78fdfb7b03..0887f154955e 100644
> --- a/arch/powerpc/platforms/powernv/pci-ioda.c
> +++ b/arch/powerpc/platforms/powernv/pci-ioda.c
> @@ -2493,6 +2493,20 @@ static const struct pci_controller_ops pnv_npu_ocapi_ioda_controller_ops = {
>   	.shutdown		= pnv_pci_ioda_shutdown,
>   };
>   
> +static struct attribute *pnv_tce_iommu_attrs[] = {
> +	NULL,
> +};
> +
> +static struct attribute_group pnv_tce_iommu_group = {
> +	.name = "spapr-tce-iommu",
> +	.attrs = pnv_tce_iommu_attrs,
> +};
> +
> +static const struct attribute_group *pnv_tce_iommu_groups[] = {
> +	&pnv_tce_iommu_group,
> +	NULL,
> +};
> +
>   static void __init pnv_pci_init_ioda_phb(struct device_node *np,
>   					 u64 hub_id, int ioda_type)
>   {
> @@ -2697,6 +2711,8 @@ static void __init pnv_pci_init_ioda_phb(struct device_node *np,
>   		hose->controller_ops = pnv_pci_ioda_controller_ops;
>   	}
>   
> +	hose->iommu_groups = pnv_tce_iommu_groups;
> +
>   	ppc_md.pcibios_default_alignment = pnv_pci_default_alignment;
>   
>   #ifdef CONFIG_PCI_IOV
> diff --git a/arch/powerpc/platforms/pseries/iommu.c b/arch/powerpc/platforms/pseries/iommu.c
> index 5497b130e026..28be7a45761d 100644
> --- a/arch/powerpc/platforms/pseries/iommu.c
> +++ b/arch/powerpc/platforms/pseries/iommu.c
> @@ -56,6 +56,20 @@ enum {
>   	DDW_EXT_LIMITED_ADDR_MODE = 3
>   };
>   
> +/* used by sysfs when querying Dynamic/Default DMA Window data */
> +struct dma_win_data {
> +	u32     page_size;
> +	u64     direct_address;
> +	u64     direct_size;
> +	u64     dynamic_address;
> +	u64     dynamic_size;
> +	u32     dynamic_pages_mapped;
> +	char    window_type[15];
> +};
> +
> +#define SPAPR_SUCCESS		0
> +#define SPAPR_ERROR			-1
> +
>   static struct iommu_table *iommu_pseries_alloc_table(int node)
>   {
>   	struct iommu_table *tbl;
> @@ -837,6 +851,253 @@ static struct device_node *pci_dma_find(struct device_node *dn,
>   	return rdn;
>   }
>   
> +/* Get DDW information for the device */
> +static int gather_ddw_info(struct device *dev, struct dma_win_data *data)
> +{
> +	struct iommu_device *iommu;
> +	struct pci_controller *phb;
> +	struct device_node *dn;
> +	struct pci_dn *pci;
> +	const __be32 *prop = NULL;
> +	bool ddw_direct = false;
> +	bool found = false;
> +	struct iommu_table *tbl;
> +	u32 pgshift;
> +	struct dynamic_dma_window_prop *p;
> +
> +	memset(data, 0, sizeof(*data));
> +
> +	iommu = dev_get_drvdata(dev);
> +	phb = container_of(iommu, struct pci_controller, iommu);
> +	dn = phb->dn;
> +
> +	if (!dn)
> +		return SPAPR_ERROR;
> +
> +	pci = PCI_DN(dn);
> +	if (!pci || !pci->table_group)
> +		return SPAPR_ERROR;
> +

Should we also hold a dn ref with of_node_get(dn) before proceeding with 
of_get_property calls ?

> +	/* Find DDW */
> +	prop = of_get_property(dn, DIRECT64_PROPNAME, NULL);
> +	if (prop) {
> +		ddw_direct = true;
> +		found = true;
> +	} else {
> +		prop = of_get_property(dn, DMA64_PROPNAME, NULL);
> +		if (prop)
> +			found = true;
> +	}
> +
> +	/* NO DDW */
> +	if (!found)

.. then release dn ref here if not found ..

> +		return SPAPR_ERROR;
> +
> +	p = (struct dynamic_dma_window_prop *)prop;
> +
> +	pgshift = be32_to_cpu(p->tce_shift);
> +	if (pgshift != 0xc && pgshift != 0x10 && pgshift != 0x15)

Can we have macros for 0xc, 0x10 and 0x15 respectively ?

> +		data->page_size = 0;
> +	else
> +		data->page_size = 1 << pgshift;
> +
> +	/* Check if DDW has table associated with it. Having a table associated with
> +	 * DDW is indicative that is has some dynamic TCE allocations. In this case the
> +	 * DDW can be fully Dynamic or in Hybrid mode. For SR-IOV DDW is on index 0,
> +	 * for dedicated adapter on index 1.
> +	 */
> +	found = false;
> +	for (int i = 0; i < IOMMU_TABLE_GROUP_MAX_TABLES; ++i) {
> +		tbl = pci->table_group->tables[i];

Can another thread do a kfree(table_group) via 
iommu_pseries_free_group() during hotplug remove before we reach here?

> +
> +		if (tbl && tbl->it_index == be32_to_cpu(p->liobn)) {
> +			found = true;
> +			break;
> +		}
> +	}

Is it possible that another thread changes bitmap before we reach
bitmap_weight below ? If table is found, we may want to safely access
its bitamp (consider using tbl->largepool.lock?).

> +
> +	/* set the parameters depnding on the DDW type */

s/depnding/depending ?

> +	if (ddw_direct && found) {          /* Hybrid */
> +		data->direct_address = be64_to_cpu(p->dma_base);
> +		data->dynamic_size = (u64)(tbl->it_size << tbl->it_page_shift);
> +
> +		data->dynamic_address = data->direct_address
> +								+ (u64)(1UL << be32_to_cpu(p->window_shift))
> +								- data->dynamic_size;
> +
> +		data->direct_size = data->dynamic_address - data->direct_address;
> +		data->dynamic_pages_mapped = bitmap_weight(tbl->it_map, tbl->it_size);
> +
> +		sprintf(data->window_type, "%s", "Hybrid");

Preferably use snprintf for safety. I see two more instances below.

> +	} else if (ddw_direct && !found) {    /* Direct */
> +		data->direct_address = be64_to_cpu(p->dma_base);
> +		data->direct_size = (u64)(1UL << be32_to_cpu(p->window_shift));
> +
> +		sprintf(data->window_type, "%s", "Direct");
> +	} else {                              /* Dynamic */
> +		data->dynamic_address = be64_to_cpu(p->dma_base);
> +		data->dynamic_size = (u64)(1UL << be32_to_cpu(p->window_shift));
> +		data->dynamic_pages_mapped = bitmap_weight(tbl->it_map, tbl->it_size);
> +
> +		sprintf(data->window_type, "%s", "Dynamic");
> +	}
> +

.. release dn ref with of_node_put() before returning.

Similarly applicable for gather_dma_info() also.

> +	return SPAPR_SUCCESS;
> +}
> +
> +/* Get DDW information for the device */
> +static int gather_dma_info(struct device *dev, struct dma_win_data *data)
> +{
> +	struct iommu_device *iommu;
> +	struct pci_controller *phb;
> +	struct device_node *dn;
> +	struct pci_dn *pci;
> +	const __be32 *prop = NULL;
> +	struct iommu_table *tbl;
> +	unsigned long offset, size, liobn;
> +
> +	memset(data, 0, sizeof(*data));
> +
> +	iommu = dev_get_drvdata(dev);
> +	phb = container_of(iommu, struct pci_controller, iommu);
> +	dn = phb->dn;
> +
> +	if (!dn)
> +		return SPAPR_ERROR;
> +
> +	pci = PCI_DN(dn);
> +	if (!pci || !pci->table_group)
> +		return SPAPR_ERROR;
> +
> +	/* search for default DMA window */
> +	prop = of_get_property(dn, "ibm,dma-window", NULL);
> +
> +	if (!prop)
> +		return SPAPR_ERROR;
> +
> +	/* default DMA Window is always at index 0 */
> +	tbl = pci->table_group->tables[0];
> +	if (!tbl)
> +		return SPAPR_ERROR;
> +
> +	of_parse_dma_window(dn, prop, &liobn, &offset, &size);
> +
> +	data->dynamic_address = offset;
> +	data->dynamic_size = size;
> +	data->page_size = 1ULL << IOMMU_PAGE_SHIFT_4K;
> +	data->dynamic_pages_mapped = bitmap_weight(tbl->it_map, tbl->it_size);
> +
> +	return SPAPR_SUCCESS;
> +}
> +
> +#define DEVICE_SHOW_DDW(_name, _fmt)							\
> +ssize_t ddw_##_name##_show(struct device *dev,					\
> +								  struct device_attribute *attr,\
> +								  char *buf)					\
> +{																\
> +	int rc = 0;													\
> +	struct dma_win_data data;									\
> +																\
> +	rc = gather_ddw_info(dev, &data);							\
> +																\
> +	if (rc == SPAPR_SUCCESS)									\
> +		return sysfs_emit(buf, _fmt, data._name);				\
> +	else														\
> +		return -ENODATA;										\
> +}																\
> +
> +#define DEVICE_SHOW_DMA(_name, _fmt)							\
> +ssize_t dma_##_name##_show(struct device *dev,					\
> +								  struct device_attribute *attr,\
> +								  char *buf)					\
> +{																\
> +	int rc = 0;													\
> +	struct dma_win_data data;									\
> +																\
> +	rc = gather_dma_info(dev, &data);							\
> +																\
> +	if (rc == SPAPR_SUCCESS)									\
> +		return sysfs_emit(buf, _fmt, data._name);				\
> +	else														\
> +		return -ENODATA;										\
> +}																\
> +
> +static DEVICE_SHOW_DDW(direct_address, "%#llx\n");
> +static DEVICE_SHOW_DDW(direct_size, "%lld\n");
> +static DEVICE_SHOW_DDW(page_size, "%d\n");
> +static DEVICE_SHOW_DDW(window_type, "%s\n");
> +static DEVICE_SHOW_DDW(dynamic_address, "%#llx\n");
> +static DEVICE_SHOW_DDW(dynamic_size, "%lld\n");
> +static DEVICE_SHOW_DDW(dynamic_pages_mapped, "%d\n");
> +static DEVICE_SHOW_DMA(dynamic_address, "%#llx\n");
> +static DEVICE_SHOW_DMA(dynamic_size, "%lld\n");
> +static DEVICE_SHOW_DMA(page_size, "%d\n");
> +static DEVICE_SHOW_DMA(dynamic_pages_mapped, "%d\n");
> +
> +#define DEVICE_ATTR_DDW(_name)                              \
> +		struct device_attribute dev_attr_ddw_##_name =      \
> +			__ATTR(_name, 0444, ddw_##_name##_show, NULL)
> +#define DEVICE_ATTR_DMA(_name)                              \
> +		struct device_attribute dev_attr_dma_##_name =      \
> +		__ATTR(_name, 0444, dma_##_name##_show, NULL)
> +
> +static DEVICE_ATTR_DDW(direct_address);
> +static DEVICE_ATTR_DDW(direct_size);
> +static DEVICE_ATTR_DDW(page_size);
> +static DEVICE_ATTR_DDW(window_type);
> +static DEVICE_ATTR_DDW(dynamic_address);
> +static DEVICE_ATTR_DDW(dynamic_size);
> +static DEVICE_ATTR_DDW(dynamic_pages_mapped);
> +static DEVICE_ATTR_DMA(dynamic_address);
> +static DEVICE_ATTR_DMA(dynamic_size);
> +static DEVICE_ATTR_DMA(page_size);
> +static DEVICE_ATTR_DMA(dynamic_pages_mapped);
> +
> +static struct attribute *spapr_tce_ddw_attrs[] = {
> +	&dev_attr_ddw_direct_address.attr,
> +	&dev_attr_ddw_direct_size.attr,
> +	&dev_attr_ddw_page_size.attr,
> +	&dev_attr_ddw_window_type.attr,
> +	&dev_attr_ddw_dynamic_address.attr,
> +	&dev_attr_ddw_dynamic_size.attr,
> +	&dev_attr_ddw_dynamic_pages_mapped.attr,
> +	NULL,
> +};
> +
> +static struct attribute *spapr_tce_dma_attrs[] = {
> +	&dev_attr_dma_dynamic_address.attr,
> +	&dev_attr_dma_dynamic_size.attr,
> +	&dev_attr_dma_page_size.attr,
> +	&dev_attr_dma_dynamic_pages_mapped.attr,
> +	NULL,
> +};
> +
> +static struct attribute_group spapr_tce_ddw_group = {
> +	.name = "spapr-tce-ddw",
> +	.attrs = spapr_tce_ddw_attrs,
> +};
> +
> +static struct attribute_group spapr_tce_dma_group = {
> +	.name = "spapr-tce-dma",
> +	.attrs = spapr_tce_dma_attrs,
> +};
> +
> +static struct attribute *spapr_tce_iommu_attrs[] = {
> +	NULL,
> +};
> +
> +static struct attribute_group spapr_tce_iommu_group = {
> +	.name = "spapr-tce-iommu",
> +	.attrs = spapr_tce_iommu_attrs,
> +};
> +
> +const struct attribute_group *spapr_tce_iommu_groups[] = {
> +	&spapr_tce_iommu_group,
> +	&spapr_tce_ddw_group,
> +	&spapr_tce_dma_group,
> +	NULL,
> +};
> +
>   static void pci_dma_bus_setup_pSeriesLP(struct pci_bus *bus)
>   {
>   	struct iommu_table *tbl;
> diff --git a/arch/powerpc/platforms/pseries/pci_dlpar.c b/arch/powerpc/platforms/pseries/pci_dlpar.c
> index 8c77ec7980de..b457451a2814 100644
> --- a/arch/powerpc/platforms/pseries/pci_dlpar.c
> +++ b/arch/powerpc/platforms/pseries/pci_dlpar.c
> @@ -45,6 +45,8 @@ struct pci_controller *init_phb_dynamic(struct device_node *dn)
>   	pci_process_bridge_OF_ranges(phb, dn, 0);
>   	phb->controller_ops = pseries_pci_controller_ops;
>   
> +	phb->iommu_groups = spapr_tce_iommu_groups;
> +
>   	pci_devs_phb_init_dynamic(phb);
>   
>   	pseries_msi_allocate_domains(phb);
> diff --git a/arch/powerpc/platforms/pseries/pseries.h b/arch/powerpc/platforms/pseries/pseries.h
> index 3968a6970fa8..4cf0b7a4e96a 100644
> --- a/arch/powerpc/platforms/pseries/pseries.h
> +++ b/arch/powerpc/platforms/pseries/pseries.h
> @@ -128,4 +128,5 @@ struct iommu_group *pSeries_pci_device_group(struct pci_controller *hose,
>   					     struct pci_dev *pdev);
>   #endif
>   
> +extern const struct attribute_group *spapr_tce_iommu_groups[];
>   #endif /* _PSERIES_PSERIES_H */
> diff --git a/arch/powerpc/platforms/pseries/setup.c b/arch/powerpc/platforms/pseries/setup.c
> index 50b26ed8432d..4d877aae0560 100644
> --- a/arch/powerpc/platforms/pseries/setup.c
> +++ b/arch/powerpc/platforms/pseries/setup.c
> @@ -512,6 +512,8 @@ static void __init pSeries_discover_phbs(void)
>   		isa_bridge_find_early(phb);
>   		phb->controller_ops = pseries_pci_controller_ops;
>   
> +		phb->iommu_groups = spapr_tce_iommu_groups;
> +
>   		/* create pci_dn's for DT nodes under this PHB */
>   		pci_devs_phb_init_dynamic(phb);
>   
> base-commit: 192c0159402e6bfbe13de6f8379546943297783d


