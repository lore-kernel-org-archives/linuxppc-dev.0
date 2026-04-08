Return-Path: <linuxppc-dev+bounces-19500-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2508D1073CA3
	for <linuxppc-dev@archiver.kernel.org>; Wed,  8 Apr 2026 12:02:26 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4frMBF39H1z2yC9;
	Wed, 08 Apr 2026 22:02:13 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::431"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775649733;
	cv=none; b=XDYIXd9gshEmt4ppVWG9R+vPZY0UQZ0q/77DQ/ubGphi7yCyRaSbnq/gdF4pDlnBDgP/1B9OfGu5wst4+lchya8PnQmKlOkyoY4lAxFEArd95pKlauSOqrUkRQvdS4LNf0cnzZ5ke0zPyI/NzXw4fsLP755m78YG0uLOCcv+gcXN+hihon7epVnptIaxiwIImwje5GncIKokq3UJuqvd2GO6rTjnvtsq/FmToREORPj9xy6ruu/blMSNv4NUBBh9yWk0kxuabZbs4mOLHkSZuM5tESj17k4J4Hjc9JrKy3Qj53igFsiamkl63pB24mL0zxfJfXy5wsKLWKKhIlS+BQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775649733; c=relaxed/relaxed;
	bh=mu3P1VfNo0DCayRCdHHojPZFKAzDzWNLwEKMHMNVDaE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AZ5bkpOomEAyo1GMG0+w/YsPHuFQ4e7J/GjG/HyFYKXn5GhOxhSnkpyYyujV1t83c8fX8ujqunJIxNMklVot/UJ/N4e00WX8CY940E/PWPJWrQA4MFTHIhsD9p7KXgjQ7f77JfEUybVQIZz64HNU+wZS+sJQblfMGSu/Kftwxs6OcJo4uwFQ+EQWbFpoGzRrQFcerccCnENdROUCxzLHsfa0ZbcY1N+Jbm4l9NnwmciLuCrIsbHcgY7XSmGHx35T58A8FH0Nfj2Cg5W3poYMdbNiCR6zcla0AgeCibTuRLpekMkpFzDsLvQcAadH+XsNll+4D1DERl0iDBVhIYD0Wg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Fs2IqKGX; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::431; helo=mail-pf1-x431.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Fs2IqKGX;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::431; helo=mail-pf1-x431.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4frMBD5mHJz2xc8
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 08 Apr 2026 22:02:12 +1000 (AEST)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-824c9da9928so5191449b3a.3
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 08 Apr 2026 05:02:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775649730; x=1776254530; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mu3P1VfNo0DCayRCdHHojPZFKAzDzWNLwEKMHMNVDaE=;
        b=Fs2IqKGXIZRk7kpu9E4Z2e3mZ3mhBwn4vqsyTRgHHnvbvVWqSdS1uVLctWuADqVgXP
         c+jeqANc190sSgYqmeC3jtZd7bXxTzPN/TyVZCiVdM1p/lsocIhGyKeuOeIIdHSVMRjs
         CyA9ba6cd/3Po4EEvF/BAl5E9DXyYm98nCL+nJmpddJoCR89OYwcHf5ifieJ/h3r3526
         TAUb4E5truSzKGy2+J5lad89H+H6nYbdrIe6QY4HFFZl6L6wxEXEQh5NiFk36IAMMVkJ
         gvkIVU2G0CelgXVr5Fh0svQ3t7/3kGKaBw75uOHSO6EB3ZNhmQRRETrPqWAJ/A3TvQ1O
         yy+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775649730; x=1776254530;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mu3P1VfNo0DCayRCdHHojPZFKAzDzWNLwEKMHMNVDaE=;
        b=UH4JeD9ljQSts8eL8d+y1aQneUP/MXVMLQlW/u4QWJo+LFtF/YwPer1ILmQrHyCNg8
         prTb/YHV+7xz9LiDapnYnKoQtRBMKsuSjCu7RAQPHYodZsFq4ZFTLmTSf7cmMOlcXC36
         8lQKrI2+XCqX2Lk1kb4qUaM47x8czi1jX9zTFvfotzkdPa0d2rYILvdpU1zN7B9yModM
         bYpRQ+mnYfGja3jS89kpGvQeJDaRLsf4BqCsNZvQ4jRoEI3mcM6L/dwf57UzQ6fb+rMK
         kpHU2Z9OspyvzFN1ej8CZls2LiVtRj/q4lmaPAuZL/+a8plznOQy5O+lAnDISeRweGno
         9Aww==
X-Gm-Message-State: AOJu0YxJamXS4AcEBCy8Si12lb8Nflwp2FmJTnSZaQBrw8VAcx9I9x+T
	981JuxoGE7QjDT+vDDJUkmgIbePMXOO0snhhZ1xB2v5eI55nov8qOE0A
