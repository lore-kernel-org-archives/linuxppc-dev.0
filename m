Return-Path: <linuxppc-dev+bounces-20359-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64E5EFF8864
	for <linuxppc-dev@archiver.kernel.org>; Fri,  1 May 2026 04:13:21 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g6Hh43gGrz30Gy;
	Fri, 01 May 2026 14:12:52 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::433"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1777608772;
	cv=none; b=Ig9538x7dlwPdvic+eYKx0Vxipgd3qqaZw3GfDXX+u3SReyWDue1pjdIL10O0LJBQkPBeU4/EhrFJGCCwp/ZS8WbiiY+uD3rCiVUNJjTc8A1lyJV6DbHxq7YGvRcYnPXxyKfwNkqk0e6Jv4IgBV9BUrc1v+Tv6wJggy0FkjVXbIZC/UHxtRwqlm2w/40yd99dqnQ29odFou3BLRoKHeefsK34X0MvTYm0Pxal6Tu+YYmHuHB9jKCFDD92K4XmbU9Nex6FGAwk0JkpsPIMqUQ8sdHOqvP+L4ARdDs+2tuDZLusDLYNPSeEJ+6y3gUwtme6on5izCTe3MJnlXvuCdA4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1777608772; c=relaxed/relaxed;
	bh=tmK0ukFVMjb3b7sfCs+v8o+MM2eoVKnNMBXjoF9UXgk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XQbemhpxZ/a2OIs2MCCQrgMCToH0g7dyAt7zG1H/F84it9SMTWyD4CQWmOx7uJ+YfFH0N/H51bouaBT0QdHrrMEONk0ST2d9aTQKdmdrheBHYxBQ+5ytJKEMdK6b4x4h/Uvf/HcqqoZAXqZaFGXa8D6MCZQvpiA6LJm826v9Bx9/0C+HhtINgbNsxKwN6Lg0TEi2kpSDSxWHD+9Ko1/8a1QdnDg5FGhSPO5mcbW8tdimrOSM7icHu0ZvCQHd4UEsDDJrpPHNGheDJ9YKZB7COStWiaVWkpZ2GUIarnkrqvcy0IatSnHWFC/O47NqLh5AQWTW56Pr0DsB5kIceNECzw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=g/4Aem5I; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::433; helo=mail-pf1-x433.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=g/4Aem5I;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::433; helo=mail-pf1-x433.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g6Hh36JG7z2xjd
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 01 May 2026 14:12:51 +1000 (AEST)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-82cf636dac8so776669b3a.3
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Apr 2026 21:12:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777608769; x=1778213569; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tmK0ukFVMjb3b7sfCs+v8o+MM2eoVKnNMBXjoF9UXgk=;
        b=g/4Aem5IBQ68qzkcE4we/KJcsqQfTWSYxg5s+HoH1SSIR0g5fZZrRfL07nwd19muqY
         zia2ytae1gwiTO25xAvWmL/wGguCznqd+zz3vDDKmQ3QKKCPeWbRRbCL44JpHMPZbx4n
         338DyCuyHLIUSiIR1Ar3uaB3IQR2EIIprJhZcL/ouezWa45FtBzb/QzTDT9wQGq7zQem
         ZTj9TGfBiDzifvoLnUQggAs1E9DrQKZGmZRUF4RkRcojL5al0/DxN/swZzynDM4S63Zu
         rbEDbt3yc2PUxCYU8OgHbHXRAqpiCvhmeSBkimc2hBm/P1phG64AXakCDybgaa2fkWr4
         4rhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777608769; x=1778213569;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tmK0ukFVMjb3b7sfCs+v8o+MM2eoVKnNMBXjoF9UXgk=;
        b=eewOu0LSUwhK12gNsTyCLxXzJH73qa/WSLnBqpdP8CUI3Y/Od7ug7fffyCZChCdIFF
         pDwiyETdtcYTcO7nONcDiowk8WSi4lqq1qIEExC75GJtkbqQWg0VHURCvUoSoeCMP2VL
         pkv+VmYW18FCkj1+PxzWbj0KBgKen6Lvyq+N2t3iHPsZDBCkJTI40qtQspwVw0GjCJfp
         zbbQbC8xvfbbwbo/RqxyMa8MNEKxdNptQp2S/p+agjKGk4T3gpXFZec6WQlsD/aeFzwq
         j/LfOYEWj6tFuIyCB8tgAo7wLTPJeYMNmtvsHrYJULMZBB1XoNJQfH9IxsZLlP6zQdBH
         nLiA==
