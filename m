Return-Path: <SRS0=TBQx=FN=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6199AC2BB40
	for <linuxppc-dev@archiver.kernel.org>; Wed,  9 Dec 2020 05:38:48 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C47EA23AFE
	for <linuxppc-dev@archiver.kernel.org>; Wed,  9 Dec 2020 05:38:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C47EA23AFE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csgroup.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4CrQnw2XB2zDqpp
	for <linuxppc-dev@archiver.kernel.org>; Wed,  9 Dec 2020 16:38:44 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=csgroup.eu (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@csgroup.eu; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=csgroup.eu
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4CrQbF6yXSzDqhC
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  9 Dec 2020 16:29:27 +1100 (AEDT)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 4CrQb729Qyz9tyPX;
 Wed,  9 Dec 2020 06:29:23 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id 3T2KIj4VXpVS; Wed,  9 Dec 2020 06:29:23 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 4CrQb66Rc0z9txjs;
 Wed,  9 Dec 2020 06:29:22 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id B1DA38B77C;
 Wed,  9 Dec 2020 06:29:23 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id SiycnILmeQHZ; Wed,  9 Dec 2020 06:29:23 +0100 (CET)
Received: from po17688vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 4FADF8B768;
 Wed,  9 Dec 2020 06:29:23 +0100 (CET)
Received: by localhost.localdomain (Postfix, from userid 0)
 id 31536668FD; Wed,  9 Dec 2020 05:29:23 +0000 (UTC)
Message-Id: <9501311014bd6507e04b27a0c3035186ccf65cd5.1607491748.git.christophe.leroy@csgroup.eu>
In-Reply-To: <0d37490a067840f53fc5b118869917c0aec9ab87.1607491747.git.christophe.leroy@csgroup.eu>
References: <0d37490a067840f53fc5b118869917c0aec9ab87.1607491747.git.christophe.leroy@csgroup.eu>
From: Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH v4 4/6] powerpc/mm: Move the WARN() out of bad_kuap_fault()
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, 
 npiggin@gmail.com, aneesh.kumar@linux.ibm.com
Date: Wed,  9 Dec 2020 05:29:23 +0000 (UTC)
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

In order to prepare the removal of calls to
search_exception_tables() on the fast path, move the
WARN() out of bad_kuap_fault().

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
v4: New
---
 arch/powerpc/include/asm/book3s/32/kup.h     | 6 +-----
 arch/powerpc/include/asm/book3s/64/kup.h     | 6 ++----
 arch/powerpc/include/asm/nohash/32/kup-8xx.h | 3 +--
 arch/powerpc/mm/fault.c                      | 2 +-
 4 files changed, 5 insertions(+), 12 deletions(-)

diff --git a/arch/powerpc/include/asm/book3s/32/kup.h b/arch/powerpc/include/asm/book3s/32/kup.h
index 32fd4452e960..a0117a9d5b06 100644
--- a/arch/powerpc/include/asm/book3s/32/kup.h
+++ b/arch/powerpc/include/asm/book3s/32/kup.h
@@ -183,11 +183,7 @@ bad_kuap_fault(struct pt_regs *regs, unsigned long address, bool is_write)
 	unsigned long begin = regs->kuap & 0xf0000000;
 	unsigned long end = regs->kuap << 28;
 
-	if (!is_write)
-		return false;
-
-	return WARN(address < begin || address >= end,
-		    "Bug: write fault blocked by segment registers !");
+	return is_write && (address < begin || address >= end);
 }
 
 #endif /* CONFIG_PPC_KUAP */
diff --git a/arch/powerpc/include/asm/book3s/64/kup.h b/arch/powerpc/include/asm/book3s/64/kup.h
index 7075c92c320c..f50f72e535aa 100644
--- a/arch/powerpc/include/asm/book3s/64/kup.h
+++ b/arch/powerpc/include/asm/book3s/64/kup.h
@@ -371,11 +371,9 @@ static inline bool bad_kuap_fault(struct pt_regs *regs, unsigned long address,
 	 * the AMR. Hence check for BLOCK_WRITE/READ against AMR.
 	 */
 	if (is_write) {
-		return WARN(((regs->amr & AMR_KUAP_BLOCK_WRITE) == AMR_KUAP_BLOCK_WRITE),
-			    "Bug: Write fault blocked by AMR!");
+		return (regs->amr & AMR_KUAP_BLOCK_WRITE) == AMR_KUAP_BLOCK_WRITE;
 	}
-	return WARN(((regs->amr & AMR_KUAP_BLOCK_READ) == AMR_KUAP_BLOCK_READ),
-		    "Bug: Read fault blocked by AMR!");
+	return (regs->amr & AMR_KUAP_BLOCK_READ) == AMR_KUAP_BLOCK_READ;
 }
 
 static __always_inline void allow_user_access(void __user *to, const void __user *from,
diff --git a/arch/powerpc/include/asm/nohash/32/kup-8xx.h b/arch/powerpc/include/asm/nohash/32/kup-8xx.h
index 567cdc557402..17a4a616436f 100644
--- a/arch/powerpc/include/asm/nohash/32/kup-8xx.h
+++ b/arch/powerpc/include/asm/nohash/32/kup-8xx.h
@@ -63,8 +63,7 @@ static inline void restore_user_access(unsigned long flags)
 static inline bool
 bad_kuap_fault(struct pt_regs *regs, unsigned long address, bool is_write)
 {
-	return WARN(!((regs->kuap ^ MD_APG_KUAP) & 0xff000000),
-		    "Bug: fault blocked by AP register !");
+	return !((regs->kuap ^ MD_APG_KUAP) & 0xff000000);
 }
 
 #endif /* !__ASSEMBLY__ */
diff --git a/arch/powerpc/mm/fault.c b/arch/powerpc/mm/fault.c
index 3fcd34c28e10..04505f938bbc 100644
--- a/arch/powerpc/mm/fault.c
+++ b/arch/powerpc/mm/fault.c
@@ -228,7 +228,7 @@ static bool bad_kernel_fault(struct pt_regs *regs, unsigned long error_code,
 	// Read/write fault in a valid region (the exception table search passed
 	// above), but blocked by KUAP is bad, it can never succeed.
 	if (bad_kuap_fault(regs, address, is_write))
-		return true;
+		return WARN(true, "Bug: %s fault blocked by KUAP!", is_write ? "Write" : "Read");
 
 	// What's left? Kernel fault on user in well defined regions (extable
 	// matched), and allowed by KUAP in the faulting context.
-- 
2.25.0

