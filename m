Return-Path: <linuxppc-dev+bounces-17342-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 757AEFD4601
	for <linuxppc-dev@archiver.kernel.org>; Fri, 27 Feb 2026 06:45:45 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fMf2Z2vbGz3cHS;
	Fri, 27 Feb 2026 17:44:54 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=193.142.43.55
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1772174694;
	cv=none; b=mZPiajeG/i8R5Yy4xS0Kk/3S5hgmjOOqzZMnGRHAvA0DJ61WSzrSrCu92Uo55sFSYbYfBDw+lL+gv+U5kBrvK+t4e/rmtwHLE0goEm54FdzPZCIKvx5QN3Xp9MTKp2lMe9EFAKGH2cQMqZ3svCuOiJj4JLlQcyntlbTAKX2ZcTjtynqql0QxUDy7YI1OSKvvVqUqYOKLg5f+Hne+BYhOTfbYy8P4qVnFniqJVVOVHba+N8NLsAenVnX7O320RH0H7QLFTwVj4F9zQp+dUcdb4VMcTYr+bo9lHzVWdaE1hWW1gxRF/A1ShqxKxba9v2itAMlgCCkg6UZ0wB0gK1DXWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1772174694; c=relaxed/relaxed;
	bh=AXZyqVV/pMt5wKYLJiKaZoCB+y3yJrXNlKmlMnaEA8o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DnaeqtkqMU9DXtND4EPT0Y8g/C0vZieukAY1zMLvRpi+1q+HnZkn/FLCSMp8++crMzbdleDEihbw2YaNTC009tPmwl2KFf7SVqn1nIurw8mkHEBlv6NbidXUGW7Pyf5afuCyq+g6xnbumwtUUtzpjKYRlp1S79DoUpvY5qajrJnoT1BMFF2HmcDLzxtH565pX8mtJB3PKoclhjARBN7Ro1YJWDe/MZFCyxgqhCJdghmNwRCuXPnTpmXCmMdsHvjY20keUTRPe60XvgwwVeo3KED6MsCfMk+9ON3OW5WknL4ZD3Dp6n7wbcfO9khJC8h91CgyMUNL+P2Jj2lwe3fA8g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; dkim=pass (2048-bit key; secure) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=tkqZ9rhb; dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=hXEle++t; dkim-atps=neutral; spf=pass (client-ip=193.142.43.55; helo=galois.linutronix.de; envelope-from=t-8ch@linutronix.de; receiver=lists.ozlabs.org) smtp.mailfrom=linutronix.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=tkqZ9rhb;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=hXEle++t;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linutronix.de (client-ip=193.142.43.55; helo=galois.linutronix.de; envelope-from=t-8ch@linutronix.de; receiver=lists.ozlabs.org)
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fMf2Y5TfXz3cGK
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Feb 2026 17:44:53 +1100 (AEDT)
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1772174685;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AXZyqVV/pMt5wKYLJiKaZoCB+y3yJrXNlKmlMnaEA8o=;
	b=tkqZ9rhbKjYApCzfhBHJzZhvbJUPCq512TRlMzVk6w7ITzco+9byAp7TtN93I0XUkelFfA
	lQWZn/gzvfm3gYMwt6ettiIUOeqasaCkiN/ZKbYEZ4KCE70yS3jdsGoI23xWBZY++Djehs
	crQHrmRIW4CBQBTdb0QNPpPxkXLnV2vyW83wvBh5UzbJz2uKEXOCTSTaiz/DgJXJhX6K3V
	NeQLZtCvNuqazzkc5K6HLwquAvJhHL+0oCouh9QluOryQhfVfD9Z+cEs06uXjIZTNCJaW5
	lkeLCgyePSK6rfawiyGgps0f/zdw265IzuyNeMvTZh22SdqBLyultTKRFs3ZiA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1772174685;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AXZyqVV/pMt5wKYLJiKaZoCB+y3yJrXNlKmlMnaEA8o=;
	b=hXEle++todjBCvkYkPp94pUXH9hqZA30TxNyJxQI3vtgT13T+EJKvoaKA+thvBTypfIkWY
	/PNgqssH6mf/Q0CA==
Date: Fri, 27 Feb 2026 07:44:33 +0100
Subject: [PATCH v2 07/15] MIPS: vdso: Add include guard to asm/vdso/vdso.h
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
Message-Id: <20260227-vdso-header-cleanups-v2-7-35d60acf7410@linutronix.de>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1772174681; l=915;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=96wQsD0ohJOJ5ijGqVXkm6xOH7JrZVn4eDcYG0UPpAQ=;
 b=LwFitQ8PqQr5rpEJ5g+EpBJZFxWGmzMUFGuk60InI5VlUjGXxMTUa4LNiy9hbyTrE25+X7KRK
 4q1m70THNmBBvaHqnKgOL71CUgZtvfvm5zCIi9lEZ/tlWUwOgrbj1oR
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

An upcomming patch will lead to the header file being included multiple
times from the same source file.

Add an include guard so this is possible.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 arch/mips/include/asm/vdso/vdso.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/mips/include/asm/vdso/vdso.h b/arch/mips/include/asm/vdso/vdso.h
index 6889e0f2e5db..ef50d33f3439 100644
--- a/arch/mips/include/asm/vdso/vdso.h
+++ b/arch/mips/include/asm/vdso/vdso.h
@@ -4,6 +4,9 @@
  * Author: Alex Smith <alex.smith@imgtec.com>
  */
 
+#ifndef __ASM_VDSO_VDSO_H
+#define __ASM_VDSO_VDSO_H
+
 #include <asm/sgidefs.h>
 #include <vdso/page.h>
 
@@ -70,3 +73,5 @@ static inline void __iomem *get_gic(const struct vdso_time_data *data)
 #endif /* CONFIG_CLKSRC_MIPS_GIC */
 
 #endif /* __ASSEMBLER__ */
+
+#endif /* __ASM_VDSO_VDSO_H */

-- 
2.53.0


