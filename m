Return-Path: <SRS0=jgKV=FH=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F8B5C8300F
	for <linuxppc-dev@archiver.kernel.org>; Thu,  3 Dec 2020 04:30:02 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AA85722203
	for <linuxppc-dev@archiver.kernel.org>; Thu,  3 Dec 2020 04:29:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA85722203
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=axtens.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4CmjYH3khYzDrLk
	for <linuxppc-dev@archiver.kernel.org>; Thu,  3 Dec 2020 15:29:55 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=axtens.net (client-ip=2607:f8b0:4864:20::1043;
 helo=mail-pj1-x1043.google.com; envelope-from=dja@axtens.net;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=axtens.net
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=axtens.net header.i=@axtens.net header.a=rsa-sha256
 header.s=google header.b=QBKrVBNm; dkim-atps=neutral
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com
 [IPv6:2607:f8b0:4864:20::1043])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4CmjWT0Dh9zDrDX
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  3 Dec 2020 15:28:15 +1100 (AEDT)
Received: by mail-pj1-x1043.google.com with SMTP id p21so1458144pjv.0
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 02 Dec 2020 20:28:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axtens.net; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=wkDbbYzx9sudeiNWprp56c2pJalLIFP5tMFX9hMKMKQ=;
 b=QBKrVBNmljTO/N89NYyWJnkJ15c8Cq3RHh6Zy7m/066w8F3n+cawMAoc/K0Zz58gpH
 rr+HBfKMhkZGCW5cZUF9McyYbCrSCXv+FI1ZyexsZUNU5e/vyRTwKEgjwMjiEowKHDOO
 Za/UEMEq4GzFA04NtS29XZS8eGjXxe78ECY0g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=wkDbbYzx9sudeiNWprp56c2pJalLIFP5tMFX9hMKMKQ=;
 b=BLKbiWB67Tt9wa+41XNXwahHFHSL/hamxISqfXRyn6NdlZKBa+xFekOSMRW67VZG9H
 k51GnYipMUkT5uhYZecmN98AubFvP1bxVHKGmjeevvFZVl+/yovQs/JzceBrhWq5c6ee
 J1uYGlq43LcS4bpOFooAdmljfKr4soZ5lBNoKYG3oYibJxGnGZu5s/WAuTd3j/pZ7PIg
 VJv7h+f7/BEyQSW77qxAQ8c0cHHI+jkfjlg0xWNWM4fVJmpiv/A/beXj8HQFH+1qdu94
 F/vgoLXJ0aVQjZfnkG+OnErM2TiTHquRz71faF1sYowQblG5YcRa8KiJ07fVWleKLENh
 IYFg==
X-Gm-Message-State: AOAM533dI7izFrQ/s/Vsy8t7Bv+XZEBbj20ph+stJOCtjx6DzPE1FBLZ
 pazywt0ScvJc+BBBA0CrN+YTQeaAqMNzIg==
X-Google-Smtp-Source: ABdhPJwNbVpw0Bd4Lr1iimSz7l0q9PwroX5ASTzfO6S4LHL549yIX6ixvUDEw6kzSEuqQbeuoxah+Q==
X-Received: by 2002:a17:90a:1bc5:: with SMTP id
 r5mr1278213pjr.157.1606969692882; 
 Wed, 02 Dec 2020 20:28:12 -0800 (PST)
Received: from localhost
 (2001-44b8-111e-5c00-186c-c138-f981-d5a8.static.ipv6.internode.on.net.
 [2001:44b8:111e:5c00:186c:c138:f981:d5a8])
 by smtp.gmail.com with ESMTPSA id b2sm381154pjq.20.2020.12.02.20.28.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Dec 2020 20:28:12 -0800 (PST)
From: Daniel Axtens <dja@axtens.net>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] powerpc: add security.config, enforcing lockdown=integrity
Date: Thu,  3 Dec 2020 15:28:07 +1100
Message-Id: <20201203042807.1293655-1-dja@axtens.net>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
Cc: Daniel Axtens <dja@axtens.net>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

It's sometimes handy to have a config that boots a bit like a system
under secure boot (forcing lockdown=integrity, without needing any
extra stuff like a command line option).

This config file allows that, and also turns on a few assorted security
and hardening options for good measure.

Suggested-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Daniel Axtens <dja@axtens.net>
---
 arch/powerpc/configs/security.config | 15 +++++++++++++++
 1 file changed, 15 insertions(+)
 create mode 100644 arch/powerpc/configs/security.config

diff --git a/arch/powerpc/configs/security.config b/arch/powerpc/configs/security.config
new file mode 100644
index 000000000000..1c91a35c6a73
--- /dev/null
+++ b/arch/powerpc/configs/security.config
@@ -0,0 +1,15 @@
+# This is the equivalent of booting with lockdown=integrity
+CONFIG_SECURITY=y
+CONFIG_SECURITYFS=y
+CONFIG_SECURITY_LOCKDOWN_LSM=y
+CONFIG_SECURITY_LOCKDOWN_LSM_EARLY=y
+CONFIG_LOCK_DOWN_KERNEL_FORCE_INTEGRITY=y
+
+# These are some general, reasonably inexpensive hardening options
+CONFIG_HARDENED_USERCOPY=y
+CONFIG_FORTIFY_SOURCE=y
+CONFIG_INIT_ON_ALLOC_DEFAULT_ON=y
+
+# UBSAN bounds checking is very cheap and good for hardening
+CONFIG_UBSAN=y
+# CONFIG_UBSAN_MISC is not set
\ No newline at end of file
-- 
2.25.1

