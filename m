Return-Path: <linuxppc-dev+bounces-22033-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5468CCD6E6B
	for <linuxppc-dev@archiver.kernel.org>; Thu,  4 Jun 2026 13:20:06 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gWQCd1DVTz3brR;
	Thu, 04 Jun 2026 23:19:57 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::32c"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780579197;
	cv=none; b=f66wlfmoXaBCq9BVhwfJsPQ/9CMZH30m0u2f+e+RYlTrBb3rVlzdq//XJLTH6sH54LR0HSUS8gx+HgTIyTsDUlz5dv9dPcyOCYYqcxyRTkYHbde62daGCNGRGD0b1uy6+RPx2CGKeaD2o8my7MZSIhfsGT8UYEroRIHsP54dI6TwhRCgZfFhRDuzw6wwccc1SY63kMCZS3K1Y5le+xx6rEqs9h801UJ5x6TEDCCSwt9T+YfpcBhs5BHA3oUaLCzYS/nVG3T0+FzMI4Ud6XQ9O1mMgUa332Sw1pFw31xqHcrDmDJKvGobangPLFTMetoSaj9jO7RidXORcbS8LkacCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780579197; c=relaxed/relaxed;
	bh=aaZcDuR1/GVoL4knmseDPUzz2J8S5y/tkogd7uxcn0M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=F7VzDJo10J9wnUi8E+gTCTmdR76Hai1RDHQLMyeMqxiOWtYatpbWchKP6cZ4RsKKUMI3VKNw9wdPJKJcYzxyIJT8oeIwiOc+lxrz4qem6KWmf+JebJvZqrIBUq3Nu04d0RuTDDIysghRkiA2gFWLMgceXFrJXbNNH7ptZLYum4WbhcAQhZnTqJxcwhnTrjLaiymTqna+TYRw5AXh10QQk4MKETQ0XK8BhVU9wmHnweW2qbosngsqY00QLDgUj9PYkHwBQLNQ47nW92zu5jMw5EyUz4vnR0TS8uI+F50apNAwFWerhFRpIc/GnO68eJ8Ch0FFVN4JhzR1VxxRMnIVGg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=AhOrDMpI; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::32c; helo=mail-wm1-x32c.google.com; envelope-from=iacobcatalin@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=AhOrDMpI;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::32c; helo=mail-wm1-x32c.google.com; envelope-from=iacobcatalin@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gWQCc0fsmz2ytv
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 04 Jun 2026 23:19:56 +1000 (AEST)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-49068493267so5807225e9.1
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 04 Jun 2026 06:19:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780579193; x=1781183993; darn=lists.ozlabs.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aaZcDuR1/GVoL4knmseDPUzz2J8S5y/tkogd7uxcn0M=;
        b=AhOrDMpIH5WKwbRu5WywoE1H5yUnJyeOHm4aUW+0F2PVu7qVQyttfJPVmQ8zJMUCE5
         IanzowNsk8q1dOAp/U7ZXjNGh+Y798j+9On8RDDcpgP8PMFQyU1tGhBcYcT+POYSbmBc
         Zgbi+orIMibNb4WUy+OaSWpXDDzK0LYInghC9bi7nzod7OngRNmompOLV3Jb+ctNNgKD
         uKDbkbsREvTD4fS3lHkVzTDyBUxHl0s0JAMr2DkIVWH5jRgx9AKd61oYsiHBcBbUHRvY
         LTiFm31MezTBk4eCB0Pkk9qbV/crD+dbKrbdskePyeO1bYM/95MlMmxxrCPxL5GNgXJA
         OngA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780579193; x=1781183993;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=aaZcDuR1/GVoL4knmseDPUzz2J8S5y/tkogd7uxcn0M=;
        b=NiEcQxa33+1GWA40NdmKP2hSpqr672RhgogGoNLF80SKPaXwZEyeOJ5N5fW9YCSe9S
         3hQvJ5yYogr4fzz6KIaIRnt6t+SZ/nU6OjAM37z1c0m8suozRDVmydQlOJrnkm/FVBeu
         jGlqUpFwQbRjiPwIOW+HwxPtTAamhGR0kDB64HpQ8AvNilz4PHEVfqj54Ybs3N77xZRM
         rrDS0azAj/OKn1oz7Phl2CVJALPDdzyS49s/opqEmeam5LB50ybHbB6Va2ADwcaKrqBI
         tfozx3znEc1wgweWR6+w5wM08TS2+ma552wU/Ppeu/uKJECNbJ+SnI1fEK6wn70ft6Cg
         8IWQ==
X-Forwarded-Encrypted: i=1; AFNElJ/cQSdocl0qovfQr77/KPui9BVjFAlRhMghq8T2VKfXszQsexqGPBL4IhUsdTFBHEsmi5a2923Udp5Jwzk=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YzCMO9Zp7Feg3Qmo5oOezPWoAqoBDSSp1osvyyA8Q/IQ1ymbXBX
	31ueNo5P2nKwIvB5M0AVnD/WDz/nuZ/jyoWjkCMbkfyFQrnYF3hU2Iap
