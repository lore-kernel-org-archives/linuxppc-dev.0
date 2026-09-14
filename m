Return-Path: <linuxppc-dev+bounces-27217-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16578C88E65
	for <linuxppc-dev@archiver.kernel.org>; Mon, 14 Sep 2026 10:43:01 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hk1vS23Gtz2yjw;
	Mon, 14 Sep 2026 20:43:00 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789382580;
	cv=none; b=m7PQNjMksGEoF76AQs7JlIR7ZsjueGxmHOtgzK3jb/8UN2kj/t26Hxf9YKbiZAZz7x8DyLqqnFiOmgFmFSjH92Bpc8BqtnXy1OeETU/ktDpnedcijbCEUzRElm2KcZDlMWla10kwU2ndqdNG09W9kO+HJ8GJbaYOdiqSfhETrhvDLYrdvAw32KDFHWCfAqK9+tkTrQDh5ou6Co18baTgyBfXphhnxs5hAA18w3Nm+RIbMzz9Rs9LOdOu6puD7+lgIliM3n6aFrXER7D3bf2VrcFJtkerD2sLX3ldtScBAiKINCh7Fq3PC2lVZH2VbycZXf7A6+dPUtjAIowxbXndiw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789382580; c=relaxed/relaxed;
	bh=ciCy+irl3CVqSBupfnZoZAqhk9D/bI5E8bqRZzqlV70=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QztNqtz1GChbEajQI0dTyHObuiteGZb8b/LpckWg36uHni+auLz7pRkji5Ag7tHvZQnbhyYhopODo+b0U/3GMnVD45Aug5qRewFhN39vkvFaFuaIcayJ7KX5Gy4/SU3BMYLpzHSBIXC+Tlad12gEYarRiy5rd0JIPBYFNmbBQflIy9zfqY6UXjTqyuo06bzvU1OT1bs+0k7EHOCCcYEgBZGfcH6BgZcSUB8n3+0+k2K/bEsbcTA2ojhqd9kVoLJWtUb5oo+Xm9YTrBC2Pmi7diHeS5gp0CogEJeKsctUIGPpEcumlHAUyuOAiTw3xde60onQOUuJQgksLTlhfgKnkw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=K3sT7Gdo; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=blum@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=K3sT7Gdo;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=blum@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hk1vR2kWxz2yWK
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 Sep 2026 20:42:59 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 476D360142;
	Mon, 14 Sep 2026 10:42:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7B6C1F000FF;
	Mon, 14 Sep 2026 10:42:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789382576;
	bh=ciCy+irl3CVqSBupfnZoZAqhk9D/bI5E8bqRZzqlV70=;
	h=From:To:Cc:Subject:Date;
	b=K3sT7GdouZcF/iLX7zGY1V45rI3nO/AFFRtzWEtUa2GIgCq02MRpr657Gzi6LUzED
	 Hb9aNNdp4oIqtp2Xdt+AUAZuJQxYWn7eVtCPl7ik0p5+YlKCIkcYdu5LiHmNyZntbK
	 m5u+eaeRJo2qF4eR1dPpl71NDovpPxrVfkc4ttbEuYUNrEuYgnyY7M1a0qXRGVT++E
	 3UAZKyqix/KGyaewuUen65Uk3h2FCJyzNJIX5x+9vxpqeVDEYEznR/sDg8RrZXxV+B
	 /IiPxytjQJe1etNHP54TR6a5PlAIP74Si2AMhWOlmmMZ8hZbScizCnedMVvUQlr2Ff
	 R+M94u5vhWr8g==
From: Thorsten Blum <blum@kernel.org>
To: Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	Thorsten Blum <blum@kernel.org>
Cc: linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] powerpc/boot: Simplify serial console control flow
Date: Mon, 14 Sep 2026 12:41:36 +0200
Message-ID: <20260914104136.74312-3-blum@kernel.org>
X-Mailer: git-send-email 2.55.0
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2032; i=blum@kernel.org; h=from:subject; bh=+BbvenQMNXTIOAVBoBW26VkcDlBYYGupfmkeRmBT70k=; b=owGbwMvMwCUWt7pQ4caZUj3G02pJDFnLzycoupzoSOh705Z5S693+mvP40XRBqbzfrJt5HjR8 ipFZ8LPjlIWBjEuBlkxRZYHs37M8C2tqdxkErETZg4rE8gQBi5OAZjIbFaGP3wT76nole91PvuI I/rvAnuGlRV1vkWXHh5RsFWc7/KPyYvhr3S4wP37+7751ZeuOhUZc+PU8byr75vup0/KbEt2Xvb lKB8A
X-Developer-Key: i=blum@kernel.org; a=openpgp; fpr=1D60735E8AEF3BE473B69D84733678FD8DFEEAD4
Content-Transfer-Encoding: 8bit

In serial_get_stdout_devp() and serial_console_init(), remove the goto
statements and return NULL and rc directly.

In serial_console_init(), handle errors early to reduce indentation.

Signed-off-by: Thorsten Blum <blum@kernel.org>
---
 arch/powerpc/boot/serial.c | 28 ++++++++++++----------------
 1 file changed, 12 insertions(+), 16 deletions(-)

diff --git a/arch/powerpc/boot/serial.c b/arch/powerpc/boot/serial.c
index 1d221ff420fd..f46943c21a22 100644
--- a/arch/powerpc/boot/serial.c
+++ b/arch/powerpc/boot/serial.c
@@ -87,19 +87,18 @@ static void *serial_get_stdout_devp(void)
 
 	devp = finddevice("/chosen");
 	if (devp == NULL)
-		goto err_out;
+		return NULL;
 
 	if (getprop(devp, "linux,stdout-path", path, MAX_PATH_LEN) > 0 ||
 		getprop(devp, "stdout-path", path, MAX_PATH_LEN) > 0) {
 		devp = finddevice(path);
 		if (devp == NULL)
-			goto err_out;
+			return NULL;
 
 		if ((getprop(devp, "device_type", devtype, sizeof(devtype)) > 0)
 				&& !strcmp(devtype, "serial"))
 			return devp;
 	}
-err_out:
 	return NULL;
 }
 
@@ -113,7 +112,7 @@ int serial_console_init(void)
 
 	devp = serial_get_stdout_devp();
 	if (devp == NULL)
-		goto err_out;
+		return rc;
 
 	if (dt_is_compatible(devp, "ns16550") ||
 	    dt_is_compatible(devp, "pnpPNP,501"))
@@ -134,19 +133,16 @@ int serial_console_init(void)
 		rc = opal_console_init(devp, &serial_cd);
 #endif
 
-	/* Add other serial console driver calls here */
+	if (rc)
+		return rc;
 
-	if (!rc) {
-		console_ops.open = serial_open;
-		console_ops.write = serial_write;
-		console_ops.close = serial_close;
-		console_ops.data = &serial_cd;
+	console_ops.open = serial_open;
+	console_ops.write = serial_write;
+	console_ops.close = serial_close;
+	console_ops.data = &serial_cd;
 
-		if (serial_cd.getc)
-			console_ops.edit_cmdline = serial_edit_cmdline;
+	if (serial_cd.getc)
+		console_ops.edit_cmdline = serial_edit_cmdline;
 
-		return 0;
-	}
-err_out:
-	return -1;
+	return 0;
 }

