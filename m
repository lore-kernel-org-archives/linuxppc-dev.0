Return-Path: <linuxppc-dev+bounces-29307-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DBA1CA9EDE
	for <linuxppc-dev@archiver.kernel.org>; Mon, 12 Oct 2026 18:49:18 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j3RMB6g37z3byZ;
	Tue, 13 Oct 2026 05:48:54 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::52a"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1791830934;
	cv=none; b=SFr/bLVrA5ulGu4vToinJP1WalcEdvOaXp14c5CoMSHb8sXGD9jMpHhpE0EAD5J493KUVMXvZbtiR7S43hOCueT5FzEM337MSNMxdH6zwv1SOSRJH9zK9kwlR9JBrOyKFPBQGy+Df/uK7TMpQ4lztoSepNZRwhSJjVszeWC+bBrHHQlY5dGqAei8mr9l3xQDttv8vHqipkEdtSgHIkTCSRIZ+hF0SIrhOfg2p/396GdPOqpSxb3W7VxZu7akaseHa3jyixLQ+J6ElYXReHb3rN3WoBZGeP8aeii4RRUEowPNSmkf7D3vAwnr6b0iGYFy0Xwb2rpTaADMyKlKYX09YQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1791830934; c=relaxed/relaxed;
	bh=xB95fmRKta5UC1qC17l7YA7Hzg7lVmH3sUQeY/dSryY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UrfctJGtRILPqKKZYywI/oit648LPcK+RfpIhNCybYuS2m1EWI2lapo9C4Ue8qvb0+IKTl4WbBTzGgAmM5xJfIMuriowB+iGBwN+enKvD6C9rw59HeDkMqYvTFd0axA/DAT19acJtCrwnZeTmZNWlKx/kKJPv2yD7Nvlunu+Taa6keVYv7cP+VHE3ieaF9Y2dovnPLgOu6sYKXd2Cebp1uSYQHW6HpJTizqRuJVtD0jtMm+JKv1QSrcQCOKkLOdO5UDPATNg+jhQ2TGO0iaiwNdVUE/S7dC0PAex2bydM7UBvJT2BFK8cFAJCt6+cT7yYPjYkgUK+BbZ9BAtH2G68g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Ylz9BgbP; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::52a; helo=mail-ed1-x52a.google.com; envelope-from=linmag7@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Ylz9BgbP;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::52a; helo=mail-ed1-x52a.google.com; envelope-from=linmag7@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j3RM96tT2z3c1B
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Oct 2026 05:48:53 +1100 (AEDT)
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-6ab006eb282so2728192a12.0
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Oct 2026 11:48:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791830930; x=1792435730; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xB95fmRKta5UC1qC17l7YA7Hzg7lVmH3sUQeY/dSryY=;
        b=Ylz9BgbPolHk0DngI/iNWaA6NcwbUsu8ONYsbF65be35r5X0iMIhBvGjrsnv/6JUm9
         x2HQkS6b8h0LJ/EVMng7qpxJUrOt67QLspC77bRXw8+pXX5UWP4bsa9k0Ig645KV67Fo
         RzcLJdGukWPD8KaT2YOCPFs5DbExKpAQbCk7K5/P20/4BPY+nE3LjlxCTyYbTKI5JJzn
         3FI1aFNw8psFYd3lDPH5m8mkApAc9naPh64SQbPIz3bLEErpNu1GYRuLNBlSQPkH09L3
         QGmMn3SvDvLjcC98582CsruhSY6DQZI93RIwdbUQDBbT6CjJGWs4hM4gOPNx9Dyx+5B2
         25iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791830930; x=1792435730;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=xB95fmRKta5UC1qC17l7YA7Hzg7lVmH3sUQeY/dSryY=;
        b=qKHpMukpijlvZcfcZOYUhhLJZyoFxprGXAoVm8qvmdMOvWqFEse0McrEYnDw6pUYTA
         hNXgx6b9k0jPgRKqjiNZSkkFpNrojuSdyCqgL1sCRyY41UvhMvxaGT98ZWRzIolRsAgF
         KKcE81Odk+A4O6BuhEJliQZMsw10pHGiW+VShLH7rKb/Mk+4PwiIJb0BMB6BOHQZqopu
         2kclIcv/rZ++o69J5qT7QKtLL46993TfkznTvAesBPANWwQI+Zzuc4XUC+b9s/YSMkMj
         RvwVw6HRVIcJN0zlosl4StCtRCrvgo0ILibYigpMc3ca0PIr5eaQYqXT1wr3DsSLnKqu
         Cnhw==
