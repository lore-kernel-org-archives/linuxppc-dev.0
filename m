Return-Path: <SRS0=ts8b=SV=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53B41C282DA
	for <linuxppc-dev@archiver.kernel.org>; Fri, 19 Apr 2019 09:53:30 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BEC15218EA
	for <linuxppc-dev@archiver.kernel.org>; Fri, 19 Apr 2019 09:53:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="SIFc/1m5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BEC15218EA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44lrrl6t5JzDqVP
	for <linuxppc-dev@archiver.kernel.org>; Fri, 19 Apr 2019 19:53:27 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=softfail (mailfrom) smtp.mailfrom=socionext.com
 (client-ip=210.131.2.75; helo=conuserg-08.nifty.com;
 envelope-from=yamada.masahiro@socionext.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=nifty.com header.i=@nifty.com header.b="SIFc/1m5"; 
 dkim-atps=neutral
Received: from conuserg-08.nifty.com (conuserg-08.nifty.com [210.131.2.75])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44lrlm5hrdzDqTP
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Apr 2019 19:49:08 +1000 (AEST)
Received: from localhost.localdomain (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp
 [153.142.97.92]) (authenticated)
 by conuserg-08.nifty.com with ESMTP id x3J9mDiP012304;
 Fri, 19 Apr 2019 18:48:19 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-08.nifty.com x3J9mDiP012304
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
 s=dec2015msa; t=1555667301;
 bh=I2dC2tyzuGPeMYW8zJtLNO2SxFu0p9zAPUz6pi0qgOE=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=SIFc/1m5Ydc1pZqGsG3eCmgNiSfy3fEcTrRuHrMyDzt0b0jj8XwnxcaFy2Z7DWjGS
 riHzRpJ1EiNeDdL5Gc9dT3SupXXDMA3GtG2u3K8Pxca74T2MoE5mm4aTh1DIhR0sLH
 sr01yXX6NTPQ4hvahiHWs5qiPJx+5swXFNgMpDL//v75znyCBqWjafE4ok5qB1xpNw
 FU4tOnsrJEcK/hbukt8CeCEuN+fheDfVwyNT6ZjigMy9E0ZREQHML885hMwaFDg7W9
 EcjaUqUPqSosX8RQMcdvBqJM8nvjfZ6C4I5zLTZlAu6aYHGZ2LzOBOi9XH5rueuPtj
 Uiob7ameRmtFA==
X-Nifty-SrcIP: [153.142.97.92]
From: Masahiro Yamada <yamada.masahiro@socionext.com>
To: Andrew Morton <akpm@linux-foundation.org>,
 linux-arch <linux-arch@vger.kernel.org>
Subject: [PATCH v2 04/11] s390/cpacf: mark scpacf_query() as __always_inline
Date: Fri, 19 Apr 2019 18:47:47 +0900
Message-Id: <20190419094754.24667-5-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190419094754.24667-1-yamada.masahiro@socionext.com>
References: <20190419094754.24667-1-yamada.masahiro@socionext.com>
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
Cc: linux-s390@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, x86@kernel.org,
 Heiko Carstens <heiko.carstens@de.ibm.com>, linux-mips@vger.kernel.org,
 linux-kernel@vger.kernel.org, Masahiro Yamada <yamada.masahiro@socionext.com>,
 Ingo Molnar <mingo@redhat.com>, linux-mtd@lists.infradead.org,
 linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

This prepares to move CONFIG_OPTIMIZE_INLINING from x86 to a common
place. We need to eliminate potential issues beforehand.

If it is enabled for s390, the following error is reported:

In file included from arch/s390/crypto/des_s390.c:19:
./arch/s390/include/asm/cpacf.h: In function 'cpacf_query':
./arch/s390/include/asm/cpacf.h:170:2: warning: asm operand 3 probably doesn't match constraints
  asm volatile(
  ^~~
./arch/s390/include/asm/cpacf.h:170:2: error: impossible constraint in 'asm'

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

Changes in v2:
  - split into a separate patch

 arch/s390/include/asm/cpacf.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/s390/include/asm/cpacf.h b/arch/s390/include/asm/cpacf.h
index 3cc52e37b4b2..f316de40e51b 100644
--- a/arch/s390/include/asm/cpacf.h
+++ b/arch/s390/include/asm/cpacf.h
@@ -202,7 +202,7 @@ static inline int __cpacf_check_opcode(unsigned int opcode)
 	}
 }
 
-static inline int cpacf_query(unsigned int opcode, cpacf_mask_t *mask)
+static __always_inline int cpacf_query(unsigned int opcode, cpacf_mask_t *mask)
 {
 	if (__cpacf_check_opcode(opcode)) {
 		__cpacf_query(opcode, mask);
-- 
2.17.1

