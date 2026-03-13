Return-Path: <linuxppc-dev+bounces-18177-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53422107BCCA
	for <linuxppc-dev@archiver.kernel.org>; Fri, 13 Mar 2026 16:38:57 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fXVYW4PN1z3cK8;
	Sat, 14 Mar 2026 03:38:55 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773419935;
	cv=none; b=ae6sfImHW80O0FqGRF2M6KkbKLDke6qEqCngY3f3Irk72TJhWQ0e3GH9uUM5l4UpUA053aSCGHrb2zcT22QyvctlZsZrfsdI41axKmP/K6xBgNKWZy8qi9A27I+wyDTpcVYe3kAyLPARqrnzKcyxCd5RFWUYLyJxy1VJLAolsvprX8nOeIF5WEua/fI+D75d9RW5BaD+tDimPWVvzXZ0Nxmn1kVOen7bos/yTfU0LiDtpPo4N4jZEXASKEC69q1+3F2fSkRcJpAs7V6bPnvPm7ECFVeUy5ivdlEWNRAtJrgIgqdy24+rUmTnqXexIDfxUalPvEXM1KYJ/A2XSzCs0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773419935; c=relaxed/relaxed;
	bh=sZVRKOoNbzRedQ16dWvFOcSvHxqdg+P0so3nMcmn9ko=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=USeOjDAblCvSbsNa4dfHqBMEMo5cNSdGRXvrLBSuXQ1DY5bla1sO4ZwfVFCjI6HE8ZPFNu9iJliPO8KvO/PUlXTJktgMG9vOj+0r/IICrzroXzQuNmvv3xK358rCqQrAr4bBpdLLKTeN5ERZoEH6I3BhtxFTu+jSAbV0Y4d9U0sI4/EvwuCuQELNtyPh6mzylM3CAds+o305OKHMdTdEWeU2Wmbwh98Rce4WhZT0ny62djrzt4XJ+5iyN+t5OGeghLc9W68YeUljlyZOg4f/afGoX2U4Rlf2OVXB/+5WW7Vv3MX2hhJJL9jMwD/KXl1DyKvw1qQ97ItMhFJX3BLs0g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=dbUcypWk; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=vaibhav@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=dbUcypWk;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=vaibhav@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fXVYV3CBmz3cK4
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 14 Mar 2026 03:38:53 +1100 (AEDT)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62D5jENr2303586
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Mar 2026 16:38:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=sZVRKOoNbzRedQ16dWvFOcSvHxqdg+
	P0so3nMcmn9ko=; b=dbUcypWk/AXwXMJl8JUS3T6eIAUFBCvJqmb1TBiuzGC7xc
	OiZzbTm1gRTZ9wiAxSwwt9OuA70La2YrOfsqIuewpB7TtieRsJ/m8yEB+VJy+cy1
	sZp96R4x5xtwcSCe2dDsO8RfhFPiq1ikBREnUo/sGOsYPKVNj9X58L1uxc8pOtXZ
	LNfVWuyjChWdKCTfwGW9SeF8ZPfQPVgFrp++8CIABBeJqyfoZko24lDl8rljJ4qh
	YS/SwJmfAsZTv8Ezj8IXLa4K2t7qMFI+nEtQKOrrYtNFr1c5Qo2DycVmkrITuNoG
	UmHU37Ad+OKGB8nNCPAkVeSAe0TTL7aiX4glv+ow==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cuh960fhu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Mar 2026 16:38:51 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62DFXgia006110
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Mar 2026 16:38:50 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4cuha9qe0x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Mar 2026 16:38:50 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62DGclA430867956
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 13 Mar 2026 16:38:47 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DD4682004B;
	Fri, 13 Mar 2026 16:38:46 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 96D4E20040;
	Fri, 13 Mar 2026 16:38:44 +0000 (GMT)
