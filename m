Return-Path: <SRS0=lwUg=B7=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D61ACC433DF
	for <linuxppc-dev@archiver.kernel.org>; Fri, 21 Aug 2020 20:53:36 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4876820724
	for <linuxppc-dev@archiver.kernel.org>; Fri, 21 Aug 2020 20:53:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=anastas.io header.i=@anastas.io header.b="M26UuQrQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4876820724
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=anastas.io
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4BYDJF4qpfzDqkL
	for <linuxppc-dev@archiver.kernel.org>; Sat, 22 Aug 2020 06:53:33 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=anastas.io (client-ip=104.248.188.109; helo=alpha.anastas.io;
 envelope-from=shawn@anastas.io; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none)
 header.from=anastas.io
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=anastas.io header.i=@anastas.io header.a=rsa-sha256
 header.s=mail header.b=M26UuQrQ; dkim-atps=neutral
Received: from alpha.anastas.io (alpha.anastas.io [104.248.188.109])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4BYDFm0F88zDrDT
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 22 Aug 2020 06:51:23 +1000 (AEST)
Received: from authenticated-user (alpha.anastas.io [104.248.188.109])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by alpha.anastas.io (Postfix) with ESMTPSA id 616C07ECD8;
 Fri, 21 Aug 2020 15:51:20 -0500 (CDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=anastas.io; s=mail;
 t=1598043080; bh=3aXxNw1T7kdHi4tVgB2VciVb6/V2lhrq6znhBANHZfc=;
 h=From:To:Cc:Subject:Date:From;
 b=M26UuQrQm8jPQgBKQNmE7/gc3QUIpQLE3JP7bkeox+74vKkCH06Ofnn06ZNyzLtmf
 3S9Z+OdGy2PvCKk+c0dQPQoyFkmvt8acccvKt76J0MO5ONwaUCP+o22a33Vd/m+5g2
 KfIuw9cEq/iyOr25uJE0BLGLsWQSNE8keBvzh+Cw2cWXEHDRC6oYt8KgjWVQ9pFMab
 Tke5ZQW/VWJGqs+voAbjrFQnZyM2sIusApZsZvhG/pTlroWH0v1Y2QhpY5dX3qv/Ay
 ZzF0PgVdpZZhfBbgZNhxBEoJk81cb4B3k3DsW8q+y8j2lZ+6XqN3jV6WdN9A/8G19Y
 Vga/+fpo7uINg==
From: Shawn Anastasio <shawn@anastas.io>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] powerpc/pseries: Add pcibios_default_alignment implementation
Date: Fri, 21 Aug 2020 15:51:15 -0500
Message-Id: <20200821205115.50333-1-shawn@anastas.io>
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
Cc: aik@ozlabs.ru, oohall@gmail.com, linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Implement pcibios_default_alignment for pseries so that
resources are page-aligned. The main benefit of this is being
able to map any resource from userspace via mechanisms like VFIO.

This is identical to powernv's implementation.

Signed-off-by: Shawn Anastasio <shawn@anastas.io>
---
 arch/powerpc/platforms/pseries/pci.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/powerpc/platforms/pseries/pci.c b/arch/powerpc/platforms/pseries/pci.c
index 911534b89c85..6d922c096354 100644
--- a/arch/powerpc/platforms/pseries/pci.c
+++ b/arch/powerpc/platforms/pseries/pci.c
@@ -210,6 +210,11 @@ int pseries_pcibios_sriov_disable(struct pci_dev *pdev)
 }
 #endif
 
+static resource_size_t pseries_pcibios_default_alignment(void)
+{
+	return PAGE_SIZE;
+}
+
 static void __init pSeries_request_regions(void)
 {
 	if (!isa_io_base)
@@ -231,6 +236,8 @@ void __init pSeries_final_fixup(void)
 
 	eeh_show_enabled();
 
+	ppc_md.pcibios_default_alignment = pseries_pcibios_default_alignment;
+
 #ifdef CONFIG_PCI_IOV
 	ppc_md.pcibios_sriov_enable = pseries_pcibios_sriov_enable;
 	ppc_md.pcibios_sriov_disable = pseries_pcibios_sriov_disable;
-- 
2.28.0

