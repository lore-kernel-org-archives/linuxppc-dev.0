Return-Path: <linuxppc-dev+bounces-17346-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E14E0FD4600
	for <linuxppc-dev@archiver.kernel.org>; Fri, 27 Feb 2026 06:46:11 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fMf2c0GG5z3cMF;
	Fri, 27 Feb 2026 17:44:56 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=193.142.43.55
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1772174695;
	cv=none; b=ZfWQUI+dNxYgGzzkMNfYCAvi7gwAeQA8O6BSR5L87hntq81owT+q3TZ+A3TtgxIx481GQb3QACsVBKVywmwWPilWfFhhwxqpY4bjsNy49uy6nDOBLCHuqml1EbL4S/dTuNXpt36CiY/IRfSRxHdeJrTmA34sBffrRGDrBaEjMWzeLpcj92i0In0pyGNsko3zIhwtjyYEgjBQtX9AfZxpEYYDwkFS/3gLcltkMQl/+13IT7+34e5eaMJXy5593mge3NwrTRkJTvD/tR2aTPo9mOtTbGSJKLriX1Y8cwO0Ou1RBCITIDf4xCp2P+eEzQaW5tNKUAUKg34+LbTiUCoipg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1772174695; c=relaxed/relaxed;
	bh=9Ry4+WibbULZID6m2Gq5rwGN2Xcc8vgpZAjqk8Y5/xQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=h112wfsGiebQ31f4qcdJcFvhRsAJEGrEXg7Sx9ErVU+IL/x0gy4ayPtSFstEGgSpYZSytgWOvkfyGf8akNMf8dW8gtWE/Ut82UYmTjsnPD5Kq9HbsQh3RtDAXr9yJ7b7fZDBpkUk2wqn6TqG1qWEBGEWlAjvo8h8F3KQmrJzoFiqp/uq8dhOYoxUXYH1nvPV8jMcX/KkERTyVr+wkRfaq4iGhxmj/883JF+ubiWZh/5DVEpUnPchb0zmIDBlkV9MJ4OX8Ow6sVg8eJVEWfm3zsc1AODYj3IA4uPrSjUVga/9UXKyGOAQ3cNGlDQGfrOyXeshoey9yY8vnxhJtKC8aQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; dkim=pass (2048-bit key; secure) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=stdRMCHR; dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=+WnbQ4wr; dkim-atps=neutral; spf=pass (client-ip=193.142.43.55; helo=galois.linutronix.de; envelope-from=t-8ch@linutronix.de; receiver=lists.ozlabs.org) smtp.mailfrom=linutronix.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=stdRMCHR;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=+WnbQ4wr;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linutronix.de (client-ip=193.142.43.55; helo=galois.linutronix.de; envelope-from=t-8ch@linutronix.de; receiver=lists.ozlabs.org)
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fMf2Z4vtKz3cJN
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Feb 2026 17:44:54 +1100 (AEDT)
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1772174686;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9Ry4+WibbULZID6m2Gq5rwGN2Xcc8vgpZAjqk8Y5/xQ=;
	b=stdRMCHRvs0xeu82UFxyQcNCnPhyYkbXy3Fo2ZHSjDbGGRmIU26IulLEEC7iOn80gSRfYl
	JdWJa4E0AZOnDcjiSrIGmMgmTcP8wc3PJKIZ50EAW7jQ04b8tRt5lArZLzhL09e/agJpj8
	a8HGGfHa3tRakQCJKIxMJKCrDMAOI7dJRyJ++8cdaL8uYfUNcMlIXuDixyWEcdURwCnFy0
	a4T+vHkueg/QFZNrYSOn4utqmnjLuvjU2sILDk606jU/7beDwydO9a2/coWViQAsu/eEvL
	2DxN43XmoBlhoQ+I7KiLqP5PtvfHlXbnsDHSMnNph7nt7OiMVS9fYrmKSXvcpw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1772174686;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9Ry4+WibbULZID6m2Gq5rwGN2Xcc8vgpZAjqk8Y5/xQ=;
	b=+WnbQ4wr/QXZezkGKV43XZn6mvZwovNgHtNtXxl3JgXt8BChHmKwcgG0Z9p9erF0KkIOne
	6tGT4Q4I+ksCavDw==
Date: Fri, 27 Feb 2026 07:44:34 +0100
Subject: [PATCH v2 08/15] MIPS: vdso: Explicitly include asm/vdso/vdso.h
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
Message-Id: <20260227-vdso-header-cleanups-v2-8-35d60acf7410@linutronix.de>
References: <20260227-vdso-header-cleanups-v2-0-35d60acf7410@linutronix.de>
In-Reply-To: <20260227-vdso-header-cleanups-v2-0-35d60acf7410@linutronix.de>
To: Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>, Russell King <linux@armlinux.org.uk>, 
 Madhavan Srinivasan <maddy@linux.ibm.com>, 
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, 
 Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>, 
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
 Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@kernel.org>, 
 Vincenzo Frascino <vincenzo.frascino@arm.com>, 
 Theodore Ts'o <tytso@mit.edu>, "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linuxppc-dev@lists.ozlabs.org, loongarch@lists.linux.dev, 
 linux-mips@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1772174681; l=696;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=sy5Iw83Mck3+k+fjmUT3MnQ1D2VXltvzXrUk++HeffI=;
 b=gexqOPTBO4Bt3KN2Hw80+zQ1Dm7PNP5n7sIAdmJPRveo0LnMUuplYuKy+W5bveU9pUDhtjgKK
 pk6GG2m6dQYCc7/5EXtBHbdyeNv2+zS74L0qzV37FLmkASdTF1Xw3IS
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

The usage of __VDSO_PAGES requires asm/vdso/vdso.h. Currently this header
is included transitively, but that transitive inclusion is about to go
away.

Explicitly include the header.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 arch/mips/kernel/vdso.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/mips/kernel/vdso.c b/arch/mips/kernel/vdso.c
index de096777172f..2fa4df3e46e4 100644
--- a/arch/mips/kernel/vdso.c
+++ b/arch/mips/kernel/vdso.c
@@ -21,6 +21,7 @@
 #include <asm/mips-cps.h>
 #include <asm/page.h>
 #include <asm/vdso.h>
+#include <asm/vdso/vdso.h>
 #include <vdso/helpers.h>
 #include <vdso/vsyscall.h>
 

-- 
2.53.0


