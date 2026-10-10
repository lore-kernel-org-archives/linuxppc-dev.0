Return-Path: <linuxppc-dev+bounces-29179-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B756CA6004
	for <linuxppc-dev@archiver.kernel.org>; Sat, 10 Oct 2026 12:22:13 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j22sk33lhz3bsP;
	Sat, 10 Oct 2026 23:22:02 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1332"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1791634922;
	cv=none; b=X8xlQZbHsT859zDCsTgYImcLNu6kNppUqHqjYXILLl6133mTYDEKhraxXQVzS4o7WGVX0kPdgxAOJsz2xlS0BzZAC6tF4Lb8Upm4PPRcdARkGa2G/rJzYuRh2iDq8KgQjmmAzysYBRabST1C1H47CqroR+ztpXFSZQ5h5gqPCc8KbV24rpDzQAx3VmcrYWy+Nud7leV9hD2bQ4uj7fa9DP7dxIkDRCKvIb/uTE6XlR0D+SDDSYOCuVXElykORU2ha6zpmHZrxiu3EhKMw+ieAHotzNLpZ4RNy6kEj6rbjUaWvwU253dY/+oD7wqNZgpDZg9SNgHLboArIsSKAOcvdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1791634922; c=relaxed/relaxed;
	bh=+TWFeRXhI9U2gCQnYURwRZ/xBRhQqIxrja99sCT1wuU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jlDo7cJPscQLbOLWqI6veLqbcAG9SQE7yVIEFSHkVcSxBsSON5d7rs+1JDIH6E4bJbNnwyfi3qzZPkJktInpABGcuVnNAMm/Ln7TNc4ypYlhBv8wVCvrsd/MeTJ1q/CtbzN6LZvBsD6T3xeNthLDO03Ix3FP/Dimc7mV59ceB8lzT/E3nYjccQlAVTTdD54BEK6VSfnEUq+Hmu6tSXpV/5Cv6m3YqiIGRcuxpRBq0wcCfRVwNM3MdYcAfl5I8boGbHfmnB2+IOMO3b3GzEapokDj5cTt/1qv2P7eF5011wC4/vTJdm83GCtNRaQpEklNsOwZPkhmkmMDt8Mdb2Y1tg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=VSzYUlN3; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1332; helo=mail-dy1-x1332.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=VSzYUlN3;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1332; helo=mail-dy1-x1332.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-dy1-x1332.google.com (mail-dy1-x1332.google.com [IPv6:2607:f8b0:4864:20::1332])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j22sj5C4Gz3bSn
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 10 Oct 2026 23:22:01 +1100 (AEDT)
Received: by mail-dy1-x1332.google.com with SMTP id 5a478bee46e88-30b6dad2382so1213247eec.0
        for <linuxppc-dev@lists.ozlabs.org>; Sat, 10 Oct 2026 05:22:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791634919; x=1792239719; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+TWFeRXhI9U2gCQnYURwRZ/xBRhQqIxrja99sCT1wuU=;
        b=VSzYUlN3Ldhn4NB5j0uyowBg5nvhP6Oxd2m0uufrM6d99+XR50cGcDHqNsgFlKVvv+
         b3oj6LbDajxJn/494tJGrAsX1+ebJn7B3GavemC+4CGZ+MpiwPC8vLUmrczqKeIsxGJB
         d96EmNqIH66deTRcPybewfupt2XzQQNePNby/Kscc8tClBnH0/LejSlEk4U9jIrNftWV
         /QK+xdyQUd67Q1+JhTK20cDYVIU+8WleMEUF8b7RdXCugX/sDC32pIby4rYiiHl3j1Pp
         0EmRiQEQ0DhXJoEPZK1dQprRlxRwE0S7hNI31JJmStZyDZzQfK5dHqqTsO3ciepbH8vP
         m3qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791634919; x=1792239719;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=+TWFeRXhI9U2gCQnYURwRZ/xBRhQqIxrja99sCT1wuU=;
        b=In3ltAf32SFLZ2nvC7MkHp8ijpT+j6dE2kYz9VC46af/kqJSWrU05bqy2q1LSyQ4m2
         KBYXlK5q7w9WX2BT/IH5g3Nxu8sIccaQ6VzN/ZzbwtGf+XFDvhef1Q1XwRco8x/GRBcn
         c64E+rmPY6IzkE+hgAax/onYTFOXgfpWvCeKPuJ4d+pCaoutmQGbmxI67eYAHEB8U4p5
         Kq13XZkkUoLtD3SZAyqzNC/52Vl6grlB6Fya4XDC7ImsgqcYDS7HSPD96vT7bybzPkXp
         yhMyezd3bwbvMHeniSz7lKoCL4YoFwY2O9iqBLE2RVeSAvUj1WKDdI6pIUfcVC4VfmyP
         thxg==
