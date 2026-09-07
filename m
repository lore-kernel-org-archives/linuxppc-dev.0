Return-Path: <linuxppc-dev+bounces-26627-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A9F6C79F8C
	for <linuxppc-dev@archiver.kernel.org>; Mon,  7 Sep 2026 00:49:45 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hdT476DBJz2y8c;
	Mon, 07 Sep 2026 10:49:43 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::334"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788742183;
	cv=none; b=J6nIkBFCtfwprFxanCLlTrZws+5Gy+r45lLUX5vL/dhylC4IFxZNYOAIFxeiLmBJqsStfhVUa4LumtDtcijfmdjx9qG+YHiBZSVmvAhX/C4Tivy6aBOjvg1TzqjE5ruanUKBJ2AtX2XUL3fO1MkBowL/ddnu5Ysjq5gAqlxLQlJucKlHmsEhkN0/6mtnCWoc82cjJyF3Wlx+mZ8ru/O3uzBfk0p827kkYDac7hRuMrKl87FAaaGfnuKKUmWDsD7sieVVa7kodHAjiUOTwYCA+P/5urQv2xZWoo1BDG0gkfKNPwUYbdhzf9z0a7g0dlxHx5BMjJzvrAMbGm8gtZlF6w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788742183; c=relaxed/relaxed;
	bh=9LVmuTrLSm2/9tHtDWTw4c0WbiPr4Nr8ick0kaPHngQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=dkUWo5zXpGYl70+cVDeNcb4iY9sohbCtk+MHI5v6qIX9KSKK9C2k7Fe2EBhjQ06Xk1sUcb9/NYVdi9aZnixM4WRKu/7FRSFHcNV98qwK9Q/0EXP4gco5LccP8/0tU9YfNiSVMtFc5ABHXzbR8jRVN76k5/lbnL6tzjLSV5Id7EwIZcB2n6lzvRl6CymJXl7HseJ7ViX88Yp7HwIba1gb4DIrD6STJYeqz6XiCjoOfK7mPNiB+GNQP3UBFJChGbLRlDPc/6zuq0hmwDHIerOAktIPP7VV/89n+m8+pYmURykXlKyMGwOOyubGvee9P1qeLd1c+3eVpn2RQNz8sEeNNQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=UNdxtWWY; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::334; helo=mail-wm1-x334.google.com; envelope-from=kmehltretter@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=UNdxtWWY;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::334; helo=mail-wm1-x334.google.com; envelope-from=kmehltretter@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hdT466Sp9z2xmh
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 07 Sep 2026 10:49:42 +1000 (AEST)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-499ae1c6471so28581135e9.3
        for <linuxppc-dev@lists.ozlabs.org>; Sun, 06 Sep 2026 17:49:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788742175; x=1789346975; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=9LVmuTrLSm2/9tHtDWTw4c0WbiPr4Nr8ick0kaPHngQ=;
        b=UNdxtWWYig3lqb0h5nk2LOBIObdKGU9KEjFwTZ0gTtIjWTzD4rRxZvsF40n1o0U3Au
         FOxWyBOFEgil9SxpdcJe7c+dIxwswujTjUTOcKUaOxPw/DqGo0kQ7BUdw952FbKSuPvU
         5o2olPptxd+LGvOHEbhJrDz1CbfvJ9gnRo5EbIdMgTzeTMEIil7p6h5/yZNl6A1zHCLz
         PcGxfUJJmKLGQoqqujPhdJcMMRbuPYn8k0Sf1RaXbpfhk35imGM4WxsT6fXRtcJRYjMC
         xeguXm/u53dNdB13+93Gv41S1pqmNEr1wsumdfHKFbtp/dPYBLLqsP2irJh2L1cxUmaq
         YqFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788742175; x=1789346975;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9LVmuTrLSm2/9tHtDWTw4c0WbiPr4Nr8ick0kaPHngQ=;
        b=ntKIvhrs1zZDpu5NGoVVzgD1o9mczohgvbEZVvb+3KpPBZutVv9d3SjqtVl24KkCgF
         jQ4hiBA9P7J7bf1iTGMfrJKnFcYz7cFWRujlQzTzTlbWMcQN5CHFQWQFhmOb0VcvFAEf
         IBjdGMGWaZyCvd5t6i9SSmEUQFYmZV8cZUbfXNpb4d4UT9lLLgsQ0fRSUUut7qeNpLnQ
         Vg/bH7IO8D9DxY2IJcDevuKjJ7j8pcbz/5jnErHP7gZVPM7WxyyKkFyUhRgMzK691pNZ
         i93BCMlVQabFEbiWG9T4of4QLq7ANTJ8j4hM2UL9cj7hUMjBqbW7PICbwMhHhNVq0+dK
         TCGQ==
