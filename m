Return-Path: <linuxppc-dev+bounces-25044-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C2B2C53200
	for <linuxppc-dev@archiver.kernel.org>; Wed, 29 Jul 2026 22:39:13 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h9S1W3WYLz2xJT;
	Thu, 30 Jul 2026 08:39:11 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=95.215.58.172
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785364751;
	cv=none; b=Shr7iB0gs+lD1SQ9iZGgWdFPquMInjNg3nFN/W48wS5MAo/G7hOeXi3YOqUQtdRtQrwQy5WI5z4Szn6O+28WJdJCuWtNRL5+P+G0B8q6ufVcpSZFz41e/am/lWzu9khFHTq7rhIjyPYqy3US5peVBMeoi8Q33IoqLeSTVHmpd5HGl5CFbPtTfHdma6nzFR15+T/wyHRbLh7P9e5iNFkoN2fv2ksWZANpKlxUej+ygJux5VMoovFmsSqz+PyGFTeZcZQTN7bydnM2A4+nWL7pcFmVRBeSPZpadjXeJj7Ib18WWd5ogRc80HkCW1AVJVPA0+bb7b8gqp//j9q0i36ugw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785364751; c=relaxed/relaxed;
	bh=0+gYS+CTFvyzTxy/Yk/uLl3yISZGl64atp8aoxFoxvM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nanlDx/5QTjxa/URWuEHd258jZv47t5nxyprl/FBtF9hjc6UlKwg9QKXkui731vokZtLkB78mKWqppUuyhdaECgwER4edUZD7MkOS0AAkYDNS/3D4Z/oPS4SWvhUWRgjJRUL2SZBNlPvZLfb6rCnnvPTSx7irDcAPRTjJdRyNdOmMODlnGKwpVgSehbMbaSRJbZGasiv8R46PEL0rc/JVOpoEffK19KtCSTdwSJjzcPOg21HyP9dcq9y6CSqDXD+A/NzjiKY4Cy5VejlZraTgG+J9oP7nV0FujvUVFQajHSavZR/IvPg8RSQVlR1ooMmT2xdKhCR8CS2VYz+bqC34w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev; dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=peOsMKIu; dkim-atps=neutral; spf=pass (client-ip=95.215.58.172; helo=out-172.mta1.migadu.com; envelope-from=thorsten.blum@linux.dev; receiver=lists.ozlabs.org) smtp.mailfrom=linux.dev
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=peOsMKIu;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.dev (client-ip=95.215.58.172; helo=out-172.mta1.migadu.com; envelope-from=thorsten.blum@linux.dev; receiver=lists.ozlabs.org)
Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h9S1Q2kXCz2xFc
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Jul 2026 08:39:05 +1000 (AEST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1785364724;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=0+gYS+CTFvyzTxy/Yk/uLl3yISZGl64atp8aoxFoxvM=;
	b=peOsMKIuIqxhDfHP/lsnCVVWYmkP6TubB0Td8WqjtoTHciZrnwYGg/+Vj5vG/NhjNwGG+T
	dh24HhEPHM6vUemx5CAUTFNmkpSg4gHoSP+D/xqyEqsQjSdt+WpKy+5QhCswszkNnRH/ro
	Lvdn3xJSszF/Hqao4UKNmIJQFLM4cPI=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] powerpc/serial: Use generic BASE_BAUD in asm/serial.h
Date: Thu, 30 Jul 2026 00:38:07 +0200
Message-ID: <20260729223807.570178-3-thorsten.blum@linux.dev>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=800; i=thorsten.blum@linux.dev; h=from:subject; bh=yEp9DXwWsx6XbhkgNa55MZpXRtIkJbazQ9uYM9P6PRE=; b=owGbwMvMwCUWt7pQ4caZUj3G02pJDFlZDeddfMRmeEmsDD2vdO/hZc93afxCS/2WClsyJZ85m lD3wKi2o5SFQYyLQVZMkeXBrB8zfEtrKjeZROyEmcPKBDKEgYtTACbyspKRYYtpi2x5cMJWrSPe v4JTOpZvii/zMGJwi3475YODzec5GYwMB/PO1/zzmHI3Ju+Y8lU5B4n7J2LK19pP4/tcu+yKm9d uDgA=
X-Developer-Key: i=thorsten.blum@linux.dev; a=openpgp; fpr=1D60735E8AEF3BE473B69D84733678FD8DFEEAD4
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Include asm-generic/serial.h and use the generic BASE_BAUD definition
instead of redefining it.

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 arch/powerpc/include/asm/serial.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/include/asm/serial.h b/arch/powerpc/include/asm/serial.h
index cd6c18d0e66e..eca0ef56f874 100644
--- a/arch/powerpc/include/asm/serial.h
+++ b/arch/powerpc/include/asm/serial.h
@@ -9,8 +9,8 @@
  * through the device tree.
  */
 
-/* Default baud base if not found in device-tree */
-#define BASE_BAUD ( 1843200 / 16 )
+/* Provides BASE_BAUD, used as fallback if not found in device tree. */
+#include <asm-generic/serial.h>
 
 #ifdef CONFIG_PPC_UDBG_16550
 extern void find_legacy_serial_ports(void);

