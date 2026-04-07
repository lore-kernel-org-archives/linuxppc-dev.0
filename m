Return-Path: <linuxppc-dev+bounces-19440-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9001BFEEF53
	for <linuxppc-dev@archiver.kernel.org>; Tue,  7 Apr 2026 14:32:38 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fqpYw4hxfz2yhV;
	Wed, 08 Apr 2026 00:32:20 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::62c"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775572340;
	cv=none; b=RNK90YFgwSJXUWeydk1eljAJmKdEkHPCeIH5ZQKXwag58i5wTYPdolWD44X3I4A8CxsqBxYiihosYdKd2ELOPFWtxRO5uoGQzpGJcqK78c6oCOw52n+o/lwMD7tnSsEJECLLX9Y3/6UyIZGRS67ujG6wGW9dbCTAK9LAcN2qlq4HRVCy55WbJtEtVaZcxsEtslrNWskgsuSn+foDzDJ7CZfLwmLiMiv7XbRJvk9wPob8MKer7vpaQ3JlZ6gDb20o69eKs02nwKJozUOhuKeXHZ/pjqzQnYlw7nIq1MqAnm3H/Wk2pAw6T2kxCLnygbLQ4id2R4F4kjwkIKUVI4pJDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775572340; c=relaxed/relaxed;
	bh=WCaF3kLdCiAgYQ5/bk3SyXEWPD5dHMX+3j2VLCRYM2s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TZY8xxrduA5gy0eKG4O9vtCbf+y9wsAYMWKaiia5YxDsOIEsADfT8rI5oPoNJm5mRmE7A9Xp5EpfLnqvS608k35moWeaHtiZOOlZef5wO8FHy7DcoZX5V7ANeLvh+FzGiWALuiJvMMzzjPH+SQVX7kRptIAwhp9ClVyBu7HqWU4mS5dvtH5/ujQybcx9l2GeBmeZjcLFz2n3UWV8xkALzuUTau1+/6FB4wofGw7hUk5NFXwHA9Tk40XDFaOnGleM2kk+zlg+CmeHpD9yEUQ6FZecIu+YFo5PXsEe+rFyS93NSCd+9yQPp6VdNQOjhY+vMdo+GRou6xjRgAU9N5dSIA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=R92qxu6R; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::62c; helo=mail-pl1-x62c.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=R92qxu6R;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::62c; helo=mail-pl1-x62c.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fqpYv6V4Wz2ySk
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 08 Apr 2026 00:32:19 +1000 (AEST)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-2b0ba3bfe16so48296255ad.1
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 07 Apr 2026 07:32:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775572337; x=1776177137; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WCaF3kLdCiAgYQ5/bk3SyXEWPD5dHMX+3j2VLCRYM2s=;
        b=R92qxu6RNzFHXbH1PDziDl810F3RHSLQrPx7MbtOE450cc0Pnt2hYhw8zFG6NYPuRB
         rNSUc4CIr2o/33UEavO19szxPYHA8BE4DDX+qxgf8SyXS4IN+eHPkYG1gV/Me3im0tSa
         v+8YRJr5o7L5rGsIT9ImzwSEkY87urGY7IiqJJXwx7X2seraKuCnojlyUeSBHe9JfIfF
         5YLkdx6dczxXZ1hYxhyUP5EsIO2Wxr9wi0f3MMdwAaUkNylTIM7vbp9LSmZ3S6ZTqSca
         CvHxBl9TTEgBFZkDgRUQyYjmWShY/KiwGdFTkyoJcr0gN/qMMYvHgAQcz/LAWVgA+7vm
         kJ3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775572337; x=1776177137;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WCaF3kLdCiAgYQ5/bk3SyXEWPD5dHMX+3j2VLCRYM2s=;
        b=gcjoaG9nkvfmWNgtW8Iwd1k/YTSO9w7ZiWej6sBwEgXNfrpLzq8DL1HlLUQLfXC1+X
         SrM38gjctx/zZLQ807MNatZ74qLB1/R4KuztuEXXB7KtB4OsOE+Zg8Yp3HAEcWTdtYm2
         6kr+m+gQrRxyanDGXbxWIGE8BdILrlae3BABwR2boa+vlbtFh+Hk/it4iatVof3xRGMo
         9EG1egaRhN5a9PsinAqdXgTuCaASf8THpY9H5WSTs2sR9yVy3997BhPaw/YAqN8j31md
         ONtWzyGo58pyTJS4o7/Iob1AdwkzUyofUYRj5Xtm1/kyMfPjhSTs4uHhZtaT7cLei65L
         enEA==
X-Gm-Message-State: AOJu0YwOc0XI8+8aOYduqqHE0KK6ZJNXTzWMepy65CA9HJHxNSJMSE1X
	+bvGpXPjJ7Q2YLlI+PlikNS4QMtrrZE8iAJ1zQjhnenpLRv7HMYW3Ltj+YjwCA==
