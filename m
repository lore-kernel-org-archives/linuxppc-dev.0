Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63B67606A321
	for <linuxppc-dev@archiver.kernel.org>; Mon, 23 Nov 2026 13:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=p4ZIBkY1
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jY6nQ3xm3z2yCP;
	Tue, 24 Nov 2026 00:52:10 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::531"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795441930;
	cv=none; b=XRvIgbpDTHKL7Rg8j02fpjmxy/aIR37c1gQlLeb/v8zHpbPQNCLNpvunKFe9DfSDO545lYAN49Q5WXT8PyAouYvqJV3tOFV40IFoFms7mk6ZfpzVlRvrxiR0mO2l7z/U9wXn69GODbvnINN/C2bPPmDPpmVySW3AeWAxlcA7kWH07WPRnWsAMo4jkzRhhsGAHzFfMWdCVGqh+pnLZqQi5C8Plkj5cQUgskFB9Q7MqwIaqRC5wzB9Uc1JL09KxMm7mcffyTHGqTlr2C4FvlOVUWETeX4WtTsEdJJAu5ayS4ADSl/RGGUBkkLXuxFv5nTHcKKBPxHKJkxaSBGbNCIj/g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795441930; c=relaxed/relaxed;
	bh=/IO4yScrqDKaKjG7SH6JwQjksWNKpCJcuGeohF7E2TU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ji5Jo373AFJgm6ZovM63c6XgDluCEjigBauHxXXDoFHPsutqy8C4dY4Yq3XvJQ0ciBfab6rObyO8Cn4ywg7FwSSnJPUMO2T+6W0sHVtO6WZPi5UyWAAZE3dU6XRcH1ITDpwj3ST256DXNOBBhHY/78POB4Jf8aFZwpSU5/2ZpkTqMizgIPytqaUWJn8wkPzgdrL//1xLFHXOiEXUS6bzpah0+ZH0QDv8EeYMh6BNVg7XqxOHaOBLJajxnpT0s3Im2oBOOoXtch55F4JLIpxxKsYnHVgfqLNaSX433ECmGLAnTB+E804fsg5kBTj65FKbS+i2LL5O1FtovfPmjhudFQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=p4ZIBkY1; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::531; helo=mail-pg1-x531.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=p4ZIBkY1;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::531; helo=mail-pg1-x531.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jY6nP5Lkpz2y7p
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Nov 2026 00:52:09 +1100 (AEDT)
Received: by mail-pg1-x531.google.com with SMTP id 41be03b00d2f7-cddc597d062so1973194a12.3
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Nov 2026 05:52:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795441927; x=1796046727; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=/IO4yScrqDKaKjG7SH6JwQjksWNKpCJcuGeohF7E2TU=;
        b=p4ZIBkY1eUbk5wFWv/MaPnrZjsqAJcnP2+dhT5NjgrFolZa6qPt6EsUnr2ND44Hq/o
         YuAMm77DOnVfKDKQrJ1Geaoece4qoDsgw3lRfV5urwubCrwm9Rha1c+azeubnUmJ/Xns
         I5yvqMoy5CThVjx2ocBJcNtRcp7t85C5alk/gmSB6xI09m3a7L5ZoGHqRbnXqGKTIoYV
         mjjX+WkRmiIcS72EA3WhzbKcslvk86mtpZGU4ZeHz1J2xB9qwzCSP5EXb4aTGmPw93qo
         vm0kz6hCyCAO/zY6/CKGgB+BTbkzxhPmfOp1LJObYjU6R9UrwNqsQlNagTIhKkdJeo2Q
         Q6VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795441927; x=1796046727;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/IO4yScrqDKaKjG7SH6JwQjksWNKpCJcuGeohF7E2TU=;
        b=MvM318RNdJPPm53osPtVotm0eI5kMkASE/+5cIKTbHxP1CR+V/xqRe4H301xF2xT+r
         HhTYhQi6ugluTS7qbnqXJ3dfkjwX05xNAmc/pGXReVC+3QICNDjid5IR8G/osq7xcVvt
         DFLirEhEigIGbVxH4YPEk3fJBYyvkAIiLHjilgI6ojNKQEiOxVdWIAu/3tIeC/2lbsMG
         E37HjVuvc+sR9aIwj6bk6uTtDaHTF84BLAth7Fjv1zg1CCipBngSBTNMLj7cHHToiWPb
         w1M5tr86yyWwavAO2cWQaN+7l8fxd3mhbSOxi7A6N4+0ttWWRdeKjIVLR7dDTdYXcemr
         jyhQ==
