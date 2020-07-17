Return-Path: <SRS0=mPqZ=A4=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5983C433E1
	for <linuxppc-dev@archiver.kernel.org>; Fri, 17 Jul 2020 18:31:45 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3A72D20759
	for <linuxppc-dev@archiver.kernel.org>; Fri, 17 Jul 2020 18:31:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A72D20759
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=al2klimov.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4B7fpk3LQszDqQJ
	for <linuxppc-dev@archiver.kernel.org>; Sat, 18 Jul 2020 04:31:42 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=none (no SPF record) smtp.mailfrom=al2klimov.de
 (client-ip=78.46.175.9; helo=smtp.al2klimov.de;
 envelope-from=grandmaster@al2klimov.de; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=al2klimov.de
Received: from smtp.al2klimov.de (smtp.al2klimov.de [78.46.175.9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4B7fmf6MzSzDqPw
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 18 Jul 2020 04:29:53 +1000 (AEST)
Received: from authenticated-user (PRIMARY_HOSTNAME [PUBLIC_IP])
 by smtp.al2klimov.de (Postfix) with ESMTPA id 1AA4EBC062;
 Fri, 17 Jul 2020 18:29:46 +0000 (UTC)
From: "Alexander A. Klimov" <grandmaster@al2klimov.de>
To: colin@colino.net, benh@kernel.crashing.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH] macintosh/therm_adt746x: Replace HTTP links with HTTPS ones
Date: Fri, 17 Jul 2020 20:29:40 +0200
Message-Id: <20200717182940.75484-1-grandmaster@al2klimov.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Bar: +++++
Authentication-Results: smtp.al2klimov.de;
 auth=pass smtp.auth=aklimov@al2klimov.de
 smtp.mailfrom=grandmaster@al2klimov.de
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
Cc: "Alexander A. Klimov" <grandmaster@al2klimov.de>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Rationale:
Reduces attack surface on kernel devs opening the links for MITM
as HTTPS traffic is much harder to manipulate.

Deterministic algorithm:
For each file:
  If not .svg:
    For each line:
      If doesn't contain `\bxmlns\b`:
        For each link, `\bhttp://[^# \t\r\n]*(?:\w|/)`:
	  If neither `\bgnu\.org/license`, nor `\bmozilla\.org/MPL\b`:
            If both the HTTP and HTTPS versions
            return 200 OK and serve the same content:
              Replace HTTP with HTTPS.

Signed-off-by: Alexander A. Klimov <grandmaster@al2klimov.de>
---
 Continuing my work started at 93431e0607e5.
 See also: git log --oneline '--author=Alexander A. Klimov <grandmaster@al2klimov.de>' v5.7..master

 If there are any URLs to be removed completely
 or at least not (just) HTTPSified:
 Just clearly say so and I'll *undo my change*.
 See also: https://lkml.org/lkml/2020/6/27/64

 If there are any valid, but yet not changed URLs:
 See: https://lkml.org/lkml/2020/6/26/837

 If you apply the patch, please let me know.


 drivers/macintosh/therm_adt746x.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/macintosh/therm_adt746x.c b/drivers/macintosh/therm_adt746x.c
index 8f7725dc2166..7e218437730c 100644
--- a/drivers/macintosh/therm_adt746x.c
+++ b/drivers/macintosh/therm_adt746x.c
@@ -5,8 +5,8 @@
  * Copyright (C) 2003, 2004 Colin Leroy, Rasmus Rohde, Benjamin Herrenschmidt
  *
  * Documentation from 115254175ADT7467_pra.pdf and 3686221171167ADT7460_b.pdf
- * http://www.onsemi.com/PowerSolutions/product.do?id=ADT7467
- * http://www.onsemi.com/PowerSolutions/product.do?id=ADT7460
+ * https://www.onsemi.com/PowerSolutions/product.do?id=ADT7467
+ * https://www.onsemi.com/PowerSolutions/product.do?id=ADT7460
  *
  */
 
-- 
2.27.0

