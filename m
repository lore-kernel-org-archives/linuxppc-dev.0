Return-Path: <linuxppc-dev+bounces-24467-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F600C44527
	for <linuxppc-dev@archiver.kernel.org>; Mon, 20 Jul 2026 10:09:20 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h3bpR0Rcdz2xm3;
	Mon, 20 Jul 2026 20:09:19 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::32a"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784542158;
	cv=none; b=k9Mzin+KTxJP1CSqo5wfpNWCbrYxSAU9Fjorn0dN0m2xwGYDY00P4dY6RFElccGnBIh2MJPisvIDYmA4NYqNFUfZHP9eHBToUoStLT2AfaCiZej9/ozzSNKTLxW81Sra/JdfohvaYvO0NII2jcuXkFWPCjitVXq0iBtA58mTmzzNsBwtbDS16F1wuoVO4YZL/Wm6n+0fF7FLtcSbKcXhDxDpi5diDrt+czDTik4zwF9Yjso37x5/08gHmNWhEq9IC67SJ4ljQLc8lENu0O4rrAsYDj/4F1JmtzuAviBl7n58Xg/NcEY988kPt8D6U3bz819XdvngVXfla5fCmfMl7g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784542158; c=relaxed/relaxed;
	bh=POoWktMdOXvQialSyT5Wj6jwaYCnpEUeXXbNynanq18=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SaJ1/ODhjsorniqsLB3kLpLebsAatJeb7yzISyNLjlVhyi3ajASkFU6Qgs/z6+lvsOELPRdmvZqxjkApRrp41B7jlsDPTS6OSbIOg6xVbCI37+r2FqGYtAUdfQu/yhK+tsT5nx7sIKqV910h7ejn+QY1cb7vr6YxJbaQgVmxIbwzqYG1Mlz1VYRiVd9VJI6flWUZj2M0IVOuwuoWPkpjcDH6i+v8v44XDlwA4pkxmfiElRq0BHPsDXXFOjDd2HXvz8l3ama5DK3NXCHD5V3ZDZ6pbzYBKNXMh/2NzVFmCN0xwetLLHGeGdx/GfQoi8+c0ZK+eqToaD8awcDR6FM0ug==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; dkim=pass (2048-bit key; unprotected) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=ckb4RpN3; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::32a; helo=mail-wm1-x32a.google.com; envelope-from=marco.crivellari@suse.com; receiver=lists.ozlabs.org) smtp.mailfrom=suse.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=ckb4RpN3;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=suse.com (client-ip=2a00:1450:4864:20::32a; helo=mail-wm1-x32a.google.com; envelope-from=marco.crivellari@suse.com; receiver=lists.ozlabs.org)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h3bpP02xVz2xF8
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Jul 2026 20:09:15 +1000 (AEST)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-49556f97a9dso8207345e9.1
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Jul 2026 03:09:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1784542152; x=1785146952; darn=lists.ozlabs.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=POoWktMdOXvQialSyT5Wj6jwaYCnpEUeXXbNynanq18=;
        b=ckb4RpN3xIr7dFyNgStzHN4UKIYXgQEm33hhkMvJp3+V4iir/v2ALIFjTBRnvfDfbe
         S1shcRCke9zf3ZY4MU0VHCsRA/jWVRb82IdGJUAlDPs0zcaz/HtuQy4NL8kHhULmz+eL
         +ov/kblonJM+aFA7F8u/VO8qaSU0U6O5FuTxdXCEd5edSrNKd/70EXbczQoVKItlVZCC
         pgHN1fCuB+suTT+UcB/8ufp7xsUPLtdWiOrs8pv6vqetyUJKL2/3qyZ/gNAg2HOR4V1M
         PFp8d/wb92sM4bkJ+jdueLDatjmIh/hCf0DwN4i326M73nQ5KQzVAzY38fxnsKcIbVOf
         h2tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784542152; x=1785146952;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=POoWktMdOXvQialSyT5Wj6jwaYCnpEUeXXbNynanq18=;
        b=G8tgWZzHDxy15HOUunOVM8PJrNZ8RBmLjkYGRms2zlBRJlBu+1ZgfPNlBnYbiqx92q
         PCrfQhOA0Ilollm1ZkmKY9sOOq0r0Ol5NKQ4QzqZZFlsobiOS2iz4p8H27iNvU9lYvhT
         LHFzUxR937JufCBXx1xiEZLEQTg7gEy+z2eBN8pKkPeXKncl5AoI2xBSRCQwHPizuGiZ
         RfcGYY8m8UEwY2tp/kbhvCqXyp83k2KcSCsmKO0Dc3K/k0LvI+FW5dJJXRxUHPaiNxdN
         b9k6EraUMB5eGKyUD2QNiY9KvtC95ndRPjAmef+ZtRir55CmWkwSd6K65zwYldZhbtMp
         C/3A==
