Return-Path: <linuxppc-dev+bounces-21437-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 681D8CD5BAB
	for <linuxppc-dev@archiver.kernel.org>; Sun, 24 May 2026 08:07:49 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gNWpW4SVwz2yDs;
	Sun, 24 May 2026 18:07:47 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=141.14.17.11
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779610067;
	cv=none; b=XGvFWfclb7qSpq4JlgJ/rXC5dIK2YOY2WQ+6njmY4w9j9clKnMmYmr8/V3p/FfCXDISRe57vbVjOg9pakors4t/q8leWtFHvJ8nEpGh5jI09rvUb9Yuq9FL/iF4YUFUuMTWPLArhmfU+WuvbK7bc4g1lRN65IuKiZljk+cfKA22A4yDeZj/x5/mi3WwDBV4vvBDlJ5FBgjYZ52oIJq7YMyq7TsCiSGOTy5ZJN+BLCxA+DNxRcCIT6tczQRBjr52tA4MVRitQV0piFL19LFAveuUDYvUezaQb526UUa9LjQ7Dl25KYinRYxbyNg7I7siPgaDJwSOP/iSvuxFpne3JNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779610067; c=relaxed/relaxed;
	bh=HdwUYC452M0UPCmNSsLxM3dRnijav76MhevLnvjqkFU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=P+MbFs2scpMkEPlG3NG89Y/DMHOYKM12MaBoawu8CHSi4BUF2U0LEvr9K3eXRHKW1nbga05OoY/8rQminTKxtOcpDdOMRBmBrRQPZwLJqVzboukrD6g7y9sSBzTbwcUgbOzQ3YA5lM/OS4+ffUDAbr7477WEsTv4cPnnsmu2ssY99tvjDTKaGlVZbjX3riuN0KPe7TlxHsTuvhdVF56tvrupIZh6f+7fi//Iki/YoeTXDDDqm7WX+G/HSyxU841SYap8wq4OLrDjxb9SOZHUYhq2EsCi4KzVcByAn8Ra0HHFWtTtxgwOpUX4ct0tEiyX1PhQMehCrDdK1vjOvngrdg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass (client-ip=141.14.17.11; helo=mx3.molgen.mpg.de; envelope-from=pmenzel@molgen.mpg.de; receiver=lists.ozlabs.org) smtp.mailfrom=molgen.mpg.de
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=molgen.mpg.de (client-ip=141.14.17.11; helo=mx3.molgen.mpg.de; envelope-from=pmenzel@molgen.mpg.de; receiver=lists.ozlabs.org)
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bit raw public key) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gNWpV0cHWz2y8d
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 24 May 2026 18:07:44 +1000 (AEST)
Received: from abreu.speedport.ip (p5dc553b1.dip0.t-ipconnect.de [93.197.83.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 8C4044C151324A;
	Sun, 24 May 2026 10:06:57 +0200 (CEST)
From: Paul Menzel <pmenzel@molgen.mpg.de>
To: Bartosz Golaszewski <brgl@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>
Cc: Paul Menzel <pmenzel@molgen.mpg.de>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	linuxppc-dev@lists.ozlabs.org,
	linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] misc: eeprom: at24: Make VCC supply description requirement optional
Date: Sun, 24 May 2026 10:05:33 +0200
Message-ID: <20260524080533.8749-2-pmenzel@molgen.mpg.de>
X-Mailer: git-send-email 2.53.0
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
List-Unsubscribe: <mailto:linuxppc-dev+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Some platforms (e.g. IBM Power System S822LC (8335-GCA POWER8)) do not
describe the EEPROM’s VCC supply in firmware-provided device trees.
Using `devm_regulator_get()` on such systems falls back to a dummy
regulator with a kernel warning:

    at24 0-0051: supply vcc not found, using dummy regulator
    at24 0-0051: 16384 byte 24c128 EEPROM, writable, 1 bytes/write
    at24 0-0052: supply vcc not found, using dummy regulator
    at24 0-0052: 256 byte 24c02 EEPROM, writable, 1 bytes/write
    at24 0-0053: supply vcc not found, using dummy regulator
    at24 0-0053: 256 byte 24c02 EEPROM, writable, 1 bytes/write
    at24 0-0054: supply vcc not found, using dummy regulator
    at24 0-0054: 256 byte 24c02 EEPROM, writable, 1 bytes/write
    […]
    at24 12-0050: supply vcc not found, using dummy regulator
    at24 12-0050: 16384 byte 24c128 EEPROM, writable, 1 bytes/write
    at24 12-0051: supply vcc not found, using dummy regulator
    at24 12-0051: 16384 byte 24c128 EEPROM, writable, 1 bytes/write

Switch to `devm_regulator_get_optional()` and treat -ENODEV as “no
supply described”. When `vcc_reg` is NULL, skip all
regulator_enable/disable calls; the hardware is assumed to be always
powered. Linux now logs:

    at24 0-0051: 16384 byte 24c128 EEPROM, writable, 1 bytes/write
    at24 0-0052: 256 byte 24c02 EEPROM, writable, 1 bytes/write
    at24 0-0053: 256 byte 24c02 EEPROM, writable, 1 bytes/write
    at24 0-0054: 256 byte 24c02 EEPROM, writable, 1 bytes/write
    at24 0-0055: 256 byte 24c02 EEPROM, writable, 1 bytes/write
    […]
    at24 12-0050: 16384 byte 24c128 EEPROM, writable, 1 bytes/write
    at24 12-0051: 16384 byte 24c128 EEPROM, writable, 1 bytes/write

Assisted-by: Claude Sonnet 4.6
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org
Signed-off-by: Paul Menzel <pmenzel@molgen.mpg.de>
---
 drivers/misc/eeprom/at24.c | 26 ++++++++++++++++++--------
 1 file changed, 18 insertions(+), 8 deletions(-)

diff --git a/drivers/misc/eeprom/at24.c b/drivers/misc/eeprom/at24.c
index 0200288d3a7a..7e1050f8759a 100644
--- a/drivers/misc/eeprom/at24.c
+++ b/drivers/misc/eeprom/at24.c
@@ -699,9 +699,12 @@ static int at24_probe(struct i2c_client *client)
 	at24->offset_adj = at24_get_offset_adj(flags, byte_len);
 	at24->client_regmaps[0] = regmap;
 
-	at24->vcc_reg = devm_regulator_get(dev, "vcc");
-	if (IS_ERR(at24->vcc_reg))
-		return PTR_ERR(at24->vcc_reg);
+	at24->vcc_reg = devm_regulator_get_optional(dev, "vcc");
+	if (IS_ERR(at24->vcc_reg)) {
+		if (PTR_ERR(at24->vcc_reg) != -ENODEV)
+			return PTR_ERR(at24->vcc_reg);
+		at24->vcc_reg = NULL;
+	}
 
 	writable = !(flags & AT24_FLAG_READONLY);
 	if (writable) {
@@ -754,9 +757,12 @@ static int at24_probe(struct i2c_client *client)
 
 	full_power = acpi_dev_state_d0(&client->dev);
 	if (full_power) {
-		err = regulator_enable(at24->vcc_reg);
-		if (err)
-			return dev_err_probe(dev, err, "Failed to enable vcc regulator\n");
+		if (at24->vcc_reg) {
+			err = regulator_enable(at24->vcc_reg);
+			if (err) {
+				return dev_err_probe(dev, err, "Failed to enable vcc regulator\n");
+			}
+		}
 
 		pm_runtime_set_active(dev);
 	}
@@ -771,7 +777,7 @@ static int at24_probe(struct i2c_client *client)
 		err = at24_read(at24, 0, &test_byte, 1);
 		if (err) {
 			pm_runtime_disable(dev);
-			if (!pm_runtime_status_suspended(dev))
+			if (!pm_runtime_status_suspended(dev) && at24->vcc_reg)
 				regulator_disable(at24->vcc_reg);
 			return -ENODEV;
 		}
@@ -808,7 +814,7 @@ static void at24_remove(struct i2c_client *client)
 
 	pm_runtime_disable(&client->dev);
 	if (acpi_dev_state_d0(&client->dev)) {
-		if (!pm_runtime_status_suspended(&client->dev))
+		if (!pm_runtime_status_suspended(&client->dev) && at24->vcc_reg)
 			regulator_disable(at24->vcc_reg);
 		pm_runtime_set_suspended(&client->dev);
 	}
@@ -819,6 +825,8 @@ static int __maybe_unused at24_suspend(struct device *dev)
 	struct i2c_client *client = to_i2c_client(dev);
 	struct at24_data *at24 = i2c_get_clientdata(client);
 
+	if (!at24->vcc_reg)
+		return 0;
 	return regulator_disable(at24->vcc_reg);
 }
 
@@ -827,6 +835,8 @@ static int __maybe_unused at24_resume(struct device *dev)
 	struct i2c_client *client = to_i2c_client(dev);
 	struct at24_data *at24 = i2c_get_clientdata(client);
 
+	if (!at24->vcc_reg)
+		return 0;
 	return regulator_enable(at24->vcc_reg);
 }
 
-- 
2.53.0


