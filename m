Return-Path: <SRS0=TQYx=NT=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81239ECDE4B
	for <linuxppc-dev@archiver.kernel.org>; Thu,  8 Nov 2018 20:54:16 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E058F20825
	for <linuxppc-dev@archiver.kernel.org>; Thu,  8 Nov 2018 20:54:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="VLb+fI0e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E058F20825
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42rb9x6zJSzF3RN
	for <linuxppc-dev@archiver.kernel.org>; Fri,  9 Nov 2018 07:54:13 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="VLb+fI0e";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=joelfernandes.org
 (client-ip=2607:f8b0:4864:20::443; helo=mail-pf1-x443.google.com;
 envelope-from=joel@joelfernandes.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=joelfernandes.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=joelfernandes.org header.i=@joelfernandes.org
 header.b="VLb+fI0e"; dkim-atps=neutral
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com
 [IPv6:2607:f8b0:4864:20::443])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42rWb641GMzF3Rs
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  9 Nov 2018 05:12:18 +1100 (AEDT)
Received: by mail-pf1-x443.google.com with SMTP id y18-v6so7261776pfn.1
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 08 Nov 2018 10:12:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=joelfernandes.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=BRzIw96c42MBsppp+UtkS27cZw2ziHLGOZAWHCwUwkU=;
 b=VLb+fI0e5CupBhLX7SEpqp6aMYCEmrno2/+PWx1Fj5vgMnrhqgQj4nIpkri0wUpbG8
 F4GPWoT5NbHXAaJTdGVfn6zckMlMvaTWgcceAQNHhxzEznYU/sGs1Oziz5WMuk+Y2lPY
 nZdjL8GBrbofS49q8gzGHo1DibcI7hQLaT5lY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=BRzIw96c42MBsppp+UtkS27cZw2ziHLGOZAWHCwUwkU=;
 b=uJQlvFvLXPnTDugpCpJb4pZMGTIFzQBCNRHRT4rDb7I7gnrz9TZ9+nY0GBfLvJCgjm
 RqQTvs9XERnl3/OQQhCetC9nnvh5/kslk/P0kHR0IBxzMmYjfcaFudnfBw3oP0Oj5CcD
 h02D415OA7pUKS1E2WUEARHd99lrZkoKGit8Rds7sE9ydGj7hxtMH5tXhldbj+SVxaGm
 czHZo/g1/X8+vARhtED76kEztM+dhlF7rklJJtUpfrjLGiNXMqSF0YAsDsLa5+3XldW8
 2yODyYtNft3bFb+oAd45WcMT/1gZzaFK67Go1zol8uePbZzxqhegG/Znx/VKx1oa7gaH
 qCQQ==
X-Gm-Message-State: AGRZ1gLzKXfHD4JB1QyE51EMzMeuxwFKJ3MTeT+O2Afllv2AP52pDdO6
 M7sdUHkdaL4rBbxY0wB7vd/iaA==
X-Google-Smtp-Source: AJdET5d03oyVAX8rvXz4lqxLxyGhZaxEcaDz6tsUNfJPuVe8tAAaxUTzs4svhnT0ivYmEFumZgA8Jg==
X-Received: by 2002:a63:2b01:: with SMTP id r1mr4588917pgr.432.1541700736301; 
 Thu, 08 Nov 2018 10:12:16 -0800 (PST)
Received: from joelaf.mtv.corp.google.com
 ([2620:0:1000:1601:3aef:314f:b9ea:889f])
 by smtp.gmail.com with ESMTPSA id 64-v6sm10028533pfa.120.2018.11.08.10.12.13
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 08 Nov 2018 10:12:15 -0800 (PST)
From: Joel Fernandes <joel@joelfernandes.org>
X-Google-Original-From: Joel Fernandes <joelaf@google.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH -next-akpm 2/3] mm: speed up mremap by 20x on large regions
 (v5)
