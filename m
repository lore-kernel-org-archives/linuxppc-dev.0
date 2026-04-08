Return-Path: <linuxppc-dev+bounces-19501-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA20F1073CA3
	for <linuxppc-dev@archiver.kernel.org>; Wed,  8 Apr 2026 12:02:32 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4frMBK2bcxz2yjn;
	Wed, 08 Apr 2026 22:02:17 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::534"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775649737;
	cv=none; b=KyQHku0F5apzXaAHEN5Kmx5UJBz61NKWeQDHWoXGnG0XpBjBEkMXaloMgPdpCStULAcNr6oi4yDLHokQJF9MYrSHyG5l9ZiZL26SoW5AQ/l0L01emfgOK6s2P3CS//iNZs7l9JJE/KEHoJSjDkiQBhCOmhV4KVIltv/4cWVxmPYdyNDMGEfs4Ab8CfVMRBVSc4J9kwU1iXqOyHuWHeSuXWA+SgvLpF6ESm5hG7A4z+vsT3qOqe7WCA+jQMlc3n5EQcQn709n5Tq10mtgiGMlomGljp4bKUkkjmLpjH4lQDdQjKyrnLUeS+ra1wa8z4HpMnmKQYpYz9QT6nJ2Rveq+g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775649737; c=relaxed/relaxed;
	bh=FkcaRdjNdQrSS4RW7vp7wN/6lfwG0aLJHvzJtjGnR8s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SeHObub7SQDOu/ASWQjL2uRdRWpPGqgsDg7WG7+4b8HyX8NulCxxPpz+ZIoDMkretSB+iRUS6kVoGZLKhhN+cv96tSCEAYRV54/8bl52odXv8HcsglUYyfzZH2rE9WKBqABI4doUR3hYZJ7ONd9iOUg+dpHvKhKct216oiqi4wisZMCeVEfJD8dFdPyiJmPKa8Tv//fYKHV5mh3uEkWAnUoVX7s7vILs9dNpG4wOf6EazpnjINTtcGGb6tAEmafyLp6Kq7T1sKhreVzV93a6GYfj7PlVn64JuZpwSJi+p32+Ntxu2HQGPWqTsrc9jbpBUOUS27L5aXn1RE3X74omIw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=j3bSBDV8; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::534; helo=mail-pg1-x534.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=j3bSBDV8;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::534; helo=mail-pg1-x534.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4frMBJ58L3z2xc8
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 08 Apr 2026 22:02:16 +1000 (AEST)
Received: by mail-pg1-x534.google.com with SMTP id 41be03b00d2f7-c76af7b0f94so4037363a12.1
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 08 Apr 2026 05:02:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775649734; x=1776254534; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FkcaRdjNdQrSS4RW7vp7wN/6lfwG0aLJHvzJtjGnR8s=;
        b=j3bSBDV8d9GFkFcGXC8so6/2zpOc5NYKmPlkRimFzA4/8UnHA9hisugVvfleYksGWS
         A8jWBr90ZMu/av+OcRSHpVHUnh/HfXvCiDg1Z/3tjJZGC9X4fJ4tFkpiv3SrEB9F9xEY
         d6Zm3QhZvzZV37Tn70NO6rxRurN99BO/FWd4vLyXNyl3Hq/mkYp3OThQQkgSXmMQ7sWO
         0Qv4D0K7Vrz8EmLOQGk4ZCPje86wX0LrDUsUoE9a8fmr5T7fxylirFY0K6nJjeDVyShF
         lE2r+ScgcnvqX3lV5jNTC+SpCoJIcmXJK+0Vyi+Hybd3kQABGEB5sXoeJkC6XNcE1Sqn
         CCZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775649734; x=1776254534;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FkcaRdjNdQrSS4RW7vp7wN/6lfwG0aLJHvzJtjGnR8s=;
        b=RiuQhhETgf6T9SoL/9LVL/pg0EQJjzAYKo6NDfxtmiKqY2NYNwIeQHBQB2WFQboL14
         GYp9YrAGucmc487F+PJPquNVJyYrJzoMi3CyzZgA3uWv1YJ3rIZIBGJH2njY08Yg5Zzc
         6GnPojjv/dOmdYAH5uDbb2HNwksjjUGk9gKkqzB18tLLgSl7i4CF72hd50ZBY7zPzf7O
         DdAb2u7U6NWJ8cM6phbEXKcVi1I6nRaVS7rvayi50zY6euTg9N/YWRXvKk5Ne13Ep2I7
         974Swd8eeu8q7CY49DMFAh1/Ic+W7LVum712mTyft96Tc+WrGgky975yXXY6c9ygLxp5
         C+ag==
