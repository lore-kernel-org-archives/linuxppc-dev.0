Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66D40606A321
	for <linuxppc-dev@archiver.kernel.org>; Thu, 26 Nov 2026 11:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=N6q86/Uu
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jZvFv0pkFz3bjg;
	Thu, 26 Nov 2026 22:19:31 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795691971;
	cv=none; b=Jjiq+v1FDEcuDII2QMZBTQHH8LDJ+ojpuo6Gy8cNiC/K/3A4uD2fhHiAJ5168Kv9ph3GGdEHR9O3qLUY6RhFx2dbi/P14z12Yb4jON8z6ckEO9sJZQAUqM3DU0B+rpBS1asOuVY0gOYxfIpwDp0eFft9ttBE5O+tq5p331+P8wamNITQlQCfTBcdgnP0HFhlQnOsCv4pLWc1dZadx6kkNJyF399m0G9fMANbycCPyIMAKwp3URcUyg/tsuRTyR5FL3TtxBvumzchI+OY7n/BI4JYC94GTNR4MXlgNU0B/F+6pN6vFbDv95EtpaaZgAdJ6HcQxfzOkCXV3VMhcCItPw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795691971; c=relaxed/relaxed;
	bh=9cPWUjHIPI7LtCSNqYYvsVdQiH3MUbUDgs7gRvdWWiI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IyGbudrOO0HbdvcH3T5JJ5NHuXKWUEFTTi/kIrP8+8UPNktBT5ECHB+SDFE2CExVr0VeayJZ3tcTDgAtWdMhc3GtamNCbM2THdf7jCajrsAESXup+3kNNbLkmERlLpDxaiYo/L6ANku0EhZadvh+VhynhAO+L8qTVZOMDFG1ZZrk/TBSDdX6J6oYsOe6i/q37xWv8NXmPaTsS2xx6MDVGLdetGRmF5YPGPtoD+AWRp2Hp4dbqxEobMtX3at3sNLgaZMDaym+xs3j+nzVF/Q4LoERqRwHCGY1zLysKTeKVE3Kjcutaotu+CHKyBs5rfJ4pSkVY0I1XI24o19AtyTX3A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=N6q86/Uu; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=rppt@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=N6q86/Uu;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=rppt@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jZvFt2VpHz3bjb
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Nov 2026 22:19:30 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 78CFA41794;
	Thu, 26 Nov 2026 11:19:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E38AB1F000C6;
	Thu, 26 Nov 2026 11:19:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795691968;
	bh=9cPWUjHIPI7LtCSNqYYvsVdQiH3MUbUDgs7gRvdWWiI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=N6q86/UuKdbMrBdtERhjhVFw0CbAJ4clSdTmUchWL6RgFVkEFE3mEFyjySuZ/PEVC
	 rUCd6Kq2go9A79rGKv9HgKqGK83C2clZ6aUkNYsA29a1Wo0vuxFjA1XROwrOgbp8xw
	 aOL75eZCeV1YUWJizVWuqhiRYrNriruvGv6qFzQV16MzEVZyn/pOqMpQzhn0BETYu1
	 Pw/fxf1OEmACLN0sONM/NixOOFWiGvIiGavxH1woaBbI73/XNSn75AXasiZb0IIKd0
	 HqmQAy3YxyZej2Z4YIxY5NMru1NNVtgYbxwMHf1zAj+lpMo3vwasqVbinhwzpc4VDC
	 dZfOgF0XejigQ==
