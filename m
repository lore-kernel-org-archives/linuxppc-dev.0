Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF7E1606A31C
	for <linuxppc-dev@archiver.kernel.org>; Wed, 18 Nov 2026 14:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=mail.sdu.edu.cn header.i=@mail.sdu.edu.cn header.a=rsa-sha256 header.s=default header.b=HrES4Tp4
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jV4Rd4dZvz2xSl;
	Thu, 19 Nov 2026 01:56:13 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=101.71.155.101
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795011214;
	cv=none; b=fmfh3y0QCyh4MZ+guI339pf6MjwYrhsEOsOL+7xc9r5a4kNNoKuqiZYRMwfa69z0Kk23xPtmkNX+0Hm7c4fBIPiMe5qtqHLcawDdAlQ/aiEHSHwb8/iEXGhNp76T/tYZlSZPXzcF1JxEFK1h9lyXzghTz7/tG/EGeDkdPjEeYHlPjPOot18J/cnFtpa0C3PztxigHeRg//LSqBy057BW4RA3s9vBLHeAZoxBT4EJgYQlQ28bOjgEKanJxwVENpKdEJfRhIrqrm2TsUZ04vL+xeIs8r4rDl1I3U+3NKSO0lJpvSL1VBR2/t1Wun6OAoXl65bRfZ38FudtSLo9FfpIiA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795011214; c=relaxed/relaxed;
	bh=0sSkgJi+Iy6AbBDGZ/m3UoHILo4pwmgba+6jz8hywfI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gAvj56FPbduzM6ruyEUPfmTLuxwpZUJWNbri7otMtR3NwXmZg3jH8qcCHC13Lo1Jec+WdI5PD/q+Ck1kvfZL09hJmZHXRhFa3MPLl7igiIq1A8cIfDtxdTjCOBzINPPlsr8IOaOdl/TUYHZEyCep1pgy8nQ583EWAleD48PZWayyOlcO4PiHn9fcGnOJwofl6IGKAQhkmrqQyUFjbypvt2ftpLzG0+jLwyAfu8W1wucunMi6BwIm1Vq8MofUL8sSz30fXGhMDI5YjUZSOLJFcM3EnG31zDYCehpJQL9thwiLvjvByDczJXgo3Obbxyz5FMoKqrE+FOerYMALxlfVDg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=mail.sdu.edu.cn; dkim=pass (1024-bit key; unprotected) header.d=mail.sdu.edu.cn header.i=@mail.sdu.edu.cn header.a=rsa-sha256 header.s=default header.b=HrES4Tp4; dkim-atps=neutral; spf=pass (client-ip=101.71.155.101; helo=mail-m155101.qiye.163.com; envelope-from=liguangshuo@mail.sdu.edu.cn; receiver=lists.ozlabs.org) smtp.mailfrom=mail.sdu.edu.cn
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=mail.sdu.edu.cn
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=mail.sdu.edu.cn header.i=@mail.sdu.edu.cn header.a=rsa-sha256 header.s=default header.b=HrES4Tp4;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=mail.sdu.edu.cn (client-ip=101.71.155.101; helo=mail-m155101.qiye.163.com; envelope-from=liguangshuo@mail.sdu.edu.cn; receiver=lists.ozlabs.org)
X-Greylist: delayed 117 seconds by postgrey-1.37 at boromir; Thu, 19 Nov 2026 01:11:31 AEDT
Received: from mail-m155101.qiye.163.com (mail-m155101.qiye.163.com [101.71.155.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jV3S33cLgz2xns
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Nov 2026 01:11:30 +1100 (AEDT)
Received: from lgs.. (unknown [101.76.249.61])
	by smtp.qiye.163.com (Hmail) with ESMTP id 5526d7801;
	Wed, 18 Nov 2026 22:10:53 +0800 (GMT+08:00)
From: Guangshuo Li <liguangshuo@mail.sdu.edu.cn>
To: Neill Kapron <nkapron@google.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	stable@vger.kernel.org
Subject: [PATCH 1/2] usb: gadget: fsl_udc: Fix potential use-after-free during removal
Date: Wed, 18 Nov 2026 22:10:53 +0800
Message-ID: <20261118-324f82bd41-usb-gadget-1@mail.sdu.edu.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261118-324f82bd41-usb-gadget-0@mail.sdu.edu.cn>
References: <20261118-324f82bd41-usb-gadget-0@mail.sdu.edu.cn>
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
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0aa1eeff090603a1kunm8266b8a11a0aa5
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVkZSkJDVhpPSkJLGB1PTk1MGFYeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlKS0pVTE1VSU9CVU1KWVdZFhoPEhUdFFlBWU9LSFVKS0lCQ0
	NMVUpLS1VLWQY+
DKIM-Signature: a=rsa-sha256;
	b=HrES4Tp44DGQexBDvC2aVamA/bscbe+hZ2E8EVhnkiSq/sXlJiPNQjkWO/rFbdwDE1jlPnuJPpRNbDegiCb0KRxAdkZRc0kTZG+NSWhvKKBxuu//ifvpIVcdYlGaed8zmNjn81+Mb0Evp+bznl8hhHBXmw/oViXnWNl8E72gKE8=; c=relaxed/relaxed; s=default; d=mail.sdu.edu.cn; v=1;
	bh=0sSkgJi+Iy6AbBDGZ/m3UoHILo4pwmgba+6jz8hywfI=;
	h=date:mime-version:subject:message-id:from;
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

usb_del_gadget_udc() can drop the last gadget device reference and call
fsl_udc_release(), which frees udc_controller. The remaining remove path
then dereferences it to release its requests, endpoints and DMA pool.

Hold a gadget device reference until this cleanup has finished.

This issue was found by our static analysis tool under development.

Fixes: eab35c4e6d95 ("usb: gadget: fsl_udc_core: let udc-core manage gadget->dev")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <liguangshuo@mail.sdu.edu.cn>
---
 drivers/usb/gadget/udc/fsl_udc_core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/usb/gadget/udc/fsl_udc_core.c b/drivers/usb/gadget/udc/fsl_udc_core.c
index 878d70b55530..9d9d2164c5bf 100644
--- a/drivers/usb/gadget/udc/fsl_udc_core.c
+++ b/drivers/usb/gadget/udc/fsl_udc_core.c
@@ -2537,6 +2537,7 @@ static void fsl_udc_remove(struct platform_device *pdev)
 	DECLARE_COMPLETION_ONSTACK(done);
 
 	udc_controller->done = &done;
+	get_device(&udc_controller->gadget.dev);
 	usb_del_gadget_udc(&udc_controller->gadget);
 
 	/* DR has been stopped in usb_gadget_unregister_driver() */
@@ -2554,6 +2555,7 @@ static void fsl_udc_remove(struct platform_device *pdev)
 		release_mem_region(res->start, resource_size(res));
 
 	/* free udc --wait for the release() finished */
+	put_device(&udc_controller->gadget.dev);
 	wait_for_completion(&done);
 
 	/*
-- 
2.43.0