X-Gm-Message-State: AOJu0YxLQVBKQn2U8YAax+zHtzylrZ0VoPDRKDDODWXU1cCX/RfFFtwX
	5HK/KtMt+ka1r8EXtlTM08JSDffcwN59bDsrl+q2EPOZC2pR5Pc5eYWnU5BEyw==
X-Gm-Gg: AeBDiesBbBMybbSErLfCTkD4W0OwY1Rg5Vypf5WJcTeuD6jNkNotHpe1Lo3KFxKyUif
	mSIoC1PdXrhyFCqWxneFn10ASYUSXYybnquUUEHYTm9v1kTpXmIZNOXVjgEMSR2GHCferO+CpM8
	SGzrvZnq64URh7SXh7R7QSZN7LXg/UjLTGvRT5CEHmqjGfAuQrUk5jpCkfJg1Q1VCmoxvlWY5DW
	bdORVzWJzr5mW6TFBG8JeQYxmdtxFfMnlIiKnoAt0bC0Ygp2yRZS+OTKyqv7+H7NZqVZq6fRSAK
	HVB3L9mrJsiEnu8PT0TRdL3KiedDNlLBgkA8I2Dg8qTErtQP2/QPMqxDjlTaY9HyX8McgL3KoeD
	PKmOMMJ46kF1J1LSMW2w7TDtRFYfLJ6hl+QwsbYhSwFCggbXegyrAi3JN6OZMMmOW1PDcBgQ5QE
	WEFNg1Xx5CEEeSnjOczwgHwm78Wp8Gli8yLxD5TockHvQV
X-Received: by 2002:a05:6a00:6c94:b0:829:9a7b:db84 with SMTP id d2e1a72fcca58-82d0dba35d7mr20895852b3a.49.1775649733978;
        Wed, 08 Apr 2026 05:02:13 -0700 (PDT)
Received: from Mac.localdomain ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82cf9b3e169sm21209322b3a.18.2026.04.08.05.02.10
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 08 Apr 2026 05:02:13 -0700 (PDT)
From: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To: linuxppc-dev@lists.ozlabs.org,
	Haren Myneni <haren@linux.ibm.com>
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>,
	Christophe Leroy <chleroy@kernel.org>,
	Venkat Rao Bagalkote <venkat88@linux.ibm.com>,
	Nicholas Piggin <npiggin@gmail.com>,
	linux-kernel@vger.kernel.org,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Subject: [RFC v2 05/10] pseries/papr-hvpipe: Simplify spin unlock usage in papr_hvpipe_handle_release()
Date: Wed,  8 Apr 2026 17:31:35 +0530
Message-ID: <b9131bbc806d95fb85fe0a2a515c8c024fb45e51.1775648406.git.ritesh.list@gmail.com>
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

Once the src_info is removed from the global list, no one can access it.
This simplies the usage of spin_unlock_irqrestore() in
papr_hvpipe_handle_release()

Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 arch/powerpc/platforms/pseries/papr-hvpipe.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/papr-hvpipe.c b/arch/powerpc/platforms/pseries/papr-hvpipe.c
index 5c773a6f0efc..7d05d6dcdb79 100644
--- a/arch/powerpc/platforms/pseries/papr-hvpipe.c
+++ b/arch/powerpc/platforms/pseries/papr-hvpipe.c
@@ -460,6 +460,7 @@ static int papr_hvpipe_handle_release(struct inode *inode,
 	src_info = file->private_data;
 	list_del(&src_info->list);
 	file->private_data = NULL;
+	spin_unlock_irqrestore(&hvpipe_src_list_lock, flags);
 	/*
 	 * If the pipe for this specific source has any pending
 	 * payload, issue recv HVPIPE RTAS so that pipe will not
@@ -467,10 +468,8 @@ static int papr_hvpipe_handle_release(struct inode *inode,
 	 */
 	if (src_info->hvpipe_status & HVPIPE_MSG_AVAILABLE) {
 		src_info->hvpipe_status = 0;
-		spin_unlock_irqrestore(&hvpipe_src_list_lock, flags);
 		hvpipe_rtas_recv_msg(NULL, 0);
-	} else
-		spin_unlock_irqrestore(&hvpipe_src_list_lock, flags);
+	}
 
 	kfree(src_info);
 	return 0;
-- 
2.39.5


