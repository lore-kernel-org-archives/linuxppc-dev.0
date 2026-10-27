Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D691F606A31A
	for <linuxppc-dev@archiver.kernel.org>; Tue, 27 Oct 2026 04:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=UyzGzEDb
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jDHK975Ctz2yR1;
	Tue, 27 Oct 2026 15:17:49 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::132c"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793071386;
	cv=none; b=OMw63BuWCYaIsDwZfwwf3OnY05YK0C2+4mUF47BGZIqGe3WDtzrk8eFiGZUCKtAIXCPQUR5w5MkBYvF6J7MfMrVZvH9DYgQgeK+t5quo/EuG5FEjo6I7qKuEmm7jn48PUTSGUzyFq7Q/+MejPuCg1lv/wugsScfDGBGZFTcY9qoPqUw1ye67baiw05pW/WMS5HraZ6FFmdSovugzVJ9TjvLjr60+YuTeM6TcxZ/Pl57Kl8iO2jnsREVwhqcNaM+LVNLEs9xQ8S7kayEAAM5niuklf2cs9DuPyFjlna86XaV92C30AWQXF/JSZuTZdko4bszlcQE3xFf60H9nXjCjFA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793071386; c=relaxed/relaxed;
	bh=mWd1DAd1S4KnKkwjMVvNunqSd6gNRebh+/QyhPldimE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=V5LH6jA+bffzzrPOxYvfulxKyri94rNaZcis26lFwknpHakhaPnP0YgOl80xHRE+JjHsbk4aLLd5sE24rvLGvm9qKqU+ncYpe93NqHqKf/e+ksmQNZq8esKJA5kqMzx0uZAQZcMTgUbYcTI/oH1KJ1TUbKW9ilAy9GiwPeepx8GkD1kq0ld2/i80Lix6lKhxSSfPWYw0QcPbaGpHBAWTDnnOgu+e0AVYBFavwBGksDTz9y0hV05WWLtOvF4mihmif2flc5nTxy4YRBnn6hkhtDO6o/GWBR2s74xe8a9PWyr4oNdDcQ9+85xmb+Vqj/jVQmhQjqWpS46dWGylvJtcFA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=UyzGzEDb; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::132c; helo=mail-dy1-x132c.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=UyzGzEDb;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::132c; helo=mail-dy1-x132c.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-dy1-x132c.google.com (mail-dy1-x132c.google.com [IPv6:2607:f8b0:4864:20::132c])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jDG610JbHz2xQs
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Oct 2026 14:23:04 +1100 (AEDT)
Received: by mail-dy1-x132c.google.com with SMTP id 5a478bee46e88-36661f953e4so6818816eec.1
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Oct 2026 20:23:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793071382; x=1793676182; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=mWd1DAd1S4KnKkwjMVvNunqSd6gNRebh+/QyhPldimE=;
        b=UyzGzEDbT0FephzrFFvJtKzChshlG+1zqevMHh/rXFpzQqfe6LLxFa7b9D6GNqMLsW
         uvZWTCVUJdt9yt+lHU0goLUc6EY6tMTRTzrRjieCW9cFI5pSMRRaUOuPVLjnIccRCHe3
         UzGzc6ReQ9uw1FnWhONxfd/OcW4J2XYCOBPtrnZzEYNoqZrl1+tyRnhKe9KgoQIIczYT
         93l8nTt7XHDz8Q3c1HYxlU1pUbOkeDvOXLiUI21/hxnLtuSfgOC7EtPKgY1ZLM7s5N/t
         4JQgocv3zoYyuwMA8JFpb5d+vVBgER0OWvLIbZLGqrxFvGPezolQrJCkZqoDwJy3bl8q
         bXkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793071382; x=1793676182;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mWd1DAd1S4KnKkwjMVvNunqSd6gNRebh+/QyhPldimE=;
        b=X+V67jEkKeShFxMHDqOB99abDa+t/fHpvkVTJMfWY0zAE8qAzJNyD5/KrXllQ4V8Bt
         67vYuX7UA1cByDnFWPmxvrN+H0KXa/EZXYHniaYWSo/kLhVCipyTAWB0mI6V5xgoMzxh
         5mm/Uid62CenVprx038KSjinEBp9Z8SZfFdKFPRtEZ+F/rkRiArzEOKhP6i7ubXT7Wib
         sFDrwGu3GPbvnBU5QRaqzvhI0h1kkXsfFq1zXgfHW62UUt5dBGkgOCjzI1Ktf2fZqHLF
         ApbWjRGKCKfIrit/G19ctTQ5lFIolk5/aZPln0DfRcJ156VRKqh3/9Yi0zqzNeMS/t6d
         2lvg==
