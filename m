Return-Path: <linuxppc-dev+bounces-19381-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8974E9D824
	for <linuxppc-dev@archiver.kernel.org>; Sun,  5 Apr 2026 22:23:43 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fpn6k1dBfz2xPL;
	Mon, 06 Apr 2026 08:23:42 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::436"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775405763;
	cv=none; b=ZKiIEvcFtDLa/cc8E83bK+mb7tGwU13Er5X8ldEKTkUBsg8wvVB1Jt+M9sJ/0fTes+4hov++yW1cTP9UENJXNaGnAFjiZCp6XCrMobhNOJB2Y1W0vFo93XiNiqdb+gqZZisaMColb7MARvn9tKgyMTelQOLtAF2VDceuA706gbO3P5nfmsDmbNFM/bsM+wjE+gDgTbLQeVXnee0XbB/sPseR7MMTF3jK2x5crgBVmLnK8XNbz5werB4fhhiehOLxaS8kGEk5rLfyIXe1ww/5ad4A4dx79cPpfz3JyeQVcaV3P2zsLCRszLvPBOl6b7pTh3rgdF6AnDNi9Rdme5iowA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775405763; c=relaxed/relaxed;
	bh=JDo7wOf9Rd6NNXxatwieaMtmaaIFmU/41KBybrHKVJs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fOlQb+MMOxFks3z+FIXCxXaMhcrJ366RpA1nZI0gG7zrROu7rnusySXeMiyGPg+ErwFA11vIti4KuqBhgcI3fiJxnN41wOHMPmznXddfXoGMCyZq3ppKbRLDF9sNdNA6cHAj1xanke6fhanXFp+5TPu7j3C6+mPNBjvTo7Y2kjHiKV/4amEj8J6o/HQ6Zp+tI8Pl8c1XFyUiaw1Wiq3D4R70m1v8LwQE0yxGQRwzh9Ft0JOc4WPA4tIv57FgWA5l00JGzH2bnfH6qg9ls29jLS6DeU/8Exu9z1FmxdYZ2RRBwl0JwJ1lWYgW8p5vMAfgI7E4qE01MByW2l/C4d5ldw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=E69CbVxR; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::436; helo=mail-wr1-x436.google.com; envelope-from=julianbraha@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=E69CbVxR;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::436; helo=mail-wr1-x436.google.com; envelope-from=julianbraha@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fpcyT6JHtz2xLt
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 06 Apr 2026 02:16:00 +1000 (AEST)
Received: by mail-wr1-x436.google.com with SMTP id ffacd0b85a97d-43cfa33a983so1989194f8f.1
        for <linuxppc-dev@lists.ozlabs.org>; Sun, 05 Apr 2026 09:16:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775405752; x=1776010552; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=JDo7wOf9Rd6NNXxatwieaMtmaaIFmU/41KBybrHKVJs=;
        b=E69CbVxR2h2inc2P10kH148g5sGGY/1hr7AFjOlfULNibKSRJgsVdWOYYtfvMR1/yn
         6o8c9oZU5tk/5Upg91cUjHeu63optRZcqRah4gXiPBKUuZ+SJTXb6/1tT+riu0qEfqP2
         IdDzx0YDglb2Brp9wJH1fMbTONVYIQy2eirnLisIcZi3m+bk/4E7jXOZ80pn0pwMLLoe
         kN7oWIT3mBBOIOqDE49Sqrl1QeUxx4PY/E94H8ZO6kGqTR/QUi93v7SfJXmzpAqW1rDq
         yksNVDhVnRixKZw7SqC0Aybhn0y/cF30AIPYLIHp1rBYM21pqghPuyOhYzax2xUH4ujd
         RQ+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775405752; x=1776010552;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JDo7wOf9Rd6NNXxatwieaMtmaaIFmU/41KBybrHKVJs=;
        b=K1EI5oQbhSq/dyEMwXHw8oFBcYxZdJq0IKCbNupNooh2aKI4Ut+Vhfm0b7TJKJncth
         b/JNCmF46txfVsBd1gcHaVcVifBfAIdj6zJtbNUyWkbt0FBEzM0gsVPj7l7jTI4MiNgO
         o8LT/GbjgbE4kYcFwNn0pLCptsXXR5luSqjzPi7J3u7zr59q7hB2F++VuiiENmyK9Pcg
         +rYDcNysqeCJWfu3DXBbHNMOIrL/hU5MeG57kWknfOH/MTE3Y2kIReJcx6J70CyAfruB
         zkDuf9PzU+GyjYGfCMehdkl0/HHeVnKLcnmdzHhbStyE9Vz/h7CmpnxiagpPIPqDRuW/
         Pn6Q==
