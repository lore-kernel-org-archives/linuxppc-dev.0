Return-Path: <linuxppc-dev+bounces-25892-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30DEEC5B572
	for <linuxppc-dev@archiver.kernel.org>; Sun, 16 Aug 2026 13:56:54 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hNHZX4MRhz2yfN;
	Sun, 16 Aug 2026 23:56:52 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::636"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1786817599;
	cv=none; b=EvNXel7eRIVlqmMlLGkio7Xk8ebmScxWV3i6LGH7QgHb6hl5PkaAlEPmayRm+cRxRz3z6cJ4E9NvOm0+qb7QMSC0M1VsO9NPOQl9GEjN67E6Znb55psu9slwOXWgUOaUf89OHufQIEJU6lHBTKqdK0drlulHjPIdxOKbfTAm1ejQXPWnDm5C61jOo3RBnHGX5pJGYTtQuXLgd/6RDrqyXeIeyaVXUmcVsoLFRcW1ylXy2iPnXLrKj9tA3YO8XD8MSbxdrfakRWgNACJMqT2q0nzQUEZXrcflDfga2xkO5zlECG2sjjoPoLmwmvpIAXhycerZ25FWF8Mi0jpvYZb3Gg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1786817599; c=relaxed/relaxed;
	bh=hn1w8vtbj9zAmfIr6OtJvXMx3Rjgqtv0x/ZQ8XLdFkg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ebUOXvrPI9TUxLRhgG77LEZH3PNsCoJUANyktIQGHAcZcXAIH/50dfzEOk+DZVHzuvi99GGeGaoZeNdwVsrJ0HdNQdanEEl+mY15Wi0E+v/b+1mgDNTNtViIfvSblIW+qT0tITve/2EtyJ5L6R7HYFS8cfk5VxHw8x7jFNJV0rD1a0lyWSN/ptrlQWuPs4+ISB+7aLg8C3raK7dq/6am1GGRMrwAU0LIV+Md9HA8Sxv1//nNSJlaT0S3KTyHOOYouRxIZZ1HxkdDGivrmJHL0E/ihGM/AcS6IZKBkoLGu5uBtwWGaKmOijuqzGtCXV9FdqVhnx35bZ1HQ7QbX0ZXug==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=m7NtGXdk; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::636; helo=mail-pl1-x636.google.com; envelope-from=dragonliu2018@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=m7NtGXdk;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::636; helo=mail-pl1-x636.google.com; envelope-from=dragonliu2018@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hMnJv0zQMz2xlw
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 16 Aug 2026 04:13:19 +1000 (AEST)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-2cc61541f8cso38951105ad.0
        for <linuxppc-dev@lists.ozlabs.org>; Sat, 15 Aug 2026 11:13:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786817597; x=1787422397; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hn1w8vtbj9zAmfIr6OtJvXMx3Rjgqtv0x/ZQ8XLdFkg=;
        b=m7NtGXdkueqUn13oqpkY/O2sR9PUtfX9SWx63NeTCuBBWlqLa2diLtK6XkrbvCKeaI
         lrUReHsfemYUayk8/sW7aLCFnrASms0PIB1wmyb7QrVLtCWKmz1qMHLf/p6RvFzq4pIk
         6azcYichlU+SrCsOzXAnMuOCejKrxMXv6YqrwSThE2xhtyEoCF4wDuHoomeMzwmO+lIc
         PR1cbkAEaW2orpzWpioYpJYXSeGqrhN1mOr3uvc6nCwAyeqFydbIGqn7vvhWf4PTbIoh
         kLkgZPrABHCGLW4und9LsjSTTSyN/8fndCHxqlV7fFhMHI3NSZ5MbXGf74m5C9Puujvu
         fRBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786817597; x=1787422397;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=hn1w8vtbj9zAmfIr6OtJvXMx3Rjgqtv0x/ZQ8XLdFkg=;
        b=mCnxFvQ4qNwCGqlJWoDXmVfXtbTCdL670UoPy46y9OBdJYhQYjTc5GKdB5iPVo7nVH
         7Kmt928SOlhQ3oEUwwwIJ/we106x6WlkLNdG4dviXFQwFS4/AlmfhTS688hzFum99e6h
         Q5hHNLrEK1HbtJHhxOSA8MDNTOe52rvVxg0qisVX2OP+Z1/5scwhVcteShPyf5h4td2l
         AcdCCFDqbqLI5Y+wztU5YCUW+ZwGnsTw2FsR4EaqfjuWIFocmPU3oLWCM6/4HSjsKtmD
         Bcs6UorkAyCwHNB8t+R0TsRtd8+lP8GLhOzbGFizzegZyYOPBqrVHOyhHbr9W0bcPle2
         gViQ==
X-Forwarded-Encrypted: i=1; AHgh+RrGi7uPDSEHLsK2R9N43Z6+OD/dW52M7PGlhOX1YITjeH3PMlEZJ9iKrw0ne7P5j8XCkV+0R/Rkn7wL/zQ=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yxn9HwzFe8IKe5g3S7um7H/kLQITrsyhU3ccTvOpWqz30FYfk09
	JwgaQvqz8XTkjdnpCc1TAkUhldfbuXO6wIYbXHeOK+puc8llSRQrMZp8
