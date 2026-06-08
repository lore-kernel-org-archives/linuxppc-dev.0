Return-Path: <linuxppc-dev+bounces-22203-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5CBFCD8C92
	for <linuxppc-dev@archiver.kernel.org>; Mon,  8 Jun 2026 14:28:20 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gYvXg0Cbbz2ytj;
	Tue, 09 Jun 2026 00:28:19 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::32c"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780928898;
	cv=none; b=CJKX+QcVk51KTmQIiuUb75Z8hx+s+wDhRIMOXJxTCH6dYvOGYbm76P3ZX5Wv5XD/0GBy8FlG2osx6769Xyt0/1URerNBofKlwijnhAnUs84JEgEfK1ZzsP4t8xaU/TS6yMheOT+9Z+TyXjNTGndtABYFWj8n5ZSYN5/uAMtZpKRXLHii3bGJpfDC2SxRpzkI+mg/sq+gQ0D3vKZsX3rRCQgFRYEaFVXiO1dFAfYatodb5fIWW6eS9Yqh579QnLVjyYZXl3f/B3j1vva1wNTX/I+HM1gPh39YwZdmNzpsUfJHC2DcDjc+r+mnRhfSmr3kvP53JBAPCYvByWILmISHIA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780928898; c=relaxed/relaxed;
	bh=Sp2ANuSp/GV260EEmEmdmugr8RRzCxVHzflIi+KBBt8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KRxaGKTX1mZv0msdNO2HZZ/VAL4g1R7hRBny9M1T5qj8Krz3xj1PxMokOSj1q0bxQyDVvRlDT2ZlFPkMo9q1Swg3xyzXIiMdubq2xNRH8tlDN9DT/bvtkNEnAgoiv8rdmZb0LN7pVFHdqvGjlvQOWpEqagvbpp1MoH4bmhGGaOSp9Uk1xRfuZGwxoN3XqpqWuXhZw43r5qeQbB13FDcXnCyV/F80lE0NeV3vbb6RR7HZ3wYglUHYrqg9mjNytNqD/ROakqLdkzBmHkOwJvoeQZGlEcC4Tffl1xkQa6t8PbCN0EYuMP4UCpftLJ7PBzspNmy40lVnAv14l6MQVEhAbQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=m8CNSG39; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::32c; helo=mail-wm1-x32c.google.com; envelope-from=iacobcatalin@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=m8CNSG39;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::32c; helo=mail-wm1-x32c.google.com; envelope-from=iacobcatalin@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gYvXd5jSVz2yRM
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 09 Jun 2026 00:28:16 +1000 (AEST)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-490be29c1c5so56886785e9.2
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 08 Jun 2026 07:28:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780928893; x=1781533693; darn=lists.ozlabs.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Sp2ANuSp/GV260EEmEmdmugr8RRzCxVHzflIi+KBBt8=;
        b=m8CNSG39N5nHlh1RbvD1xl6Jlt/9HshJJEgSYc6X35vw2d2D98jcpci//XZLDrx9Gq
         kPxPd0R5Ev9e31tp2hWOSy+pTlNulJr0aANQSta1W414P0OFQ5ACtNJQ1FxBhNYAGgF3
         hyKvj/6TZPclt739jPsv5k33L/itvPmohazpXmTaDm6EwV7/0LfQfKwd07iJYmMcpzqT
         9bFeZ3BcMYYYg36zTGACGrCEGWmPRjAnb/cwqFC8u8HT/GUa1nVWTqZyQf4U/tOv9yv5
         AuX2SCp9YjiRCI+nMTR5hpZD7TMp+d18PKA2IDX2OPn31hvmt1OUq4jiULfUmUvdIkwq
         MzpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780928893; x=1781533693;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Sp2ANuSp/GV260EEmEmdmugr8RRzCxVHzflIi+KBBt8=;
        b=HAei1dcsy1AZ2FK7A8vlf5CDYmP6ryN+kTtMDVa7a2RWnfLhIKapVbr9adqrwWzIxL
         uZ9tnc66bkaLp6paezdysM5sPCc3kzNTq3WhU4H8vi2+8GxlkHCXMKU6uyQKsAx5cbdI
         fLMsJ3ihIrVONtfT6NgIS64+FOwhkDOW3CBurO3prGjoC62oDmr/YJLn2FDmBeK67jwv
         TPGABL3x8WY8iIK2OTvtCccG53PSCWQBxv3LTSwuUXPhz/6SyVH1iRKyKWvN+WN/Trkn
         kVJB1NtAS4IjvhF6uSC3y7O8IZtCoxZtuNqXIOrXx4s9GGEY0niUTCcYCkLi7oqzYd2e
         Q7GA==
X-Forwarded-Encrypted: i=1; AFNElJ+ZadZIpm/4eJ/kx9T43YfyAwpku1fbwmt0T/0FoMh6Fx2mOMLQPxxSFY/qnDAlF+RGdEcGl0Lr1Ycbjqo=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YydnNMysqiUKegx46xgBWmqJC6jbiEhHenROmuw+zLr7qrp59Gb
	B8P9cN9glD6qU+rJBz+L8nHCk0cmyp4XrBp5SzyxJ5qpBz2PSpYYo0YR