Date: Thu,  8 Nov 2018 10:12:00 -0800
Message-Id: <20181108181201.88826-3-joelaf@google.com>
X-Mailer: git-send-email 2.19.1.930.g4563a0d9d0-goog
In-Reply-To: <20181108181201.88826-1-joelaf@google.com>
References: <20181108181201.88826-1-joelaf@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 09 Nov 2018 07:47:52 +1100
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: linux-mips@linux-mips.org, Rich Felker <dalias@libc.org>,
 linux-ia64@vger.kernel.org, linux-sh@vger.kernel.org,
 Peter Zijlstra <peterz@infradead.org>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Dave Hansen <dave.hansen@linux.intel.com>, Will Deacon <will.deacon@arm.com>,
 Michal Hocko <mhocko@kernel.org>,
 William Kucharski <william.kucharski@oracle.com>, lokeshgidra@google.com,
 "Joel Fernandes \(Google\)" <joel@joelfernandes.org>,
 linux-riscv@lists.infradead.org, anton.ivanov@kot-begemot.co.uk,
 Jonas Bonn <jonas@southpole.se>, linux-s390@vger.kernel.org, dancol@google.com,
 Yoshinori Sato <ysato@users.sourceforge.jp>, sparclinux@vger.kernel.org,
 linux-xtensa@linux-xtensa.org, linux-hexagon@vger.kernel.org,
 Helge Deller <deller@gmx.de>,
 "maintainer:X86 ARCHITECTURE 32-BIT AND 64-BIT" <x86@kernel.org>,
 hughd@google.com, "James E.J. Bottomley" <jejb@parisc-linux.org>,
 kasan-dev@googlegroups.com, kvmarm@lists.cs.columbia.edu,
 Ingo Molnar <mingo@redhat.com>, Geert Uytterhoeven <geert@linux-m68k.org>,
 Andrey Ryabinin <aryabinin@virtuozzo.com>, linux-snps-arc@lists.infradead.org,
 kernel-team@android.com, Sam Creasey <sammy@sammy.net>,
 Fenghua Yu <fenghua.yu@intel.com>, Jeff Dike <jdike@addtoit.com>,
 linux-um@lists.infradead.org,
 Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
 Julia Lawall <Julia.Lawall@lip6.fr>, linux-m68k@lists.linux-m68k.org,
 Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>,
 nios2-dev@lists.rocketboards.org, "Kirill A . Shutemov" <kirill@shutemov.name>,
 Stafford Horne <shorne@gmail.com>, Guan Xuetao <gxt@pku.edu.cn>,
 Chris Zankel <chris@zankel.net>, Tony Luck <tony.luck@intel.com>,
 Richard Weinberger <richard@nod.at>, linux-parisc@vger.kernel.org,
 linux-mm@kvack.org, Max Filippov <jcmvbkbc@gmail.com>, pantin@google.com,
 minchan@kernel.org, Thomas Gleixner <tglx@linutronix.de>,
 linux-alpha@vger.kernel.org, Ley Foon Tan <lftan@altera.com>,
 akpm@linux-foundation.org, linuxppc-dev@lists.ozlabs.org,
 "David S. Miller" <davem@davemloft.net>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

From: "Joel Fernandes (Google)" <joel@joelfernandes.org>

Android needs to mremap large regions of memory during memory management
related operations. The mremap system call can be really slow if THP is
not enabled. The bottleneck is move_page_tables, which is copying each
pte at a time, and can be really slow across a large map. Turning on THP
may not be a viable option, and is not for us. This patch speeds up the
performance for non-THP system by copying at the PMD level when possible.

The speed up is an order of magnitude on x86 (~20x). On a 1GB mremap,
the mremap completion times drops from 3.4-3.6 milliseconds to 144-160
microseconds.

Before:
Total mremap time for 1GB data: 3521942 nanoseconds.
Total mremap time for 1GB data: 3449229 nanoseconds.
Total mremap time for 1GB data: 3488230 nanoseconds.

After:
Total mremap time for 1GB data: 150279 nanoseconds.
Total mremap time for 1GB data: 144665 nanoseconds.
Total mremap time for 1GB data: 158708 nanoseconds.

Incase THP is enabled, the optimization is mostly skipped except in
certain situations.

Acked-by: Kirill A. Shutemov <kirill@shutemov.name>
Reviewed-by: William Kucharski <william.kucharski@oracle.com>
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---

Note that since the bug fix in [1], we now have to flush the TLB every
PMD move. The above numbers were obtained on x86 with a flush done every
move. For arm64, I previously encountered performance issues doing a
flush everytime we move, however Will Deacon says [2] the performance
should be better now with recent release. Until we can evaluate arm64, I
am dropping the HAVE_MOVE_PMD config enable patch for ARM64 for now. It
can be added back once we finish the performance evaluation. Also of
note is that the speed up on arm64 with this patch but without the TLB
flush every PMD move is around 500x.

