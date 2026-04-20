Return-Path: <linuxppc-dev+bounces-19852-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1203EF588C5
	for <linuxppc-dev@archiver.kernel.org>; Mon, 20 Apr 2026 13:25:08 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fzmSL5PxVz2ynn;
	Mon, 20 Apr 2026 23:25:06 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::52f"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1776691506;
	cv=none; b=oPtEvaaUbJAwKEZAQm1+ZjsyNoYgk62v3iPVbTdFsiYIWzpR8ZlHjcdIh78raYlBipxtdUXhW5pxXhfRpWLesgOPc+0s6emhkGuNC/vN9FOLUQ0WmsjW1Vq4+swa9YsD/vYsFAau76VZ0CWw6U377uTMGaxeaIo8AtZaXAzi/zoWK1VPxFJudbEyWbnQPeeA/j9nbHOIQ459plaYdCQJuyQ6/Y8FYOkCV8u4ntFyYhWoA1qKTjJbpNHAPH5luvQYOiGxnRJfn3Nr1Z6mn3dNd8+SqW/iffI2Rb13BL/jLvqvTMbbBp+X/PmsbUXDlnKE0VKNCUB75joiwrRD+hncRA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1776691506; c=relaxed/relaxed;
	bh=gr0oztocKaKLkdTKEsH8odatBVVrOkD1g/pdHlqb6Es=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WUARofQ/RzZv35ufBZkeBjoQ4eVoAwPiTziYNM9p28jvlWnJRQjaiMlqG6m5EmUypbFMI7jgZ2Q8X2Fd0xCkzKVQlsSkrHQaevozOtDtOGqN3/C7KTpfJw9TLhnjrojDJmr7ibLq9y2m6brlh88hEaPgfDfY+9fF5v6MU/D96J9CCDaqTCz8EBweKij2UK8WnC8cfn+0iHSJQY72MovtMfcacsera/LmeDnxJaBjD454Z6u4E/DkFHlnZRSvX+dyWu9GtV/etfbgbuiIN7ywsOhNT9X7vrW2DBdP9HMISfoRHZEQ+nQu0Jswae0vGVlfrUjgL2rfPyFXTiSR6W+Kkg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=tGTto8wG; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::52f; helo=mail-pg1-x52f.google.com; envelope-from=lgs201920130244@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=tGTto8wG;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::52f; helo=mail-pg1-x52f.google.com; envelope-from=lgs201920130244@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fzmSK1V1bz2xll
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Apr 2026 23:25:04 +1000 (AEST)
Received: by mail-pg1-x52f.google.com with SMTP id 41be03b00d2f7-c741692db4cso776106a12.1
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Apr 2026 06:25:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776691502; x=1777296302; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gr0oztocKaKLkdTKEsH8odatBVVrOkD1g/pdHlqb6Es=;
        b=tGTto8wGBFT9sMURMr1apQKv6VnQNI6ddAYD+VAZY1TZ0DFI2dAC9K0oG7BDyXD5wK
         yvfRCtmbCWb2kqkdtIYmgKI5EOHy6y0WAKqsnrU1yRxPcy4IbC6kfM2SkdOtwujr3kCL
         vI+JYmG3nHNHFpuqwi2W3N7JW4j1i2ieLjpqcky4MclCSezCzksgCG5CKCQ8eNkj3PzA
         MQAlx5eAZ2lBgcYOikEMuNw+1gXbWWIJ0OVk6tXu0Tz575P3IwdwbggXDHHZUcAieCha
         YbD/HhykTQopDziUToxm06+5/3PiwE4UJzad+P/2eVK/nIbrHf7+lWuAQSOAITs1/KFH
         jSJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776691502; x=1777296302;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gr0oztocKaKLkdTKEsH8odatBVVrOkD1g/pdHlqb6Es=;
        b=nsGXOmaz1EyujL/BfjYRSWGbYOVcII85FkW4rfWuKd3AV1MBIb2nipUnD7/m5DTrOi
         VZTvoG8HeFyberlQ/dOSGyDJIiHCd28KBOe25BIfzFie7Paukg8ywUK0AnxkdVtiRxMg
         QMj6wGP3tAuYxsadPNlM0QrPKyQM0+Dis4Cx1nK3DcqeS4DttivGETNpJxilOl+c6rZ1
         eC1hvMkesAClvY4PuV9yWEUD8VowOaZs0R0iualp7ATmPJSTv0Q4XsJ/U2c/7gfIMyIH
         X38DmqNyjLl6qMKEWhWLr7F36yM1YNEE4UQFbzeh3yDvxlbsgs1ZMOR7Z7JaBdu6zSF8
         WpCQ==
