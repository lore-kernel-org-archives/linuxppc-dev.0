Return-Path: <SRS0=/W8y=SZ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2042EC282E1
	for <linuxppc-dev@archiver.kernel.org>; Tue, 23 Apr 2019 03:53:18 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8DE60206BA
	for <linuxppc-dev@archiver.kernel.org>; Tue, 23 Apr 2019 03:53:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="afqDfXVj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8DE60206BA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44p8gH1SBnzDqMq
	for <linuxppc-dev@archiver.kernel.org>; Tue, 23 Apr 2019 13:53:15 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=softfail (mailfrom) smtp.mailfrom=socionext.com
 (client-ip=210.131.2.74; helo=conuserg-07.nifty.com;
 envelope-from=yamada.masahiro@socionext.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=nifty.com header.i=@nifty.com header.b="afqDfXVj"; 
 dkim-atps=neutral
Received: from conuserg-07.nifty.com (conuserg-07.nifty.com [210.131.2.74])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44p8cr66s7zDqK6
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Apr 2019 13:51:08 +1000 (AEST)
Received: from localhost.localdomain (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp
 [153.142.97.92]) (authenticated)
 by conuserg-07.nifty.com with ESMTP id x3N3o2cB023044;
 Tue, 23 Apr 2019 12:50:06 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-07.nifty.com x3N3o2cB023044
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
 s=dec2015msa; t=1555991406;
 bh=Uo1hU/pOzqv1Q6UwWPC8xpA1XS41uzJeh8wwHc0qw10=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=afqDfXVjkaU0um6ru4UQMMi/0BjTNH297qWtGHSlxZheAmZyP7g2xdSoWOVya1o3F
 wGNcrJgeLRi6N/dbYoVHmPyHDzsnc2AU0bWQ+9qUTrdrQivAR0riQON09o58AWsOGr
 3MiTJC5LhBxOf783Kh7T5ogQtLBRlDPZpIjEknU13Pb5R24UeulQjWWACsWqksWNy/
 MOi4jEYXLWhhh0fOsa98tELQZ7ialZWJGxUV2Bf+R1moCuqtuvyxDYXI3zc0pibOqZ
 Ia4mCuwX/wsrlpQjBMZfH8khciAtejgbm1rP56cXK3ZONAbZKMksvRc2KMzhxqMxfc
 n907v8qlw7Oqw==
X-Nifty-SrcIP: [153.142.97.92]
From: Masahiro Yamada <yamada.masahiro@socionext.com>
To: Andrew Morton <akpm@linux-foundation.org>,
 linux-arch <linux-arch@vger.kernel.org>
Subject: [RESEND PATCH v3 03/11] MIPS: mark mult_sh_align_mod() as
 __always_inline
Date: Tue, 23 Apr 2019 12:49:51 +0900
Message-Id: <20190423034959.13525-4-yamada.masahiro@socionext.com>
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

If it is enabled for mips, the following error is reported:

arch/mips/kernel/cpu-bugs64.c: In function 'mult_sh_align_mod.constprop':
arch/mips/kernel/cpu-bugs64.c:33:2: error: asm operand 1 probably doesn't match constraints [-Werror]
  asm volatile(
  ^~~
arch/mips/kernel/cpu-bugs64.c:33:2: error: asm operand 1 probably doesn't match constraints [-Werror]
  asm volatile(
  ^~~
arch/mips/kernel/cpu-bugs64.c:33:2: error: impossible constraint in 'asm'
  asm volatile(
  ^~~
arch/mips/kernel/cpu-bugs64.c:33:2: error: impossible constraint in 'asm'
  asm volatile(
  ^~~

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

Changes in v3: None
Changes in v2:
  - split into a separate patch

 arch/mips/kernel/cpu-bugs64.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/mips/kernel/cpu-bugs64.c b/arch/mips/kernel/cpu-bugs64.c
index bada74af7641..c04b97aace4a 100644
--- a/arch/mips/kernel/cpu-bugs64.c
+++ b/arch/mips/kernel/cpu-bugs64.c
@@ -42,8 +42,8 @@ static inline void align_mod(const int align, const int mod)
 		: "n"(align), "n"(mod));
 }
 
-static inline void mult_sh_align_mod(long *v1, long *v2, long *w,
-				     const int align, const int mod)
+static __always_inline void mult_sh_align_mod(long *v1, long *v2, long *w,
+					      const int align, const int mod)
 {
 	unsigned long flags;
 	int m1, m2;
-- 
2.17.1

