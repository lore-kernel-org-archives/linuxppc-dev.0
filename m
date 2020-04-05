Return-Path: <SRS0=yY75=5V=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5049FC2BA19
	for <linuxppc-dev@archiver.kernel.org>; Sun,  5 Apr 2020 23:14:24 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 976DB20659
	for <linuxppc-dev@archiver.kernel.org>; Sun,  5 Apr 2020 23:14:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=daynix-com.20150623.gappssmtp.com header.i=@daynix-com.20150623.gappssmtp.com header.b="jJyCDymm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 976DB20659
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 48wTyN5wK1zDr0Q
	for <linuxppc-dev@archiver.kernel.org>; Mon,  6 Apr 2020 09:14:20 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=none (no SPF record) smtp.mailfrom=daynix.com
 (client-ip=2a00:1450:4864:20::141; helo=mail-lf1-x141.google.com;
 envelope-from=andrew@daynix.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=daynix.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=daynix-com.20150623.gappssmtp.com
 header.i=@daynix-com.20150623.gappssmtp.com header.a=rsa-sha256
 header.s=20150623 header.b=jJyCDymm; dkim-atps=neutral
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com
 [IPv6:2a00:1450:4864:20::141])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 48wPxm4p5jzDqQt
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  6 Apr 2020 06:13:27 +1000 (AEST)
Received: by mail-lf1-x141.google.com with SMTP id t11so10094088lfe.4
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 05 Apr 2020 13:13:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=ZecswmQzcKyJcaA1KVr1PgDOFuDkBa9m5xQm0CMlRfg=;
 b=jJyCDymm6a4Y4wyhQ19mQrdIHDOuRafStVA1S1Ig6u2VsstNNG+WN5ithcMu/UoDhe
 CJm6CNrO5du/C461KF08IoNM6ixV+wdPZH8150mM/yVeqUBK51IxAnWz7mKOY839n8aW
 d7cHEB5htx7FQ8+DMQOGIPAUPdAP2iIaT8fdrFL0ztPZz0GCoILB7X3WnENer2eAJskQ
 eeo1VWbmuMKB2MUvYRbouX1S5SlVWKrKQ6M6xDtskZYZDXj9EBjSi5jMaCUjXzgkBOze
 jU3zjVkxzmHp8gl2mo4gFFASzkAJPg2bF21TLTOydSfR8DchzsZcVw7KD93PqUSsu39Y
 78tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=ZecswmQzcKyJcaA1KVr1PgDOFuDkBa9m5xQm0CMlRfg=;
 b=dbFNUHlVW923idcEAIojVLVHoqdfk3IItRs9pjJ8VEbFNwMBLbcm4iOC5w4mTu3y9f
 fW+Ks5+lQPtf688ftaZAz8kvor3T/7QF5umpLF9lT7mrdQAl8GNcnw7vbHYgg5gHGr0B
 e3oG9KMoXYGezF1vVRtfb3iJ/YJbn/9A9kOvTaQZ/ubGcVGGa67muNSsJoWiBA1iBols
 9tiFjkrT2tiDqX74j23iM04oO7YeSqjXIj7hGCnOFxR/l3dVA1aGHq0scVF5ae8tTHPs
 RmTfx12gs3yFhYp8bJMQ6iA9XA6Q9SBRVD2o45Ammh4gFkn1kdmgAJfYsJFpYHoAHT+g
 fKbQ==
X-Gm-Message-State: AGi0PuZkklDWeiAcVEeFt10mHMbK9RtLssVxyKIo9SXmlo5fwjWeSKhm
 lMiVTrY9MEN6ncAywicw8c0Iqw==
X-Google-Smtp-Source: APiQypIEsOpmUVRbUVIGQF9PTFmAXeRwenTbMDANUZ4VQGITx+F9m6bijBqeMQEHZ9PikkiF90Ex9A==
X-Received: by 2002:ac2:4143:: with SMTP id c3mr4585061lfi.131.1586117602906; 
 Sun, 05 Apr 2020 13:13:22 -0700 (PDT)
Received: from navi.cosmonova.net.ua ([95.67.24.131])
 by smtp.gmail.com with ESMTPSA id m1sm5450815lfl.69.2020.04.05.13.13.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 Apr 2020 13:13:22 -0700 (PDT)
From: andrew@daynix.com
To: virtualization@lists.linux-foundation.org
Subject: [PATCH] Fix: buffer overflow during hvc_alloc().
Date: Sun,  5 Apr 2020 23:40:24 +0300
Message-Id: <20200405204024.1007843-1-andrew@daynix.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 06 Apr 2020 09:12:42 +1000
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
Cc: gregkh@linuxfoundation.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, jslaby@suse.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

From: Andrew Melnychenko <andrew@daynix.com>

If there is a lot(more then 16) of virtio-console devices
or virtio_console module is reloaded
- buffers 'vtermnos' and 'cons_ops' are overflowed.
In older kernels it overruns spinlock which leads to kernel freezing:
https://bugzilla.redhat.com/show_bug.cgi?id=1786239

Signed-off-by: Andrew Melnychenko <andrew@daynix.com>
---
 drivers/tty/hvc/hvc_console.c | 23 ++++++++++++++---------
 1 file changed, 14 insertions(+), 9 deletions(-)

diff --git a/drivers/tty/hvc/hvc_console.c b/drivers/tty/hvc/hvc_console.c
index 27284a2dcd2b..436cc51c92c3 100644
--- a/drivers/tty/hvc/hvc_console.c
+++ b/drivers/tty/hvc/hvc_console.c
@@ -302,10 +302,6 @@ int hvc_instantiate(uint32_t vtermno, int index, const struct hv_ops *ops)
 	vtermnos[index] = vtermno;
 	cons_ops[index] = ops;
 
-	/* reserve all indices up to and including this index */
-	if (last_hvc < index)
-		last_hvc = index;
-
 	/* check if we need to re-register the kernel console */
 	hvc_check_console(index);
 
@@ -960,13 +956,22 @@ struct hvc_struct *hvc_alloc(uint32_t vtermno, int data,
 		    cons_ops[i] == hp->ops)
 			break;
 
-	/* no matching slot, just use a counter */
-	if (i >= MAX_NR_HVC_CONSOLES)
-		i = ++last_hvc;
+	if (i >= MAX_NR_HVC_CONSOLES) {
+
+		/* find 'empty' slot for console */
+		for (i = 0; i < MAX_NR_HVC_CONSOLES && vtermnos[i] != -1; i++) {
+		}
+
+		/* no matching slot, just use a counter */
+		if (i == MAX_NR_HVC_CONSOLES)
+			i = ++last_hvc + MAX_NR_HVC_CONSOLES;
+	}
 
 	hp->index = i;
-	cons_ops[i] = ops;
-	vtermnos[i] = vtermno;
+	if (i < MAX_NR_HVC_CONSOLES) {
+		cons_ops[i] = ops;
+		vtermnos[i] = vtermno;
+	}
 
 	list_add_tail(&(hp->next), &hvc_structs);
 	mutex_unlock(&hvc_structs_mutex);
-- 
2.24.1