X-Gm-Gg: Acq92OG7M/bRTUBb9zZ8yYMJQqqLmrvEo6J4mhSumVReRU4hCqV7etgCe4Hf4d8RzU9
	muCzLllyi6vCvcm+9kJKkSEuuXlMzx5dIqcHUQ6U6b7UGSytVnMBJOF47JCNblQCJeNLvOEkC6/
	9bLORz86yVGgp4uHjP1ByOH0WDtfy9J+9lYrzrwwGYDi7dLjI/VhcKtsY75haKGa/SZHZjUngsd
	tLrVKT/KLrOaQuFTG58PU3fyvyF68T9RVsl45FxCX2xhhIJ3liCxLr6G6zNJ3YRcvrs1FjSrCH9
	mu8nfwEMZKJ+osi+O7iN5Jd69JTRRUJiT0fDgtn47SAzsQiZm5SEAS8iO6+mxdZYedGVEbk7+eq
	Q4rC3GwKGm1cXf6Lu4+nvx5YfDZeM70GTw6dlRGgwNfmFQ7jBpHA8DF/NcPTrVHnz2JAQSvmCcf
	iKAl7TV/a/wdHJWUEYEpFxoKDrn3gHdfig
X-Received: by 2002:a05:600c:a09:b0:490:958f:2a5c with SMTP id 5b1f17b1804b1-490b5ed6375mr133235845e9.17.1780579192962;
        Thu, 04 Jun 2026 06:19:52 -0700 (PDT)
Received: from localhost ([94.53.77.213])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490b7a52dacsm7715545e9.1.2026.06.04.06.19.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2026 06:19:52 -0700 (PDT)
From: Catalin Iacob <iacobcatalin@gmail.com>
Date: Thu, 04 Jun 2026 16:20:25 +0300
Subject: [PATCH v3 2/6] scsi: core: Move scsi_device_from_queue() to
 scsi_priv.h
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260604-remove-pktcdvd-references-v3-2-e2f06fb4eef4@gmail.com>
References: <20260604-remove-pktcdvd-references-v3-0-e2f06fb4eef4@gmail.com>
In-Reply-To: <20260604-remove-pktcdvd-references-v3-0-e2f06fb4eef4@gmail.com>
To: Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
 Madhavan Srinivasan <maddy@linux.ibm.com>, 
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, 
 Rich Felker <dalias@libc.org>, 
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, 
 "David S. Miller" <davem@davemloft.net>, 
 Andreas Larsson <andreas@gaisler.com>, 
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, 
 "Martin K. Petersen" <martin.petersen@oracle.com>, 
 Jens Axboe <axboe@kernel.dk>, Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linuxppc-dev@lists.ozlabs.org, linux-sh@vger.kernel.org, 
 sparclinux@vger.kernel.org, linux-scsi@vger.kernel.org, 
 Catalin Iacob <iacobcatalin@gmail.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1518;
 i=iacobcatalin@gmail.com; h=from:subject:message-id;
 bh=9eVs5ZEWu5PvYIeNWvEPYnAIntZhT6pYVPj8oRQzPMQ=;
 b=owGbwMvMwCX261qtXAKXKjvjabUkhizF6vU3LqT3G94r9cqys+vtuZina/9q/t07UmFefy8un
 b3PXWxjRykLgxgXg6yYIsuLc9fbNuw5E3Avya4FZg4rE8gQBi5OAZiI+zSGf0qLXDQLS2uXPT03
 Kf2kWOsWYcVL01cdWXVcSm7NuVPX+4MZGWZd0Pu7+WuqS5Kxo3SX/azfa+t/Oh0x/i7Au8Di5/Q
 djEwA
X-Developer-Key: i=iacobcatalin@gmail.com; a=openpgp;
 fpr=F609BFABD84EB5C9DDDC37EDE89C6A3571CD0E33

scsi_device_from_queue() is only referenced in drivers/scsi so move its
prototype to drivers/scsi/scsi_priv.h.

Signed-off-by: Catalin Iacob <iacobcatalin@gmail.com>
---
 drivers/scsi/scsi_priv.h   | 1 +
 include/scsi/scsi_device.h | 1 -
 2 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/scsi_priv.h b/drivers/scsi/scsi_priv.h
index 7a193cc04e5b..37e5601be2b8 100644
--- a/drivers/scsi/scsi_priv.h
+++ b/drivers/scsi/scsi_priv.h
@@ -102,6 +102,7 @@ void scsi_eh_done(struct scsi_cmnd *scmd);
 
 /* scsi_lib.c */
 extern void scsi_device_unbusy(struct scsi_device *sdev, struct scsi_cmnd *cmd);
+extern struct scsi_device *scsi_device_from_queue(struct request_queue *q);
 extern void scsi_queue_insert(struct scsi_cmnd *cmd,
 			      enum scsi_qc_status reason);
 extern void scsi_io_completion(struct scsi_cmnd *, unsigned int);
diff --git a/include/scsi/scsi_device.h b/include/scsi/scsi_device.h
index 9c2a7bbe5891..9f716497a959 100644
--- a/include/scsi/scsi_device.h
+++ b/include/scsi/scsi_device.h
@@ -407,7 +407,6 @@ void scsi_attach_vpd(struct scsi_device *sdev);
 void scsi_cdl_check(struct scsi_device *sdev);
 int scsi_cdl_enable(struct scsi_device *sdev, bool enable);
 
-extern struct scsi_device *scsi_device_from_queue(struct request_queue *q);
 extern int __must_check scsi_device_get(struct scsi_device *);
 extern void scsi_device_put(struct scsi_device *);
 extern struct scsi_device *scsi_device_lookup(struct Scsi_Host *,

-- 
2.54.0


