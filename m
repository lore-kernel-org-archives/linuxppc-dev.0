Return-Path: <linuxppc-dev+bounces-23633-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 498E0C44500
	for <linuxppc-dev@archiver.kernel.org>; Mon,  6 Jul 2026 13:40:51 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gv58x65SHz3bby;
	Mon, 06 Jul 2026 23:40:49 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::42e"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783345249;
	cv=none; b=Izxari/z8wMWTGp5bBO5M6BqmWOElyDhSoMMoy41pbMvY+m/GKFNMZqkQnu5d225QzHFx7qd0Q6M4txF3/zF28fD2Xho468B2LiRZ2SIxUarklRk+yDB4OoVIGQq7I8eUXwIA1CvWzdBY0SU8kqBZ371/Ft+Fq0au5D9LD/gAt4WFpjcKYKU2jGAu836B/PaIB+4LI0xp0JwyAJIBxrFyEEnB38Q2s1n9xGAylP+JsQz8uxM7ht+/KxRrm6a5iMO4ImxFiu1iH6UFBa3vXcLVqsC0agXEzuMMWS2qEHRGRrDwC3Nbb75ewgLQW0+ijXhZj8V+BdY8B1IMEqEPRd0DA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783345249; c=relaxed/relaxed;
	bh=YNtvrx6JU0RSTB5C/gMvs38ikePYtzcXdrklgWjxoQE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mqdYKhU2az8qO5vlB7TEGKWx1IZ0+avxbCgNWJHwQEDcvA0kr4BfteDEAYPXyyySIv94F5WKJIu5HThFmVD+YY5+5s/2dMrsz4GuZHbK88m9YtRPgY3Wlukz7qXXHEOVgaskRoRmT4o5ACA/RiOY0BSPgkTXgGYVoSKUxo7vpY8f79TKzshNG76hZGIec5rifAB2GHZOBCaSdGcjwTZicnNf75B2tHn9lAbAxQYvsJDLYQznV5GV7krtLt5/ZfY/hMcSwIQqDOqmCimNGYdGHetxaR7z43eCnFbc+Sqzyz5H9/APSnSQnrnPptFKo1oHiaQBVtdLJV29BhNpciRP7g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; dkim=pass (2048-bit key; unprotected) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=VimXP19T; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::42e; helo=mail-wr1-x42e.google.com; envelope-from=marco.crivellari@suse.com; receiver=lists.ozlabs.org) smtp.mailfrom=suse.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=VimXP19T;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=suse.com (client-ip=2a00:1450:4864:20::42e; helo=mail-wr1-x42e.google.com; envelope-from=marco.crivellari@suse.com; receiver=lists.ozlabs.org)
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gv58w1kr2z2yVZ
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 06 Jul 2026 23:40:47 +1000 (AEST)
Received: by mail-wr1-x42e.google.com with SMTP id ffacd0b85a97d-47c2b362ee2so1639323f8f.1
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 06 Jul 2026 06:40:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1783345242; x=1783950042; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YNtvrx6JU0RSTB5C/gMvs38ikePYtzcXdrklgWjxoQE=;
        b=VimXP19TG9hScROuKNTivUQBlmEslrsGaABlXggRVhfjU3AKSOaICnz04/g8kBMrqi
         3YGQ0W5NbG/S2gh855ScyZcSbjqc+OuofcSkrGjoNuZtVda8YbIX+jwsuYW28y8ia9li
         wB0Q2X25Tnok1cQmDeslc3KHk0b0wyCT246oygmYyGgAvmnONDP+04qDB4UAwrW0zlBL
         2N0LsC32Mkzo9Ap18f9DRYQQCDuU4s9axhCRPrxB+QFfbtbfXDpDQc7FiRcWkG/34Q/A
         4UoQ0PBD2F2ABXHJZ2O6wWitt7T89m+oOglDBUkbktHqujzcW2LysG3iawVfaAKMHDGp
         vKtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783345242; x=1783950042;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=YNtvrx6JU0RSTB5C/gMvs38ikePYtzcXdrklgWjxoQE=;
        b=oLgdD54H4u6t0qxgicUC+Fsue0zSbV1lnM9fVq4f9ZcRVIeY2bhnPnYux4cbk1xzO1
         5CHrI11T0LBA68HbeWXbvPsNpFzwhi5Heg8AMkGFKcl5q1+kOooxCQce1URGYJ2mGLI5
         pLk2a++PgZVspYsW19r7jW81uoqk4Do1ngLalGY2CbZpKnxzgugqIQe9ZRSZ13ZTaChV
         9TGSIXMinKsbXiVQb5jtNpy5Wt83SNMeiYs1Y2bkOew0LIHr5Oxg9Fbh82Lv7UE6twEP
         DXaRgbq6zywRFh7skKIvAdDx+noHhM2uJvpn1TCQX11knYhcsZJra/q1TNc+NN+00bkh
         3VBA==
X-Forwarded-Encrypted: i=1; AHgh+RowpDn4oXJoMGUAEBQshXFxL61M/9Cg3YQblpRgSu8CtqapGwFomD9B2sqzeacfIeq5X4Z0757VLxw4k/E=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YyGbHu5ISjukKY2VRrQ41aTlwL1m8z7zMxJV7wufrXhw8HLnj9N
	JcgiIbjvEGuBVpAgrYOgzb90uX/jJzWUym4IdZqpHov3qlIefZy38ENq3uAK3A2ha0w=
