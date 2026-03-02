Return-Path: <linuxppc-dev+bounces-17523-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B566E9B371
	for <linuxppc-dev@archiver.kernel.org>; Mon,  2 Mar 2026 12:26:46 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fPdSj6jRqz3cHb;
	Mon, 02 Mar 2026 23:25:57 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=193.142.43.55
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1772454357;
	cv=none; b=KMpl1hCZwf7JzrBLxrJ3etjGAjeBo/1w5ygtqGGMhxYLP9HKCL+O/i92s7JiU3pxubiVQ2fb20PjV4WcRX6heSz5RWtfowygWl4Xm7MUMyamzQ50l6O1irdiYUucUiKb9LNQ1NR07Big+Fitnl+24eHTyB2YeGmOJkvEhrsXkPNqjSpwOFSww68ybftC7rsDsflj4NoN0GU7vQM+VvMwFOxdfTgdQkTFWtdc1PKtT+8WNqmPjHjCvW3AdZFOP30wpSBBj5mUq/3oXqmRP3hEkTGuOHs7LtiGCdPkt+1uFUOdtlHofOxVOz9uVIvcUnMneARtM0IZOe1+NoiM5NpT6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1772454357; c=relaxed/relaxed;
	bh=IIl7i97gp0WaH6kynmrYy0424iWZ8UY7WAcAVJym5Rw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cuYp/4S2gk38Vc/XNzR+WaYiwZamCOQeshQ8c9mAh+NHyjNToRHEbx3BehOwUWh/k2GNzBqzR8r6xvC04/7sQd9fMx2WvpCZZf0IcnBxUtM5JFjh9OtAJN3Yybhqu8dEOqLuezUbDNtCM2TA7JVXk588vHs99jfrjsJVfFGLmi9cC7yU5Bkdi8wIw9Rqcbs05Gow0+FApSqJ19zkWeba5tFGLQECZ7HYbSCcloGQ+x/QOIW1Ghqve0gck4Q8iR2+xtolKS3QoONgn1Osw1AEJAPK87pggOYuXWJPE1G/GnQZC1ABX9q/ot9NFuopQnRFPAVjRQjLwnete/gfP0I8lw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; dkim=pass (2048-bit key; secure) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=DRPBoJTS; dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=l3N5HQGw; dkim-atps=neutral; spf=pass (client-ip=193.142.43.55; helo=galois.linutronix.de; envelope-from=t-8ch@linutronix.de; receiver=lists.ozlabs.org) smtp.mailfrom=linutronix.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=DRPBoJTS;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=l3N5HQGw;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linutronix.de (client-ip=193.142.43.55; helo=galois.linutronix.de; envelope-from=t-8ch@linutronix.de; receiver=lists.ozlabs.org)
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fPdSj1mJGz3cG9
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 02 Mar 2026 23:25:57 +1100 (AEDT)
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1772454351;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IIl7i97gp0WaH6kynmrYy0424iWZ8UY7WAcAVJym5Rw=;
	b=DRPBoJTSt1Cn72FxGrkICtx6iDm9aDHjx/AiP76zWoLsyxyzrn4ftQM8rjPsBPR2yghAxc
	iR03PQOiOtY65dbfApwClyN8khUvycPTz5RPDD0zS6rfyoHl/BLatzcQVmp558W1UrU0/V
	DFLjDsmsvIVFvnRmUwCirnFDQgXPo+umbV9RIGje8FXGAYZUx+Oi9PCoWGSVr6fjD4npDk
	X0e31PVB5vjJFxtV/JxaclK2glIQQnIbrbYGPZVHGwtbyhuWE04K6kgZN5ywBmzdxx54K9
	oRG0MM6oeTqAEIOftIbOHX4Ql1V8Gitv0Z0kUSKeQRgIsWMIjbEf/G/ltVyCjQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1772454351;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IIl7i97gp0WaH6kynmrYy0424iWZ8UY7WAcAVJym5Rw=;
	b=l3N5HQGw9RkKQ8pgKQOl0uOf0kedifyuf/MGCLSijjuMiUCiOQTt4T2v93KxTFefrGNyku
	1oJIKuXH2FuNXNBQ==
Date: Mon, 02 Mar 2026 13:25:36 +0100
Subject: [PATCH 12/15] sparc: Remove AT_VECTOR_SIZE_ARCH from UAPI
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
Message-Id: <20260302-at-vector-size-arch-v1-12-a11f03ba2ca8@linutronix.de>
References: <20260302-at-vector-size-arch-v1-0-a11f03ba2ca8@linutronix.de>
In-Reply-To: <20260302-at-vector-size-arch-v1-0-a11f03ba2ca8@linutronix.de>
To: Kees Cook <kees@kernel.org>, Arnd Bergmann <arnd@arndb.de>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
 linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-riscv@lists.infradead.org, loongarch@lists.linux.dev, 
 linux-s390@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
 linux-mips@vger.kernel.org, sparclinux@vger.kernel.org, 
 linux-sh@vger.kernel.org, linux-alpha@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1772454343; l=1413;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=Iwaju8vXi9F4QFXCQeLchkBfrV3+4S1lN9ALuspGOMM=;
 b=qYE0Cjq7x88NCS4YgSX8MOndLBO3D8QhHWThM4b0UUGFInc+vhxv4cTOMQS/J6/diZo2W/4vM
 jvG23iECxNuCS96zpughHWKWr8+8K3S6bWHHCGi1ZI/2c1sH/jMD9lc
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

There is nothing userspace can do with this value. In the kernel is
always combined with AT_VECTOR_SIZE_BASE, which is not exposed to
userspace and also changes from time to time.

Move the symbol to a kernel-internal header.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
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
2.53.0


