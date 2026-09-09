Return-Path: <linuxppc-dev+bounces-26896-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1BF1C79F8C
	for <linuxppc-dev@archiver.kernel.org>; Wed,  9 Sep 2026 08:52:30 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hfvgD72Zyz308Y;
	Wed, 09 Sep 2026 18:51:36 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=193.142.43.55
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788943896;
	cv=none; b=Ucn6ReO5C+0SFfD1/c1BIR5xf3lTu73AZURWZ03D7uCyuV1p8fCOFC1IFJ2mwl/FtS3Ev1hCs67m+u7hbNCSmc3oRy8V7SSZwWwWTvMdOcsbFEF3gMxzPsRyjbQFd74l3LkUJb+Ihdrwp4XZ9EDu88lncBT0Xx6MBbnwMTDXgEx+IutuJOCrkOvv8T1LKDw+Hskdt4z4z1IbQp1ok5Hj/g3cVrmb/HVPgtfK7FDrrBp3z+R6Jy24LKNvUza/BUE4e1TERQAKqSbn6jheKNeLzs5MeI01xAphy4IRZjBpemX4+O9U8njUVpCgHS9njpGyV9o6K8O/JFL8xfSLzxmAmg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788943896; c=relaxed/relaxed;
	bh=sC8+6J9OLUakbA4e+Ap2B6uuZE9Tl7PwTVwk0psJD7w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SlRqLX65ce+41722XAdQ4D6/bVNlNEZI8UzwyySVdbXV9EexM+ikDVcJHMuYAC82zsE6nZFQgf/2m73YDCZV/cMbT8KdHx/U3ko95lTv9rksLwNjHGVjY0u4k+adE4ymvE6oNtcHVTfUWmKOpiMnzRbqwD5EwO4oxStI0I5FJzhB/tb9pPxCz8GIhUwY42RQiW6z8ZST0y9J343U4Bk4lzSCQNGrYQ2czm/Io90C+f6BylcIgwZum147K4L4WbGobNOStNnTqg5noL2503BITnpHxbpldKIbdFkqb3awXKhYnlAEn0CSf2tdlL/iVPKiAj/08HhA2JEu+W49jQtTvw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; dkim=pass (2048-bit key; secure) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=18ypzorm; dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=V9tYUFNz; dkim-atps=neutral; spf=pass (client-ip=193.142.43.55; helo=galois.linutronix.de; envelope-from=t-8ch@linutronix.de; receiver=lists.ozlabs.org) smtp.mailfrom=linutronix.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=18ypzorm;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=V9tYUFNz;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linutronix.de (client-ip=193.142.43.55; helo=galois.linutronix.de; envelope-from=t-8ch@linutronix.de; receiver=lists.ozlabs.org)
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hfvg94HcSz2yvj
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 09 Sep 2026 18:51:33 +1000 (AEST)
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1788943885;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sC8+6J9OLUakbA4e+Ap2B6uuZE9Tl7PwTVwk0psJD7w=;
	b=18ypzormw89rOzBf6uIIHYH1wJOPorGI4jxdXBGhkEdBQPZOLIVTm3KlRtbdVDtdGj9VG7
	Dyjho9sIcBEasT5u31Y6tYFz04xKu20FzftA5gy6Id8NhHbhfJut0d0PS+7ZjetZKmijCh
	u/3olgtjrDEgB4C5ITT4CpG3VJZ5DK2VcHCG/wOlxBKI+jSGLQNOi+m8a9Y5OivTRfFyAs
	2pKxnMgQ6QXgcLRV+3MsRlunL77unXFK+hIJ7P2eCY8PBRsZctieqL2rbr4yWOsH/yijps
	0oceS1P/fPh3YWLS+ARzngBQRl6bCpKYgOPJXYvTIYdpTZN4WO39XXP4Yc9OKQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1788943885;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sC8+6J9OLUakbA4e+Ap2B6uuZE9Tl7PwTVwk0psJD7w=;
	b=V9tYUFNzgGBunIsna6vZfNbVMtIIjvl+n+kfHtNDv+819iutT7PUqChs4OihB+GRdxuasV
	MJxc+Wzwhfj+biBw==
Date: Wed, 09 Sep 2026 10:51:22 +0200
Subject: [PATCH 09/15] sparc/vdso: Delete asm/vdso/vsyscall.h inclusion
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
Message-Id: <20260909-vdso-asm-generic-vsyscall-h-v1-9-63ae856cc659@linutronix.de>
References: <20260909-vdso-asm-generic-vsyscall-h-v1-0-63ae856cc659@linutronix.de>
In-Reply-To: <20260909-vdso-asm-generic-vsyscall-h-v1-0-63ae856cc659@linutronix.de>
To: Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@kernel.org>, 
 Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, 
 linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 loongarch@lists.linux.dev, linux-mips@vger.kernel.org, 
 linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, 
 sparclinux@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788943875; l=516;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=p+b8xoqSRp+BaXpuv6UkhI9jSr9haopNWgF+UmEOVQk=;
 b=M4PnWWjB8PtId1XPU1zVCslJBTDHYh9V/L0XSbIVM9OptHzq+tq0jklWaWwKlEoUCNwkyM6tW
 rJ+WK8pnGurDoAd2fM6SfaNEA6DETxYOyV8t6MVuFm8YlCVyu8Tziow
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

The inclusion is unnecessary, remove it.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 arch/sparc/vdso/vma.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/sparc/vdso/vma.c b/arch/sparc/vdso/vma.c
index 60029d60f4d3..ab6626c1ee61 100644
--- a/arch/sparc/vdso/vma.c
+++ b/arch/sparc/vdso/vma.c
@@ -23,7 +23,6 @@
 #include <asm/page.h>
 
 #include <vdso/datapage.h>
-#include <asm/vdso/vsyscall.h>
 
 unsigned int __read_mostly vdso_enabled = 1;
 

-- 
2.55.0