X-Gm-Gg: Acq92OExPE4tu+9EpUSnDIxiQLHyl+S3VI4icudAzrvAU974pO9otMbjbpzbCF7kCTH
	vmasKh01Y6i5aLR/8XsLmbH3H3jacWkpaZr4oipVT3gYy2Sug3OH9U2SaPIuGJdu7b3OtXCo77v
	ze25aehg1piDmUzQMtLAmCP7k93s1PVs+5X6Ejb/ZhayjDCNWFiOrgpPs/qNEWww/guKmYUrkVX
	re0FZ2Z45l2mFemZrbrE6LUOF3f7ph7VH3Ne/ivuLl+IRZmpvLxdHc3iUpRcKooELr0eF/nMclv
	pOEPTmCinIb+Qof4w4esEk6JsLv5bW2w8rJHfJB3ER0NFdD0bCc9wnlI786JcPfCC3/XGapHKVq
	z8dBqsGDqp84fOSxtNNydiewD/Ibq2ItK2rMiUXjVv21KhJ78e9n/GWv6WkIIHvxE8uC7dmRDJC
	UCJKuH6XuNJq0P9Kj5JU4LhQaWuIwStnDD
X-Received: by 2002:a05:600c:34cb:b0:48e:6db3:ff3a with SMTP id 5b1f17b1804b1-490c25b09a2mr267979525e9.16.1780928893422;
        Mon, 08 Jun 2026 07:28:13 -0700 (PDT)
Received: from localhost ([94.53.77.213])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490bc3cbfe4sm407415735e9.7.2026.06.08.07.28.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 07:28:13 -0700 (PDT)
From: Catalin Iacob <iacobcatalin@gmail.com>
Date: Mon, 08 Jun 2026 17:29:16 +0300
Subject: [PATCH v4 1/5] scsi: core: Remove export for
 scsi_device_from_queue()
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
Message-Id: <20260608-remove-pktcdvd-references-v4-1-72f88b04cc87@gmail.com>
References: <20260608-remove-pktcdvd-references-v4-0-72f88b04cc87@gmail.com>
In-Reply-To: <20260608-remove-pktcdvd-references-v4-0-72f88b04cc87@gmail.com>
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
 Jens Axboe <axboe@kernel.dk>
Cc: linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linuxppc-dev@lists.ozlabs.org, linux-sh@vger.kernel.org, 
 sparclinux@vger.kernel.org, linux-scsi@vger.kernel.org, 
 Catalin Iacob <iacobcatalin@gmail.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2345;
 i=iacobcatalin@gmail.com; h=from:subject:message-id;
 bh=LvrQuMufMa2jstaWqw8VwauAYnxPiY07NBjKrPJoU1M=;
 b=owGbwMvMwCX261qtXAKXKjvjabUkhiy1i/trmY8wXFU74qot2bFMQKYllkdpZl28/6LcZt/OR
 qdEq6qOUhYGMS4GWTFFlhfnrrdt2HMm4F6SXQvMHFYmkCEMXJwCMBGLYEaGGddjWhj5Nom9NZZx
 dnsg6qDb+vSPoVpBs3Rha/1MyRkLGBm+xtTJSfmev1K2/2Tr4t/P9C4Ibt+n+LLSJ2aHYv+PR4K
 sAA==
X-Developer-Key: i=iacobcatalin@gmail.com; a=openpgp;
 fpr=F609BFABD84EB5C9DDDC37EDE89C6A3571CD0E33

Commit 1cea5180f2f8 ("block: remove pktcdvd driver") left behind an
export that is now dead code. Remove it and move the declaration of
scsi_device_from_queue() to drivers/scsi/scsi_priv.h.

Signed-off-by: Catalin Iacob <iacobcatalin@gmail.com>
---
 drivers/scsi/scsi_lib.c    | 8 --------
 drivers/scsi/scsi_priv.h   | 1 +
 include/scsi/scsi_device.h | 1 -
 3 files changed, 1 insertion(+), 9 deletions(-)

diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
index 85eef401925a..b67f0dc79499 100644
--- a/drivers/scsi/scsi_lib.c
+++ b/drivers/scsi/scsi_lib.c
@@ -2224,14 +2224,6 @@ struct scsi_device *scsi_device_from_queue(struct request_queue *q)
 
 	return sdev;
 }
-/*
- * pktcdvd should have been integrated into the SCSI layers, but for historical
- * reasons like the old IDE driver it isn't.  This export allows it to safely
- * probe if a given device is a SCSI one and only attach to that.
- */
-#ifdef CONFIG_CDROM_PKTCDVD_MODULE
-EXPORT_SYMBOL_GPL(scsi_device_from_queue);
-#endif
 
 /**
  * scsi_block_requests - Utility function used by low-level drivers to prevent
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