X-Gm-Message-State: AFq9FYIqghrzxrmecDGCmsK6jSZcmG3R+L1NqIDbe+V67R1dL06c9R5t
	91ZrWTlhZw8k9hYlJMDoiy7Yd5B+JbIojsthCO/8vh/1P9nx2j+4fW3Igjc/BE5o
X-Gm-Gg: AYBFou2XxLMFYrPDhzf9zhAsmukJKcOHnxDmjJt122cndnlSOe2kHWMdsddjRmUeaax
	pN/CXXipcDlDOckNRsEtiDOg7f2mDCmxTGccHu21AqOnDauRPSblRL1ExpoCqWxI/ir3iUlmM70
	Fghb2oTg4Fs4/eYpEpWUCRzD6z0oUw1KNTsiOVtHtNOotbtcs9q3WQZDR0xvPxGx3AO7NGrLTPi
	/yfoM710yWdbfAiZIeG0xU0wqhCsb04kq24b+T/ZSkb7Jl9FvcZJlJxS8ujOUSluaLHW6OAjjz/
	zb4t+SEPES9DFJU9n9EFdX3csas8YWZD/A6Y+EebMvT4pqqXK47Y+9xbmCZezeHr3fsiztv7jg+
	LDOBTs64zCJN4MpOq1jtS8xU0Krb9K9eW6PLnFmH5dcxBZXVwVVrcVGHkdzM/eF75/3zxakJfPC
	1wlne0OqW/jNZmgurDOMjfjQFK1q193WIdHUpeDVI9XEq7V4USZMMD7If/DcZlpSwvzKTQa63Bn
	tEw9jgjH9k6f9JKL+25HnSGHqgD+9Pro4GLJrnxaGZkm95fK6J3wR8aP+Es
X-Received: by 2002:a05:7022:1507:b0:15b:53a4:3495 with SMTP id a92af1059eb24-16a60bf1f13mr8414869c88.35.1791634919405;
        Sat, 10 Oct 2026 05:21:59 -0700 (PDT)
Received: from pve-server.rlab ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-169a1becf08sm15401816c88.5.2026.10.10.05.21.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Oct 2026 05:21:58 -0700 (PDT)
From: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Christophe Leroy <chleroy@kernel.org>,
	Venkat Rao Bagalkote <venkat88@linux.ibm.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	linux-kernel@vger.kernel.org,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Subject: [RFC 2/4] powerpc/64s/radix: Implement ARCH_HAS_SET_DIRECT_MAP
Date: Sat, 10 Oct 2026 17:51:10 +0530
Message-Id: <744ed18f924d7aeb1a92993e90971120f0b7d4d4.1791608423.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <cover.1791608423.git.ritesh.list@gmail.com>
References: <cover.1791608423.git.ritesh.list@gmail.com>
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

memfd_secret() keeps a secret by taking its page out of the kernel
linear map. The process that owns the page can still read and write it
through its own mapping, but the kernel no longer has a translation for
that physical page, so a kernel read or a speculative walk of the linear
map cannot see it.

Note that set_memory_np() and set_memory_p() already clear and restore the
present bit for debug_pagealloc and KFENCE, so the same direct-map helpers
are used here to implement ARCH_HAS_SET_DIRECT_MAP for radix.

Note that they can only run when the linear map is already made of base
pages. For implementing this feature when the linear map is mapped with
2M (PMD) or 1G (PUD) mapping - a 2M or 1G leaf would have to be broken
into PTEs first and doing that while the large translation is still in
the TLB installs a second translation for the same address at
a different page size.

On this, the processor architecture manual says that it is fatal:
  If a given virtual address is mapped by two overlapping pages of
  different sizes (for example, a small page is mapped initially but is
  later re-mapped into a larger page without invalidating the original
  TLB entry), a machine check interrupt can result with an indication
  that either a parity error or a multi-hit occurred when the TLB was
  accessed to translate the address. The error condition can be
  corrected by invalidating the entire TLB and SLB.

The same multi-hit applies if the large page was installed first and is
then replaced by PTEs without invalidating that TLB entry. Since today
there is no support for doing that split safely, so can_set_direct_map()
stays false unless the linear map is already page-sized.

Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 arch/powerpc/Kconfig                  |  1 +
 arch/powerpc/include/asm/set_memory.h |  9 +++
 arch/powerpc/mm/pageattr.c            | 96 +++++++++++++++++++++++++++
 3 files changed, 106 insertions(+)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 2580e27e4328..3c5c07c67a5b 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -150,6 +150,7 @@ config PPC
 	select ARCH_HAS_PTDUMP
 	select ARCH_HAS_PTE_SPECIAL
 	select ARCH_HAS_SCALED_CPUTIME		if VIRT_CPU_ACCOUNTING_NATIVE && PPC_BOOK3S_64
+	select ARCH_HAS_SET_DIRECT_MAP		if PPC_RADIX_MMU
 	select ARCH_HAS_SET_MEMORY
 	select ARCH_HAS_STRICT_KERNEL_RWX	if (PPC_BOOK3S || PPC_8xx) && !HIBERNATION
 	select ARCH_HAS_STRICT_KERNEL_RWX	if PPC_85xx && !HIBERNATION && !RANDOMIZE_BASE
