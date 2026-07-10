Return-Path: <linuxppc-dev+bounces-23994-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DAFCC44501
	for <linuxppc-dev@archiver.kernel.org>; Fri, 10 Jul 2026 06:14:51 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gxM4S0vVPz30Cj;
	Fri, 10 Jul 2026 16:14:48 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a0a:51c0:0:12e:550::1"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783664088;
	cv=none; b=nd8H2AGj+1KPw+w3ZzAS+uDGxVJ7N1aIx1iHc6saEJL75v0QORwBF4Zln4WOllCBTtRnuCwtQal/OyPT+YLTdtPyb+EBuNCqwOxAlbFW067cL7wO+KijiNuP9BiD60iTnfpXpn9ScDJ8a2pBpMZkbsItWVzJGIeen2g739nTrkVi1ydqNQ8H6k5pPBXM9wNJx2KurWFieUumqfbGhYydHwsuVcj1+zoqTkHs/Wrm3LTjf6U8WJ6SIDIVh4leot3RtZFcqZT0xyYyisAnNHMCHye3YJPwt9c+8k4Zma2c2nRIqL5n1VauqqUmEY12jN9r8jC2hHuD5Dns6v4Sz+CawQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783664088; c=relaxed/relaxed;
	bh=lu3+SDN8lxoNjl2dBZxs25rh4Ilkvavn8U5ButRQBxI=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Rc1uwAPpxR+nq11jm4pUdiLxRPNE1DdN7hSALz87QMGd7xGkNdf8ABMlEmFGMwDA5/MwZ9tXNxJARVYABEcNy1gMOpWMQEgqfeF5vhnqcW8pWn3vcciR8CixW4UHOParzKH5KiFNsfGQ30WIRB1hay+gYwe6HK95QV7VFMGFmyfvrCrUSXvO0J3UIiv5izsBKL7svBvdNSH7QQbb8euS78ARbVVX9sjukpGqGipqzVUc3uYAzCr/M7pXsIFrCbIdJ5eJaVC1SJ5MJIO7mg4ee8+zl/JreKlzF9iPNssRuy9+f6/4G2bk9AYitZveSKR/LqWR2+c5Hm8J4e3hCSlfYg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; dkim=pass (2048-bit key; secure) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=KpuEUrN9; dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=1VbPjfbs; dkim-atps=neutral; spf=pass (client-ip=2a0a:51c0:0:12e:550::1; helo=galois.linutronix.de; envelope-from=t-8ch@linutronix.de; receiver=lists.ozlabs.org) smtp.mailfrom=linutronix.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=KpuEUrN9;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=1VbPjfbs;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linutronix.de (client-ip=2a0a:51c0:0:12e:550::1; helo=galois.linutronix.de; envelope-from=t-8ch@linutronix.de; receiver=lists.ozlabs.org)
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gxM4R38T5z2yQH
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Jul 2026 16:14:47 +1000 (AEST)
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1783664078;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=lu3+SDN8lxoNjl2dBZxs25rh4Ilkvavn8U5ButRQBxI=;
	b=KpuEUrN91J7zN1EKzYrkTOTOu73IwH60lkqscXRrvKNkI2ksZW+OISQb8KXHAjoit58ZsL
	xvzORuG1v8SxkGUHBeVboXSLaEMKesbWYRjmHtpaI6rPyMRYxj1omm6fQ/S1j/m+TgQqiA
	V8tJ+T0GW06NLkyC5kV4rPPBaTIssoubWYKbyETEdpvIg+ixz8b2+7FE9j45VunuiYgGVB
	R23y/nnb/nnH8oWTgTJJzIHQONukM3QYOUdHeLXcdHvCYEln5eIvMOAdOTusPuuwWY2odP
	ECeKnG7qkrI/YfsRYNFbGyj9MVtI1qMCE9i9eoT7SL8TYvT1iXxQBK+DZ8yfhg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1783664078;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=lu3+SDN8lxoNjl2dBZxs25rh4Ilkvavn8U5ButRQBxI=;
	b=1VbPjfbsrpCVIK2bqdJYdzdiYRWuKWt69Ys5BHg/U1GEqPlouOIAXA3dwyVZQ036S1fzxU
	+bYvr3/FkoJmxcAg==
Subject: [PATCH 0/2] powerpc/vdso: Debugging improvements
Date: Fri, 10 Jul 2026 08:14:26 +0200
Message-Id: <20260710-powerpc-vdso-install-v1-0-3015af1aa354@linutronix.de>
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
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x3MQQqAIBBA0avErBtIk4yuEi2kxhoIFScqiO6et
 HyL/x8QykwCQ/VAppOFYyhQdQXz5sJKyEsx6EZ3Tat6TPGinGY8F4nIQQ6379gba0zrrVXaQ0l
 TJs/3vx2n9/0AMFhMoWYAAAA=
X-Change-ID: 20260318-powerpc-vdso-install-847443f7712f
To: Madhavan Srinivasan <maddy@linux.ibm.com>, 
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783664073; l=718;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=8wfO4lBwrayFhUsQ4KAf6/honB/+vmhedTvDLIGPJ1Y=;
 b=m9DRLcxv9oiRuW3kcgiyHCPBGUb8urnfAmuWlQaAnhvid8Q/czHzA2bfSyUJOfgttuK27Ksbs
 h0nDKD+4+ukCQHtTYApeXAEu4DjXBkAsGBkZKmb3omLyRbvdv8CQrfX
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

Make it possible to package the vDSO debug information and correlate it
with the vDSO mapped into processes.

Also see https://lore.kernel.org/lkml/20260708-vdso-sysfs-v1-1-fcd93385006d@linutronix.de/

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
Thomas Weißschuh (2):
      powerpc/vdso: Add support for vDSO installation
      powerpc/vdso: Generate build IDs

 arch/powerpc/Makefile             | 3 +++
 arch/powerpc/kernel/vdso/Makefile | 2 +-
 2 files changed, 4 insertions(+), 1 deletion(-)
---
base-commit: e891777067dc42e033906c23c0bd048b09202f49
change-id: 20260318-powerpc-vdso-install-847443f7712f

Best regards,
--  
Thomas Weißschuh <thomas.weissschuh@linutronix.de>


