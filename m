Return-Path: <linuxppc-dev+bounces-17351-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7199FFD4601
	for <linuxppc-dev@archiver.kernel.org>; Fri, 27 Feb 2026 06:54:56 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fMfG66ffcz2xLv;
	Fri, 27 Feb 2026 17:54:54 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a0a:51c0:0:12e:550::1"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1772175294;
	cv=none; b=d6ZIT3jx70Z7rmCaNFUTXeKGww8NShBmk8Cfy/2SzWNdQKmJCt8aOTVaGOy8lvowrIA8rtuM5CqgS38Umpcz4GlvT2nQGCnevZDKYYedItkL7Wfekvx/pOe7iUmAfYn5G/+OCJVlVhHhH4ejXFtCxfY1XnQtyH2IKWPjPn+kayhfQeQ1JJlj4w5vejgZO2P7fEHErRLyRLXxbgI9/hwXlE5bJuiiDCIkd9VXDAB9Gr8gCe9vqKQDfr1M308BMMPekO7BfJsJvGo3u20rDTnjyUO8rx/je0wfIKUAmwgrFi0xUYjHgl5OWLDRfie3+lZXlTA6TfdQ36kr0CH8z54iOw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1772175294; c=relaxed/relaxed;
	bh=NYU2DjWIvo/s2zAJBv/B2HsELMqSCe9+by7E9gQC1/M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=ZEF8QeP/0XpFCyTtdY9sPn+lgYYi3XwcL5FTEFyDMNDb1DIShJnZgGLBRpFebTiZ6OUp2VH19PhDp5hfLE8UzpbtZeCycLADoMzYOecPty/kp/uvAX/+iFio2R7MToarlUs7e9OVetgrohbOs6SqvNrsqCMTErKiC44M3zwS8NMiTPwWYElYsQsR6iP/nNnVPZ4AXf4VnG44PmCyN7FSYFv0MTi+kcXmuChSKmetTHCUeoiJ1c9dq8b1xUcO+CBCn/QartUWj5+VcMreuMYt5Vb4W0nT/jjgsrAbdStcPnwHP+/kzCM5WaKD/o+7DKZLr1oZJL9vBFrrGPAC8rtVBg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; dkim=pass (2048-bit key; secure) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=zqCtK5Zu; dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=EwUlFhki; dkim-atps=neutral; spf=pass (client-ip=2a0a:51c0:0:12e:550::1; helo=galois.linutronix.de; envelope-from=t-8ch@linutronix.de; receiver=lists.ozlabs.org) smtp.mailfrom=linutronix.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=zqCtK5Zu;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=EwUlFhki;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linutronix.de (client-ip=2a0a:51c0:0:12e:550::1; helo=galois.linutronix.de; envelope-from=t-8ch@linutronix.de; receiver=lists.ozlabs.org)
X-Greylist: delayed 602 seconds by postgrey-1.37 at boromir; Fri, 27 Feb 2026 17:54:52 AEDT
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fMfG43ygpz2xKh
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Feb 2026 17:54:52 +1100 (AEDT)
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1772175288;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=NYU2DjWIvo/s2zAJBv/B2HsELMqSCe9+by7E9gQC1/M=;
	b=zqCtK5Zug38lALa1rDaX4rXov8yi0xleLfTP/Nn4hfLXb8yDFrjoRndvLJFHVquqsoFUNx
	ZklTmvg1YYYCVP3Ms+CyZyNNncFjbMU4YAjtXtu9tDGAVIY62piCYh6x9xobvKFJRRRkSB
	HKkaNO9hDCvBZ4y7/nVE6+ixU83YPvJd0k37zT45bEytH2N/wPDuTBlnSr+u9jRNzrRpSF
	XoyJ3P1OfwR90IQy4STigmN6+bHk3rhmcyWudJHu3yAzuzOqGsmY1jSuUQkZX9NvkW0vbB
	Bsgr67LnUgOfaqxWnY8yQlEkw3iVoOmri5SyVcHgP/Ji7wbp5sBNJxdNRaMZpQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1772175288;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=NYU2DjWIvo/s2zAJBv/B2HsELMqSCe9+by7E9gQC1/M=;
	b=EwUlFhkia9zD/URLV1OXQqVzNJ+xebzIlkbqTkKVmX0eZAECbf9yMxPP/n4hdp8AiJPIzG
	RmaDJT0KpQDfxFBw==
Date: Fri, 27 Feb 2026 07:54:46 +0100
Subject: [PATCH v2] powerpc: Implement ARCH_HAS_CC_CAN_LINK
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
Message-Id: <20260227-cc-can-link-powerpc-v2-1-7690e8030ea2@linutronix.de>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/22NwQ6CMBBEf4X07Bq6CAFP/ofhAN2tbDQtaRExh
 H+3Eo8e30zmzaoiB+GoztmqAs8SxbsEeMiUGTp3YxBKrDDHUiMiGAOmc/AQd4fRvziMBkoiwlP
 VWCp7lZZjYCvLbr22iQeJkw/v/WTW3/TnK/K/vlmDhhqxqclWXPT2kurnFLyT5Uis2m3bPmUkr
 Zm6AAAA
X-Change-ID: 20251222-cc-can-link-powerpc-5ddd2469fd5b
To: Madhavan Srinivasan <maddy@linux.ibm.com>, 
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1772175287; l=1975;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=fi5JLAbOTl/+1Nk3gJx/MoRlnQFDtzWfQs1ISlV2qGU=;
 b=110tPJbd42OCVbDCmek+mzfdMZ88CUZNMgvUD6PZf3Qj4/IakaahKSpyZAYvOeHW/TFITHV+/
 vjoRx7N/AHeBVZLUMnc6XeBankB5q2WrpV0SsePxtZjh3RzIp1wyeeS
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


