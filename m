Return-Path: <SRS0=CEjL=R2=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50B24C43381
	for <linuxppc-dev@archiver.kernel.org>; Sat, 23 Mar 2019 14:06:57 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4518E218D4
	for <linuxppc-dev@archiver.kernel.org>; Sat, 23 Mar 2019 14:06:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nlC9gaKa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4518E218D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44RMlf0zYLzDqQB
	for <linuxppc-dev@archiver.kernel.org>; Sun, 24 Mar 2019 01:06:54 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::543; helo=mail-pg1-x543.google.com;
 envelope-from=jagdsh.linux@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="nlC9gaKa"; 
 dkim-atps=neutral
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com
 [IPv6:2607:f8b0:4864:20::543])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44RL4W3SXNzDqMK
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 23 Mar 2019 23:51:18 +1100 (AEDT)
Received: by mail-pg1-x543.google.com with SMTP id j26so1338798pgl.5
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 23 Mar 2019 05:51:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id;
 bh=8ChnlVqrga2W8EZIJdLuUoeyqlT7OHpe4yzIC29FI84=;
 b=nlC9gaKaMvjO9I+zCoKz3DAuQOFrWigLoi2/kt/FZIaAkdWQlv601my1uWwEL2o/lZ
 Va0ZeSRLU5LTMYSb78t/LjeNTCYp5XggebFwiRdA+37vNVxcyLzAV+P7HjXNVXP1bjy9
 5ki5cI5O0Hgt0IUB1RDZvF2zXaBENo/OVpliD+vsgBs73bJ0EzpkNQ77Igssc6LdgxKM
 uLeBJQiYoVixkKXVIIFTzZPUnPKsEHkJfhEk6fpnFA0JGYvXyz73MKpyHTxNiI1r8KJW
 u/IvNTcwoD+OCVr8yFcY+q7lBY63NSRSlNH1aXevzIOLgZj+UNeq51iaYJMg0YF/b8j3
 G4Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=8ChnlVqrga2W8EZIJdLuUoeyqlT7OHpe4yzIC29FI84=;
 b=Gm1rFC2F1D6oN+GcUxvso696iFsWIXLAFa+e1bWibzlXZHwTEKb9olAw/9N3AyuCjk
 TVge3mKPz2ux6Vuu15YzEpl9PWorfPxe1kiYrdXM5jqkBjFjxzmwN/epFz0WqNnEqFCd
 W0YV97E7bZ8PhSyj1cOChsnNJmB1moOkFCSJegRzf+X1XpE0qlG//4sO0kbNRonDZ/XR
 MWZIlsGRy2HQmHhL6nGhpsaRKMwFNGp7D5TVBzYtM32JFoxBWw8qlZCgo5+wzrGcGugU
 ahiwB6nb7UXNfrpaZhM7D+neThW5Hg4JMiL0xFvu+x9QnGl7ZG7/0rSVQB/2iM3xWNBu
 EluQ==
X-Gm-Message-State: APjAAAXP+sOUPCAtYagWC2HE44T22zyuPiMea44cNZs12kxQsYEVaQRK
 p2Ax0Ep0KYWahrhinmkTyUM=
X-Google-Smtp-Source: APXvYqwYlcL6Cr3p/H7TNbgapyzT5BIiqgu/uTsPEQSH4BuWc/be2+h4wYHeckljdUQL1FrMI956bA==
X-Received: by 2002:a17:902:1121:: with SMTP id
 d30mr15011160pla.104.1553345475734; 
 Sat, 23 Mar 2019 05:51:15 -0700 (PDT)
Received: from CentOS76.localdomain.localdomain ([49.205.222.128])
 by smtp.gmail.com with ESMTPSA id t190sm16657001pfb.33.2019.03.23.05.51.09
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sat, 23 Mar 2019 05:51:14 -0700 (PDT)
From: jagdsh.linux@gmail.com
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 npiggin@gmail.com, hristophe.leroy@c-s.fr, arnd@arndb.de, anton@ozlabs.org,
 paul.burton@mips.com, mikey@neuling.org, akpm@linux-foundation.org,
 mwb@linux.vnet.ibm.com
Subject: [PATCH] arch/powerpc: Remove duplicate headers
Date: Sat, 23 Mar 2019 18:20:55 +0530
Message-Id: <1553345455-32085-1-git-send-email-jagdsh.linux@gmail.com>
X-Mailer: git-send-email 1.8.3.1
X-Mailman-Approved-At: Sun, 24 Mar 2019 01:05:21 +1100
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
Cc: Jagadeesh Pagadala <jagdsh.linux@gmail.com>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

From: Jagadeesh Pagadala <jagdsh.linux@gmail.com>

Remove duplicate headers which are included twice.

Signed-off-by: Jagadeesh Pagadala <jagdsh.linux@gmail.com>
---
 arch/powerpc/kernel/time.c       | 1 -
 arch/powerpc/lib/code-patching.c | 1 -
 arch/powerpc/mm/numa.c           | 1 -
 3 files changed, 3 deletions(-)

diff --git a/arch/powerpc/kernel/time.c b/arch/powerpc/kernel/time.c
index bc0503e..6ef3247 100644
--- a/arch/powerpc/kernel/time.c
+++ b/arch/powerpc/kernel/time.c
@@ -43,7 +43,6 @@
 #include <linux/timex.h>
 #include <linux/kernel_stat.h>
 #include <linux/time.h>
-#include <linux/clockchips.h>
 #include <linux/init.h>
 #include <linux/profile.h>
 #include <linux/cpu.h>
diff --git a/arch/powerpc/lib/code-patching.c b/arch/powerpc/lib/code-patching.c
index 506413a..587ff97 100644
--- a/arch/powerpc/lib/code-patching.c
+++ b/arch/powerpc/lib/code-patching.c
@@ -15,7 +15,6 @@
 #include <linux/cpuhotplug.h>
 #include <linux/slab.h>
 #include <linux/uaccess.h>
-#include <linux/kprobes.h>
 
 #include <asm/pgtable.h>
 #include <asm/tlbflush.h>
diff --git a/arch/powerpc/mm/numa.c b/arch/powerpc/mm/numa.c
index f976676..f3ee0e1 100644
--- a/arch/powerpc/mm/numa.c
+++ b/arch/powerpc/mm/numa.c
@@ -32,7 +32,6 @@
 #include <asm/sparsemem.h>
 #include <asm/prom.h>
 #include <asm/smp.h>
-#include <asm/cputhreads.h>
 #include <asm/topology.h>
 #include <asm/firmware.h>
 #include <asm/paca.h>
-- 
1.8.3.1

