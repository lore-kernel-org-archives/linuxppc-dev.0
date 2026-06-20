Return-Path: <linuxppc-dev+bounces-22847-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4813CDB46B
	for <linuxppc-dev@archiver.kernel.org>; Sat, 20 Jun 2026 12:09:23 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gjCtn52YXz3bpx;
	Sat, 20 Jun 2026 22:09:21 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=220.197.31.2
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781957361;
	cv=none; b=UfGksH/1vjeIeDuwfD7AzQdCxnwwqpdCcTenJLDCcbRi3aMxmr4DyMsqsb9Bt9GqHMqEQmZi6hxqOMikvO4zXDMaiRnh9YTb4OysrupsTfHhywRsV4atjsciVGaUK5+5dR0M58G0Khri1ECEInRXTIQ7avHHpQBSNoGXa6mi2hDCLwHnR0IwED6Q2ClOmcJHoyao2D+3yg6DP5tkzHLxRZCdXoGZ2DPH3nzAi2p1cbrGyhlHSJbnfzSrkBGEf93JHCDl30Blv1fMj8mQsVGLyAgAd+zQkIi0IF8/eHxQag7BCg/Y2eOPiLlWce5JJHhsEsMCVlEmE0h4QBkfbui+vg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781957361; c=relaxed/relaxed;
	bh=+KTI0mDZMF3AYyK23FmAyqNncU+sjW5XAXd7jr2Trm4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ZmcBTtfKGR5Wv6jQ4LTKJQpJj284odG914T3SsnwosGG8tXuECtgas5hwllMKTh64HZI71XTSQYU7I51efmKiOafmXljHteMD8rMsXwiAliczS3XkLbtUQVgUPG3Om0NrJw8lzbu9eJiGvwdA11mu6Hk0e3QgdiXSLoPL9FQZeJeClhU6msjT5bW0Ghu7h9RPfIYpuupVOu0FbUkBnhsQFcHf4b3m/ZEuDh9ZVEeEJO3sv/KDiVbbL8m8noJXistweTnl21Pkl+usFohiYTa54NVWIPxQUkQrEYovPkXiMJzHrv1GZkT6DqMvtzafF/+KupkiB5uU6jEekBWVSI8Aw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=163.com; dkim=pass (1024-bit key; unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=nWsolaHb; dkim-atps=neutral; spf=pass (client-ip=220.197.31.2; helo=m16.mail.163.com; envelope-from=haoxiang_li2024@163.com; receiver=lists.ozlabs.org) smtp.mailfrom=163.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=nWsolaHb;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=163.com (client-ip=220.197.31.2; helo=m16.mail.163.com; envelope-from=haoxiang_li2024@163.com; receiver=lists.ozlabs.org)
X-Greylist: delayed 138 seconds by postgrey-1.37 at boromir; Sat, 20 Jun 2026 22:09:18 AEST
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gjCtk4R0jz2xwL
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 20 Jun 2026 22:09:16 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=+K
	TI0mDZMF3AYyK23FmAyqNncU+sjW5XAXd7jr2Trm4=; b=nWsolaHbpdr7QNCQT2
	vitVIKVmkd1qooYJJyWIllifZFvgE8AaDV+uEZ8aqf8Pf9Tz9IjWkq5QycW5AQQY
	pdksl2X2Ztb/2kCJQaIIsIQUsPGlb0I3USNVHWRgVXL6uw0TLG7xhk3xw0d9S2zX
	qqfEjMUQz5yznY3D0lp7DMXKw=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g0-4 (Coremail) with SMTP id _____wB3ROVIgjZqsf9PEw--.43408S2;
	Sat, 20 Jun 2026 20:06:33 +0800 (CST)
From: Haoxiang Li <haoxiang_li2024@163.com>
To: kees@kernel.org,
	gregkh@linuxfoundation.org
Cc: linux-usb@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	Haoxiang Li <haoxiang_li2024@163.com>
Subject: [PATCH] usb: fsl_qe_udc: check qe_alloc_request() failure in ch9getstatus()
Date: Sat, 20 Jun 2026 20:06:31 +0800
Message-Id: <20260620120631.2894977-1-haoxiang_li2024@163.com>
X-Mailer: git-send-email 2.25.1
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
X-CM-TRANSID:_____wB3ROVIgjZqsf9PEw--.43408S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Cw43XryDtrWrKw43Gr4rKrg_yoW8GrW3pF
	W5JrWjyFW8Zr4vya1UJr4kZa45Ca97Cry7KrWIq3yS9FnxJw4kCay5Kry0qr4xAFW8Gr42
	gFsYgrnxAw47KrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pRqZXUUUUUU=
X-Originating-IP: [240e:604:311:e68d:6113:4bb1:7711:7d42]
X-CM-SenderInfo: xkdr5xpdqjszblsqjki6rwjhhfrp/xtbCxQnaSWo2gkkr-gAA3d

qe_alloc_request() may return NULL on allocation failure. ch9getstatus()
passes the return value directly to container_of() and then immediately
dereferences the resulting qe_req pointer. Check the allocation result
before using it and stall the control request on failure.

Signed-off-by: Haoxiang Li <haoxiang_li2024@163.com>
---
 drivers/usb/gadget/udc/fsl_qe_udc.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/gadget/udc/fsl_qe_udc.c b/drivers/usb/gadget/udc/fsl_qe_udc.c
index bf87285ad13c..603c77ff129f 100644
--- a/drivers/usb/gadget/udc/fsl_qe_udc.c
+++ b/drivers/usb/gadget/udc/fsl_qe_udc.c
@@ -1945,6 +1945,7 @@ static void ch9getstatus(struct qe_udc *udc, u8 request_type, u16 value,
 			u16 index, u16 length)
 {
 	u16 usb_status = 0;
+	struct usb_request *usb_req;
 	struct qe_req *req;
 	struct qe_ep *ep;
 	int status = 0;
@@ -1983,8 +1984,11 @@ static void ch9getstatus(struct qe_udc *udc, u8 request_type, u16 value,
 		}
 	}
 
-	req = container_of(qe_alloc_request(&ep->ep, GFP_KERNEL),
-					struct qe_req, req);
+	usb_req = qe_alloc_request(&ep->ep, GFP_KERNEL);
+	if (!usb_req)
+		goto stall;
+
+	req = container_of(usb_req, struct qe_req, req);
 	req->req.length = 2;
 	req->req.buf = udc->statusbuf;
 	*(u16 *)req->req.buf = cpu_to_le16(usb_status);
-- 
2.25.1


