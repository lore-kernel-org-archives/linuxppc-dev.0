Return-Path: <SRS0=WC9B=B3=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C62BBC433E1
	for <linuxppc-dev@archiver.kernel.org>; Mon, 17 Aug 2020 12:11:33 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2A3D22072E
	for <linuxppc-dev@archiver.kernel.org>; Mon, 17 Aug 2020 12:11:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jyoKi+zL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A3D22072E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4BVXvl0ZWjzDqYM
	for <linuxppc-dev@archiver.kernel.org>; Mon, 17 Aug 2020 22:11:31 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::443;
 helo=mail-pf1-x443.google.com; envelope-from=allen.cryptic@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=jyoKi+zL; dkim-atps=neutral
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com
 [IPv6:2607:f8b0:4864:20::443])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4BVSjf1p1yzDqQD
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 17 Aug 2020 19:02:30 +1000 (AEST)
Received: by mail-pf1-x443.google.com with SMTP id a79so7901124pfa.8
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 17 Aug 2020 02:02:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=2vTu6UftF7cQJbJWPsIkFjwuCpKR0DhP9J5zcRGrqoI=;
 b=jyoKi+zL9LSuhOPQ80fRIjLL7JLJHMk+jLLKWZWpDdCply4xhhtYwfiLo+v9Gmd2HB
 MoafH47E2/qeJ3o2/fhNpyesUHbHtqfSjtNFfI680LssZHCLaakpecGrN8t2GiXyVYKC
 U3YqdYATtpfP0z4bvmCdcmaXgeHyeh3N+B2Ry1cg1RYmTwAWLlEQUKP2f5ItyZ8Y0QKK
 MJ5ISgtHIBDE9WMLkRMfUB9u/usIIFGRwKHPqdpsRqbCg70JlN7uj5wcW1vruY98BiKD
 POnKmfAz4wNjunOokWZ/ePwWAZgvXkfvv40q2M2wXRYwrnj+kDNIzuB7thZaxu1p0Kz8
 LSqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=2vTu6UftF7cQJbJWPsIkFjwuCpKR0DhP9J5zcRGrqoI=;
 b=r/pe+gQO6n8oeDS28cSUbKLDlrA3ymgIZYLNj7IuMMSaKEEs25gmKwTtNZZ8FgonHR
 3PUToS0EzvN5Z9VYQ8eAUlB9/SzDuZtO2Iw3AQFdZi3H7T6H1AhvI1LagwDIJgNUMiC6
 SbfOLd/KvL2eI6/P7mq1nI2KtGU9sNYkJIQVdpdZ1Tb7s7Z/Jq9JWub7ImZQ+/GZAQ7p
 weKrT7ujxqwcfmc3Sqm/6nvUBffOabDfzroFHmxibpiLRl7YXz8rf5YlzH4PQ3kgXLL8
 eK1Pd0UVRxMMxVSvgFaP5KD98Lu6HRU//gVDwIQ+XvFn+ySMWmcSgmygEXxIDhHaiKwW
 91yg==
X-Gm-Message-State: AOAM533ZTy/HaSOsAzeALmHQgYVg8O27bXv3u+utMKP0MafVdZBLpbJZ
 QTYEDDmMvkOlY4nh4ciDLBMsqOlUCeMQVQ==
X-Google-Smtp-Source: ABdhPJw+NUVlFHmHuq0xLyJ9Qs3O4JjM2hTVZcFUlYoIH6k59c4k+FO8V6iZ+byK1cCoIzwPNcFOEg==
X-Received: by 2002:a62:8141:: with SMTP id t62mr10236273pfd.282.1597654946593; 
 Mon, 17 Aug 2020 02:02:26 -0700 (PDT)
Received: from localhost.localdomain ([49.207.202.98])
 by smtp.gmail.com with ESMTPSA id f3sm19488238pfj.206.2020.08.17.02.02.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Aug 2020 02:02:26 -0700 (PDT)
From: Allen Pais <allen.cryptic@gmail.com>
To: duncan.sands@free.fr, gregkh@linuxfoundation.org, jacmet@sunsite.dk,
 balbi@kernel.org, leoyang.li@nxp.com, johan@kernel.org
Subject: [PATCH 1/7] usb: atm: convert tasklets to use new tasklet_setup() API
Date: Mon, 17 Aug 2020 14:32:03 +0530
Message-Id: <20200817090209.26351-2-allen.cryptic@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200817090209.26351-1-allen.cryptic@gmail.com>
References: <20200817090209.26351-1-allen.cryptic@gmail.com>
X-Mailman-Approved-At: Mon, 17 Aug 2020 21:23:58 +1000
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
Cc: keescook@chromium.org, linux-usb@vger.kernel.org,
 Allen Pais <allen.lkml@gmail.com>, linux-kernel@vger.kernel.org,
 Romain Perier <romain.perier@gmail.com>, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

From: Allen Pais <allen.lkml@gmail.com>

In preparation for unconditionally passing the
struct tasklet_struct pointer to all tasklet
callbacks, switch to using the new tasklet_setup()
and from_tasklet() to pass the tasklet pointer explicitly.

Signed-off-by: Romain Perier <romain.perier@gmail.com>
Signed-off-by: Allen Pais <allen.lkml@gmail.com>
---
 drivers/usb/atm/usbatm.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/usb/atm/usbatm.c b/drivers/usb/atm/usbatm.c
index 4e12a32ca392..56fe30d247da 100644
--- a/drivers/usb/atm/usbatm.c
+++ b/drivers/usb/atm/usbatm.c
@@ -511,9 +511,10 @@ static unsigned int usbatm_write_cells(struct usbatm_data *instance,
 **  receive  **
 **************/
 
-static void usbatm_rx_process(unsigned long data)
+static void usbatm_rx_process(struct tasklet_struct *t)
 {
-	struct usbatm_data *instance = (struct usbatm_data *)data;
+	struct usbatm_data *instance = from_tasklet(instance, t,
+						    rx_channel.tasklet);
 	struct urb *urb;
 
 	while ((urb = usbatm_pop_urb(&instance->rx_channel))) {
@@ -564,9 +565,10 @@ static void usbatm_rx_process(unsigned long data)
 **  send  **
 ***********/
 
-static void usbatm_tx_process(unsigned long data)
+static void usbatm_tx_process(struct tasklet_struct *t)
 {
-	struct usbatm_data *instance = (struct usbatm_data *)data;
+	struct usbatm_data *instance = from_tasklet(instance, t,
+						    tx_channel.tasklet);
 	struct sk_buff *skb = instance->current_skb;
 	struct urb *urb = NULL;
 	const unsigned int buf_size = instance->tx_channel.buf_size;
@@ -1069,8 +1071,8 @@ int usbatm_usb_probe(struct usb_interface *intf, const struct usb_device_id *id,
 
 	usbatm_init_channel(&instance->rx_channel);
 	usbatm_init_channel(&instance->tx_channel);
-	tasklet_init(&instance->rx_channel.tasklet, usbatm_rx_process, (unsigned long)instance);
-	tasklet_init(&instance->tx_channel.tasklet, usbatm_tx_process, (unsigned long)instance);
+	tasklet_setup(&instance->rx_channel.tasklet, usbatm_rx_process);
+	tasklet_setup(&instance->tx_channel.tasklet, usbatm_tx_process);
 	instance->rx_channel.stride = ATM_CELL_SIZE + driver->rx_padding;
 	instance->tx_channel.stride = ATM_CELL_SIZE + driver->tx_padding;
 	instance->rx_channel.usbatm = instance->tx_channel.usbatm = instance;
-- 
2.17.1

