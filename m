Return-Path: <linuxppc-dev+bounces-28320-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14BD2C9830E
	for <linuxppc-dev@archiver.kernel.org>; Sun, 27 Sep 2026 14:36:07 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ht6Rf70WMz30Yb;
	Mon, 28 Sep 2026 00:35:26 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=74.125.229.43
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790519726;
	cv=none; b=GitNaZJy1htiI3hiTHtK2ADaRmMILJcynuuNMGv3J5U+caWVSHnaIt23kWs5stWshmz2Cx4J0rE9J0YwYhX4ohX/uBRvUB6HNDShOQLgB5vYf3NaNiNKijJ99LDqBIL9/hTAUWSlqTKOdeD/7pXCk/7xji7nDXmfWV6osvTxgQABHWKMgUUS4QKFeHTI2rG21mYQHxlguCOnn0gjjLqdHCaOx6yu7NhABeqYA6IfpohTF4+/CBJ4jxSbT8XAGY7ArAxegWwBXDiH3/Z+aP3ooOZxbE7RGsdf488P8gfBO7S5lKgHnq/KOpMl8RdjFNM96ck9DytbwNKmAEIgIgwS2g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790519726; c=relaxed/relaxed;
	bh=A0MBPJOKvnLE5rP9NIQzyUeRKGazCi9hDA+IfnK6LUo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=U2V19kILDtA1PU0OP3C3v7agdOMFd/F8/zVWesyQU6kFbHZHZ026QTAFFmx/U06XN3C0pMBXBtFCmXsvZkRTswGXeQEZdzmS6Ox47WzeiPPBAWCO2uVlZEq/L4/oTY8Ojz54u5sb4sMWJc/2hCUj2S/t1FHMZz4xAP1YY/p74/u3QyYBL8oKkmYzn4ywYAoYhSC2ieAvscVs7TxlrBru7/xbI/VWYxapkD2YyIXr+IbmTEHkCg8j747zEx7NIMmblY0whjDv0aUUox7rAt6DBxOaxh1Cxha4+JBN6x8axSfSRtNlvVx24106GYSixmCKzR8QFtAW18QbR5msbRpiCw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=UeNDuRWv; dkim-atps=neutral; spf=pass (client-ip=74.125.229.43; helo=mail-dy2-f43.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=UeNDuRWv;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=74.125.229.43; helo=mail-dy2-f43.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-dy2-f43.google.com (mail-dy2-f43.google.com [74.125.229.43])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ht6Rf0xmYz2yfS
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Sep 2026 00:35:26 +1000 (AEST)
Received: by mail-dy2-f43.google.com with SMTP id 5a478bee46e88-33c11ef641aso2699003eec.1
        for <linuxppc-dev@lists.ozlabs.org>; Sun, 27 Sep 2026 07:35:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790519723; x=1791124523; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=A0MBPJOKvnLE5rP9NIQzyUeRKGazCi9hDA+IfnK6LUo=;
        b=UeNDuRWvWrw/8ePtU1V2qlA5x4JcIHBtW47BdGonLnMX0HvYiA1OqHwBlFw/ZRAFuh
         ewoWHTwuGgM/40FHOPsDdBfd/cxvlsoK69mDyCORRjRFGS1dAJJsKypMYLDFnGcXRCdD
         8WPTfOPcdh37qpgLFwquNiu2I4esfgAKAYjuDFPCvJwd2VZuyUnPSdPFQsJWGmGtK2bH
         L5BeIG7aX5jMZGjA1x5h1Th6fB8w+ZcwA/9V4AMs7kxpiHaP8Sa6Bg8AGndHkFZDR/FW
         aTGr+03m9zijxYwjUkJENTkjfB4URws/MYSh7u7ISpeW/GbdEQZusNjcOu/BA6Cq5l74
         vxBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790519723; x=1791124523;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=A0MBPJOKvnLE5rP9NIQzyUeRKGazCi9hDA+IfnK6LUo=;
        b=nq8Lp2tHMcYGT2pmeHInv0z9P1dbYdn7aJYV9wiQqlQ7WdyL3vm7xVWawvwc9zj/1e
         7/MoAHRz9SOUPcA21uHTRy6bxdqCfUh/c6hn0g5S8/8A20aPo1sZwEBqh0/pFzJklDGO
         CSTFgtGwqzKIfNuhk1LRlt9Y91/acXQj/MFFS0/+2srxZkbFqZ3fD1fhILo5Ra9nxwv4
         +vp38c+OUVGbvpOC14wzuyiGtDXZEAGGW2zbjLccBsR/CxUkuMNdNodn5I9ZQhAg/cYk
         t1y4G4LynT3TPDM9hV5qyEZlL7wl1IpgjodLO+hK01/dE0GGNXODrc8Hdo10EnnDsdBS
         jrdQ==
X-Gm-Message-State: AFq9FYLICvCBCP/jet9/RSKWZdvyw4CqlLCmip3UQsZs/g6Akaaot5r4
	qn01/NCjGN4ZA3XbFAj5QC3n1hK+GeBkcOymBLEcf68AvM/Gb0Cb+Yh7oPZ3CQ==
X-Gm-Gg: AYBFou1Ugjp1+bYpSw+wY+eQ2kmgnD8wTosP04NJbKUT0Clwj4BtZGClCS0wVeVAA8n
	4JuFmkyPz9tw9yITqciKw5V26FQQ9c0svkED+0sgnNMdm5ncKPLLRwRg1Xwio0EQzGmcMECeM4Z
	i2OifrmJYvbT2HEpVdLkeFyqdhU92ZrRm+seGEhaZT5VMYYBbN+2l30wQl8Fwl5BH7kT4kjs7M+
	4lmxKrCsJyD/YS4kPu2DPIvUBCV7JGefOGEK6hvao5zZOaWTPut+BDLnwIQQHtah8eX8NWRYScM
	bFSyzwfSe8b1yRC0KTaMVZ/eHPGLG4xROetij2BcloaP/hzB4ocQg6CXvvfhhGAoV8HNw3cWCMr
	tt2O30zLWhly0L+5KMeLoGWagsxEx+v9whK02FaOh69ajWN6llvoGGmjV00UDxCimJKvhKQv/MN
	CUwFP1uKtmFC+mP6lvk5uJot5A8vkYcna1m/hsOgJKNgUsHCELUU9HKwX1Vnpxh6LFq230tIpw9
	R8tokAfcbK5ALCAPiR4qkdvXuJJy55Bevw6hs7f3lQQltYW/9OUEEw512Y4
X-Received: by 2002:a05:7300:de0b:b0:342:cbae:b1f7 with SMTP id 5a478bee46e88-342cbbdff28mr5834166eec.27.1790519722955;
        Sun, 27 Sep 2026 07:35:22 -0700 (PDT)
Received: from pve-server.rlab ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-34144b4ae50sm21869436eec.17.2026.09.27.07.35.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Sep 2026 07:35:21 -0700 (PDT)
From: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Christophe Leroy <chleroy@kernel.org>,
	Venkat Rao Bagalkote <venkat88@linux.ibm.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	Marco Elver <elver@google.com>,
	linux-kernel@vger.kernel.org,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Subject: [RFC 11/12] powerpc/powernv: Rework OPAL console write to remove conditional locking
Date: Sun, 27 Sep 2026 20:03:52 +0530
Message-Id: <6e3f2e429727bc1a7a79441ebb2276a51c08cd40.1790517984.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <cover.1790517984.git.ritesh.list@gmail.com>
References: <cover.1790517984.git.ritesh.list@gmail.com>
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
Content-Transfer-Encoding: 8bit

Clang's context analysis reports:
  opal.c:454:7: error: spinlock 'opal_write_lock' is not held on every path through here [-Werror,-Wthread-safety-analysis]
  opal.c:493:3: error: releasing spinlock 'opal_write_lock' that was not held [-Werror,-Wthread-safety-analysis]

This patch rework the OPAL console write function to remove this
conditional locking to fix the reported build errors while enabling
Clang context analysis. We could have marked __context_unsafe(),
but this anyways simplifies the locking a bit.

Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 arch/powerpc/platforms/powernv/opal.c | 30 ++++++++++++++++++---------
 1 file changed, 20 insertions(+), 10 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/opal.c b/arch/powerpc/platforms/powernv/opal.c
index 1946dbdc9fa1..aea83c4be76d 100644
--- a/arch/powerpc/platforms/powernv/opal.c
+++ b/arch/powerpc/platforms/powernv/opal.c
@@ -438,19 +438,13 @@ ssize_t opal_get_chars(uint32_t vtermno, u8 *buf, size_t count)
 	return 0;
 }
 
