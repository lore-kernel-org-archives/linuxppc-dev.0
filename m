Return-Path: <linuxppc-dev+bounces-25771-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC479C5CFDB
	for <linuxppc-dev@archiver.kernel.org>; Wed, 12 Aug 2026 11:31:53 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hKmY41BcQz3brC;
	Wed, 12 Aug 2026 21:31:52 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1786534312;
	cv=none; b=othfFJ0pbBMW2Y4QhasJhY2lPZqxtWt6Y3yqFlyxKNWD35n+heTNHzXEB3HSdlYjtd0OMLkJYe+kjuB9ERJGBp/Pb8JCiyUe05A/9mqvpp8hdEe7CInjvX70b701tiJTglVJ8yqJBSRygnbaNwAlK2WLvWeDxTurKHNfeJe4FqhxSjEdrXH3PApBQtqB8ieYUDUf+Ed1rpRSAPNaLWywF7yB5Ieldn0CTb/SdumEJmu4JtvjXG/Z9IF1CCC/LyR9d22Ie/burFSgxn6fijLH0QcwmFTX1tPdN7nxxH/+fnKzS2It/l19OmbuKUHVkef+7VqJaLoBagOG0OWgQAQ2eQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1786534312; c=relaxed/relaxed;
	bh=8R0bYt528y2mbivyUE1djUnRJwaalT2no2Rhah2uRgU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=OpquOqC3dKY7Pk4MLv/AjUufW1yeXhFSn+vqcEsJSTvrwzy5A5hwqOsUKvdybiyvkFcsfFYuJHR6IGbYg0E+F/DBOm/fuxUi3aXLP1g6NjZWx6PO/xhoUTEp+oMRtNSO1ocvlp9w3QUzuw0y5I1Smtk8MESFf8vJpov1jiUCCh3M7mPwfTUO+u6vzV8MYuxjvFOGnGijkjIH02IV+sXLzOgTkKwsAvLMK7sakp9BDxXhsJsjlTq13H4FvaG10xHbUXH68cILEpH9nHGHpszr+dbQAq7BhEQ4uNRV6aE4V51Pv0qWc+iPeqcSTpZUo5r+cfvwHQWtoCRvPc7u7nZVmw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cvoNZLlJ; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=aneesh.kumar@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cvoNZLlJ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=aneesh.kumar@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hKmY21Xmjz303K
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Aug 2026 21:31:50 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id A6A86601E0;
	Wed, 12 Aug 2026 11:31:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47EF91F000E9;
	Wed, 12 Aug 2026 11:31:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786534307;
	bh=8R0bYt528y2mbivyUE1djUnRJwaalT2no2Rhah2uRgU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=cvoNZLlJHW+4WOwYmevlbzkHPd7+Hbm9aTKER6k84q/k54rUk8JPdaAZtnxpqPlGh
	 WBUIWjAoHCAfBrKR2k6VIIpyHPdYitk67obZ1E3ZqU0mj2wcu8OQaFMwuWv1Gc8pRn
	 lGVsxICtRj7Pjsym6tNbO6xBq5x5xHZvdLvgC1NfkP22+Sr8s4yoJGpQaMusWOl6Wo
	 TTlkiBlem5dh19IDXWOSxSjsWWSi3+UQ7dGyxBjXjtEnOwL8mPkqaYjAH37SBlFd3b
	 ieLS7PaRTKrwBLLAqi7+ZIAmPBmvS1d+u3/VKi9x/bOU1+ohhYTujIU+5khH/iE0fR
	 GUsUxWVBsS1lQ==
X-Mailer: emacs 30.2 (via feedmail 11-beta-1 I)
From: Aneesh Kumar K.V <aneesh.kumar@kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev,
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
	linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <chleroy@kernel.org>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>, x86@kernel.org
Subject: Re: [RFC PATCH] dma: swiotlb: Size shared default pools for memory
 encryption
In-Reply-To: <anxEc8EHmJQywVI5@arm.com>
References: <20260811134056.756015-1-aneesh.kumar@kernel.org>
 <anxEc8EHmJQywVI5@arm.com>
Date: Wed, 12 Aug 2026 17:01:33 +0530
Message-ID: <yq5ah5kzinhm.fsf@kernel.org>
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

>
> I also wonder whether we could address Will's pKVM request not to
> allocate a bounce buffer once pKVM guests will start reporting
> CC_ATTR_GUEST_MEM_ENCRYPT. Some simple heuristic: if a
> restricted-dma-pool is advertised in DT (it will end up in
> rmem_swiotlb_setup()), skip resizing the default swiotlb. It's not
> perfect but the bounce buffer can be overridden on the command line.

I have a follow-up cleanup patch where I switch the swiotlb
initialization reason to a flag value. With that, we now have
SWIOTLB_INIT_CC_SHARED.

The challenge is that it is still not clear when pKVM would want to use
an unencrypted swiotlb pool for DMA bouncing. I would expect pKVM to
have some additional condition based on which it chooses either the
restricted-dma-pool or the default swiotlb pool.

