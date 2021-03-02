Return-Path: <SRS0=ynH/=IA=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12FE3C433E0
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Mar 2021 02:10:27 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C10E76148E
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Mar 2021 02:10:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C10E76148E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4DqLFD2dHKz3d4y
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Mar 2021 13:10:24 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au header.a=rsa-sha256 header.s=201909 header.b=i7a9YCDR;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=ozlabs.org (client-ip=2401:3900:2:1::2; helo=ozlabs.org;
 envelope-from=michael@ozlabs.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au
 header.a=rsa-sha256 header.s=201909 header.b=i7a9YCDR; 
 dkim-atps=neutral
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4DqLDj69q2z30Jj
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  2 Mar 2021 13:09:57 +1100 (AEDT)
Received: by ozlabs.org (Postfix, from userid 1034)
 id 4DqLDj4lvPz9sVw; Tue,  2 Mar 2021 13:09:57 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
 s=201909; t=1614650997;
 bh=3By2plsfm8KYf9qxlo26luvRA7Hv3TzI8Eo2K+ayWyA=;
 h=From:To:Subject:Date:From;
 b=i7a9YCDRsEcbDUkzVFobsXvMXPDq1MpSQPw2e3FOZR9a4etePuG1y8EXMUZ1TC15b
 b94M3hV6YaG1OsYUPTLr62hbXw2lOc9a0LUT52Bk6fLQ4s70mgExoCHLdtLB9C/VW8
 i4ziX1NLe/3BeSAYgh+G+kUhyVVlYpkdKgbaqbrNtxEBD0uAR/5PaCVX0cPUEMiZzS
 YYY8OsKvdFFSIWDeO5Y1OwQLilhuPvXNFbuhicM0Vbe4XAFIL1NPo3AbLWNUpxD4Fo
 i8wi8c6/UJxkXCwHIFJ88khHZvvVKICVJFUKt8/i840FgokUFtjql0mkTZkRwc+S9F
 1aPrz6cPfoTgQ==
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] powerpc/configs: Add IBMVNIC to some 64-bit configs
Date: Tue,  2 Mar 2021 13:09:54 +1100
Message-Id: <20210302020954.2980046-1-mpe@ellerman.id.au>
X-Mailer: git-send-email 2.25.1
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
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

This is an IBM specific driver that we should enable to get some
build/boot testing.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/configs/ppc64_defconfig   | 1 +
 arch/powerpc/configs/pseries_defconfig | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/powerpc/configs/ppc64_defconfig b/arch/powerpc/configs/ppc64_defconfig
index 4f05a6652478..f82675d4d44e 100644
--- a/arch/powerpc/configs/ppc64_defconfig
+++ b/arch/powerpc/configs/ppc64_defconfig
@@ -177,6 +177,7 @@ CONFIG_CHELSIO_T1=m
 CONFIG_BE2NET=m
 CONFIG_IBMVETH=m
 CONFIG_EHEA=m
+CONFIG_IBMVNIC=m
 CONFIG_E100=y
 CONFIG_E1000=y
 CONFIG_E1000E=y
diff --git a/arch/powerpc/configs/pseries_defconfig b/arch/powerpc/configs/pseries_defconfig
index 777221775c83..a85ff7bc1fb7 100644
--- a/arch/powerpc/configs/pseries_defconfig
+++ b/arch/powerpc/configs/pseries_defconfig
@@ -159,6 +159,7 @@ CONFIG_BE2NET=m
 CONFIG_S2IO=m
 CONFIG_IBMVETH=y
 CONFIG_EHEA=y
+CONFIG_IBMVNIC=y
 CONFIG_E100=y
 CONFIG_E1000=y
 CONFIG_E1000E=y
-- 
2.25.1

