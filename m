Return-Path: <linuxppc-dev+bounces-27939-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85962C98302
	for <linuxppc-dev@archiver.kernel.org>; Tue, 22 Sep 2026 18:29:54 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hq7t83THHz2yqL;
	Wed, 23 Sep 2026 04:29:36 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:38::f"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790101776;
	cv=none; b=T4is/JXoPsv+oWsZn8d5JqYRNSrgi+NzOR2p0i7uvGUZLG+4E0874xa/lWKrokyWzv4BFzckWggZmoV3NF7tztP3TOv4SXrUiOhUIRLP5G1Hw8iFsR+1X3o1/2T6uuahNj5FqCFTKPgb8Y+ax3W/zv7aOAOXKwP3cHbuF/HzXEplP6quv+/cyUrac0N9hxutg6ICuoZxyL0S+Rm4VTUqMCp2u7N6Jq9VUw2RiMald1ezUAHBYybp/K+cd/7jBjAZ7yYsM3BjcmS9bcZy9n1ZhTPkTtxwiTdIBMr4NoBDnc/3KB6SFR3K1buVNbUVwwCQsqwhsKQL1w6ZPkrvd4DVjg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790101776; c=relaxed/relaxed;
	bh=w4tObarZqWzLfPDYSwGxwQwAXuFMWWhRAhqBOMQynsA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EhFg9ZLGzTwY4dCcd2ASIDKZY32T+olOQZ7w63JxIMuUdl8x7fE/OpsnX4F7zeIs3yiTh0pUtHUqGfh41ZhM3K7Ev+KriIbruWnXGKOxnpYOYtVRrFxFRPuNf1zTOGIIasKXc0DswAjjATRITNsrxaShuThszisYlaiCJvw32cUdi8CEQrouoOLNBAt6qQaSrjS0fsCF80pvoNFhGN1H6fQhEp+/7M08lCNbmFa5ricU0TuIYPNeRgeOaaEJqvLIYtOccktMoQG3csBh9lJ6xu1xol7TP9DHGq6+w23M5inPhwrpwhKzAQ+rNrNdu0K54uguiRne6sLdH+3j5AS+RQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=r0KeYIPi; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:38::f; helo=mail-dl2-x0f.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=r0KeYIPi;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:38::f; helo=mail-dl2-x0f.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-dl2-x0f.google.com (mail-dl2-x0f.google.com [IPv6:2607:f8b0:4864:38::f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hq7t76G5fz2ygK
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Sep 2026 04:29:35 +1000 (AEST)
Received: by mail-dl2-x0f.google.com with SMTP id a92af1059eb24-142dd04f7f2so158833c88.0
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Sep 2026 11:29:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790101773; x=1790706573; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=w4tObarZqWzLfPDYSwGxwQwAXuFMWWhRAhqBOMQynsA=;
        b=r0KeYIPiLt/rrJxbV5v2IjEYUxDJietz67za5FXJBn2jUN4RvcPoUE2Y5T1fVCojy2
         sXTHfyKht+/w4t+bkPonjaJ0PI4fuB/HaaFyI8O6G4QTU7IX5Ztqr7tnuuFE9I9tXy0j
         H460c9F7gYDxV5FxbDYECqHXmp02WAMiJtTwy8PXhApvdcMvRiutMHx7GOezU5ryB6qd
         LO+B8cNaoUmwC01sVnf0pPi2y5sdEdbzR0KGaSmEVkes5UxaKYms6QYAc3CKg6W+t6uO
         UZTCVHkAcODKv8NFVSocr6EhWmh9edoP28TXrJ2NcsOivQ5y9zu5Z/VplJKkE+HnzUPW
         U8Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790101773; x=1790706573;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=w4tObarZqWzLfPDYSwGxwQwAXuFMWWhRAhqBOMQynsA=;
        b=RzKr4jI3LAdOcxJI7f4rNzP+DDhzZ9tl5p1FRbZT5CZmYG2QpMMH2Mogd4ypCsKOfq
         KC1h9sGbA37IkVonTwME6iGgWxHtq2P1vIVfBQYPve8PYhbHGc7AEz7R+jSvsthLGBTz
         A4MZwDkWO80BGeb87IPxCTK9c85cnlgqLJ9GLebTVDGhvSFDlY58bLbUNthkaQ/n3y9w
         fy699uS7+B/x19RgTqQgQAWvqe1ROhCY+MoHZ2VVGjh5SbUApDg4UlXZ/GUkr0nal7Mj
         pn4NuR1hkBr2iEHuNf86J0SSAUWXTgLcznNANXgP7nXnymgU+Ox6PakQmP04hUOE7M6L
         VFJA==
X-Forwarded-Encrypted: i=1; AKwUvBwx87qgzvVFKwdxi/4/QxwnaNp+8ZnbDrhxkxuj4V182WOn+AORaETQuYJBvQWCzYDm1ztKrMs2EHbItLU=@lists.ozlabs.org
X-Gm-Message-State: AFuF++lX+CUJJ/zV5tKipaGgP+/ha1o+/9FdJKxwymuxpMAuEDKJaKoX
	+AM5Rxajal9cOb9otfWLl3kKqD5WCjQeWohogKLemqOisKG3XUQDLZqoFh0z+w==
X-Gm-Gg: AYBFou2NMO73YJJ91q3H6dClL+Vb/M0w1HsS6syzvgcqfEoi75wtzD+65kOnvWnuLd+
	/T03vZb+nqjvRcE11ImL1WzsnHBLtwL0+MXxpaT9KpbCzcOOfPu5man3rAPgsUCWh9GWwnxPif3
	yoMNIr/6Udo9RmtyjxZXY2msyXhTa12b2B0SN4YjbHfJK+y9YPimjM7DqXLRemPUBb8E/K1KnSc
	/AtdTUIcjE/usSZhCHV7QbUsOy6jfoY9EBdrw9yNsUhBt/FWaRz9hz15zEm/waJYvd3AnTJOpcE
	ySi/NldCNz0NmXi9cwWYVnYvjnRU17DnIC/1GQ87KgzB6p3aAqq57i/pvlZcHCUpPKi207ILOgH
	QZ5wHtZpegfQi+Jco0N0GPVDrHUHsIp84pc2kCpK5Q+cHriklOROdZtsH5VeE6lo9ZrGpw0deUn
	uqBJESw7vudWZelBTINXA6IuBasM3udvfZDGJjgCPUwgzgn2qtJbqA/GBD2UZPLEYJ4pv52M/x3
	QfildEIUI02JnKEUJBjd7dXVQwEkBX89uWeZkBr5m8M0x92ig1HuAHscPj6
X-Received: by 2002:a05:7301:2421:b0:33c:e8f:5701 with SMTP id 5a478bee46e88-33e8e1b3d3amr121483eec.34.1790101769713;
        Tue, 22 Sep 2026 11:29:29 -0700 (PDT)
Received: from pve-server.rlab ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33e939fdabcsm154315eec.3.2026.09.22.11.29.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 11:29:29 -0700 (PDT)
From: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To: kvm@vger.kernel.org
Cc: Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	linuxppc-dev@lists.ozlabs.org,
	Michael Ellerman <mpe@ellerman.id.au>,
	Christophe Leroy <chleroy@kernel.org>,
	Anushree Mathur <anushree.mathur@linux.ibm.com>,
	Venkat Rao Bagalkote <venkat88@linux.ibm.com>,
	Harsh Prateek Bora <harshpb@linux.ibm.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	linux-kernel@vger.kernel.org,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Subject: [PATCH v5 3/9] KVM: selftests: Don't limit LE dirty-bitmap bitops to s390x
Date: Tue, 22 Sep 2026 23:58:47 +0530
Message-Id: <09b1330bb7ef56920ff451af15f98ea468899209.1790101179.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <cover.1790101179.git.ritesh.list@gmail.com>
References: <cover.1790101179.git.ritesh.list@gmail.com>
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

dirty_log_test already has BITOP_LE_SWIZZLE helpers, but they were
compiled in only for s390x, so every other big-endian host used native
test_bit().

The test fails on big-endian powerpc because it treated dirty host pages
as clean (because of the endianness issue)

w/o the fix the test fails with:
  Clear page 1 value (1) >= iteration (1)

Fixes: a049a377164c ("KVM: selftests: Enable dirty_log_test on s390x")
Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 tools/testing/selftests/kvm/dirty_log_test.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/tools/testing/selftests/kvm/dirty_log_test.c b/tools/testing/selftests/kvm/dirty_log_test.c
index af5eb0334a74..8189eaac713c 100644
--- a/tools/testing/selftests/kvm/dirty_log_test.c
+++ b/tools/testing/selftests/kvm/dirty_log_test.c
@@ -44,8 +44,11 @@
 #define TEST_MIN_WRITES_PER_ITERATION	0x100
 
 /* Dirty bitmaps are always little endian, so we need to swap on big endian */
-#if defined(__s390x__)
+#if __BYTE_ORDER__ == __ORDER_BIG_ENDIAN__
 # define BITOP_LE_SWIZZLE	((BITS_PER_LONG-1) & ~0x7)
+#else
+# define BITOP_LE_SWIZZLE	0
+#endif
 # define test_bit_le(nr, addr) \
 	test_bit((nr) ^ BITOP_LE_SWIZZLE, addr)
 # define __set_bit_le(nr, addr) \
@@ -56,13 +59,6 @@
 	__test_and_set_bit((nr) ^ BITOP_LE_SWIZZLE, addr)
 # define __test_and_clear_bit_le(nr, addr) \
 	__test_and_clear_bit((nr) ^ BITOP_LE_SWIZZLE, addr)
-#else
-# define test_bit_le			test_bit
-# define __set_bit_le			__set_bit
-# define __clear_bit_le			__clear_bit
-# define __test_and_set_bit_le		__test_and_set_bit
-# define __test_and_clear_bit_le	__test_and_clear_bit
-#endif
 
 #define TEST_DIRTY_RING_COUNT		65536
 
-- 
2.39.5


