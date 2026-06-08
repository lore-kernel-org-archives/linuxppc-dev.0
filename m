Return-Path: <linuxppc-dev+bounces-22290-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 976DBCD8CA4
	for <linuxppc-dev@archiver.kernel.org>; Mon,  8 Jun 2026 19:32:38 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gZ2Hm6Fs7z2yS4;
	Tue, 09 Jun 2026 05:32:36 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=91.218.175.170
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780947156;
	cv=none; b=WK23AyqDWYeA2ujjay1Hb5tP+Gu9JSIIfpUSB8vOd9HhigPRRnEbzze3TFuaC2Pm+jzirfoY9fASZlGCDBAmVbcoivwCIL9kZakaW0tsbvWEJh68DIOhKk7YoPtPsJO9uOJdNblPiCirmgVDqdYwBVe3DQgUBLpGAdBjQkYuWe9XJgn6BRjZYBfCh14vNlRDVYJd+v+PEELec04PmwyP04W9YAOzXOGSNP5o4K+pmAycWZadANHYn96x7WNvXGnXElX/Qq65TPFmxkhqMXTrbUg1iMmua7m2zMqlWVxRgfD5r3lovfLONfSH2jIJSAZe28QIkgwHU1JEePSDKnMdeA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780947156; c=relaxed/relaxed;
	bh=/QZ5Q/NLP6mi0bFSin+pLXDHZVfutJQsDeBxQFEW0TM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=h7dc+MQvZOpulDoWMjX78BtQo0+CWSQMyhrY6hvWIapDXU7FLlWLEs4o9eZy9O7Aw9+6bV2Nij4ofD1LGOzGwf+IwOUBoEZOySQ47opgXKuBVvo4q1oeUcyHy4fEGcXf7hiM3Q+lujl/O7zusyq7sYd+mhNrVvgrdJtpCVqZ3Lsg1rBtFfUce3nvCepkDifKqTgOgmCD/H8RsrpQz9NxTVoGmc1E3uguwSzb1xVaZSEsCQ/qcGaLi26Euq3Ovw0O1GzatEEpFhlohMYPeL3sd3ThnL6vXHPQB1jCUV6CugjDOqtWrrGNw795WJcapY3u7bgwI2EHEZPBT8qzn9jagg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev; dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=YoU9pd2w; dkim-atps=neutral; spf=pass (client-ip=91.218.175.170; helo=out-170.mta0.migadu.com; envelope-from=thorsten.blum@linux.dev; receiver=lists.ozlabs.org) smtp.mailfrom=linux.dev
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=YoU9pd2w;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.dev (client-ip=91.218.175.170; helo=out-170.mta0.migadu.com; envelope-from=thorsten.blum@linux.dev; receiver=lists.ozlabs.org)
Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gZ2Hj6767z2yRM
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 09 Jun 2026 05:32:32 +1000 (AEST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1780947132;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=/QZ5Q/NLP6mi0bFSin+pLXDHZVfutJQsDeBxQFEW0TM=;
	b=YoU9pd2wBL/0d9aROLd4wz97VZahlzwxoGnL1ptmbq5uLKQHyEREDvtxEZvM11kpyglrdn
	7MFuvG2j+BqjYkQcxpeYGqtyksuHu/g/pSWl+iQE33GkBWbytCgtWmU5jTL4PowraqQJFc
	7IyOJ7O3Zz3gwcZYRCNw+AlYrPYEzDg=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] powerpc: replace strlcat to simplify ppc_kallsyms_lookup_name
Date: Mon,  8 Jun 2026 21:32:03 +0200
Message-ID: <20260608193203.163266-2-thorsten.blum@linux.dev>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1639; i=thorsten.blum@linux.dev; h=from:subject; bh=aEF6WPdcapxB9O1OP0x5DNXuOONQzmwjEmpk8Q0Akrw=; b=owGbwMvMwCUWt7pQ4caZUj3G02pJDFnqEpv39sgcWdsjxlR3sW+93WthxZSaNzd2c4vcPd3PH rvuwteujlIWBjEuBlkxRZYHs37M8C2tqdxkErETZg4rE8gQBi5OAZhI4juG/35Tn7qebSpVUVon r7i35aaW97ez1SXXLat9Nu8s7fTgqWVk6NrtFn5xRUPffM7buWFPG7efszwtecDWiXf6red3H2l n8AIA
X-Developer-Key: i=thorsten.blum@linux.dev; a=openpgp; fpr=1D60735E8AEF3BE473B69D84733678FD8DFEEAD4
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

strlcat() should not be used anymore (see fortify-string.h), and since
name is guaranteed to be NUL-terminated within KSYM_NAME_LEN bytes, use
memcpy() instead.

Rename dot_appended to the semantically clearer prepend_dot while at it.

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 arch/powerpc/include/asm/text-patching.h | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/arch/powerpc/include/asm/text-patching.h b/arch/powerpc/include/asm/text-patching.h
index e7f14720f630..c47b813bd067 100644
--- a/arch/powerpc/include/asm/text-patching.h
+++ b/arch/powerpc/include/asm/text-patching.h
@@ -227,22 +227,21 @@ static inline unsigned long ppc_kallsyms_lookup_name(const char *name)
 #ifdef CONFIG_PPC64_ELF_ABI_V1
 	/* check for dot variant */
 	char dot_name[1 + KSYM_NAME_LEN];
-	bool dot_appended = false;
+	bool prepend_dot = name[0] != '.';
+	size_t len = strnlen(name, KSYM_NAME_LEN);
 
-	if (strnlen(name, KSYM_NAME_LEN) >= KSYM_NAME_LEN)
+	if (len == KSYM_NAME_LEN)
 		return 0;
 
-	if (name[0] != '.') {
+	if (prepend_dot) {
 		dot_name[0] = '.';
-		dot_name[1] = '\0';
-		strlcat(dot_name, name, sizeof(dot_name));
-		dot_appended = true;
+		memcpy(dot_name + 1, name, len + 1);
 	} else {
-		dot_name[0] = '\0';
-		strlcat(dot_name, name, sizeof(dot_name));
+		memcpy(dot_name, name, len + 1);
 	}
+
 	addr = kallsyms_lookup_name(dot_name);
-	if (!addr && dot_appended)
+	if (!addr && prepend_dot)
 		/* Let's try the original non-dot symbol lookup	*/
 		addr = kallsyms_lookup_name(name);
 #elif defined(CONFIG_PPC64_ELF_ABI_V2)

