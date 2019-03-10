Return-Path: <SRS0=/OnI=RO=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAA9AC43381
	for <linuxppc-dev@archiver.kernel.org>; Mon, 11 Mar 2019 12:54:03 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 69BFB2075C
	for <linuxppc-dev@archiver.kernel.org>; Mon, 11 Mar 2019 12:54:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69BFB2075C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vault24.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44Hyj50rk3zDqCK
	for <linuxppc-dev@archiver.kernel.org>; Mon, 11 Mar 2019 23:54:01 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=vault24.org
 (client-ip=2600:3c03::f03c:91ff:fe96:b31a; helo=pinero.vault24.org;
 envelope-from=nuxi@vault24.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=vault24.org
X-Greylist: delayed 69419 seconds by postgrey-1.36 at bilbo;
 Mon, 11 Mar 2019 23:51:50 AEDT
Received: from pinero.vault24.org (pinero.vault24.org
 [IPv6:2600:3c03::f03c:91ff:fe96:b31a])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44HyfZ0dpqzDqCH
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Mar 2019 23:51:48 +1100 (AEDT)
Received: from feynman.vault24.org (c-98-243-50-21.hsd1.mi.comcast.net
 [98.243.50.21])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by pinero.vault24.org (Postfix) with ESMTPS id DF4B4605E
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Mar 2019 08:51:42 -0400 (EDT)
Received: by feynman.vault24.org (Postfix, from userid 1000)
 id 30CB5302DD18; Mon, 11 Mar 2019 08:51:42 -0400 (EDT)
Resent-From: Jon DeVree <nuxi@vault24.org>
Resent-Date: Mon, 11 Mar 2019 08:51:42 -0400
Resent-Message-ID: <20190311125142.GA3740@feynman.vault24.org>
Resent-To: linuxppc-dev@lists.ozlabs.org
Received: by feynman.vault24.org (Postfix, from userid 113)
 id 5322B3025B25; Sun, 10 Mar 2019 13:34:42 -0400 (EDT)
Received: from nobel.vault24.org (nobel.vault24.org [10.222.173.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by feynman.vault24.org (Postfix) with ESMTPS id 37C00302DD18;
 Sun, 10 Mar 2019 13:34:42 -0400 (EDT)
Received: by nobel.vault24.org (Postfix, from userid 1000)
 id 70B2E221DD1C; Sun, 10 Mar 2019 13:34:41 -0400 (EDT)
From: Jon DeVree <nuxi@vault24.org>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] powerpc: fix mistake in arch_get_random_seed_int()
Date: Sun, 10 Mar 2019 13:33:20 -0400
Message-Id: <20190310173319.15411-1-nuxi@vault24.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Bogosity: Ham, tests=bogofilter, spamicity=0.000000, version=1.2.4
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
Cc: Jon DeVree <nuxi@vault24.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Way back in v4.3 the PPC hardware RNG stuff was changed to only provide
the RNG seed functions, but this line was missed during the change.

Fixes: 01c9348c7620 ("powerpc: Use hardware RNG for arch_get_random_seed_* not arch_get_random_*")
Signed-off-by: Jon DeVree <nuxi@vault24.org>
---
 arch/powerpc/include/asm/archrandom.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/archrandom.h b/arch/powerpc/include/asm/archrandom.h
index 9c63b596e6ce..a09595f00cab 100644
--- a/arch/powerpc/include/asm/archrandom.h
+++ b/arch/powerpc/include/asm/archrandom.h
@@ -28,7 +28,7 @@ static inline int arch_get_random_seed_int(unsigned int *v)
 	unsigned long val;
 	int rc;
 
-	rc = arch_get_random_long(&val);
+	rc = arch_get_random_seed_long(&val);
 	if (rc)
 		*v = val;
 
-- 
2.20.1

