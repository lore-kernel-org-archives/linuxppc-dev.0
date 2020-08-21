Return-Path: <SRS0=lwUg=B7=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64249C433DF
	for <linuxppc-dev@archiver.kernel.org>; Fri, 21 Aug 2020 01:14:49 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 10A1D20748
	for <linuxppc-dev@archiver.kernel.org>; Fri, 21 Aug 2020 01:14:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=anastas.io header.i=@anastas.io header.b="BBzskPd9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 10A1D20748
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=anastas.io
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4BXk863HL0zDqkC
	for <linuxppc-dev@archiver.kernel.org>; Fri, 21 Aug 2020 11:14:46 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=anastas.io (client-ip=104.248.188.109; helo=alpha.anastas.io;
 envelope-from=shawn@anastas.io; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none)
 header.from=anastas.io
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=anastas.io header.i=@anastas.io header.a=rsa-sha256
 header.s=mail header.b=BBzskPd9; dkim-atps=neutral
Received: from alpha.anastas.io (alpha.anastas.io [104.248.188.109])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4BXk1q1pSCzDr2w
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Aug 2020 11:09:18 +1000 (AEST)
Received: from authenticated-user (alpha.anastas.io [104.248.188.109])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by alpha.anastas.io (Postfix) with ESMTPSA id 06D007ECD5;
 Thu, 20 Aug 2020 20:08:45 -0500 (CDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=anastas.io; s=mail;
 t=1597972126; bh=j+w6XtGkxtFNQ0GLezhFKHopmQXUH7iSQXejY1lxhqo=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=BBzskPd9V++glJSpFF2eIMs/ArJL8yXVYvsYzDumrZjeKnAFeOLnLoT7/42aXH3Te
 PKSilvxQ1p7rSeCdqeryL4jlvkTQDp+w3nZkdthWSOnmYegmUKMMel6ta9n2ZsZkN0
 PUKHAaD1eppDYIOwax8xxghL2p2NaJrJiOzeZHqLJFc+SRn7vT4dBvYyZpKEfEnqIK
 n3YO9fiNeTp+T2ZgC8GaJx1TXZANziWKrMuA+ndZ3WPmdu8neixCO+g7RBTy6ma3Uv
 w5ZmDuiQl49+CAs96pkXTC7Fz92w6MHc8gqJ/parB/sfKP67Ut/KpehIJn1HTVuyC3
 DURc6QuT79LPw==
From: Shawn Anastasio <shawn@anastas.io>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 2/2] powerpc/64s: Disallow PROT_SAO in LPARs by default
Date: Thu, 20 Aug 2020 20:08:37 -0500
Message-Id: <20200821010837.4079-3-shawn@anastas.io>
In-Reply-To: <20200821010837.4079-1-shawn@anastas.io>
References: <20200821010837.4079-1-shawn@anastas.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
Cc: npiggin@gmail.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Since migration of guests using SAO to ISA 3.1 hosts may cause issues,
disable PROT_SAO in LPARs by default and introduce a new Kconfig option
PPC_PROT_SAO_LPAR to allow users to enable it if desired.

Signed-off-by: Shawn Anastasio <shawn@anastas.io>
---
 arch/powerpc/Kconfig            | 12 ++++++++++++
 arch/powerpc/include/asm/mman.h |  9 +++++++--
 2 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 1f48bbfb3ce9..65bed1fdeaad 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -860,6 +860,18 @@ config PPC_SUBPAGE_PROT
 
 	  If unsure, say N here.
 
+config PPC_PROT_SAO_LPAR
+	bool "Support PROT_SAO mappings in LPARs"
+	depends on PPC_BOOK3S_64
+	help
+	  This option adds support for PROT_SAO mappings from userspace
+	  inside LPARs on supported CPUs.
+
+	  This may cause issues when performing guest migration from
+	  a CPU that supports SAO to one that does not.
+
+	  If unsure, say N here.
+
 config PPC_COPRO_BASE
 	bool
 
diff --git a/arch/powerpc/include/asm/mman.h b/arch/powerpc/include/asm/mman.h
index 4ba303ea27f5..7cb6d18f5cd6 100644
--- a/arch/powerpc/include/asm/mman.h
+++ b/arch/powerpc/include/asm/mman.h
@@ -40,8 +40,13 @@ static inline bool arch_validate_prot(unsigned long prot, unsigned long addr)
 {
 	if (prot & ~(PROT_READ | PROT_WRITE | PROT_EXEC | PROT_SEM | PROT_SAO))
 		return false;
-	if ((prot & PROT_SAO) && !cpu_has_feature(CPU_FTR_SAO))
-		return false;
+	if (prot & PROT_SAO) {
+		if (!cpu_has_feature(CPU_FTR_SAO))
+			return false;
+		if (firmware_has_feature(FW_FEATURE_LPAR) &&
+		    !IS_ENABLED(CONFIG_PPC_PROT_SAO_LPAR))
+			return false;
+	}
 	return true;
 }
 #define arch_validate_prot arch_validate_prot
-- 
2.28.0