-static ssize_t __opal_put_chars(uint32_t vtermno, const u8 *data,
-				size_t total_len, bool atomic)
+static ssize_t __opal_put_chars_unlocked(uint32_t vtermno, const u8 *data,
+					 size_t total_len, bool atomic)
 {
-	unsigned long flags = 0 /* shut up gcc */;
 	ssize_t written;
 	__be64 olen;
 	s64 rc;
 
-	if (!opal.entry)
-		return -ENODEV;
-
-	if (atomic)
-		spin_lock_irqsave(&opal_write_lock, flags);
 	rc = opal_console_write_buffer_space(vtermno, &olen);
 	if (rc || be64_to_cpu(olen) < total_len) {
 		/* Closed -> drop characters */
@@ -489,10 +483,26 @@ static ssize_t __opal_put_chars(uint32_t vtermno, const u8 *data,
 	}
 
 out:
-	if (atomic)
+	return written;
+}
+
+static ssize_t __opal_put_chars(uint32_t vtermno, const u8 *data,
+				size_t total_len, bool atomic)
+{
+	unsigned long flags = 0;
+	ssize_t written;
+
+	if (!opal.entry)
+		return -ENODEV;
+
+	if (atomic) {
+		spin_lock_irqsave(&opal_write_lock, flags);
+		written = __opal_put_chars_unlocked(vtermno, data, total_len, true);
 		spin_unlock_irqrestore(&opal_write_lock, flags);
+		return written;
+	}
 
-	return written;
+	return __opal_put_chars_unlocked(vtermno, data, total_len, false);
 }
 
 ssize_t opal_put_chars(uint32_t vtermno, const u8 *data, size_t total_len)
-- 
2.39.5


