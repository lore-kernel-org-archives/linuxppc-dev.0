Return-Path: <linuxppc-dev+bounces-17338-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 219D2FD9E34
	for <linuxppc-dev@archiver.kernel.org>; Fri, 27 Feb 2026 06:45:17 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fMf2V0MY0z2yFQ;
	Fri, 27 Feb 2026 17:44:50 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=193.142.43.55
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1772174690;
	cv=none; b=Q3VhofDgidlTe8giKrUnGyzQueO6Ll3KU3s1gtIIyKr2DtmAbe7S/Toua0UmLjrzGe0Ub/9lmM6HCjFU+iLLx9wTqRkLoYEckRp4APi/BJ6dXmcqQZTGD36BIhbnLBuJKbQNn8/lLnLNr9YqtsXpCKAjygX0EFKOWASN4OHvzvQGxgvTUln2CvlR91SsuE+hgtdIKCXaGnV7TR5cZhU+ZcFLZZKDg3mxEDmntn8zoKqlW+DA/oSfCmqDD+sY36JvBXjW6gfCVSV8c6TgePtq4JK8PJtuQWYdUoTnwccNlm+NRCrFSvRtHSUnlxPg0/0SMQs3cciDjVBb5bWUPQfinA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1772174690; c=relaxed/relaxed;
	bh=XmucPrbDNMsefUcsKOtEJFfiebQUYcBxKvPhHkOrNBw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AJHPCKWgdXIHno22ufxd+EOu2qZIluqBYRja7CNFYqzqSIUm6smTaQrwrbBwGWdTM8zNX2CnjBDJsmNWmuowXKdTO47yI2Mlor+iGkdVEvzLBoo41w56nujKDhxn5so5T8DRI4yTozG7yfxXBYrgct+9lY+2wdqMrBS0UAwhcDvmkswb69DSiTWno5vqDagiYWXJZTUkpHqlQrwKinOliy3n4NH++JNwt/w0i1MzFFAeeZ3PZdyN4Nr/V0WjW8GwAxwHDnC0GrntZVrMu//Y7VcBUx3ZIxpDCvUVhNJuc+5knMAHBAodbF2V7fl4giNCv2ofY+WwTKtsfWpg+mV27g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; dkim=pass (2048-bit key; secure) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=JnWzCg7D; dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=tHlKNh6w; dkim-atps=neutral; spf=pass (client-ip=193.142.43.55; helo=galois.linutronix.de; envelope-from=t-8ch@linutronix.de; receiver=lists.ozlabs.org) smtp.mailfrom=linutronix.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=JnWzCg7D;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=tHlKNh6w;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linutronix.de (client-ip=193.142.43.55; helo=galois.linutronix.de; envelope-from=t-8ch@linutronix.de; receiver=lists.ozlabs.org)
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fMf2T412Bz2xKh
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Feb 2026 17:44:49 +1100 (AEDT)
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1772174684;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XmucPrbDNMsefUcsKOtEJFfiebQUYcBxKvPhHkOrNBw=;
	b=JnWzCg7DEKYV2bv5K6E3fL2KDMQNza16vhQQfVP9nF3iJ/IoUaCDlBDz/d70U96JL4bnVy
	FjwNJ9HQBFViBxVX1Gf7tt25uFpAoDTwROf+MbHrNcMSCO2BKHTCiQ4FDqgpqOCTQFrdvf
	mGFzCCzjqfkLAEB+zSGT49adTuUHlugoT/PoXH4w67QEc3b3R9T1OWTP5SBlly1FzZ6+j8
	VQwAmWJkDUJaNh8453C/m5M/+IY2xg1jbnSi6PezuKdBjZ29sBF1qsT0JlbnUo664I0cGP
	okw1YIVfE58WIO6J75t6Hq77Do+5U/qzPqrwmdKbX0dTaMNdCohQ6L7r3AdNcg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1772174684;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XmucPrbDNMsefUcsKOtEJFfiebQUYcBxKvPhHkOrNBw=;
	b=tHlKNh6wS5kvkLXvS6aQz/UTvClSXPsl2MOfkm2W3fc7sbbFTwrKKMB7iR+WUCpFSo/B4Z
	EWK+/op+KpFGrVCQ==
Date: Fri, 27 Feb 2026 07:44:31 +0100
Subject: [PATCH v2 05/15] powerpc/vdso: Explicitly include asm/cputable.h
 and asm/feature-fixups.h
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
Message-Id: <20260227-vdso-header-cleanups-v2-5-35d60acf7410@linutronix.de>
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
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>, 
 Christophe Leroy <chleroy@kernel.org>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1772174681; l=993;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=MsK41lHUHc/yAdslHPs0q9i5ib5Ft1iliGOxwDrf3Kg=;
 b=TfyA4IzI496eXTs3L/06kAAhPp3mHtun65YNoMVIs2Yhuq39YNDXrVKmQsQU6Y4LdaAnU2PQ0
 aCTV6rcrMRYADzKJ1REKA2yV8qrugygffNHq4VkMModR+niBGWTNBiB
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

The usage of ASM_FTR_IFCLR(CPU_TR_ARCH_31) requires asm/cputable.h and
asm/feature-fixups.h. Currently these headers are included transitively,
but that transitive inclusion is about to go away.

Explicitly include the headers.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
Reviewed-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/include/asm/vdso/processor.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/powerpc/include/asm/vdso/processor.h b/arch/powerpc/include/asm/vdso/processor.h
index c1f3d7aaf3ee..4c6802c3a580 100644
--- a/arch/powerpc/include/asm/vdso/processor.h
+++ b/arch/powerpc/include/asm/vdso/processor.h
@@ -4,6 +4,9 @@
 
 #ifndef __ASSEMBLER__
 
+#include <asm/cputable.h>
+#include <asm/feature-fixups.h>
+
 /* Macros for adjusting thread priority (hardware multi-threading) */
 #ifdef CONFIG_PPC64
 #define HMT_very_low()		asm volatile("or 31, 31, 31	# very low priority")

-- 
2.53.0


