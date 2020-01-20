Return-Path: <SRS0=DTJJ=3J=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90F24C32771
	for <linuxppc-dev@archiver.kernel.org>; Mon, 20 Jan 2020 20:53:17 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E0AC722522
	for <linuxppc-dev@archiver.kernel.org>; Mon, 20 Jan 2020 20:53:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YrOLIgKH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E0AC722522
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 481kQd49zqzDqdf
	for <linuxppc-dev@archiver.kernel.org>; Tue, 21 Jan 2020 07:53:13 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::641;
 helo=mail-pl1-x641.google.com; envelope-from=wenhu.pku@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=YrOLIgKH; dkim-atps=neutral
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com
 [IPv6:2607:f8b0:4864:20::641])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 481ZDn6hn4zDqBZ
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Jan 2020 01:44:06 +1100 (AEDT)
Received: by mail-pl1-x641.google.com with SMTP id g6so13275999plp.6
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Jan 2020 06:44:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id;
 bh=Gk+XnTJkS82tNYdQHdvBk1UC3MkIoHkULCXBVdOn/98=;
 b=YrOLIgKH7aFn8lDGP/EY6YnW9V6SUULS/WGIwhS6gE5Vm10r/q5IYDt7OUbHG4888U
 Vq5zvJu9FXgvS5fGIVM7odYfzTgipSU5BifQa25quydewc2OYs3VeRgGN2n7yF6F/is+
 gsRc0gntvpZBZifQgjyJwcXyZrc72HxJdRxlPZgdya4gNXMlbeMKBC2fAbZ73FOo1fe4
 I08tUix64bedwljZfRHayujDeBM3J7R4ZgfCqaKPiu9byjvfcUbHVqBCJnqY8MSeBzps
 FkpNCqZ5ozXb9Mnw+zhMX7FfUfCjHhi9bDkvEGr36aUKm3SkZRxIPFFMLsVGBr8egD15
 1L1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=Gk+XnTJkS82tNYdQHdvBk1UC3MkIoHkULCXBVdOn/98=;
 b=CHrrBfLMVQO4mnZ/1d4HtWdZdtnEt8FZLTsgGDAYHA0slbbPghMBdo2K1sllZsuS8Q
 Zgqzx7uw8UFLgnzKbp4Y/BLE1CpNo6+NpDCU/PXFTrPH+f6ewC5EiZewf6Rv3SO64M2B
 T23ujVUrQXnF/8qXPlhbanUgXud/AMGHGHvvLuXtsh2oGuDJkxXfVl8pRHWP+Q8kOHC2
 MssjCim8LFKHnsKz/XAdyxUpW9zCXwbLpArRV09oxXhbH/pZDOG2HAYsIKfvC8ZSXg5I
 JgdUWjtx0XctQKN3nVBCt6uYRgo76vt1/RalWr0pQd1fETMQx2KNJsAjuT7O8Dcc/cBb
 +G9A==
X-Gm-Message-State: APjAAAW6r3OoQAnL5UOjwBLwE44UVeQSKmvYpDpPCFBt4sC5fNus0xpD
 WhrFPBP23FxIaRIrLjeUyqw=
X-Google-Smtp-Source: APXvYqwn9xPQBXqWtFBVQ2U19m5cD4nwj01Adw9EZj+vufMWeamCIUNCFxC5MCJn2KVbzC7axX/YjA==
X-Received: by 2002:a17:902:fe17:: with SMTP id g23mr5567plj.42.1579531442917; 
 Mon, 20 Jan 2020 06:44:02 -0800 (PST)
Received: from ubuntu.localdomain ([218.189.25.100])
 by smtp.gmail.com with ESMTPSA id c18sm39517820pfr.40.2020.01.20.06.44.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jan 2020 06:44:02 -0800 (PST)
From: wangwenhu <wenhu.pku@gmail.com>
To: Scott Wood <oss@buserror.net>, Kumar Gala <galak@kernel.crashing.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH] powerpc/Kconfig: Make FSL_85XX_CACHE_SRAM configurable
Date: Mon, 20 Jan 2020 06:43:27 -0800
Message-Id: <20200120144327.20800-1-wenhu.pku@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Mailman-Approved-At: Tue, 21 Jan 2020 07:51:05 +1100
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
Cc: wenhu.wang@vivo.com, trivial@kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

From: wangwenhu <wenhu.wang@vivo.com>

When generating .config file with menuconfig on Freescale BOOKE
SOC, FSL_85XX_CACHE_SRAM is not configurable for the lack of
description in the Kconfig field, which makes it impossible
to support L2Cache-Sram driver. Add a description to make it
configurable.

Signed-off-by: wangwenhu <wenhu.wang@vivo.com>
---
 arch/powerpc/platforms/85xx/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/85xx/Kconfig b/arch/powerpc/platforms/85xx/Kconfig
index fa3d29dcb57e..ee5ba10b98cb 100644
--- a/arch/powerpc/platforms/85xx/Kconfig
+++ b/arch/powerpc/platforms/85xx/Kconfig
@@ -17,7 +17,7 @@ if FSL_SOC_BOOKE
 if PPC32

 config FSL_85XX_CACHE_SRAM
-   bool
+   bool "Freescale Cache-Sram"
    select PPC_LIB_RHEAP
    help
      When selected, this option enables cache-sram support
--
2.23.0

