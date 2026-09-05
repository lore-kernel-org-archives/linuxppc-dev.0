Return-Path: <linuxppc-dev+bounces-26607-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9165C624D3
	for <linuxppc-dev@archiver.kernel.org>; Sat,  5 Sep 2026 10:43:24 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hcVL30lDBz2yv2;
	Sat, 05 Sep 2026 20:43:23 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::434"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788605003;
	cv=none; b=JXSPH6bCf53auPSEbnco3po8MJIdDMvbtf9kto1W3tHvkiE57Iy4Z5GE/Rii/6w/SFbI7aNkm+GiDU3rKk2juLZuanWuL5kDnghTPlhQMQz8LTuNrnMRCvZ88zLy8n/ZkLeK0gNr4jsGsEATYRUsM6laTuhjQxZhakqOOeZiYmlKB6awnU0hICWcydFB53ZLR5hc0xr7Vq7zINvY2wRXEFd1dhgGrTJp1BW7iF/Kd3jjIOBpGDjYrZZc4gYzDKDA86KyvKUm0dx91KBp/0x1h+2zkRsEcJI3AQiWz0LlxWC4smh5XgYYhzmYZndKJVcyVXeZm46JlxJnN+ikg6hyXA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788605003; c=relaxed/relaxed;
	bh=yYKzgOeBZLaXbTK9FiFpJ1LTahc5Bghrw6NjETh12gg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Anq1uVXP65HgQZDxAwjJImYrPB/dhKfCOOzvzhJ7Z1TD4Fq20bkUzqY5P3tubwFyR3jOZpepILw/uQgBiRkxuLemApTRqfNaMv+fu3MdEf37/G44vo6ASunU00jAbise+hXC3jrmc3uVu8SAh33BIJ6OmB4yiCDBlwa0m/oTTdZpwXxuKg2FvBZk7OyT83Kmu3eKcWDe+SehB9pGtt1hoipY+mzwUh2GY1qY5+FgRt9omrEpM1izO7MX6OtAD+7+/ihpJJt/dVQyw+2MHif0Pn8WAO262s5Vbwn1oQISBjejxnKvlnD/m+zRB8UefY8nD0yjfByIgwvejkHO5l6egg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=IOYjlNc3; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::434; helo=mail-wr1-x434.google.com; envelope-from=kmehltretter@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=IOYjlNc3;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::434; helo=mail-wr1-x434.google.com; envelope-from=kmehltretter@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hcVL165qCz2ytj
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 05 Sep 2026 20:43:21 +1000 (AEST)
Received: by mail-wr1-x434.google.com with SMTP id ffacd0b85a97d-48436251906so2088892f8f.0
        for <linuxppc-dev@lists.ozlabs.org>; Sat, 05 Sep 2026 03:43:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788604998; x=1789209798; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=yYKzgOeBZLaXbTK9FiFpJ1LTahc5Bghrw6NjETh12gg=;
        b=IOYjlNc3UO4aRoC4nN0SKK208xNne7HzxfIu2gflEiSxpetGVMA3kSbfLJn2G0Z6F2
         zplpRc+MClPw1mZPwzDymVnucJ6EMbBGiaXscKd2l6lsIkpR/TBiUWiOSUaarR7AoQBO
         /7R16GBeZ5fWeIo5h1BdP5XdsNNpH+t5pk/4EoINFPm1Pu5kiaBosuVWUcRXxmKNf5ou
         UKhih+LcpHFAHabsb39neMzvh375+y6gSZ/4BytcY3YTFPZR6DHktWxfuU6zRHmfXEsJ
         b4CZO0JuqeElMV6THLOd3VacoRLgHFDSMN5IwWtFKEVrhHI98hEfXKSFJOIXabia6395
         7uHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788604998; x=1789209798;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yYKzgOeBZLaXbTK9FiFpJ1LTahc5Bghrw6NjETh12gg=;
        b=AH/PRP+Xqpt5wFReNlGSODjEKTKZOY0RT8rmkViDdhONw1OhMRESPXVTxNP5UMjaRd
         /EhKivnc2QmSDynSP2YbqxcRPybmdcKdoQRD0vKByvehA0CyRI7s1xNeHP/RzGwQDzl5
         /aHjU/ZiLgxqcFmG2QtyWoPbTpD245p/r/zw6Dsn2XwbWo5zzstDSaP0UnNmjq6REZsZ
         fO+9gm7pTYfwe2dAr7F5PoRipN1fOBjeAOWGz7bp02SsGs5QQ/uP9m6b2FoCwaAfi5Wl
         Vbh1wtzCsXTG3mRM/QoBF007/rBLmvUJk1YqYKWyykWvDT86V8vzwkVRCgG8ydWRA8gP
         DwOw==
