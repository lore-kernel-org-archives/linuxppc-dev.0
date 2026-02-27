Return-Path: <linuxppc-dev+bounces-17349-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36ED3FD4601
	for <linuxppc-dev@archiver.kernel.org>; Fri, 27 Feb 2026 06:46:46 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fMf2d6tfCz3cQq;
	Fri, 27 Feb 2026 17:44:57 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=193.142.43.55
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1772174697;
	cv=none; b=QeQIvrzLoPTpRchCtza6Jq7JBjt4uDhrFINviUiuWL9dR7fIvnLESD3NgoavIZSfKh4rXtI6txuIW8rurlbcV8935k/1DqOzXZ7WcpaDaURlHRLfE4C+/VanajBMhC7LKdIjo0NtDZgDj4lrFj6tCr+NY/njFqA5NcjBxgE+VXvMJZuZ2nDsXCaKZuzkHwrBeHvNwFg/eO8B3dmPm5dG7TNkduCXLwxBEgLigRgt/TUEsCbR40BaXX/imQ2aPkNKOA4mMmd0GS8hTt86GzYXEIMQYmbheXJXBsZnNq/IVgORgzgVdJXkMDVw/aimxMPCqY/zjn97W2iAaj40mBDkMA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1772174697; c=relaxed/relaxed;
	bh=X0EBIBm5jNpd3KIuLGszq3PazACWdDvXzo0/uNY329I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=A+lhsBz/+it6rM8WQP+9k0VejI9VuVSUtp9TJXCFx2AbMhZs1la+iUjxRRnrfmQOVSZ1/HOZLul56QJalaKX1NrQ/kBRATYxP/zYCy24lFfbh5AeeEoYHNAI/+7My7LVolYgy48aKk/zdo2z6JtC0IKUk1ElHXmPMAmJLeRlADh4oMzDCLbwdsYdBLDMX+W0Dd4lyIB+oQFbaKGzpDJM86z+gCKzUrNGFBDs/pwfvrHOFwv+B6xdTaIs5U60oi4pTBIED+lzszaaupa/y0VxGsaqDH/QWl6ydWY5S6+m5HEwbu88oqNmRRhUfib4hCji4OWxt8DA5NqpUD3L4X251w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; dkim=pass (2048-bit key; secure) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=Vw0vB8om; dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=rjQkLIGR; dkim-atps=neutral; spf=pass (client-ip=193.142.43.55; helo=galois.linutronix.de; envelope-from=t-8ch@linutronix.de; receiver=lists.ozlabs.org) smtp.mailfrom=linutronix.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=Vw0vB8om;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=rjQkLIGR;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linutronix.de (client-ip=193.142.43.55; helo=galois.linutronix.de; envelope-from=t-8ch@linutronix.de; receiver=lists.ozlabs.org)
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fMf2d3MBTz3cQM
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Feb 2026 17:44:57 +1100 (AEDT)
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1772174688;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=X0EBIBm5jNpd3KIuLGszq3PazACWdDvXzo0/uNY329I=;
	b=Vw0vB8omZo7n15kO9jm6LrTkJPZPCyTUp7BYuIRcalRbmVrerP//B/YrsO/bVuRC8udPiT
	Tx4WT5VQ9gY7wC/GaUR2JbK6RKmJ/hwVpyjbBNGyQSn0ma2Vy9Pr/7MWbkqQ6z9rfh4347
	VjCtnblV+UrqlbRZID7ZEV25INf4LrJCikRBLY5WEXMADFbC7ADXNK6btC7Jk09vyomdw3
	eN1Yd3OwInZGcay04IFQ0tNnsZeSsJyNQ49cgmhblZox/8R78n8G1ObRfI3QYw1xQLCqpN
	nz3DOXY6/+ZaGAlwr+3V/r/IiWmyhmuAurbhWwGRe8eLBYlAbP/vOFgsklzxbA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1772174688;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=X0EBIBm5jNpd3KIuLGszq3PazACWdDvXzo0/uNY329I=;
	b=rjQkLIGROHanTm4ZQKkRhxB+SoXQ85/KChGEgURGHZRk1xF73Af+heravUg1o4MI3/6Nmb
	ppUZ97iYyiOwdNCQ==
Date: Fri, 27 Feb 2026 07:44:37 +0100
Subject: [PATCH v2 11/15] vdso/helpers: Explicitly include vdso/processor.h
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
Message-Id: <20260227-vdso-header-cleanups-v2-11-35d60acf7410@linutronix.de>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1772174681; l=694;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=ksAvbNu4g6GEEgEwDE4RqU2Mb+uIs9kO6obM62gGDDM=;
 b=jfMCxjTvNN6/pYy+fIWrmEt0awSdB/wvT6klfnssMA8eEwpKV+gbcmPDAhbNs3euCJHVEtrES
 QylTA587HbwCMFzseU3rCypSwUO+LeHxhv6GYUU1xKBFDru1TJ7WJvw
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

The usage of cpu_relax() requires vdso/processor.h. Currently
this header is included transitively, but that transitive inclusion is
about to go away.

Explicitly include the header.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 include/vdso/helpers.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/vdso/helpers.h b/include/vdso/helpers.h
index 1a5ee9d9052c..a1c995af4696 100644
--- a/include/vdso/helpers.h
+++ b/include/vdso/helpers.h
@@ -6,6 +6,7 @@
 
 #include <asm/barrier.h>
 #include <vdso/datapage.h>
+#include <vdso/processor.h>
 
 static __always_inline u32 vdso_read_begin(const struct vdso_clock *vc)
 {

-- 
2.53.0


