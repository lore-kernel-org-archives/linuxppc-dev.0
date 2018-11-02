Return-Path: <SRS0=pcIm=NN=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB514C32789
	for <linuxppc-dev@archiver.kernel.org>; Fri,  2 Nov 2018 21:19:47 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DAF982081F
	for <linuxppc-dev@archiver.kernel.org>; Fri,  2 Nov 2018 21:19:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="UNpNKE2o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DAF982081F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rasmusvillemoes.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42mw284cYfzF386
	for <linuxppc-dev@archiver.kernel.org>; Sat,  3 Nov 2018 08:19:44 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=rasmusvillemoes.dk
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="UNpNKE2o";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=rasmusvillemoes.dk
 (client-ip=2a00:1450:4864:20::542; helo=mail-ed1-x542.google.com;
 envelope-from=linux@rasmusvillemoes.dk; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=rasmusvillemoes.dk
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk
 header.b="UNpNKE2o"; dkim-atps=neutral
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com
 [IPv6:2a00:1450:4864:20::542])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42mvzR24cDzF35Q
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  3 Nov 2018 08:17:18 +1100 (AEDT)
Received: by mail-ed1-x542.google.com with SMTP id z12-v6so2868868edp.7
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 02 Nov 2018 14:17:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rasmusvillemoes.dk; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=73Yrp2BJa8JllIjkFd7mlwtLDDEyf3BVxMYTOSKf0E0=;
 b=UNpNKE2o354eq6jxDmmf5nBiNgp6Twa8avsFFh21sqqSmNvYMULZGHZMyFwvldylyY
 Ba8naldVgHUFp1Nfri1HqcGFpp9kgl0ly18kUPE7xclMWkpSYN43xQqHNfCmUFl/4wbt
 Lae+7s2SA/sW0pgKUt65unmKieZ4+tNJzgOas=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=73Yrp2BJa8JllIjkFd7mlwtLDDEyf3BVxMYTOSKf0E0=;
 b=SJHg6OL4RAv6DDncmvBJVOBnDYHXuM0aYBZmvOVyplpEyujCwCHHJ+r/x3YoW8jf99
 4O6yGkYv50dKPfMof9SZenq9BvOavnUlPUYtgKUbmqEYiBc6/U0xKSFqzIKSRsGqyTZq
 dG9RwULPZciNh9upbqUFWkF25KfEO5BwPSzBJ7BMeebJm6YWsln9y9lCKeu8jGRbC3YP
 H+K629Cuvj4GVemrQgsj4JvxKJ1ZBsVZ+R5OkFNBurNrAKccpNC7HBQZir+/8oxUS0py
 H3ZKQHIXerSIiQdfXs6y31itWYSaqgqEFkzi/vhVA1CRb1W1Rj9mlNE5m3R0KyMVejgN
 wkYQ==
X-Gm-Message-State: AGRZ1gKRpcD5PkVElA2E/tPaNhN6sACRemDVLfJbLQpqpubfL/J/h8H0
 RAZxmWYJLW+XLPBbA3GIpAy5Og==
X-Google-Smtp-Source: AJdET5eHvjN/pe6hdIfSy56WEexwDFL7vsbEJN0RaJwkw9BgBs5iutn/Hgu6ZWhFqHT5pufL42a79w==
X-Received: by 2002:a17:906:6c9:: with SMTP id
 v9-v6mr7400577ejb.203.1541193435250; 
 Fri, 02 Nov 2018 14:17:15 -0700 (PDT)
Received: from prevas-ravi.waoo.dk (dhcp-5-186-114-252.cgn.ip.fibianet.dk.
 [5.186.114.252])
 by smtp.gmail.com with ESMTPSA id h3-v6sm10741825ede.42.2018.11.02.14.17.14
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Fri, 02 Nov 2018 14:17:14 -0700 (PDT)
From: Rasmus Villemoes <linux@rasmusvillemoes.dk>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH] macintosh: ans-lcd: make anslcd_logo static and __initconst
Date: Fri,  2 Nov 2018 22:17:06 +0100
Message-Id: <20181102211707.10229-1-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.19.1.6.gbde171bbf5
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
Cc: linuxppc-dev@lists.ozlabs.org, Rasmus Villemoes <linux@rasmusvillemoes.dk>,
 linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

This variable has no reason to have external linkage, and since it is
only used in an __init function, it might as well be made __initconst
also.

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 drivers/macintosh/ans-lcd.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/macintosh/ans-lcd.c b/drivers/macintosh/ans-lcd.c
index c8e078b911c7..a7a79a935f6a 100644
--- a/drivers/macintosh/ans-lcd.c
+++ b/drivers/macintosh/ans-lcd.c
@@ -147,7 +147,8 @@ static struct miscdevice anslcd_dev = {
 	&anslcd_fops
 };
 
-const char anslcd_logo[] =	"********************"  /* Line #1 */
+static const char anslcd_logo[] __initconst =
+				"********************"  /* Line #1 */
 				"*      LINUX!      *"  /* Line #3 */
 				"*    Welcome to    *"  /* Line #2 */
 				"********************"; /* Line #4 */
-- 
2.19.1.6.gbde171bbf5