X-Gm-Gg: AeBDievTiKpiVIxyiBqssZP/V549q6cXJ0oHr+v2Qx2RDqB8zHvE6cbgOvIFT4bFk1b
	ef1EhRAH/vhpNE9SnrRCuqMvH4Dq8PDMPssBRNFXeiO8plNlfihgAyJCDYHtTBU7mjcOGyP0BpT
	YZgxu1c9d6QfZC8w5PbYgGeCzPelqFggjC2XxDMOMh3TidJ29lo4QmB7DSw+OMg2MakSe9538/9
	lu2fv2KX72KSoTNIs6UxEIU4qawYtsdPpYWdk8aInMGEp92MJUiMKdAhTuOBO50rTA8onF62N9j
	VXsGNWvknUGJWBXtopluJDyn/mFIwNsa219h3Uu8W2+hg3WmSh+GQKkPSrsfg92DYmJCvYGY5Sj
	Np9F+9POcY5IbgbkwwA4vAzELQP1jZstH931Wi1MUcwsZA4ECZFysrCmzUiJB8e3tK2yNujCm22
	mKR2AoARx/bk2/+HJhLuo2q2z4NXB4Emn4az9xyAT3d5MMH3mkNu0WipMYatpd
X-Received: by 2002:a17:903:1b0c:b0:2b0:6068:4c5f with SMTP id d9443c01a7336-2b277d966bdmr184775385ad.8.1775572337304;
        Tue, 07 Apr 2026 07:32:17 -0700 (PDT)
Received: from Mac.localdomain.com ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b2749cbc58sm181201525ad.78.2026.04.07.07.32.13
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 07 Apr 2026 07:32:16 -0700 (PDT)
From: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To: linuxppc-dev@lists.ozlabs.org,
	Haren Myneni <haren@linux.ibm.com>
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>,
	Christophe Leroy <chleroy@kernel.org>,
	Venkat Rao Bagalkote <venkat88@linux.ibm.com>,
	Nicholas Piggin <npiggin@gmail.com>,
	linux-kernel@vger.kernel.org,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Subject: [RFC v1 5/6] pseries/papr-hvpipe: Refactor and simplify hvpipe_rtas_recv_msg()
Date: Tue,  7 Apr 2026 20:01:39 +0530
Message-ID: <51b10f1e82e5c9965902b34b082a4d2aa981ff8f.1775569027.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <cover.1775569027.git.ritesh.list@gmail.com>
References: <cover.1775569027.git.ritesh.list@gmail.com>
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

Simplify hvpipe_rtas_recv_msg() by removing three levels of nesting...
if (!ret)
    if (buf)
	if (size < bytes_written)
... this refactoring of the funcion ensures bail out routines are
handled early, to simplify the function logic.

Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 arch/powerpc/platforms/pseries/papr-hvpipe.c | 52 ++++++++++----------
 1 file changed, 26 insertions(+), 26 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/papr-hvpipe.c b/arch/powerpc/platforms/pseries/papr-hvpipe.c
index 7242a14eb5ec..f41f5c0a8418 100644
--- a/arch/powerpc/platforms/pseries/papr-hvpipe.c
+++ b/arch/powerpc/platforms/pseries/papr-hvpipe.c
@@ -190,34 +190,34 @@ static int hvpipe_rtas_recv_msg(char __user *buf, int size)
 		return -ENOMEM;
 	}
 
-	ret = rtas_ibm_receive_hvpipe_msg(work_area, &srcID,
-					&bytes_written);
-	if (!ret) {
-		/*
-		 * Recv HVPIPE RTAS is successful.
-		 * When releasing FD or no one is waiting on the
-		 * specific source, issue recv HVPIPE RTAS call
-		 * so that pipe is not blocked - this func is called
-		 * with NULL buf.
-		 */
-		if (buf) {
-			if (size < bytes_written) {
-				pr_err("Received the payload size = %d, but the buffer size = %d\n",
-					bytes_written, size);
-				bytes_written = size;
-			}
-			if (copy_to_user(buf,
-					rtas_work_area_raw_buf(work_area),
-					bytes_written))
-				ret = -EFAULT;
-			else
-				ret = bytes_written;
-		}
-	} else {
-		pr_err("ibm,receive-hvpipe-msg failed with %d\n",
-				ret);
+	/*
+	 * Recv HVPIPE RTAS is successful.
+	 * When releasing FD or no one is waiting on the
+	 * specific source, issue recv HVPIPE RTAS call
+	 * so that pipe is not blocked - this func is called
+	 * with NULL buf.
+	 */
+	ret = rtas_ibm_receive_hvpipe_msg(work_area, &srcID, &bytes_written);
+	if (ret) {
+		pr_err("ibm,receive-hvpipe-msg failed with %d\n", ret);
+		goto out;
 	}
 
+	if (!buf)
+		goto out;
+
+	if (size < bytes_written) {
+		pr_err("Received the payload size = %d, but the buffer size = %d\n",
+				bytes_written, size);
+		bytes_written = size;
+	}
+
+	if (copy_to_user(buf, rtas_work_area_raw_buf(work_area), bytes_written))
+		ret = -EFAULT;
+	else
+		ret = bytes_written;
+
+out:
 	rtas_work_area_free(work_area);
 	return ret;
 }
-- 
2.39.5


