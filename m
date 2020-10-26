Return-Path: <SRS0=voBx=EC=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 202C3C2D0A3
	for <linuxppc-dev@archiver.kernel.org>; Tue, 27 Oct 2020 00:20:51 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7093220708
	for <linuxppc-dev@archiver.kernel.org>; Tue, 27 Oct 2020 00:20:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="zMDaxVQ5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7093220708
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4CKsml67dKzDqBY
	for <linuxppc-dev@archiver.kernel.org>; Tue, 27 Oct 2020 11:20:39 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.org (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=sashal@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=default header.b=zMDaxVQ5; dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4CKs5m403gzDqGh
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Oct 2020 10:50:20 +1100 (AEDT)
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net
 [73.47.72.35])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 71FC7221F8;
 Mon, 26 Oct 2020 23:50:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1603756218;
 bh=Wy/KydK0ZqcnH/mktZ3ZcmM4o49aYFBg/WnZ0CpR5oo=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=zMDaxVQ51s3wNp80SAy5GJb+BUtBffhQ+8M9MNubtNnSF9JEDCq3MlsvwUBzH8RPS
 7rMdeAWH6mVFD758ASPO5zNcYru0B2EmVIKKqWC6uXXB27nOcttxU2EcPb/KT19LXy
 XS+32Y0W/w2skcfMC6uUMbj64DE7XddgufnEOjq4=
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 5.9 058/147] selftests/powerpc: Make using_hash_mmu()
 work on Cell & PowerMac
Date: Mon, 26 Oct 2020 19:47:36 -0400
Message-Id: <20201026234905.1022767-58-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201026234905.1022767-1-sashal@kernel.org>
References: <20201026234905.1022767-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
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
Cc: Sasha Levin <sashal@kernel.org>, linuxppc-dev@lists.ozlabs.org,
 linux-kselftest@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

From: Michael Ellerman <mpe@ellerman.id.au>

[ Upstream commit 34c103342be3f9397e656da7c5cc86e97b91f514 ]

These platforms don't show the MMU in /proc/cpuinfo, but they always
use hash, so teach using_hash_mmu() that.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Link: https://lore.kernel.org/r/20200819015727.1977134-1-mpe@ellerman.id.au
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/testing/selftests/powerpc/utils.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/powerpc/utils.c b/tools/testing/selftests/powerpc/utils.c
index 18b6a773d5c73..638ffacc90aa1 100644
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