X-Forwarded-Encrypted: i=1; AFNElJ/bYeR/FHO0G0QY/CAQTPYvuhTSSGD1Do3hZYExRAdsonI/SAkpMwPS1+v0K52R4vFQHJRSJitEYczTM+Q=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YxGRqzttiH7en+3dV3tqBwINQ06eIi4PwQBWP60KIetdRSv88En
	lYNLh+6Z/2yfpABKm8V2eeZxHndHAN4AsFum2xKuxtvWxnKVztgYNlnt
X-Gm-Gg: AeBDieuBsxXJWbH4VQafAh1PiDE0FLO+QfsREA3gDYQe7Xfboqp/igczsjh8d05JYiv
	ALre8eie4mcGKao1YzdhCzuHrPE3wcqmBH1xr9z8HRTL0l1Lb83NDjEnC1FFK0s6TUJ8Nl5aIyz
	PuMSI3OeAq39RTIjzIbsc84inJ6kFpEtB3i+ncubZ0M3c1kVR7W/pshKOPPwupj794BLdgAMU58
	b2RRaW2cyf+GJbTuJ844E6ecl6A4bExvunrJEt4UUI8BYOMjY1kGDtPUaS1UKjJSn1C4LzomvYO
	d2J8SpwtmM9gsu5511qO3HqfdTbnFNFvfjuU6M9tzbd6VzqdKyscCndLDoDNqA1P57OBGLu8tkX
	zXj8iV1M5LxjYzxA/Y9EkYI22CjvlxIX4bhsLNKwE7OYbhvlk66nviuQMPVPQDcD26mxfX46oHZ
	Vka3wDSzBTdbQ9ErT/hgAPDJW1qpWKqgvPMxY=
X-Received: by 2002:a05:6a20:3d06:b0:3a2:d5b8:bfa7 with SMTP id adf61e73a8af0-3a2d5b8c92fmr2099312637.1.1776691502065;
        Mon, 20 Apr 2026 06:25:02 -0700 (PDT)
Received: from lgs.. ([2408:8417:d50:4775:1153:f731:14e3:b103])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c7976f8fcbdsm7907037a12.6.2026.04.20.06.24.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2026 06:25:01 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Mahesh Salgaonkar <mahesh@linux.ibm.com>,
	Haren Myneni <haren@linux.ibm.com>,
	Tyrel Datwyler <tyreld@linux.ibm.com>,
	Christian Brauner <brauner@kernel.org>,
	Kees Cook <kees@kernel.org>,
	Guangshuo Li <lgs201920130244@gmail.com>,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH v2] powerpc/pseries/papr-hvpipe: fix NULL dereference in handle creation
Date: Mon, 20 Apr 2026 21:24:29 +0800
Message-ID: <20260420132429.128075-1-lgs201920130244@gmail.com>
X-Mailer: git-send-email 2.43.0
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

papr_hvpipe_dev_create_handle() transfers ownership of src_info with
retain_and_null_ptr(src_info) after anon_inode_getfile() succeeds.
However, retain_and_null_ptr() clears src_info immediately, and the
function then still dereferences src_info in the subsequent list_add().

Store the transferred pointer in a separate variable and use that for
the list insertion.

Manually identified during code review.

Fixes: 6d3789d347a7 ("papr-hvpipe: convert papr_hvpipe_dev_create_handle() to FD_PREPARE()")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
v2:
  - Fix the Fixes tag to use the documented 12-character SHA-1 format

 arch/powerpc/platforms/pseries/papr-hvpipe.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/papr-hvpipe.c b/arch/powerpc/platforms/pseries/papr-hvpipe.c
index 14ae480d060a..497eb967611b 100644
--- a/arch/powerpc/platforms/pseries/papr-hvpipe.c
+++ b/arch/powerpc/platforms/pseries/papr-hvpipe.c
@@ -480,6 +480,7 @@ static const struct file_operations papr_hvpipe_handle_ops = {
 static int papr_hvpipe_dev_create_handle(u32 srcID)
 {
 	struct hvpipe_source_info *src_info __free(kfree) = NULL;
+	struct hvpipe_source_info *owned_src_info;
 
 	spin_lock(&hvpipe_src_list_lock);
 	/*
@@ -509,7 +510,7 @@ static int papr_hvpipe_dev_create_handle(u32 srcID)
 	if (fdf.err)
 		return fdf.err;
 
-	retain_and_null_ptr(src_info);
+	owned_src_info = retain_and_null_ptr(src_info);
 	spin_lock(&hvpipe_src_list_lock);
 	/*
 	 * If two processes are executing ioctl() for the same
@@ -520,7 +521,7 @@ static int papr_hvpipe_dev_create_handle(u32 srcID)
 		spin_unlock(&hvpipe_src_list_lock);
 		return -EALREADY;
 	}
-	list_add(&src_info->list, &hvpipe_src_list);
+	list_add(&owned_src_info->list, &hvpipe_src_list);
 	spin_unlock(&hvpipe_src_list_lock);
 	return fd_publish(fdf);
 }
-- 
2.43.0


