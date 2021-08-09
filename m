Return-Path: <SRS0=IXoQ=NA=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A08AC4338F
	for <linuxppc-dev@archiver.kernel.org>; Mon,  9 Aug 2021 21:55:17 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EDCD260F25
	for <linuxppc-dev@archiver.kernel.org>; Mon,  9 Aug 2021 21:55:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org EDCD260F25
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Gk8yV0cMnz30Gr
	for <linuxppc-dev@archiver.kernel.org>; Tue, 10 Aug 2021 07:55:14 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (sender SPF authorized) smtp.mailfrom=omp.ru
 (client-ip=45.84.86.81; helo=mxout01.lancloud.ru;
 envelope-from=s.shtylyov@omp.ru; receiver=<UNKNOWN>)
X-Greylist: delayed 338 seconds by postgrey-1.36 at boromir;
 Tue, 10 Aug 2021 06:56:07 AEST
Received: from mxout01.lancloud.ru (mxout01.lancloud.ru [45.84.86.81])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Gk7fH6fGqz2xnd
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Aug 2021 06:56:06 +1000 (AEST)
Received: from LanCloud
DKIM-Filter: OpenDKIM Filter v2.11.0 mxout01.lancloud.ru 2BFC5206094F
Received: from LanCloud
Received: from LanCloud
Received: from LanCloud
Subject: [PATCH v2 7/9] usb: phy: fsl-usb: add IRQ check
From: Sergey Shtylyov <s.shtylyov@omp.ru>
To: <linux-usb@vger.kernel.org>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Felipe Balbi <balbi@kernel.org>, Ran Wang
 <ran.wang_1@nxp.com>
References: <47bacc02-4e34-3208-779c-7072a6261782@omp.ru>
Organization: Open Mobile Platform
Message-ID: <b0a86089-8b8b-122e-fd6d-73e8c2304964@omp.ru>
Date: Mon, 9 Aug 2021 23:50:18 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <47bacc02-4e34-3208-779c-7072a6261782@omp.ru>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.11.198]
X-ClientProxiedBy: LFEXT02.lancloud.ru (fd00:f066::142) To
 LFEX1907.lancloud.ru (fd00:f066::207)
X-Mailman-Approved-At: Tue, 10 Aug 2021 07:54:12 +1000
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

The driver neglects to check the result of platform_get_irq()'s call and
blithely passes the negative error codes to request_irq() (which takes
*unsigned* IRQ #), causing it to fail with -EINVAL, overriding an original
error code. Stop calling request_irq() with the invalid IRQ #s.

Fixes: 0807c500a1a6 ("USB: add Freescale USB OTG Transceiver driver")
Signed-off-by: Sergey Shtylyov <s.shtylyov@omp.ru>

---
 drivers/usb/phy/phy-fsl-usb.c |    2 ++
 1 file changed, 2 insertions(+)

Index: usb/drivers/usb/phy/phy-fsl-usb.c
===================================================================
--- usb.orig/drivers/usb/phy/phy-fsl-usb.c
+++ usb/drivers/usb/phy/phy-fsl-usb.c
@@ -873,6 +873,8 @@ int usb_otg_start(struct platform_device
 
 	/* request irq */
 	p_otg->irq = platform_get_irq(pdev, 0);
+	if (p_otg->irq < 0)
+		return p_otg->irq;
 	status = request_irq(p_otg->irq, fsl_otg_isr,
 				IRQF_SHARED, driver_name, p_otg);
 	if (status) {
