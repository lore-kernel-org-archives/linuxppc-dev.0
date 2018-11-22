Return-Path: <SRS0=R24o=OB=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04393C43441
	for <linuxppc-dev@archiver.kernel.org>; Thu, 22 Nov 2018 14:11:00 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 71C5A206B2
	for <linuxppc-dev@archiver.kernel.org>; Thu, 22 Nov 2018 14:10:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Ymtgguo0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 71C5A206B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=russell.cc
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4311Z95rZ1zDqPc
	for <linuxppc-dev@archiver.kernel.org>; Fri, 23 Nov 2018 01:10:57 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=russell.cc
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="Ymtgguo0";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (helo)
 smtp.helo=wout2-smtp.messagingengine.com (client-ip=64.147.123.25;
 helo=wout2-smtp.messagingengine.com; envelope-from=ruscur@russell.cc;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=russell.cc
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=messagingengine.com header.i=@messagingengine.com
 header.b="Ymtgguo0"; dkim-atps=neutral
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com
 [64.147.123.25])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4311QW1rwtzDqP5
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Nov 2018 01:04:16 +1100 (AEDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
 by mailout.west.internal (Postfix) with ESMTP id 34965802;
 Thu, 22 Nov 2018 09:04:12 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
 by compute6.internal (MEProxy); Thu, 22 Nov 2018 09:04:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:date:from
 :in-reply-to:message-id:mime-version:references:subject:to
 :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm1; bh=MXrzjh44bxWUE/c6WLXOS7ozsDiz4pdVGW2F0pHHyT0=; b=Ymtgguo0
 nA5dfa7+y+xAFq1ZX5PyOEBkrzfkBJTvno7cayJQ9rp37RMLXBLYitaqH8rnjPDJ
 ETuHHevf5qwOpElhcSFtS9P8rqBuvNU6ed2uS6yIdw1y0wUBq50OsgDRjpcotfhT
 pk0Chs7RX/2S2WztRrlT6I/aghsv9zdqYJCPse+vtWNyBnK/tTW0wPmdZci7DVj+
 ylDdwA5HfQmEp/WhHBqvJmNT3UzU6PWyRR//ndZyXc77wa5tFEHGgsxoTeWG+zOc
 ii9QDuLYeeBeW1932RkZ+jlBW3sBdrI/ZTzmciTBQYHEQ9p3gBCFGDjNrycIWDdy
 38aK+YT3WUVqgA==
X-ME-Sender: <xms:W7f2W8fpctZ54YfOgUvOgdx0rjuaKjV-CiLDFNBj5u0Fdak72FMExQ>
X-ME-Proxy: <xmx:W7f2WyLJZ5NagZav5MK3IPK0dPh22oqOyeiAT4CbSoDVO-8j4Kc46Q>
 <xmx:W7f2W7_9CGuAlqM_XoG2T1ss2xwLWfSCs19aVg44IBKINkAeIS_nxw>
 <xmx:W7f2Wx3C5ktCZstS2syS3fn8hCGf8tHQDbhKgJ6Oocr4ISSQ1hjI6w>
 <xmx:W7f2W6s9PJAURD8NyIb7xysNHpVncYOAIn2SYmP1LnCvdFlGxd7nyw>
 <xmx:W7f2W2K17S4A3wSZ6fNzvt8qMy9FJtcV39l5JAicXK9jktA1Qm8uTw>
 <xmx:W7f2Wxm1TRUDpJmsR5st8Ux2TRpUq6gfx6i8S9kJuQcQC0LNRFx9sw>
Received: from crackle.ozlabs.ibm.com.com (124-171-154-44.dyn.iinet.net.au
 [124.171.154.44])
 by mail.messagingengine.com (Postfix) with ESMTPA id C6B7710304;
 Thu, 22 Nov 2018 09:04:08 -0500 (EST)
From: Russell Currey <ruscur@russell.cc>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 1/4] powerpc: Track KUAP state in the PACA
Date: Fri, 23 Nov 2018 01:04:13 +1100
Message-Id: <20181122140416.3447-2-ruscur@russell.cc>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181122140416.3447-1-ruscur@russell.cc>
References: <20181122140416.3447-1-ruscur@russell.cc>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
Cc: kernel-hardening@lists.openwall.com, Russell Currey <ruscur@russell.cc>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Necessary for subsequent patches that enable KUAP support for radix.
Could plausibly be useful for other platforms too, if similar to the
radix case, reading the register that manages these accesses is
costly.

Has the unfortunate downside of another layer of abstraction for
platforms that implement the locks and unlocks, but this could be
useful in future for other things too, like counters for benchmarking
or smartly handling lots of small accesses at once.

