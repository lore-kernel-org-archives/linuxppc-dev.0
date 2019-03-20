Return-Path: <SRS0=4bR/=RX=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F241AC10F0D
	for <linuxppc-dev@archiver.kernel.org>; Wed, 20 Mar 2019 10:18:11 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 765752175B
	for <linuxppc-dev@archiver.kernel.org>; Wed, 20 Mar 2019 10:18:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="oKgFQVNj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 765752175B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44PQq543KNzDqQg
	for <linuxppc-dev@archiver.kernel.org>; Wed, 20 Mar 2019 21:18:09 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=c-s.fr
 (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@c-s.fr; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=c-s.fr header.i=@c-s.fr header.b="oKgFQVNj"; 
 dkim-atps=neutral
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44PQZ01qV0zDqJj
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Mar 2019 21:06:48 +1100 (AEDT)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 44PQYq6rttz9vC04;
 Wed, 20 Mar 2019 11:06:39 +0100 (CET)
Authentication-Results: localhost; dkim=pass
 reason="1024-bit key; insecure key"
 header.d=c-s.fr header.i=@c-s.fr header.b=oKgFQVNj; dkim-adsp=pass;
 dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id 8g_cGDYGbEbI; Wed, 20 Mar 2019 11:06:39 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 44PQYq5Wbrz9vByx;
 Wed, 20 Mar 2019 11:06:39 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
 t=1553076399; bh=h7/rZIF3uGtCrZZS12jpO81CTlxOtTpT+Awl5ww0sac=;
 h=In-Reply-To:References:From:Subject:To:Cc:Date:From;
 b=oKgFQVNjUVGemogterTVlY+J/TJ+hoMWMYrQegHvDjKiBNF36F+oQxK/HCWLUB+Uu
 PyO2RPMX43b8901qisEozzZP4y+UVRQP/TEEKyoqcpKDtXLWUItzKZA3fcMDy1c78J
 8XqLh5/rFDN1BSn/9XhQ+npdq+OA6KdhcH1xXQOU=
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id D9FCE8B918;
 Wed, 20 Mar 2019 11:06:40 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id PMN5MDTOsgIx; Wed, 20 Mar 2019 11:06:40 +0100 (CET)
Received: from po16846vm.idsi0.si.c-s.fr (unknown [172.25.231.2])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id BF06F8B911;
 Wed, 20 Mar 2019 11:06:40 +0100 (CET)
Received: by po16846vm.idsi0.si.c-s.fr (Postfix, from userid 0)
 id A44CE63AEF; Wed, 20 Mar 2019 10:06:40 +0000 (UTC)
Message-Id: <463eb6599ff3ed0a3238be5e01c7d4508042f7f8.1553076180.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1553076180.git.christophe.leroy@c-s.fr>
References: <cover.1553076180.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v1 05/27] powerpc/mm: drop slice_set_user_psize()
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, 
 aneesh.kumar@linux.ibm.com
Date: Wed, 20 Mar 2019 10:06:40 +0000 (UTC)
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

slice_set_user_psize() is not used anymore, drop it.

Fixes: 1753dd183036 ("powerpc/mm/slice: Simplify and optimise slice context initialisation")
Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/include/asm/book3s/64/slice.h | 5 -----
 arch/powerpc/include/asm/nohash/64/slice.h | 1 -
 2 files changed, 6 deletions(-)

diff --git a/arch/powerpc/include/asm/book3s/64/slice.h b/arch/powerpc/include/asm/book3s/64/slice.h
index db0dedab65ee..af498b0da21a 100644
--- a/arch/powerpc/include/asm/book3s/64/slice.h
+++ b/arch/powerpc/include/asm/book3s/64/slice.h
@@ -16,11 +16,6 @@
 #else /* CONFIG_PPC_MM_SLICES */
 
 #define get_slice_psize(mm, addr)	((mm)->context.user_psize)
-#define slice_set_user_psize(mm, psize)		\
-do {						\
-	(mm)->context.user_psize = (psize);	\
-	(mm)->context.sllp = SLB_VSID_USER | mmu_psize_defs[(psize)].sllp; \
-} while (0)
 
 #endif /* CONFIG_PPC_MM_SLICES */
 
diff --git a/arch/powerpc/include/asm/nohash/64/slice.h b/arch/powerpc/include/asm/nohash/64/slice.h
index ad0d6e3cc1c5..1a32d1fae6af 100644
--- a/arch/powerpc/include/asm/nohash/64/slice.h
+++ b/arch/powerpc/include/asm/nohash/64/slice.h
@@ -7,6 +7,5 @@
 #else /* CONFIG_PPC_64K_PAGES */
 #define get_slice_psize(mm, addr)	MMU_PAGE_4K
 #endif /* !CONFIG_PPC_64K_PAGES */
-#define slice_set_user_psize(mm, psize)	do { BUG(); } while (0)
 
 #endif /* _ASM_POWERPC_NOHASH_64_SLICE_H */
-- 
2.13.3

