Return-Path: <SRS0=/W8y=SZ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A265C10F14
	for <linuxppc-dev@archiver.kernel.org>; Tue, 23 Apr 2019 04:02:05 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 93C8920843
	for <linuxppc-dev@archiver.kernel.org>; Tue, 23 Apr 2019 04:02:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="Wkvm6o1l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93C8920843
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44p8sP6h5YzDqCX
	for <linuxppc-dev@archiver.kernel.org>; Tue, 23 Apr 2019 14:02:01 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=softfail (mailfrom) smtp.mailfrom=socionext.com
 (client-ip=210.131.2.74; helo=conuserg-07.nifty.com;
 envelope-from=yamada.masahiro@socionext.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=nifty.com header.i=@nifty.com header.b="Wkvm6o1l"; 
 dkim-atps=neutral
Received: from conuserg-07.nifty.com (conuserg-07.nifty.com [210.131.2.74])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44p8d933wdzDqNw
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Apr 2019 13:51:25 +1000 (AEST)
Received: from localhost.localdomain (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp
 [153.142.97.92]) (authenticated)
 by conuserg-07.nifty.com with ESMTP id x3N3o2cI023044;
 Tue, 23 Apr 2019 12:50:17 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-07.nifty.com x3N3o2cI023044
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
 s=dec2015msa; t=1555991417;
 bh=O+ymeBuOvG0uQG78yokX58qG5GQYyDm6Ks5zKkCXYg8=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=Wkvm6o1lunQyjJ9Kab2hpLJJedT9k6nDHed+tC9S6VEWmYvf12KiI0/z8UecSh1Eg
 xrkEGs/qi9IL4SEof7zav4uTYP2NKn+XLwUo/z1vl1eIWuA17x8p75dh3d6jQOZGHh
 N2qAtQbEChxQuldIRkwF1/08tj7sFulQcpJj8OpsIyRxy74PnIjvZVRyrF/edxyZnk
 LU9ba5mzUm28sLO+xk7dX5WwI3G4smz4D4xfAkONCSj9ym/jZSJQOCfTXeoOdlT3Xh
 ZWG8+Sol2L2KV3VGsZzHGEn8/lvYNwrSeDfa5qvcdMvUX8pvYS/oTV4OjOO7F7wkkQ
 r8yksoHWxXEqw==
X-Nifty-SrcIP: [153.142.97.92]
From: Masahiro Yamada <yamada.masahiro@socionext.com>
To: Andrew Morton <akpm@linux-foundation.org>,
 linux-arch <linux-arch@vger.kernel.org>
Subject: [RESEND PATCH v3 10/11] powerpc/mm/radix: mark as __tlbie_pid() and
 friends as__always_inline
Date: Tue, 23 Apr 2019 12:49:58 +0900
Message-Id: <20190423034959.13525-11-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190423034959.13525-1-yamada.masahiro@socionext.com>
References: <20190423034959.13525-1-yamada.masahiro@socionext.com>
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
Cc: linux-s390@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
 Mathieu Malaterre <malat@debian.org>, x86@kernel.org,
 Heiko Carstens <heiko.carstens@de.ibm.com>, linux-mips@vger.kernel.org,
 linux-kernel@vger.kernel.org, Masahiro Yamada <yamada.masahiro@socionext.com>,
 Ingo Molnar <mingo@redhat.com>, linux-mtd@lists.infradead.org,
 linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

This prepares to move CONFIG_OPTIMIZE_INLINING from x86 to a common
place. We need to eliminate potential issues beforehand.

If it is enabled for powerpc, the following errors are reported:

arch/powerpc/mm/tlb-radix.c: In function '__tlbie_lpid':
arch/powerpc/mm/tlb-radix.c:148:2: warning: asm operand 3 probably doesn't match constraints
  asm volatile(PPC_TLBIE_5(%0, %4, %3, %2, %1)
  ^~~
arch/powerpc/mm/tlb-radix.c:148:2: error: impossible constraint in 'asm'
arch/powerpc/mm/tlb-radix.c: In function '__tlbie_pid':
arch/powerpc/mm/tlb-radix.c:118:2: warning: asm operand 3 probably doesn't match constraints
  asm volatile(PPC_TLBIE_5(%0, %4, %3, %2, %1)
  ^~~
arch/powerpc/mm/tlb-radix.c: In function '__tlbiel_pid':
arch/powerpc/mm/tlb-radix.c:104:2: warning: asm operand 3 probably doesn't match constraints
  asm volatile(PPC_TLBIEL(%0, %4, %3, %2, %1)
  ^~~

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

Changes in v3: None
Changes in v2:
  - new patch

 arch/powerpc/mm/tlb-radix.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/mm/tlb-radix.c b/arch/powerpc/mm/tlb-radix.c
index a2b2848f0ae3..14ff414d1545 100644
--- a/arch/powerpc/mm/tlb-radix.c
+++ b/arch/powerpc/mm/tlb-radix.c
@@ -90,8 +90,8 @@ void radix__tlbiel_all(unsigned int action)
 	asm volatile(PPC_INVALIDATE_ERAT "; isync" : : :"memory");
 }
 
-static inline void __tlbiel_pid(unsigned long pid, int set,
-				unsigned long ric)
+static __always_inline void __tlbiel_pid(unsigned long pid, int set,
+					 unsigned long ric)
 {
 	unsigned long rb,rs,prs,r;
 
@@ -106,7 +106,7 @@ static inline void __tlbiel_pid(unsigned long pid, int set,
 	trace_tlbie(0, 1, rb, rs, ric, prs, r);
 }
 
-static inline void __tlbie_pid(unsigned long pid, unsigned long ric)
+static __always_inline void __tlbie_pid(unsigned long pid, unsigned long ric)
 {
 	unsigned long rb,rs,prs,r;
 
@@ -136,7 +136,7 @@ static inline void __tlbiel_lpid(unsigned long lpid, int set,
 	trace_tlbie(lpid, 1, rb, rs, ric, prs, r);
 }
 
-static inline void __tlbie_lpid(unsigned long lpid, unsigned long ric)
+static __always_inline void __tlbie_lpid(unsigned long lpid, unsigned long ric)
 {
 	unsigned long rb,rs,prs,r;
 
@@ -239,7 +239,7 @@ static inline void fixup_tlbie_lpid(unsigned long lpid)
 /*
  * We use 128 set in radix mode and 256 set in hpt mode.
  */
-static inline void _tlbiel_pid(unsigned long pid, unsigned long ric)
+static __always_inline void _tlbiel_pid(unsigned long pid, unsigned long ric)
 {
 	int set;
 
-- 
2.17.1