Signed-off-by: Russell Currey <ruscur@russell.cc>
---
this is all because I can't do PACA things from radix.h and I spent
an hour figuring this out at midnight
---
 arch/powerpc/include/asm/nohash/32/pte-8xx.h |  8 +++----
 arch/powerpc/include/asm/paca.h              |  3 +++
 arch/powerpc/include/asm/uaccess.h           | 23 +++++++++++++++++++-
 arch/powerpc/kernel/asm-offsets.c            |  1 +
 4 files changed, 30 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/include/asm/nohash/32/pte-8xx.h b/arch/powerpc/include/asm/nohash/32/pte-8xx.h
index f1ec7cf949d5..7bc0955a56e9 100644
--- a/arch/powerpc/include/asm/nohash/32/pte-8xx.h
+++ b/arch/powerpc/include/asm/nohash/32/pte-8xx.h
@@ -137,22 +137,22 @@ static inline pte_t pte_mkhuge(pte_t pte)
 #define pte_mkhuge pte_mkhuge
 
 #ifdef CONFIG_PPC_KUAP
-static inline void lock_user_wr_access(void)
+static inline void __lock_user_wr_access(void)
 {
 	mtspr(SPRN_MD_AP, MD_APG_KUAP);
 }
 
-static inline void unlock_user_wr_access(void)
+static inline void __unlock_user_wr_access(void)
 {
 	mtspr(SPRN_MD_AP, MD_APG_INIT);
 }
 
-static inline void lock_user_rd_access(void)
+static inline void __lock_user_rd_access(void)
 {
 	mtspr(SPRN_MD_AP, MD_APG_KUAP);
 }
 
-static inline void unlock_user_rd_access(void)
+static inline void __unlock_user_rd_access(void)
 {
 	mtspr(SPRN_MD_AP, MD_APG_INIT);
 }
diff --git a/arch/powerpc/include/asm/paca.h b/arch/powerpc/include/asm/paca.h
index e843bc5d1a0f..56236f6d8c89 100644
--- a/arch/powerpc/include/asm/paca.h
+++ b/arch/powerpc/include/asm/paca.h
@@ -169,6 +169,9 @@ struct paca_struct {
 	u64 saved_r1;			/* r1 save for RTAS calls or PM or EE=0 */
 	u64 saved_msr;			/* MSR saved here by enter_rtas */
 	u16 trap_save;			/* Used when bad stack is encountered */
+#ifdef CONFIG_PPC_KUAP
+	u8 user_access_allowed;		/* can the kernel access user memory? */
+#endif
 	u8 irq_soft_mask;		/* mask for irq soft masking */
 	u8 irq_happened;		/* irq happened while soft-disabled */
 	u8 io_sync;			/* writel() needs spin_unlock sync */
diff --git a/arch/powerpc/include/asm/uaccess.h b/arch/powerpc/include/asm/uaccess.h
index 2f3625cbfcee..76dae1095f7e 100644
--- a/arch/powerpc/include/asm/uaccess.h
+++ b/arch/powerpc/include/asm/uaccess.h
@@ -63,7 +63,28 @@ static inline int __access_ok(unsigned long addr, unsigned long size,
 
 #endif
 
-#ifndef CONFIG_PPC_KUAP
+#ifdef CONFIG_PPC_KUAP
+static inline void unlock_user_rd_access(void)
+{
+	__unlock_user_rd_access();
+	get_paca()->user_access_allowed = 1;
+}
+static inline void lock_user_rd_access(void)
+{
+	__lock_user_rd_access();
+	get_paca()->user_access_allowed = 0;
+}
+static inline void unlock_user_wr_access(void)
+{
+	__unlock_user_wr_access();
+	get_paca()->user_access_allowed = 1;
+}
+static inline void lock_user_wr_access(void)
+{
+	__lock_user_wr_access();
+	get_paca()->user_access_allowed = 0;
+}
+#else
 static inline void unlock_user_rd_access(void) { }
 static inline void lock_user_rd_access(void) { }
 static inline void unlock_user_wr_access(void) { }
diff --git a/arch/powerpc/kernel/asm-offsets.c b/arch/powerpc/kernel/asm-offsets.c
index da2f5d011ddb..899e9835b45f 100644
--- a/arch/powerpc/kernel/asm-offsets.c
+++ b/arch/powerpc/kernel/asm-offsets.c
@@ -260,6 +260,7 @@ int main(void)
 	OFFSET(ACCOUNT_STARTTIME_USER, paca_struct, accounting.starttime_user);
 	OFFSET(ACCOUNT_USER_TIME, paca_struct, accounting.utime);
 	OFFSET(ACCOUNT_SYSTEM_TIME, paca_struct, accounting.stime);
+	OFFSET(PACA_USER_ACCESS_ALLOWED, paca_struct, user_access_allowed);
 	OFFSET(PACA_TRAP_SAVE, paca_struct, trap_save);
 	OFFSET(PACA_NAPSTATELOST, paca_struct, nap_state_lost);
 	OFFSET(PACA_SPRG_VDSO, paca_struct, sprg_vdso);
-- 
2.19.1