From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Date: Thu, 26 Nov 2026 13:14:44 +0200
Subject: [PATCH RFC v2 31/54] mm/pageattr: introduce
 cpa_flush_tlb_kernel_range()
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261126-generic-set-memory-v0-1-v2-31-723f1e33c3d8@kernel.org>
References: <20261126-generic-set-memory-v0-1-v2-0-723f1e33c3d8@kernel.org>
In-Reply-To: <20261126-generic-set-memory-v0-1-v2-0-723f1e33c3d8@kernel.org>
To: linux-mm@kvack.org
Cc: =?utf-8?q?Adrian_Barna=C5=9B?= <abarnas@google.com>, 
 Alexander Gordeev <agordeev@linux.ibm.com>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Andy Lutomirski <luto@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
 Borislav Petkov <bp@alien8.de>, Brendan Jackman <brendan.jackman@linux.dev>, 
 Catalin Marinas <catalin.marinas@arm.com>, 
 Dave Hansen <dave.hansen@linux.intel.com>, 
 David Hildenbrand <david@kernel.org>, 
 Gerald Schaefer <gerald.schaefer@linux.ibm.com>, 
 Heiko Carstens <hca@linux.ibm.com>, Huacai Chen <chenhuacai@kernel.org>, 
 Ingo Molnar <mingo@kernel.org>, Kevin Brodsky <kevin.brodsky@arm.com>, 
 "Liam R. Howlett" <liam@infradead.org>, Lorenzo Stoakes <ljs@kernel.org>, 
 Madhavan Srinivasan <maddy@linux.ibm.com>, Michal Hocko <mhocko@suse.com>, 
 Mike Rapoport <rppt@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
 Paul Walmsley <pjw@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
 Russell King <linux@armlinux.org.uk>, 
 Suren Baghdasaryan <surenb@google.com>, Thomas Gleixner <tglx@kernel.org>, 
 Vasily Gorbik <gor@linux.ibm.com>, Vlastimil Babka <vbabka@kernel.org>, 
 Will Deacon <will@kernel.org>, linux-arch@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, 
 linuxppc-dev@lists.ozlabs.org, loongarch@lists.linux.dev, x86@kernel.org
X-Mailer: b4 0.16.1-dev
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Many architectures that implement set_memory_*() APIs flush the TLB after a
page table update with flush_tlb_kernel_range() for the range of the
request.

Add cpa_flush_tlb_kernel_range() helper for their arch_cpa_flush() hooks.

When to flush and whether to flush more than the request stays up to the
architecture.

LoongArch, ARM, powerpc, riscv and arm64 will use it when they switch to
the CPA core.

Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
---
 include/linux/pageattr.h | 1 +
 mm/pageattr.c            | 8 ++++++++
 2 files changed, 9 insertions(+)

diff --git a/include/linux/pageattr.h b/include/linux/pageattr.h
index 25f04e61ee85..091408ad328f 100644
--- a/include/linux/pageattr.h
+++ b/include/linux/pageattr.h
@@ -65,6 +65,7 @@ static inline unsigned long cpa_addr(struct cpa_data *cpa, unsigned long idx)
 
 int cpa_process_fault(struct cpa_data *cpa);
 int cpa_change_alias(struct cpa_data *cpa, struct cpa_data *alias);
+void cpa_flush_tlb_kernel_range(struct cpa_data *cpa);
 
 int change_page_attr(struct cpa_data *cpa);
 
diff --git a/mm/pageattr.c b/mm/pageattr.c
index dcece32ebad2..852e0989dac9 100644
--- a/mm/pageattr.c
+++ b/mm/pageattr.c
@@ -14,6 +14,8 @@
 #include <linux/vmalloc.h>
 #include <linux/set_memory.h>
 
+#include <asm/tlbflush.h>
+
 /*
  * Serialize CPA using cpa_lock so that:
  * - concurrent requests don't split or change the same large mapping at the
@@ -482,6 +484,12 @@ int change_page_attr_noflush(struct cpa_data *cpa)
 	return ret;
 }
 
+void cpa_flush_tlb_kernel_range(struct cpa_data *cpa)
+{
+	flush_tlb_kernel_range(cpa->addr,
+			       cpa->addr + cpa->numpages * PAGE_SIZE);
+}
+
 int cpa_change_alias(struct cpa_data *cpa, struct cpa_data *alias)
 {
 	int ret;

-- 
2.53.0


