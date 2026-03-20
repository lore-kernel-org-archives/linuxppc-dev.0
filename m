Return-Path: <linuxppc-dev+bounces-18526-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B271F1099B30
	for <linuxppc-dev@archiver.kernel.org>; Fri, 20 Mar 2026 20:50:26 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fcvpT00zHz2yZ6;
	Sat, 21 Mar 2026 07:50:25 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a01:4f8:c010:41de::1"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774039824;
	cv=none; b=FbDapbdzRmb3PHI/Od9yCRESeD1gGxqK8YYxVrE+d2Y+pJEurUH1VWlQqIyzPizsqIqVhJpbYHyqkrf6xtEMeVzyMCEKz0u5Kav6k9EaigWHJGYC/2iH/bKLutudSxWmmJowq4KSffhufxmZwf4nm9xOiCO8+osdURK0BMdHlLa200xrMfSNPMWvWCi3COE/gMSn7Q4Y5zVGhtIQ6ID71yfjzYjBzKv1FEoG0BG+RkTcmhcde7S9dSskLS7wNVUvSyEOKmXSOEVeu6ShUSz+tHAV6w5yk//STHr/HCUcjaD1eEv4UokAgBNsdhEqrw7wNzEFL72rgngJig+7oPnY8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774039824; c=relaxed/relaxed;
	bh=OWQoYRWLsJb492Aoj5nYDrlLPL430gY409sctbD/CA4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=hmp86vjslFKeCgIw0+Xmh6ZiS16wN2AkZe7iv5ejTDyXY0e7uxdYzs7z90C0B9SlN5nIS1OT0u3gIF0qtOyqkWeFkDn3EAZdLPRNX+vIValzd4w0TMp1OlLIG9kKFqEjZ8p2UXATwym28qpI7fcWZWzJuCXFD4KlpZWts/3lKf/781Eu0irxxC1WTOu538U2xUbaD/m3t01ev+fQLLygRgI8Rz9OtGSbsmlcPv2+b3zrqQMF+o9+y/DapwoOIem/pI41EgH5msO8fVDi4jWiX7mN5rE6xJaNwWLVS6uaGHa1UxgZ9aCE/GGNmDLLuZOPtSMvl1F3oiY5GFfdBcI4uw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; dkim=pass (1024-bit key; unprotected) header.d=weissschuh.net header.i=@weissschuh.net header.a=rsa-sha256 header.s=mail header.b=FJok0OPg; dkim-atps=neutral; spf=pass (client-ip=2a01:4f8:c010:41de::1; helo=todd.t-8ch.de; envelope-from=linux@weissschuh.net; receiver=lists.ozlabs.org) smtp.mailfrom=weissschuh.net
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=weissschuh.net header.i=@weissschuh.net header.a=rsa-sha256 header.s=mail header.b=FJok0OPg;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=weissschuh.net (client-ip=2a01:4f8:c010:41de::1; helo=todd.t-8ch.de; envelope-from=linux@weissschuh.net; receiver=lists.ozlabs.org)
Received: from todd.t-8ch.de (todd.t-8ch.de [IPv6:2a01:4f8:c010:41de::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fcvpR3mllz2yY1
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 21 Mar 2026 07:50:22 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1774039812;
	bh=8PFnTjoeCdaQIzaeUgE2p/MqLReT53S2EKPioRaW2kI=;
	h=From:Date:Subject:To:Cc:From;
	b=FJok0OPgtw/1uInl1wkPWa+XkR1Ku+NkoAFifRO5O7j3ZjAT8sYAj6oSOY40sCSWO
	 Rn7y65eYiiadAdThBbfE6eL2qahqtGRoamyOQeQFhlWXERmE6SqKDxI4V3y9hb9U6w
	 Rxk19KmudL8Mx8EW2X75B6N5eBYYos0KHwoKsysw=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Fri, 20 Mar 2026 21:50:03 +0100
Subject: [PATCH] powerpc/vdso: Add support for unstripped vDSO installation
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
Message-Id: <20260320-powerpc-vdso-install-v1-1-b4b551689709@weissschuh.net>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x3MQQqAIBBA0avErBtIk4yuEi2kxhoIFScqiO6et
 HyL/x8QykwCQ/VAppOFYyhQdQXz5sJKyEsx6EZ3Tat6TPGinGY8F4nIQQ6379gba0zrrVXaQ0l
 TJs/3vx2n9/0AMFhMoWYAAAA=
X-Change-ID: 20260318-powerpc-vdso-install-847443f7712f
To: Madhavan Srinivasan <maddy@linux.ibm.com>, 
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1774039811; l=1324;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=8PFnTjoeCdaQIzaeUgE2p/MqLReT53S2EKPioRaW2kI=;
 b=mV1D0V34eVAkFnvXv3kYiNv+PtMKIy429nG9IwbkYtRe/VfoFoC5BN+SzUiMrdYCqQO0qFsZE
 IITkXUuq3LOAPljz/stTeCwSU4rBB4wbMJm48qIcagu8hh+ps3Ligo7
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

'make vdso_install' can install the unstripped vDSO files,
so that they can be shipped to the target system for debugging purposes.

Add the necessary variables so this also works on PowerPC.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
Adding a build ID to the vdso with --build-id=sha1 would also make
debugging easier.
And then add powerpc to scripts/Makefile.vdsoinst, or wait for [0].

[0] https://lore.kernel.org/lkml/20260320-kbuild-vdso-install-v1-0-e2e8a0970889@weissschuh.net/
---
 arch/powerpc/Makefile | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/powerpc/Makefile b/arch/powerpc/Makefile
index a58b1029592c..ca25dffc28fb 100644
--- a/arch/powerpc/Makefile
+++ b/arch/powerpc/Makefile
@@ -391,6 +391,10 @@ vdso_prepare: prepare0
 		$(build)=arch/powerpc/kernel/vdso include/generated/vdso64-offsets.h)
 endif
 
+vdso-install-$(CONFIG_PPC32)	+= arch/powerpc/kernel/vdso/vdso32.so.dbg
+vdso-install-$(CONFIG_PPC64)	+= arch/powerpc/kernel/vdso/vdso64.so.dbg
+vdso-install-$(CONFIG_COMPAT)	+= arch/powerpc/kernel/vdso/vdso32.so.dbg
+
 archprepare: checkbin
 
 archheaders:

---
base-commit: 6de23f81a5e08be8fbf5e8d7e9febc72a5b5f27f
change-id: 20260318-powerpc-vdso-install-847443f7712f

Best regards,
-- 
Thomas Weißschuh <linux@weissschuh.net>


