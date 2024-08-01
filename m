Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 012BDC3DA64
	for <linuxppc-dev@archiver.kernel.org>; Thu,  1 Aug 2024 00:40:56 +0000 (UTC)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=RN2K7M3U;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4WZ99z4Ml5z3dBs
	for <linuxppc-dev@archiver.kernel.org>; Thu,  1 Aug 2024 10:40:55 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=RN2K7M3U;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=139.178.84.217; helo=dfw.source.kernel.org; envelope-from=sashal@kernel.org; receiver=lists.ozlabs.org)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4WZ99C50q4z2y8d
	for <linuxppc-dev@lists.ozlabs.org>; Thu,  1 Aug 2024 10:40:15 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 9295961741;
	Thu,  1 Aug 2024 00:40:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E423C4AF10;
	Thu,  1 Aug 2024 00:40:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722472813;
	bh=hDFH0xuVEwXXPx+0//7xppgQ92FJEKmcmTYJrdk8Hrs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RN2K7M3U8Qgq2A6iJgKNgsmHLeB1N+zFlYsA8FEzdLlvDBUlu7ru2LpRxrYGVpP/T
	 QdWkRr9ShCvJ/lZKmEXND89rR25qkp/a1LpwKR4zniuBvcLAffm0wWHbjibW+dAkOq
	 JAwhJqabHkT0VyORT/dyjIU1piSPwG7PgqIexc9Gn6UuTWAhJuCTqGyHmnDm/yHiaY
	 uW94kG7z7qp0r8d8ie6bKbYoXVHWFBqlLBTmXixuuFP1jM1d+uDk0zf7VSTKcLMrom
	 USCeL2d4viVeKFXZjgJWhz6rywJ80Cld9laqgyV89HDrU/Hl4A3t4xWcsaowFnvj7w
	 rRsKVofXZsJOg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 18/22] pci/hotplug/pnv_php: Fix hotplug driver crash on Powernv
Date: Wed, 31 Jul 2024 20:38:47 -0400
Message-ID: <20240801003918.3939431-18-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240801003918.3939431-1-sashal@kernel.org>
References: <20240801003918.3939431-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.281
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
Cc: Sasha Levin <sashal@kernel.org>, Shawn Anastasio <sanastasio@raptorengineering.com>, Bjorn Helgaas <bhelgaas@google.com>, Timothy Pearson <tpearson@raptorengineering.com>, linux-pci@vger.kernel.org, Krishna Kumar <krishnak@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev" <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

From: Krishna Kumar <krishnak@linux.ibm.com>

[ Upstream commit 335e35b748527f0c06ded9eebb65387f60647fda ]

The hotplug driver for powerpc (pci/hotplug/pnv_php.c) causes a kernel
crash when we try to hot-unplug/disable the PCIe switch/bridge from
the PHB.

The crash occurs because although the MSI data structure has been
released during disable/hot-unplug path and it has been assigned
with NULL, still during unregistration the code was again trying to
explicitly disable the MSI which causes the NULL pointer dereference and
kernel crash.

The patch fixes the check during unregistration path to prevent invoking
pci_disable_msi/msix() since its data structure is already freed.

Reported-by: Timothy Pearson <tpearson@raptorengineering.com>
Closes: https://lore.kernel.org/all/1981605666.2142272.1703742465927.JavaMail.zimbra@raptorengineeringinc.com/
Acked-by: Bjorn Helgaas <bhelgaas@google.com>
Tested-by: Shawn Anastasio <sanastasio@raptorengineering.com>
Signed-off-by: Krishna Kumar <krishnak@linux.ibm.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Link: https://msgid.link/20240701074513.94873-2-krishnak@linux.ibm.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pci/hotplug/pnv_php.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/pci/hotplug/pnv_php.c b/drivers/pci/hotplug/pnv_php.c
index d7b2b47bc33eb..3824942618305 100644
--- a/drivers/pci/hotplug/pnv_php.c
+++ b/drivers/pci/hotplug/pnv_php.c
@@ -35,7 +35,6 @@ static void pnv_php_disable_irq(struct pnv_php_slot *php_slot,
 				bool disable_device)
 {
 	struct pci_dev *pdev = php_slot->pdev;
-	int irq = php_slot->irq;
 	u16 ctrl;
 
 	if (php_slot->irq > 0) {
@@ -54,7 +53,7 @@ static void pnv_php_disable_irq(struct pnv_php_slot *php_slot,
 		php_slot->wq = NULL;
 	}
 
-	if (disable_device || irq > 0) {
+	if (disable_device) {
 		if (pdev->msix_enabled)
 			pci_disable_msix(pdev);
 		else if (pdev->msi_enabled)
-- 
2.43.0