Using the presence of a restricted-dma-pool to decide whether the
default swiotlb pool should be unencrypted is one option, but I am not
sure that is the right abstraction.

modified   arch/arm64/mm/init.c
@@ -342,7 +342,7 @@ void __init arch_mm_preinit(void)
 	bool cc_guest = is_realm_world();
 
 	if (cc_guest)
-		swiotlb_mark_default_cc_shared();
+		flags |= SWIOTLB_INIT_CC_SHARED;
 	else if (max_pfn > PFN_DOWN(arm64_dma_phys_limit))
 		flags |= SWIOTLB_INIT_ADDRESSING_LIMIT;
 
modified   arch/powerpc/mm/mem.c
@@ -289,9 +289,8 @@ void __init arch_mm_preinit(void)
 #ifdef CONFIG_SWIOTLB
 	if (is_secure_guest()) {
 		/* The host can access DMA buffers only through the SWIOTLB. */
-		swiotlb_mark_default_cc_shared();
 		ppc_swiotlb_enable = 1;
-		ppc_swiotlb_flags |= SWIOTLB_ANY;
+		ppc_swiotlb_flags |= SWIOTLB_INIT_CC_SHARED | SWIOTLB_ANY;
 	}
 
 	/*
modified   arch/s390/mm/init.c
@@ -163,12 +163,10 @@ static void __init pv_init(void)
 	if (!is_prot_virt_guest())
 		return;
 
-	swiotlb_mark_default_cc_shared();
-
 	virtio_set_mem_acc_cb(virtio_require_restricted_mem_acc);
 
 	/* make sure bounce buffers are shared */
-	swiotlb_init(SWIOTLB_VERBOSE);
+	swiotlb_init(SWIOTLB_VERBOSE | SWIOTLB_INIT_CC_SHARED);
 	swiotlb_update_mem_attributes();
 }
 
modified   arch/x86/mm/mem_encrypt.c
@@ -14,6 +14,7 @@
 #include <linux/mem_encrypt.h>
 #include <linux/virtio_anchor.h>
 
+#include <asm/iommu.h>
 #include <asm/sev.h>
 
 /* Override for DMA direct allocation check - ARCH_HAS_FORCE_DMA_UNENCRYPTED */
@@ -109,7 +110,7 @@ void __init mem_encrypt_setup_arch(void)
 		snp_fixup_e820_tables();
 
 	if (cc_platform_has(CC_ATTR_MEM_ENCRYPT))
-		swiotlb_mark_default_cc_shared();
+		x86_swiotlb_flags |= SWIOTLB_INIT_CC_SHARED;
 
 	if (!cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT))
 		return;
modified   include/linux/swiotlb.h
@@ -18,6 +18,8 @@ struct scatterlist;
 #define SWIOTLB_ANY	(1 << 1) /* allow any memory for the buffer */
 /* Initialize a default-sized pool for devices with limited DMA addressing. */
 #define SWIOTLB_INIT_ADDRESSING_LIMIT	(1 << 2)
+/* Initialize a shared default pool for confidential-computing systems. */
+#define SWIOTLB_INIT_CC_SHARED		(1 << 3)
 
 /*
  * Maximum allowable number of contiguous slabs to map,
@@ -191,7 +193,6 @@ void swiotlb_dev_init(struct device *dev);
 size_t swiotlb_max_mapping_size(struct device *dev);
 bool is_swiotlb_allocated(void);
 bool is_swiotlb_active(struct device *dev);
-void __init swiotlb_mark_default_cc_shared(void);
 void __init swiotlb_adjust_size(unsigned long size);
 phys_addr_t default_swiotlb_base(void);
 phys_addr_t default_swiotlb_limit(void);
@@ -231,10 +232,6 @@ static inline bool is_swiotlb_active(struct device *dev)
 	return false;
 }
 
-static inline void swiotlb_mark_default_cc_shared(void)
-{
-}
-
 static inline void swiotlb_adjust_size(unsigned long size)
 {
 }
modified   kernel/dma/swiotlb.c
@@ -373,11 +373,6 @@ static void __init *swiotlb_memblock_alloc(unsigned long nslabs,
 	return tlb;
 }
 
-void __init swiotlb_mark_default_cc_shared(void)
-{
-	io_tlb_default_mem.cc_shared = true;
-}
-
 static void __init swiotlb_adjust_cc_attributes(void)
 {
 	unsigned long size;
@@ -429,7 +424,7 @@ static bool __init swiotlb_should_init(unsigned int flags)
 	if (swiotlb_force_bounce)
 		return true;
 
-	if (io_tlb_default_mem.cc_shared)
+	if (flags & SWIOTLB_INIT_CC_SHARED)
 		return true;
 
 	return false;
@@ -451,6 +446,9 @@ void __init swiotlb_init_remap(unsigned int flags,
 	if (!swiotlb_should_init(flags))
 		return;
 
+	if (flags & SWIOTLB_INIT_CC_SHARED)
+		io_tlb_default_mem.cc_shared = true;
+
 	io_tlb_default_mem.force_bounce = swiotlb_force_bounce;
 
 #ifdef CONFIG_SWIOTLB_DYNAMIC

