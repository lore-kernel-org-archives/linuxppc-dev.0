Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02792C2BD09
	for <linuxppc-dev@archiver.kernel.org>; Sat,  6 Jul 2024 11:23:28 +0000 (UTC)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=sang-engineering.com header.i=@sang-engineering.com header.a=rsa-sha256 header.s=k1 header.b=bb6i1/pB;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4WGSgM36TJz3cTb
	for <linuxppc-dev@archiver.kernel.org>; Sat,  6 Jul 2024 21:23:27 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=sang-engineering.com header.i=@sang-engineering.com header.a=rsa-sha256 header.s=k1 header.b=bb6i1/pB;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=sang-engineering.com (client-ip=194.117.254.33; helo=mail.zeus03.de; envelope-from=wsa+renesas@sang-engineering.com; receiver=lists.ozlabs.org)
Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4WGSdq3v4Sz30Wl
	for <linuxppc-dev@lists.ozlabs.org>; Sat,  6 Jul 2024 21:22:07 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=from:to:cc:subject:date:message-id
	:in-reply-to:references:mime-version:content-transfer-encoding;
	 s=k1; bh=7oZE53EqwBJ41YgA1lOP+r1p1fkFj5Ah6izJNlUQSw8=; b=bb6i1/
	pBSvPM0QWPAlXgSbfX5ryFvQVJV0iC+OkPEdf9u83ehcXfZJLFl8XazQ2Lp8Odr5
	+4VnVDPiHrtr4PNyp1XDXFqOtIK0Zf5EQLNRWXYG3XI1F9shZR28a7AQg6wpuGJe
	dASWosDlIyzc9J81yr6dNMmb1sX5jLriavnaw5U7adfIPkHqtuw7RV2mGxQ5548G
	Top84KGEaAeo4TkNTTD1FmrjyII2tyjW/Yns+hYXJqMX44OvJEvozbLDuEzY6Fe1
	3TYLurhTGrcq0/jlH/M+JKp/QyvGBQxujOYaBb3ybX3ZQvAIKPH/PfL3R64K2xzg
	+AN+ZpRcK7iIVMEw==
Received: (qmail 3810577 invoked from network); 6 Jul 2024 13:21:48 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 6 Jul 2024 13:21:48 +0200
X-UD-Smtp-Session: l3s3148p1@667GYpIcJMJQT+F6
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: linux-i2c@vger.kernel.org
Subject: [PATCH v2 37/60] i2c: pasemi: reword according to newest specification
Date: Sat,  6 Jul 2024 13:20:37 +0200
Message-ID: <20240706112116.24543-38-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240706112116.24543-1-wsa+renesas@sang-engineering.com>
References: <20240706112116.24543-1-wsa+renesas@sang-engineering.com>
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
Cc: Andi Shyti <andi.shyti@kernel.org>, Sven Peter <sven@svenpeter.dev>, Hector Martin <marcan@marcan.st>, linux-kernel@vger.kernel.org, Christophe Leroy <christophe.leroy@csgroup.eu>, Wolfram Sang <wsa+renesas@sang-engineering.com>, Nicholas Piggin <npiggin@gmail.com>, "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org, Alyssa Rosenzweig <alyssa@rosenzweig.io>, asahi@lists.linux.dev
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev" <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Change the wording of this driver wrt. the newest I2C v7 and SMBus 3.2
specifications and replace "master/slave" with more appropriate terms.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/i2c/busses/i2c-pasemi-core.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/i2c/busses/i2c-pasemi-core.c b/drivers/i2c/busses/i2c-pasemi-core.c
index bd8becbdeeb2..dac694a9d781 100644
--- a/drivers/i2c/busses/i2c-pasemi-core.c
+++ b/drivers/i2c/busses/i2c-pasemi-core.c
@@ -336,9 +336,9 @@ static u32 pasemi_smb_func(struct i2c_adapter *adapter)
 }
 
 static const struct i2c_algorithm smbus_algorithm = {
-	.master_xfer	= pasemi_i2c_xfer,
-	.smbus_xfer	= pasemi_smb_xfer,
-	.functionality	= pasemi_smb_func,
+	.xfer = pasemi_i2c_xfer,
+	.smbus_xfer = pasemi_smb_xfer,
+	.functionality = pasemi_smb_func,
 };
 
 int pasemi_i2c_common_probe(struct pasemi_smbus *smbus)
-- 
2.43.0