X-Gm-Gg: AR+sD12x+Ea2rfFsT4JQGZejwTo1myra3VUiK7u8Pc5huxclTIHvMZHEC59/Wd+yDQ7
	E4TGZEdeERgoZF/0X14qpIdTHiQMMhcuw8kzYIPNTyetWYMOPuOeoQsYQVG4GFlOeRotD4Z8PNm
	2P2p/hO5LvUx2ve3bppNk/+A8H3YM68/Y5BvjQ/ffk1nYXHI8bgHL+xCuilA4YzvhxcPo4JnreP
	FAbo5qFh+C9x5hxOGRjbw8+o8Hafmt9ZtHmDXz5IZ4Z+GlUuPCYUx/UPOk8eCH5u9FVmFlGUrRi
	nFVTZGLPG9P8cEYVKtSJdvcr86eE0YAmSDQU3GA/y9OYfB+1TMdMG0yC2DrXP7cB/IyFT/VtvSh
	4shREynVLPv8TrSND5/vcanW4YkuIIrTknZwXrFkC687VC/vgiVwa5qfVPR44tmJ7e2kED24MQ3
	fll8/2JAGmqRds3zMz2kPL1Vf4QvXLFBmisA1epw/Ly7Ur+5C0eIraaMpWTirzH96e2HangxxDX
	ohCnMvlDqwGAx3ArRadSl90Kg0=
X-Received: by 2002:a17:90b:37c3:b0:390:84db:888e with SMTP id 98e67ed59e1d1-3933afb4ba2mr11589304a91.7.1786817596734;
        Sat, 15 Aug 2026 11:13:16 -0700 (PDT)
Received: from localhost.localdomain ([240a:4280:4800:6ace:25e8:2607:e94d:caaf])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-394eb7539d3sm7304254a91.15.2026.08.15.11.13.10
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 15 Aug 2026 11:13:16 -0700 (PDT)
From: Liu Zhenlong <dragonliu2018@gmail.com>
To: andi.shyti@kernel.org,
	chris.packham@alliedtelesis.co.nz,
	jochen@scram.de,
	maddy@linux.ibm.com,
	vz@mleia.com,
	piotr.wojtaszczyk@timesys.com
Cc: mpe@ellerman.id.uk,
	npiggin@gmail.com,
	chleroy@kernel.org,
	grant.likely@secretlab.ca,
	neelegup@linux.vnet.ibm.com,
	benh@kernel.crashing.org,
	wsa@kernel.org,
	stigge@antcom.de,
	linux-i2c@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Liu Zhenlong <dragonliu2018@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH 3/5] i2c: ibm_iic: fix device_node refcount leak in iic_probe()/iic_remove()
Date: Sun, 16 Aug 2026 02:12:02 +0800
Message-ID: <20260815181204.2321-4-dragonliu2018@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260815181204.2321-1-dragonliu2018@gmail.com>
References: <20260815181204.2321-1-dragonliu2018@gmail.com>
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

iic_probe() calls of_node_get() to take an extra reference on the
platform device's of_node when assigning it to the adapter device, but
neither the probe error path nor iic_remove() drops it.

device_release() does not call of_node_put() and i2c_adapter_dev_release()
only completes a struct, so the extra reference is never released, leaking
the device_node on every probe failure and every adapter removal.

Add the matching of_node_put() to the probe error cleanup (error_cleanup,
which covers the i2c_add_adapter() failure path; the earlier error paths
jump to the same label before of_node_get() runs, but dev is kzalloc'ed
so dev->adap.dev.of_node is NULL and of_node_put() is a no-op there) and
to iic_remove().

In iic_remove(), i2c_del_adapter() clears adap->dev with memset() at the
end (commit bd4bc3dbded9 ("i2c: Clear i2c_adapter.dev on adapter
removal")), which zeroes adap->dev.of_node before of_node_put() runs.
Cache the pointer before calling i2c_del_adapter(), the same approach
used in i2c-mux (i2c_mux_del_adapters) and mtd (commit 56570bdad5e3
("mtd: core: Fix refcount error in del_mtd_device()")).

Compile-tested with gcc-powerpc-linux-gnu on ppc44x defconfig; no
hardware available for runtime testing.

Fixes: 9fd049927ccb ("of/i2c: Generalize OF support")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-5
Signed-off-by: Liu Zhenlong <dragonliu2018@gmail.com>
---
 drivers/i2c/busses/i2c-ibm_iic.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/i2c/busses/i2c-ibm_iic.c b/drivers/i2c/busses/i2c-ibm_iic.c
index 7c70e8bda24e..5c3b973c40d9 100644
--- a/drivers/i2c/busses/i2c-ibm_iic.c
+++ b/drivers/i2c/busses/i2c-ibm_iic.c
@@ -751,6 +751,8 @@ static int iic_probe(struct platform_device *ofdev)
 		free_irq(dev->irq, dev);
 	}
 
+	of_node_put(dev->adap.dev.of_node);
+
 	if (dev->vaddr)
 		iounmap(dev->vaddr);
 
@@ -764,8 +766,10 @@ static int iic_probe(struct platform_device *ofdev)
 static void iic_remove(struct platform_device *ofdev)
 {
 	struct ibm_iic_private *dev = platform_get_drvdata(ofdev);
+	struct device_node *node = dev->adap.dev.of_node;
 
 	i2c_del_adapter(&dev->adap);
+	of_node_put(node);
 
 	if (dev->irq) {
 		iic_interrupt_mode(dev, 0);
-- 
2.55.0


