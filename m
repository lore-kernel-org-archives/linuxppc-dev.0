Return-Path: <linuxppc-dev+bounces-5733-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4953CC02190
	for <linuxppc-dev@archiver.kernel.org>; Fri, 31 Jan 2025 06:30:48 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YkmGm4Kbtz30Vs;
	Fri, 31 Jan 2025 17:30:24 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2404:9400:2221:ea00::3"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1738305024;
	cv=none; b=bwI+qPnhTGVtLp+263UzL3Gl/TWtmtpU0IIsZLKNfq9DeLc0iceo6AiR0DcxIDnRKtMm/B9+OcQb4MPe8XIJBxLjk0BlB3SxRvoaxjpLmpSJTlsqNKOf3HLKPCppVmlAN/ANxCQanHtt6PTOaZbDYj+7aqwYuRvdE2O3iJPWSNU1IMtSTt247ahunarV3EbRFfrr51fB+YJVa7URs+1CASoGG7DJzpRExJpczdycPQFQoIIuW3ZkoEDduFs5SJOmraDPpY9PCVKcjuaT5CRFhhGNcKiZ2WKds1saj2H3tg40k5i+NbMPZgHykv3qbdjM3ByiZXoHSHfbddnxqNUGBw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1738305024; c=relaxed/relaxed;
	bh=HpozJ2E6jobz+cU5TBmPnsSABQnvOrZEXWaprRsjdY0=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HqgidOidY3xmVjIz06CMuYESL6iQEnzLEi3Nd/QsyFw6WN2EVXzj7XoSfd6bmdqnXc6KQL3HA2NpIN7B0eqd78aCSlLD7HSNnjFcgdWN53aIGDZEgAuKGd8aEKnLzAVXYqlbsa3ZsfKuhfyAIP1QnyKsR84W3kuE+eZff8PvaqTBdx05LEShXyqEPbHyvY+/D2wyuxIH+EXWWkEETnMIVemtCmYsKBiv9bj+I1CwWcoU4wSTkBOZxmIAp9LOffZW3KRGUVfL1XXXFj4rdAC/u+Mouqld1lEWP+hD8unb9OKlRsnzV6CxfqlPffYexnWjMJl56617PIBdnffWQ3n7ew==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=ozlabs.org; dkim=pass (2048-bit key; secure) header.d=ozlabs.org header.i=@ozlabs.org header.a=rsa-sha256 header.s=201707 header.b=Xgx8hUpB; dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=ozlabs.org header.i=@ozlabs.org header.a=rsa-sha256 header.s=201707 header.b=Xgx8hUpB;
	dkim-atps=neutral
Received: from mail.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YkmGk2p79z30VS
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 31 Jan 2025 17:30:22 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ozlabs.org;
	s=201707; t=1738305012;
	bh=HpozJ2E6jobz+cU5TBmPnsSABQnvOrZEXWaprRsjdY0=;
	h=Date:From:To:Subject:References:In-Reply-To:From;
	b=Xgx8hUpBloJvACwd4uo2KSdgOm3iaMoUBjHv43lTG+b4p6s3Rg7L56/hhJ+X7+bpU
	 DUHusNzkIewWgf6yS9ieQg2V/cx0ptCK1mA2VBo25nh1lrkMpAFYclZNzui/5ppwwo
	 2L2yzBZxIq7DxMcnhwOpH4sXFl7ocN+Qzyf/UOr+zTgAeC33jbSnoAsER/mIkjF1Wj
	 yC9uuT4xKtLN1GNkjpmUtalUg9mvNmkNGl7MPbfPwz+wuDDmLg7izv6cmC2A5TMPo8
	 gIAGXsJpv3axE7y56FR8kS8DM5TEcNruHcdenI14KKYui/t2xDCMLUPNEB9UR5Ymlk
	 lB9Ck1sdJhjlA==
Received: by gandalf.ozlabs.org (Postfix, from userid 1003)
	id 4YkmGX1f8Bz4x6T; Fri, 31 Jan 2025 17:30:12 +1100 (AEDT)
Date: Fri, 31 Jan 2025 17:27:27 +1100
From: Paul Mackerras <paulus@ozlabs.org>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2 1/5] powerpc/microwatt: Select COMMON_CLK in order to get
 the clock framework
Message-ID: <Z5xtT47QsnFpxc5E@thinks.paulus.ozlabs.org>
References: <Z5xtIVa0y7lTDTU3@thinks.paulus.ozlabs.org>
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
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z5xtIVa0y7lTDTU3@thinks.paulus.ozlabs.org>

This is to allow us to select Litex MMC host controller driver, which
drives the litesdcard gateware.

Signed-off-by: Paul Mackerras <paulus@ozlabs.org>
Acked-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/platforms/microwatt/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/powerpc/platforms/microwatt/Kconfig b/arch/powerpc/platforms/microwatt/Kconfig
index 6af443a1db99..5e41adadac1f 100644
--- a/arch/powerpc/platforms/microwatt/Kconfig
+++ b/arch/powerpc/platforms/microwatt/Kconfig
@@ -6,6 +6,7 @@ config PPC_MICROWATT
 	select PPC_ICS_NATIVE
 	select PPC_ICP_NATIVE
 	select PPC_UDBG_16550
+	select COMMON_CLK
 	help
           This option enables support for FPGA-based Microwatt implementations.
 
-- 
2.47.1



