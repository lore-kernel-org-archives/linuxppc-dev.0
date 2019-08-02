Return-Path: <SRS0=WT2w=V6=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E116C32750
	for <linuxppc-dev@archiver.kernel.org>; Fri,  2 Aug 2019 04:22:53 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 236F1206A2
	for <linuxppc-dev@archiver.kernel.org>; Fri,  2 Aug 2019 04:22:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 236F1206A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=informatik.wtf
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 460DXp1c3tzDqwW
	for <linuxppc-dev@archiver.kernel.org>; Fri,  2 Aug 2019 14:22:50 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 460DT20SbVzDqkV
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  2 Aug 2019 14:19:34 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=informatik.wtf
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 460DT16lyVz8t7p
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  2 Aug 2019 14:19:33 +1000 (AEST)
Received: by ozlabs.org (Postfix)
 id 460DT16TjZz9sBF; Fri,  2 Aug 2019 14:19:33 +1000 (AEST)
Authentication-Results: ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=informatik.wtf
 (client-ip=131.153.2.44; helo=h3.fbrelay.privateemail.com;
 envelope-from=cmr@informatik.wtf; receiver=<UNKNOWN>)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none)
 header.from=informatik.wtf
Received: from h3.fbrelay.privateemail.com (h3.fbrelay.privateemail.com
 [131.153.2.44])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 460DT14C44z9s3Z
 for <linuxppc-dev@ozlabs.org>; Fri,  2 Aug 2019 14:19:33 +1000 (AEST)
Received: from MTA-06-3.privateemail.com (mta-06.privateemail.com
 [68.65.122.16])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by h3.fbrelay.privateemail.com (Postfix) with ESMTPS id DE55B81615
 for <linuxppc-dev@ozlabs.org>; Fri,  2 Aug 2019 00:19:30 -0400 (EDT)
Received: from MTA-06.privateemail.com (localhost [127.0.0.1])
 by MTA-06.privateemail.com (Postfix) with ESMTP id 8E10D6003D;
 Fri,  2 Aug 2019 00:19:27 -0400 (EDT)
Received: from wrwlf0000.attlocal.net (unknown [10.20.151.234])
 by MTA-06.privateemail.com (Postfix) with ESMTPA id 26B9460039;
 Fri,  2 Aug 2019 04:19:27 +0000 (UTC)
From: "Christopher M. Riedl" <cmr@informatik.wtf>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH v2 2/3] powerpc/spinlocks: Rename SPLPAR-only spinlocks
Date: Thu,  1 Aug 2019 23:22:32 -0500
Message-Id: <20190802042233.20835-3-cmr@informatik.wtf>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190802042233.20835-1-cmr@informatik.wtf>
References: <20190802042233.20835-1-cmr@informatik.wtf>
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
Cc: "Christopher M. Riedl" <cmr@informatik.wtf>, ajd@linux.ibm.com,
 bauerman@linux.ibm.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

The __rw_yield and __spin_yield locks only pertain to SPLPAR mode.
Rename them to make this relationship obvious.

Signed-off-by: Christopher M. Riedl <cmr@informatik.wtf>
Reviewed-by: Andrew Donnellan <ajd@linux.ibm.com>
---
 arch/powerpc/include/asm/spinlock.h | 6 ++++--
 arch/powerpc/lib/locks.c            | 6 +++---
 2 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/include/asm/spinlock.h b/arch/powerpc/include/asm/spinlock.h
index dc5fcea1f006..0a8270183770 100644
--- a/arch/powerpc/include/asm/spinlock.h
+++ b/arch/powerpc/include/asm/spinlock.h
@@ -101,8 +101,10 @@ static inline int arch_spin_trylock(arch_spinlock_t *lock)
 
 #if defined(CONFIG_PPC_SPLPAR)
 /* We only yield to the hypervisor if we are in shared processor mode */
-extern void __spin_yield(arch_spinlock_t *lock);
-extern void __rw_yield(arch_rwlock_t *lock);
+void splpar_spin_yield(arch_spinlock_t *lock);
+void splpar_rw_yield(arch_rwlock_t *lock);
+#define __spin_yield(x) splpar_spin_yield(x)
+#define __rw_yield(x) splpar_rw_yield(x)
 #else /* SPLPAR */
 #define __spin_yield(x)	barrier()
 #define __rw_yield(x)	barrier()
diff --git a/arch/powerpc/lib/locks.c b/arch/powerpc/lib/locks.c
index 6550b9e5ce5f..6440d5943c00 100644
--- a/arch/powerpc/lib/locks.c
+++ b/arch/powerpc/lib/locks.c
@@ -18,7 +18,7 @@
 #include <asm/hvcall.h>
 #include <asm/smp.h>
 
-void __spin_yield(arch_spinlock_t *lock)
+void splpar_spin_yield(arch_spinlock_t *lock)
 {
 	unsigned int lock_value, holder_cpu, yield_count;
 
@@ -36,14 +36,14 @@ void __spin_yield(arch_spinlock_t *lock)
 	plpar_hcall_norets(H_CONFER,
 		get_hard_smp_processor_id(holder_cpu), yield_count);
 }
-EXPORT_SYMBOL_GPL(__spin_yield);
+EXPORT_SYMBOL_GPL(splpar_spin_yield);
 
 /*
  * Waiting for a read lock or a write lock on a rwlock...
  * This turns out to be the same for read and write locks, since
  * we only know the holder if it is write-locked.
  */
-void __rw_yield(arch_rwlock_t *rw)
+void splpar_rw_yield(arch_rwlock_t *rw)
 {
 	int lock_value;
 	unsigned int holder_cpu, yield_count;
-- 
2.22.0