X-Gm-Message-State: AOJu0YwdsgQXygZQVVz+seV9+2RYuprsa2HC7bXab+QkWZNcuA0WXGbQ
	soIKTUJIBGjurr/qgkHze8LAKL3rbWUrE8o9EW2vg27Nm10IN8Rd3CIQ5T0vJCHAh6o=
X-Gm-Gg: AeBDievjfx2QSQcFWPuOlTucxoGXmZXAHg24P3RM8FDhcY08zjWLfMWQJpzNz0AO9PO
	hchTqnY5VARtafuYIC/Urz8WueVUxov4JGkCXCMsXxMyYhzMOPHQsGQxYzTDpLuL8ht26YlGq7x
	RqTLhKHZJSIU8Vii/ZB8nNo+3YJR7SNN5oGJsBsiAxnquZktgc1d2D6y1hydOJyLBEouKZA/ZjM
	FJdFEU72GScgLaQeP+a0zm876fmj7wAMRWpoNy7L65w4ehCrNS3xJzLaCOnJ3+BxIS7vtj5akEb
	Ez7+ESrUTtLXcXo1EVEOkiSr0S/zazHoGUr6NpkT0C6hYRBm6VmQFjNYXxVgB2fu7Eurv+xP5WE
	ik+cDUMGinvCHiM7Ok/xv6Rh+rTj6+euGj8OUe5FneclqcuBQIoB3J3GyWj63crJli00a54oZs0
	ZcFHLPd9kZKAJoUERg5eV2QRx9pgYHXOTKCyDgCe7XMRZ/EHFfX33dYYs=
X-Received: by 2002:a05:6000:2c0a:b0:43d:1c39:26fd with SMTP id ffacd0b85a97d-43d29305b12mr14362355f8f.43.1775405752340;
        Sun, 05 Apr 2026 09:15:52 -0700 (PDT)
Received: from nixos-office (195-23-151-163.net.novis.pt. [195.23.151.163])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d214f2b63sm28787819f8f.28.2026.04.05.09.15.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Apr 2026 09:15:51 -0700 (PDT)
Sender: Julian Braha <julian.braha@gmail.com>
From: Julian Braha <julianbraha@gmail.com>
To: maddy@linux.ibm.com,
	mpe@ellerman.id.au,
	npiggin@gmail.com,
	chleroy@kernel.org,
	jniethe5@gmail.com
Cc: linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	Julian Braha <julianbraha@gmail.com>
Subject: [PATCH] powerpc: fix dead default for GUEST_STATE_BUFFER_TEST
Date: Sun,  5 Apr 2026 17:15:45 +0100
Message-ID: <20260405161545.161006-1-julianbraha@gmail.com>
X-Mailer: git-send-email 2.53.0
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

The GUEST_STATE_BUFFER_TEST config option should default
to KUNIT_ALL_TESTS so that if all tests are enabled then
it is included, but currently the 'default KUNIT_ALL_TESTS'
statement is shadowed by 'def_tristate n',
meaning that this second default statement is currently dead code.

It looks to me like the commit
6ccbbc33f06a ("KVM: PPC: Add helper library for Guest State Buffers")
intended to set the default to KUNIT_ALL_TESTS, but mistakenly
missed the def_tristate.

This dead code was found by kconfirm, a static analysis tool for Kconfig.

Fixes: 6ccbbc33f06a ("KVM: PPC: Add helper library for Guest State Buffers")
Signed-off-by: Julian Braha <julianbraha@gmail.com>
---
 arch/powerpc/Kconfig.debug | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/powerpc/Kconfig.debug b/arch/powerpc/Kconfig.debug
index f15e5920080b..e8718bc13eeb 100644
--- a/arch/powerpc/Kconfig.debug
+++ b/arch/powerpc/Kconfig.debug
@@ -83,11 +83,10 @@ config MSI_BITMAP_SELFTEST
 	depends on DEBUG_KERNEL
 
 config GUEST_STATE_BUFFER_TEST
-	def_tristate n
+	def_tristate KUNIT_ALL_TESTS
 	prompt "Enable Guest State Buffer unit tests"
 	depends on KUNIT
 	depends on KVM_BOOK3S_HV_POSSIBLE
-	default KUNIT_ALL_TESTS
 	help
 	  The Guest State Buffer is a data format specified in the PAPR.
 	  It is by hcalls to communicate the state of L2 guests between
-- 
2.53.0