X-Forwarded-Encrypted: i=1; AKwUvBzLGFxMiBMrBp9STRXFuGCC9tBhDXenEibv+1B3qf7DH6YEPz5BdQL3rnPFAh1egi12r17aA4QWo0cNpEE=@lists.ozlabs.org
X-Gm-Message-State: AFq9FYJd/VsxrXqRK+H2gTHVNISbIGXXI5VPnmcxIUSxvGFAJKhczVg1
	VFu+voqLoX1bnBZyYxILv1Y3AV1wE1kcEiq/2nRNncoPVfcbE++NowrZ
X-Gm-Gg: AYBFou3I1AwCxmgmnyHdqkrJSUm/OotTlAP0QdkWROzthKvO3VPnuk049P3GhV9iFvs
	dxTtWAZCaA3uMPsKxhP8YS/YSIQuq5AFDU49s48fMWIyHcifYR19Bl2mUUQz/P382ape+r5arnM
	g3MO3rS0auzRoMw/bNHsxQSI9xmnN06WH1UZGWT+A6qkWMCvvstNFHP/ZsM4+WyCEkkTU/4wKHW
	9yE4SaMEmhQfjVpEnmdG56umXZMm/muEOwLtRHPTcNXWuZk7OTV2Q/r8ITsB45A6sN1U4CDFgIQ
	3GeL0qc4aWJxC2EyulMoUSxkZoqgZBlh2ylFrd4W+JBo7A/WUzOOudaAWYaUQYKZ9RE75979xCc
	7LaalXNuawALBm/zduuLv2C25dNrnPCncUTrfkpEIVs+1wmBBwPTl6xZoeLaAvZaIMJRwTboNyd
	8J6mkQD81nUYj/7U25lZeJR4Xh15xM6PkCVvDnfuNh/VOhNAS8XpzkwNUFGGbxfv03NOPKAwfcv
	2CYvlV7fGJFwC83L7fTRLO1lW/h5stq3SkCMz4ul6jDGZQ/LFPRNP/8r8og
X-Received: by 2002:a05:7301:4388:b0:361:6884:78b1 with SMTP id 5a478bee46e88-369e8507476mr13203756eec.28.1793071382017;
        Mon, 26 Oct 2026 20:23:02 -0700 (PDT)
Received: from pve-server.rlab ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-369e8ec9276sm49373826eec.25.2026.10.26.20.22.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 20:23:01 -0700 (PDT)
From: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To: linux-mm@kvack.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Muchun Song <muchun.song@linux.dev>
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Christophe Leroy <chleroy@kernel.org>,
	Venkat Rao Bagalkote <venkat88@linux.ibm.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	David Hildenbrand <david@kernel.org>,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
	Pavithra <pavrampu@linux.ibm.com>
Subject: [PATCH 1/2] powerpc/64s/radix: don't dedup vmemmap covered by an existing PMD leaf
Date: Tue, 27 Oct 2026 08:52:48 +0530
Message-Id: <97f85592bb78a273be8519e6897e7f9b9bd31469.1793070429.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.39.5
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

radix__vmemmap_populate() is asked for one 16MB section, which is 16KB of
struct pages. With no altmap it rounds the request down to a PMD leaf.
That leaf describes 2GB of PFNs with 64KB pages (128MB with 4KB pages),
so it also covers sections that are not present yet. It cannot be freed
while any of those sections are still in use.

