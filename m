Return-Path: <linuxppc-dev+bounces-15691-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FFAAD31A23
	for <linuxppc-dev@archiver.kernel.org>; Wed, 14 Jan 2026 08:02:24 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4drdqg5rGqz2ygG;
	Wed, 14 Jan 2026 19:01:51 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=193.142.43.55
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1768377711;
	cv=none; b=BCFRPGXeJSD9nWvZajYngT7djFyWVFj/AcPnEm2O09t1ELh1wXDGqH15IOTDcx7v+GRH1lk3KV0dZMiuIfDRVzImrhpQcSTWFJhzDAPzHFACmRD43kO+ZD9TZ0nob+ixRNzoxsEqETFcsdk4TA1KLTihz6ymPl6KmibN9PU1sjPqMFz2RqeOeLVmD4ceFkmw9OQoFaHRYfrD7/uCcSRQ0JslA6uGwyCi0SKhdvJXkHlRoNbxBdtriXnyHnioVzsY+q6WllLlk10q788SL4ECAcu7F2VfOvxBtksHhvgb653+DxpLsgztPm1VIXZBVMDnb9DLisEEV7EbCka9jDxZjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1768377711; c=relaxed/relaxed;
	bh=2g3QVbHrWMxbltOpJFbYJDEOEW8Rpv5rFE4qRg3bpXo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Qa4KpRDDsZUjm2021416uTbVp6bRWzsKBiTwUh6Kgpnv3sSelgJPfJP+cf/IJEs+MTEsPS9ZCvIAfTZgbAW0zuNaKS6YCLL8Rp9GTLOgSIM7IcvF9+GXNEWxX0k2MzFX/3Vm22eaea5S0UBkboQmV0MFw5AEoB4bgfPKgRv0u3HMINd4sHn/rB+hhtXBQpF/9M/yiVtVVkwcYWpvyt9Qu1uuPewn695SA6ZxTFLEHcjktwV7pjpm3NBJ81YsnKcKB1cZxiLwLUbbn+fGOyW0ahICc1HxoBTRlY2Il9uG+IcYgAmwzrXOBUJZaQSpr+4GgHOS/7KXnD9xchC0OrMUHQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; dkim=pass (2048-bit key; secure) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=pJFUzWW0; dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=zIgedRcN; dkim-atps=neutral; spf=pass (client-ip=193.142.43.55; helo=galois.linutronix.de; envelope-from=t-8ch@linutronix.de; receiver=lists.ozlabs.org) smtp.mailfrom=linutronix.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=pJFUzWW0;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=zIgedRcN;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linutronix.de (client-ip=193.142.43.55; helo=galois.linutronix.de; envelope-from=t-8ch@linutronix.de; receiver=lists.ozlabs.org)
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4drdqg210dz2yYY
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Jan 2026 19:01:51 +1100 (AEDT)
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1768377707;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2g3QVbHrWMxbltOpJFbYJDEOEW8Rpv5rFE4qRg3bpXo=;
	b=pJFUzWW05k5+SSg3f6116KzG9PtFSdPOXjYr/Y7ZNCV3dg2pqVk0Kh5F+WEGurOMxEvGLE
	e8WYlK46AjuQ1yAo4BHqfJ7OBebZp9MdZHX/jDMy6KeCFNsxRRgpaPLB5+rXbS+BVb9BbV
	MdHbtBPXSJK6/lrYeASQ+abCoQtNAKK3tHtoIvyNXqHLJIhPgkdoxHW7gsd6MbPwBPk7/I
	A9/vclGzyQH7p0C7So8wjn6VhQZDZQSlkSeHaDhxa3PVylvsORCST058MJx0LkJiKLlUSx
	jXp/no7CybdXDtdCD4+m5u6u7nyLj+SYsl4j4+SUUX/anoXGPOcxt9lfEZaYGA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1768377707;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2g3QVbHrWMxbltOpJFbYJDEOEW8Rpv5rFE4qRg3bpXo=;
	b=zIgedRcNd3q11NN2zkOnafQCoSRyD8+2dkrpNSIdUlN8QrHNXHEcE4bTlFmXGrUE5jATc9
	9KB/8Yf/M60VhQBQ==
Date: Wed, 14 Jan 2026 09:01:41 +0100
Subject: [PATCH 09/15] random: vDSO: Add explicit includes
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
Message-Id: <20260114-vdso-header-cleanups-v1-9-803b80ee97b4@linutronix.de>
References: <20260114-vdso-header-cleanups-v1-0-803b80ee97b4@linutronix.de>
In-Reply-To: <20260114-vdso-header-cleanups-v1-0-803b80ee97b4@linutronix.de>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1768377702; l=796;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=Ko7rOXN2f5vKh19n3ut994p4BW56m9dv4kY+PIvm7Yk=;
 b=PbIRfpWFNk9BAu4/xZnM8LVqwnYh83cMAfcRW7ldaxC8YUzNBltZ6iiaNDxvKbJrUjBSDRKG8
 VF9TendS0JWAdSkvD00Kqbs3zGzzNt5ZkyIFAgLOrROICTue30rPSrW
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

Various used symbols are only visible through transitive includes.
These transitive includes are about to go away.

Explicitly include the necessary headers.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 lib/vdso/getrandom.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/lib/vdso/getrandom.c b/lib/vdso/getrandom.c
index 440f8a6203a6..7e29005aa208 100644
--- a/lib/vdso/getrandom.c
+++ b/lib/vdso/getrandom.c
@@ -7,8 +7,11 @@
 #include <linux/minmax.h>
 #include <vdso/datapage.h>
 #include <vdso/getrandom.h>
+#include <vdso/limits.h>
 #include <vdso/unaligned.h>
+#include <asm/barrier.h>
 #include <asm/vdso/getrandom.h>
+#include <uapi/linux/errno.h>
 #include <uapi/linux/mman.h>
 #include <uapi/linux/random.h>
 

-- 
2.52.0


