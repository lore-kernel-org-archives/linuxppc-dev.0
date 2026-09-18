Return-Path: <linuxppc-dev+bounces-27664-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDA43C982D9
	for <linuxppc-dev@archiver.kernel.org>; Fri, 18 Sep 2026 07:05:52 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hmNv32jQyz2y2W;
	Fri, 18 Sep 2026 17:05:51 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789715151;
	cv=none; b=BbTfluzofu5uhCqzX8+n3N3ciYS0GpDXN+medSvztdlsK3qAfeeFUcPqRzchvN2gTdXi8g+JfC42lP+R6CjOvJzDskEHQjcler7yBnDNgPJPPBSohSb046trfQliKQ6T2ls48nQONkaRgzwOhvzMHFWiR5lQ2QJZ+dzhkjMxpNgZoQZEnEae6IBRSR7YgUWW17M1x1oeELy2OMQVlvQbYG7HjNwfTCFBjcPlf9/S6wG6afjsI+znMTJosBQOPhzo/M0M+wO5r6PoXi5MIJnTiinFaZbr3JW0dSY6TDtOMnvDLNU/rzJQgiCEWN7Ui8bE+ceyXq/EF1tKp26AW2oTKA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789715151; c=relaxed/relaxed;
	bh=8A8/O+7kImUGwyK+g6ktN1c/AodTX2n+ZCwskgpCIms=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=PPJKhVvd7RNlxUO4KKYPQ2/BvhvGFRam9E1n+FV+sgY/joCZmFB5J0sUzcSv4GPYrSSCOJYnuSkINYB0R2H/h2Xprs/SVjF1pIgaduyQbFzxZ5Rt2s4abYVvX7mtu8n/bqKpETYWsh5UIwjRs0nGQSXNUP1ddh96iLNVgg9j9pPHFzXrGiPjsoKJt/qaKl2/WDjLvPrylf0x1J2X2MQYu9Ebxfst4M4SC7KZpq0xhR4BcSzPsNCef7f8/0wBxgemv6XsGgFcGGcuT/wHeG6Uv47+coQTc2V1ql/8OA8imJe7Qc7RdY78Re7VIVloVCmb0ay6mnqmHriIh6Et8lQZuw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OhbOg+jM; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=aneesh.kumar@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OhbOg+jM;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=aneesh.kumar@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hmNv23DMHz2xYg
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Sep 2026 17:05:50 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 5E75A434A2;
	Fri, 18 Sep 2026 07:05:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F1671F000FF;
	Fri, 18 Sep 2026 07:05:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789715148;
	bh=8A8/O+7kImUGwyK+g6ktN1c/AodTX2n+ZCwskgpCIms=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=OhbOg+jMAJehO/c3Cb2LnBG1EHaNGxRwW7RCZKKxd0yM2OJJ2I84lIBozdzVSMMs3
	 +WM4nMhZGCgtmfbKF+3FYXPCXP1Fn4FFDij6NV9v6vIfhZZcrzdoad/ioZKk/OLmU7
	 U4BRT2idZTVWZWW7yJkZHO27YBS7pMiTfQDvZSfV9J/5lxNpLMBaC5tQN7SfTOadJv
	 2ad3QLFHUCi8MRnPkgfHrIBMEzM8OuOnv3XlsTimZnNOMHmO/2eVA2IOEf37ZK8x57
	 I3K6leIS7bYtSSIm8iuKjzuG67oG4h4B/uj+r42SlmJq9Rrpr4mu5D0Ji8r74G52jV
	 CtOj2OqWqqw7Q==
X-Mailer: emacs 31.1 (via feedmail 11-beta-1 I)
From: Aneesh Kumar K.V <aneesh.kumar@kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	Robin Murphy <robin.murphy@arm.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
	Steven Price <steven.price@arm.com>,
	Suzuki K Poulose <Suzuki.Poulose@arm.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Mostafa Saleh <smostafa@google.com>,
	Petr Tesarik <ptesarik@suse.com>,
	Alexey Kardashevskiy <aik@amd.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Xu Yilun <yilun.xu@linux.intel.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Russell King <linux@armlinux.org.uk>,
	Huacai Chen <chenhuacai@kernel.org>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Jiaxun Yang <jiaxun.yang@flygoat.com>,
	Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	linux-arm-kernel@lists.infradead.org, loongarch@lists.linux.dev,
	linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
	x86@kernel.org
Subject: Re: [PATCH v4 2/5] dma: swiotlb: Centralize minimal pool sizing
In-Reply-To: <aqwLiHQb71hU8cEy@arm.com>
References: <20260914070135.313337-1-aneesh.kumar@kernel.org>
 <20260914070135.313337-3-aneesh.kumar@kernel.org>
 <aqwLiHQb71hU8cEy@arm.com>
Date: Fri, 18 Sep 2026 12:35:33 +0530
Message-ID: <yq5a4ifn11ky.fsf@kernel.org>
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

Catalin Marinas <catalin.marinas@arm.com> writes:

