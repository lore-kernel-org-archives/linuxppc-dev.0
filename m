Return-Path: <linuxppc-dev+bounces-27571-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDD66C982D1
	for <linuxppc-dev@archiver.kernel.org>; Thu, 17 Sep 2026 13:07:29 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hlwym2mHyz2y8G;
	Thu, 17 Sep 2026 23:07:28 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.28.52
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789648309;
	cv=none; b=hZV/pCSvwMjj7SI1Z8VLKejTcyd7Jl+ION3xOmqeOGVk+CtbQAQmodSK6vXh7hwZnudcpUC4TGRuEa3yHAlA3jIXH0o4vaohtg2ViUFNKXkYLjeOaXcveS6aDJ7BB720WGqIWMAFYsI7zBoZuFa72BfT7DMRU+9kBlHFYvZlJIRfaxAMo0GHF3EEIm4LFEvyDtNi0e/iSyoujkyWz7B6s4IpFoWI0QyBZuFUQAr0GCMiibpDyONiD+vNTRwpgvB+jobFKQkw8wlzVBDckKak5GHlUYm5LhvGX9EjeZvyg3ZA/IBJ3ZOdySWRKEfCJB3mxtvPWuXpf5STKP6SuGDB2w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789648309; c=relaxed/relaxed;
	bh=P5lw9hhVO/HWDptR38l1sHYaWyT1zdds3SbCv75Wjq4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=emE4hEINanc2ZOeDff7K9XWd2fGirSXZybh0siuRVYtb2RcUivZelXUrSFCeMZv52Dy3syze1xFURFXzRT92YIEpnWrYCcfCci8feQiw/fyyJk8EqLoS04k/0kEsKekpL9cmeXDRxmwfQLYhWEvt9SItl5YYSmLHnTVu3abqc+kQwDHYWCM2+6MrdryR0J2tZlkIJbGaTGOzdBXPBrj4KMP0ZPJxr64KAwwMgGJ8i+c4VAEsK433uELnBfbygE+vZ+TP5wYGsIyC2TnbtvSRM+ITrh08aOY3WOsKr+jk/nmlv3AqFHoSdi0Z+CV1dWULGu8zZg42QUJ/znWrYf/nlg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=xiaopeng.com; dkim=pass (1024-bit key; unprotected) header.d=xiaopeng.com header.i=@xiaopeng.com header.a=rsa-sha256 header.s=default header.b=hK0bE3xj; dkim-atps=neutral; spf=pass (client-ip=115.124.28.52; helo=out28-52.mail.aliyun.com; envelope-from=liuc63@xiaopeng.com; receiver=lists.ozlabs.org) smtp.mailfrom=xiaopeng.com
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=xiaopeng.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=xiaopeng.com header.i=@xiaopeng.com header.a=rsa-sha256 header.s=default header.b=hK0bE3xj;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=xiaopeng.com (client-ip=115.124.28.52; helo=out28-52.mail.aliyun.com; envelope-from=liuc63@xiaopeng.com; receiver=lists.ozlabs.org)
Received: from out28-52.mail.aliyun.com (out28-52.mail.aliyun.com [115.124.28.52])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hlw9b44Jwz2y2Q
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Sep 2026 22:31:44 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xiaopeng.com; s=default;
	t=1789648299; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=P5lw9hhVO/HWDptR38l1sHYaWyT1zdds3SbCv75Wjq4=;
	b=hK0bE3xjZYm90N8m8LB0AMAaDuL+bbln5NcFuv1PGQV+Cq8vyxs3b7g6L4KKH426Y9fuP36gYPxWI3OqjQ7UkbxVpvSm80zkKL1KT4qtymwPgyClLPDvO6rGLUasrhsa/prI3gm8tvinFwBzLe46tmdiDJinNk740ELAoisil0c=
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.07765399|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.0194029-0.00114363-0.979454;FP=12020485485498140115|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033037028158;MF=liuc63@xiaopeng.com;NM=1;PH=DS;RN=7;RT=7;SR=0;TI=SMTPD_---.jFyaSJF_1789648295;
Received: from localhost(mailfrom:liuc63@xiaopeng.com fp:SMTPD_---.jFyaSJF_1789648295 cluster:ay29)
          by smtp.aliyun-inc.com;
          Thu, 17 Sep 2026 20:31:36 +0800
From: Liu Chao <liuc63@xiaopeng.com>
To: gregkh@linuxfoundation.org
Cc: linux-usb@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	liuwb@xiaopeng.com,
	Liu Chao <liuc63@xiaopeng.com>
Subject: [PATCH] usb: gadget: fsl_udc: validate pipe index in ch9getstatus()
Date: Thu, 17 Sep 2026 20:31:33 +0800
Message-ID: <20260917123133.3760392-1-liuc63@xiaopeng.com>
X-Mailer: git-send-email 2.50.1
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
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ch9getstatus() uses get_pipe_by_windex() to compute a pipe index from
the host-supplied wIndex field and then passes it to get_ep_by_pipe()
to index the udc->eps[] array.  get_pipe_by_windex() can return up to
31, but udc->eps[] is allocated with udc->max_ep entries (typically
8-16 depending on the hardware).

The SET/CLEAR_FEATURE handler in the same function already checks
'pipe >= udc->max_ep' (line 1431) before indexing, but the GET_STATUS
path omits this check, allowing an out-of-bounds access.

Add the same pipe >= max_ep guard to the GET_STATUS endpoint path,
matching the existing check in the feature handler.

Fixes: b504882df105 ("USB: add Freescale high-speed USB SOC device controller driver")
Cc: stable@vger.kernel.org
Reviewed-by: Weibin Liu <liuwb@xiaopeng.com>
Signed-off-by: Liu Chao <liuc63@xiaopeng.com>
---
 drivers/usb/gadget/udc/fsl_udc_core.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/gadget/udc/fsl_udc_core.c b/drivers/usb/gadget/udc/fsl_udc_core.c
index 20392409a..ed70cc650 100644
--- a/drivers/usb/gadget/udc/fsl_udc_core.c
+++ b/drivers/usb/gadget/udc/fsl_udc_core.c
@@ -1344,8 +1344,12 @@ static void ch9getstatus(struct fsl_udc *udc, u8 request_type, u16 value,
 	} else if ((request_type & USB_RECIP_MASK) == USB_RECIP_ENDPOINT) {
 		/* Get endpoint status */
 		struct fsl_ep *target_ep;
+		int pipe = get_pipe_by_windex(index);
 
-		target_ep = get_ep_by_pipe(udc, get_pipe_by_windex(index));
+		if (pipe >= udc->max_ep)
+			goto stall;
+
+		target_ep = get_ep_by_pipe(udc, pipe);
 
 		/* stall if endpoint doesn't exist */
 		if (!target_ep->ep.desc)
-- 
2.50.1


