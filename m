Return-Path: <linuxppc-dev+bounces-26467-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21756C624A4
	for <linuxppc-dev@archiver.kernel.org>; Thu,  3 Sep 2026 07:51:57 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hbBcq6Q3gz2yvv;
	Thu, 03 Sep 2026 17:51:39 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=193.142.43.55
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788421899;
	cv=none; b=V3JRJIgnIJ+ks05tsziuhvcghCsUL9deWshoFSzJHgm0PXhGGMR8hyNrmVhPwFsX9Dz8pw4+g16AeridhCFoDsBA+k571Tzk1HLXwrieTORoms1MW76KcohoBkQwBqmbZN23FrQubwEFPXRahd+MnaXT3+b3TYfe1C/3DBux0tVTnLscykhZk+vPKDloYVp24Zv/7S7w+sN59dJTg5+DKCzFAuNlOazd8yBCdJ4QjgWPXVld4metYnsV7+dEN1VXDouezjroftGw5hEfxAwOq0h/DBA7R3f3Ce3agYRNPmpXOR6n5x2lPZIROcUDTno0bLGrmVCmkE9F1W/3JJKVKA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788421899; c=relaxed/relaxed;
	bh=0aZut8kA+4chJGGwM3gCf5+HQ533NpmMKcsyR+MQing=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ms5V0bAJwya0R2ZjFVmP3mj4Kk1EgwwVlUOADCxBBXMSmNI5VJTdT65HScDavf8Wxtkrh0/7rpmbqaF5LP+LTdJZ7IZiZxtKRORG6jwATubd9wGiNDPXpuy/iKCBJt9R51AeLz5xHTEVBChwn3qM4Y84HD0I+LoEYQ3epQhPl+s0FGyLVcJxc41Gb75pj8n1onRvLyIR3jWGbmsmH7DYI8JDbMjHKa9a6JkGmJ5zuNAwYFE+QKmFg2n0t5RFTit9TPrdkUH5F1lATjD3TkYXO8EMnjtvZwgrozAxD0nyr79sKodjDJ0d6lDGey0y7rFuiXH8Bty/62WtRfP538LHRw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; dkim=pass (2048-bit key; secure) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=2n1aEsew; dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=amGLpWRC; dkim-atps=neutral; spf=pass (client-ip=193.142.43.55; helo=galois.linutronix.de; envelope-from=t-8ch@linutronix.de; receiver=lists.ozlabs.org) smtp.mailfrom=linutronix.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=2n1aEsew;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=amGLpWRC;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linutronix.de (client-ip=193.142.43.55; helo=galois.linutronix.de; envelope-from=t-8ch@linutronix.de; receiver=lists.ozlabs.org)
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hbBcm0gkkz2yrF
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 03 Sep 2026 17:51:35 +1000 (AEST)
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1788421298;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0aZut8kA+4chJGGwM3gCf5+HQ533NpmMKcsyR+MQing=;
	b=2n1aEsewcEY2O/4HmcehE0YE0VieS3W2Gs7Xi6wKvR4tHUFLZZdAgWR7QSYOOUkhJPQYgK
	Kf2YukB5g2gEpDitBxuqTpqVK1ts0CgTyVz6Ft/ZacoKjUo1xHG5dq9fA1bxtdIte/vSMa
	58oCWjCpgyI39K14Qkp11rzvyd7YXsrvwZGArqXZ/wa7XZbFvsNdzIviRN6F3eu02VelMS
	0IR+KoFKvbjgJLQBuTr2jCrJ0mmGsc4gS7EcrDz4+L54rrwo5R2h8w1UoisMF/Lh8uc4m0
	RuqlyQoxX8m9GiTcSRlUh4IIaO/IBeLdHZwcZlUEiN865f/h5LeGkrWqIAfMTw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1788421298;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0aZut8kA+4chJGGwM3gCf5+HQ533NpmMKcsyR+MQing=;
	b=amGLpWRCPzszmWf2agPqW3Fg7V59XzpRILVaIxSaD3ICIskVDU9Cfpi1H6/i1xn+cRW6Jq
	FawyH8+8sQE1GjBg==
Date: Thu, 03 Sep 2026 09:41:30 +0200
Subject: [PATCH v2 15/15] auxvec.h: Drop fallback AT_VECTOR_SIZE_ARCH
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
Message-Id: <20260903-at-vector-size-arch-v2-15-5bc32a71e3d8@linutronix.de>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788421286; l=772;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=h0d3/9vi5+RkvDv34sEYqTWGje2TjQ5iv2oSp1yFOKY=;
 b=JaGBRkuyra1orRqWHzX95kpMA0xW4S8rfsJ0pler5rGlI0La87KEeut8woUGbU1ptSxEISgz0
 Ljvg0UEOZ/ZBH8ervfYSiUK0bZeaLfogWTUGiQhqsWdwyQWXx54SvJ8
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

All asm headers now define this constant.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
Reviewed-by: Kees Cook <kees@kernel.org>
---
 include/linux/auxvec.h | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/include/linux/auxvec.h b/include/linux/auxvec.h
index de1c33c4a256..f7ddea1dbc8e 100644
--- a/include/linux/auxvec.h
+++ b/include/linux/auxvec.h
@@ -9,10 +9,6 @@
 #define AT_VECTOR_SIZE_BASE 24 /* NEW_AUX_ENT entries in auxiliary table */
   /* number of "#define AT_.*" above, minus {AT_NULL, AT_IGNORE, AT_NOTELF} */
 
-#ifndef AT_VECTOR_SIZE_ARCH
-#define AT_VECTOR_SIZE_ARCH 0
-#endif
-
 #define AT_VECTOR_SIZE (2*(AT_VECTOR_SIZE_ARCH + AT_VECTOR_SIZE_BASE + 1))
 
 #endif /* _LINUX_AUXVEC_H */

-- 
2.55.0


