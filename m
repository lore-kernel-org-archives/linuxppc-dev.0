Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39F13606A33C
	for <linuxppc-dev@archiver.kernel.org>; Sat,  7 Nov 2026 13:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=JoAh/QNS
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jMHW73n7Yz2yDc;
	Sun, 08 Nov 2026 00:50:43 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::132e"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794059443;
	cv=none; b=Z/9rkJt3Cp1qTNXMtNCI1qI+eyX/wihj2RRh9OEmKWGPANe63xAo4Pi3yfatpaEBk+EICi2K/S8nrHsObRmPCnKHsYMUHzn7HmlHyepv4fzewiIDJl78OhtU49I5UkEgV5jSp1i/pT5t3AhZBJqEdN4mKWhzx/3ApXl4kfzwhYyfkvqe5f5xKZ32YfNAWAA2W1PI+Y1vBJ7n8QrXW2mHqbAGeebTstDnTIOkbtyhvSR3fi8KIlYttcIhSyG4poslQ5aSmAesjmrPpsU3OR8SNVw0xVmXGeBWhYrtEmc9xIG5Cra6R1osan/nGGog8x56zPXLLGBU40/6IZ/MWURDBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794059443; c=relaxed/relaxed;
	bh=juq+pi4pblAMzdsctIP8tsm6etRIcSlR/IjeGEKfwmM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hYdIiTeKz3RUibJORhfWSUW8C/kWzkgzxfx11cpylHwjnsCqpmhLhG7rRRJUvblH9B97BExY2ZAya2VXGNCR+oHNj6O8TIgFJ4/ZPNZVI5v1kmZvywcA9koPxpgqejVVfVGOxJADeUihZbQWZnj1/Zh6IZLqFFtpXptP8nBIvC7jzYixrAUuTNrGol5nO8EPrCOrHQZuRko7nigpdQ2ajfToRN63SsLYYDyH3bVLYIghB5prYlNZDUIApEsj6s+KrS8ghYC73VR50Ikao1gR1Bqr6xWyL1SUpZnRldnblub459Lua+tPdOc39qxI3I+4ue6NgurUrTjawWi3QJ74Qw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=JoAh/QNS; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::132e; helo=mail-dy1-x132e.google.com; envelope-from=jiangwenxiaomi@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=JoAh/QNS;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::132e; helo=mail-dy1-x132e.google.com; envelope-from=jiangwenxiaomi@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-dy1-x132e.google.com (mail-dy1-x132e.google.com [IPv6:2607:f8b0:4864:20::132e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jMHW66BMkz2yDD
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 08 Nov 2026 00:50:42 +1100 (AEDT)
Received: by mail-dy1-x132e.google.com with SMTP id 5a478bee46e88-3704d30b84fso1210865eec.1
        for <linuxppc-dev@lists.ozlabs.org>; Sat, 07 Nov 2026 05:50:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794059441; x=1794664241; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=juq+pi4pblAMzdsctIP8tsm6etRIcSlR/IjeGEKfwmM=;
        b=JoAh/QNS3yyt1jFTiBYbgjNhiwyRIQXcDVDjhFeknPeIOfbHGfilxL3NJYTUvt5ngz
         d7qlRvJ9+b4yeLFKZIWeZ6iKYxGkpjQ+2wdszqPRSwEMMKffkYnzZoEzueOJCP5YJqKq
         m8McpFar8/QP/RBZbz2wynWxQUQCLvlQeqEUl17J1cU9yp0Fphfhzb6LRdUnZMSllW7F
         OVMrdZtdecPVxYAHGIm2z/qdTi1pEqDaQq019cleaXHzXENH3RKaSPBBqJD+OpE/Peu+
         7ZrFKoXCF2faLmsMatM5D4ew+BHY/kuWy9kI+SXej6DISilTP1jH7x2ygdxnl93v3tum
         HStw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794059441; x=1794664241;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=juq+pi4pblAMzdsctIP8tsm6etRIcSlR/IjeGEKfwmM=;
        b=j+0ZyqVfx4E5uOoUn8lBnIObKufyJxyOnveZOPQmFNrsWYEDBxmoyc5kr8oW1XWmgq
         qQB8ACigsDB+Zt5SxegXGFu4wlK7ZG7N7TYADi6roqBoyVfRmq4SjaVeMwTF1jc9bC4d
         yfUnszg1PAW2ItEDUTHLq0rrjaXcXDjm+5/ED5O+cyTn3t8TU8fJMI/LhtjCwd7ORSrR
         2V/eSxjV7KZ0QrSPpK5ywdW1xs9jjY82x1Z0GI550SCZRgfELV0qKogw9okqjNBW3wTF
         D0xu14Tcn3ygv9X3CYwKGyOBqUMJbPVXGgxNm/ag7fkncKGi2Eq/dIUKlWLikNBOVf9r
         KKdw==
X-Forwarded-Encrypted: i=1; AL+hErESt2W98AfDNGJJfCjLuHhb6l3FUc1TYRo0TYaxlXf6tqnEyE3Ecq2yr3p/mwfi7hVLaf4HvYzXSCIubBw=@lists.ozlabs.org
X-Gm-Message-State: APuU4Z8f1Uiw/zwvfWCtYUPU+UVcAqyrC9SgOJv68ht1Exkrm891wXqE
	mBQLoCaDUufSYua7SY31C8Yzrd94VMOvrxtoCGzuwE/nR0qy0djqsQ6d
X-Gm-Gg: AYBFou0/vTlQPkr6W7S/GNvTlBJ7f5F+bHwZtuo19E4SLVUqGOoGUb1Y8rqbDswfSPU
	R3GJoaznlDcqhLKldq/tCLteQN+X5Ut7brj7ZNrBAcIkl40HlxGgZITbWimXAnaAOYfnfiPTB/I
	Ux4LCJ3tco97d0JhO3lpd47Lz+P2uS7ar2HNwGxpTzXzF7CvlqForOHfSiV3oHAEXnuXOQ8k2qk
	liE+X3cWYuUtVjWmqdegAztBF+UKysE4aagYjNr7cD7G71zhReboCoQVZoP47lFmUtp8PvxSsOI
	Vdquv5e9uOCzsg7r/hgcjIiSOSMXoOULEROlPzd71bNPjII4bkMhfTEBN3XUTS/LqJEZDQIs+t5
	7eLJbDCIzufhnhoZ1PIkZ4cfja4Iqra+41njCzsROpvHUMf3j6N/myYNEOil34qYpEfjIM31jTA
	Sb3B9kPwmkqe6MFArxN8hnYueiN59/o4g7MtAOj1InDlZrwJ1rLu6zroey8kD1l4D7/+uJGFoBE
	h59FmNd5xxHGtkSB8kPaRhupXDIT99K//5pzUeiR6UWK/19RM0kn5QNUGs5pRVxpvNJUlXqkn3u
	qgqGRR7pzcjY5Hm9IEmlFYu5CVYpnmLpfWvDXZLDr2r/8Wns6iwt/Wye5w==
X-Received: by 2002:a05:7301:fc02:b0:36a:1788:3d1c with SMTP id 5a478bee46e88-36f761249e4mr8433809eec.34.1794059440743;
        Sat, 07 Nov 2026 05:50:40 -0800 (PST)
Received: from mi-OptiPlex-7060.mioffice.cn ([43.224.245.234])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36fa922c6c7sm21280820eec.10.2026.11.07.05.50.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Nov 2026 05:50:40 -0800 (PST)
From: Wen Jiang <jiangwenxiaomi@gmail.com>
To: akpm@linux-foundation.org,
	catalin.marinas@arm.com,
	will@kernel.org,
	urezki@gmail.com,
	linux-mm@kvack.org
Cc: baohua@kernel.org,
	dev.jain@arm.com,
	ryan.roberts@arm.com,
	anshuman.khandual@arm.com,
	david@kernel.org,
	rppt@kernel.org,
	leo.yan@arm.com,
	xueyuan.chen21@gmail.com,
	chleroy@kernel.org,
	maddy@linux.ibm.com,
	mpe@ellerman.id.au,
	npiggin@gmail.com,
	ajd@linux.ibm.com,
	jiangwen6@xiaomi.com,
	jiangwenxiaomi@gmail.com,
	linux-arm-kernel@lists.infradead.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v12 06/10] mm/vmalloc: extract vmap_set_ptes() to consolidate PTE mapping logic
Date: Sat,  7 Nov 2026 21:49:49 +0800
Message-Id: <20261107134953.748622-7-jiangwenxiaomi@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261107134953.748622-1-jiangwenxiaomi@gmail.com>
References: <20261107134953.748622-1-jiangwenxiaomi@gmail.com>
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
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Wen Jiang <jiangwen6@xiaomi.com>

Extract the common PTE mapping logic from vmap_pte_range() into a
shared helper vmap_set_ptes(). This handles both CONT_PTE and regular
PTE mappings in a single function, preparing for the next patch which
will extend vmap_pages_pte_range() to also use this helper.

No functional change.

Signed-off-by: Wen Jiang <jiangwen6@xiaomi.com>
Tested-by: Xueyuan Chen <xueyuan.chen21@gmail.com>
Tested-by: Leo Yan <leo.yan@arm.com>
Reviewed-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
Reviewed-by: Dev Jain <dev.jain@arm.com>
---
 mm/vmalloc.c | 36 +++++++++++++++++++++++++++---------
 1 file changed, 27 insertions(+), 9 deletions(-)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index df37c8490ae7e..e3ea9581e68d0 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -92,6 +92,29 @@ struct vfree_deferred {
 static DEFINE_PER_CPU(struct vfree_deferred, vfree_deferred);
 
 /*** Page table manipulation functions ***/
+
+/*
+ * Try contiguous mappings at the PTE level for arches which support them, and if
+ * requested by the caller. Fall back to PAGE_SIZE mappings otherwise.
+ *
+ * Return: mapping size.
+ */
+static __always_inline unsigned long vmap_set_ptes(pte_t *ptep,
+		unsigned long addr, unsigned long end, u64 pfn,
+		pgprot_t prot, unsigned int max_page_shift)
+{
+	unsigned long size;
+
+	size = arch_vmap_pte_range_map_size(addr, end, pfn, max_page_shift);
+	if (size != PAGE_SIZE) {
+		vmap_pte_set_huge(ptep, addr, PFN_PHYS(pfn), prot, size);
+		return size;
+	}
+
+	set_pte_at(&init_mm, addr, ptep, pfn_pte(pfn, prot));
+	return PAGE_SIZE;
+}
+
 static int vmap_pte_range(pmd_t *pmd, unsigned long addr, unsigned long end,
 			phys_addr_t phys_addr, pgprot_t prot,
 			unsigned int max_page_shift, pgtbl_mod_mask *mask)
@@ -100,6 +123,7 @@ static int vmap_pte_range(pmd_t *pmd, unsigned long addr, unsigned long end,
 	u64 pfn;
 	struct page *page;
 	unsigned long size;
+	unsigned int nr_pages;
 
 	if (WARN_ON_ONCE(!PAGE_ALIGNED(end - addr)))
 		return -EINVAL;
@@ -120,15 +144,9 @@ static int vmap_pte_range(pmd_t *pmd, unsigned long addr, unsigned long end,
 			BUG();
 		}
 
-		size = arch_vmap_pte_range_map_size(addr, end, pfn, max_page_shift);
-		if (size != PAGE_SIZE) {
-			vmap_pte_set_huge(pte, addr, PFN_PHYS(pfn), prot, size);
-			pfn += PFN_DOWN(size);
-			continue;
-		}
-		set_pte_at(&init_mm, addr, pte, pfn_pte(pfn, prot));
-		pfn++;
-	} while (pte += PFN_DOWN(size), addr += size, addr != end);
+		size = vmap_set_ptes(pte, addr, end, pfn, prot, max_page_shift);
+		nr_pages = PFN_DOWN(size);
+	} while (pte += nr_pages, pfn += nr_pages, addr += size, addr != end);
 
 	lazy_mmu_mode_disable();
 	*mask |= PGTBL_PTE_MODIFIED;
-- 
2.34.1


