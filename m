Return-Path: <SRS0=psBJ=MK=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4738FC43382
	for <linuxppc-dev@archiver.kernel.org>; Fri, 28 Sep 2018 08:59:34 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ADCCC2152A
	for <linuxppc-dev@archiver.kernel.org>; Fri, 28 Sep 2018 08:59:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ADCCC2152A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42M5GC4wrpzF3D9
	for <linuxppc-dev@archiver.kernel.org>; Fri, 28 Sep 2018 18:59:31 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=c-s.fr
 (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@c-s.fr; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=c-s.fr
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42M5D547BdzF31F
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Sep 2018 18:57:41 +1000 (AEST)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 42M5D04Sm2z9ttBh;
 Fri, 28 Sep 2018 10:57:36 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id vIZ7PUZSH7cz; Fri, 28 Sep 2018 10:57:36 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 42M5D041Bzz9ttBd;
 Fri, 28 Sep 2018 10:57:36 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 249DC8B8D3;
 Fri, 28 Sep 2018 10:57:38 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id 4r0Hacp9c6a0; Fri, 28 Sep 2018 10:57:38 +0200 (CEST)
Received: from pc16082vm.idsi0.si.c-s.fr (unknown [172.25.231.3])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id AE6B08B8D1;
 Fri, 28 Sep 2018 10:57:37 +0200 (CEST)
Received: by pc16082vm.idsi0.si.c-s.fr (Postfix, from userid 0)
 id 8CC286F1CD; Fri, 28 Sep 2018 08:57:37 +0000 (UTC)
Message-Id: <5ccbb0b1ce0a86ef7a77e7b8dbb85c3637bf4628.1538087238.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v2] powerpc: wire up memtest
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>
Date: Fri, 28 Sep 2018 08:57:37 +0000 (UTC)
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
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Add call to early_memtest() so that kernel compiled with
CONFIG_MEMTEST really perform memtest at startup when requested
via 'memtest' boot parameter.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 v2: moved the test after initmem_init() as PPC64 sets max_low_pfn later than PPC32.

 arch/powerpc/kernel/setup-common.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/powerpc/kernel/setup-common.c b/arch/powerpc/kernel/setup-common.c
index 93fa0c99681e..9ca9db707bcb 100644
--- a/arch/powerpc/kernel/setup-common.c
+++ b/arch/powerpc/kernel/setup-common.c
@@ -33,6 +33,7 @@
 #include <linux/serial_8250.h>
 #include <linux/percpu.h>
 #include <linux/memblock.h>
+#include <linux/bootmem.h>
 #include <linux/of_platform.h>
 #include <linux/hugetlb.h>
 #include <asm/debugfs.h>
@@ -966,6 +967,8 @@ void __init setup_arch(char **cmdline_p)
 
 	initmem_init();
 
+	early_memtest(min_low_pfn << PAGE_SHIFT, max_low_pfn << PAGE_SHIFT);
+
 #ifdef CONFIG_DUMMY_CONSOLE
 	conswitchp = &dummy_con;
 #endif
-- 
2.13.3

