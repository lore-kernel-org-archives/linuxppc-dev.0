Return-Path: <linuxppc-dev+bounces-16901-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 718E3E6816B
	for <linuxppc-dev@archiver.kernel.org>; Tue, 17 Feb 2026 13:05:51 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fFfyk0Thmz2xjP;
	Wed, 18 Feb 2026 00:05:50 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=210.118.77.11
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1771333549;
	cv=none; b=Ff5zRYlZdarHDev5al8rBNHmuaL5C6AvWw5mAZaori1GfIaD/A1/dAE0VCBMgGo1Wz0cl5uotqtmY2CdwYLNMXWM4WhZK8JMFgws1Iyz7sv9q0BNTTXvOOZXxbRFgRUHbp0xg3Rg7BuYE8KIR8Q9cRFdkzzOR9Ke+Ye1n9TvXGYqMzwfah9CQNJDSQxNHE15v1WjJLikH6VXP/sloRswll0xB6NRRd3MITZRQDiLPND24cyoSJznD2xsi3GhLFg7ZDq1Abh/yfC+MzmMag/I5SKejrDH/NagQPaJvMj8EUl/6m0/q+bq1C97lbL3+r0d8tYdQYFAOEvGQNbxMg4kXw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1771333549; c=relaxed/relaxed;
	bh=kPHvBI1Pan3M4iaidTIFZnbtqSz3AZ7jPYAHqyBo5u8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=B5f3AXPnoVHr77bHo6g0wo4axH07b5HDX0taaK1Xh1ZgYiUN+beiq0pvWrmycM6vQadv1Gk/DqkV86GKRStN13Piu3pqqDXhS0m5QL7/7wmaflWpsLDR4sBzVpSam4vSNaqJiDgs0Bz2VhhuMTam6RgMWoNPYyoTc0Gm2Lq9GNPWh5rlYZCb4aq3Ojo1kd1Bqww5vcj+WLrYF/eBLE4hTn0qb+/dP1CMEBJAEltX5t/yxEa6MHd+WNronlQ2m8YYkkAP3pPx3lu/VZeG1MyEaqlZPBbGZBxwRbbSESchclWFO5VmI7PfnxRMk3wmLScHRg9BNdMIghGqIJp05iIRCA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=samsung.com; dkim=pass (1024-bit key; unprotected) header.d=samsung.com header.i=@samsung.com header.a=rsa-sha256 header.s=mail20170921 header.b=qE2Na2wF; dkim-atps=neutral; spf=pass (client-ip=210.118.77.11; helo=mailout1.w1.samsung.com; envelope-from=m.szyprowski@samsung.com; receiver=lists.ozlabs.org) smtp.mailfrom=samsung.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=samsung.com header.i=@samsung.com header.a=rsa-sha256 header.s=mail20170921 header.b=qE2Na2wF;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=samsung.com (client-ip=210.118.77.11; helo=mailout1.w1.samsung.com; envelope-from=m.szyprowski@samsung.com; receiver=lists.ozlabs.org)
X-Greylist: delayed 573 seconds by postgrey-1.37 at boromir; Wed, 18 Feb 2026 00:05:46 AEDT
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fFfyf4Bn6z2xJF
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Feb 2026 00:05:44 +1100 (AEDT)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20260217125600euoutp01e702ba17a82df7a26cb54abe09518e80~VCfFtKJNi2750327503euoutp01K;
	Tue, 17 Feb 2026 12:56:00 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20260217125600euoutp01e702ba17a82df7a26cb54abe09518e80~VCfFtKJNi2750327503euoutp01K
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1771332961;
	bh=kPHvBI1Pan3M4iaidTIFZnbtqSz3AZ7jPYAHqyBo5u8=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=qE2Na2wFoGobnNwByWm49yVZUxp6ZyqvGOKUcTxQmO/J9J6nwYoOSde40k3tzupbf
	 5drCH58ib86rmTAuEFK3Dh2gBz0w2T0sLKmgAdsu5bu3cX1d1C762Ho+VBd2ZtAcrr
	 Rpa2eUVwXatWI/hNEoqzx/baF+s1uCvrB4JykOMY=