X-Forwarded-Encrypted: i=1; AHgh+Rqyu38ZBKAj2Gu70HxbgxwDJo4QJKOoXu8Hmrw32+N4JL0n0GvOYHTc42NjRj7QMNxoDrO3VH4UbHrFCdU=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YwqH9FAkG2CtOTIwiH2G4oX+rvkixCCfkdPAbwJNsnVD41PdEpI
	EgqWtVBmpU05+OwK9wsLYxGVoeTUlu+MTMMjRH3DZZTYYwjhnRXVgIYCaC8esE8+g8M=
X-Gm-Gg: AfdE7cmMZcc9gRQIAb0VxxmdH2bSSSMu3Jid08Q+gAMUJpYx2nLQYLC2hnqLLVrvdoc
	ms4P4/yxDID4hklHUWsM225zA6nXiOjbBTc5fNslMdm9fZAWu44AZQR2BDsaqvibBmUAzJLnd9n
	g1andoBKfdL1eb+6SOSzb1DIFHwtEVbWFqFB94ZKYoVJYd+sXamHv4ciBoSFnKB7E1v4Iac6UHa
	p1mYRO4UiFGxfDVgDMjWpNDeR8JFGZ5i+XXN0B2OX0sqt59/x3PLUzb/wcHdT2mGrLQ0T3y0Vc3
	qUWquZPu6AJfSO25Chb7SSDC+Vzk/UPAKVwJzH7UbTnm5ovl3VLSrvSC6/ES4SHIHlWF5SQ7+3S
	CCqFIXWClt8Ei28zl2V9BeUFHqKSJcd5tzuj+989aBrjTBdVQHsZmuGeXNDjkG2aKYzKjtTEUL9
	96OmO+zs/GdnbtkwDuVodPxs/weA==
X-Received: by 2002:a05:600c:3143:b0:493:faf3:3ea5 with SMTP id 5b1f17b1804b1-4954a3d0925mr148347665e9.4.1784542152138;
        Mon, 20 Jul 2026 03:09:12 -0700 (PDT)
Received: from localhost.localdomain ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4954a2a2504sm294792995e9.2.2026.07.20.03.09.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2026 03:09:11 -0700 (PDT)
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
Subject: [PATCH v3 net-next 1/6] ibmvnic: Move long delayed work on system_dfl_long_wq
Date: Mon, 20 Jul 2026 12:08:51 +0200
Message-ID: <20260720100902.155605-2-marco.crivellari@suse.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260720100902.155605-1-marco.crivellari@suse.com>
References: <20260720100902.155605-1-marco.crivellari@suse.com>
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
 drivers/net/ethernet/ibm/ibmvnic.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/ibm/ibmvnic.c b/drivers/net/ethernet/ibm/ibmvnic.c
index 5a510eed335e..d4c284c8ef43 100644
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
@@ -3454,7 +3454,7 @@ static int ibmvnic_reset(struct ibmvnic_adapter *adapter,
 	list_add_tail(&rwi->list, &adapter->rwi_list);
 	netdev_dbg(adapter->netdev, "Scheduling reset (reason %s)\n",
 		   reset_reason_to_string(reason));
-	queue_work(system_long_wq, &adapter->ibmvnic_reset);
+	queue_work(system_dfl_long_wq, &adapter->ibmvnic_reset);
 
 	ret = 0;
 err:
-- 
2.54.0


