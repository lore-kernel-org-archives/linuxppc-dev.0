Return-Path: <linuxppc-dev+bounces-25699-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBA14C5AD55
	for <linuxppc-dev@archiver.kernel.org>; Mon, 10 Aug 2026 22:38:07 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hJqQk0sXSz2yqL;
	Tue, 11 Aug 2026 08:38:06 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::545"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1786379699;
	cv=none; b=EEpF5hhDT1+XhqOKd169Ui4VKFVz/q057ZgIeQ85sjcLpLjmZ0k09sJeouBOM/H1sUAy1Do0kZ+n2+JZ7NOf6MXkK3Rsi5UaulcrdovfglQhVHL06HAiSz4NSLskrW9Oe89EocmGYFckOaCdaQVTIGDNPS3OCp/N0jpkSWH/tJdEx7PHr6TsqZ8TMrwO9D/esyB6OT6x9DaO6jn2TMzsQtwPwMG1UovOEwxhDMJPEDkY/MrEC0mC5ebzFvdW85i0mUU9FSqXx0CKWl0om9nD9bCZbT3PCaNokryopJiENO3mswovupOjym+XiZ+d3oNIfQI1zCdgX8Rn43QgQTVf4g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1786379699; c=relaxed/relaxed;
	bh=L84OjIpSeCWFBArdFIo9a7688YTN2+iL7sp2DP0ZJfM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=bicue42ijmTpwr52IUI5eGwvCficayWxnOTrjGiBvvtjjAP9uhDhKeybWieTEpQTN3glvLH6+/qJ5UadqrB+IgKa06mhO0hnrCTCKjwpBLNzmzjsD+P8ICmXQzrCeV8RfpGy6uutOkiirRnig/7etwXOcijSZSbEX7/bEdUZBedg4P3uJYEcHW7utaPSUPH7aOLMOG3cKZmBjgVXEwylZ2KvnrrDYR7+0Ay+fnFy5lkXF4noR2v+u2zfOCS5E5/CTK1XgJeCvDxVIAwtvpTViiSvXkHwG1KFnSZYz/iHYN8Rve71/XXAgGnAyv1CW2JtJEEihDYV2UNEDuocCRFBlQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=Us5SB3aL; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::545; helo=mail-ed1-x545.google.com; envelope-from=3rf15agkkdoofmdgzemtgsaasxq.oayxuzgjbbo-pqhxuefe.alxmne.ads@flex--tarunsahu.bounces.google.com; receiver=lists.ozlabs.org) smtp.mailfrom=flex--tarunsahu.bounces.google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=Us5SB3aL;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=flex--tarunsahu.bounces.google.com (client-ip=2a00:1450:4864:20::545; helo=mail-ed1-x545.google.com; envelope-from=3rf15agkkdoofmdgzemtgsaasxq.oayxuzgjbbo-pqhxuefe.alxmne.ads@flex--tarunsahu.bounces.google.com; receiver=lists.ozlabs.org)
Received: from mail-ed1-x545.google.com (mail-ed1-x545.google.com [IPv6:2a00:1450:4864:20::545])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hJgMj4gxpz300M
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Aug 2026 02:34:57 +1000 (AEST)
Received: by mail-ed1-x545.google.com with SMTP id 4fb4d7f45d1cf-6a1188c8948so2017790a12.0
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Aug 2026 09:34:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786379694; x=1786984494; darn=lists.ozlabs.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=L84OjIpSeCWFBArdFIo9a7688YTN2+iL7sp2DP0ZJfM=;
        b=Us5SB3aLfFgXHlbuHBe1DttjR4TLRMgne4+msUjQUBPs+aEgTJLCmSJzzqHIAXSU9n
         4QJ08dVbmarjqw/svqFypR+BU6LqiyEfTWHR0Oy2pYPYz0ASHnGzXh+bAC801k6hzaft
         R/Dh16a/qA+YkWmRfp3+17eu1eVLnXVwIUeUutQ54kc8V9+AgkPg8/k0akxQGRBMz/6m
         /K9YU/hM+UPqLr+uKjTXu02arsuZNei7ER4kkV7R+fTpboBjYchR8KPUx+lvWZ+1riCN
         i/SWwM66yzB2QfU0YxnDVGINGfimi2UVFkYNVjIMtFlD138BAOVylANEbn4QGgnLpGHB
         rFkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786379694; x=1786984494;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=L84OjIpSeCWFBArdFIo9a7688YTN2+iL7sp2DP0ZJfM=;
        b=X6UOgnNt6d805wgZH+fR0C9JwA0jgKhm25zhzrOIYO3X5JNgG0eRoCbMLthFWFplbL
         e7wq/K19DrpfBU5S5uI0NBgty6k7y9yzf5frUcJ4zdnlkPrMsat2uA7zJvcmOO8LlgdQ
         p0LseWHuxIU3v+OkOjrQ/2Jp/TdSyiI426DJ4KnnSmcQLKpPiNRf+k7VOLFBF0D4StbN
         ZRmlnOsdfFA5jkOLljqnEBlm3C3gRsaxR+VUz7jo7BHy0eAzLF64gnhfMvGTL2aw/+O2
         FK/9j+FnztDQ9grp9IMhd18DWboPsalnDw2iAfam/X9mvP5PPY0MpGC8LH9SkX9OUXM5
         R5WQ==