Received: from vaibhav?linux.ibm.com (unknown [9.124.216.150])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with SMTP;
	Fri, 13 Mar 2026 16:38:44 +0000 (GMT)
Received: by vaibhav@linux.ibm.com (sSMTP sendmail emulation); Fri, 13 Mar 2026 22:08:43 +0530
From: Vaibhav Jain <vaibhav@linux.ibm.com>
To: Gaurav Batra <gbatra@linux.ibm.com>, maddy@linux.ibm.com
Cc: linuxppc-dev@lists.ozlabs.org, sbhat@linux.ibm.com,
        Gaurav Batra
 <gbatra@linux.ibm.com>,
        Brian King <brking@linux.ibm.com>
Subject: Re: [PATCH] powerpc/pseries/iommu: export DMA window data to user
 space
In-Reply-To: <20260224162405.32695-1-gbatra@linux.ibm.com>
References: <20260224162405.32695-1-gbatra@linux.ibm.com>
Date: Fri, 13 Mar 2026 22:08:43 +0530
Message-ID: <878qbvfzvw.fsf@vajain21.in.ibm.com>
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
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzEzMDEyOCBTYWx0ZWRfX30tfZWU0ql/M
 Lf0Xl+9+00XNsYwHqNckUzhv7rwvTzG9BQNOywCbABhwrdRSOlhqHXon60SvgV1E7QezwN0t1hi
 qOfCtVO8+wHt8oR5VFt8OyvHKTzuR8RU0CYZreDuls92S/xoGKfrn1GcdHhNipzYczGuo2j7Aav
 FmTkpeVunflw7msG2pXiwArWWkrk0TKYfpejrHr7WRlCY8932t7yG60YIfWb/HxBl+Pn+HWiePL
 kSgBtRSvylR/sp4ZyDT3DryQLG76Sl2D856Tc8asFiQ9Y/fn3oOs96Uch3KP/bNgzHf4z/33GIq
 tkdD95t3zEHu0Ckv+zraO+ev28qXa+xCGu3cfxBKLJluNGCffBYxo2GHL1o7geHGq0PC0mBe5wC
 v9uzldoCTMYR9PEhRTvvxWsT+l421+3YWHTtlrVoSNk+MF6ItB1ldNtMYuuFu+y5e8BTsjYhkdD
 UWMbgQ6CVoDrC63Shrw==
X-Authority-Analysis: v=2.4 cv=FowIPmrq c=1 sm=1 tr=0 ts=69b43d9b cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=pVnmnYfQqY12UWKZNMgA:9
X-Proofpoint-GUID: 308EbGY3qOZVNx8rVEiBQINxYkVxhebf
X-Proofpoint-ORIG-GUID: 308EbGY3qOZVNx8rVEiBQINxYkVxhebf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-13_02,2026-03-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1011 suspectscore=0 bulkscore=0 impostorscore=0
 lowpriorityscore=0 adultscore=0 phishscore=0 malwarescore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603130128

Hi Gaurav,

Thanks for the patch. Few review comments inline below:

Gaurav Batra <gbatra@linux.ibm.com> writes:

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
> Signed-off-by: Gaurav Batra <gbatra@linux.ibm.com>
> ---
>  .../arch/powerpc/dma_window_attributes.rst    |  65 +++++
>  arch/powerpc/include/asm/iommu.h              |  20 ++
>  arch/powerpc/kernel/iommu.c                   | 235 ++++++++++++++++++
>  arch/powerpc/platforms/pseries/iommu.c        | 156 ++++++++++++
>  4 files changed, 476 insertions(+)
>  create mode 100644 Documentation/arch/powerpc/dma_window_attributes.rst
>
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
Since sysfs is ABI can you propose appropriate entries under Documentation/ABI/testing