X-Gm-Gg: AfdE7cmHm6+GjmRwISTrNc8RMwXGCKnzfPB8h6IWveZCQp2Q3HGG8BmbPo3K+Pjaq+r
	LuFFki2Su0/nUMY439bTCnY0j8r9koXn1RSxzz7dgphJu3SNQayP+KV/rO2PComM2b8Iscdui/V
	/Zxd/vzBbXobNEuorJPJ+Eled8m1Ko45g4qdPTkQqNsuMgKsu6qDhXESmyTDT0ilRay+NQQKZkf
	SRRNUu/pXDZ3AI8yMSFMWNuEHfKESKYj8oJ2ZR14A78F/Rce1jfGN0DParB/mLd6ha2G/S3gu3M
	rfRRsCRss9L+vpYdedXTf07MjabJbKqbgaURhF+3AHiprPe5xuK7mro06haeGb3Y1/akUboG8ap
	yGypWZRdl+F9JsAj61a9hywJMoo9qQKWdQEGHY2NSDuS9h0B+zjBrb5CdogFJ5dw1KWt5Ufu7JX
	8WDKzo5GBnvad6AcQdFZaXP6eLT9jyFJfN+YCnQJS9yfUjqg==
X-Received: by 2002:a5d:4101:0:b0:460:2eee:4e21 with SMTP id ffacd0b85a97d-47de66a4d3amr240493f8f.17.1783345242476;
        Mon, 06 Jul 2026 06:40:42 -0700 (PDT)
Received: from localhost.localdomain ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47aa0f214d2sm24424868f8f.33.2026.07.06.06.40.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 06:40:42 -0700 (PDT)
From: Marco Crivellari <marco.crivellari@suse.com>
To: linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Michal Hocko <mhocko@suse.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Haren Myneni <haren@linux.ibm.com>,
	Rick Lindsley <ricklind@linux.ibm.com>,
	Nick Child <nnac123@linux.ibm.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2 1/5] ibmvnic: Move long delayed work on system_dfl_long_wq
Date: Mon,  6 Jul 2026 15:40:24 +0200
Message-ID: <20260706134033.244295-2-marco.crivellari@suse.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260706134033.244295-1-marco.crivellari@suse.com>
References: <20260706134033.244295-1-marco.crivellari@suse.com>
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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Currently the code enqueue work items using {queue|mod}_delayed_work(),
using system_long_wq. This workqueue should be used when long works are
expected and it is a per-cpu workqueue.

The function(s) end up calling __queue_delayed_work(), which set a global
timer that could fire anywhere, enqueuing the work where the timer fired.

Unbound works could benefit from scheduler task placement, to optimize
performance and power consumption. Long work shouldn't stick to a single
CPU.

Recently, a new unbound workqueue specific for long running work has
been added:

    c116737e972e ("workqueue: Add system_dfl_long_wq for long unbound works")

Since the workqueue work doesn't rely on per-cpu variables, there is no
obvious reason that justify the use of a per-cpu workqueue. So change
system_long_wq with system_dfl_long_wq so that the work may benefit from
scheduler task placement.

Cc: Haren Myneni <haren@linux.ibm.com>
Cc: Rick Lindsley <ricklind@linux.ibm.com>
Cc: Nick Child <nnac123@linux.ibm.com>
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Nicholas Piggin <npiggin@gmail.com>
Cc: Christophe Leroy (CS GROUP) <chleroy@kernel.org>
Cc: linuxppc-dev@lists.ozlabs.org
Signed-off-by: Marco Crivellari <marco.crivellari@suse.com>
---
 drivers/net/ethernet/ibm/ibmvnic.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/ibm/ibmvnic.c b/drivers/net/ethernet/ibm/ibmvnic.c
index 5a510eed335e..a1c01c9820d2 100644
--- a/drivers/net/ethernet/ibm/ibmvnic.c
+++ b/drivers/net/ethernet/ibm/ibmvnic.c
@@ -3229,7 +3229,7 @@ static void __ibmvnic_reset(struct work_struct *work)
 	if (adapter->state == VNIC_PROBING &&
 	    !wait_for_completion_timeout(&adapter->probe_done, timeout)) {
 		dev_err(dev, "Reset thread timed out on probe");
-		queue_delayed_work(system_long_wq,
+		queue_delayed_work(system_dfl_long_wq,
 				   &adapter->ibmvnic_delayed_reset,
 				   IBMVNIC_RESET_DELAY);
 		return;
@@ -3267,7 +3267,7 @@ static void __ibmvnic_reset(struct work_struct *work)
 	spin_lock(&adapter->rwi_lock);
 	if (!list_empty(&adapter->rwi_list)) {
 		if (test_and_set_bit_lock(0, &adapter->resetting)) {
-			queue_delayed_work(system_long_wq,
+			queue_delayed_work(system_dfl_long_wq,
 					   &adapter->ibmvnic_delayed_reset,
 					   IBMVNIC_RESET_DELAY);
 		} else {
-- 
2.54.0


