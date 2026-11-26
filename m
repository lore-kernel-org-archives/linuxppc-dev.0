Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5863606A31C
	for <linuxppc-dev@archiver.kernel.org>; Thu, 26 Nov 2026 11:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EzXrhltc
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jZv8d4GVYz2yFb;
	Thu, 26 Nov 2026 22:14:57 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795691697;
	cv=none; b=Q5Z49H14eEVHKXReCkZ79nuH/1EWY0aE7qVNtcUzfZi3EATaz9lpM1Y6iiesFFi1h+8MHpQnStS6uol4XaA3HbsxzkGfidaO7HO5hZiGMMWud/0TY0LiUQSJjxmYdacQePcXb3B1t/XIRHrRusWmPg+N1ieMT5mXbGM3zzw1qCB4sZfJ1APpddtLbWvPMwjhlu0JVG1WIN5DVisdrTGTK4CEjGb6Bwefn40EN8c25LQHiM1sOqKFEt0vejJVPF8b1DcBW44YIOhi5Wh40JWi/cVu6KhvXbcDEmsrGObh7iWgkZ00Nr+Wlvyb64/aiICP6Nixr0zVkWzpYZE2SrrL8g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795691697; c=relaxed/relaxed;
	bh=pOe0fNlH4H+/AQprp4nKXyU+tisJl0prDAgrQlBRIqs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=czA+OUO3XwfcwZBWI2Yu8OG00BggpdTqP6Ktb4WaZN9eKBJ/9k8Glxs6+F7WoOB/U+qy8NWVu+BfuqKsYZYt0eLBJxOxK0/pKxdKfSxbBsPiGGT0DrIe2veJm9vM8j79PJ6JDCsdOgvR+sg4moi2m+V36TbNAn4wHotiv/GBrvdaCNVWOqkHt7PAzk1js/m36OchiQHwTpiCxG4D1nA1wpsqYCvtMDSxiR7qD/Y/eHoI5W8QQw5uqM4gMJVhSiDBOF6YbJqoERSu1GcNelNZ0mlpZV/7rZfLp2gZrjmeYxHtx4HUJscjyzW0tzvRSH9dSmMH1GyD//uBmi0zn9gUMg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EzXrhltc; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=rppt@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EzXrhltc;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=rppt@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jZv8c39Lkz2xMt
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Nov 2026 22:14:56 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 3F6DF444C8;
	Thu, 26 Nov 2026 11:14:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 714501F000D4;
	Thu, 26 Nov 2026 11:14:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795691693;
	bh=pOe0fNlH4H+/AQprp4nKXyU+tisJl0prDAgrQlBRIqs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=EzXrhltcMrtKqO6MUWfWRH8/mg8UPhf8i9k4imGHKf4DwbyhoWKKGEnGwRRQgDHwr
	 GmANWhG79gGu7kXW0nekO6FiH4J7RNjWmJoACGQuDBbF6TFy0hUTXDeJ0AR58NQZc6
	 buOPNoDUiaYbPsAZILufugpB4I0oq+kC27B2yxiGnZBMhs/TYqArOIvN/BjSWka2Ll
	 CnvSHYHGIaFGI/ZvB/lVrv8z1dzNmQ6KLqJFB4zTv51MOrM0Ketp2V7nlbX1PnrjAl
	 v0eW8OfCD1pYNH03IstDX7+gNwHnJQcool9WeGFi33CrMoUwm4fiA2rhPhJlQOskbm
	 xnEyOahRKWe7A==
From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Date: Thu, 26 Nov 2026 13:14:15 +0200
Subject: [PATCH RFC v2 02/54] riscv: test for Svnapot in pte_napot()
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
Message-Id: <20261126-generic-set-memory-v0-1-v2-2-723f1e33c3d8@kernel.org>
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

pte_napot() tests only bit 63 and relies on its callers to check that the
CPU supports Svnapot.

On T-Head CPUs bit 63 is not the NAPOT bit: it is set in the non-cached I/O
mappings (_PAGE_IO_THEAD).

pte_pfn() checks has_svnapot() before pte_napot(), but pte_leaf_size() does
not. With CONFIG_RISCV_ISA_SVNAPOT=y on T-Head, a page of an I/O mapping
looks like a NAPOT block and pte_leaf_size() derives its size from the
alignment of its PFN. perf then reports a bogus page size for addresses in
I/O mappings.

Check has_svnapot() in pte_napot() so that its callers don't have to, and
drop the check that became redundant in pte_pfn().

Fixes: e0fe5ab4192c ("riscv: Fix pte_leaf_size() for NAPOT")
Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
---
 arch/riscv/include/asm/pgtable.h | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
index 2ebd5fa5adc5..1c1ba48315ed 100644
--- a/arch/riscv/include/asm/pgtable.h
+++ b/arch/riscv/include/asm/pgtable.h
@@ -288,9 +288,9 @@ static __always_inline bool has_svnapot(void)
 	return riscv_has_extension_likely(RISCV_ISA_EXT_SVNAPOT);
 }
 
-static inline unsigned long pte_napot(pte_t pte)
+static inline bool pte_napot(pte_t pte)
 {
-	return pte_val(pte) & _PAGE_NAPOT;
+	return has_svnapot() && (pte_val(pte) & _PAGE_NAPOT);
 }
 
 static inline pte_t pte_mknapot(pte_t pte, unsigned int order)
@@ -306,9 +306,9 @@ static inline pte_t pte_mknapot(pte_t pte, unsigned int order)
 
 static __always_inline bool has_svnapot(void) { return false; }
 
-static inline unsigned long pte_napot(pte_t pte)
+static inline bool pte_napot(pte_t pte)
 {
-	return 0;
+	return false;
 }
 
 #endif /* CONFIG_RISCV_ISA_SVNAPOT */
@@ -318,7 +318,7 @@ static inline unsigned long pte_pfn(pte_t pte)
 {
 	unsigned long res  = __page_val_to_pfn(pte_val(pte));
 
-	if (has_svnapot() && pte_napot(pte))
+	if (pte_napot(pte))
 		res = res & (res - 1UL);
 
 	return res;

-- 
2.53.0