> diff --git a/arch/powerpc/include/asm/iommu.h b/arch/powerpc/include/asm/iommu.h
> index eafdd63cd6c4..e644c6e95301 100644
> --- a/arch/powerpc/include/asm/iommu.h
> +++ b/arch/powerpc/include/asm/iommu.h
> @@ -90,6 +90,7 @@ struct iommu_pool {
>  	unsigned long start;
>  	unsigned long end;
>  	unsigned long hint;
> +	unsigned long inuse;
>  	spinlock_t lock;
>  } ____cacheline_aligned_in_smp;
>
Review-comment from Shivaprasad:
Instead of  maintaining a counter in iommu_pool can you just 'weigh' the it_map
bitmap. That way you wont have to introduce a new counter. Please look
into how iommu_debugfs_weight_get() does this.


> @@ -319,5 +320,24 @@ extern unsigned long iommu_direction_to_tce_perm(enum dma_data_direction dir);
>  
>  extern const struct dma_map_ops dma_iommu_ops;
>  
> +/* used by sysfs when querying Dynamic/Default DMA Window data */
> +struct dma_win_data {
> +	u32     win_pgsize;
> +	u64     direct_addr;
> +	u64     direct_size;
> +	u64     dynamic_addr;
> +	u64     dynamic_size;
> +	u32     dynamic_tces_inuse;
> +	char    win_type[15];
> +};
> +
> +#define SPAPR_SUCCESS       0
> +#define SPAPR_NODMAWIN      -1
> +#define SPAPR_NODDWWIN      -2
> +#define SPAPR_ERROR         -3
> +
> +extern int gather_ddw_info(struct device *dev, struct dma_win_data *data);
> +extern int gather_dma_info(struct device *dev, struct dma_win_data *data);
> +
>  #endif /* __KERNEL__ */
>  #endif /* _ASM_IOMMU_H */
> diff --git a/arch/powerpc/kernel/iommu.c b/arch/powerpc/kernel/iommu.c
> index 0ce71310b7d9..e3cf3701dd6e 100644
> --- a/arch/powerpc/kernel/iommu.c
> +++ b/arch/powerpc/kernel/iommu.c
> @@ -339,6 +339,9 @@ static unsigned long iommu_range_alloc(struct device *dev,
>  	if (handle)
>  		*handle = end;
>  
> +	/* update use count */
> +	pool->inuse += npages;
> +

See the review comment above. This counter can be done away with.

>  	spin_unlock_irqrestore(&(pool->lock), flags);
>  
>  	return n;
> @@ -452,6 +455,7 @@ static void __iommu_free(struct iommu_table *tbl, dma_addr_t dma_addr,
>  	tbl->it_ops->clear(tbl, entry, npages);
>  
>  	spin_lock_irqsave(&(pool->lock), flags);
> +	pool->inuse -= npages;
Ditto as above

>  	bitmap_clear(tbl->it_map, free_entry, npages);
>  	spin_unlock_irqrestore(&(pool->lock), flags);
>  }
> @@ -759,6 +763,7 @@ struct iommu_table *iommu_init_table(struct iommu_table *tbl, int nid,
>  		p->start = tbl->poolsize * i;
>  		p->hint = p->start;
>  		p->end = p->start + tbl->poolsize;
> +		p->inuse = 0;
Ditto as above

>  	}
>  
>  	p = &tbl->large_pool;
> @@ -766,6 +771,7 @@ struct iommu_table *iommu_init_table(struct iommu_table *tbl, int nid,
>  	p->start = tbl->poolsize * i;
>  	p->hint = p->start;
>  	p->end = tbl->it_size;
> +	p->inuse = 0;
>  
>  	iommu_table_clear(tbl);
>  
> @@ -1269,6 +1275,233 @@ static const struct iommu_ops spapr_tce_iommu_ops = {
>  	.device_group = spapr_tce_iommu_device_group,
>  };
>  
> +static inline const char *dma_win_error(int err)
> +{
> +	switch (err) {
> +	case SPAPR_ERROR:
> +		return "Error";
> +	case SPAPR_NODMAWIN:
> +		return "No Default DMA Window Found";
> +	case SPAPR_NODDWWIN:
> +		return "No Dynamic DMA Window Found";
> +	default:
> +		return "Unknown Result";
> +	}
> +}
> +
> +static ssize_t ddw_direct_address_show(struct device *dev,
> +									   struct device_attribute *attr,
> +									   char *buf)
> +{
> +	int rc = 0;
> +	struct dma_win_data data;
> +
> +	rc = gather_ddw_info(dev, &data);
> +
> +	if (rc == SPAPR_SUCCESS)
> +		return sysfs_emit(buf, "%#llx\n", data.direct_addr);
> +	else
> +		return sysfs_emit(buf, "%s\n", dma_win_error(rc));
> +}
> +
Instead of returning success from these *_show() functions despite dma
window not available, can you just return an error (e.g ENOENT) so that
userspace know the error instantly instead of having to parse the sysfs
contents.



> +static ssize_t ddw_dynamic_address_show(struct device *dev,
> +										struct device_attribute *attr,
> +										char *buf)
> +{
> +	int rc = 0;
> +	struct dma_win_data data;
> +
> +	rc = gather_ddw_info(dev, &data);
> +
> +	if (rc == SPAPR_SUCCESS)
> +		return sysfs_emit(buf, "%#llx\n", data.dynamic_addr);
> +	else
> +		return sysfs_emit(buf, "%s\n", dma_win_error(rc));
> +}
> +
> +static ssize_t ddw_direct_size_show(struct device *dev,
> +									struct device_attribute *attr,
> +									char *buf)
> +{
> +	int rc = 0;
> +	struct dma_win_data data;
> +
> +	rc = gather_ddw_info(dev, &data);
> +
> +	if (rc == SPAPR_SUCCESS)
> +		return sysfs_emit(buf, "%lld\n", data.direct_size);
> +	else
> +		return sysfs_emit(buf, "%s\n", dma_win_error(rc));
> +}
> +
> +static ssize_t ddw_dynamic_size_show(struct device *dev,
> +									 struct device_attribute *attr,
> +									 char *buf)
> +{
> +	int rc = 0;
> +	struct dma_win_data data;
> +
> +	rc = gather_ddw_info(dev, &data);
> +
> +	if (rc == SPAPR_SUCCESS)
> +		return sysfs_emit(buf, "%lld\n", data.dynamic_size);
> +	else
> +		return sysfs_emit(buf, "%s\n", dma_win_error(rc));
> +}
> +
> +static ssize_t ddw_page_size_show(struct device *dev,
> +								  struct device_attribute *attr,
> +								  char *buf)
> +{
> +	int rc = 0;
> +	struct dma_win_data data;
> +
> +	rc = gather_ddw_info(dev, &data);
> +
> +	if (rc == SPAPR_SUCCESS)
> +		return sysfs_emit(buf, "%d\n", data.win_pgsize);
> +	else
> +		return sysfs_emit(buf, "%s\n", dma_win_error(rc));
> +}
> +
> +static ssize_t ddw_window_type_show(struct device *dev,
> +									struct device_attribute *attr,
> +									char *buf)
> +{
> +	int rc = 0;
> +	struct dma_win_data data;
> +
> +	rc = gather_ddw_info(dev, &data);
> +
> +	if (rc == SPAPR_SUCCESS)
> +		return sysfs_emit(buf, "%s\n", data.win_type);
> +	else
> +		return sysfs_emit(buf, "%s\n", dma_win_error(rc));
> +}
> +
> +static ssize_t ddw_dynamic_pages_mapped_show(struct device *dev,
> +											 struct device_attribute *attr,
> +											 char *buf)
> +{
> +	int rc = 0;
> +	struct dma_win_data data;
> +
> +	rc = gather_ddw_info(dev, &data);
> +
> +	if (rc == SPAPR_SUCCESS)
> +		return sysfs_emit(buf, "%d\n", data.dynamic_tces_inuse);
> +	else
> +		return sysfs_emit(buf, "%s\n", dma_win_error(rc));
> +}
> +
> +static ssize_t dma_dynamic_address_show(struct device *dev,
> +										struct device_attribute *attr,
> +										char *buf)
> +{
> +	int rc = 0;
> +	struct dma_win_data data;
> +
> +	rc = gather_dma_info(dev, &data);
> +
> +	if (rc == SPAPR_SUCCESS)
> +		return sysfs_emit(buf, "%#llx\n", data.dynamic_addr);
> +	else
> +		return sysfs_emit(buf, "%s\n", dma_win_error(rc));
> +}
> +
> +static ssize_t dma_dynamic_size_show(struct device *dev,
> +									 struct device_attribute *attr,
> +									 char *buf)
> +{
> +	int rc = 0;
> +	struct dma_win_data data;
> +
> +	rc = gather_dma_info(dev, &data);
> +
> +	if (rc == SPAPR_SUCCESS)
> +		return sysfs_emit(buf, "%lld\n", data.dynamic_size);
> +	else
> +		return sysfs_emit(buf, "%s\n", dma_win_error(rc));
> +}
> +
> +static ssize_t dma_page_size_show(struct device *dev,
> +								  struct device_attribute *attr,
> +								  char *buf)
> +{
> +	int rc = 0;
> +	struct dma_win_data data;
> +
> +	rc = gather_dma_info(dev, &data);
> +
> +	if (rc == SPAPR_SUCCESS)
> +		return sysfs_emit(buf, "%d\n", data.win_pgsize);
> +	else
> +		return sysfs_emit(buf, "%s\n", dma_win_error(rc));
> +}
> +
> +static ssize_t dma_dynamic_pages_mapped_show(struct device *dev,
> +											 struct device_attribute *attr,
> +											 char *buf)
> +{
> +	int rc = 0;
> +	struct dma_win_data data;
> +
> +	rc = gather_dma_info(dev, &data);
> +
> +	if (rc == SPAPR_SUCCESS)
> +		return sysfs_emit(buf, "%d\n", data.dynamic_tces_inuse);
> +	else
> +		return sysfs_emit(buf, "%s\n", dma_win_error(rc));
> +}
All the *_show() functions above share same template. Please convert
them to macros expansion below to reduce code volume.


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

These attributes are PSeries specific but they are being setup in ppc
generic iommu code at arch/powerpc/kernel/iommu.c . Can you move these
attributes to arch/powerpc/platforms/pseries/iommu.c

>  static struct attribute *spapr_tce_iommu_attrs[] = {
>  	NULL,
>  };
> @@ -1280,6 +1513,8 @@ static struct attribute_group spapr_tce_iommu_group = {
>  
>  static const struct attribute_group *spapr_tce_iommu_groups[] = {
>  	&spapr_tce_iommu_group,
> +	&spapr_tce_ddw_group,
> +	&spapr_tce_dma_group,
>  	NULL,
>  };
>  
> diff --git a/arch/powerpc/platforms/pseries/iommu.c b/arch/powerpc/platforms/pseries/iommu.c
> index 5497b130e026..5d04b50ae265 100644
> --- a/arch/powerpc/platforms/pseries/iommu.c
> +++ b/arch/powerpc/platforms/pseries/iommu.c
> @@ -837,6 +837,162 @@ static struct device_node *pci_dma_find(struct device_node *dn,
>  	return rdn;
>  }
>  
> +static unsigned long iommu_table_inuse_tces(struct iommu_table *tbl)
> +{
> +	struct iommu_pool *pool;
> +	unsigned long ntces = 0;
> +
> +	/* Number of TCEs in-use */
> +	for (int i = 0; i < tbl->nr_pools; i++) {
> +		pool = &tbl->pools[i];
> +		ntces += pool->inuse;
> +	}
> +
> +	pool = &tbl->large_pool;
> +	ntces += pool->inuse;
> +
> +	return ntces;
> +}
It would be better to use this functions as a callback in
iommu_table_ops which can be implemented by pseries and powernv code
differently.


> +
> +/* Get DDW information for the device */
> +int gather_ddw_info(struct device *dev, struct dma_win_data *data)
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
> +		return SPAPR_NODDWWIN;
> +
> +	p = (struct dynamic_dma_window_prop *)prop;
> +
> +	pgshift = be32_to_cpu(p->tce_shift);
> +	if (pgshift != 0xc && pgshift != 0x10 && pgshift != 0x15)
> +		data->win_pgsize = 0;
> +	else
> +		data->win_pgsize = 1 << pgshift;
> +
> +	/* Check if DDW has table associated with it. Having a table associated with
> +	 * DDW is indicative that is has some dynamic TCE allocations. In this case the
> +	 * DDW can be fully Dynamic or in Hybrid mode. For SR-IOV DDW is on index 0,
> +	 * for dedicated adapter on index 1.
> +	 */
> +	found = false;
> +	for (int i = 0; i < IOMMU_TABLE_GROUP_MAX_TABLES; ++i) {
> +		tbl = pci->table_group->tables[i];
> +
> +		if (tbl && tbl->it_index == be32_to_cpu(p->liobn)) {
> +			found = true;
> +			break;
> +		}
> +	}
> +
> +	/* set the parameters depnding on the DDW type */
> +	if (ddw_direct && found) {          /* Hybrid */
> +		data->direct_addr = be64_to_cpu(p->dma_base);
> +		data->dynamic_size = (u64)(tbl->it_size << tbl->it_page_shift);
> +
> +		data->dynamic_addr = data->direct_addr
> +								+ (u64)(1UL << be32_to_cpu(p->window_shift))
> +								- data->dynamic_size;
> +
> +		data->direct_size = data->dynamic_addr - data->direct_addr;
> +		data->dynamic_tces_inuse = iommu_table_inuse_tces(tbl);
> +
> +		sprintf(data->win_type, "%s", "Hybrid");
> +	} else if (ddw_direct && !found) {    /* Direct */
> +		data->direct_addr = be64_to_cpu(p->dma_base);
> +		data->direct_size = (u64)(1UL << be32_to_cpu(p->window_shift));
> +
> +		sprintf(data->win_type, "%s", "Direct");
> +	} else {                              /* Dynamic */
> +		data->dynamic_addr = be64_to_cpu(p->dma_base);
> +		data->dynamic_size = (u64)(1UL << be32_to_cpu(p->window_shift));
> +		data->dynamic_tces_inuse = iommu_table_inuse_tces(tbl);
> +
> +		sprintf(data->win_type, "%s", "Dynamic");
> +	}
> +
> +	return SPAPR_SUCCESS;
> +}
> +
> +/* Get DDW information for the device */
> +int gather_dma_info(struct device *dev, struct dma_win_data *data)
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
> +		return SPAPR_NODMAWIN;
> +
> +	/* default DMA Window is always at index 0 */
> +	tbl = pci->table_group->tables[0];
> +	if (!tbl)
> +		return SPAPR_ERROR;
> +
> +	of_parse_dma_window(dn, prop, &liobn, &offset, &size);
> +
> +	data->dynamic_addr = offset;
> +	data->dynamic_size = size;
> +	data->win_pgsize = 1ULL << IOMMU_PAGE_SHIFT_4K;
> +	data->dynamic_tces_inuse = iommu_table_inuse_tces(tbl);
> +
> +	return SPAPR_SUCCESS;
> +}
> +
>  static void pci_dma_bus_setup_pSeriesLP(struct pci_bus *bus)
>  {
>  	struct iommu_table *tbl;
>
> base-commit: 192c0159402e6bfbe13de6f8379546943297783d
> -- 
> 2.39.3
>

-- 
Cheers
~ Vaibhav

