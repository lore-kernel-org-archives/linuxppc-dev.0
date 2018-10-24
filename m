Return-Path: <SRS0=Hff1=NE=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D227ECDE44
	for <linuxppc-dev@archiver.kernel.org>; Wed, 24 Oct 2018 19:40:52 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 184F92054F
	for <linuxppc-dev@archiver.kernel.org>; Wed, 24 Oct 2018 19:40:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XUVPRaDo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 184F92054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42gLG95R7kzDrMG
	for <linuxppc-dev@archiver.kernel.org>; Thu, 25 Oct 2018 06:40:49 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="XUVPRaDo";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::442; helo=mail-pf1-x442.google.com;
 envelope-from=f.fainelli@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="XUVPRaDo"; 
 dkim-atps=neutral
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com
 [IPv6:2607:f8b0:4864:20::442])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42gL5b5gt3zDrMf
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Oct 2018 06:33:23 +1100 (AEDT)
Received: by mail-pf1-x442.google.com with SMTP id j23-v6so2928817pfi.4
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Oct 2018 12:33:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=R7GnanBC/dUP1yUUX1JKpyThiE0iCRjX5YFPvjRZfCc=;
 b=XUVPRaDoxMaZ0lc+zIzwRmVi++6Px2u+8TgSt+ESHM01GRwvZtXwQDGr4zqDSMZfrw
 8nq+I4eE4vaqFXIJDj0j7q+PI42qbkO9Lx9HT8x5RKjlanTfAVScBJLHwP7splrM/86g
 SwKMGcaiEl1CEBvNP0jbIDkfSLJKkemdtX42rsEnrMQENoVA80iYvrzrwMnfiQoxbZni
 JkfwfIdggNQDt4uFgzXJhfpmuyCYCHoxEVICC0TXx1+PvFtzmXL0tV4d+3IFqdBUfCN3
 GqHTcCVh6xi6gCkOdgy0tizfHP5iGPbFk5siMBPV9ZhNeCLYFPKMA1XnN4fFTHSdfvvV
 A26w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=R7GnanBC/dUP1yUUX1JKpyThiE0iCRjX5YFPvjRZfCc=;
 b=k3AQAb+UojIqn43NyqLFWKSoAwmCatinjU2GqJh0iipyFouYsN21zU/ZZ8ciBbLQlE
 riNqaNQcC6y7q+IBEFe8EZl6G0AA5fJViVT/AG7Mo2qTnO87e2X5M5AXyJzRVI9Pkg/0
 lZoi5mIsha2RRQDx2qPzYpH25E9yZ+CJ/5g4TXD5vaLq/04X7KEkpoznqiKsv936d0Da
 pK35wOiqfnpBSHAVzkJrjUibDAq/r/j54CCucVLMF6u3MQzFpEhSbdnA8nqFFKFIAoAe
 kcZTjuplsCoSnVFRp0p6sj4CC/4UrCBsng3RG7bS2kCYsYHzBp1c5ILLoKJQ+1tiBEdC
 Kjaw==
X-Gm-Message-State: AGRZ1gIYPi25ZHLZXw9v6FqyFI8JDf8/5zlpfhlyEwZt0R7xt1kdtZVa
 c06S1iDqAJ4MYNCjl+xtorI=
