Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1247E606A33F
	for <linuxppc-dev@archiver.kernel.org>; Thu, 26 Nov 2026 11:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oK4AqxJG
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jZvHw5YS6z3d0p;
	Thu, 26 Nov 2026 22:21:16 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795692076;
	cv=none; b=VPpmADl9EsjHjFfAlm4d5JnZTMG5IBeY64UoWEB9wikrNfc2/tmXG0X7MfPGGNyzoIWHApxJOXm5ZfHiIVYDX0PEwQHszSa54inxLTwAy2r8W8hMyKP7BcvfjWKsabQkZmNrMUEnfomYnHK5PsKqUh4y3AEicXxt8An6YCbjHSr5cbwN2NlTYiJojQMiJN/ToVKZr0ZkWMAM94xQV6Xuj9f1m1iv4E5AFlD4Yuwi9fYfNKsWd1o9rIZrTZ3nkMUJ90ByADVDR9774gsxEIZgO+OdszP65uCxjIvRETHpuBIPBf4kIG/LSOOJWQrl5FI+42qp/YqeNalAH+K5aHda/A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795692076; c=relaxed/relaxed;
	bh=acVZadH+VFBFC1d1dLbutXfDJETNRTgRtEhv1loN3Kc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eafU1y7O7JOXqx3cNuFiV0s7zWNm7UZWcYGRirpOcWNg8GunfrueFWxUVR7n+2XtkVvJRmchoIEXkXyeFI//aZ7sDw8Pk7kJCkFr5FG/w9MI6MaYJbaWByr/m3UmXVYqABMlVzjh+00JCvu5ab65L1rO4CjLpQ1AuouXF2154Xs52FQNajXxUDyTA6ihRBbVSoLcvnti2qO9zEac7MeMar0hpyh/QwDombXJq/XgI1gr3192nfq+HMUo4SILjwDRwdwhJ7KlMqWNN/Mc7PdMwv80UFnKta42uEiJTm6Z9kr5Dk4CRmp0oODx0+5P6tC+GJo9nvLSzHaMKH9eJP6vKw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oK4AqxJG; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=rppt@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oK4AqxJG;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=rppt@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jZvHv6yKMz3bnD
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Nov 2026 22:21:15 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 174A66338E;
	Thu, 26 Nov 2026 11:21:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52F331F000F0;
	Thu, 26 Nov 2026 11:21:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795692073;
	bh=acVZadH+VFBFC1d1dLbutXfDJETNRTgRtEhv1loN3Kc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=oK4AqxJGy9uqp40xlP/Jc0iEDwgFDT9uMRNK+Zl8qcl8G0bhKbCFVgHRfykGfNWh7
	 rtJNH451csTci9e1tSOqJ5qyT8T6vptgOd9P041BiJa0SV5y21pqGOAEXr1+d+1WCS
	 cIpdBKH1Fy/CULw7Wl50ENc3s+c3GzFxSO5iYs+XhEAWpLIAX9icNKRJR3koOxCV0Z
	 mHqfTR7sjYIttOG7RyHW9UfPkEmc9uo53WuWB6vqHW+ROeoi9ZN6xtbRTt34C0QJDV
	 AQKxlsm/4KiSBcg5omjktitzKas7r73CDVkNZYMMMl3IfwUGRR6riIvMyHQ81TcoJ/
	 UqKiSDECBOiuA==
From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Date: Thu, 26 Nov 2026 13:14:55 +0200
Subject: [PATCH RFC v2 42/54] riscv: count the mappings of the linear map
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
Message-Id: <20261126-generic-set-memory-v0-1-v2-42-723f1e33c3d8@kernel.org>
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
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The CPA core keeps a counter of the linear map entries at every page table
level and displays the "Breakdown of page table sizes used in the kernel's
identity mapping of RAM" in /proc/meminfo.

When a large mapping is split, the counters of the split level and the one
below are updated as well as direct_map_level2_splits or
direct_map_level3_splits event counters displayed in /proc/vmstat.

The initial updates for these counters happen when an architecture creates
its linear map.

riscv doesn't seed these counters, so the CPA core cannot update them
during a split, and the split events stay at zero.

Count the linear map when it is created at boot and on memory hot-plug and
hot-remove.