X-Gm-Message-State: AOJu0YyvDii5rXrGA5J4BikZ5mjpHiyEIpEtt84u7GZ9kTqBhwi2aCgi
	sr0IPZFmf2kEfij/jpuouYE6l/UMMbiWVMwZWQQvY2DWMQN+GN6RkcgszfTxa8VZXz8TsobxeC2
	6GtSPXpeUUK7qfSoZtw==
X-Received: from edgj25-n1.prod.google.com ([2002:a05:6402:a5d9:10b0:6a1:fe68:3f56])
 (user=tarunsahu job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6402:278f:b0:698:af31:5a9b with SMTP id 4fb4d7f45d1cf-6a14f0b8fa8mr21454308a12.9.1786379693823;
 Mon, 10 Aug 2026 09:34:53 -0700 (PDT)
Date: Mon, 10 Aug 2026 16:28:13 +0000
In-Reply-To: <20260810162814.1398016-1-tarunsahu@google.com>
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
Mime-Version: 1.0
References: <20260810162814.1398016-1-tarunsahu@google.com>
X-Mailer: git-send-email 2.55.0.679.g6767b8d81c-goog
Message-ID: <20260810162814.1398016-4-tarunsahu@google.com>
Subject: [PATCH 3/4] EDAC/versalnet: use put_device() on device_register() failure
From: Tarun Sahu <tarunsahu@google.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Geoff Levand <geoff@infradead.org>, 
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, Nicholas Piggin <npiggin@gmail.com>, 
	Michael Ellerman <mpe@ellerman.id.au>, dmatlack@google.com, Borislav Petkov <bp@alien8.de>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>, djeffery@redhat.com, 
	Tony Luck <tony.luck@intel.com>, skhawaja@google.com, 
	Russell King <linux@armlinux.org.uk>, stuart.w.hayes@gmail.com
Cc: linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, driver-core@lists.linux.dev, 
	linux-edac@vger.kernel.org, Tarun Sahu <tarunsahu@google.com>
Content-Type: text/plain; charset="UTF-8"

When device_register() fails, calling kfree(dev) directly bypasses the
device_release() callback (versal_edac_release) and leaks the allocated
driver core structures.

Fix this by calling put_device(dev) when device_register() returns an
error, ensuring proper refcount decrement and release cleanup.

Signed-off-by: Tarun Sahu <tarunsahu@google.com>
---
 drivers/edac/versalnet_edac.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/edac/versalnet_edac.c b/drivers/edac/versalnet_edac.c
index 97ec05d68bbb..2912b3658915 100644
--- a/drivers/edac/versalnet_edac.c
+++ b/drivers/edac/versalnet_edac.c
@@ -829,8 +829,10 @@ static int init_one_mc(struct mc_priv *priv, struct platform_device *pdev, int i
 	dev->release = versal_edac_release;
 
 	rc = device_register(dev);
-	if (rc)
+	if (rc) {
+		put_device(dev);
 		goto err_mc_free;
+	}
 
 	mci->pdev = dev;
 	mc_init(mci, dev);
@@ -852,9 +854,9 @@ static int init_one_mc(struct mc_priv *priv, struct platform_device *pdev, int i
 	device_unregister(mci->pdev);
 err_mc_free:
 	edac_mc_free(mci);
+	return rc;
 err_dev_free:
 	kfree(dev);
-
 	return rc;
 }
 
-- 
2.55.0.679.g6767b8d81c-goog