X-Gm-Message-State: AOJu0YwcCqaYt3ZreByrII9anL/RUXbBO49OAFZnTAAAip/jmtyzuHkL
	cyxvLcvESlW4OAfSpY2eTbubEv7bgQ8o/kkvypv6ZX5AOVM1G4oGX1Z7YeeShZZ+
X-Gm-Gg: AeBDievydm7IUViIGoy8K2lmn9K7URmi4970xpDX7tRiv0z+9s3aBD+CeeGeS1OF6mc
	ATY1Fi+fgpfZx6W4+5R69By6QbV9W1Y2HuzxE9H68iq9HmSG3GCRjug0wgoHECS/1xfSV54YCcx
	vKk7kpU7ffU8p2iUX0r6XCcjjyjFHgJWGtB1c7plF+spWwAn8g43j1hY6r7AFhxZyS3uvsXAQGX
	R1F2rb/pwHyYfK/bGhNONa33JBKC4MmVL9j6ZJIawjuglWyEg5jfLUUEvbUIp8yeGKIynY80K7W
	vih9mBtuvAofvRpvVEk7GBls3mP4bU79+awjoLTPeyvOa7iStINSl/smubabN6G62EZZHiTKVt/
	Sh6QiH1VFbdGqKlAZMFlEcMgsDCPz9QnpG+RX78irMp3+RatbxqhOsGNaXtZqNeDijFISrJfUey
	83q3dXGRv/Yoxf+ZuPhEyjYT4xTz/Z/K1M0ljK3/9UR6IE8RdxEjaPUBuHpGx+1qo=
X-Received: by 2002:a05:6a00:1ca5:b0:82f:5154:d1d9 with SMTP id d2e1a72fcca58-834fdb07c68mr7050443b3a.6.1777608769448;
        Thu, 30 Apr 2026 21:12:49 -0700 (PDT)
Received: from localhost.localdomain ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-83515b485eesm1159428b3a.48.2026.04.30.21.12.45
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 30 Apr 2026 21:12:48 -0700 (PDT)
From: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To: linuxppc-dev@lists.ozlabs.org,
	Haren Myneni <haren@linux.ibm.com>
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>,
	Christophe Leroy <chleroy@kernel.org>,
	Venkat Rao Bagalkote <venkat88@linux.ibm.com>,
	Nicholas Piggin <npiggin@gmail.com>,
	linux-kernel@vger.kernel.org,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Subject: [PATCH v3 8/9] pseries/papr-hvpipe: Refactor and simplify hvpipe_rtas_recv_msg()
Date: Fri,  1 May 2026 09:41:47 +0530
Message-ID: <bbe7ddf8b8e25c9be8fc5e2c4aea9e5fca128bf4.1777606826.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <cover.1777606826.git.ritesh.list@gmail.com>
References: <cover.1777606826.git.ritesh.list@gmail.com>
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
... this refactoring of the function bails out to "out:" label first, in case
of any error. This simplifies the init flow.

Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 arch/powerpc/platforms/pseries/papr-hvpipe.c | 52 ++++++++++----------
 1 file changed, 26 insertions(+), 26 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/papr-hvpipe.c b/arch/powerpc/platforms/pseries/papr-hvpipe.c
index 46159f1c1cf1..3688b2be0445 100644
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