A devdax namespace that lands in the same window is marked for vmemmap dedup.
vmemmap_populate_compound_pages() treated the leaf as an existing huge mapping
and skipped it. The core then initializes only the head vmemmap page and assumes
the rest is the shared tail. Those remaining tail slots are real struct pages
still holding the page_init_poison() pattern and are not the shared tail pages.
__init_single_page() warns on the zone mismatch and the following pageblock init
faults in __set_pfnblock_flags_mask().

If the section's vmemmap is already a PMD leaf, clear its compound order
and reuse the leaf, so every struct page in the section is initialized.
The shared-tail layout needs base-page PTEs, so it cannot be built on top of
this leaf and dropping the leaf is not an option while the neighbouring range
is still using it. So, fail the compound populate if a leaf is still seen there.

<Call Trace>
============
[    3.467060][    T1] WARNING: mm/mm_init.c:600 at __init_single_page+0xd0/0xf4, CPU#0: swapper/0/1
<...>
[    3.477419][    T1] NIP [c000000000576b30] __init_single_page+0xd0/0xf4
[    3.477827][    T1] LR [c0000000005778b0] __init_zone_device_page+0x30/0xb8
[    3.478444][    T1] Call Trace:
[    3.478764][    T1]  0x10000 (unreliable)
[    3.479874][    T1]  memmap_init_zone_device+0x164/0x430
[    3.480392][    T1]  memremap_pages+0x43c/0x93c
[    3.480836][    T1]  devm_memremap_pages+0x3c/0xa4
[    3.481328][    T1]  dev_dax_probe+0x264/0x3d0
[    3.481817][    T1]  dax_bus_probe+0x140/0x1c8
[    3.482237][    T1]  really_probe+0x108/0x580
[    3.482681][    T1]  __driver_probe_device+0xcc/0x284
[    3.483186][    T1]  driver_probe_device+0x5c/0x108
[    3.483656][    T1]  __device_attach_driver+0x10c/0x1e8
[    3.484134][    T1]  bus_for_each_drv+0xc0/0x13c
<...>
[    3.499972][    T1] BUG: Kernel NULL pointer dereference on read at 0x00001400
[    3.500417][    T1] Faulting instruction address: 0xc0000000005f4ecc
[    3.500417][    T1] Faulting instruction address: 0xc0000000005f4ecc
cpu 0x0: Vector: 300 (Data Access) at [c000000006756b50]
    pc: c0000000005f4ecc: __set_pfnblock_flags_mask.constprop.0+0x34/0x160
    lr: c000000000577f38: memmap_init_zone_device+0x358/0x430
    pid   = 1, comm = swapper/0
enter ? for help
  memmap_init_zone_device+0x358/0x430
  memmap_init_zone_device+0x220/0x430 (unreliable)
  memremap_pages+0x43c/0x93c
  devm_memremap_pages+0x3c/0xa4
  dev_dax_probe+0x264/0x3d0
  dax_bus_probe+0x140/0x1c8
  really_probe+0x108/0x580
<...>

Fixes: bd0862382adb ("mm/sparse-vmemmap: drop Device DAX-specific population path")
Reported-by: Pavithra <pavrampu@linux.ibm.com>
Assisted-by: LLM
Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
Fixes tag here is added since the fix is dependent upon the change mentioned in
"Fixes" tag. The Fixes commit-id is from mm-new branch. Although this could be
an older pre-existing issue, but got exposed after this patch series.

 arch/powerpc/mm/book3s64/radix_pgtable.c | 57 +++++++++++++++++++++---
 1 file changed, 50 insertions(+), 7 deletions(-)

