Return-Path: <SRS0=3bX/=SF=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B728C4360F
	for <linuxppc-dev@archiver.kernel.org>; Wed,  3 Apr 2019 20:18:03 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7BC1120700
	for <linuxppc-dev@archiver.kernel.org>; Wed,  3 Apr 2019 20:18:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="SD1lRnGg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7BC1120700
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44ZHSl66KZzDqJg
	for <linuxppc-dev@archiver.kernel.org>; Thu,  4 Apr 2019 07:17:59 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=c-s.fr
 (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@c-s.fr; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=c-s.fr header.i=@c-s.fr header.b="SD1lRnGg"; 
 dkim-atps=neutral
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44ZHCQ0B4nzDqGY
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Apr 2019 07:06:26 +1100 (AEDT)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 44ZHCG5gyjz9v3pr;
 Wed,  3 Apr 2019 22:06:18 +0200 (CEST)
Authentication-Results: localhost; dkim=pass
 reason="1024-bit key; insecure key"
 header.d=c-s.fr header.i=@c-s.fr header.b=SD1lRnGg; dkim-adsp=pass;
 dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id iHb_j0jQSX14; Wed,  3 Apr 2019 22:06:18 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 44ZHCG3xLkz9v3pp;
 Wed,  3 Apr 2019 22:06:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
 t=1554321978; bh=5yd1NAIr8P/S/pElfFeAqs29R+LkuX1lKFh0+n0sXbw=;
 h=In-Reply-To:References:From:Subject:To:Cc:Date:From;
 b=SD1lRnGgmSRo8zB79u3lH+VASY58E01ml01ozLHJj6tZe79U+juyL5xbZxqL7LsYf
 iB0eV+xhbbkv2a3JKBQO6Mx22w+Az++UHCTHeQr53HfekBYhh42Eikl1aCgC1QoOTc
 y2fGx7tkC7sNcNeyUIkugMMuut8pLSczx4Ra/nRg=
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id A7BB78B905;
 Wed,  3 Apr 2019 22:06:18 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id uvCkvxyeJRCo; Wed,  3 Apr 2019 22:06:18 +0200 (CEST)
Received: from po16846vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 7DB928B902;
 Wed,  3 Apr 2019 22:06:18 +0200 (CEST)
Received: by po16846vm.idsi0.si.c-s.fr (Postfix, from userid 0)
 id 600E3655EC; Wed,  3 Apr 2019 20:06:18 +0000 (UTC)
Message-Id: <2cd783f6975b126f024ee0965047342b6c36bded.1554321743.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1554321743.git.christophe.leroy@c-s.fr>
References: <cover.1554321743.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v1 06/15] powerpc/Kconfig: select PPC_MM_SLICES from subarch
 type
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, 
 aneesh.kumar@linux.ibm.com
Date: Wed,  3 Apr 2019 20:06:18 +0000 (UTC)
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

Lets select PPC_MM_SLICES from the subarch config item instead of
doing it via defaults declaration in the PPC_MM_SLICES item itself.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/platforms/Kconfig.cputype | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/platforms/Kconfig.cputype b/arch/powerpc/platforms/Kconfig.cputype
index 842b2c7e156a..a46a0adb634d 100644
--- a/arch/powerpc/platforms/Kconfig.cputype
+++ b/arch/powerpc/platforms/Kconfig.cputype
@@ -34,6 +34,7 @@ config PPC_8xx
 	bool "Freescale 8xx"
 	select FSL_SOC
 	select SYS_SUPPORTS_HUGETLBFS
+	select PPC_MM_SLICES if HUGETLB_PAGE
 
 config 40x
 	bool "AMCC 40x"
@@ -75,6 +76,7 @@ config PPC_BOOK3S_64
 	select ARCH_ENABLE_THP_MIGRATION if TRANSPARENT_HUGEPAGE
 	select ARCH_SUPPORTS_NUMA_BALANCING
 	select IRQ_WORK
+	select PPC_MM_SLICES
 
 config PPC_BOOK3E_64
 	bool "Embedded processors"
@@ -360,8 +362,6 @@ config PPC_BOOK3E_MMU
 
 config PPC_MM_SLICES
 	bool
-	default y if PPC_BOOK3S_64
-	default y if PPC_8xx && HUGETLB_PAGE
 
 config PPC_HAVE_PMU_SUPPORT
        bool
-- 
2.13.3

