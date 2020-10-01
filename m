Return-Path: <SRS0=1OJO=DI=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB9CEC4727C
	for <linuxppc-dev@archiver.kernel.org>; Thu,  1 Oct 2020 12:53:46 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 427DA2075F
	for <linuxppc-dev@archiver.kernel.org>; Thu,  1 Oct 2020 12:53:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 427DA2075F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csgroup.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4C2Cjh03JTzDqQb
	for <linuxppc-dev@archiver.kernel.org>; Thu,  1 Oct 2020 22:53:44 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=csgroup.eu (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@csgroup.eu; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=csgroup.eu
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4C2CT473PPzDqBN
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  1 Oct 2020 22:42:45 +1000 (AEST)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 4C2CSw6Lrnz9tx8X;
 Thu,  1 Oct 2020 14:42:40 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id DG2Gqi6lg23E; Thu,  1 Oct 2020 14:42:40 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 4C2CSw5338z9twnv;
 Thu,  1 Oct 2020 14:42:40 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 8CFC08B97A;
 Thu,  1 Oct 2020 14:42:42 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id 0LHxUKLwaS-p; Thu,  1 Oct 2020 14:42:42 +0200 (CEST)
Received: from po17688vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 333398B903;
 Thu,  1 Oct 2020 14:42:42 +0200 (CEST)
Received: by po17688vm.idsi0.si.c-s.fr (Postfix, from userid 0)
 id 2E63365ED8; Thu,  1 Oct 2020 12:42:41 +0000 (UTC)
Message-Id: <41573406a4eab98838decaa91649086fef1e6119.1601556145.git.christophe.leroy@csgroup.eu>
In-Reply-To: <94dc68d3d9ef9eb549796d4b938b6ba0305a049b.1601556145.git.christophe.leroy@csgroup.eu>
References: <94dc68d3d9ef9eb549796d4b938b6ba0305a049b.1601556145.git.christophe.leroy@csgroup.eu>
From: Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH 3/6] powerpc/time: Avoid using get_tbl() and get_tbu()
 internally
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>
Date: Thu,  1 Oct 2020 12:42:41 +0000 (UTC)
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

get_tbl() is confusing as it returns the content of TBL register
on PPC32 but the concatenation of TBL and TBU on PPC64.

Use mftb() instead.

Do the same with get_tbu() for consistency allthough it's name
is less confusing.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/include/asm/delay.h | 2 +-
 arch/powerpc/include/asm/time.h  | 8 ++++----
 arch/powerpc/kernel/time.c       | 4 ++--
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/powerpc/include/asm/delay.h b/arch/powerpc/include/asm/delay.h
index 66963f7d3e64..51bb8c1476c7 100644
--- a/arch/powerpc/include/asm/delay.h
+++ b/arch/powerpc/include/asm/delay.h
@@ -54,7 +54,7 @@ extern void udelay(unsigned long usecs);
 ({                                                                             \
 	typeof(condition) __ret;                                               \
 	unsigned long __loops = tb_ticks_per_usec * timeout;                   \
-	unsigned long __start = get_tbl();                                     \
+	unsigned long __start = mftb();                                     \
                                                                                \
 	if (delay) {                                                           \
 		while (!(__ret = (condition)) &&                               \
diff --git a/arch/powerpc/include/asm/time.h b/arch/powerpc/include/asm/time.h
index b0fb8456305f..3ef0f4b3299e 100644
--- a/arch/powerpc/include/asm/time.h
+++ b/arch/powerpc/include/asm/time.h
@@ -97,9 +97,9 @@ static inline u64 get_tb(void)
 	unsigned int tbhi, tblo, tbhi2;
 
 	do {
-		tbhi = get_tbu();
-		tblo = get_tbl();
-		tbhi2 = get_tbu();
+		tbhi = mftbu();
+		tblo = mftb();
+		tbhi2 = mftbu();
 	} while (tbhi != tbhi2);
 
 	return ((u64)tbhi << 32) | tblo;
@@ -153,7 +153,7 @@ static inline unsigned long tb_ticks_since(unsigned long tstamp)
 		int delta = get_rtcl() - (unsigned int) tstamp;
 		return delta < 0 ? delta + 1000000000 : delta;
 	}
-	return get_tbl() - tstamp;
+	return mftb() - tstamp;
 }
 
 #define mulhwu(x,y) \
diff --git a/arch/powerpc/kernel/time.c b/arch/powerpc/kernel/time.c
index f85539ebb513..a9cbd5a61585 100644
--- a/arch/powerpc/kernel/time.c
+++ b/arch/powerpc/kernel/time.c
@@ -467,8 +467,8 @@ void __delay(unsigned long loops)
 		 */
 		spin_cpu_relax();
 	} else {
-		start = get_tbl();
-		while (get_tbl() - start < loops)
+		start = mftb();
+		while (mftb() - start < loops)
 			spin_cpu_relax();
 	}
 	spin_end();
-- 
2.25.0

