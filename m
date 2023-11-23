Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B4E7C61D85
	for <linuxppc-dev@archiver.kernel.org>; Thu, 23 Nov 2023 03:30:06 +0000 (UTC)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au header.a=rsa-sha256 header.s=201909 header.b=CB5K01wS;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4SbNsT28ZFz3dSV
	for <linuxppc-dev@archiver.kernel.org>; Thu, 23 Nov 2023 14:30:05 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au header.a=rsa-sha256 header.s=201909 header.b=CB5K01wS;
	dkim-atps=neutral
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4SbNrX3hYWz2ytJ
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Nov 2023 14:29:16 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
	s=201909; t=1700710146;
	bh=Ebo9XJo4gjFkutL1waSQbcM+Zg48V+0DlrLuq/aR8hY=;
	h=From:To:Subject:Date:From;
	b=CB5K01wSItpuEpT00b+xwF7dQDORqW8/3TnP86m7+HkBNtxzpJdh+e24ZEPYyF0yI
	 Gp4uOQ/joWcMGZH0Xa6XepzvqA9E81EPeq9S3eV8ccC+wSxh1yzXmQKLkmwOCggS0I
	 TwnyvrUtDNu6SPju39jeAP8NaUN4MKVwT/K8Nby60PvrEpQ7fWGo7tj5k2C2ZFfF/P
	 dUGx3dWFyY0ubZhITZSx4v/g1T9lsqF36TUPMCLFSdGG5AG7esLUdlGG9DQTOKHQNk
	 +pE1sgMxuIAbz6JlNNU5nrISUxos0fpnX2tPt9qD96mgSFBYxOKWmeh/qYnIjWvDcf
	 jBII27R2tPKzw==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4SbNrL4Pgtz4wd6;
	Thu, 23 Nov 2023 14:29:06 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH] powerpc/86xx: Drop unused CONFIG_MPC8610
Date: Thu, 23 Nov 2023 14:29:02 +1100
Message-ID: <20231123032902.2760818-1-mpe@ellerman.id.au>
X-Mailer: git-send-email 2.41.0
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

The MPC8610 symbol used to be default y if MPC8610_HPCD, but since
MPC8610_HPCD was removed MPC8610 is now never used. Remove it.

Fixes: 248667f8bbde ("powerpc: drop HPCD/MPC8610 evaluation platform support")
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/platforms/86xx/Kconfig | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/arch/powerpc/platforms/86xx/Kconfig b/arch/powerpc/platforms/86xx/Kconfig
index 67467cd6f34c..06b1e5c49d6f 100644
--- a/arch/powerpc/platforms/86xx/Kconfig
+++ b/arch/powerpc/platforms/86xx/Kconfig
@@ -52,10 +52,3 @@ config MPC8641
 	select MPIC
 	default y if GEF_SBC610 || GEF_SBC310 || GEF_PPC9A \
 			|| MVME7100
-
-config MPC8610
-	bool
-	select HAVE_PCI
-	select FSL_PCI if PCI
-	select PPC_UDBG_16550
-	select MPIC
-- 
2.41.0

