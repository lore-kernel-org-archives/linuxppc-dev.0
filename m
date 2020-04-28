Return-Path: <SRS0=O865=6M=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E34DCC83002
	for <linuxppc-dev@archiver.kernel.org>; Tue, 28 Apr 2020 02:28:26 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 90C7D20728
	for <linuxppc-dev@archiver.kernel.org>; Tue, 28 Apr 2020 02:28:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KyQYUvSA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90C7D20728
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 49B5D839c5zDqRH
	for <linuxppc-dev@archiver.kernel.org>; Tue, 28 Apr 2020 12:28:24 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1044;
 helo=mail-pj1-x1044.google.com; envelope-from=jniethe5@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=KyQYUvSA; dkim-atps=neutral
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com
 [IPv6:2607:f8b0:4864:20::1044])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 49B4c92sXGzDqH1
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Apr 2020 12:00:41 +1000 (AEST)
Received: by mail-pj1-x1044.google.com with SMTP id fu13so427823pjb.5
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Apr 2020 19:00:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=vUwyLlCkETgPxJc6fNblFBK3ZJZnbjHAhaL3xPNdbZU=;
 b=KyQYUvSAn+vLUorx7QNjKNdjhA39XsCsj6lmO6ClslgMznzqiF6FXwpmQJ4wXiOUIe
 pRY34G2gx2OMWUQGe4bnviYI0iUWD8P4C0dH1P4eNR0JwMPWkCuUxjlE6aZgJ9g92vrb
 vxMOM9hKY670d9Pw+qinmt6RRwNScW6b6OVfORQV0Ib+R8i64FrXmfInPi+6INJFFtkC
 MSiX/kvjw0Sfa6za1I/0+t/7eXcOZRKamaGRh85dQJWaXA0opEW4XaRzD5/Uqkocqv29
 a0Y1YOI94UFdTHztXE8NWfopqnt+DVoxl3nsZjfALBuv7K5q2dyZ5MjpVI7VUEJLbqxX
 IvvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=vUwyLlCkETgPxJc6fNblFBK3ZJZnbjHAhaL3xPNdbZU=;
 b=iukEqPjz6nCbIJ9AgXnJcrNcHIyhgYWQUzY74MQm56Jt3qTATrGgQK33lxQ1agVBi0
 rYnThLJ4VErMn0ogZpTlDVRUolQcQxTXT3/P6dZrl/zZRw84YSqNGZS1hBK46mplORwn
 KT1S/ooZOY37yi8UhoRXKGaD9+IWxj8vx1DrBw2PE9XxU7mDPepNpoZWJyv+ZR7FdM20
 43rTmvDb5QDYuyHqpYb2aZkmfLuVfnmc0w8UNVdk7mO+H+mGn1fRJSOx1IlqlqRbTbjv
 Ut6fab8TfxKxm49383ihrRmjOk31lEQPoFm8oYMQMym72+w02EzJDipJkWeeoEPE1Vkb
 BISw==
X-Gm-Message-State: AGi0PubONiwG2O4AWxLgW7mpsJCdV/LDgkclOSnLIEu6fXqiH3IVUXBX
 wjLT0ChCslXCoDcRhfHm15qI2gYWi5w=
X-Google-Smtp-Source: APiQypJrgVORLAwGqCqz6uQHpraJ/izjuEfH0NS9K29C+2heD2G8HKMu6tOQPMD7X4odMqiGDfCtTA==
X-Received: by 2002:a17:90a:cb86:: with SMTP id
 a6mr1984929pju.127.1588039236314; 
 Mon, 27 Apr 2020 19:00:36 -0700 (PDT)
Received: from localhost.localdomain
 (180-150-65-4.b49641.syd.nbn.aussiebb.net. [180.150.65.4])
 by smtp.gmail.com with ESMTPSA id o68sm13666642pfb.206.2020.04.27.19.00.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Apr 2020 19:00:35 -0700 (PDT)
