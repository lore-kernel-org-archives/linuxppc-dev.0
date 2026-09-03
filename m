Return-Path: <linuxppc-dev+bounces-26473-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9EB6C624A4
	for <linuxppc-dev@archiver.kernel.org>; Thu,  3 Sep 2026 07:52:47 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hbBcx36DTz30gJ;
	Thu, 03 Sep 2026 17:51:45 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=193.142.43.55
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788421905;
	cv=none; b=FHeU70SFvolu8W4fXRt3D3U1vtAnlk7a5/eykJ1t4iNZDnnoI0gjm6DWM3b+JfDAyjqS6XdSX4W7vvk8xG5g+51B9JkoMbOcsFN0jaCGj0YuqcdverRVGaAT7UvK1Ju7u6VqgcrpkDbfD6KQWB0hbyGd0Fs5HwchAaqVe9XRRz2WtfqZ9TS1IomewU4EJ4/6l9oM5Wj7w+rp8uSLuZwn+MvPIcv8pF947nBdSOX7Y7rDIupdvoTvI4NPKkHDBJNol1x/m7JVeEbq0JG7pOh/0UymULdgeJ0mKeDgiihSZTvS7nmGlXcZHu0KP+jpHPOihAQDzwlITcK/NiZ43KBtPw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788421905; c=relaxed/relaxed;
	bh=hrAnP/C3vIIV9MfVxkKNdnam3FAI0o97+nAzFrr7A6o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=npU+3TT5DyZi4jx+jtZPkmr8nDmPwWjY7sEkBvwGopq+odF5+3+Mz43YvRo0orP43pR08VT4ScReUVbGDKxXnRHeJQrkOixv1xKpCucn6Pm8lkaUgeqZudYSgp2NPzTUfGe9qBga6peYsfHquuTt16Igb5TICO7CDXJ3NgHy0qWqQYhDCEPjG9ZFNQ+n43t+da60wCsxvDbZKUjULPqfnEDS44e3ILYtdLDvqMxCc+6VshWEQ/gZ2LyaP3pnlAGttgfr4EAKI52WiB6M0JnfsSruV3mDeIAKue8NkP9lqTh1z6ycqHCCmIV5Wy2vXG/pfNnM0QyhtSBkjS1ATKafiw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; dkim=pass (2048-bit key; secure) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=A7uMxPFG; dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=4+LXrGA1; dkim-atps=neutral; spf=pass (client-ip=193.142.43.55; helo=galois.linutronix.de; envelope-from=t-8ch@linutronix.de; receiver=lists.ozlabs.org) smtp.mailfrom=linutronix.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=A7uMxPFG;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=4+LXrGA1;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linutronix.de (client-ip=193.142.43.55; helo=galois.linutronix.de; envelope-from=t-8ch@linutronix.de; receiver=lists.ozlabs.org)
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hbBct2cMvz305v
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 03 Sep 2026 17:51:42 +1000 (AEST)
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1788421296;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hrAnP/C3vIIV9MfVxkKNdnam3FAI0o97+nAzFrr7A6o=;
	b=A7uMxPFGSNRKyM+CJ+qi+nH0EVA+MdWp35wphWaEq2E8+0fRn9MbLOB3YpV2ixqEZxN/yY
	o3xT6U8duMUicllU/fFzqeNAcXNYjnmbWLuP9Ch69tr76jl5AlQe3N6DjUD5g9hRhZ57WZ
	olbXOlRtqjhM3eDLMpgailyhTg1ViVGBqUv/W2UKgy4MqAlW6aRfOEnyEMEaTbcMfyg3v3
	AzKBzF8fw0Tus/oHpwhzkco2BlB0yaOGb/fhK0uWDRdoSDCtKLzR4FiKRwpXRiUZBZAdVK
	n+fwbsrReekXVse4Vgc+2+OQC9qpYeuhvgKdvyN3IcmTz6oKlgewhGS31B7Vvw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1788421296;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hrAnP/C3vIIV9MfVxkKNdnam3FAI0o97+nAzFrr7A6o=;
	b=4+LXrGA1BNsb+1bt9PPBXeYwlB5OKLjrbTPg3/JyXLOelfRU9JW6w01qpy84FUq6+qD8x1
	o8BYkU71G9JpY9Bg==
Date: Thu, 03 Sep 2026 09:41:27 +0200
Subject: [PATCH v2 12/15] sparc: Remove AT_VECTOR_SIZE_ARCH from UAPI
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
Message-Id: <20260903-at-vector-size-arch-v2-12-5bc32a71e3d8@linutronix.de>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788421286; l=1455;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=BmY0rNeTgoOTIM8NoOSOBKd7iOT2/BoW3MMuJmEOpcY=;
 b=k8LJMytIpq8a92cFKJDRyQD9G2gB9e4yHENKcxQqZFuxwyQL3K6Na9Pxjb+tfuD8ycnpiW86k
 er0SGyhyT3cByQa0pEx46UyDAAhL+iId74x9DTkTy68/ftCipnFboFb
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

There is nothing userspace can do with this value. In the kernel is
always combined with AT_VECTOR_SIZE_BASE, which is not exposed to
userspace and also changes from time to time.

Move the symbol to a kernel-internal header.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
Reviewed-by: Kees Cook <kees@kernel.org>
---
 arch/sparc/include/asm/auxvec.h      | 6 ++++++
 arch/sparc/include/uapi/asm/auxvec.h | 8 +++-----
 2 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/arch/sparc/include/asm/auxvec.h b/arch/sparc/include/asm/auxvec.h
new file mode 100644
index 000000000000..50c249a8bd17
--- /dev/null
+++ b/arch/sparc/include/asm/auxvec.h
@@ -0,0 +1,6 @@
+#ifndef __ASMSPARC_AUXVEC_H
+#define __ASMSPARC_AUXVEC_H
+
+#define AT_VECTOR_SIZE_ARCH	4
+
+#endif /* !(__ASMSPARC_AUXVEC_H) */
diff --git a/arch/sparc/include/uapi/asm/auxvec.h b/arch/sparc/include/uapi/asm/auxvec.h
index ab8780fb9df1..0fab3b29148a 100644
--- a/arch/sparc/include/uapi/asm/auxvec.h
+++ b/arch/sparc/include/uapi/asm/auxvec.h
@@ -1,5 +1,5 @@
-#ifndef __ASMSPARC_AUXVEC_H
-#define __ASMSPARC_AUXVEC_H
+#ifndef __UAPI_ASMSPARC_AUXVEC_H
+#define __UAPI_ASMSPARC_AUXVEC_H
 
 #define AT_SYSINFO_EHDR		33
 
@@ -10,6 +10,4 @@
 #define AT_ADI_NBITS	49
 #define AT_ADI_UEONADI	50
 
-#define AT_VECTOR_SIZE_ARCH	4
-
-#endif /* !(__ASMSPARC_AUXVEC_H) */
+#endif /* !(__UAPI_ASMSPARC_AUXVEC_H) */

-- 
2.55.0


