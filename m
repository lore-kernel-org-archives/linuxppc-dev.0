Return-Path: <linuxppc-dev+bounces-2430-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CACEFD3C927
	for <linuxppc-dev@archiver.kernel.org>; Sun, 20 Oct 2024 09:50:07 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4XWYZk0VTkz2xn5;
	Sun, 20 Oct 2024 20:50:06 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::433"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1729408697;
	cv=none; b=Egcg0L+jx6+aRoc6+KslVqefGUIewjgMVkYdb2D05cJfaPszgcXZbp1fgMNUOzz9SFDUKwjbKwfrJESNiNNeb6Mnr8lV7XK10mKUZifgzUc17FxKpawVnXqRhzvH7xQ9hNGT8zx4TJwhjz/RMwi0ckk5N7jZMQX9imcqfN9g/BC9htId8Xj1ikOEzDfGUkvlxg6sp9NKyCeVJIgb2p96IJyYXCmZWq+Ztf3G8VKYvMAKpTtOShUUqjRxXw9TurwAQX84Z+ksEb6XEEfkFE6yPWCMMc6T3cQWENoNs/0p+66QPvNExP1H7UTY3rmFt9LMOIveqGDkiGFK9Yfqprj+9g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1729408697; c=relaxed/relaxed;
	bh=YKNNo6ORCMbRFNJ5dKq8wkAXppSzm4Ntz4bE2iMLwtI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ac3kbNJ9sF/eUYixt2wVxKUPVprCUGqZ35GNThEpdzuDQakd3XTXv5AbeY1yPKVP8mBMu/9l46XVPUda+gY2sksGnSu4NbJvJ+m0h7ek37srW16sfeLMsEmxZoLHcKJ5TjQVwPLRf0mvivfmYAzWvslfiSNtblvJJSYhWtS6nRvfs5/2uBkH4j+qPO4ERc8rrSlVIaaXKvdF4XSDUKmMdDZtlc+Nk6snuPaaVgTxqg+JpfCFVgblumCcWb02UOSwhFZEoYXPeseldgU/+7dLieKCc/VE+8KbUXREwTM5JTGWAIsND2RRua3fDA8gNNPJj/baK++2qnf+vy9JYJFi7w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=l1NmFtJQ; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::433; helo=mail-pf1-x433.google.com; envelope-from=ryotkkr98@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=l1NmFtJQ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::433; helo=mail-pf1-x433.google.com; envelope-from=ryotkkr98@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4XWVCX0gk1z2xfR
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 20 Oct 2024 18:18:15 +1100 (AEDT)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-71e70c32cd7so2848619b3a.1
        for <linuxppc-dev@lists.ozlabs.org>; Sun, 20 Oct 2024 00:18:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729408690; x=1730013490; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YKNNo6ORCMbRFNJ5dKq8wkAXppSzm4Ntz4bE2iMLwtI=;
        b=l1NmFtJQQ+SP2WeCnx3YF201koLlTn7XrmaJnyVDrJIbgo984BY1wou6uvWo89wYlj
         AILsgiaqozCmKcNwwqDSbgSAiteT+7bq8Ijbn8lSUwdKQoFkMvJQ8Qdhmq1fbYy4vuS3
         7Zzkn4McQNS/H1FHWVrODkPoTeJc+7p0fUPlNp9u/ioiphKG1M8IOWMji+4g5qFUXkjH
         CruUBHnxtwZD/NhKfC2kX7e9q9zlnDlBMqtjJnMR8b73nW0L8kT5qMyiUdehr30eNXzp
         fd81MUSHnvOHk72uFuYW1Du+kK+LB8Za34Xa+AMsJ6xtrE0wj646ouI/sKIM/iWMVI4P
         wu6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729408690; x=1730013490;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YKNNo6ORCMbRFNJ5dKq8wkAXppSzm4Ntz4bE2iMLwtI=;
        b=jXF7c3vYvsiJjcqcneHogI3xr6gtTVJLXSICNbsyliwKyXPTAUzJDtO75LglVDBALT
         NM7U9rihiEQDnQf/bCy+piCA9HOd+GafXLo3mCmgVkXeonVXFOmMrTzQ0BDMDSDeDgqY
         iYVALz/JsOvThTpP+FEyQD00ux1v9VeqVEtsr1dpQR/Geofij9waZFUdLsshNgVQZSgn
         DlG31H6QXN/IUPDujUjPQDpoy5v9OJxDBXfz2iI2RYYQ+1yH6flStNxlaWi5dbqyBUbP
         HJW/4Vir53Z/QVemyOG74wwV2K1xgkIgBh7mHnNC/oKYfCEXGTZiy2P+Nx/sWsBYFQuk
         XCxg==