X-Forwarded-Encrypted: i=1; AKwUvBzf4n024H7u6YMYfK0WVFn1tQAifRI2PxT/evo0AQtwvu6l6De5U/X85xOFKJMLwZ1w4mPa8zB8czRi11M=@lists.ozlabs.org
X-Gm-Message-State: AFq9FYJ8tmI6a1OZp3qyHQLVSS3lY9HR1FcW2PHCCYlBpSzN42T3G1Cn
	BxYQVVzgEdsOlI/dxVF6qYEnexPxHmeODNrQkKgxLmqMnt/dIKClu4sM
X-Gm-Gg: AYBFou1w5nYKsw0IcmCJxHG/6kWx9+iksgElLawPGgF4CKPjU216UhClmDBWh5aDhd5
	4ic60SWQu/ak9aeW1x5u1vi5OxfTJepL63wxFvSQ6Wen9ej6X4VJoCOnE+DTZEF+ASpnV/lwdDh
	w88PUn1E8RuUNYg4pNY1kxIxjF1dHoS5V5CHL3Et9bwmezTKt/KrNuReo5AnZ9dZh9Og4zPkfEQ
	rV7idm/n9s9UknMa1vGPdqehoO2lZHi8oI33tgDElhIKdGBOi8DtcFy9NJKFeUmEi42rYOKS+yR
	77/NeporaDi66cFNV8Q/EdURnJB8hurgK3J+92cfdGjSwQgHvRzKI/NQRhvjqstTA4pvUwx+IYL
	/OTsPr1wk+L7OgrqW1vxNNsD4Tzo5EQuegYEjhpStajHrlTxEbr+3AH9aEWHT7aP/5JugLkmQm+
	2HxHnG9nNgBGjUHZ6CTLRfhB4GllrfBvvtpWEXiT+XUlXtF8GUHxGnezFJNwcEvTqkWDdzMP7Ae
	14J3y/mMsjaKtFVRSCZb9Ie+wN004twus2ho4p+Sm71hXlA4XY=
X-Received: by 2002:a17:907:72ca:b0:c29:462b:f908 with SMTP id a640c23a62f3a-c31a9fec198mr1293598066b.10.1791830930106;
        Mon, 12 Oct 2026 11:48:50 -0700 (PDT)
Received: from buildhost.darklands.se ([2001:9b1:ff:d701:51eb:176f:63d9:53f8])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c31a9aa5aa7sm488517666b.55.2026.10.12.11.48.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2026 11:48:49 -0700 (PDT)
From: Magnus Lindholm <linmag7@gmail.com>
To: davem@davemloft.net,
	andreas@gaisler.com,
	sparclinux@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	linux-serial@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	krzk@kernel.org,
	oleg@redhat.com,
	linmag7@gmail.com
Subject: [PATCH v3 4/8] sparc64: stop IRQ setup when descriptor allocation fails
Date: Mon, 12 Oct 2026 20:48:05 +0200
Message-ID: <20261012184826.986050-5-linmag7@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261012184826.986050-1-linmag7@gmail.com>
References: <20261012184826.986050-1-linmag7@gmail.com>
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

irq_alloc() returns zero on failure, but build_irq() then configures
IRQ 0, which is reserved for the timer, as a device interrupt.

Halt before publishing the IRQ or changing its descriptor, matching the
existing fatal handler-data allocation path. Returning zero would let
callers continue treating the timer IRQ as a valid device interrupt.

Signed-off-by: Magnus Lindholm <linmag7@gmail.com>
---
 arch/sparc/kernel/irq_64.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/sparc/kernel/irq_64.c b/arch/sparc/kernel/irq_64.c
index 3f55c69d5f3b..4cceeba726ab 100644
--- a/arch/sparc/kernel/irq_64.c
+++ b/arch/sparc/kernel/irq_64.c
@@ -619,6 +619,10 @@ unsigned int build_irq(int inofixup, unsigned long iclr, unsigned long imap)
 	irq = bucket_get_irq(__pa(bucket));
 	if (!irq) {
 		irq = irq_alloc(0, ino);
+		if (!irq) {
+			prom_printf("IRQ: cannot allocate interrupt descriptor.\n");
+			prom_halt();
+		}
 		bucket_set_irq(__pa(bucket), irq);
 		irq_set_chip_and_handler_name(irq, &sun4u_irq,
 					      handle_fasteoi_irq, "IVEC");

