Return-Path: <linuxppc-dev+bounces-17341-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C649FD9E34
	for <linuxppc-dev@archiver.kernel.org>; Fri, 27 Feb 2026 06:45:36 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fMf2Y5NL2z3cGD;
	Fri, 27 Feb 2026 17:44:53 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=193.142.43.55
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1772174693;
	cv=none; b=lf/X/unAImuP2ILBndcgpa8lDtOPMPNxxE4V5QMVpcmNfTrq2Fp6nrN+++O2txRd4QIOcCm5lGxLOY4R5u8jGLtGC25KOeeGP0+LTCs3L0uUAODlDNQ+JaSopaS87ZKKfhROtLGYzFOtdHbRhvraqQ2l7bo3suXw7iriJv1da9QajhHN3KrHj/DDvX/XcWt1vIP7t5DfYWdWDN0HQKqelGqfNsUD+spxdO74UQAF9Rv5GsU+ncsxbLG4XaWLd7hCcdVlGzK4C4zXJfknxQVxjwgIkSYDKeAV0OybYmM77InVWBbrCjH91P92u+QC99c2HUhT0j2RLF2FYWA+9mVTiw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1772174693; c=relaxed/relaxed;
	bh=Ns/5VchQVCZoKSPGG69oVFKcL4Adw7WpxEQJ3c/B2CA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RGI1pJUmoHhxY5PJFAS7OpGGRuKXdGP7KntRp1Oi0FGU+mcdINAbqE0L1W1x9aKmPT8Mmz79kgC5YKxiCoRsTnXM6qTSpysb76itwu2gUR+doubktWC05Ub2XWeWbMFuoWxJkJGR/XAUhZIMMetqSxZai9clYRa/Pn0J5NhiRpxnVGrp24hdkrynItkeacoN14xYv1TVt7D7g/qW+/kOZns6EYZCRLiikft3lNjQ0U87MJPoUApbdx8RjMf20UREeSTpizStU+rlbkaZvXEMgn3QCv+7nzT64Rki8LcpxVELCeUGvhKbcq52hBjdlETsPntTxTOQ3CqFWbnl95Qkpw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; dkim=pass (2048-bit key; secure) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=JCmZPwYW; dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=Q34qgHOe; dkim-atps=neutral; spf=pass (client-ip=193.142.43.55; helo=galois.linutronix.de; envelope-from=t-8ch@linutronix.de; receiver=lists.ozlabs.org) smtp.mailfrom=linutronix.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=JCmZPwYW;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=Q34qgHOe;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linutronix.de (client-ip=193.142.43.55; helo=galois.linutronix.de; envelope-from=t-8ch@linutronix.de; receiver=lists.ozlabs.org)
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fMf2Y1ywPz3cFm
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Feb 2026 17:44:53 +1100 (AEDT)
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1772174690;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ns/5VchQVCZoKSPGG69oVFKcL4Adw7WpxEQJ3c/B2CA=;
	b=JCmZPwYWDYToRyEQ9DR8fipEF/ULgK3B4oVRwWHLTcekFqTViMl2N/xXKz75LI5l1qr47j
	xPn9Rsn34YLZ/KdRp9IL3X+UgseOAA5Gw6UEoQYdfwz22lZl80Tfblc0sChWc6GBpsZI/X
	Ivbxyk0MeuNL2Juh5AUY+wlHXIUtLd1baIIerKeCUAi1yXNMPRPS+IZHAI98jUrgizIzOK
	8qin9uAxtsCYs1UsSNa2TBL3GgFusppXtMq5HGGPhOSMssvIQimvH+lscXk9wHq0CMgdSQ
	WTXWmZ1XohrP5u+BH2H+6HxknCbr+MJ/OBBBGUtbq9JrnV/R54GXj7ZL1/ouHg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1772174690;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ns/5VchQVCZoKSPGG69oVFKcL4Adw7WpxEQJ3c/B2CA=;
	b=Q34qgHOeSxFo3Ifozm8ShqwF2m6jrAUnaadKtDXG3hehTabXwbDdCf5WWlUypCd06X0U2E
	lxTt7rcOT8SLyJAg==
Date: Fri, 27 Feb 2026 07:44:40 +0100
Subject: [PATCH v2 14/15] random: vDSO: trim vDSO includes
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
Message-Id: <20260227-vdso-header-cleanups-v2-14-35d60acf7410@linutronix.de>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1772174681; l=674;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=kYG/ybqKszLJuacxc6F+IgigSyzq9bc/Tf+cZR6TFzc=;
 b=hRsrMQVPxwKxWQngl7rDhlf+sNF1zn7pg7IIBz8oApCVJ13R3dYi+fdcB1s31dvzbU6Sx8f15
 IpdV9+rftWEARi2FlzZ45wcpJn7tR73aFc0r+30IO7QgRivY2an1P9j
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

These includes are not used, remove them.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
Reviewed-by: Jason A. Donenfeld <Jason@zx2c4.com>
---
 drivers/char/random.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/char/random.c b/drivers/char/random.c
index dcd002e1b890..9738673018f3 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -57,9 +57,7 @@
 #include <crypto/chacha.h>
 #include <crypto/blake2s.h>
 #ifdef CONFIG_VDSO_GETRANDOM
-#include <vdso/getrandom.h>
 #include <vdso/datapage.h>
-#include <vdso/vsyscall.h>
 #endif
 #include <asm/archrandom.h>
 #include <asm/processor.h>

-- 
2.53.0


