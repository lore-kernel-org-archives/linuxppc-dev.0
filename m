Return-Path: <SRS0=YrVw=SA=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02B3EC43381
	for <linuxppc-dev@archiver.kernel.org>; Fri, 29 Mar 2019 10:06:34 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7755220643
	for <linuxppc-dev@archiver.kernel.org>; Fri, 29 Mar 2019 10:06:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="pJbYCWVX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7755220643
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44Vy7W3gwXzDqQV
	for <linuxppc-dev@archiver.kernel.org>; Fri, 29 Mar 2019 21:06:31 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=c-s.fr
 (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@c-s.fr; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=c-s.fr header.i=@c-s.fr header.b="pJbYCWVX"; 
 dkim-atps=neutral
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44Vy052v1czDqSV
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 Mar 2019 21:00:05 +1100 (AEDT)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 44Vy011s6gz9v4yK;
 Fri, 29 Mar 2019 11:00:01 +0100 (CET)
Authentication-Results: localhost; dkim=pass
 reason="1024-bit key; insecure key"
 header.d=c-s.fr header.i=@c-s.fr header.b=pJbYCWVX; dkim-adsp=pass;
 dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id 2QAniqriMyj3; Fri, 29 Mar 2019 11:00:01 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 44Vy010fCFz9v1N5;
 Fri, 29 Mar 2019 11:00:01 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
 t=1553853601; bh=EzeI7HKwxBA3dVP3UDaBxG1dqdkeWlUkN2NImcoxlFk=;
 h=In-Reply-To:References:From:Subject:To:Cc:Date:From;
 b=pJbYCWVXyN1Xh23Zo9TqUmy9+ocNK42P8cnicMdC1ZiwkRRvOFPfqVg3jk4h9qiqc
 DAbOhszCl1knBp6Hzb/itCz0wVKWwoOYh0dNMXFqze2UIKLtzXGUNqWchItTOLynXR
 +6UtXAYXff1Rdr9aPGOJbnRYJxP3T0qcg/RFqeLs=
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 2159C8B91C;
 Fri, 29 Mar 2019 11:00:02 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id elwHU6GvMKtT; Fri, 29 Mar 2019 11:00:02 +0100 (CET)
Received: from po16846vm.idsi0.si.c-s.fr (po15451.idsi0.si.c-s.fr
 [172.25.231.2])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id EDE7D8B88C;
 Fri, 29 Mar 2019 11:00:01 +0100 (CET)
Received: by po16846vm.idsi0.si.c-s.fr (Postfix, from userid 0)
 id DF1506FC95; Fri, 29 Mar 2019 10:00:01 +0000 (UTC)
Message-Id: <12c1ba4fc9e2e55ca44c5c57225669b296d48c74.1553853405.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1553853405.git.christophe.leroy@c-s.fr>
References: <cover.1553853405.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v1 3/4] powerpc/mm: Move book3s32 specifics in subdirectory
 mm/book3s64
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>
Date: Fri, 29 Mar 2019 10:00:01 +0000 (UTC)
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

Several files in arch/powerpc/mm are only for book3S32. This patch
creates a subdirectory for them.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/mm/Makefile                            | 3 +--
 arch/powerpc/mm/book3s32/Makefile                   | 6 ++++++
 arch/powerpc/mm/{ => book3s32}/hash_low_32.S        | 0
 arch/powerpc/mm/{ => book3s32}/mmu_context_hash32.c | 0
 arch/powerpc/mm/{ => book3s32}/ppc_mmu_32.c         | 0
 arch/powerpc/mm/{ => book3s32}/tlb_hash32.c         | 0
 6 files changed, 7 insertions(+), 2 deletions(-)
 create mode 100644 arch/powerpc/mm/book3s32/Makefile
 rename arch/powerpc/mm/{ => book3s32}/hash_low_32.S (100%)
 rename arch/powerpc/mm/{ => book3s32}/mmu_context_hash32.c (100%)
 rename arch/powerpc/mm/{ => book3s32}/ppc_mmu_32.c (100%)
 rename arch/powerpc/mm/{ => book3s32}/tlb_hash32.c (100%)

diff --git a/arch/powerpc/mm/Makefile b/arch/powerpc/mm/Makefile
index a137fdf775e2..68cb1e840b5e 100644
--- a/arch/powerpc/mm/Makefile
+++ b/arch/powerpc/mm/Makefile
@@ -12,11 +12,10 @@ obj-$(CONFIG_PPC_MMU_NOHASH)	+= mmu_context_nohash.o tlb_nohash.o \
 				   tlb_nohash_low.o
 obj-$(CONFIG_PPC_BOOK3E)	+= tlb_low_$(BITS)e.o
 obj-$(CONFIG_PPC_BOOK3E_64)   += pgtable-book3e.o
+obj-$(CONFIG_PPC_BOOK3S_32)	+= book3s32/
 obj-$(CONFIG_PPC_BOOK3S_64)	+= book3s64/
 obj-$(CONFIG_PPC_BOOK3S_64)	+= pgtable-frag.o
 obj-$(CONFIG_PPC32)		+= pgtable-frag.o
-obj-$(CONFIG_PPC_BOOK3S_32)	+= ppc_mmu_32.o hash_low_32.o mmu_context_hash32.o
-obj-$(CONFIG_PPC_BOOK3S_32)	+= tlb_hash32.o
 obj-$(CONFIG_40x)		+= 40x_mmu.o
 obj-$(CONFIG_44x)		+= 44x_mmu.o
 obj-$(CONFIG_PPC_8xx)		+= 8xx_mmu.o
diff --git a/arch/powerpc/mm/book3s32/Makefile b/arch/powerpc/mm/book3s32/Makefile
new file mode 100644
index 000000000000..7f2690d319fd
--- /dev/null
+++ b/arch/powerpc/mm/book3s32/Makefile
@@ -0,0 +1,6 @@
+# SPDX-License-Identifier: GPL-2.0
+#
+# Makefile for the linux ppc-specific parts of the memory manager.
+#
+
+obj-y		+= ppc_mmu_32.o hash_low_32.o mmu_context_hash32.o tlb_hash32.o
diff --git a/arch/powerpc/mm/hash_low_32.S b/arch/powerpc/mm/book3s32/hash_low_32.S
similarity index 100%
rename from arch/powerpc/mm/hash_low_32.S
rename to arch/powerpc/mm/book3s32/hash_low_32.S
diff --git a/arch/powerpc/mm/mmu_context_hash32.c b/arch/powerpc/mm/book3s32/mmu_context_hash32.c
similarity index 100%
rename from arch/powerpc/mm/mmu_context_hash32.c
rename to arch/powerpc/mm/book3s32/mmu_context_hash32.c
diff --git a/arch/powerpc/mm/ppc_mmu_32.c b/arch/powerpc/mm/book3s32/ppc_mmu_32.c
similarity index 100%
rename from arch/powerpc/mm/ppc_mmu_32.c
rename to arch/powerpc/mm/book3s32/ppc_mmu_32.c
diff --git a/arch/powerpc/mm/tlb_hash32.c b/arch/powerpc/mm/book3s32/tlb_hash32.c
similarity index 100%
rename from arch/powerpc/mm/tlb_hash32.c
rename to arch/powerpc/mm/book3s32/tlb_hash32.c
-- 
2.13.3

