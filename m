Return-Path: <linuxppc-dev+bounces-23993-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD7D9C43458
	for <linuxppc-dev@archiver.kernel.org>; Fri, 10 Jul 2026 06:14:45 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gxM4N4GJyz2yRF;
	Fri, 10 Jul 2026 16:14:44 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=193.142.43.55
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783664084;
	cv=none; b=NI1JVVdbC0ju/34Mf3LoV1BAuI+rycvHMUSdex0bs1ssTtDzUodIJ1sQVWdmMru5NfBUxkxXwP5hCui08VIadngAn/HmrAij+tc38XqH3fExOSAOxrbi//fmKb7kG3CPcIHraOow8pwXntWNlQ4MXVZE67gS9BS2ID5tJYy1VYmoTym3ydOHZNDuTC5t6aRwOphVMHqe8eF+/7lOw4iRqso8taaAD8B7IOBEAQnaSA9df0ODTTbeIpWsmNJ/eaDIGj+rcNM0WqSz8X/m6JqxHiDaFM9Jba39AEXsSfjBDfVsxe0GAnylgVqdSn+OauMi45SJQcMf+BeWJ2KJAgP4nw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783664084; c=relaxed/relaxed;
	bh=RN/LYB8s7inQyOqwKkBwjrqheVSXAS70Mvy85PvkZ7c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UjfqJDTKdqmzWM7H4xIbTOfpmWYeSauor3Tlbc9QLHc6+SIhOTRn5UU3v7cQKv1phAAnfYkRg1oHQbWX+Vjzfz6IbtdXoWxOU5lrDvQ+7eQP9zQ1u/xMPI8eoUAOJWYW15cbAQfSpDnoKJaLeCvP73fNm+YHTudRPCBHdWfLkNEjXyl8s+z5zf/UciQx8Fd3qeejnDZWGluM1UxSldoTFAriAVKUK9noGgC50Gs9p1sca0PyBqIrxA6+i21YyPsNy8CaOdgosfAOfvSFo2d2kxskUs2QWwM/8zE3r34dGydIl24g8/N6QORgxtq8RRQ5DqZx9c2RKfmfhXXzjx45PA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; dkim=pass (2048-bit key; secure) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=hSY6xBRO; dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=pw/urJLd; dkim-atps=neutral; spf=pass (client-ip=193.142.43.55; helo=galois.linutronix.de; envelope-from=t-8ch@linutronix.de; receiver=lists.ozlabs.org) smtp.mailfrom=linutronix.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=hSY6xBRO;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=pw/urJLd;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linutronix.de (client-ip=193.142.43.55; helo=galois.linutronix.de; envelope-from=t-8ch@linutronix.de; receiver=lists.ozlabs.org)
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gxM4M1fKlz2yQH
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Jul 2026 16:14:43 +1000 (AEST)
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1783664079;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RN/LYB8s7inQyOqwKkBwjrqheVSXAS70Mvy85PvkZ7c=;
	b=hSY6xBROOGZLc7Ot4/Ifox5KUAiSbn9/3X1/XRpcTKOS5/75jDiejzgfYk9ZhrgWWIlB1g
	2LpB9CQ53bZeSSuGrfC/Bwe7Y1SoeF315ou3TN7yQzgwy4CXgD0tZwtn+ddC3EPiLzN/Tg
	DG+p+QCVbuil3Z/pVGbThyJ+8F9riEodl+GzVXI/gMxblEd6kIsD15woL3OJ2x2OjiEZVh
	s2GsUyXqvLHJo8MRPPRjyIIrESnQlcT44dfzKkJMXUxa9ra1d1EWAUv2pC6IaXML8B6trm
	LspqYy1905YCypvCKf/MfUCrOPCekXOMFyZIYUrUD9WzImyPti4SUuaVuJ/Ayg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1783664079;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RN/LYB8s7inQyOqwKkBwjrqheVSXAS70Mvy85PvkZ7c=;
	b=pw/urJLdpO9rlB+A2IG0iyRFR64M82qzep1iKyRRaJM8/36rRSQFa7xYZX366LKjCUbuYM
	cNC9seoYG5292sAA==
Date: Fri, 10 Jul 2026 08:14:28 +0200
Subject: [PATCH 2/2] powerpc/vdso: Generate build IDs
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
Message-Id: <20260710-powerpc-vdso-install-v1-2-3015af1aa354@linutronix.de>
References: <20260710-powerpc-vdso-install-v1-0-3015af1aa354@linutronix.de>
In-Reply-To: <20260710-powerpc-vdso-install-v1-0-3015af1aa354@linutronix.de>
To: Madhavan Srinivasan <maddy@linux.ibm.com>, 
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783664073; l=1069;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=6TxI15G459SU7/L04+mOiUiV4SbyQEX3EFcN0Hu9P6I=;
 b=lyBlnm6wkkBbZDeU0ztAP67JWFa+yuNLGYAzwQYCMKkyuJYxc2CWPketnt4CWuJzcZhr+OXLG
 afHGboBRMFcC3DLUONmjQ2h/tV+eH8ZyzDNZhgWcFlOKr44crmoBLle
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

The build ID can be used to correlate a vDSO mapped into a process with
its debugging information.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 arch/powerpc/kernel/vdso/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/vdso/Makefile b/arch/powerpc/kernel/vdso/Makefile
index 368759f81708..18ef3057dfd0 100644
--- a/arch/powerpc/kernel/vdso/Makefile
+++ b/arch/powerpc/kernel/vdso/Makefile
@@ -45,7 +45,7 @@ ccflags-y += $(call cc-option, -fno-stack-protector)
 ccflags-y += -DDISABLE_BRANCH_PROFILING
 ccflags-y += -ffreestanding -fasynchronous-unwind-tables
 ccflags-remove-y := $(CC_FLAGS_FTRACE)
-ldflags-y := -Wl,--hash-style=both -nostdlib -shared -z noexecstack $(CLANG_FLAGS)
+ldflags-y := -Wl,--hash-style=both -Wl,--build-id=sha1 -nostdlib -shared -z noexecstack $(CLANG_FLAGS)
 ldflags-$(CONFIG_LD_IS_LLD) += $(call cc-option,--ld-path=$(LD),-fuse-ld=lld)
 ldflags-$(CONFIG_LD_ORPHAN_WARN) += -Wl,--orphan-handling=$(CONFIG_LD_ORPHAN_WARN_LEVEL)
 

-- 
2.55.0


