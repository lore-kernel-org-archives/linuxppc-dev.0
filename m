Return-Path: <linuxppc-dev+bounces-27058-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9242C88E41
	for <linuxppc-dev@archiver.kernel.org>; Thu, 10 Sep 2026 23:55:11 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hgvft0bLRz2yvT;
	Fri, 11 Sep 2026 09:54:46 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::835"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789084486;
	cv=none; b=bTNLLFqw5HSjQlm+hb5n3g5lQ/CQfr6bDogmuQYSQMJLXLzhYfWojf42J+QydHBvcXm6mpUb6kMvqd82BriNe5k7e13rL6/n+dq0D+ftnAyHEUYNnB8a4D3KyjAd4gD9BSGIumNOCQxGA0PdNrC47wgI4f4RKPSMqnbG4NvexsdHrTEK4hCaKePAiC4WbHQ29De85YhrGHyCyZ9EYNhyY3GR+50O19UvU8vpmnuRKQrgP+dotwNHCIl57jegu7XrWjXv0DhiKzNbchlsSql2zpMn6NZoJWBB6kzvlNfpSbiFCXozx7S3UO9kKxMeMpWY5TTV7AA+UzUvPW+ZWHVpDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789084486; c=relaxed/relaxed;
	bh=aXOUF/0dKfcL9nM72QWKoaIot6Ph6ib6YvMRCU6EYeU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EEsn6wMPGdmqYLaNbTCdD3KAptZPpduE6gbAhR5bpN6mSWFB9DUSl+SF28Pev32P76dd7Yc0+kQtxVkJC7cce7tc0SULjvCtTArn4+0k0xCZbapYFcOAvwrsScwyhrLYCrcAofFOFVFl3IgHpxfmlZ8v5AzAQVNPQeiSqHLD2Baom6oqgMVXOEyavqzUDgf8WAr6wA8gXOLDtNcrpmaoh2w0aXM+Vh6ot2P11pviXqMph2L+dJeD5qqOCSlzZ+hmogo3rdcWap0Q7vQ4/yb5dj1IzuN6E09IvrKUV4IO83WtZBWTA3c4iS1DQ0MV7rRnHmTf7500+9k8Xk518m/X3A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Zwc9QgW7; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::835; helo=mail-qt1-x835.google.com; envelope-from=mhun512@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Zwc9QgW7;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::835; helo=mail-qt1-x835.google.com; envelope-from=mhun512@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hgvfs2hgpz2y71
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 Sep 2026 09:54:45 +1000 (AEST)
Received: by mail-qt1-x835.google.com with SMTP id d75a77b69052e-51bfe810293so4499001cf.1
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Sep 2026 16:54:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789084483; x=1789689283; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=aXOUF/0dKfcL9nM72QWKoaIot6Ph6ib6YvMRCU6EYeU=;
        b=Zwc9QgW7qnOFUk+SyF/EmiN3kNZKUD4wRVqimtxJh/rflUCzN2KT7qhawjKlqNtyZL
         TQ99UKG9WPxj8StNViyGtl6QZzkmjtLkGlmDl4RiQtZcM12Bgmcvtdbtkv7yaJPFWe6g
         vuTfGcoS88Bk+fQvMAb+UzH8PfJ++h0daCy6tYYUOZyCPZFfoYQYqhIrMjbewTu10J++
         gVibb40IGdsHVw3Q5I3pqXxAuki9120YhUr4NTDZGYbyaSJJusl4tVTmkHHzTXUogpYF
         lfrXSf3PWEAB40o52txJLHwWFFjIz1ja+rzkyODfLRLcj1/6usS9HmsU1zSVyvFwbUX8
         HJLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789084483; x=1789689283;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=aXOUF/0dKfcL9nM72QWKoaIot6Ph6ib6YvMRCU6EYeU=;
        b=GBsRgpBr8id8qCUVqCOuOIAKKz54iy3mdykojo7J5NEjJGaiaFpJPO6MDpoVh95Fmx
         ikHboWmLXm12mdnDc9TtafO4gDo2UBEKsKyNLXrZth7tOvNjUyKg1M+OAY9YPTJM/5LP
         Cw1EYhSL+SD0t23REKAi5k0t54YVg4ALZiNhEHtNYMn0L4xqWw9ZOVfkElV320BoPRND
         5vl+RhLi6m7GRygICrUQDU5PrJIGvmApcOI+b9BWBcnc4p9R3+PkOITE+P+Tr1AmwQm2
         xN8fuN5qI0Z88TphOpbdNIkOjKbUlJWH/Cz3b9MiYUwnSY4BiH02BW8zBKyWSW0kT5pa
         JOhg==
X-Forwarded-Encrypted: i=1; AKwUvBwMHUPqVEzaMdBMyzPWul988za9m+IPG8ECnMg8uuteotmSMFtQTDqKKrxBt0wVtpTVf5TGolW1OPayX0E=@lists.ozlabs.org
X-Gm-Message-State: AFuF++lP3ELit9DoAmc0ROGpbnrYaRjo48dHw05fsWMN8UqFcTZ2jg00
	JdOzVNBbOQoiUIBHY01i3tb7inflHHJ6Bg0JtYU7N0zMuAW5YHrTIG0=
