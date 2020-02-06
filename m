Return-Path: <SRS0=dZYZ=32=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CFFAC2D0B1
	for <linuxppc-dev@archiver.kernel.org>; Thu,  6 Feb 2020 08:13:19 +0000 (UTC)
Received: from lists.ozlabs.org (unknown [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 725CC20720
	for <linuxppc-dev@archiver.kernel.org>; Thu,  6 Feb 2020 08:13:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="d1QUD3BB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 725CC20720
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 48Crlv6SvzzDqZw
	for <linuxppc-dev@archiver.kernel.org>; Thu,  6 Feb 2020 19:13:15 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (sender SPF authorized) smtp.mailfrom=c-s.fr
 (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@c-s.fr; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=c-s.fr header.i=@c-s.fr header.a=rsa-sha256
 header.s=mail header.b=d1QUD3BB; dkim-atps=neutral
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 48CrkB1XCCzDqX7
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  6 Feb 2020 19:11:44 +1100 (AEDT)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 48Crk336LBz9vBmq;
 Thu,  6 Feb 2020 09:11:39 +0100 (CET)
Authentication-Results: localhost; dkim=pass
 reason="1024-bit key; insecure key"
 header.d=c-s.fr header.i=@c-s.fr header.b=d1QUD3BB; dkim-adsp=pass;
 dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id umdXHmaXceAF; Thu,  6 Feb 2020 09:11:39 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 48Crk31hrdz9vBmm;
 Thu,  6 Feb 2020 09:11:39 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
 t=1580976699; bh=2NfLAdBOBoIleIWFQnQiqKoyTFtAwdYJziIrr8QnJqY=;
 h=From:Subject:To:Cc:Date:From;
 b=d1QUD3BBMiMmM2CIRGFCTURsOR0UonsCQqNFdwjV4PsIS/GdEXf6jeOpPt8L51O1a
 i8lDwnApbHsfTTi4e9QE2bZeearbiSbLrw/OgmWeLeVL1r+G6pH/UhNnyDdNYBvz+l
 4b9AWV2oir8oSikMqsLmbDrIGdaj157ptTiUbUDw=
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 194708B863;
 Thu,  6 Feb 2020 09:11:40 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id An7XLW9YJR2C; Thu,  6 Feb 2020 09:11:40 +0100 (CET)
Received: from pc16570vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id B2D738B85F;
 Thu,  6 Feb 2020 09:11:39 +0100 (CET)
Received: by localhost.localdomain (Postfix, from userid 0)
 id 64DAB652B7; Thu,  6 Feb 2020 08:11:39 +0000 (UTC)
Message-Id: <668b6ff463849ceee01f726fbf3e7110687575ec.1580976576.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH] selftest/lkdtm: Don't pollute 'git status'
To: Kees Cook <keescook@chromium.org>, Shuah Khan <skhan@linuxfoundation.org>
Date: Thu,  6 Feb 2020 08:11:39 +0000 (UTC)
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
Cc: linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Commit 46d1a0f03d66 ("selftests/lkdtm: Add tests for LKDTM targets")
added generation of lkdtm test scripts.

Ignore those generated scripts when performing 'git status'

Fixes: 46d1a0f03d66 ("selftests/lkdtm: Add tests for LKDTM targets")
Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 .gitignore | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/.gitignore b/.gitignore
index b849a72d69d5..bb05dce58f8e 100644
--- a/.gitignore
+++ b/.gitignore
@@ -100,6 +100,10 @@ modules.order
 /include/ksym/
 /arch/*/include/generated/
 
+# Generated lkdtm tests
+/tools/testing/selftests/lkdtm/*.sh
+!/tools/testing/selftests/lkdtm/run.sh
+
 # stgit generated dirs
 patches-*
 
-- 
2.25.0

