Return-Path: <linuxppc-dev+bounces-27806-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A7F4C982DE
	for <linuxppc-dev@archiver.kernel.org>; Mon, 21 Sep 2026 06:37:31 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hpD6t03r5z30VM;
	Mon, 21 Sep 2026 16:37:26 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789972645;
	cv=none; b=AFw5RQxZY8I7FKjZ/p/DQmGYwAVXw8bPZwnkir0GnyMNV9np/FPIoxUZYw/8XM01kHYVwG70zEEts8mOyR/ItseEOkMFwaKp/3AY4ocf9LIPrgX8btVuMZ4Oev2TEOkjUVODw1guZsqNLzWO24QqerPh2tODJi3nIMRSFxiIYFJtA8u78p7Zipau8mZUH+bePpuonFuegM74yjZcC3oL/yUpt/rD4n8fLB6hFYp2imBomf7teK/J8mU2odIk4gc6wj7C7vyhEyCCOVvvzApdegBFcxqOoH7diRkxsn4LZzs/rd7MKvpx9lTEd1GE/fMpzRn13oDqTBPJYIEl0I+kAg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789972645; c=relaxed/relaxed;
	bh=fUCvSD545AGqyJgwYc/GicxI6hMF/t9YAHwv4jFcQak=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Uyq3mkX0Zzy+tkzEi1nZOS7kA+3chRZXZDzwGNzyRoTo73XLIHd9zsmev4n0ldRwV02yEAqL2IAre2b9ot1JkxIcGEjCFp5tM0WpH9w/oEZTzgnCD+c5+gN/Vjd7V37v3iyFQPJa7/of10Bs+XGx5a3+7iDyxd0zAc1Q7pJEOg31/0v5aguE7vKBEzjxxcD5q1RqWrTyMXJdc7RD2D1/BxF5exfxT8dmymy8UTjCscuawG/feBmpIEwEDrvk6y1UMUI9X6Y+cjss5Fsv2DyRAW8CqTjAiuxzMKcDsdUDTE8evL3jy+uvz1Tej5eR9gf9DdG8xq87l444Q7079UbP+g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ItCAWN/b; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=aneesh.kumar@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ItCAWN/b;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=aneesh.kumar@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hpD6r6bM5z30TL
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Sep 2026 16:37:24 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 8168F432D2;
	Mon, 21 Sep 2026 06:37:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D478A1F00899;
	Mon, 21 Sep 2026 06:37:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789972642;
	bh=fUCvSD545AGqyJgwYc/GicxI6hMF/t9YAHwv4jFcQak=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ItCAWN/bZKXBVisaCNeR/Zme4Bhaf0Rs8NXllfTFEHHwczMFALk0glxv5UtwQ2E1M
	 A8qyeQOutrpDF0GB73be/Dhp7UyA76pr93qyXCp/SBgZlJv/us4v9DB8544n2XS0LO
	 ZmWn9ULvzsnJeFZSk1zQIKMZHULsZm5+e33H56EKAvDfqjypjXEl/2I5CUNPqTuhyp
	 HsqgaPygQtGAqNarWWmiPfWWkx7rgJDdc80k6kWbQ6xkbHO9IRuLGCTv9wtfUK4+vT
	 TzOFDt8Xlr8T/WTX3YWtL/0YYcr0Rv2B1mevPDJnI55O5NaYEPvy5tlnh6c02ULEjb
	 PLdVf4MFo0IFg==
From: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>
To: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Will Deacon <will@kernel.org>,
	Marc Zyngier <maz@kernel.org>,
	Steven Price <steven.price@arm.com>,
	Suzuki K Poulose <Suzuki.Poulose@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
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
	linux-arm-kernel@lists.infradead.org,
	loongarch@lists.linux.dev,
	linux-mips@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org,
	x86@kernel.org
Subject: [PATCH v5 2/6] dma: swiotlb: Track whether the pool size was explicitly set
Date: Mon, 21 Sep 2026 12:06:24 +0530
Message-ID: <20260921063628.362078-3-aneesh.kumar@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260921063628.362078-1-aneesh.kumar@kernel.org>
References: <20260921063628.362078-1-aneesh.kumar@kernel.org>
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
Content-Transfer-Encoding: 8bit

swiotlb_adjust_size() must not override a pool size supplied through the
swiotlb= command-line parameter.

Currently, it determines whether a size was supplied by comparing
default_nslabs with IO_TLB_DEFAULT_SIZE. This fails when the user
explicitly requests the compiled-in default size, allowing the request
to be overwritten by automatic pool sizing.

Record whether swiotlb= supplied a numeric size and add
swiotlb_default_size_changed() to query that state.

Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
---
 kernel/dma/swiotlb.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index aa19e81ae544..8f86deb25be2 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -107,6 +107,7 @@ static struct io_tlb_mem io_tlb_default_mem;
 
 static unsigned long default_nslabs = IO_TLB_DEFAULT_SIZE >> IO_TLB_SHIFT;
 static unsigned long default_nareas;
+static bool swiotlb_size_set __initdata;
 
 /**
  * struct io_tlb_area - IO TLB memory area descriptor
@@ -269,6 +270,7 @@ setup_io_tlb_npages(char *str)
 		/* avoid tail segment of size < IO_TLB_SEGSIZE */
 		default_nslabs =
 			ALIGN(simple_strtoul(str, &str, 0), IO_TLB_SEGSIZE);
+		swiotlb_size_set = true;
 	}
 	if (*str == ',')
 		++str;
@@ -304,6 +306,11 @@ unsigned long swiotlb_size_or_default(void)
 	return default_nslabs << IO_TLB_SHIFT;
 }
 
+static bool __init swiotlb_default_size_changed(void)
+{
+	return swiotlb_size_set;
+}
+
 void __init swiotlb_adjust_size(unsigned long size)
 {
 	/*
@@ -311,7 +318,7 @@ void __init swiotlb_adjust_size(unsigned long size)
 	 * architectures such as those supporting memory encryption to
 	 * adjust/expand SWIOTLB size for their use.
 	 */
-	if (default_nslabs != IO_TLB_DEFAULT_SIZE >> IO_TLB_SHIFT)
+	if (swiotlb_default_size_changed())
 		return;
 
 	default_nslabs = swiotlb_aligned_nslabs(size);
-- 
2.43.0


