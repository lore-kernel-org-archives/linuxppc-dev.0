Return-Path: <linuxppc-dev+bounces-29241-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 392BCCA9ED0
	for <linuxppc-dev@archiver.kernel.org>; Mon, 12 Oct 2026 09:55:14 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j3CWP29Csz2yPR;
	Mon, 12 Oct 2026 20:55:13 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::42b"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1791798913;
	cv=none; b=FCH0MnAWBzNmZmTTPznQJdFRzTELuVLQD8yvUS6oNIi/cPgZjo+xkd+dby3F66qXIYP6+vrKPlb2Toaq2xZ/ZRkCz4DbmZ2zsd6p1h1DglSRWMCDfG3VYYMnynZ0PcCiaOR+TrxSRvzKPTaMnSm9zbCtn8OA6DiaLQKb4ghY91yhjnHf8TjuL/07DOaalhUhiIsv5L/VQmfJxrNuw/I5hx29TvKl9xhuWySwpf4EUuubGIbKvqVVjdAzaqWJI9rQl22N4HDeNRDTz+iMNkAWveLXdRqdRXX5JKOlmcJpa+e1Z9CF1f8Y4OmCK6ZYDpjKV76Jak7TsP8+DaAFIDIEBg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1791798913; c=relaxed/relaxed;
	bh=0DTUEu+tQMr+K01BzO77MDPNxFso/NrhJ3ycIpr+NMA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EOTXZulUg4Xoj3AcfcAUwYO2zEK5W0SA7hDKMarlthr2e67YGhQp14stxyCXtHlCsgCdP3LsZL3nj3CyO+pp5uopjb+9zxy939Vpj5Y9J91EgOPhtsiTwROYp+ESQAQnsWwwnDvD+R9hgn0ALDmz7+yok/4HzioNowdMXW3/AHFgPBZNVyT0ZcMWUAmVcOF+Tc4W/kTieyQkKOeZx5NuwXUK6Yp81NNEBurGuOMOmRaTg1dG2rNl6e8WvquN4mxTDIcHvoCy4zZW1m0JUAskGC+EFG0Qonf/+6Sp5SQ29W7OVyPY8bzHK44zE64yxzUAX0IS3XUt626ghkxs9B6O4A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; dkim=pass (2048-bit key; unprotected) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=UAn4Moxs; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::42b; helo=mail-wr1-x42b.google.com; envelope-from=marco.crivellari@suse.com; receiver=lists.ozlabs.org) smtp.mailfrom=suse.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=UAn4Moxs;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=suse.com (client-ip=2a00:1450:4864:20::42b; helo=mail-wr1-x42b.google.com; envelope-from=marco.crivellari@suse.com; receiver=lists.ozlabs.org)
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j3CWM4mvYz2xwZ
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Oct 2026 20:55:10 +1100 (AEDT)
Received: by mail-wr1-x42b.google.com with SMTP id ffacd0b85a97d-48b02a2359aso1558369f8f.0
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Oct 2026 02:55:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1791798906; x=1792403706; darn=lists.ozlabs.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=0DTUEu+tQMr+K01BzO77MDPNxFso/NrhJ3ycIpr+NMA=;
        b=UAn4MoxsfmkwvH4OCiB4uh4oXc6bp31rYGkeiH4MQufqMUSjj/6HqrsOS08srsnRQu
         5kGvneq6Qx0cjroUUhq8jSIcepZH0UIuojYq5QoUQnm/7eKxKXvgQd5nlnxMDDgqPFfK
         VBDuVZ/18T5jJZEHfBdchBaKveELdZjkAOItz2VwZmWa0Sg3m+v/aPV4giZs/8vZ43PX
         qxAMBpEcDAEZBl37rgFNJsJ7DYS++k+xUkaXARS2jjH5o+iVBN/mOu88Idq+BJNAgccl
         ZGleUdEvidkSoF58fY1rL/iz1jgXVTbxRKwjFI0mx5WhB39GzSvFIg8jJAlUbXzQJmq6
         2dlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791798906; x=1792403706;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0DTUEu+tQMr+K01BzO77MDPNxFso/NrhJ3ycIpr+NMA=;
        b=p6HmJWimONxf70s8FFCq2czlr3ysodZmdjeRAykVn5Vr9NfKWEzsCApRp3SN3s0OyC
         GFywT7Ni8/ZNfokmil/E5ddAxcBnET+5utXYEeHkUnYbRPYluZM0nJgzR2XdUnAmWH7z
         wGWIgGgdNdXjF3HB8f8O/65bzxUq1v9qjr3sZUHdI41VevvU1HmmKyaM5vB4C9LHg5hz
         Jkj5W20Slzb+5h57gTbOaO/AQoKZvUDPCxMqaF0v46g3QJ8ZdivjKN87Ca81PYxyHlcD
         z5Gtmh7u39/jheGMlLS/jWFecr8iVp9ea0bC8EjFYTS0C1qJDY5uonlzcCs1RRd/zBrW
         MMbQ==
