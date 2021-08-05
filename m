Return-Path: <SRS0=rnOA=M4=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B0F4C4338F
	for <linuxppc-dev@archiver.kernel.org>; Thu,  5 Aug 2021 01:20:53 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EEE9560F38
	for <linuxppc-dev@archiver.kernel.org>; Thu,  5 Aug 2021 01:20:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org EEE9560F38
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=ozlabs.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Gg9m3448Sz3cKk
	for <linuxppc-dev@archiver.kernel.org>; Thu,  5 Aug 2021 11:20:51 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=ozlabs.org header.i=@ozlabs.org header.a=rsa-sha256 header.s=201707 header.b=ERUWHop7;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=ozlabs.org (client-ip=203.11.71.1; helo=ozlabs.org;
 envelope-from=anton@ozlabs.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 secure) header.d=ozlabs.org header.i=@ozlabs.org header.a=rsa-sha256
 header.s=201707 header.b=ERUWHop7; dkim-atps=neutral
Received: from ozlabs.org (ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Gg9lD4bmSz3cLP
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  5 Aug 2021 11:20:07 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4Gg9lB1KGZz9sWc;
 Thu,  5 Aug 2021 11:20:06 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ozlabs.org;
 s=201707; t=1628126406;
 bh=1JJwNmuESAvQFYQrD8ppSQ0u01ajqAsXxsPjoN6nDfs=;
 h=Date:From:To:Cc:Subject:From;
 b=ERUWHop7CjhsnrMXlOZNITaabKHiai9+tQUr7S7dzYQxZw/scXW6IXYNi3r29STlL
 uBbrMZrJnAcM9m3CU1/dJ5xyMR9KrsV9RIDHRbgomliPQwXRN//Z/sesGBz92ZKOE9
 n85Ck5c8AW3epwywPg37+gznr8BWqR3xPi43G1HHR30RkD2kifXny+rMCPtwxTy/h5
 zLr/+/sm7oeBwWXNxOFoADrVEuIbCTsBZAuDFuqLMNV2pixGmUXcbkY39HKykAD4Vl
 zsW/+bJMlSE/klsuIP71XyODTG9IfyQIBuVfAn54eYMwL2TZTHJmu8a69PyHwUSyHP
 CFYH1S/h5GCrw==
Date: Thu, 5 Aug 2021 11:20:05 +1000
From: Anton Blanchard <anton@ozlabs.org>
To: Paul Mackerras <paulus@samba.org>, Joel Stanley <joel@jms.id.au>,
 Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH] powerpc/configs: Disable legacy ptys on microwatt defconfig
Message-ID: <20210805112005.3cb1f412@kryten.localdomain>
X-Mailer: Mutt/1.8.0 (2017-02-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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
Cc: linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

We shouldn't need legacy ptys, and disabling the option improves boot
time by about 0.5 seconds.

Signed-off-by: Anton Blanchard <anton@ozlabs.org>
---

diff --git a/arch/powerpc/configs/microwatt_defconfig b/arch/powerpc/configs/microwatt_defconfig
index a08b739123da..ebc90aefbc0c 100644
--- a/arch/powerpc/configs/microwatt_defconfig
+++ b/arch/powerpc/configs/microwatt_defconfig
@@ -57,6 +57,7 @@ CONFIG_NETDEVICES=y
 # CONFIG_INPUT is not set
 # CONFIG_SERIO is not set
 # CONFIG_VT is not set
+# CONFIG_LEGACY_PTYS is not set
 CONFIG_SERIAL_8250=y
 # CONFIG_SERIAL_8250_DEPRECATED_OPTIONS is not set
 CONFIG_SERIAL_8250_CONSOLE=y

