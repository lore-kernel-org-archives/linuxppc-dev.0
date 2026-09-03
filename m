Return-Path: <linuxppc-dev+bounces-26471-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38EF8C624A4
	for <linuxppc-dev@archiver.kernel.org>; Thu,  3 Sep 2026 07:52:39 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hbBcw2q97z30dR;
	Thu, 03 Sep 2026 17:51:44 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a0a:51c0:0:12e:550::1"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788421904;
	cv=none; b=HCt8nGoSylV4WaqGY9sjpYglUOLuhE/VQwswxwpIMsFIoGusPHa8vSlP0Kk4MwHdL+EdXX+VpcNiy2pkq+PgAFspAcj324EcM6yp2V6QTrBxd7SeDC0CBpEv3vOAJKOvDJcaSOsiSLyDzZd9YEdAgxuZGo9IDGb9SDeq13YUtCBTTOcM/3lM8Dfg5wd0RHELbp14w74yIWkg3Wh9cmWLcYw2AbQoiHhNhwbFN7QhusxCl2SKBDvfXZuYQb+8/vM64cAwyDOPHojm27F55/bg9iIzzKPFU9IVQuNdliWL0v10inv8X+4K4dWkVbchqD7IbfSOoaxekPrGyvnOLTtUTg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788421904; c=relaxed/relaxed;
	bh=YUcarKasoX0h99dw6M4/xD5hiQ/p+f+NjembhaSjUVQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=l7cJTvjvUrVqEDPS/fGxSnCsaMInJmZXgqleklQeNRTZV5fSrEkdJkaNyuw/pV41KuvnIMetZ6O5tAH25q8gSO4go+qJ5daAIlT3uRfhZ3pxG1+LWKsBbcER0/ASECZlUF4JZvJiQB+K67RNbGmx4AK2yH1qXdfNNJZfwVnI3oiP3UsOyc/kGKmOkFMM9/VLh3jttC+5MQZfIsvQ+vGPDNwaoRXlWV4SaYFzkDwJ6xkURDCe4qRQurrb/RHOGmKRDTEdM2tIU73iQQamgLLozH7U6tnf6uooRMta4JyL6yk4nbx/qw90TBVRq/fk9bQmYuE3btvsNGpcV+StZ+Zu1w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; dkim=pass (2048-bit key; secure) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=APQB2vuQ; dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=kMqEoxbn; dkim-atps=neutral; spf=pass (client-ip=2a0a:51c0:0:12e:550::1; helo=galois.linutronix.de; envelope-from=t-8ch@linutronix.de; receiver=lists.ozlabs.org) smtp.mailfrom=linutronix.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=APQB2vuQ;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=kMqEoxbn;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linutronix.de (client-ip=2a0a:51c0:0:12e:550::1; helo=galois.linutronix.de; envelope-from=t-8ch@linutronix.de; receiver=lists.ozlabs.org)
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hbBcs5FxLz2yrS
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 03 Sep 2026 17:51:41 +1000 (AEST)
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1788421294;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YUcarKasoX0h99dw6M4/xD5hiQ/p+f+NjembhaSjUVQ=;
	b=APQB2vuQicLW7Zb8jMJr8A8PXWF7rS0zkF9Ri7xRZz0NsPEweiKDr7QnuZXaZEvkpJG+4v
	K4RMcVqqimnh0TCJyD8QgGasKT3klSt0i/t9LuY/5GXUbyPDPWKT/4dWU6jcyXMNbq3QSY
	tWglOGTMDhufCZNh4xqwF/KN9UqbmPUZn3x3MB/GHS1WhgREN9lSNUhpFZvq9Y8R7n4jrc
	RzUDRhuuzFI6IhveVU/KEl+OXPL1RML61ZFBzasXiEbV82Qy8nBURU/YjV1AwndNfUiRnF
	pVVKkQaJsMt+N+OB0YtlNGJkvmD9mgWghcpmB4U+XKodetrCpm8ZE1xKF4sWgg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1788421294;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YUcarKasoX0h99dw6M4/xD5hiQ/p+f+NjembhaSjUVQ=;
	b=kMqEoxbn4idATtgPsStZnSGqmHcSXU6olXd8YPdu0q+KeHi8EXRyVYj+Mj6ubqC9aAtVS4
	PHj2p3DSjWMbZIBw==
Date: Thu, 03 Sep 2026 09:41:24 +0200
Subject: [PATCH v2 09/15] s390: Remove AT_VECTOR_SIZE_ARCH from UAPI
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260903-at-vector-size-arch-v2-9-5bc32a71e3d8@linutronix.de>
References: <20260903-at-vector-size-arch-v2-0-5bc32a71e3d8@linutronix.de>
In-Reply-To: <20260903-at-vector-size-arch-v2-0-5bc32a71e3d8@linutronix.de>
To: Kees Cook <kees@kernel.org>, Arnd Bergmann <arnd@arndb.de>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
 linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-riscv@lists.infradead.org, loongarch@lists.linux.dev, 
 linux-s390@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
 linux-mips@vger.kernel.org, sparclinux@vger.kernel.org, 
 linux-sh@vger.kernel.org, linux-alpha@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788421286; l=1450;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=SvAg75HBK8bLtuaKgOOLDr10ibDxxL9SdBfOzzfNWls=;
 b=3RT19pLNWlOURXZVikzalNwkQhefjiPlou99ySXRRsmtxX0e69Nl8D5OGCHH4DyrLWTIuCnAG
 MABfP++jZRoDuSWe0OPaLheUiQwuWtT2e9LUHAy/E3h86Qgzctp8htY
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

There is nothing userspace can do with this value. In the kernel is
always combined with AT_VECTOR_SIZE_BASE, which is not exposed to
userspace and also changes from time to time.

Move the symbol to a kernel-internal header.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
Reviewed-by: Kees Cook <kees@kernel.org>
---
 arch/s390/include/asm/auxvec.h      | 7 +++++++
 arch/s390/include/uapi/asm/auxvec.h | 6 ++----
 2 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/arch/s390/include/asm/auxvec.h b/arch/s390/include/asm/auxvec.h
new file mode 100644
index 000000000000..beaaefe12a84
--- /dev/null
+++ b/arch/s390/include/asm/auxvec.h
@@ -0,0 +1,7 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+#ifndef __ASMS390_AUXVEC_H
+#define __ASMS390_AUXVEC_H
+
+#define AT_VECTOR_SIZE_ARCH 1 /* entries in ARCH_DLINFO */
+
+#endif
diff --git a/arch/s390/include/uapi/asm/auxvec.h b/arch/s390/include/uapi/asm/auxvec.h
index a056c4637ffc..54bbfd68d709 100644
--- a/arch/s390/include/uapi/asm/auxvec.h
+++ b/arch/s390/include/uapi/asm/auxvec.h
@@ -1,9 +1,7 @@
 /* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
-#ifndef __ASMS390_AUXVEC_H
-#define __ASMS390_AUXVEC_H
+#ifndef __ASMS390_UAPI_AUXVEC_H
+#define __ASMS390_UAPI_AUXVEC_H
 
 #define AT_SYSINFO_EHDR		33
 
-#define AT_VECTOR_SIZE_ARCH 1 /* entries in ARCH_DLINFO */
-
 #endif

-- 
2.55.0


