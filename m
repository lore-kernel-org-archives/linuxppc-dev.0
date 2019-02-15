Return-Path: <SRS0=eC6l=QW=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32FD6C43381
	for <linuxppc-dev@archiver.kernel.org>; Fri, 15 Feb 2019 00:13:09 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9B9F3217F5
	for <linuxppc-dev@archiver.kernel.org>; Fri, 15 Feb 2019 00:13:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=axtens.net header.i=@axtens.net header.b="XXLoczJW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B9F3217F5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=axtens.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 440tyC0NzQzDqYq
	for <linuxppc-dev@archiver.kernel.org>; Fri, 15 Feb 2019 11:13:07 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=axtens.net
 (client-ip=2607:f8b0:4864:20::643; helo=mail-pl1-x643.google.com;
 envelope-from=dja@axtens.net; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=axtens.net
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=axtens.net header.i=@axtens.net header.b="XXLoczJW"; 
 dkim-atps=neutral
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com
 [IPv6:2607:f8b0:4864:20::643])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 440tn24ZzdzDqTj
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Feb 2019 11:05:10 +1100 (AEDT)
Received: by mail-pl1-x643.google.com with SMTP id y10so4025667plp.0
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Feb 2019 16:05:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axtens.net; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Qo3C0jeBqokfe3NtfWTYRIQXW1jGrTc8UlmM+hz7MCc=;
 b=XXLoczJWpS72wIAmROXzXe/45g/oIGzhnsxwn7GFajwz4rkkuMOFs/t+4KQdqjYvrR
 41dm9Dj45q8vuC+0xWG9vnSwZSYX870pdRTfFIfNLLou4q9vjj51Z6eDk7WfDIaKzKg9
 JC5RQHSd4h/pxXadQr9gVi+b6ugwuiu44pPBM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Qo3C0jeBqokfe3NtfWTYRIQXW1jGrTc8UlmM+hz7MCc=;
 b=cGhsTQiuNxWZVvsiulcZDRw7z6lDJA5l1dKj5h80RI/rQwesOQHFJmsfih9sstrvmv
 vQKLy3wVVzj80a8OayxQJ59flVB/h7upmYJYAibOUXB30Dl4OmkWs0nfxz0Znb4q8zKF
 vl6HmVf3QOZT1Uc8+P6E8llvkVMVnDYpamalzKRvIplYYyS4xfY3xQMiaOSWyRtkLkZR
 wO2KkFH6HmpxR0fo9dc8/K/a4dwyPx0EyTuVR6lL267m4mAHZHK1GU7cjZRMZvlc1W3K
 p58AIrD1ZJxmksB0MXtsb6Ze1zL12WexWdegbIQUXPL4zpzRHJaqWwoK6VGJy60DmDGN
 SRwA==
X-Gm-Message-State: AHQUAubQSZ/LqEYXcq1l03JH+Rg6o5aCi1za7CCU+A3nHaQ4NHoNArDJ
 ItC1FyZxtxQp7rPrf3a/8Zk2mg==
X-Google-Smtp-Source: AHgI3IZZ8W7wqpvA4LT/o/TQvqEK3dO37wCtHoDRA2Dd0DW2sO/oLHN2Q+LQrFhi+8lRGhVS5T7+zw==
X-Received: by 2002:a17:902:3143:: with SMTP id
 w61mr7167138plb.253.1550189108375; 
 Thu, 14 Feb 2019 16:05:08 -0800 (PST)
Received: from localhost (124-171-165-212.dyn.iinet.net.au. [124.171.165.212])
 by smtp.gmail.com with ESMTPSA id
 w65sm4571002pfb.23.2019.02.14.16.05.06
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 14 Feb 2019 16:05:07 -0800 (PST)
From: Daniel Axtens <dja@axtens.net>
To: aneesh.kumar@linux.ibm.com, christophe.leroy@c-s.fr, bsingharora@gmail.com
Subject: [RFC PATCH 4/5] powerpc: move KASAN into its own subdirectory
Date: Fri, 15 Feb 2019 11:04:40 +1100
Message-Id: <20190215000441.14323-5-dja@axtens.net>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190215000441.14323-1-dja@axtens.net>
References: <20190215000441.14323-1-dja@axtens.net>
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
Cc: linuxppc-dev@lists.ozlabs.org, kasan-dev@googlegroups.com,
 Daniel Axtens <dja@axtens.net>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

In preparation for adding ppc64 implementations, break out the
code into its own subdirectory.

Signed-off-by: Daniel Axtens <dja@axtens.net>
---
 arch/powerpc/mm/Makefile                                | 4 +---
 arch/powerpc/mm/kasan/Makefile                          | 5 +++++
 arch/powerpc/mm/{kasan_init.c => kasan/kasan_init_32.c} | 0
 3 files changed, 6 insertions(+), 3 deletions(-)
 create mode 100644 arch/powerpc/mm/kasan/Makefile
 rename arch/powerpc/mm/{kasan_init.c => kasan/kasan_init_32.c} (100%)

diff --git a/arch/powerpc/mm/Makefile b/arch/powerpc/mm/Makefile
index d6b76f25f6de..457c0ea2b5e7 100644
--- a/arch/powerpc/mm/Makefile
+++ b/arch/powerpc/mm/Makefile
@@ -7,8 +7,6 @@ ccflags-$(CONFIG_PPC64)	:= $(NO_MINIMAL_TOC)
 
 CFLAGS_REMOVE_slb.o = $(CC_FLAGS_FTRACE)
 
-KASAN_SANITIZE_kasan_init.o := n
-
 obj-y				:= fault.o mem.o pgtable.o mmap.o \
 				   init_$(BITS).o pgtable_$(BITS).o \
 				   init-common.o mmu_context.o drmem.o
@@ -57,4 +55,4 @@ obj-$(CONFIG_PPC_BOOK3S_64)	+= dump_linuxpagetables-book3s64.o
 endif
 obj-$(CONFIG_PPC_HTDUMP)	+= dump_hashpagetable.o
 obj-$(CONFIG_PPC_MEM_KEYS)	+= pkeys.o
-obj-$(CONFIG_KASAN)		+= kasan_init.o
+obj-$(CONFIG_KASAN)		+= kasan/
diff --git a/arch/powerpc/mm/kasan/Makefile b/arch/powerpc/mm/kasan/Makefile
new file mode 100644
index 000000000000..6577897673dd
--- /dev/null
+++ b/arch/powerpc/mm/kasan/Makefile
@@ -0,0 +1,5 @@
+# SPDX-License-Identifier: GPL-2.0
+
+KASAN_SANITIZE := n
+
+obj-$(CONFIG_PPC32)           += kasan_init_32.o
diff --git a/arch/powerpc/mm/kasan_init.c b/arch/powerpc/mm/kasan/kasan_init_32.c
similarity index 100%
rename from arch/powerpc/mm/kasan_init.c
rename to arch/powerpc/mm/kasan/kasan_init_32.c
-- 
2.19.1

