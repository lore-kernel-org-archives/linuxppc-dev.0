Return-Path: <SRS0=hRxk=V3=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 118D4C0650F
	for <linuxppc-dev@archiver.kernel.org>; Tue, 30 Jul 2019 14:22:11 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6061C20665
	for <linuxppc-dev@archiver.kernel.org>; Tue, 30 Jul 2019 14:22:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6061C20665
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 45ydzh1vN7zDqX1
	for <linuxppc-dev@archiver.kernel.org>; Wed, 31 Jul 2019 00:22:08 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 45ydwb0NWCzDqRB
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 31 Jul 2019 00:19:27 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix)
 id 45ydwZ4YDTz9s8m; Wed, 31 Jul 2019 00:19:26 +1000 (AEST)
Received: by ozlabs.org (Postfix, from userid 1034)
 id 45ydwZ3zM2z9sBF; Wed, 31 Jul 2019 00:19:26 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc/spe: Mark expected switch fall-throughs
Date: Wed, 31 Jul 2019 00:19:17 +1000
Message-Id: <20190730141917.21817-1-mpe@ellerman.id.au>
X-Mailer: git-send-email 2.20.1
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
Cc: gustavo@embeddedor.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Mark switch cases where we are expecting to fall through.

Fixes errors such as below, seen with mpc85xx_defconfig:

  arch/powerpc/kernel/align.c: In function 'emulate_spe':
  arch/powerpc/kernel/align.c:178:8: error: this statement may fall through
    ret |= __get_user_inatomic(temp.v[3], p++);
        ^~

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/kernel/align.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/powerpc/kernel/align.c b/arch/powerpc/kernel/align.c
index 7107ad86de65..92045ed64976 100644
--- a/arch/powerpc/kernel/align.c
+++ b/arch/powerpc/kernel/align.c
@@ -176,9 +176,11 @@ static int emulate_spe(struct pt_regs *regs, unsigned int reg,
 			ret |= __get_user_inatomic(temp.v[1], p++);
 			ret |= __get_user_inatomic(temp.v[2], p++);
 			ret |= __get_user_inatomic(temp.v[3], p++);
+			/* fall through */
 		case 4:
 			ret |= __get_user_inatomic(temp.v[4], p++);
 			ret |= __get_user_inatomic(temp.v[5], p++);
+			/* fall through */
 		case 2:
 			ret |= __get_user_inatomic(temp.v[6], p++);
 			ret |= __get_user_inatomic(temp.v[7], p++);
@@ -259,9 +261,11 @@ static int emulate_spe(struct pt_regs *regs, unsigned int reg,
 			ret |= __put_user_inatomic(data.v[1], p++);
 			ret |= __put_user_inatomic(data.v[2], p++);
 			ret |= __put_user_inatomic(data.v[3], p++);
+			/* fall through */
 		case 4:
 			ret |= __put_user_inatomic(data.v[4], p++);
 			ret |= __put_user_inatomic(data.v[5], p++);
+			/* fall through */
 		case 2:
 			ret |= __put_user_inatomic(data.v[6], p++);
 			ret |= __put_user_inatomic(data.v[7], p++);
-- 
2.20.1