[1] https://bugs.chromium.org/p/project-zero/issues/detail?id=1695
[2] https://www.mail-archive.com/linuxppc-dev@lists.ozlabs.org/msg140837.html

 arch/Kconfig |  5 +++++
 mm/mremap.c  | 62 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 67 insertions(+)

diff --git a/arch/Kconfig b/arch/Kconfig
index e1e540ffa979..b70c952ac838 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -535,6 +535,11 @@ config HAVE_IRQ_TIME_ACCOUNTING
 	  Archs need to ensure they use a high enough resolution clock to
 	  support irq time accounting and then call enable_sched_clock_irqtime().
 
+config HAVE_MOVE_PMD
+	bool
+	help
+	  Archs that select this are able to move page tables at the PMD level.
+
 config HAVE_ARCH_TRANSPARENT_HUGEPAGE
 	bool
 
diff --git a/mm/mremap.c b/mm/mremap.c
index 7c9ab747f19d..2591e512373a 100644
--- a/mm/mremap.c
+++ b/mm/mremap.c
@@ -191,6 +191,50 @@ static void move_ptes(struct vm_area_struct *vma, pmd_t *old_pmd,
 		drop_rmap_locks(vma);
 }
 
+static bool move_normal_pmd(struct vm_area_struct *vma, unsigned long old_addr,
+		  unsigned long new_addr, unsigned long old_end,
+		  pmd_t *old_pmd, pmd_t *new_pmd)
+{
+	spinlock_t *old_ptl, *new_ptl;
+	struct mm_struct *mm = vma->vm_mm;
+	pmd_t pmd;
+
+	if ((old_addr & ~PMD_MASK) || (new_addr & ~PMD_MASK)
+	    || old_end - old_addr < PMD_SIZE)
+		return false;
+
+	/*
+	 * The destination pmd shouldn't be established, free_pgtables()
+	 * should have release it.
+	 */
+	if (WARN_ON(!pmd_none(*new_pmd)))
+		return false;
+
+	/*
+	 * We don't have to worry about the ordering of src and dst
+	 * ptlocks because exclusive mmap_sem prevents deadlock.
+	 */
+	old_ptl = pmd_lock(vma->vm_mm, old_pmd);
+	new_ptl = pmd_lockptr(mm, new_pmd);
+	if (new_ptl != old_ptl)
+		spin_lock_nested(new_ptl, SINGLE_DEPTH_NESTING);
+
+	/* Clear the pmd */
+	pmd = *old_pmd;
+	pmd_clear(old_pmd);
+
+	VM_BUG_ON(!pmd_none(*new_pmd));
+
+	/* Set the new pmd */
+	set_pmd_at(mm, new_addr, new_pmd, pmd);
+	flush_tlb_range(vma, old_addr, old_addr + PMD_SIZE);
+	if (new_ptl != old_ptl)
+		spin_unlock(new_ptl);
+	spin_unlock(old_ptl);
+
+	return true;
+}
+
 unsigned long move_page_tables(struct vm_area_struct *vma,
 		unsigned long old_addr, struct vm_area_struct *new_vma,
 		unsigned long new_addr, unsigned long len,
@@ -237,7 +281,25 @@ unsigned long move_page_tables(struct vm_area_struct *vma,
 			split_huge_pmd(vma, old_pmd, old_addr);
 			if (pmd_trans_unstable(old_pmd))
 				continue;
+		} else if (extent == PMD_SIZE) {
+#ifdef CONFIG_HAVE_MOVE_PMD
+			/*
+			 * If the extent is PMD-sized, try to speed the move by
+			 * moving at the PMD level if possible.
+			 */
+			bool moved;
+
+			if (need_rmap_locks)
+				take_rmap_locks(vma);
+			moved = move_normal_pmd(vma, old_addr, new_addr,
+					old_end, old_pmd, new_pmd);
+			if (need_rmap_locks)
+				drop_rmap_locks(vma);
+			if (moved)
+				continue;
+#endif
 		}
+
 		if (pte_alloc(new_vma->vm_mm, new_pmd))
 			break;
 		next = (new_addr + PMD_SIZE) & PMD_MASK;
-- 
2.19.1.930.g4563a0d9d0-goog
