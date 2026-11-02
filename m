Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8CE560A5BC0
	for <linuxppc-dev@archiver.kernel.org>; Mon,  2 Nov 2026 10:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=Pn78X4My
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jJ7vc4Rkcz2yTQ;
	Mon, 02 Nov 2026 21:57:32 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::430"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793617052;
	cv=none; b=RTG200RjWVcDRYoojZnWSJDYDHlwsCDkU3zc/sKuaBS6vZSP5dNVoP5QR3DkFBC2wPmvzLf9zVO6L9q3ZBldcu8xWOGfiowoVymQOcC2VCPlSmO028FLAT8NzWMDNbUQmstE12V/MDMgi0S0d2vcrQ47KnsKsJM3iUiL7plvwQ8qNz2bl1r6fHT3vS6ee1kWdrfaje/+m0hQsQb+w3gLcOwCljOa13THnMhJYTZe0DOTlRNwC7r0+Up4e2uO4Pa1nGVun03lWxefPxcT1y+zcB3V1ZB9eKoSplylQ7lKf1nF4HafHlw7S4uyvDyBfzXQHdENtieM4rIo/HIIY8CcJg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793617052; c=relaxed/relaxed;
	bh=FVUrfemyNnwloOlUvhimVc5x8NpDNzjKpz5CjJJeqrQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UhV3HLEsnvWp4Fo82MSPJgQWXAlMQldm99sDVJTuDJ4it42aV8kbKDZuSO7PdpwSL4Dm9UBfBFUCfkyhBkfl3p+L38JSMN/jTwSV91UiA2DWg68jss5tHeLT1UQgkjBum9NJ3gZHqyj26ntOEMt7btejsV+pf2/GdSOvQcsmiOamelC6tRxgz7N14864gtn4Gc/n8isv4cdJU0AiGLJmwRYPMBqRPir+I6T1b91ZqKCPXEvuq1sS91cVWZcCXhYdeVHzm78/Q/BLWHvHz4BGNJn5ZwQiVggqa9ioMiyzUB1f1BB4gRvrY+XBIUTjY8PlbRzjEYp4encFJP11VQk9dg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; dkim=pass (2048-bit key; unprotected) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=Pn78X4My; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::430; helo=mail-wr1-x430.google.com; envelope-from=marco.crivellari@suse.com; receiver=lists.ozlabs.org) smtp.mailfrom=suse.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=Pn78X4My;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=suse.com (client-ip=2a00:1450:4864:20::430; helo=mail-wr1-x430.google.com; envelope-from=marco.crivellari@suse.com; receiver=lists.ozlabs.org)
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jJ7vZ2LWjz2yST
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 02 Nov 2026 21:57:29 +1100 (AEDT)
Received: by mail-wr1-x430.google.com with SMTP id ffacd0b85a97d-48b060ec084so1619803f8f.0
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 02 Nov 2026 02:57:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1793617041; x=1794221841; darn=lists.ozlabs.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=FVUrfemyNnwloOlUvhimVc5x8NpDNzjKpz5CjJJeqrQ=;
        b=Pn78X4My407D8567mLQQPACbbbUoEKWQqi2Azz3yUJEf5n5u3PSbfh2iOfM9gw+b9S
         EOJAXhnQwfxIqz1jXemX9ZHNwqbqI0dc/Flm7h7/eCPwF4Zu/ybGhBGlwEP2uufnLiRq
         q5kknet8CCmOc0nZf8lRToHXhrnS0KHAXMo7NiR7VeWVmUNIoVVswruv381CY61Zm851
         +CYQiIaU6yN+qYeuM7oJY42Qn4ZK+VTyNpeQJv4NlnVqB6f7ziuSHHsnBHdxhcKDC+iX
         md+ogHRRSTkEXFHYj6oPwZrvOYcLcWQm8QZeXa2zobmQ/EMM0gbKbZ2OWqSauzKegl2a
         hi9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793617041; x=1794221841;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FVUrfemyNnwloOlUvhimVc5x8NpDNzjKpz5CjJJeqrQ=;
        b=ZcLaE2wAyLV+B6jZjXDR7g/bDOG6s2wDQRRIwRn6zVWqMDpahdf7Hg+utGt7owoFj2
         5GANrQOS+dkQwyBKOsJwMK/c4romiYt5GwC+O5Ou38Ydoum+YrZ4WUGviz3PWrv2vycX
         Sru4gQHo/j8jHY7E43dgAHC2HBR25ng6oywjR+Sx34juAvxLEBua0ZSd/EvVG6gOaje3
         wkWp2NUz3MjJHGhlIgq7VBHSwMkaz/i4eEJARb4xyPW00WzxLxnyTWWYWEr2MfHb6kME
         saypDFyxCFwH4P2EsAYc/29ihHCG5CpfMpcd6L77+MqYFFC4ozML1iKiCbL5EldSa5jO
         sIUg==
