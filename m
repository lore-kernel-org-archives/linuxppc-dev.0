Return-Path: <SRS0=ImKy=S4=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A0D6C43218
	for <linuxppc-dev@archiver.kernel.org>; Fri, 26 Apr 2019 06:06:51 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9EE6A206E0
	for <linuxppc-dev@archiver.kernel.org>; Fri, 26 Apr 2019 06:06:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="H5yXS0GE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9EE6A206E0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44r3V01v8lzDqf6
	for <linuxppc-dev@archiver.kernel.org>; Fri, 26 Apr 2019 16:06:48 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=c-s.fr
 (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@c-s.fr; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=c-s.fr header.i=@c-s.fr header.b="H5yXS0GE"; 
 dkim-atps=neutral
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44r3Kn3nk5zDqSh
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 Apr 2019 15:59:40 +1000 (AEST)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 44r3Kg62vVz9v1v6;
 Fri, 26 Apr 2019 07:59:35 +0200 (CEST)
Authentication-Results: localhost; dkim=pass
 reason="1024-bit key; insecure key"
 header.d=c-s.fr header.i=@c-s.fr header.b=H5yXS0GE; dkim-adsp=pass;
 dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id xMGdyZ-sALfV; Fri, 26 Apr 2019 07:59:35 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 44r3Kg4s4Gz9v1tj;
 Fri, 26 Apr 2019 07:59:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
 t=1556258375; bh=Zm6ZnYvUkWxwYXsOqQdxiSykYTniGaBNNjGiCYmoLWc=;
 h=In-Reply-To:References:From:Subject:To:Cc:Date:From;
 b=H5yXS0GEP+GF89KizLPXR51Xpzb7Q57+wrhMPVF3CAnrtbwcYf7/T6AUnMM4om3i3
 0FF8FK9bk0oi/YeOJPUNd+0GYa1z/KjwlOPkWiU1IFDah2zsvBwSkfvkclzkgprhoC
 3hdGpfEVfQ0OShsG+TCQwziDhsOa76iTuF4eMIrY=
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 8D7DF8B807;
 Fri, 26 Apr 2019 07:59:36 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id 0V0bsa9S-etu; Fri, 26 Apr 2019 07:59:36 +0200 (CEST)
Received: from po16846vm.idsi0.si.c-s.fr (po15451.idsi0.si.c-s.fr
 [172.25.231.6])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 690E88B74C;
 Fri, 26 Apr 2019 07:59:36 +0200 (CEST)
Received: by po16846vm.idsi0.si.c-s.fr (Postfix, from userid 0)
 id 5F02866278; Fri, 26 Apr 2019 05:59:36 +0000 (UTC)
Message-Id: <ff4366d14b3ef4de6af835a880a772477577139f.1556258135.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1556258134.git.christophe.leroy@c-s.fr>
References: <cover.1556258134.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v2 01/17] powerpc/mm: Don't BUG() in hugepd_page()
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, 
 aneesh.kumar@linux.ibm.com
Date: Fri, 26 Apr 2019 05:59:36 +0000 (UTC)
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

Use VM_BUG_ON() instead of BUG_ON(), as those BUG_ON()
are not there to catch runtime errors but to catch errors
during development cycle only.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/include/asm/hugetlb.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/include/asm/hugetlb.h b/arch/powerpc/include/asm/hugetlb.h
index 8d40565ad0c3..7f1867e428c0 100644
--- a/arch/powerpc/include/asm/hugetlb.h
+++ b/arch/powerpc/include/asm/hugetlb.h
@@ -14,7 +14,7 @@
  */
 static inline pte_t *hugepd_page(hugepd_t hpd)
 {
-	BUG_ON(!hugepd_ok(hpd));
+	VM_BUG_ON(!hugepd_ok(hpd));
 	/*
 	 * We have only four bits to encode, MMU page size
 	 */
@@ -42,7 +42,7 @@ static inline void flush_hugetlb_page(struct vm_area_struct *vma,
 
 static inline pte_t *hugepd_page(hugepd_t hpd)
 {
-	BUG_ON(!hugepd_ok(hpd));
+	VM_BUG_ON(!hugepd_ok(hpd));
 #ifdef CONFIG_PPC_8xx
 	return (pte_t *)__va(hpd_val(hpd) & ~HUGEPD_SHIFT_MASK);
 #else
-- 
2.13.3

