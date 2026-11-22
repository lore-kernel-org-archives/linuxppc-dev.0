Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BA3A606A31A
	for <linuxppc-dev@archiver.kernel.org>; Sun, 22 Nov 2026 22:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=Wn7V06mL
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jXjrF2jY5z2ySH;
	Mon, 23 Nov 2026 09:08:13 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2001:67c:2050:0:465::202"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795372456;
	cv=none; b=U2G9nEZB7U5DcVGqA+BMuez3AkczoW9mEiNcUfNTxMmXRJsInaxWWzz8+Aym6VzHbBPqPvQd4nBE/UrIWhqQ6YKbXZJE0+5pd7wxqnhslc7/wwrZZZCxsK1PdGpCeVd5VLsQcw4wOuqytdp+YU0pH2k5y5ZMbgLxLPMgksCufG2lybEtrQuH9uhtmFrciS64DofRVaUW7Ed9sxIO3ND8sRTqdAfu3bbyCOH+pxAvr/NdRr254YuRzyfze2V2uUdq76NMhnVX1cb1/3OYKyU1qiYiUkEgKj1PlD3xR8BuZGR9sBQUoLVpv4kVQQfDNRmaJqtNz+RVuirSAv80uE2oHw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795372456; c=relaxed/relaxed;
	bh=3Cfvn8MwvsJ6IYbSBjRAuULHLw/EUrLYwitYQBymANo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UaLWmyPXwouRh71KQklHi8qZjwRAvx/F8yy9Jw8aUdI9tXvRU0uyaxnvh4H2koxf2+b/oQsuix1Lv/o1zGHtVadWAXa0o/lv9ulmoOOEQa0htJ+eSt6OklpCRHJWZa1BiufHiReoOY96UH55q2Pzu/V0Ho2QGiLWik1Dtbys4Xg00AikFEgziOiA8xSmobPDrZisjsI/mShdC4XE/r+S9YERcua+oz3gL0fQBrprLznk4cm4hqvh2auvkYRg50KpHqPOIu5UFV3oQ9To46qCWCxQcCdeyIT2sFPM3goaD9FYQhQCpw0X0nNPxXO957Rh+KdQXyDtz/5gf/RpP1CArg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=Wn7V06mL; dkim-atps=neutral; spf=pass (client-ip=2001:67c:2050:0:465::202; helo=mout-p-202.mailbox.org; envelope-from=manuelebnerli@mailbox.org; receiver=lists.ozlabs.org) smtp.mailfrom=mailbox.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=Wn7V06mL;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=mailbox.org (client-ip=2001:67c:2050:0:465::202; helo=mout-p-202.mailbox.org; envelope-from=manuelebnerli@mailbox.org; receiver=lists.ozlabs.org)
X-Greylist: delayed 585 seconds by postgrey-1.37 at boromir; Mon, 23 Nov 2026 05:34:15 AEDT
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [IPv6:2001:67c:2050:0:465::202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bit raw public key) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jXd5M303mz2xLh
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Nov 2026 05:34:15 +1100 (AEDT)
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:b231:465::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4jXcsp0bcCzMlLn;
	Sun, 22 Nov 2026 19:24:14 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1795371854;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=3Cfvn8MwvsJ6IYbSBjRAuULHLw/EUrLYwitYQBymANo=;
	b=Wn7V06mLYTAqiuUHFtTalSdqdUBHbQA7sdkrhJuVwrK5Mk5kUd8QXVFhkLcqH3ITDwqPdD
	oLII0QxhiLLNKPJBzTQj/tePMCK1ur6660xrpK3qqjP2N8I4yrjiRehc4GlGJcTLTAHB6c
	AdrkFsjNFBP/ZiTYOT6R4fmFGJwbpAXNATgD4KqYJYBlXR+4HYdsGtOt+YC+mTzs7eHlNa
	6Gf7jqpvQU4LWeyW6UMnbRoTp1T6TxrhRQ5LLtpPEtAR89YMtHNaJTGghblgkt7hTd2N03
	s+m54ovRkjyNAab90adlv3LYBqRcTcfSOjXknrsjlDjHea9nIdiP2ainUGmKFQ==
From: Manuel Ebner <manuelebnerli@mailbox.org>
To: Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>
Cc: Manuel Ebner <manuelebnerli@mailbox.org>,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] powerpc: fix kernel-doc warning
Date: Sun, 22 Nov 2026 19:23:46 +0100
Message-ID: <20261122182346.1479340-2-manuelebnerli@mailbox.org>
X-Mailer: git-send-email 2.56.0
X-Mailing-List: linuxppc-dev@lists.ozlabs.org
List-Id: <linuxppc-dev.lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev+help@lists.ozlabs.org>
List-Owner: <mailto:linuxppc-dev+owner@lists.ozlabs.org>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>,
  <https://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Subscribe: <mailto:linuxppc-dev+subscribe@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-digest@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-nomail@lists.ozlabs.org>
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 7f7fe48fad2a4e8fdcc
X-MBO-RS-META: cwf5dhx8jd1i8xu6ugmr6eqfnzsixakf
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add 'struct' to kernel-doc to fix:
  $ ./scripts/kernel-doc --none arch/powerpc/include/asm/hvcserver.h
  Warning: arch/powerpc/include/asm/hvcserver.h:30 cannot understand function prototype: 'struct hvcs_partner_info'

Signed-off-by: Manuel Ebner <manuelebnerli@mailbox.org>
---
 arch/powerpc/include/asm/hvcserver.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/hvcserver.h b/arch/powerpc/include/asm/hvcserver.h
index 2b20403e9f..b26340c43b 100644
--- a/arch/powerpc/include/asm/hvcserver.h
+++ b/arch/powerpc/include/asm/hvcserver.h
@@ -16,7 +16,7 @@
 #define HVCS_CLC_LENGTH	79
 
 /**
- * hvcs_partner_info - an element in a list of partner info
+ * struct hvcs_partner_info - an element in a list of partner info
  * @node: list_head denoting this partner_info struct's position in the list of
  *	partner info.
  * @unit_address: The partner unit address of this entry.
-- 
2.56.0