X-Forwarded-Encrypted: i=1; AKwUvBwWmbgjU1eAXclWQ65nrZOygnFrXmsoEEMuiNJe7I3RWArLHgaskNSJD5NPZg4CngddibJLbg/ceL+XB2s=@lists.ozlabs.org
X-Gm-Message-State: AFuF++k/QJUGgEBWsg1dbcV8TcNc+MqErHHCSS7xycRYRg9Gn3rvgSuq
	eet196oFSl2q1EFYXIZrjWCCA3xzoI6N6V6bHlJ15E+N4YPsVKlRG9Xa
X-Gm-Gg: AYBFou3QcJMRPrkV1xuJiO0RRxVbj4dYBYNpWB41/AXbdQ9YZ1YWd7Q4IYKp2/5BbZX
	NkB/YS6demdiSLcqvOJQ67bsP2dR6bmpv3YZNx1p6puVxndn24DnjO+hYF9bKTDWhBVI8/TyDpq
	JGQanF+bf53DPoTB4vQhbajx2fSUObfoPMRlUyTeuYAHtvnzYGN32CZTdp0r2HPnzkSO80OKYt/
	W1J64bkeuxoY/JTy4v074XZvCV+hw5x0AVLkeyx7hz/iuSHg5F9Y1WDwL8VDylq+n+vG8V5iaY+
	GM8aCfyTpQV6h0rfnHw7sI4PmQDRj8jJZUAH6jiKEulHOSUWP0jYU647zMkX9vEzohFGcgX4JZV
	46Y1hRx6llCNVx17MSaom6IcsruKOslAomyYCtwu6W5Z39q5kMw6qiw+60Urd3nMuJVPBaDdMgL
	PjzfBg+cBcygZpoHpEerpLGzbsgOLloRgIc1JQ9XknWPLNHS6u5kknSJbVZfsdWI3ncqPzXd17F
	18Ym+EUHljD1IXO0iWwdyiuuflAeVXDHrmIabkdZp5DNIpk7LfpyTOj8yKR5yVEbF9t/PgOz3ZS
	UaNLQ+iHvDTi3NgfhAoUzLfSQCQIDQPYDbngFD8nKAdIvtr+EzYrPwsgeLwmOPuEaywK57KhDJg
	qcJAQ7I80sIg=
X-Received: by 2002:a5d:5889:0:b0:485:8b5c:da26 with SMTP id ffacd0b85a97d-4858b5ce16cmr19044594f8f.11.1788604997962;
        Sat, 05 Sep 2026 03:43:17 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a02-3100-a4eb-3001-c06d-af27-9fa2-ea53.310.pool.telefonica.de. [2a02:3100:a4eb:3001:c06d:af27:9fa2:ea53])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-485885bbb51sm13206632f8f.30.2026.09.05.03.43.16
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 05 Sep 2026 03:43:17 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
	Haren Myneni <haren@us.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	linuxppc-dev@lists.ozlabs.org,
	Jonathan Corbet <corbet@lwn.net>,
	linux-doc@vger.kernel.org,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH] docs: powerpc: vas-api: Use the uapi structure name in the example
Date: Sat,  5 Sep 2026 12:43:13 +0200
Message-Id: <20260905104313.43620-1-kmehltretter@gmail.com>
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
vas_tx_win_open_attr.

Use struct vas_tx_win_open_attr.

Fixes: c12e38b1d52e ("Documentation/powerpc: VAS API")
Assisted-by: LLM
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
---
 Documentation/arch/powerpc/vas-api.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/arch/powerpc/vas-api.rst b/Documentation/arch/powerpc/vas-api.rst
index 1d0d055356e3..00d98cfd95c9 100644
--- a/Documentation/arch/powerpc/vas-api.rst
+++ b/Documentation/arch/powerpc/vas-api.rst
@@ -265,7 +265,7 @@ Simple example
 		{
 			int rc, fd;
 			void *addr;
-			struct vas_setup_attr txattr;
+			struct vas_tx_win_open_attr txattr;
 
 			fd = open("/dev/crypto/nx-gzip", O_RDWR);
 			if (fd < 0) {
-- 
2.53.0