X-Gm-Gg: AeBDieut++R/2nuIuaT3AHaodv3SK46oTEsGcr6DF5WEFsUK4xWbWAiJBkfYI+lcVLr
	MHjTQ8FBW2QFDWlPZPrsD7nNWK3+/U5N2rnQMrqFu/Ap3DKj9V8+SzFG+OwCDbujskrsGSu96PM
	pI3tpepFS8LduI5b892+Ry9fU5SJVqvAKNYE1Sny4Fq/7ilHmp8HMFM8ZejmP8tJvTe5WDRUOpe
	udMb3AyxwqP/X9t5Amy8SZuJnFrp5wajYv7b+OqAQTLEq/2nz+sSUswJQLkPx+ulsFurseM7Hgt
	7dYC+DvZRXtqyOnpwRtogFY42UmlpzRcNVyDFywp5EL5y33/+JFV6hysWNL3qNLVLO6OxZ2uYSe
	JEUcROaPGpsSwbmEvHdfrys9T2tyAJGq6X0IN50MIjFMnteRkTB7bpDNWIm4EYy2ZPj53kJ3nuG
	oUMA==
X-Received: by 2002:a05:6a00:2e93:b0:827:4343:4c1 with SMTP id d2e1a72fcca58-82d0db32d62mr19867111b3a.29.1775649730179;
        Wed, 08 Apr 2026 05:02:10 -0700 (PDT)
Received: from Mac.localdomain ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82cf9b3e169sm21209322b3a.18.2026.04.08.05.02.06
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 08 Apr 2026 05:02:09 -0700 (PDT)
From: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To: linuxppc-dev@lists.ozlabs.org,
	Haren Myneni <haren@linux.ibm.com>
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>,
	Christophe Leroy <chleroy@kernel.org>,
	Venkat Rao Bagalkote <venkat88@linux.ibm.com>,
	Nicholas Piggin <npiggin@gmail.com>,
	linux-kernel@vger.kernel.org,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Subject: [RFC v2 04/10] pseries/papr-hvpipe: Fix the usage of copy_to_user()
Date: Wed,  8 Apr 2026 17:31:34 +0530
Message-ID: <e37025db2008cde5ccc4f88fad076d96555dbcf4.1775648406.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <cover.1775648406.git.ritesh.list@gmail.com>
References: <cover.1775648406.git.ritesh.list@gmail.com>
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

copy_to_user() return bytes_not_copied to the user buffer. If there was
an error writing bytes into the user buffer, i.e. if copy_to_user
returns a non-zero value, then we simply return -EFAULT from the
->read() call.

Also let's make sure we clear the hvpipe_status flag, if we have
consumed the hvpipe msg by making the rtas call. ret = -EFAULT means
copy_to_user has failed but that still means that the msg was read from
the hvpipe, hence for both cases, success & -EFAULT, we should clear the
HVPIPE_MSG_AVAILABLE flag in hvpipe_status.

Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 arch/powerpc/platforms/pseries/papr-hvpipe.c | 23 ++++++++++++--------
 1 file changed, 14 insertions(+), 9 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/papr-hvpipe.c b/arch/powerpc/platforms/pseries/papr-hvpipe.c
index 402781299497..5c773a6f0efc 100644
--- a/arch/powerpc/platforms/pseries/papr-hvpipe.c
+++ b/arch/powerpc/platforms/pseries/papr-hvpipe.c
@@ -206,10 +206,11 @@ static int hvpipe_rtas_recv_msg(char __user *buf, int size)
 					bytes_written, size);
 				bytes_written = size;
 			}
-			ret = copy_to_user(buf,
+			if (copy_to_user(buf,
 					rtas_work_area_raw_buf(work_area),
-					bytes_written);
-			if (!ret)
+					bytes_written))
+				ret = -EFAULT;
+			else
 				ret = bytes_written;
 		}
 	} else {
@@ -328,7 +329,7 @@ static ssize_t papr_hvpipe_handle_read(struct file *file,
 
 	struct hvpipe_source_info *src_info = file->private_data;
 	struct papr_hvpipe_hdr hdr = {};
-	long ret;
+	ssize_t ret = 0;
 
 	/*
 	 * Return -ENXIO during migration
@@ -376,7 +377,7 @@ static ssize_t papr_hvpipe_handle_read(struct file *file,
 
 	ret = copy_to_user(buf, &hdr, HVPIPE_HDR_LEN);
 	if (ret)
-		return ret;
+		return -EFAULT;
 
 	/*
 	 * Message event has payload, so get the payload with
@@ -385,19 +386,23 @@ static ssize_t papr_hvpipe_handle_read(struct file *file,
 	if (hdr.flags & HVPIPE_MSG_AVAILABLE) {
 		ret = hvpipe_rtas_recv_msg(buf + HVPIPE_HDR_LEN,
 				size - HVPIPE_HDR_LEN);
-		if (ret > 0) {
+		/*
+		 * Always clear MSG_AVAILABLE once the RTAS call has drained
+		 * the message, regardless of whether copy_to_user succeeded.
+		 */
+		if (ret > 0 || ret == -EFAULT)
 			src_info->hvpipe_status &= ~HVPIPE_MSG_AVAILABLE;
-			ret += HVPIPE_HDR_LEN;
-		}
 	} else if (hdr.flags & HVPIPE_LOST_CONNECTION) {
 		/*
 		 * Hypervisor is closing the pipe for the specific
 		 * source. So notify user space.
 		 */
 		src_info->hvpipe_status &= ~HVPIPE_LOST_CONNECTION;
-		ret = HVPIPE_HDR_LEN;
 	}
 
+	if (ret >= 0)
+		ret += HVPIPE_HDR_LEN;
+
 	return ret;
 }
 
-- 
2.39.5


