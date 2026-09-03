Return-Path: <linuxppc-dev+bounces-26468-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D01EC624A4
	for <linuxppc-dev@archiver.kernel.org>; Thu,  3 Sep 2026 07:52:26 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hbBct0YLDz2yrF;
	Thu, 03 Sep 2026 17:51:42 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a0a:51c0:0:12e:550::1"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788421902;
	cv=none; b=YOPFYUW1qOg2Dr39L2oKMPihaftATJtuQA6ttYqJ18IntU2tLsapsZcdhTif545GP472s6H6gei4mCZkKrUO4d+gZ5sqIUF4f1PpgO9Pp+LuPy4IQsrmksNmWmwrIHvEMQ3kp35sVsCxzLCNdDskkBFwruwNx65OmJ3bG9aDLd47nUbnCbx8lMZNa9uAnbyBXsmUcRHacP0WKf92EswcVU0RU0ax/pPQcX7QWUJU9uPd+PPlFzej0m8gNIIJZHIXJvcuJGZ1HscGb9kRc0TyS29HPjOrxaByRP5BnaCDAZ2KmYMWYXIfWokMZqHPI8JUzCIT4+Zg29RaPouzMDqcOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788421902; c=relaxed/relaxed;
	bh=8ViTmWloD5J2eKVReHF1z7HtFirOwWOw1jQ1azvN/uQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FRWvEwjEpCFKnGXkhkqgeR0kLPoN5WEahtyGKmzeACYCOnvpjE5DW3+FY3yE6oCenBtHJqQ1Y82tbYIHYIU2drnjstgqz26z5Q3SERkD/zcaW4lHCZw1cZFM2vrZEQ+FUJZ189SS90Js52baQ62dFPorq281X0JWpiVXZQ+JtsfZLZOlACbMqfq4mEUOLFcWeql+V4qvAan2d70AA462/KN9FrEPfFl62nVtssVHhnGeKY3e3JIQQ0nWlXRW5X/Mx9Jj1oaOC+eVBAblNK6YtIycjsrKYvCyW0GsEZByrdmosLD9CgJrX4UumDIdIxTOeLpx3qe4jJw5CvmsQhB0YA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; dkim=pass (2048-bit key; secure) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=qygBbDf/; dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=99/QUoc8; dkim-atps=neutral; spf=pass (client-ip=2a0a:51c0:0:12e:550::1; helo=galois.linutronix.de; envelope-from=t-8ch@linutronix.de; receiver=lists.ozlabs.org) smtp.mailfrom=linutronix.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=qygBbDf/;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=99/QUoc8;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linutronix.de (client-ip=2a0a:51c0:0:12e:550::1; helo=galois.linutronix.de; envelope-from=t-8ch@linutronix.de; receiver=lists.ozlabs.org)
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hbBcs00mFz302l
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 03 Sep 2026 17:51:40 +1000 (AEST)
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1788421289;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8ViTmWloD5J2eKVReHF1z7HtFirOwWOw1jQ1azvN/uQ=;
	b=qygBbDf/i/ChTAwdDHX/OMkpJmg3bx6WNehWxnz/a/QG/CS7FCGINzvET8JahA42fqomF9
	0tA/fgeQbgmMTbTiQjN7PdJlMV7Y11X8gID4ivpxX9BwP+ezfa5IJUGKanG/XPsFRFZvzW
	+w91JMBD2jwTIuY19qA66NaWObSbeT+v9qSA/aXqJ/r7GLtPWY+L4rF0kBBhrcq0sS9IS1
	YH38iFpVF78cVoohANLZiDMxyNqiEUlth5rF658DWk6HyldpYOdOSloQqohF0RloLbf5f+
	O1QY45sabtAAMz5DyzbmCTCGTzJvoZxmpqGlyZ73gD3OpdV5mqJKFQtQUXHgsw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1788421289;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8ViTmWloD5J2eKVReHF1z7HtFirOwWOw1jQ1azvN/uQ=;
	b=99/QUoc8tSeZF+1c6hGSR5xjtwKPDTxKJiyjGqHWes2RoXstjBOuax6m03o+e/SbOdYvh9
	hLslsBJWfKFMgqDg==
Date: Thu, 03 Sep 2026 09:41:19 +0200
Subject: [PATCH v2 04/15] ARM: drop custom asm/auxvec.h
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
Message-Id: <20260903-at-vector-size-arch-v2-4-5bc32a71e3d8@linutronix.de>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788421286; l=523;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=4mJFyYPX7/9EiMcEouBDn+ZTTOxkaHBJ3RQn0m6AUq0=;
 b=sVImdxunzIXRXXF2KzwDmKwk5x92lBY65ndCWzK3uf7dXH1bpo1cEYC44cBh8xKpT1XJtE/ZI
 nX8kEx7kkkRCESasFd8Wvn+OVgSU5t7OhvXleYrjtpeuaW16BitTJtC
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

With the introduction of asm-generic/auxvec.h, this header unnecessary.

Drop it.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
Reviewed-by: Kees Cook <kees@kernel.org>
---
 arch/arm/include/asm/auxvec.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/include/asm/auxvec.h b/arch/arm/include/asm/auxvec.h
deleted file mode 100644
index fbd388c46299..000000000000
--- a/arch/arm/include/asm/auxvec.h
+++ /dev/null
@@ -1 +0,0 @@
-#include <uapi/asm/auxvec.h>

-- 
2.55.0