X-Forwarded-Encrypted: i=1; AKwUvBw/f4tgOaCdHvSj5z7jmcvHgtNhzN3Wxfdr3UEwJO/NF6Tb2Q+AaxcF7VILLn+a5CGGK7E0BHCo3TBksOg=@lists.ozlabs.org
X-Gm-Message-State: AFq9FYLUYBADWhSKIOdq3H3W5gOmVd7TXo80/Fj8MVelU9BPVqXL8yME
	qBbH5N+90CZ57WRyQ8qumOTPnF176il6UBMMKbo8aJQx3N/38XrKTIYgvxIbbirLT/o=
X-Gm-Gg: AYBFou3WW7/G31+rQQK/I8LrZ2lqMuG5+S30HiFDG9kk+cQYuMfjxASAWOHavWMepdv
	JCkbgWeswWswE5iA1nGL1WYHiK0C/ml76MH5vMUN0lrPl5fk4A6NNqxq6BlxvC5Pij76W5Yl1lI
	qVA1+3qxDDt54x+AsysCt1KHDWFLeKqzkKgdUosTGzGsW6TSeOGK6bgLz9bf1Dceo4xC6+sEiz8
	wGlJM66UaafERmIG6R0+KYC2k16/lZwgVl3deEdDCJG4Saztkv/ddL10kYof16b0n7l1VaovSCr
	cPuzZipbUiJLaK7HiSaqPf4oeK+Uu/CQua/uwbXJPnGtLA80yGyjNc+GFccLPjoMZrxt/56tjTE
	MZjFMm0yxoCocDbbw5pmPAvrDFrErFvCXlyhTKTCDImSb9YyIIjXAEjLvnnr3JRiJdI3tTOq1jN
	N1iE5d5atysI/rxncMWSHDagasS2c6aZdNPuk1ndoVgM7C0lgh7EHMH+kpmQOT+w7DdtFAKOF1t
	1sNjS9rZQL7AvdZ/vlBpZ9mMmWXdHaDBL3V9LL9AkZJabOuw5DZgKsEWbi9EBiz3WjEhuf4J0gn
	xULCaPzHAzh2uhXoT0zqXZvWwpcSS46v7iiImOuZ7CYN+dLVPQck
X-Received: by 2002:a05:600c:628d:b0:4a2:397:73e9 with SMTP id 5b1f17b1804b1-4ac17d1995amr224936715e9.18.1793617041562;
        Mon, 02 Nov 2026 02:57:21 -0800 (PST)
Received: from localhost.localdomain ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4abeb77af8csm363171175e9.1.2026.11.02.02.57.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 02:57:21 -0800 (PST)
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
	linuxppc-dev@lists.ozlabs.org,
	Mingming Cao <mmc@linux.ibm.com>
Subject: [PATCH net-next v5 1/6] ibmvnic: Change system_long_wq with system_dfl_long_wq
Date: Mon,  2 Nov 2026 11:56:51 +0100
Message-ID: <20261102105703.111844-2-marco.crivellari@suse.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261102105703.111844-1-marco.crivellari@suse.com>
References: <20261102105703.111844-1-marco.crivellari@suse.com>
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
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Currently the code enqueues the reset work items on system_long_wq: the
ibmvnic_delayed_reset delayed work using queue_delayed_work(), and the
ibmvnic_reset work using queue_work(). This workqueue should be used when
long works are expected and it is a per-cpu workqueue.

queue_delayed_work() ends up calling __queue_delayed_work(), which, since
IBMVNIC_RESET_DELAY is non-zero, sets a global timer that could fire
anywhere, enqueuing the work where the timer fired. queue_work(), instead,
enqueues the work on the local CPU, i.e. the CPU that requested the reset.

Unbound works could benefit from scheduler task placement, to optimize
performance and power consumption. Long work shouldn't stick to a single
CPU.

Recently, a new unbound workqueue specific for long running work has
been added:

    c116737e972e ("workqueue: Add system_dfl_long_wq for long unbound works")

Since the reset work doesn't rely on per-cpu variables, there is no
obvious reason that justify the use of a per-cpu workqueue. So change
system_long_wq with system_dfl_long_wq so that the work may benefit from
scheduler task placement.

Both work items run the same handler, __ibmvnic_reset(), and every reset
request is scheduled through the queue_work() call in ibmvnic_reset().
So convert this call site too, so that all the reset work runs on an
unbound workqueue instead of the CPU that submitted the request.

Cc: Haren Myneni <haren@linux.ibm.com>
Cc: Rick Lindsley <ricklind@linux.ibm.com>
Cc: Nick Child <nnac123@linux.ibm.com>
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Nicholas Piggin <npiggin@gmail.com>
Cc: Christophe Leroy (CS GROUP) <chleroy@kernel.org>
Cc: linuxppc-dev@lists.ozlabs.org
Signed-off-by: Marco Crivellari <marco.crivellari@suse.com>
Acked-by: Mingming Cao <mmc@linux.ibm.com>
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
2.56.0


