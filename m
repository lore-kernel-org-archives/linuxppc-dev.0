Return-Path: <linuxppc-dev+bounces-20695-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2C3ECD37AC
	for <linuxppc-dev@archiver.kernel.org>; Mon, 11 May 2026 09:29:10 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gDZDP4Fbbz2xlh;
	Mon, 11 May 2026 19:29:09 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::32b"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1778491749;
	cv=none; b=RAdUXMQCoCC+E717C8mra8Ta5ap5HehfB88cDFM7CmcyyjFmfuHF7dGtt/4noWtsmZEnlzBRzDFZYdB47l/tCBtsNonp8DRlrJeFt2/BafAO9Y6B/e92XtN/IPlFFepOl65Ej+OgCSfOipn9Hzo+cOEbA2PjouhAVlqm/arl75ePNPNKBIuFYdnsnvLx7ZY7RtLUIrE5V5GEX6z5wD3K8cIJWqF/LEMtVtVeR/hlTTjyGHVoiVWBEn16nnkPpDSrLIyX2EWpOL6Kh5K0sCnkE2vlFgqQPonTMejf72yEqczirROwnRP5Ek0vB7eiP6+3FxSf2xBFDbmT9kK+upgVHw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1778491749; c=relaxed/relaxed;
	bh=YNtvrx6JU0RSTB5C/gMvs38ikePYtzcXdrklgWjxoQE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Lsxnd8UuT3XnBYnzeo2j83mDLBzTP6T4Nr6jAbMDTiUIMTzU0E2jxCvWaH6DRZA8RwABAYxxdtjPlJ9guOhiXXI45u7hCvxHlGve8otSicUumbV394Xq5Thm/TwMqiift1Oj80jFv5tVDj7+FtSPsZyL4OzxhCBFl/GAKfyeTTlHulqKxGLg3o6fE/xpvACNZrSYPhi/oFXyKY0ArrXtDvwYqTi97eSVodzONZOBoEAR9xMWkn98qBT4QzdOevcLb8gjatZZ54YniR6hz1CwY9i6L1bRouRdr28YhkRpWezsahpgljHHwZbkR28NDeEoUk7kmA+IiM0x7ivIDH5RrQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; dkim=pass (2048-bit key; unprotected) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=EieNBX1e; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::32b; helo=mail-wm1-x32b.google.com; envelope-from=marco.crivellari@suse.com; receiver=lists.ozlabs.org) smtp.mailfrom=suse.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=EieNBX1e;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=suse.com (client-ip=2a00:1450:4864:20::32b; helo=mail-wm1-x32b.google.com; envelope-from=marco.crivellari@suse.com; receiver=lists.ozlabs.org)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gDZDM1mt0z2xl6
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 May 2026 19:29:06 +1000 (AEST)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-48d102471a4so39906005e9.2
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 May 2026 02:29:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1778491738; x=1779096538; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YNtvrx6JU0RSTB5C/gMvs38ikePYtzcXdrklgWjxoQE=;
        b=EieNBX1eYPQr4930/0mlBGkayPfuy9S/Byz8j1wZ/9TDlREkJtpsSvvq8ih+e+2a8J
         fCO6zheYIkPxRKhaVdAK6tNpkovMfkZzk3+HDY0ybsV5hluGLbjPzcAfns3+uqlgBDOT
         I4QLQMpzpa5933p2dn8xWdkd5F3NdX5V2G7HdfhxY/yUQQu6Q2qYWLm/L+7BtiNab2jM
         Ik8iAJEDfz3qMu6T6ZSFyE1TcoQYe2jDW49eW1nmFe/QPb/r2iJKuNtdnmItHwIcAXVV
         Is55HPS0fZnik+Tl2MmEBRCNLzzo19izP9Ax0b3+iCzSssBjm9UwyEB2+Tz8wD3GsEyb
         g7vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778491738; x=1779096538;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=YNtvrx6JU0RSTB5C/gMvs38ikePYtzcXdrklgWjxoQE=;
        b=YdzzztD392YOSBb/BIxDM35eMbVAHxYy5hOdJ4Ty2RcpbptsLqD8p/xV3UbIGolxcM
         O1bpCbWKo9nddB5cX+A16OtLCyEVmzDaLrAnqbwQj7Wp2SQied4GqIU3miTJjHNWHhtW
         asId8Ezuq2ZuLEReW7D6uphbuUEnEkV/aujeS3PO4Biw0eZjxJR44Oeo2e0eskLzsbc3
         QvoaHtBErZSjV045O3IgxUnVqWZiGdVJ8Q7fto8LnX3/86NEDN5Xd+Jm/jNTC3JX08f3
         2NX1kS23xRpKT6GwxUDHovURvRmJCk+VVULtwc0HJ6uS2jtxVeuzkRdClA1NxViTLkhd
         uvUA==
X-Forwarded-Encrypted: i=1; AFNElJ8J1Unp/QIGiVRqxWK+G00hAVeudQf8K34fR1xKaHKMoivkeilIG6k6g5txZblIGeXSSyReOG/8I818W08=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YycIRecMdiDOZcqJfP+yugo5BV11HL1tHMyicL9Rfrd1ffydi8h
	hOchLZ0WSvOfSWgmxLHlPScNzl9b3u+yCoOLhfn+qa9vXWTK3nnd+PH/loaQ8CdMarU=
X-Gm-Gg: Acq92OFjNe+1OgJJBSF5ZWfOoXkKArJwkS4uqGMpcA9mgCjn+GrTr/cQUdCw7ZGV1HK
	RfdWhlcpUc65CAAXnCyDslG64WUNvbwbZAKUCifaRYAnwEPgTbvinXf2SVWD3Bd33vLtcDDFIuV
	295KcudPIlt1g/3mn8E+VKs3TQYjpVRoQXcclng5qF0Bn8Ghdf8PUC0belVW69BnfUsxdmniljM
	VvfO2hJfCleETHF5DbECvq0IomeOQik1aiX8BHP4IZ96VokdR1/ErhmzlWMzwSFkchcSvPahnmk
	wz4USlxs9pmxYY/wOLo2ck2zspVo5LY7AAlCj2//m+Hm/3eDHDhZebAtPKcS9Js4BPwvv1osX4t
	Ebcxncg9XcvZ66fdZsAZBatZ0LcTIxeDAKGs4ggXtn2YR7jaZhVwJlt4EqIDxyBQ5zgmrUEt2ve
	v4M+9b8tqpQYzfZiuXzdAavFIGZ927RrQgA8YrtLxXuisLIKk=
X-Received: by 2002:a05:600c:8908:b0:48e:6275:27ec with SMTP id 5b1f17b1804b1-48e676b6393mr138132725e9.24.1778491737984;
        Mon, 11 May 2026 02:28:57 -0700 (PDT)
Received: from localhost.localdomain ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e701e89fbsm157606675e9.4.2026.05.11.02.28.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 02:28:57 -0700 (PDT)
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
Subject: [RFC PATCH net-next 1/5] ibmvnic: Move long delayed work on system_dfl_long_wq
Date: Mon, 11 May 2026 11:28:36 +0200
Message-ID: <20260511092846.120141-2-marco.crivellari@suse.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260511092846.120141-1-marco.crivellari@suse.com>
References: <20260511092846.120141-1-marco.crivellari@suse.com>
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