X-Google-Smtp-Source: AJdET5dg31dP21iFfiQOW43Rew2HT+LpqU+mmMjIz/9NCSpREeKfcx0lWewCTEg3MxMGJke0wlIAEA==
X-Received: by 2002:a62:b87:: with SMTP id 7-v6mr3903770pfl.67.1540409601762; 
 Wed, 24 Oct 2018 12:33:21 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.250])
 by smtp.gmail.com with ESMTPSA id j187-v6sm9818878pfc.39.2018.10.24.12.33.19
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 24 Oct 2018 12:33:20 -0700 (PDT)
From: Florian Fainelli <f.fainelli@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] arm64: Create asm/initrd.h
Date: Wed, 24 Oct 2018 12:32:56 -0700
Message-Id: <20181024193256.23734-3-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181024193256.23734-1-f.fainelli@gmail.com>
References: <20181024193256.23734-1-f.fainelli@gmail.com>
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
Cc: "open list:MIPS" <linux-mips@linux-mips.org>,
 "open list:IA64 Itanium PLATFORM" <linux-ia64@vger.kernel.org>,
 "open list:SUPERH" <linux-sh@vger.kernel.org>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>,
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE"
 <devicetree@vger.kernel.org>,
 "open list:SPARC + UltraSPARC sparc/sparc64" <sparclinux@vger.kernel.org>,
 "open list:RISC-V ARCHITECTURE" <linux-riscv@lists.infradead.org>,
 "open list:GENERIC INCLUDE/ASM HEADER FILES" <linux-arch@vger.kernel.org>,
 "open list:S390" <linux-s390@vger.kernel.org>,
 Florian Fainelli <f.fainelli@gmail.com>,
 "open list:C6X ARCHITECTURE" <linux-c6x-dev@linux-c6x.org>,
 "open list:QUALCOMM HEXAGON ARCHITECTURE" <linux-hexagon@vger.kernel.org>,
 "open list:SYNOPSYS ARC ARCHITECTURE" <linux-snps-arc@lists.infradead.org>,
 "moderated list:H8/300 ARCHITECTURE" <uclinux-h8-devel@lists.sourceforge.jp>,
 "open list:TENSILICA XTENSA PORT xtensa" <linux-xtensa@linux-xtensa.org>,
 Arnd Bergmann <arnd@arndb.de>, Marc Zyngier <marc.zyngier@arm.com>,
 "open list:USER-MODE LINUX UML" <linux-um@lists.infradead.org>,
 "open list:M68K ARCHITECTURE" <linux-m68k@lists.linux-m68k.org>,
 "open list:OPENRISC ARCHITECTURE" <openrisc@lists.librecores.org>,
 "moderated list:ARM PORT" <linux-arm-kernel@lists.infradead.org>,
 "open list:PARISC ARCHITECTURE" <linux-parisc@vger.kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "open list:ALPHA PORT" <linux-alpha@vger.kernel.org>,
 Olof Johansson <olof@lixom.net>,
 "moderated list:NIOS2 ARCHITECTURE" <nios2-dev@lists.rocketboards.org>,
 "open list:LINUX FOR POWERPC 32-BIT AND 64-BIT"
 <linuxppc-dev@lists.ozlabs.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

ARM64 is the only architecture that requires a re-definition of
__early_init_dt_declare_initrd(). Now that we added the infrastructure
in asm-generic to provide an asm/initrd.h file, properly break up that
definition from asm/memory.h and make use of that header in
drivers/of/fdt.c where this is used.

This significantly cuts the number of objects that need to be rebuilt on
ARM64 due to the repercusions of including asm/memory.h in several
places.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 arch/arm64/include/asm/initrd.h | 13 +++++++++++++
 arch/arm64/include/asm/memory.h |  8 --------
 drivers/of/fdt.c                |  1 +
 3 files changed, 14 insertions(+), 8 deletions(-)
 create mode 100644 arch/arm64/include/asm/initrd.h

diff --git a/arch/arm64/include/asm/initrd.h b/arch/arm64/include/asm/initrd.h
new file mode 100644
index 000000000000..0c9572485810
--- /dev/null
+++ b/arch/arm64/include/asm/initrd.h
@@ -0,0 +1,13 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __ASM_INITRD_H
+#define __ASM_INITRD_H
+
+#ifdef CONFIG_BLK_DEV_INITRD
+#define __early_init_dt_declare_initrd(__start, __end)			\
+	do {								\
+		initrd_start = (__start);				\
+		initrd_end = (__end);					\
+	} while (0)
+#endif
+
+#endif /* __ASM_INITRD_H */
diff --git a/arch/arm64/include/asm/memory.h b/arch/arm64/include/asm/memory.h
index b96442960aea..dc3ca21ba240 100644
--- a/arch/arm64/include/asm/memory.h
+++ b/arch/arm64/include/asm/memory.h
@@ -168,14 +168,6 @@
 #define IOREMAP_MAX_ORDER	(PMD_SHIFT)
 #endif
 
-#ifdef CONFIG_BLK_DEV_INITRD
-#define __early_init_dt_declare_initrd(__start, __end)			\
-	do {								\
-		initrd_start = (__start);				\
-		initrd_end = (__end);					\
-	} while (0)
-#endif
-
 #ifndef __ASSEMBLY__
 
 #include <linux/bitops.h>
diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
index 800ad252cf9c..4e4711af907b 100644
--- a/drivers/of/fdt.c
+++ b/drivers/of/fdt.c
@@ -28,6 +28,7 @@
 
 #include <asm/setup.h>  /* for COMMAND_LINE_SIZE */
 #include <asm/page.h>
+#include <asm/initrd.h>
 
 #include "of_private.h"
 
-- 
2.17.1