X-Forwarded-Encrypted: i=1; AKwUvBx9CTLa1nx3RSsVxpu1+EoiMmVGKj5KBXlhMDQmNvFG/vkISWc00+WtUF4lMTrUVeu2dxbt5QF5iGM+HSw=@lists.ozlabs.org
X-Gm-Message-State: AFq9FYItjcvzBisTp4PEAyuqRUdw3+aC7mIs5r0iAXsKYjo+Zq78uIK/
	4uBxXEMLb498L+7rVSqn5kOZkeN9Fr+zDHfXh78w6XixrNFk2fm35oqamsi1cbf+bXs=
X-Gm-Gg: AYBFou2Y2R133APckdtyBRtTfzino7qXOn88JAg6wCs263UJKbaGWnRtRhfy2c787f3
	zOD99f1bgzAEbDqn23Wpkt4KoZ+zENYEJvgCSI0G0ZX5qwOvbKBGvD63D3RhPfUBVRuyswY1dot
	5vSuqCPAJwxgYvVDSa2NJ7k8OhCzxMtz4nvfNlXFBAddkLuF390Lqo6o5NNlhucD2UqXwUeFao7
	UMBDK/6AHCeOftIdlxSTRBFMOvvSJRl25G9oT+SBTXZFoCFonQo8ZvvotvDBGvxrRMBY8cq8gCw
	snczsK8dVv4F4ua0ql4sxKEnrbZnvWd+buuVx3y5rIBZp/HUtK2ua7XZX/BUqBBJdN7lNilhOZM
	JPCaRmjWaP1EMgnn4hLiUcErtpz2DNwnOIb54LHR7dk0Xpg/PsIpZjM0P10hPQVaMUMYi/D6uhO
	EIC9fqRroS+xxe3BWkWZDcMv6x5397EqSUbpBwbk/ubpvM4WdA7tIfWiELbNUnwS5Q4OsSywLEZ
	s+PeJrMQkP0nsSE5Tto5w==
X-Received: by 2002:a05:6000:298d:20b0:48b:469:b562 with SMTP id ffacd0b85a97d-48dba7b3284mr12398568f8f.2.1791798906038;
        Mon, 12 Oct 2026 02:55:06 -0700 (PDT)
Received: from localhost.localdomain ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48db98c2800sm18539103f8f.26.2026.10.12.02.55.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2026 02:55:05 -0700 (PDT)
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
Subject: [PATCH net-next v4 1/6] ibmvnic: Move long delayed work on system_dfl_long_wq
Date: Mon, 12 Oct 2026 11:54:40 +0200
Message-ID: <20261012095452.135828-2-marco.crivellari@suse.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261012095452.135828-1-marco.crivellari@suse.com>
References: <20261012095452.135828-1-marco.crivellari@suse.com>
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
2.55.0