Report the counters in /proc/meminfo, as x86 and s390 do.

Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
---
 arch/riscv/mm/init.c     | 20 ++++++++++++++++++++
 arch/riscv/mm/pageattr.c | 15 +++++++++++++++
 2 files changed, 35 insertions(+)

diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
index e1bcc3a16129..b466db515ee1 100644
--- a/arch/riscv/mm/init.c
+++ b/arch/riscv/mm/init.c
@@ -28,6 +28,9 @@
 #include <linux/kfence.h>
 #include <linux/execmem.h>
 #include <linux/vmemmap-optimization.h>
+#ifdef CONFIG_MMU
+#include <linux/pageattr.h>
+#endif
 
 #include <asm/alternative.h>
 #include <asm/fixmap.h>
@@ -1201,6 +1204,15 @@ asmlinkage void __init setup_vm(uintptr_t dtb_pa)
 	pt_ops_set_fixmap();
 }
 
+static enum pgtable_level __meminit linear_map_level(uintptr_t map_size)
+{
+	if (map_size == PUD_SIZE)
+		return PGTABLE_LEVEL_PUD;
+	if (map_size == PMD_SIZE)
+		return PGTABLE_LEVEL_PMD;
+	return PGTABLE_LEVEL_PTE;
+}
+
 static void __meminit create_linear_mapping_range(phys_addr_t start, phys_addr_t end,
 						  uintptr_t fixed_map_size, const pgprot_t *pgprot)
 {
@@ -1214,6 +1226,7 @@ static void __meminit create_linear_mapping_range(phys_addr_t start, phys_addr_t
 
 		create_pgd_mapping(swapper_pg_dir, va, pa, map_size,
 				   pgprot ? *pgprot : pgprot_from_va(va));
+		direct_map_count_update(linear_map_level(map_size), 1);
 	}
 }
 
@@ -1599,6 +1612,8 @@ static void __meminit remove_pte_mapping(pte_t *pte_base, unsigned long addr, un
 		pte_clear(&init_mm, addr, ptep);
 		if (is_vmemmap)
 			free_vmemmap_storage(pte_page(pte), PAGE_SIZE, altmap);
+		else
+			direct_map_count_update(PGTABLE_LEVEL_PTE, -1);
 	}
 }
 
@@ -1620,6 +1635,8 @@ static void __meminit remove_pmd_mapping(pmd_t *pmd_base, unsigned long addr, un
 			pmd_clear(pmdp);
 			if (is_vmemmap)
 				free_vmemmap_storage(pmd_page(pmd), PMD_SIZE, altmap);
+			else
+				direct_map_count_update(PGTABLE_LEVEL_PMD, -1);
 			continue;
 		}
 
@@ -1648,6 +1665,9 @@ static void __meminit remove_pud_mapping(pud_t *pud_base, unsigned long addr, un
 				pud_clear(pudp);
 				if (is_vmemmap)
 					free_vmemmap_storage(pud_page(pud), PUD_SIZE, altmap);
+				else
+					direct_map_count_update(
+						PGTABLE_LEVEL_PUD, -1);
 			}
 			continue;
 		}
diff --git a/arch/riscv/mm/pageattr.c b/arch/riscv/mm/pageattr.c
index bb8629da0d1d..22826ba688c3 100644
--- a/arch/riscv/mm/pageattr.c
+++ b/arch/riscv/mm/pageattr.c
@@ -5,12 +5,27 @@
 
 #include <linux/pageattr.h>
 #include <linux/pgtable.h>
+#include <linux/proc_fs.h>
 #include <linux/vmalloc.h>
 #include <linux/cacheflush.h>
 #include <asm/tlbflush.h>
 #include <asm/bitops.h>
 #include <asm/set_memory.h>
 
+#ifdef CONFIG_PROC_FS
+void arch_report_meminfo(struct seq_file *m)
+{
+	unsigned long levels = BIT(PGTABLE_LEVEL_PTE);
+
+	if (IS_ENABLED(CONFIG_64BIT))
+		levels |= BIT(PGTABLE_LEVEL_PMD);
+	if (pgtable_l4_enabled())
+		levels |= BIT(PGTABLE_LEVEL_PUD);
+
+	cpa_report_meminfo(m, levels);
+}
+#endif
+
 void arch_cpa_decode_leaf(struct cpa_leaf *leaf)
 {
 	pte_t pte = ptep_get(leaf->kpte);

-- 
2.53.0