X-Gm-Gg: AYBFou2qe4NfOJWLsFQselz0SEiqVUH34CiT2Nb81LlbOiXlhZIysycwODmfIAD2/Qh
	21M4khS0D88CoZu+9ofhRztUsyed51TUu0DJkzUsr5RGZhoxJJoyJYnqIT64eZl6TxWbfBZ6BnB
	Zeb/U2HyzYNJBPXAQlv6WekhlWCjqqcFaYm4NA73jlUtpltnl5yBvAUUaETleWrJtmIXDs5SNoJ
	obIo/35l99QnRWYUXGGDbSs9Gx0+//2+3bI3JEUKIdLJUmfQBu7Rdjhfhutu6sUKxfY36j1raL+
	J9I1j0tJNXFlSatNeCNVtQAffvPySUnA/pH5Q3OfHr2Q7+Uj5ZpcXVknTKYx9zxVkKUEAGNTsBo
	+72B1VLat164FpX4u9FTt0nL/VHWkCuCkLLpAQx1KFhBb7BfUDx78bPJyiIIvkqdssZmRMq2zUe
	0ZNZnbRE/YiKOfw9bchdfkPL3MhlUu4BQFwtbuwGaC+oSGkbdeTsKxZEk0QZwL/VjnVROhFkZuv
	AKg+hT+1FsrdYgApokh7Cd97N9j13uXZAoB0ngZ1wYSheAyMmNaDsjMpwwg2nQJ6Z2sWdQAl2pU
	h03PTohdiAGcaJ/RiKavdAxSEuBmnA83kaQmkcZkGsGw9w==
X-Received: by 2002:a05:622a:1a96:b0:52f:ab8f:43dd with SMTP id d75a77b69052e-530c871239amr28491771cf.38.1789084478245;
        Thu, 10 Sep 2026 16:54:38 -0700 (PDT)
Received: from localhost.localdomain ([104.39.73.78])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-530ca48912csm6100771cf.13.2026.09.10.16.54.36
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 10 Sep 2026 16:54:37 -0700 (PDT)
From: Myeonghun Pak <mhun512@gmail.com>
To: Zhao Qiang <qiang.zhao@nxp.com>
Cc: Krzysztof Halasa <khc@pm.waw.pl>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Alexandra Diupina <adiupina@astralinux.ru>,
	Christophe Leroy <chleroy@kernel.org>,
	Ijae Kim <ae878000@gmail.com>,
	netdev@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH net v3 3/4] net: wan: hdlc: close active devices before protocol detach
Date: Thu, 10 Sep 2026 19:54:29 -0400
Message-ID: <f5f0519e82a7b8bbf314dc137470f7cf931e320b.1788128904.git.mhun512@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <cover.1788128904.git.mhun512@gmail.com>
References: <cover.1788128904.git.mhun512@gmail.com>
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

Commit ff3516442768 ("WAN: HDLC: Detach protocol before unregistering
device") moved protocol detach ahead of netdev unregister so detach could
still use its state. However, detach_hdlc_protocol() calls
hdlc_setup_dev(), which clears IFF_UP. unregister_netdevice() then sees an
already-down device and skips ndo_stop, leaving an active HDLC device
running while its driver releases resources.

Close the device under RTNL while its protocol is still attached, then
keep the existing detach-before-unregister order. This runs the hardware
stop callback and the protocol close callback before their state is
released.

Audit all current users: c101, n2, pc300too, pci200syn, wanxl,
ixp4xx_hss, fsl_qmc_hdlc and farsync unregister before releasing the
resources used by their close callbacks. The farsync probe unwind can
disable interrupts and free its RX DMA buffer first, but fst_close() does
not use that buffer or require interrupts; the card is also in FST_RESET,
so fst_closeport() does not access the port hardware.

Fixes: ff3516442768 ("WAN: HDLC: Detach protocol before unregistering device")
Cc: stable@vger.kernel.org
Reported-by: Jakub Kicinski <kuba@kernel.org>
Link: https://lore.kernel.org/r/20260806020541.2011936-2-kuba@kernel.org
Co-developed-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
---
 drivers/net/wan/hdlc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/wan/hdlc.c b/drivers/net/wan/hdlc.c
index cbed10b1d862e..a38f90d3006ed 100644
--- a/drivers/net/wan/hdlc.c
+++ b/drivers/net/wan/hdlc.c
@@ -263,6 +263,7 @@ EXPORT_SYMBOL(alloc_hdlcdev);
 void unregister_hdlc_device(struct net_device *dev)
 {
 	rtnl_lock();
+	dev_close(dev);
 	detach_hdlc_protocol(dev);
 	unregister_netdevice(dev);
 	rtnl_unlock();
-- 
2.47.1

