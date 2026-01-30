Return-Path: <linuxppc-dev+bounces-16425-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47428D49C64
	for <linuxppc-dev@archiver.kernel.org>; Fri, 30 Jan 2026 07:29:52 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4f2SML625Jz30Lw;
	Fri, 30 Jan 2026 18:29:50 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:7c80:54:3::133"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1769758190;
	cv=none; b=YTry7a8FiWvxV7iAWJZ1feMjsfDeDitFf/kef/dJVEpc5MQgdnN2zw9/pBjqiZxaJHyGVNc5Du20V2DBWrvsTBaN5kv626akHyMcwGf4h4XKmeLyBwDBQRoq2zolKgiHaH/UBIjo6XmgC7HMI42jZHYjIeh4KiSQvIwN8eeApz63CMFrI55LW7o3ArkhFRwiZcC7uBgfzZ0U/iXdXdGYiXHulsdse80N4kMtDgMdOOwERG8pa8tn1xVLEGaxYLej/dggv5sUGEWabyfFsc1jr/ZVBUxtZEMnCEM8gcSIDtXRn4HPBEFJwfPuCPu8xRi+YyDwd2/Rf0uLRYaJRKFFfA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1769758190; c=relaxed/relaxed;
	bh=1q7l3cf0hPLD0O5rGHsZ/nxvzquqh1DhwSv089uPgvw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ImfCnvE/1fLzN5twp9XNzlcAxI2eAr/ayQTLNkCB2iMZNci9ULxvhNSVt4nRw12HAKzxfiiM8IsQHPPGkZjAzTYVrpliAW+ReV1ht7Lu+Z/mt316P8gmMou/eXUbLkqnLUHRl9kSdmVi5XbYZRFPN5UarwhrLBtp6nG5JVWvc4EwOyzDWG94icbnU6Vvi0o1eM6KP6bR99LJ61I5hj7a7xq+W2aO4P17ZIU9GZ5uzCuUeXXjJAe63sL8MrznBQNsJGcR3tKgtF4prSQLpN7neDE6gAr0X8L0N/P0QO5QXV2hNuOZKqagT8UXHOSLMR5ypFYJ/N78mXPXwLTCxPmWkQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=infradead.org; dkim=pass (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=37q1F1+I; dkim-atps=neutral; spf=none (client-ip=2607:7c80:54:3::133; helo=bombadil.infradead.org; envelope-from=rdunlap@infradead.org; receiver=lists.ozlabs.org) smtp.mailfrom=infradead.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=37q1F1+I;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record) smtp.mailfrom=infradead.org (client-ip=2607:7c80:54:3::133; helo=bombadil.infradead.org; envelope-from=rdunlap@infradead.org; receiver=lists.ozlabs.org)
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4f2SMF0MS8z30FF
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 30 Jan 2026 18:29:43 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=1q7l3cf0hPLD0O5rGHsZ/nxvzquqh1DhwSv089uPgvw=; b=37q1F1+IGMJHE3H3pez/SK5TwD
	GyDPjg6knF5AqQOTNXY6IbB0f7SRq6eWLcdIPbJn7Io/tC5kGtNj/lDlosEWQLjeVdVba1lWr11pR
	c2PVIuAZPt6St8c9X6/fQitseCUQ7CkUkNEvktgDu30micPiFePqUVD5/pI8QWnNHKg7syhVZB+cq
	mczCWgUtopj70MgvONsz06UNJ6pr9R4Lxba+pq13Jgh5GUem51eWVcjKRtcxPuLWKlZ8A7sXi3q+T
	JWH3GpM+zqXlpZGoSaa+vy9ym/tQRCVA5cSXyKbNCp+IqamvmV6qoo6RwXszc2mx3if+Y633jzB0F
	myUeIcJQ==;
Received: from [50.53.43.113] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vliwm-000000019KS-0lqa;
	Fri, 30 Jan 2026 07:29:40 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	=?UTF-8?q?Ahelenia=20Ziemia=C5=84ska?= <nabijaczleweli@nabijaczleweli.xyz>,
	Hendrik Brueckner <brueckner@linux.vnet.ibm.com>,
	linuxppc-dev@lists.ozlabs.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	linux-serial@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	"Borislav Petkov (AMD)" <bp@alien8.de>
Subject: [PATCH] tty: hvc_iucv: fix off-by-one in number of supported devices
Date: Thu, 29 Jan 2026 23:29:37 -0800
Message-ID: <20260130072939.1535869-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.52.0
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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

MAX_HVC_IUCV_LINES == HVC_ALLOC_TTY_ADAPTERS == 8.
This is the number of entries in:
  static struct hvc_iucv_private *hvc_iucv_table[MAX_HVC_IUCV_LINES];

Sometimes hvc_iucv_table[] is limited by:
(a)	if (num > hvc_iucv_devices) // for error detection
or
(b)	for (i = 0; i < hvc_iucv_devices; i++) // in 2 places
(so these 2 don't agree; second one appears to be correct to me.)

hvc_iucv_devices can be 0..8. This is a counter.
(c)	if (hvc_iucv_devices > MAX_HVC_IUCV_LINES)

If hvc_iucv_devices == 8, (a) allows the code to access hvc_iucv_table[8].
Oops.

Fixes: 44a01d5ba8a4 ("[S390] s390/hvc_console: z/VM IUCV hypervisor console support")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
---
No, I haven't seen an issue with this out in the wild.

Cc: Ahelenia Ziemiańska <nabijaczleweli@nabijaczleweli.xyz>
Cc: Hendrik Brueckner <brueckner@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jirislaby@kernel.org>
Cc: linux-serial@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: "Borislav Petkov (AMD)" <bp@alien8.de>

 drivers/tty/hvc/hvc_iucv.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-next-20260128.orig/drivers/tty/hvc/hvc_iucv.c
+++ linux-next-20260128/drivers/tty/hvc/hvc_iucv.c
@@ -130,7 +130,7 @@ static struct iucv_handler hvc_iucv_hand
  */
 static struct hvc_iucv_private *hvc_iucv_get_private(uint32_t num)
 {
-	if (num > hvc_iucv_devices)
+	if (num >= hvc_iucv_devices)
 		return NULL;
 	return hvc_iucv_table[num];
 }