diff --git a/arch/powerpc/mm/book3s64/radix_pgtable.c b/arch/powerpc/mm/book3s64/radix_pgtable.c
index 44868b62b14e..abac39d020ab 100644
--- a/arch/powerpc/mm/book3s64/radix_pgtable.c
+++ b/arch/powerpc/mm/book3s64/radix_pgtable.c
@@ -1114,7 +1114,35 @@ static inline pte_t *vmemmap_pte_alloc(pmd_t *pmdp, int node,
 	return pte_offset_kernel(pmdp, address);
 }

+/*
+ * vmemmap is populated one memory section at a time. A section on PowerPC
+ * is 16MB, so backing its struct pages takes a 16K region of vmemmap.
+ * Without an altmap, radix__vmemmap_populate() satisfies such a request by
+ * mapping a whole PMD_SIZE leaf. One leaf holds the struct pages for
+ * PMD_SIZE / sizeof(struct page) PFNs (2GB of memory with 64K pages, 128MB
+ * with 4K pages) i.e. for many sections, including ones that aren't
+ * present yet.
+ * Return true if any part of [start, end) is already covered by such a leaf.
+ */
+static bool __meminit vmemmap_pmd_leaf_mapped(unsigned long start,
+					      unsigned long end)
+{
+	unsigned long addr;

+	for (addr = start; addr < end; addr = pmd_addr_end(addr, end)) {
+		p4d_t *p4d = p4d_offset(pgd_offset_k(addr), addr);
+		pud_t *pud;
+
+		if (p4d_none(READ_ONCE(*p4d)))
+			continue;
+		pud = pud_offset(p4d, addr);
+		if (pud_none(READ_ONCE(*pud)))
+			continue;
+		if (pmd_leaf(READ_ONCE(*pmd_offset(pud, addr))))
+			return true;
+	}
+	return false;
+}

 int __meminit radix__vmemmap_populate(unsigned long start, unsigned long end, int node,
 				      struct vmem_altmap *altmap)
@@ -1128,8 +1156,20 @@ int __meminit radix__vmemmap_populate(unsigned long start, unsigned long end, in
 	pte_t *pte;
 	unsigned long pfn = page_to_pfn((struct page *)start);

-	if (vmemmap_optimizable_order(pfn_to_section_compound_order(pfn)))
-		return vmemmap_populate_compound_pages(pfn, start, end, node, NULL);
+	if (vmemmap_optimizable_order(pfn_to_section_compound_order(pfn))) {
+		if (!vmemmap_pmd_leaf_mapped(start, end))
+			return vmemmap_populate_compound_pages(pfn, start, end, node, NULL);
+		/*
+		 * A leaf installed for a neighbouring range already backs this
+		 * section with real struct pages and it cannot be freed while
+		 * that range is present, so the shared tail layout would save
+		 * nothing. The core trusts the section's compound order to tell
+		 * which struct pages it must initialize. So, clear it so that
+		 * every struct page of this section is initialized, then reuse
+		 * the leaf like any other section does below.
+		 */
+		section_set_compound_order(__pfn_to_section(pfn), 0);
+	}
 	/*
 	 * If altmap is present, Make sure we align the start vmemmap addr
 	 * to PAGE_SIZE so that we calculate the correct start_pfn in
@@ -1260,11 +1300,14 @@ int __meminit vmemmap_populate_compound_pages(unsigned long start_pfn,
 		if (!pmd)
 			return -ENOMEM;

-		if (pmd_leaf(READ_ONCE(*pmd))) {
-			/* existing huge mapping. Skip the range */
-			next = pmd_addr_end(addr, end);
-			continue;
-		}
+		/*
+		 * The struct pages behind a leaf are not the head/shared tail
+		 * layout the core expects for this section and the tails
+		 * would be left uninitialized. radix__vmemmap_populate()
+		 * calls this only when it finds vmemmap optimizable order.
+		 */
+		if (WARN_ON_ONCE(pmd_leaf(READ_ONCE(*pmd))))
+			return -EOPNOTSUPP;
 		pte = vmemmap_pte_alloc(pmd, node, addr);
 		if (!pte)
 			return -ENOMEM;
--
2.39.5