Received: from eusmtip1.samsung.com (unknown [203.254.199.221]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20260217125600eucas1p2f5a7aaf272ec1e8419eb4f30114ae4c0~VCfFifkBN0465704657eucas1p2k;
	Tue, 17 Feb 2026 12:56:00 +0000 (GMT)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20260217125557eusmtip157747204999f9293afbbfbea0aadd349~VCfCuB9mO1169311693eusmtip1R;
	Tue, 17 Feb 2026 12:55:57 +0000 (GMT)
Message-ID: <7131d609-b083-4264-818a-21de38c1c3ed@samsung.com>
Date: Tue, 17 Feb 2026 13:55:56 +0100
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
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH v5 11/14] sparc: Use physical address DMA mapping
To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, Leon
	Romanovsky <leon@kernel.org>, Robin Murphy <robin.murphy@arm.com>, Russell
	King <linux@armlinux.org.uk>, Juergen Gross <jgross@suse.com>, Stefano
	Stabellini <sstabellini@kernel.org>, Oleksandr Tyshchenko
	<oleksandr_tyshchenko@epam.com>, Richard Henderson
	<richard.henderson@linaro.org>, Matt Turner <mattst88@gmail.com>, Thomas
	Bogendoerfer <tsbogend@alpha.franken.de>, "James E.J. Bottomley"
	<James.Bottomley@HansenPartnership.com>, Helge Deller <deller@gmx.de>,
	Madhavan Srinivasan <maddy@linux.ibm.com>, Michael Ellerman
	<mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, Christophe Leroy
	<christophe.leroy@csgroup.eu>, Geoff Levand <geoff@infradead.org>, "David S.
 Miller" <davem@davemloft.net>, Andreas Larsson <andreas@gaisler.com>, Thomas
	Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav
	Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, xen-devel@lists.xenproject.org,
	linux-alpha@vger.kernel.org, linux-mips@vger.kernel.org,
	linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, sparclinux
	<sparclinux@vger.kernel.org>
Content-Language: en-US
From: Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <e294484787a5032c531dcd40071b22362bddcad4.camel@physik.fu-berlin.de>
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20260217125600eucas1p2f5a7aaf272ec1e8419eb4f30114ae4c0
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20260217123216eucas1p2d74189a3cdf08e9301bebf1840491364
X-EPHeader: CA
X-CMS-RootMailID: 20260217123216eucas1p2d74189a3cdf08e9301bebf1840491364
References: <20251015-remove-map-page-v5-0-3bbfe3a25cdf@kernel.org>
	<20251015-remove-map-page-v5-11-3bbfe3a25cdf@kernel.org>
	<CGME20260217123216eucas1p2d74189a3cdf08e9301bebf1840491364@eucas1p2.samsung.com>
	<e294484787a5032c531dcd40071b22362bddcad4.camel@physik.fu-berlin.de>

