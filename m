Return-Path: <SRS0=sLSx=7Q=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61B43C433E1
	for <linuxppc-dev@archiver.kernel.org>; Wed,  3 Jun 2020 05:25:01 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A6475206E6
	for <linuxppc-dev@archiver.kernel.org>; Wed,  3 Jun 2020 05:25:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6475206E6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=informatik.wtf
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 49cHRG2sYBzDqd0
	for <linuxppc-dev@archiver.kernel.org>; Wed,  3 Jun 2020 15:24:58 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=informatik.wtf (client-ip=131.153.2.45;
 helo=h4.fbrelay.privateemail.com; envelope-from=cmr@informatik.wtf;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=informatik.wtf
Received: from h4.fbrelay.privateemail.com (h4.fbrelay.privateemail.com
 [131.153.2.45])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 49cHH10w06zDqTF
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  3 Jun 2020 15:17:48 +1000 (AEST)
Received: from MTA-07-4.privateemail.com (mta-07.privateemail.com
 [198.54.127.57])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by h3.fbrelay.privateemail.com (Postfix) with ESMTPS id 665A980ADB
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  3 Jun 2020 01:17:45 -0400 (EDT)
Received: from MTA-07.privateemail.com (localhost [127.0.0.1])
 by MTA-07.privateemail.com (Postfix) with ESMTP id E0A8560046;
 Wed,  3 Jun 2020 01:17:36 -0400 (EDT)
Received: from geist.attlocal.net (unknown [10.20.151.239])
 by MTA-07.privateemail.com (Postfix) with ESMTPA id C5F7E6004E;
 Wed,  3 Jun 2020 05:17:35 +0000 (UTC)
From: "Christopher M. Riedl" <cmr@informatik.wtf>
To: linuxppc-dev@lists.ozlabs.org,
	kernel-hardening@lists.openwall.com
Subject: [PATCH 2/5] powerpc/lib: Initialize a temporary mm for code patching
Date: Wed,  3 Jun 2020 00:19:09 -0500
Message-Id: <20200603051912.23296-3-cmr@informatik.wtf>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200603051912.23296-1-cmr@informatik.wtf>
References: <20200603051912.23296-1-cmr@informatik.wtf>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP
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
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

When code patching a STRICT_KERNEL_RWX kernel the page containing the
address to be patched is temporarily mapped with permissive memory
protections. Currently, a per-cpu vmalloc patch area is used for this
purpose. While the patch area is per-cpu, the temporary page mapping is
inserted into the kernel page tables for the duration of the patching.
The mapping is exposed to CPUs other than the patching CPU - this is
undesirable from a hardening perspective.

Use the `poking_init` init hook to prepare a temporary mm and patching
address. Initialize the temporary mm by copying the init mm. Choose a
randomized patching address inside the temporary mm userspace address
portion. The next patch uses the temporary mm and patching address for
code patching.

Based on x86 implementation:

commit 4fc19708b165
("x86/alternatives: Initialize temporary mm for patching")

Signed-off-by: Christopher M. Riedl <cmr@informatik.wtf>
---
 arch/powerpc/lib/code-patching.c | 33 ++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/arch/powerpc/lib/code-patching.c b/arch/powerpc/lib/code-patching.c
index 5ecf0d635a8d..599114f63b44 100644
--- a/arch/powerpc/lib/code-patching.c
+++ b/arch/powerpc/lib/code-patching.c
@@ -11,6 +11,8 @@
 #include <linux/cpuhotplug.h>
 #include <linux/slab.h>
 #include <linux/uaccess.h>
+#include <linux/sched/task.h>
+#include <linux/random.h>
 
 #include <asm/pgtable.h>
 #include <asm/tlbflush.h>
@@ -45,6 +47,37 @@ int raw_patch_instruction(struct ppc_inst *addr, struct ppc_inst instr)
 }
 
 #ifdef CONFIG_STRICT_KERNEL_RWX
+
+static struct mm_struct *patching_mm __ro_after_init;
+static unsigned long patching_addr __ro_after_init;
+
+void __init poking_init(void)
+{
+	spinlock_t *ptl; /* for protecting pte table */
+	pte_t *ptep;
+
+	/*
+	 * Some parts of the kernel (static keys for example) depend on
+	 * successful code patching. Code patching under STRICT_KERNEL_RWX
+	 * requires this setup - otherwise we cannot patch at all. We use
+	 * BUG_ON() here and later since an early failure is preferred to
+	 * buggy behavior and/or strange crashes later.
+	 */
+	patching_mm = copy_init_mm();
+	BUG_ON(!patching_mm);
+
+	/*
+	 * In hash we cannot go above DEFAULT_MAP_WINDOW easily.
+	 * XXX: Do we want additional bits of entropy for radix?
+	 */
+	patching_addr = (get_random_long() & PAGE_MASK) %
+		(DEFAULT_MAP_WINDOW - PAGE_SIZE);
+
+	ptep = get_locked_pte(patching_mm, patching_addr, &ptl);
+	BUG_ON(!ptep);
+	pte_unmap_unlock(ptep, ptl);
+}
+
 static DEFINE_PER_CPU(struct vm_struct *, text_poke_area);
 
 static int text_area_cpu_up(unsigned int cpu)
-- 
2.26.2

