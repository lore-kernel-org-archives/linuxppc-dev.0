Return-Path: <SRS0=jlj5=AR=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34408C433DF
	for <linuxppc-dev@archiver.kernel.org>; Mon,  6 Jul 2020 02:21:56 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D2E902070C
	for <linuxppc-dev@archiver.kernel.org>; Mon,  6 Jul 2020 02:21:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mI6BLefG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2E902070C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4B0Tpn5LJvzDqSV
	for <linuxppc-dev@archiver.kernel.org>; Mon,  6 Jul 2020 12:21:53 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::344;
 helo=mail-wm1-x344.google.com; envelope-from=npiggin@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=mI6BLefG; dkim-atps=neutral
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com
 [IPv6:2a00:1450:4864:20::344])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4B0Tl16VXXzDqfK
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  6 Jul 2020 12:18:37 +1000 (AEST)
Received: by mail-wm1-x344.google.com with SMTP id g10so14661565wmc.1
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 05 Jul 2020 19:18:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=8azaCA9X1iEXFHYq8WU7gBmP5Jpn7hLBsRbOcU8tD5s=;
 b=mI6BLefG8kiEdyrg3ZfySPw/VMbyr7KUsuiPQfDyaYllWfFDAsc4lEex0NPJsZ5uUT
 8mCI15rM9FpIlS2UFl5ho/2H52kvZ0eL0oBjMZ1ZUHXn6iuPCiCS4Fs2jorkhGtrsD3u
 YMed9/HJs0T3wXtX/vcFJ7td+hk78SxduBvsQzFIkp04w5YdKJ8WJfb752ml1TWLw1FS
 cU30FSRc4N7wnXGmc0ScNERfIU1VCNHAWlkvISXHCyQFtbWt7e2xFF6lMT1A0zb34BoX
 vpod83/VMHQ3QoKNhAD+qOXWW3IQXHAHv2A1ugBwA+UN5uC3Rye7/gHK7S+W5qle8cwN
 EOKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=8azaCA9X1iEXFHYq8WU7gBmP5Jpn7hLBsRbOcU8tD5s=;
 b=QNuG6FYM9J/lrMqEh0ecsNI1Xd9MSsoxCzjP68A6QeSPiLbjOCW6K8V4WtT2KU/15z
 Oqk7Tchfws4crDh14vwT5ZWmb5FxvaMHh1p2iMxwLYw8iDEM/LM0XRp8gEpGA3XN74Fk
 O0oPLtrf4aaqF8GfysJDkWNH6N2tiTBL0bmkw9nPlZYsdHKf9AdKWQ8Ylfep46mbHrUh
 vG+DEDUp40sdEVTsgJFV2AqV1bWl+E/Jpl4RLuW6iu3HAxq9tUqWAK3h+N20GQUCeJO8
 GFvVBCsKnc8K5cbZuxK/DFJdgB8Dmr2mt7OE7X7LexZ4BWwiDeSEzzlzbJxe8Ru2tEjV
 vV/w==
X-Gm-Message-State: AOAM530p0xjRDiLkg2XyH+nw8fxTtJTR0kR4WnJROApAwupbfg9uEfOA
 OEorywAQrQWJK49JuQ/MPjTp5hFj
X-Google-Smtp-Source: ABdhPJytt4H9PGzg2ntcpGdqYseJUZTiSJiP3ITiJ9lfclGIF9hzX1UAiNy7r8mkzTctoX04E9T9CQ==
X-Received: by 2002:a7b:c208:: with SMTP id x8mr47340897wmi.49.1594001914526; 
 Sun, 05 Jul 2020 19:18:34 -0700 (PDT)
Received: from bobo.ibm.com (61-68-186-125.tpgi.com.au. [61.68.186.125])
 by smtp.gmail.com with ESMTPSA id g14sm19096722wrw.83.2020.07.05.19.18.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 Jul 2020 19:18:33 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] powerpc: select ARCH_HAS_MEMBARRIER_SYNC_CORE
Date: Mon,  6 Jul 2020 12:18:22 +1000
Message-Id: <20200706021822.1515189-1-npiggin@gmail.com>
X-Mailer: git-send-email 2.23.0
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
Cc: linux-arch@vger.kernel.org,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Nicholas Piggin <npiggin@gmail.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

powerpc return from interrupt and return from system call sequences are
context synchronising.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 .../features/sched/membarrier-sync-core/arch-support.txt      | 4 ++--
 arch/powerpc/Kconfig                                          | 1 +
 arch/powerpc/include/asm/exception-64s.h                      | 4 ++++
 3 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/Documentation/features/sched/membarrier-sync-core/arch-support.txt b/Documentation/features/sched/membarrier-sync-core/arch-support.txt
index 8a521a622966..52ad74a25f54 100644
--- a/Documentation/features/sched/membarrier-sync-core/arch-support.txt
+++ b/Documentation/features/sched/membarrier-sync-core/arch-support.txt
@@ -5,7 +5,7 @@
 #
 # Architecture requirements
 #
-# * arm/arm64
+# * arm/arm64/powerpc
 #
 # Rely on implicit context synchronization as a result of exception return
 # when returning from IPI handler, and when returning to user-space.
@@ -45,7 +45,7 @@
     |       nios2: | TODO |
     |    openrisc: | TODO |
     |      parisc: | TODO |
-    |     powerpc: | TODO |
+    |     powerpc: |  ok  |
     |       riscv: | TODO |
     |        s390: | TODO |
     |          sh: | TODO |
diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 9fa23eb320ff..920c4e3ca4ef 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -131,6 +131,7 @@ config PPC
 	select ARCH_HAS_PTE_DEVMAP		if PPC_BOOK3S_64
 	select ARCH_HAS_PTE_SPECIAL
 	select ARCH_HAS_MEMBARRIER_CALLBACKS
+	select ARCH_HAS_MEMBARRIER_SYNC_CORE
 	select ARCH_HAS_SCALED_CPUTIME		if VIRT_CPU_ACCOUNTING_NATIVE && PPC_BOOK3S_64
 	select ARCH_HAS_STRICT_KERNEL_RWX	if (PPC32 && !HIBERNATION)
 	select ARCH_HAS_TICK_BROADCAST		if GENERIC_CLOCKEVENTS_BROADCAST
diff --git a/arch/powerpc/include/asm/exception-64s.h b/arch/powerpc/include/asm/exception-64s.h
index 47bd4ea0837d..b88cb3a989b6 100644
--- a/arch/powerpc/include/asm/exception-64s.h
+++ b/arch/powerpc/include/asm/exception-64s.h
@@ -68,6 +68,10 @@
  *
  * The nop instructions allow us to insert one or more instructions to flush the
  * L1-D cache when returning to userspace or a guest.
+ *
+ * powerpc relies on return from interrupt/syscall being context synchronising
+ * (which hrfid, rfid, and rfscv are) to support ARCH_HAS_MEMBARRIER_SYNC_CORE
+ * without additional additional synchronisation instructions.
  */
 #define RFI_FLUSH_SLOT							\
 	RFI_FLUSH_FIXUP_SECTION;					\
-- 
2.23.0

