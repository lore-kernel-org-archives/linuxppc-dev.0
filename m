Return-Path: <SRS0=rc36=SS=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56A9FC10F13
	for <linuxppc-dev@archiver.kernel.org>; Tue, 16 Apr 2019 21:47:28 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C4CA020821
	for <linuxppc-dev@archiver.kernel.org>; Tue, 16 Apr 2019 21:47:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UN9PQL+s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4CA020821
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44kJqy01YzzDqMV
	for <linuxppc-dev@archiver.kernel.org>; Wed, 17 Apr 2019 07:47:26 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::c41; helo=mail-yw1-xc41.google.com;
 envelope-from=nishadkamdar@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="UN9PQL+s"; 
 dkim-atps=neutral
Received: from mail-yw1-xc41.google.com (mail-yw1-xc41.google.com
 [IPv6:2607:f8b0:4864:20::c41])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44k8RY1GMVzDqLs
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Apr 2019 01:29:09 +1000 (AEST)
Received: by mail-yw1-xc41.google.com with SMTP id j128so7431655ywg.12
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Apr 2019 08:29:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=CiDNzOF6FPRSsYxd0JWAZRrzI9jxs8nAYPelAU2Dl58=;
 b=UN9PQL+sf/jodUc+5Xa1Usz06GA6zvib2h9+dYGPMZbwd5mm1MS9jFU5rgmrD55FHG
 RXujflovo8ujLIwJO9aKnnkZ3vDipu2ISSXgyBgdltgCO/iMZVAiB5fjHWA+3qf4FZuy
 NTsFZg0106UB0neMFqzqiY4WC8+EDAusbelnvl6XdUOVCqqZYlBhGeTDPvrpuKA9uZox
 Zw8UAnijlbO2+tpmEPLXV16DtTzoRucREz5H7UEAVs2nj1XKIM3XrpApxxWMSHHgP7vH
 bLUv0Sc+IJrTYNFx87T9XuoNUeJqubqJJYKXnFK1RJN76XpVI+FOd3IN4nolJ6fBY/Vs
 QQGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=CiDNzOF6FPRSsYxd0JWAZRrzI9jxs8nAYPelAU2Dl58=;
 b=glYNa/UK06xEA+KWX7dASbpcqeDpdxKlhhhFQa2jY+HwqB5mU5f9Fh36wIAmnF5IQF
 zv7k4zMfQlLljK3BTOw77xJzTJ9Ch0I17IErWcbVdox16iq2sE+eE1R8WiiopWY0Rt2V
 D7nYzGB5xo8/CriZ39l08yonDpnKC87dgYJTiegzkx9uOQmD8MXyFOqpGnzmRPF+plKX
 2bluKBOS17qZOISOmTO1z15v+1Oh0jIAJqwM4h6QKMZN3nxRkLgHYpdvcvvsoEdxwCLo
 jsnXIuPGXEJ7yvw9lLMk4VNvwxCsybN/DIZbeM+2tfsOvlnY9XB1yEydbiMF6/JiqlYt
 egbg==
X-Gm-Message-State: APjAAAX85jn2n0ZegxZ1qxSPWJ/E0g7khpCwjLvDzPuwiqUdFSBGErKs
 53P/UTvaLLuvTj3vFi/Q+Sk=
X-Google-Smtp-Source: APXvYqyqxM7q/rqg/WGfkhul2fEDL6+6+rkvSyfNz1OIZ58lfT/a8XcrcEitNlxGJYPxRMlOSy8spA==
X-Received: by 2002:a81:3506:: with SMTP id c6mr65178291ywa.207.1555428546429; 
 Tue, 16 Apr 2019 08:29:06 -0700 (PDT)
Received: from nishad ([2406:7400:54:eb3:d9be:857a:cd1e:eb7f])
 by smtp.gmail.com with ESMTPSA id s79sm15565301ywg.43.2019.04.16.08.29.01
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Tue, 16 Apr 2019 08:29:05 -0700 (PDT)
Date: Tue, 16 Apr 2019 20:58:57 +0530
From: Nishad Kamdar <nishadkamdar@gmail.com>
To: Frederic Barrat <fbarrat@linux.ibm.com>,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Subject: [PATCH v3 3/5] powerpc: Use the correct style for SPDX License
 Identifier
Message-ID: <5c04f72569b508cd5477fa1bf15f0166d376cd3a.1555427420.git.nishadkamdar@gmail.com>
References: <cover.1555427418.git.nishadkamdar@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1555427418.git.nishadkamdar@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Mailman-Approved-At: Wed, 17 Apr 2019 06:55:24 +1000
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
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-kernel@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
 Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
 Joe Perches <joe@perches.com>, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

This patch corrects the SPDX License Identifier style
in the powerpc Hardware Architecture related files.

Suggested-by: Joe Perches <joe@perches.com>
Signed-off-by: Nishad Kamdar <nishadkamdar@gmail.com>
---
 arch/powerpc/include/asm/pnv-ocxl.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/pnv-ocxl.h b/arch/powerpc/include/asm/pnv-ocxl.h
index 208b5503f4ed..7de82647e761 100644
--- a/arch/powerpc/include/asm/pnv-ocxl.h
+++ b/arch/powerpc/include/asm/pnv-ocxl.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0+
+/* SPDX-License-Identifier: GPL-2.0+ */
 // Copyright 2017 IBM Corp.
 #ifndef _ASM_PNV_OCXL_H
 #define _ASM_PNV_OCXL_H
-- 
2.17.1