On 17.02.2026 13:27, John Paul Adrian Glaubitz wrote:
> On Wed, 2025-10-15 at 12:12 +0300, Leon Romanovsky wrote:
>> From: Leon Romanovsky <leonro@nvidia.com>
>>
>> Convert sparc architecture DMA code to use .map_phys callback.
>>
>> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
>> ---
>>   arch/sparc/kernel/iommu.c     | 30 +++++++++++++++++-----------
>>   arch/sparc/kernel/pci_sun4v.c | 31 ++++++++++++++++++-----------
>>   arch/sparc/mm/io-unit.c       | 38 ++++++++++++++++++-----------------
>>   arch/sparc/mm/iommu.c         | 46 ++++++++++++++++++++++---------------------
>>   4 files changed, 82 insertions(+), 63 deletions(-)
>>
>> diff --git a/arch/sparc/kernel/iommu.c b/arch/sparc/kernel/iommu.c
>> index da0363692528..46ef88bc9c26 100644
>> --- a/arch/sparc/kernel/iommu.c
>> +++ b/arch/sparc/kernel/iommu.c
>> @@ -260,26 +260,35 @@ static void dma_4u_free_coherent(struct device *dev, size_t size,
>>   		free_pages((unsigned long)cpu, order);
>>   }
>>   
>> -static dma_addr_t dma_4u_map_page(struct device *dev, struct page *page,
>> -				  unsigned long offset, size_t sz,
>> -				  enum dma_data_direction direction,
>> +static dma_addr_t dma_4u_map_phys(struct device *dev, phys_addr_t phys,
>> +				  size_t sz, enum dma_data_direction direction,
>>   				  unsigned long attrs)
>>   {
>>   	struct iommu *iommu;
>>   	struct strbuf *strbuf;
>>   	iopte_t *base;
>>   	unsigned long flags, npages, oaddr;
>> -	unsigned long i, base_paddr, ctx;
>> +	unsigned long i, ctx;
>>   	u32 bus_addr, ret;
>>   	unsigned long iopte_protection;
>>   
>> +	if (unlikely(attrs & DMA_ATTR_MMIO))
>> +		/*
>> +		 * This check is included because older versions of the code
>> +		 * lacked MMIO path support, and my ability to test this path
>> +		 * is limited. However, from a software technical standpoint,
>> +		 * there is no restriction, as the following code operates
>> +		 * solely on physical addresses.
>> +		 */
>> +		goto bad_no_ctx;
>> +
>>   	iommu = dev->archdata.iommu;
>>   	strbuf = dev->archdata.stc;
>>   
>>   	if (unlikely(direction == DMA_NONE))
>>   		goto bad_no_ctx;
>>   
>> -	oaddr = (unsigned long)(page_address(page) + offset);
>> +	oaddr = (unsigned long)(phys_to_virt(phys));
>>   	npages = IO_PAGE_ALIGN(oaddr + sz) - (oaddr & IO_PAGE_MASK);
>>   	npages >>= IO_PAGE_SHIFT;
>>   
>> @@ -296,7 +305,6 @@ static dma_addr_t dma_4u_map_page(struct device *dev, struct page *page,
>>   	bus_addr = (iommu->tbl.table_map_base +
>>   		    ((base - iommu->page_table) << IO_PAGE_SHIFT));
>>   	ret = bus_addr | (oaddr & ~IO_PAGE_MASK);
>> -	base_paddr = __pa(oaddr & IO_PAGE_MASK);
>>   	if (strbuf->strbuf_enabled)
>>   		iopte_protection = IOPTE_STREAMING(ctx);
>>   	else
>> @@ -304,8 +312,8 @@ static dma_addr_t dma_4u_map_page(struct device *dev, struct page *page,
>>   	if (direction != DMA_TO_DEVICE)
>>   		iopte_protection |= IOPTE_WRITE;
>>   
>> -	for (i = 0; i < npages; i++, base++, base_paddr += IO_PAGE_SIZE)
>> -		iopte_val(*base) = iopte_protection | base_paddr;
>> +	for (i = 0; i < npages; i++, base++, phys += IO_PAGE_SIZE)
>> +		iopte_val(*base) = iopte_protection | phys;

'base_paddr' was aligned to start of a page before this patch, while 
'phys' includes the offset within a page.


Could You check if the following change fixes the issue?

diff --git a/arch/sparc/kernel/iommu.c b/arch/sparc/kernel/iommu.c
index 46ef88bc9c26..edb0ffb21e2f 100644
--- a/arch/sparc/kernel/iommu.c
+++ b/arch/sparc/kernel/iommu.c
@@ -312,6 +312,7 @@ static dma_addr_t dma_4u_map_phys(struct device 
*dev, phys_addr_t phys,
         if (direction != DMA_TO_DEVICE)
                 iopte_protection |= IOPTE_WRITE;

+       phys -= offset_in_page(phys);
         for (i = 0; i < npages; i++, base++, phys += IO_PAGE_SIZE)
                 iopte_val(*base) = iopte_protection | phys;

 >> ...

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland


