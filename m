Return-Path: <linuxppc-dev+bounces-22032-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4354ECD6E4A
	for <linuxppc-dev@archiver.kernel.org>; Thu,  4 Jun 2026 13:19:59 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gWQCZ6YvDz2xfB;
	Thu, 04 Jun 2026 23:19:54 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::42f"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780579194;
	cv=none; b=Km4JqhLg+Na6eidkBivt8GRmav+cA0pmA6OtF7fyqbJpmOS11y/ilc0xMYyNI4N1vuDZh3UjaD1Z3iig3J9QIPus3mRofqKJpvEnMZ5UU6Y13DMitX/jpyfFnHCxc2tupHV6XQlW321/vMed77to24zr0vxDhIrupOcKUCBFXoCnsUPPN3mpwZ81B+8+Iin25ItfA1acm6zFK4hxD65SsnrTMNIJT84LAp/iaoniYagHqxe75k8l2CBV88WEKI9rSUp55FobCaHhxrEMFYuQsHnIQPO6YcxsAyA4C6E2s6yVWgDJBy5v/UsiMfQgiDZUoD0I462PZ+eikbYNHU7d1w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780579194; c=relaxed/relaxed;
	bh=KlT40SXHIDNPrvJ62EcqbeXntfzy9q6fgJPYwV1Z4jI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Q0JDLIY1MiZqU0HzKjFpBb0RIx/t8Oyph9bZnFt+6KeV5l4SIvNkswXSO7EeJDnPM2MiIJtE+ZBBvlquxz79rxp/9PTc9QJW3QDXd4SBGpBB6DUW+PDNBoVb/bWKK4llKNU4lm+vrA6XVvYDF7v24/sCQgCedHH5kIA07Ae4fAp5ROrglb6SC0LppqyDqsgbLIYnRwjM1LldYZmCEPkKywe1baxTh2RtY3aFceBRWqsTx5UKiDsJBANZly+QS8G57xBSa0WxI6FiMLwGjveJPmFeR8MSj9YYjlqn23zMJOkkyqAVEQjzTPjPql50IVpEe108cEHgRKGHEaFRFInwDg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=B/z0LzfC; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::42f; helo=mail-wr1-x42f.google.com; envelope-from=iacobcatalin@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=B/z0LzfC;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::42f; helo=mail-wr1-x42f.google.com; envelope-from=iacobcatalin@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gWQCZ0J4Rz2ytv
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 04 Jun 2026 23:19:53 +1000 (AEST)
Received: by mail-wr1-x42f.google.com with SMTP id ffacd0b85a97d-45efa80e0afso600253f8f.2
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 04 Jun 2026 06:19:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780579191; x=1781183991; darn=lists.ozlabs.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KlT40SXHIDNPrvJ62EcqbeXntfzy9q6fgJPYwV1Z4jI=;
        b=B/z0LzfCXSAyw1r1bBe6i1eiC29roVDPo1fyJ3yGEd2T53AIKPKi2NbNT4vunyM13E
         DXDqU56mFtqxcrC9gVEkN8v4fZQKmmXNB6xGln4eSP/dXGdPTlbqPNnozY1PEkWkd0GS
         jf+poLUZYwE4fJQJTPwY1qotFr3yVDAy+IyC6TfORPXe+R1Z4EyUxcKYujvjdiF9Seqq
         zprXNEC8SWi7tlQZpbtl0vhVzxSk7krCEeJ6kXqhKsoZ4xwWAtUX9oXQc+djL/m6FY3V
         OZQikOdvf0bRYvcWBTrhV4QRpFP4oVX/pzQuQ4WcvpQSxUlepqvAGUQepdHyU9Qom3Mi
         0pTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780579191; x=1781183991;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=KlT40SXHIDNPrvJ62EcqbeXntfzy9q6fgJPYwV1Z4jI=;
        b=P1TdmxLLNGl/WU+mPQY5UZY+3BoPvRB+Y1X/fwirwtRRIAIOR7HvmCBAdTTFlyOu3u
         9mBzsAf51LPli7Q+gLYK2hDpIhSiSmZRu5KrkS6vfxjsEZ1FSBUyR9W6sbnxyDLPjKSv
         tjfcGSO4cO/cdF4/1+FI/2n/yZ2I7PIe3b9nE40QQjh+GHVl9KlA3tdngzz0D/LO0Ksg
         r4g9PEVAvuMYBigH4hcGjVPgooVEyzSZT8bxh5nUaB/wRjOzsGyTmSyucuEuDSgIYiDd
         pjXuaoRiZeT+M5/Mkvw1hj1KAg13rxFNIW+Xg7+RNVyhBVldu8o8GOhpnAsP4VaqR1Qi
         eHCw==
X-Forwarded-Encrypted: i=1; AFNElJ/Fwa72X+7fkfUgd6YAGE+qts/ycJQGnY+uwH38MqtHbgN+Od8QbguDn1Ww7WraxHTt8cyKJvpUnsNTVJY=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YzZuvybfcyK3O5O2flsRo/GRhY0dLHLvs3A5Ks4p/p7h68dncTd
	H5WGIuUl8MCcNBCbWKShkVCzxADTYz/LzvH27di2qcIAA8HKqe+Sy58t
X-Gm-Gg: Acq92OE1mlmCuTnkOeNdfDuP45XgxcZWAmZ5/isC6G1c0gZh/SXKnbhM2lGijKnONb/
	/0H6zZCQozGqI8luyEt0pcT0I6yTK+Jh9EeR6DxAJCfVrmQ+Cx3DrFD61repn7sfJDBXCuAr4pK
	mRhd5KnZ+YdNPqJBcqjyM8L0kNqnFUb6Fd1ZrHXA0Ga3BRit0v3aFnYFRLWlvVZpGbTsGrWGqwn
	rtZLKyg9U4YHN6beEu0r6e1qZWjJKbMX2tDKMP6b1lhs5y4+1YQ++5MRTUkYMWMwiBSZxel6jxw
	bIypupk8q8Zp1S8WpBrXWStl4dToYewQnqP4ja5NlJUcP3vkk/Vn/hPbex8qM5rTKg3RoNg5p5y
	+Xp6xtzSR7YylmipmGkj/Xalpb/IDl4iCpkwxmoNiRqmiIS+Ko2ckT5XdWoL/SdWC6afjB36mF1
	AwuubitGQaAVrjOMhbEtRXU+3wEu8P7AZNv0W+Q2vx+ho=
X-Received: by 2002:a05:6000:46d4:b0:460:194d:8df0 with SMTP id ffacd0b85a97d-460216bdec9mr8550288f8f.4.1780579190589;
        Thu, 04 Jun 2026 06:19:50 -0700 (PDT)
Received: from localhost ([94.53.77.213])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f2e4004sm16338165f8f.9.2026.06.04.06.19.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2026 06:19:50 -0700 (PDT)
From: Catalin Iacob <iacobcatalin@gmail.com>
Date: Thu, 04 Jun 2026 16:20:24 +0300
Subject: [PATCH v3 1/6] scsi: core: Remove remaining reference to the
 pktcdvd driver
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
Message-Id: <20260604-remove-pktcdvd-references-v3-1-e2f06fb4eef4@gmail.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=966; i=iacobcatalin@gmail.com;
 h=from:subject:message-id; bh=G3Fe3cyAD+Z/AwWkMEKc9eOAUojByYfLbTKUe0Guf4M=;
 b=owGbwMvMwCX261qtXAKXKjvjabUkhizF6vVir19FLgtlrTKTWrz/dN+tx8/b3paudEw33v5iw
 bXHKZO0O0pZGMS4GGTFFFlenLvetmHPmYB7SXYtMHNYmUCGMHBxCsBEaq4y/HfOULHXvpc6y/do
 pN6xXynGrT7RcucdVm8Sqkl1P7TlwSJGhu1yi5fZJc4NvBrrpdCoPv3b3qyyTN7Z02ctmdxRfT/
 8LCsA
X-Developer-Key: i=iacobcatalin@gmail.com; a=openpgp;
 fpr=F609BFABD84EB5C9DDDC37EDE89C6A3571CD0E33

Commit 1cea5180f2f8 ("block: remove pktcdvd driver") left behind an
export that is now dead code. Remove it.

Signed-off-by: Catalin Iacob <iacobcatalin@gmail.com>
---
 drivers/scsi/scsi_lib.c | 8 --------
 1 file changed, 8 deletions(-)

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

-- 
2.54.0