> On Mon, Sep 14, 2026 at 12:31:31PM +0530, Aneesh Kumar K.V (Arm) wrote:
>> NOTE: We lose the RISC-V SWIOTLB_ANY setting in this patch. It will be
>> reinstated in a follow-up patch where we make SWIOTLB_ANY redundant.
>
> [...]
>
>> diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
>> index e0e4c103d603..734712230f35 100644
>> --- a/arch/riscv/mm/init.c
>> +++ b/arch/riscv/mm/init.c
>> @@ -165,31 +165,11 @@ static void print_vm_layout(void) { }
>>  
>>  void __init arch_mm_preinit(void)
>>  {
>> -	bool swiotlb = max_pfn > PFN_DOWN(dma32_phys_limit) &&
>> -		       memblock_start_of_DRAM() < dma32_phys_limit;
>>  	unsigned int swiotlb_flags = SWIOTLB_VERBOSE;
>>  #ifdef CONFIG_FLATMEM
>>  	BUG_ON(!mem_map);
>>  #endif /* CONFIG_FLATMEM */
>>  
>> -	if (IS_ENABLED(CONFIG_DMA_BOUNCE_UNALIGNED_KMALLOC) && !swiotlb &&
>> -	    dma_cache_alignment != 1) {
>> -		/*
>> -		 * No 32-bit DMA bouncing needed (either all DRAM is within
>> -		 * the 32-bit limit, or it all starts above it), but
>> -		 * kmalloc() buffers whose sizes are not cache-line-aligned
>> -		 * still require bouncing for non-coherent DMA.  Use
>> -		 * SWIOTLB_ANY so that the buffer can be allocated from high
>> -		 * memory when DRAM starts above dma32_phys_limit.  Allocate
>> -		 * ~1 MB per 1 GB of RAM.
>> -		 */
>> -		unsigned long size =
>> -			DIV_ROUND_UP(memblock_phys_mem_size(), 1024);
>> -		swiotlb_adjust_size(min(swiotlb_size_or_default(), size));
>> -		swiotlb = true;
>> -		swiotlb_flags |= SWIOTLB_ANY;
>> -	}
>
> Does it break the bisectability for risc-v? IIUC this undoes commit
> cfca5a48b03f until patch 5. Basically if there's no low memory and no
> SWIOTLB_ANY passed, memblock_alloc_low() will fail.
>

I mentioned this in the commit message. I can add the change below and
remove it in patch 5. 

modified   arch/riscv/mm/init.c
@@ -165,11 +165,27 @@ static void print_vm_layout(void) { }
 
 void __init arch_mm_preinit(void)
 {
+	bool swiotlb = max_pfn > PFN_DOWN(dma32_phys_limit) &&
+		       memblock_start_of_DRAM() < dma32_phys_limit;
 	unsigned int swiotlb_flags = SWIOTLB_VERBOSE;
 #ifdef CONFIG_FLATMEM
 	BUG_ON(!mem_map);
 #endif /* CONFIG_FLATMEM */
 
+	if (IS_ENABLED(CONFIG_DMA_BOUNCE_UNALIGNED_KMALLOC) && !swiotlb &&
+	    dma_cache_alignment != 1) {
+		/*
+		 * No 32-bit DMA bouncing needed (either all DRAM is within
+		 * the 32-bit limit, or it all starts above it), but
+		 * kmalloc() buffers whose sizes are not cache-line-aligned
+		 * still require bouncing for non-coherent DMA.  Use
+		 * SWIOTLB_ANY so that the buffer can be allocated from high
+		 * memory when DRAM starts above dma32_phys_limit.  Allocate
+		 * ~1 MB per 1 GB of RAM.
+		 */
+		swiotlb_flags |= SWIOTLB_ANY;
+	}
+
 	if ((max_pfn > PFN_DOWN(dma32_phys_limit)) &&
 	     (memblock_start_of_DRAM() < dma32_phys_limit))
 		swiotlb_flags |= SWIOTLB_INIT_ADDRESSING_LIMIT;


>
> I think we could preserve SWIOTLB_ANY until patch 5. Or it might be
> simpler to move patches 2 and 3 at the end (I haven't tried).
>
>> diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
>> index aa19e81ae544..90e0bfd0715c 100644
>> --- a/kernel/dma/swiotlb.c
>> +++ b/kernel/dma/swiotlb.c
>> @@ -304,6 +304,11 @@ unsigned long swiotlb_size_or_default(void)
>>  	return default_nslabs << IO_TLB_SHIFT;
>>  }
>>  
>> +static bool __init swiotlb_default_size_changed(void)
>> +{
>> +	return default_nslabs != IO_TLB_DEFAULT_SIZE >> IO_TLB_SHIFT;
>> +}
>
> I mentioned before in passing
> (https://lore.kernel.org/all/ann6noRzoPLL9kDY@arm.com/), if one sets
> swiotlb= to the default size, it will go unnoticed. I know it's an
> existing issue but we might as well fix it now with a bool that tells us
> the swiotlb size was forced/changed.
>

I will do this as an addtional patch

modified    kernel/dma/swiotlb.c
@@ -108,6 +108,7 @@
 
 static unsigned long default_nslabs = IO_TLB_DEFAULT_SIZE >> IO_TLB_SHIFT;
 static unsigned long default_nareas;
+static bool swiotlb_size_set __initdata;
 
 /**
  * struct io_tlb_area - IO TLB memory area descriptor
@@ -270,6 +271,7 @@
 		/* avoid tail segment of size < IO_TLB_SEGSIZE */
 		default_nslabs =
 			ALIGN(simple_strtoul(str, &str, 0), IO_TLB_SEGSIZE);
+		swiotlb_size_set = true;
 	}
 	if (*str == ',')
 		++str;
@@ -307,7 +309,7 @@
 
 static bool __init swiotlb_default_size_changed(void)
 {
-	return default_nslabs != IO_TLB_DEFAULT_SIZE >> IO_TLB_SHIFT;
+	return swiotlb_size_set;
 }
 
 void __init swiotlb_adjust_size(unsigned long size)



