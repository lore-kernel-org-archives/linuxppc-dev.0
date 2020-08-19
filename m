Return-Path: <SRS0=nuQA=B5=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50C25C433DF
	for <linuxppc-dev@archiver.kernel.org>; Wed, 19 Aug 2020 02:07:13 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F2FF52067C
	for <linuxppc-dev@archiver.kernel.org>; Wed, 19 Aug 2020 02:07:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="kyvQjNix"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F2FF52067C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4BWWPW0R1fzDqvL
	for <linuxppc-dev@archiver.kernel.org>; Wed, 19 Aug 2020 12:07:11 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4BWWBP67LtzDqtl
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Aug 2020 11:57:33 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au
 header.a=rsa-sha256 header.s=201909 header.b=kyvQjNix; 
 dkim-atps=neutral
Received: by ozlabs.org (Postfix)
 id 4BWWBP0Tkgz9sPC; Wed, 19 Aug 2020 11:57:33 +1000 (AEST)
Received: by ozlabs.org (Postfix, from userid 1034)
 id 4BWWBN5xJkz9sPf; Wed, 19 Aug 2020 11:57:32 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
 s=201909; t=1597802252;
 bh=dAbpUDZqLRxGxE6Jo7rd4usvWi/gU3C7mr2WBf82cq4=;
 h=From:To:Subject:Date:From;
 b=kyvQjNixdja12uwh6v2Q90vPPMWpXeViWlbNW2j6wk+ZoXKs2KbS5Vn5pvBbxGDRI
 qHuITCEKQScPJQ1fUS8YD/Mz2pdXF+OP2uuyI07VVl8VTYbnxdFh/SfVtIue86GMZb
 CBytyDDJFvijVh68gh4ZgDixbrC4PD5kCke+lXjvqAztMgP8jlT87zflnaOf36oQyt
 Ve95iRjowT63YqhMxfuyDT1Ia5RQve40ovEUqE+NGQG+IXijlCUDa82lsEktwB1k1w
 Q3hkajCXU3k6HFLoH41pQ6Xzn1QDgkfckTP+NVvOj6yfoPWj/7i+SOC8qPIp8fULJv
 3xmpP9NFlOGXg==
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 1/9] selftests/powerpc: Make using_hash_mmu() work on Cell &
 PowerMac
Date: Wed, 19 Aug 2020 11:57:19 +1000
Message-Id: <20200819015727.1977134-1-mpe@ellerman.id.au>
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

These platforms don't show the MMU in /proc/cpuinfo, but they always
use hash, so teach using_hash_mmu() that.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 tools/testing/selftests/powerpc/utils.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/powerpc/utils.c b/tools/testing/selftests/powerpc/utils.c
index 18b6a773d5c7..638ffacc90aa 100644
--- a/tools/testing/selftests/powerpc/utils.c
+++ b/tools/testing/selftests/powerpc/utils.c
@@ -318,7 +318,9 @@ int using_hash_mmu(bool *using_hash)
 
 	rc = 0;
 	while (fgets(line, sizeof(line), f) != NULL) {
-		if (strcmp(line, "MMU		: Hash\n") == 0) {
+		if (!strcmp(line, "MMU		: Hash\n") ||
+		    !strcmp(line, "platform	: Cell\n") ||
+		    !strcmp(line, "platform	: PowerMac\n")) {
 			*using_hash = true;
 			goto out;
 		}
-- 
2.25.1

