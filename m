Return-Path: <linuxppc-dev+bounces-17345-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C584FD4601
	for <linuxppc-dev@archiver.kernel.org>; Fri, 27 Feb 2026 06:46:02 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fMf2b3yGqz3cLR;
	Fri, 27 Feb 2026 17:44:55 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=193.142.43.55
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1772174695;
	cv=none; b=hAFEoPk3k5AmOLWb1fPx9+8OjwREVCRzP9T/KWLr9z4OqUntnKg/ENg71AxWzqxafVP/R662aYltHJ6I+B8KVSnDsOOlso2WY3u173/9bfQsjGdXHamvY3xuP6oDNVV1OB9iVtjQy6VBOrWc8zoDRTAmImIdpb6VYSVoEaeaBrp49Ljp4TYsZMz39Eo3ZAhgklM+vy1J8NEp00kKVLIkHXflboR1f96hX1iR6aA2otpDqnB0dFT/EgmAn0R+AEfdCbxgCgHILXoqN/gMjLowuzTDsvsXdFCPhMSnvmPD+7BzI9aphxdA6LUDpDm3KdpsZtda1v8Dw0zqKJg5B62gjg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1772174695; c=relaxed/relaxed;
	bh=NLji6Amx+w4gkoyKP87sApLv4hbvr/R4BbROA9mF7Qw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jEYv8LlKAIDCqE5RDtIj1/w368HlOO26Pas/kXEid9Sx/q+uhzzG9A6TlHNlOmIUGi9ui9dBH4PxXrnP9ivoTfxXr7lztwMZ+ts2bCUzQgrihKDLNsXDJocteZJZAmCNW1uPj/Yu1O6KgPNgYjcKcoofVJJRF/ebxHs34YCaf1BZihoKmkPCMIqoFfbF0vkt1b3QR/duC1uzI9aXR670+IEXrF9X2Pe0K7KXXfAUHzptY54pVA7HC8DsxfQuElrOH/lCazy1yJyCN6/b4/87woBFi/+VHvGmtuj4JXob4EIP+dtUTC3ZpcQtPUbTEzEa8olnSQt3OtPWxED8Mdxe3g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; dkim=pass (2048-bit key; secure) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=dCLNqQkf; dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=eVLtN9AW; dkim-atps=neutral; spf=pass (client-ip=193.142.43.55; helo=galois.linutronix.de; envelope-from=t-8ch@linutronix.de; receiver=lists.ozlabs.org) smtp.mailfrom=linutronix.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=dCLNqQkf;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=eVLtN9AW;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linutronix.de (client-ip=193.142.43.55; helo=galois.linutronix.de; envelope-from=t-8ch@linutronix.de; receiver=lists.ozlabs.org)
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fMf2Z3qy8z3cJ9
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Feb 2026 17:44:54 +1100 (AEDT)
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1772174686;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NLji6Amx+w4gkoyKP87sApLv4hbvr/R4BbROA9mF7Qw=;
	b=dCLNqQkfH1i//wSvIpnoq3xDDTzR2xeibPPMp/z9eZz64hGWimn0Lzumwy5pZBFei6FZLf
	G1v7mQUgTptwXQOorAhU4ZJk6uoK4C6efBUGJuSSMAW+9LwDA65lAhe7BLSk1GcozF7A+h
	ZlAAYWN/CSrxWHeMBVbf0yTx1gerVfh7lptz5Ry5V2dWHSqH2M2TME6HCKkyYogti0sP2G
	P6tZEdTPnz+Ch4F3lgRI/UyLbXCV97/qFf8eP3ybFVgQsdVbUJOJHabtbAoOaVU3QyEflS
	7DG9IaKYRC6xXbioku99cIA+Ibmq04T5oJ9d97OkF/WEyLWHLQ4myVt0QjtBUA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1772174686;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NLji6Amx+w4gkoyKP87sApLv4hbvr/R4BbROA9mF7Qw=;
	b=eVLtN9AWbevcPEHUTybrUg+PUlahm/LpMjWb5A6zQ6iJSsUcLh5Op7xSCyS6qNu2Uawows
	K8JJTt0JPIDm1MBg==
Date: Fri, 27 Feb 2026 07:44:35 +0100
Subject: [PATCH v2 09/15] random: vDSO: add explicit includes
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
Message-Id: <20260227-vdso-header-cleanups-v2-9-35d60acf7410@linutronix.de>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1772174681; l=844;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=JcvE3kQiMg07X05oSReGQNnDSkDG6pLjGh3SaRJFDSk=;
 b=RZXvHH2HxCYtijPWzFmGuHR3sRa73ICHOAJnT8sgpwEldcg8giFkj0QCEeXbaQyeRwjE8NIZG
 3G4L52NK7P+AtsNoMk77ybqM5aiSaWAXCceP66bohc97O91JdCE0VU8
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

Various used symbols are only visible through transitive includes.
These transitive includes are about to go away.

Explicitly include the necessary headers.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
Acked-by: Jason A. Donenfeld <Jason@zx2c4.com>
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
2.53.0