diff --git a/arch/powerpc/include/asm/set_memory.h b/arch/powerpc/include/asm/set_memory.h
index 9c8d5747755d..24779c00c1ca 100644
--- a/arch/powerpc/include/asm/set_memory.h
+++ b/arch/powerpc/include/asm/set_memory.h
@@ -48,4 +48,13 @@ static inline int __must_check set_memory_rox(unsigned long addr, int numpages)
 }
 #define set_memory_rox set_memory_rox

+#ifdef CONFIG_ARCH_HAS_SET_DIRECT_MAP
+bool can_set_direct_map(void);
+#define can_set_direct_map can_set_direct_map
+
+int set_direct_map_invalid_noflush(struct page *page, unsigned int numpages);
+int set_direct_map_default_noflush(struct page *page, unsigned int numpages);
+bool kernel_page_present(struct page *page);
+#endif
+
 #endif
diff --git a/arch/powerpc/mm/pageattr.c b/arch/powerpc/mm/pageattr.c
index ac22bf28086f..a85ac2419e6d 100644
--- a/arch/powerpc/mm/pageattr.c
+++ b/arch/powerpc/mm/pageattr.c
@@ -103,6 +103,102 @@ int change_memory_attr(unsigned long addr, int numpages, long action)
 					    change_page_attr, (void *)action);
 }

+#ifdef CONFIG_ARCH_HAS_SET_DIRECT_MAP
+/*
+ * Removing a single page from the linear mapping requires that the linear
+ * mapping is built out of PAGE_SIZE mappings in the first place. Radix only
+ * does that when explicitly asked to and there is no support for splitting
+ * a live 2M/1G mapping yet.
+ * TODO: Hash is also not supported yet.
+ */
+bool can_set_direct_map(void)
+{
+	if (!radix_enabled())
+		return false;
+
+	return linear_map_uses_base_pagesize();
+}
+
+/*
+ * Note that the set_memory_p()/set_memory_np() helpers below already flush the
+ * TLB for the range they touch, so the _noflush() naming is not honoured
+ * literally here.
+ * Since as of now this is not in the performance path, so it should be ok.
+ * Later, once the support for breaking the large mappings (PUD/PMD) into PTE is
+ * added, then this can be improved since it will anyway require a custom
+ * implementation for walking the page table and breaking the mapping.
+ */
+int set_direct_map_invalid_noflush(struct page *page, unsigned int numpages)
+{
+	unsigned long addr = (unsigned long)page_address(page);
+
+	if (!can_set_direct_map())
+		return 0;
+
+	return set_memory_np(addr, numpages);
+}
+
+int set_direct_map_default_noflush(struct page *page, unsigned int numpages)
+{
+	unsigned long addr = (unsigned long)page_address(page);
+
+	if (!can_set_direct_map())
+		return 0;
+
+	return set_memory_p(addr, numpages);
+}
+
+/*
+ * Walk the kernel page table looking for the entry that translates @addr.
+ * Currently secretmemfd is the only usecase for this.
+ */
+static bool radix_page_present(unsigned long addr)
+{
+	pgd_t *pgdp;
+	p4d_t *p4dp, p4d;
+	pud_t *pudp, pud;
+	pmd_t *pmdp, pmd;
+	pte_t *ptep;
+
+	pgdp = pgd_offset_k(addr);
+
+	p4dp = p4d_offset(pgdp, addr);
+	p4d = READ_ONCE(*p4dp);
+	if (p4d_none(p4d))
+		return false;
+
+	pudp = pud_offset(p4dp, addr);
+	pud = READ_ONCE(*pudp);
+	if (pud_none(pud))
+		return false;
+	if (pud_leaf(pud))
+		return pud_present(pud);
+
+	pmdp = pmd_offset(pudp, addr);
+	pmd = READ_ONCE(*pmdp);
+	if (pmd_none(pmd))
+		return false;
+	if (pmd_leaf(pmd))
+		return pmd_present(pmd);
+
+	ptep = pte_offset_kernel(pmdp, addr);
+	return pte_hw_valid(ptep_get(ptep));
+}
+
+bool kernel_page_present(struct page *page)
+{
+	/*
+	 * Nothing ever removes entries from the linear mapping in this
+	 * configuration, so everything is present.
+	 */
+	if (!can_set_direct_map())
+		return true;
+
+	return radix_page_present((unsigned long)page_address(page));
+}
+#endif /* CONFIG_ARCH_HAS_SET_DIRECT_MAP */
+
+
 #if defined(CONFIG_DEBUG_PAGEALLOC) || defined(CONFIG_KFENCE)
 #ifdef CONFIG_ARCH_SUPPORTS_DEBUG_PAGEALLOC
 void __kernel_map_pages(struct page *page, int numpages, int enable)
--
2.39.5