X-Gm-Message-State: APuU4Z96mmTqmv1kSwCLny1LPZ1KlbTAQ6gETUK6I0qPL5sgVUTnlXOv
	Eum+cNvJHWKvZwAR7HtP9mJgRAzjW7lQsdK5Bc40kgQ6KnFFXBpIXlO3QZFJuQ==
X-Gm-Gg: AZFdTZe0q/F4wytTWHouAKtKtouHxCkCgf9mFHrlJ6pzukrbKhdpziTwL1HtKLMuz9b
	75DqQRvjtr6urjQCm7BZc1/hlSJV/K2RqfjuS2IbTTD6iXwmnzxS1b3BvhmJYVejatsVF3PkQHh
	QY0CCq5S4PXeD8oG9lfEov1ONNU6c5ZqwRLp01Pdx2ZfzXc7CxLzH4MRL+t0Qyxt2nNR7HKCZao
	2Ok0Pq4z/qsg8L942EbCXRzH3BSI/Kj+dcvkygv+SC+iiLnIEMRjzDJ4Axpj0jBfUETxMaP0AHQ
	K4vV51ecFg2p0RIM5uLioog0IqbKX3e1/f68Euc037HOOzXwfMp4/vD0O3YGjKX+Io32ezgrklB
	qJ4IR8kJUedcJaDQQaUjIt9dJ1Wvwdk/3VuAt0cKCuW8KdlFNcvrtJtIVVvsBWZuB5vz6gLkU4o
	BVvGYSoIcBocz0k4bbrTPjQ1Gq0I0TBF6mJoJ01gXxc2kIg24XVNvwlESvwVAFoNoZ0sP5ZxoKK
	L0c9XyCs/nFFeM8YXfO9329bA6s7AS3yNXOPHRR7T+9gZ83yoaEWz5GvcfoUqqgW4ilrdJCDiB4
	rQTJGrl5fRZDCaAy7WB0QwJJIeNugnDTZA==
X-Received: by 2002:a17:90b:3810:b0:3b0:9a13:c5d5 with SMTP id 98e67ed59e1d1-3b41c8fed56mr11558586a91.16.1795441927261;
        Mon, 23 Nov 2026 05:52:07 -0800 (PST)
Received: from pve-server.rlab ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b405ec698dsm20842512a91.14.2026.11.23.05.52.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 05:52:06 -0800 (PST)
From: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>,
	Venkat Rao Bagalkote <venkat88@linux.ibm.com>,
	linux-kernel@vger.kernel.org,
	chleroy@kernel.org,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	Mukesh Kumar Chaurasiya <mkchauras@gmail.com>,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Subject: [PATCHv3 0/4] powerpc: Misc fixes for debug kernel splats
Date: Mon, 23 Nov 2026 19:21:49 +0530
Message-Id: <cover.1795441238.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.39.5
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
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Enabling debug options like PROVE_LOCKING, DEBUG_PREEMPT and
DEBUG_ATOMIC_SLEEP on powerpc64 showed these warnings.

Main motivation for me to look into this was - many folks internally reported
that after generic entry/exit feature, they aren't able to use lockdep because
of the warning splat it generates during boot, after which lockdep gets
disabled.

Therefore this series is an attempt to fix the warnings which are generated
- when we enable these various debug config options.

v2 -> v3:
=========
1. Instead of calling lockdep_hardirq_exit() 5 times, consolidated that once
   for the entire duration of __replay_soft_interrupts(). - (Christophe)

v1 -> v2:
========
1. Patch-4 fixes a pre-exiting issue pointed out by Sashiko.
2. Patch-2 and patch-3 from previous revision is re-arranged.
3. Patch-2 change smp_processor_id() to raw_smp_processor_id() since preemption
   is already off - (From Shrikanth)


Ritesh Harjani (IBM) (4):
  powerpc/64: Leave lockdep hardirq context around replayed interrupts
  powerpc/watchdog: Disable preemption in arch_touch_nmi_watchdog()
  powerpc/kvm-hv-pmu: Don't allocate gsm/gsb GFP_KERNEL allocations under spinlock
  powerpc/kvm-hv-pmu: Free hostwide stats buffers if perf_pmu_register() fails

 arch/powerpc/kernel/irq_64.c   | 19 +++++++---
 arch/powerpc/kernel/watchdog.c |  8 +++-
 arch/powerpc/perf/kvm-hv-pmu.c | 69 ++++++++++++++++------------------
 3 files changed, 53 insertions(+), 43 deletions(-)

--
2.39.5


