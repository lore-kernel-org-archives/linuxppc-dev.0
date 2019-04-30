Return-Path: <SRS0=xPOF=TA=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27741C43219
	for <linuxppc-dev@archiver.kernel.org>; Tue, 30 Apr 2019 13:17:04 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A1614205F4
	for <linuxppc-dev@archiver.kernel.org>; Tue, 30 Apr 2019 13:17:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1614205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44thrY301bzDqLd
	for <linuxppc-dev@archiver.kernel.org>; Tue, 30 Apr 2019 23:17:01 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44th554GL0zDqRD
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 Apr 2019 22:42:49 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 dmarc=fail (p=none dis=none) header.from=nxp.com
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 44th535g7vz8t3x
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 Apr 2019 22:42:47 +1000 (AEST)
Received: by ozlabs.org (Postfix)
 id 44th534bhlz9sBV; Tue, 30 Apr 2019 22:42:47 +1000 (AEST)
Authentication-Results: ozlabs.org; spf=pass (mailfrom) smtp.mailfrom=nxp.com
 (client-ip=92.121.34.13; helo=inva020.nxp.com;
 envelope-from=diana.craciun@nxp.com; receiver=<UNKNOWN>)
Authentication-Results: ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 44th53152qz9sB3
 for <linuxppc-dev@ozlabs.org>; Tue, 30 Apr 2019 22:42:45 +1000 (AEST)
Received: from inva020.nxp.com (localhost [127.0.0.1])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id E67331A0168;
 Tue, 30 Apr 2019 14:42:41 +0200 (CEST)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com
 [134.27.226.22])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id DA7101A006D;
 Tue, 30 Apr 2019 14:42:41 +0200 (CEST)
Received: from fsr-ub1664-009.ea.freescale.net
 (fsr-ub1664-009.ea.freescale.net [10.171.71.77])
 by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id 8EF1820614;
 Tue, 30 Apr 2019 14:42:41 +0200 (CEST)
From: Diana Craciun <diana.craciun@nxp.com>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Subject: [PATCH v2 stable v4.4 1/2] powerpc/fsl: Add FSL_PPC_BOOK3E as
 supported arch for nospectre_v2 boot arg
Date: Tue, 30 Apr 2019 15:42:26 +0300
Message-Id: <1556628147-15687-1-git-send-email-diana.craciun@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
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
Cc: Diana Craciun <diana.craciun@nxp.com>, linuxppc-dev@ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

commit e59f5bd759b7dee57593c5b6c0441609bda5d530 upstream.

Signed-off-by: Diana Craciun <diana.craciun@nxp.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 Documentation/kernel-parameters.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/kernel-parameters.txt b/Documentation/kernel-parameters.txt
index da515c535e62..f0bdf78420a0 100644
--- a/Documentation/kernel-parameters.txt
+++ b/Documentation/kernel-parameters.txt
@@ -2450,7 +2450,7 @@ bytes respectively. Such letter suffixes can also be entirely omitted.
 
 	nohugeiomap	[KNL,x86] Disable kernel huge I/O mappings.
 
-	nospectre_v2	[X86] Disable all mitigations for the Spectre variant 2
+	nospectre_v2	[X86,PPC_FSL_BOOK3E] Disable all mitigations for the Spectre variant 2
 			(indirect branch prediction) vulnerability. System may
 			allow data leaks with this option, which is equivalent
 			to spectre_v2=off.
-- 
2.17.1

