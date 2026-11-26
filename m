Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE0C5606A32C
	for <linuxppc-dev@archiver.kernel.org>; Thu, 26 Nov 2026 11:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gOIJf884
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jZvHY40gnz30WS;
	Thu, 26 Nov 2026 22:20:57 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795692057;
	cv=none; b=d9yCOXzG2IoO/s0szfsWrNbc3AgWpD+Nh2DTv/fnWWX98YUvtNTnY52vwq59eOMNRSOE2BtwFrfOdnIqpvt+04YhyjOqxKLiolg8FpL1JFLfyxPV3SF2rGiSVM8H4HZI7O4YcY+QVqbum63pMZJC3fxb0y8K8dvUQ7J9socK5CWgVz2h2/3H0QP1FcDLExLgReD+PrddHJoT5/+WtCJa+pHn589xw1vwieL0K33pXmzHlrUxLBEecE8C8EDhnboX0nEoNBKeZSc8t0OHLyniNbvWEt9Fmavpfi1nFTBsS90XetUS+dJhGOVNpqcmywz4bbAh+zipFDkuaWXhiKTijA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795692057; c=relaxed/relaxed;
	bh=MMesdoqS6IgWWnyy/lMZV01AhuTBPRWjqbmXz3+vHNk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Dzju8EVH7cbnJ2uLexJ5oddIDvNsaChc8WEqpQHlFNVr/QOTLyX+uPpei7zvIAQrCQn2fd8pr+x49vjYSaL9NK2MqVDFxC/6AVZeQoKbDenuu+BSWUQG6dGnIKWPRP8P/kXt+/SdzIg0rzSYCkaTdRHnjz4b1k0P4wRmCXVFVZwP4PIr8VO6kp+6bA7rnZ5RCp0LvTCpbFdacyG4Gcg18XzeuT6zKw69LkrvWkdJ5HQgyY29oQYolTKjspMYQ7qr1bWlwn7XEByrugtRp3An0Kj/Svg+itOPIIitSZOkvtOZwPTJj2GM1tAkwhhDy3/aNOitYm7WtVtAYh//86wpdQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gOIJf884; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=rppt@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gOIJf884;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=rppt@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jZvHX6BPQz2yMP
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Nov 2026 22:20:56 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 45FFE4374A;
	Thu, 26 Nov 2026 11:20:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3423A1F000D1;
	Thu, 26 Nov 2026 11:20:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795692054;
	bh=MMesdoqS6IgWWnyy/lMZV01AhuTBPRWjqbmXz3+vHNk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=gOIJf884KufaBaPzwIhw/JQosylTm2ObEX+n+dIBRN8n85W6YpVjq7ssAotO+XCJb
	 yTL4B6gPdRjtDz/3xSHiK4N+B00/PqKVy9Hbs/TF+niNS12CriahUizn4VQ3BD5VOn
	 J+iM14A0TRzeQTvx7rtgl+cn2ckJiTBVgqj/qwdF8EcqYQeaDsqOUX7rJElVd2Yi6P
	 XJO9F4VkscYC7PgN2GgWM1Wn7Nv9FQtkWqo+6V521w3Cq3S43n28pusd6yjsD3qGNb
	 o3gldwMIRC0NRUz2anmwEwh+hOlXpqGWtL2SOFGmc4CrKefHoz4Ifigh1EQqRG+fnW
	 xnlqBATFEXtXQ==
From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Date: Thu, 26 Nov 2026 13:14:53 +0200
Subject: [PATCH RFC v2 40/54] riscv: replace set_memory_rw_nx() with
 set_memory_nx() and set_memory_rw()
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
Message-Id: <20261126-generic-set-memory-v0-1-v2-40-723f1e33c3d8@kernel.org>
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

free_initmem() is the only user of set_memory_rw_nx(). Keeping it would
require the generic set_memory() to provide an operation for riscv alone.

Make free_initmem() clear the executable bit with set_memory_nx() and then
make the range writable with set_memory_rw(), like x86 does in
free_init_pages(). In this order the init text never becomes writable and
executable.

Remove set_memory_rw_nx().

Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
---
 arch/riscv/include/asm/set_memory.h | 2 --
 arch/riscv/kernel/setup.c           | 6 +++++-
 arch/riscv/mm/pageattr.c            | 6 ------
 3 files changed, 5 insertions(+), 9 deletions(-)

diff --git a/arch/riscv/include/asm/set_memory.h b/arch/riscv/include/asm/set_memory.h
index e9f9960c1947..b9a8c7033c7a 100644
--- a/arch/riscv/include/asm/set_memory.h
+++ b/arch/riscv/include/asm/set_memory.h
@@ -15,7 +15,6 @@ int set_memory_ro(unsigned long addr, int numpages);
 int set_memory_rw(unsigned long addr, int numpages);
 int set_memory_x(unsigned long addr, int numpages);
 int set_memory_nx(unsigned long addr, int numpages);
-int set_memory_rw_nx(unsigned long addr, int numpages);
 static __always_inline int set_kernel_memory(char *startp, char *endp,
 					     int (*set_memory)(unsigned long start,
 							       int num_pages))
@@ -31,7 +30,6 @@ static inline int set_memory_ro(unsigned long addr, int numpages) { return 0; }
 static inline int set_memory_rw(unsigned long addr, int numpages) { return 0; }
 static inline int set_memory_x(unsigned long addr, int numpages) { return 0; }
 static inline int set_memory_nx(unsigned long addr, int numpages) { return 0; }
-static inline int set_memory_rw_nx(unsigned long addr, int numpages) { return 0; }
 static inline int set_kernel_memory(char *startp, char *endp,
 				    int (*set_memory)(unsigned long start,
 						      int num_pages))
diff --git a/arch/riscv/kernel/setup.c b/arch/riscv/kernel/setup.c
index d79f99b86033..948f0e27aebd 100644
--- a/arch/riscv/kernel/setup.c
+++ b/arch/riscv/kernel/setup.c
@@ -378,7 +378,11 @@ bool arch_cpu_is_hotpluggable(int cpu)
 void free_initmem(void)
 {
 	if (IS_ENABLED(CONFIG_STRICT_KERNEL_RWX)) {
-		set_kernel_memory(lm_alias(__init_begin), lm_alias(__init_end), set_memory_rw_nx);
+		/* Clear X before setting W, so that the range is never W+X */
+		set_kernel_memory(lm_alias(__init_begin), lm_alias(__init_end),
+				  set_memory_nx);
+		set_kernel_memory(lm_alias(__init_begin), lm_alias(__init_end),
+				  set_memory_rw);
 		if (IS_ENABLED(CONFIG_64BIT))
 			set_kernel_memory(__init_begin, __init_end, set_memory_nx);
 	}
diff --git a/arch/riscv/mm/pageattr.c b/arch/riscv/mm/pageattr.c
index 5a1a3b4473c9..433ac98234ed 100644
--- a/arch/riscv/mm/pageattr.c
+++ b/arch/riscv/mm/pageattr.c
@@ -351,12 +351,6 @@ static int __set_memory(unsigned long addr, int numpages, pgprot_t set_mask,
 	return ret;
 }
 
-int set_memory_rw_nx(unsigned long addr, int numpages)
-{
-	return __set_memory(addr, numpages, __pgprot(_PAGE_READ | _PAGE_WRITE),
-			    __pgprot(_PAGE_EXEC));
-}
-
 int set_memory_ro(unsigned long addr, int numpages)
 {
 	return __set_memory(addr, numpages, __pgprot(_PAGE_READ),

-- 
2.53.0