From: Jordan Niethe <jniethe5@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v6 13/28] powerpc: Add a probe_user_read_inst() function
Date: Tue, 28 Apr 2020 11:57:59 +1000
Message-Id: <20200428015814.15380-14-jniethe5@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200428015814.15380-1-jniethe5@gmail.com>
References: <20200428015814.15380-1-jniethe5@gmail.com>
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
Cc: alistair@popple.id.au, npiggin@gmail.com, bala24@linux.ibm.com,
 Jordan Niethe <jniethe5@gmail.com>, dja@axtens.net
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Introduce a probe_user_read_inst() function to use in cases where
probe_user_read() is used for getting an instruction. This will be more
useful for prefixed instructions.

Signed-off-by: Jordan Niethe <jniethe5@gmail.com>
---
v6: - New to series
---
 arch/powerpc/include/asm/inst.h |  3 +++
 arch/powerpc/lib/Makefile       |  2 +-
 arch/powerpc/lib/inst.c         | 18 ++++++++++++++++++
 arch/powerpc/mm/fault.c         |  2 +-
 4 files changed, 23 insertions(+), 2 deletions(-)
 create mode 100644 arch/powerpc/lib/inst.c

diff --git a/arch/powerpc/include/asm/inst.h b/arch/powerpc/include/asm/inst.h
index 552e953bf04f..3e9a58420151 100644
--- a/arch/powerpc/include/asm/inst.h
+++ b/arch/powerpc/include/asm/inst.h
@@ -37,4 +37,7 @@ static inline bool ppc_inst_equal(struct ppc_inst x, struct ppc_inst y)
 	return ppc_inst_val(x) == ppc_inst_val(y);
 }
 
+int probe_user_read_inst(struct ppc_inst *inst,
+			 struct ppc_inst *nip);
+
 #endif /* _ASM_INST_H */
diff --git a/arch/powerpc/lib/Makefile b/arch/powerpc/lib/Makefile
index b8de3be10eb4..546591848219 100644
--- a/arch/powerpc/lib/Makefile
+++ b/arch/powerpc/lib/Makefile
@@ -16,7 +16,7 @@ CFLAGS_code-patching.o += -DDISABLE_BRANCH_PROFILING
 CFLAGS_feature-fixups.o += -DDISABLE_BRANCH_PROFILING
 endif
 
-obj-y += alloc.o code-patching.o feature-fixups.o pmem.o
+obj-y += alloc.o code-patching.o feature-fixups.o pmem.o inst.o
 
 ifndef CONFIG_KASAN
 obj-y	+=	string.o memcmp_$(BITS).o
diff --git a/arch/powerpc/lib/inst.c b/arch/powerpc/lib/inst.c
new file mode 100644
index 000000000000..eaf786afad2b
--- /dev/null
+++ b/arch/powerpc/lib/inst.c
@@ -0,0 +1,18 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ *  Copyright 2020, IBM Corporation.
+ */
+
+#include <linux/uaccess.h>
+#include <asm/inst.h>
+
+int probe_user_read_inst(struct ppc_inst *inst,
+			 struct ppc_inst *nip)
+{
+	unsigned int val;
+	int err;
+
+	err = probe_user_read(&val, nip, sizeof(val));
+	*inst = ppc_inst(val);
+	return err;
+}
diff --git a/arch/powerpc/mm/fault.c b/arch/powerpc/mm/fault.c
index 7a68a3b32615..4983197d4a8e 100644
--- a/arch/powerpc/mm/fault.c
+++ b/arch/powerpc/mm/fault.c
@@ -281,7 +281,7 @@ static bool bad_stack_expansion(struct pt_regs *regs, unsigned long address,
 		    access_ok(nip, sizeof(*nip))) {
 			struct ppc_inst inst;
 
-			if (!probe_user_read(&inst, nip, sizeof(inst)))
+			if (!probe_user_read_inst(&inst, (struct ppc_inst __user *)nip))
 				return !store_updates_sp(inst);
 			*must_retry = true;
 		}
-- 
2.17.1