X-Gm-Message-State: AOJu0YwF1a39MEJtGBhFe0MwRi3zycC+AwOtQIG7hrfTQa0Hlw98lYs1
	V9OAjPxvHMoIjnOmYIDdHZbrxIkQppDIp2sVGIYge3A7fNlx9MIb
X-Google-Smtp-Source: AGHT+IHLIEPVve3Ub+lLLowcnXy+dfiLi1sT+/U8BkiDnif9wKxlz1RJhQxh/LVPqCXSZaUmTLdNKQ==
X-Received: by 2002:a05:6a00:3d15:b0:71e:79a9:ec47 with SMTP id d2e1a72fcca58-71ea3118addmr11926875b3a.6.1729408690471;
        Sun, 20 Oct 2024 00:18:10 -0700 (PDT)
Received: from DESKTOP-NBGHJ1C.flets-east.jp (p10213112-ipngn20001marunouchi.tokyo.ocn.ne.jp. [153.220.101.112])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71ec140781fsm709022b3a.185.2024.10.20.00.18.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Oct 2024 00:18:10 -0700 (PDT)
From: Ryo Takakura <ryotkkr98@gmail.com>
To: mpe@ellerman.id.au,
	npiggin@gmail.com,
	christophe.leroy@csgroup.eu,
	naveen@kernel.org,
	maddy@linux.ibm.com,
	sourabhjain@linux.ibm.com,
	hbathini@linux.ibm.com,
	leobras.c@gmail.com,
	pmladek@suse.com,
	john.ogness@linutronix.de
Cc: linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	Ryo Takakura <ryotkkr98@gmail.com>
Subject: [PATCH] powerpc/crash: Allow direct printing on kexec
Date: Sun, 20 Oct 2024 16:17:55 +0900
Message-Id: <20241020071755.328706-1-ryotkkr98@gmail.com>
X-Mailer: git-send-email 2.34.1
X-Mailing-List: linuxppc-dev@lists.ozlabs.org
List-Id: <linuxppc-dev.lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev+help@lists.ozlabs.org>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Subscribe: <mailto:linuxppc-dev+subscribe@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-digest@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linuxppc-dev+unsubscribe@lists.ozlabs.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since the commit af2876b501e4 ("powerpc/crash: Use NMI context for printk
when starting to crash"), printing has been deferred before shutting down
non-panicked CPU on kexec to avoid deadlock on logbuf_lock. It is deferred
until the shutdown of the first kernel and starts booting into the second
kernel. As a result, there is no messages printed for legacy consoles,
including crash_kexec_post_notifiers messages which is after the
syncing of legacy console at printk_legacy_allow_panic_sync().

Let legacy consoles print directly so that we can see messages on kexec, as
the commit b6cf8b3f3312 ("printk: add lockless ringbuffer") turned printk
ring buffer lockless and there should be no worries panicked CPU 
deadlocking writing into ringbuffer after shutting down non-panicked CPU.

Signed-off-by: Ryo Takakura <ryotkkr98@gmail.com>
---

Hi!

My understanding is that deferred printing can also be safely removed 
in terms of console lock as the commit d51507098ff9 ("printk: disable 
optimistic spin during panic") prevented from spinning in case of panic.

Sincerely,
Ryo Takakura

---
 arch/powerpc/kexec/crash.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/powerpc/kexec/crash.c b/arch/powerpc/kexec/crash.c
index 9ac3266e4965..5e5260e0d964 100644
--- a/arch/powerpc/kexec/crash.c
+++ b/arch/powerpc/kexec/crash.c
@@ -269,9 +269,6 @@ static inline void crash_kexec_wait_realmode(int cpu) {}
 
 void crash_kexec_prepare(void)
 {
-	/* Avoid hardlocking with irresponsive CPU holding logbuf_lock */
-	printk_deferred_enter();
-
 	/*
 	 * This function is only called after the system
 	 * has panicked or is otherwise in a critical state.
-- 
2.34.1


