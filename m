Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74DFDC77B73
	for <linuxppc-dev@archiver.kernel.org>; Thu, 20 Apr 2023 05:17:55 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Q25X173pzz3fRq
	for <linuxppc-dev@archiver.kernel.org>; Thu, 20 Apr 2023 15:17:53 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au header.a=rsa-sha256 header.s=201909 header.b=Zu+uCCe5;
	dkim-atps=neutral
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Q25VF4KMbz3f4F
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Apr 2023 15:16:21 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au header.a=rsa-sha256 header.s=201909 header.b=Zu+uCCe5;
	dkim-atps=neutral
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4Q25V82vzvz4xD8;
	Thu, 20 Apr 2023 15:16:16 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
	s=201909; t=1681967776;
	bh=p/VPLdj4bxTCistbnu1blNuSyZYIIItEPzdNRMTp0gg=;
	h=From:To:Subject:Date:From;
	b=Zu+uCCe5y3//5G0sFwQ5GQWCy9WNX67h2FK7i9Jh2oDiewwZDGRBWxWdcNOwqIlut
	 wk/EBt9khJZF8Tyjz42q2Jkf+L71eEv6U+9FPKwOy0BZltmAwPxlWLN7DF9q9+cJwh
	 Ztbn2ADg4NIUEgI6hxepam9a2HzA4hgR2fNdr0guySFK5pbBQjUNA3mRhP1rsMH9Rx
	 Xofu6B7+qvvz0E8oJhYkhgYrTcyjphSnJN35TUoJef/odPFifx2cZNtK3zMXQu0Gl1
	 dE+mig8fuG9k9mbu6AQS+7Qs7e1JLhr8xT49+5/HZOpmi3EGTCIQvFbcCs4pYMLr0r
	 arzABKExWG0hw==
From: Michael Ellerman <mpe@ellerman.id.au>
To: <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH 1/2] powerpc/configs/64s: Use EXT4 to mount EXT2 filesystems
Date: Thu, 20 Apr 2023 15:16:08 +1000
Message-Id: <20230420051609.1324201-1-mpe@ellerman.id.au>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev" <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

The ext4 code will mount ext2 filesystems, no need to build in both.

Suggested-by: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/configs/ppc64_defconfig | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/powerpc/configs/ppc64_defconfig b/arch/powerpc/configs/ppc64_defconfig
index a17cb31105e3..2836190448d5 100644
--- a/arch/powerpc/configs/ppc64_defconfig
+++ b/arch/powerpc/configs/ppc64_defconfig
@@ -319,10 +319,6 @@ CONFIG_VIRTIO_BALLOON=m
 CONFIG_VHOST_NET=m
 CONFIG_RAS=y
 CONFIG_LIBNVDIMM=y
-CONFIG_EXT2_FS=y
-CONFIG_EXT2_FS_XATTR=y
-CONFIG_EXT2_FS_POSIX_ACL=y
-CONFIG_EXT2_FS_SECURITY=y
 CONFIG_EXT4_FS=y
 CONFIG_EXT4_FS_POSIX_ACL=y
 CONFIG_EXT4_FS_SECURITY=y
-- 
2.39.2