X-Forwarded-Encrypted: i=1; AKwUvBzs57gOAN8jjWusAKgoAjk+Q1ZrEXZy8PNftUHvbFzTrCIo+hWnMB7ho6yTb+pXNuNmRfN/0zmUWJP4kSU=@lists.ozlabs.org
X-Gm-Message-State: AFuF++lQctRzLZDuiPbne8K2x8q87ecMiIVCIcD3bruj67TA9HH40SqG
	Sl9Z9RxmdmagDfnlrUudd8ZrR9ovtceZxUVrpKrRUPDBOUwYJ6SwD7Rp
X-Gm-Gg: AYBFou03oQUyKYCI85c26a+CF8Xm+0TmNS8z8VurOrYsUFjpUG2YNc9D08PM6YiBikw
	59NSCbofsGA8LSNmn3f5uIlHoeTy864gRbBv0y+qwvT+7mFbguGGp8Xm3E5Pk83NYCkuzLBUT2a
	k1tI787n+uywBq+PWFWftedTcCQw4B1wWiOqGd5m+6V5M3Qc0jVUtDoyRyZAnLx+MXP7ScukqfT
	XxnNkieByvyGzDduX5PQ41dU9UNID4fWP4sInmEElnPA3MJXRmgu24ARyr94+fqmpghZ+Q23Tqg
	luPBIEXuPyt/aiWAXk4aYTxP2D74YJalN59WlH9WMDSWo/hcxAT+/TE8Us7GiTRHhHYIy2BBRGI
	gQFKrbbQImOVAcpRhoONNGSKcoeCWXaVviTs7UjFtvYdQu8650FgNRSWncmT864kn2nrgXktcdB
	yF+j0s11VBwLf2/UCir658BPiXbxUQALPwfm05o6fYKyVxFFvPaoMAjxSYS+EcPsUDi+7Um4HE2
	DOxD10QeEuT2QzeWmC+A1mTj5O0N2eLUSxEldoH/JNIVsnNyP9hsvTPNRailHwTIgbgVhY+sQ4b
	mle+gIUF4MHC15SiTYr6/OujKHajqIoeLnpFul9uMVAJyqOwafwgm9fuHfwKzNbjdWTAMZTU96v
	OWg==
X-Received: by 2002:a05:600c:c4aa:b0:49c:e3c3:5efd with SMTP id 5b1f17b1804b1-49cf8241a84mr334204825e9.9.1788742174581;
        Sun, 06 Sep 2026 17:49:34 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a02-3100-9d84-5101-9c80-d25b-14b6-410c.310.pool.telefonica.de. [2a02:3100:9d84:5101:9c80:d25b:14b6:410c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cf7736132sm263462605e9.12.2026.09.06.17.49.32
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 06 Sep 2026 17:49:34 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
	Haren Myneni <haren@us.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	linuxppc-dev@lists.ozlabs.org,
	Jonathan Corbet <corbet@lwn.net>,
	linux-doc@vger.kernel.org,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Ritesh Harjani <ritesh.list@gmail.com>
Subject: [PATCH v2] docs: powerpc: vas-api: Fix the structure name and the ioctl number in the example
Date: Mon,  7 Sep 2026 02:49:25 +0200
Message-Id: <20260907004925.10948-1-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
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

struct vas_setup_attr does not exist; the name is struct
vas_tx_win_open_attr. The example also defines VAS_TX_WIN_OPEN with the
request number 1, while arch/powerpc/include/uapi/asm/vas-api.h has used
0x20 since the ioctl was added.

Use struct vas_tx_win_open_attr and 0x20.

Fixes: c12e38b1d52e ("Documentation/powerpc: VAS API")
Suggested-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
Assisted-by: LLM
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
---
v2: also fix the ioctl request number in the example (Ritesh)
v1: https://lore.kernel.org/r/20260905104313.43620-1-kmehltretter@gmail.com/

 Documentation/arch/powerpc/vas-api.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/arch/powerpc/vas-api.rst b/Documentation/arch/powerpc/vas-api.rst
index 1d0d055356e3..f74ea9fbc8a0 100644
--- a/Documentation/arch/powerpc/vas-api.rst
+++ b/Documentation/arch/powerpc/vas-api.rst
@@ -136,7 +136,7 @@ a connection with NX co-processor engine:
 	follows::
 
 		#define VAS_MAGIC 'v'
-		#define VAS_TX_WIN_OPEN _IOW(VAS_MAGIC, 1,
+		#define VAS_TX_WIN_OPEN _IOW(VAS_MAGIC, 0x20,
 						struct vas_tx_win_open_attr)
 
 		struct vas_tx_win_open_attr attr;
@@ -265,7 +265,7 @@ Simple example
 		{
 			int rc, fd;
 			void *addr;
-			struct vas_setup_attr txattr;
+			struct vas_tx_win_open_attr txattr;
 
 			fd = open("/dev/crypto/nx-gzip", O_RDWR);
 			if (fd < 0) {

base-commit: 986c24e0fe44f844b44d365b71ce831947f50298
-- 
2.53.0


