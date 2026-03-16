Return-Path: <linuxppc-dev+bounces-18269-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98BC7F53D6D
	for <linuxppc-dev@archiver.kernel.org>; Mon, 16 Mar 2026 15:47:37 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fZKGv75DCz2yZc;
	Tue, 17 Mar 2026 02:47:35 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a0a:51c0:0:12e:550::1"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773676055;
	cv=none; b=aWTEpmP316wlsryxbKxFReFZDz7ovtpD2avvumveSoeN1fN2HiIaEfQ86P0iadj800JeeDhAwvBOJHXl3hct9dKH7IzjqVpCF/qvy6N0xriVfV7rvH/G/TfH1VPmOyty5cQQ3AkS/IJR0JPwqCDI6Qk2O5eGRnZNnYOwcfcAw/xQKHdf2GcYURvBL5fgFgPp+nBWIiwgWYFz6/HLJ3KFmcth/gq0ml+BOBKCM2FpaK4NUUce7jAW6ZRh6k9CxZdLa4m4hT8IKkXcbbp0HAqh74viYRBKJElc75UufLjyDoYdJS9iy6V8Bld793ZR3Yxfaex0W8a7lS2LVhBCvz5XmA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773676055; c=relaxed/relaxed;
	bh=NYU2DjWIvo/s2zAJBv/B2HsELMqSCe9+by7E9gQC1/M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=TUl0mJ7OzBvuApX3L/nNu6ijpej+6eGgMxgSZ8ztKEtBkyyl09vhg/W2JijT4KnGtw0dTOKWynIzHgKHjTtOvEOMScCnPDGPOF5t9eOddiMdfRFcJZwPFQn+UnrUZdAlVst4pqawro/WImy8RqrJIvk+aRhvEVaHx0498j8DLeSjEwU0ZIRplTA3woU9fJfjRSzrvQ42wtrK+tTOx8XDoI1URhvZnGxUaWJcgnGRaMvMkRnx3AJ3QPCQ2f87Iz1bXLgtnUWlmeAvn8qkcLlcJ48mnOjBDkB41EoxgjaYNBogodnfa4DcbJ42zN2GukUEZ9+jazXGLwUc7NF7JfUWLw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; dkim=pass (2048-bit key; secure) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=pGRFTCw1; dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=eDzGvxxR; dkim-atps=neutral; spf=pass (client-ip=2a0a:51c0:0:12e:550::1; helo=galois.linutronix.de; envelope-from=t-8ch@linutronix.de; receiver=lists.ozlabs.org) smtp.mailfrom=linutronix.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=pGRFTCw1;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=eDzGvxxR;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linutronix.de (client-ip=2a0a:51c0:0:12e:550::1; helo=galois.linutronix.de; envelope-from=t-8ch@linutronix.de; receiver=lists.ozlabs.org)
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fZKGt4Zb6z2xS3
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Mar 2026 02:47:34 +1100 (AEDT)
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1773676044;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=NYU2DjWIvo/s2zAJBv/B2HsELMqSCe9+by7E9gQC1/M=;
	b=pGRFTCw1qX1U1EjlPxvi62RAGXgFa1j0bdwSrWrjgjkb+BCyP8jQ3dvrtoWq740MRgmZlX
	o4w0G4ZuCn8bYGW/5I2F6XYA+SgR/j1wR4n4E3bqAcNa97Jd0LTHEicbqaI8wKf/sl2Egl
	7UNWqbEuR4IRCMcWjZY+Ao8GpURWgnK+215/9oFemF885zloqYueYuMTjxOd8LasuizNE4
	aRDNDXMhAi51aMATGhuA0FRzVmC8DylsXjVtkACCu0zsBBULcXDlM3D8nK4ElgM3Ry6V4T
	tmg27WrEZ7Fe6276PCgXOt97Po2M1x/UT2ca+RGDc+W1iylYpx34sXwJ/bPNQw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1773676044;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=NYU2DjWIvo/s2zAJBv/B2HsELMqSCe9+by7E9gQC1/M=;
	b=eDzGvxxRghHVmyWWP81q9AskhFLwYYWKNNSa9dJIqZ38FRzVRP+ssuydFLDlb8yd3l/pBQ
	ifm9UQeeIHKqy4Cw==
Date: Mon, 16 Mar 2026 16:47:24 +0100
Subject: [PATCH RESEND v2] powerpc: Implement ARCH_HAS_CC_CAN_LINK
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
Message-Id: <20260316-cc-can-link-powerpc-v2-1-17af7cfce88f@linutronix.de>
To: Madhavan Srinivasan <maddy@linux.ibm.com>, 
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1773676044; l=1975;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=fi5JLAbOTl/+1Nk3gJx/MoRlnQFDtzWfQs1ISlV2qGU=;
 b=CjL0tKZwNG8h2luQxdMRaaAJfexb2Adw29ULcbfSlA+DcUjDP4ELrnl1kuZX0V+mcNMPI1Rlu
 POjtXQF2sOGAjNmQ7TCt3O7ZBd+lH0mrk8entk73vtfJteQEt6BMgPx
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

The generic CC_CAN_LINK detection does not handle different byte orders.
This may lead to userprogs which are not actually runnable on the target
kernel.

Use architecture-specific logic supporting byte orders instead.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
Changes in v2:
- Rebase on v7.0-rc1.
- Link to v1: https://lore.kernel.org/r/20251230-cc-can-link-powerpc-v1-1-82298df6e3bf@linutronix.de
---
 arch/powerpc/Kconfig | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index ad7a2fe63a2a..793e6b311143 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -127,6 +127,7 @@ config PPC
 	select ARCH_DMA_DEFAULT_COHERENT	if !NOT_COHERENT_CACHE
 	select ARCH_ENABLE_MEMORY_HOTPLUG
 	select ARCH_ENABLE_MEMORY_HOTREMOVE
+	select ARCH_HAS_CC_CAN_LINK
 	select ARCH_HAS_COPY_MC			if PPC64
 	select ARCH_HAS_CURRENT_STACK_POINTER
 	select ARCH_HAS_DEBUG_VIRTUAL
@@ -1343,6 +1344,20 @@ endif
 config PPC_LIB_RHEAP
 	bool
 
+config ARCH_CC_CAN_LINK
+	bool
+	default $(cc_can_link_user,$(m64-flag) -mlittle-endian) if 64BIT && CPU_LITTLE_ENDIAN
+	default $(cc_can_link_user,$(m64-flag) -mbig-endian) if 64BIT && CPU_BIG_ENDIAN
+	default $(cc_can_link_user,$(m32-flag) -mlittle-endian) if CPU_LITTLE_ENDIAN
+	default $(cc_can_link_user,$(m32-flag) -mbig-endian) if CPU_BIG_ENDIAN
+
+config ARCH_USERFLAGS
+	string
+	default "$(m64-flag) -mlittle-endian" if 64BIT && CPU_LITTLE_ENDIAN
+	default "$(m64-flag) -mbig-endian" if 64BIT && CPU_BIG_ENDIAN
+	default "$(m32-flag) -mlittle-endian" if CPU_LITTLE_ENDIAN
+	default "$(m32-flag) -mbig-endian" if CPU_BIG_ENDIAN
+
 source "arch/powerpc/kvm/Kconfig"
 
 source "kernel/livepatch/Kconfig"

---
base-commit: 6de23f81a5e08be8fbf5e8d7e9febc72a5b5f27f
change-id: 20251222-cc-can-link-powerpc-5ddd2469fd5b

Best regards,
-- 
Thomas Weißschuh <thomas.weissschuh@linutronix.de>


