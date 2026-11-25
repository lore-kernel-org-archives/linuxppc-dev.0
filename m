Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D82BB60A5BC3
	for <linuxppc-dev@archiver.kernel.org>; Wed, 25 Nov 2026 11:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Zy+/ev5P
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jZHSS0sPKz2yqs;
	Wed, 25 Nov 2026 22:26:32 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::132b"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795605992;
	cv=none; b=JAMgTlU8bXXsnNNkgmZpuk+u5FR43WPwTmIqjROw9QxDVsGrYD23yirmvzu7uQ9OOAsLUL0HrcoQEPyOMlaMTQRk8XxNPK45vY0cx3J+myGgSWXzNXKv/uW6BoCMnoKAtNvjCFKajFkQ0+5PU2So4uPpbiZ5xzrqAoqQTpV6iSZUA1BKv7MwFw8Ru0HAes0jaTIf099VePfplz249ZneiduJaNJs0Bz0B0trHtTIA03lbgiizjz+v1XBJIF8BQmdK3sVlcOK0CZzoIbZp+aZq41j3L+cwePuKPvfqib0fKBy3i0HctLGjFoVy4hn83L70Hy+LvcR6qyKWm2Bcn9/+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795605992; c=relaxed/relaxed;
	bh=t/NXDxEHWsDao0rnWpCVQG6KZLiH+Zawh7LgTLx2e5I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Yd9hJHs1xWd6kRQJGi0UdX+g20evJD8+3/3WSsmmjuiO1jwdtxhs5PGepAPb6lj+HZVQxFPMrdVZ9SX644xnT0h8j54fh8T8qWse4KpwJ2sULapc/bTMS6x/6gnMl3G1QELwYD7RYcl2o0hBsCwKrdNA55tvH9l3LPgk5Qw97H++spdm1v03OSIptObh7JiOlsa0o391dssfe66pcodLcHqsStnMoZX60fDqmdor8eOrXXACgc4L3NZ67g/LDq414S3CqUcn+djILH7xUxD/2Hzc1zrb3eElNHF21+/DCEz2ruxtXhy/1bg3ZXB0pLlQqPN6cw99vWTI/v29UZMi3Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Zy+/ev5P; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::132b; helo=mail-dy1-x132b.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Zy+/ev5P;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::132b; helo=mail-dy1-x132b.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-dy1-x132b.google.com (mail-dy1-x132b.google.com [IPv6:2607:f8b0:4864:20::132b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jZHSR39NWz2xKQ
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Nov 2026 22:26:31 +1100 (AEDT)
Received: by mail-dy1-x132b.google.com with SMTP id 5a478bee46e88-386d1859e1cso416505eec.0
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Nov 2026 03:26:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795605990; x=1796210790; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=t/NXDxEHWsDao0rnWpCVQG6KZLiH+Zawh7LgTLx2e5I=;
        b=Zy+/ev5PvWgtIpIZpuyWAIpYf3OiehxhnR1DqKCQKk46hTRC38aU9KAqWgeyCF3vwQ
         iYKgNnCxrD30DjewNFFX9dbAqiip+jbiQukbbVNLQxI7QH8S05RhfxR40n/wLAvv3jg4
         3nMrU+rbI7KDdKSVLSy4hiQHNAQ9FfzRJ0wta1vjyJtyU+u8qaiD0RLdKQl//ZInTUdb
         hIM4jJSyuvRIyfWd7i2UXrCHjnqJWa9DTM+8vC7AkxJbumRCqatfJiT8OX2x92HKjxaO
         NHlESjKbOFdNw+3OPquo/OpepLy+il8IISJUVJoDCKAXYJziooll2vwW/53+NUCeKsSV
         eMcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795605990; x=1796210790;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=t/NXDxEHWsDao0rnWpCVQG6KZLiH+Zawh7LgTLx2e5I=;
        b=Y/iT42tYkRs1xY7NUVsMRmUq62IcrhX1/3Krlmllr+Yu41yiNG8w06Sh6LFB6p+LUY
         iJLxvmma8HhCUQUindsDRP95CC3bA4ifjwHKprEwaIrmFx7D5u4BwXyRBz3OXemScqCq
         URBVk0hmEQCplJxOcSo43ZZc4OUlkYTYj/8ISQ3HxOGHQY3NTqtcElhfJc9NCXWDOj3O
         iQ5jNKRmlOFe/z4Ysoq7eA2kWWLDI3hWTWLopw9b5m9GUNUR7/s2iyIxvBTVQV43FeFi
         uUBRLFHzizI5U8B/KwVXfNkY3Pa1Rz3AIt0nktciq8ljBszopjPcMsQwwfsK/9xYdzDm
         G77g==
X-Gm-Message-State: APuU4Z/Q1YW4DMBsIjYpOaV8NqbdHtlQb5/19yhXRLDA2FuNuqkkVkWd
	AC7txn2cUihmEjxWn4qDsYdXsw9cWOhIo8CDI6R4+Un4i4Yy1u50199FzrqB5Q==
X-Gm-Gg: AZFdTZfW38aXZEEAY9Q0MpqJVhubfRl8kGBdjLXmFubPa1ou4UozJNfOjceG0T29nuC
	vj2NA9Rsf52icmTsWk6iHeunqln6sLFqzJuqRnMfnONgEaLhD/QhFBvjBETwgeDMimeRI7Dd7Xm
	UfzHdu/Irhs1QN6c4/FYhBK0tefe8GCDzdalurvV1NYLVxX2CCwz32Fj6Y2CQfiIlqQHyj3qtNY
	AQGa20cCjITpxkJfz9bU3D1lCNLqn9E0RbCHsVYRHL59btKyio5bpuuejHvFnBg9vrBolEUDntl
	LL+zTX/e0jh2O2w7yw3FDPQKJkAwRq193IU60fjsJiBl1o8VkfA6EWJKfrM208u9nLTwJ2+uC05
	yBYPWF98H16QS+yZTIGVTCvZ9wJ4Mb2c/qNRXbgFwvDrst4ZMRoV8qOAhH/BjQOiggJOuiR1jZT
	9vYqF0p8wlavs54pHx4gg6h3Q5/exZZ9qm/fHmOPNfc7eE8u/PGMu9Kf3qORqdZEiU/5Hf5v6HR
	dbLXo8jsPe1i/6n73segI0wm784+7BzicUokbFfN0j1xMibyArSAFdrtdi0ALIHr0XEY4rr+1NL
	bcC//OQmFvx3/1aDLabf0VydUYETeCnaCw==
X-Received: by 2002:a05:693c:414d:20b0:382:cd5e:dc9e with SMTP id 5a478bee46e88-3869a1501f1mr16719896eec.13.1795605989447;
        Wed, 25 Nov 2026 03:26:29 -0800 (PST)
Received: from pve-server.rlab ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-386c7c62a91sm11778380eec.17.2026.11.25.03.26.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 03:26:28 -0800 (PST)
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
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCHv4 3/4] powerpc/kvm-hv-pmu: Don't allocate gsm/gsb GFP_KERNEL allocations under spinlock
Date: Wed, 25 Nov 2026 16:56:05 +0530
Message-Id: <3847b27ac12ae19b2256ff1e025304d93af2d739.1795603946.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <cover.1795603946.git.ritesh.list@gmail.com>
References: <cover.1795603946.git.ritesh.list@gmail.com>
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

kvmppc_init_hostwide() takes lock_l0_stats with spin_lock_irqsave() and
then allocates the guest state message and buffer with GFP_KERNEL. On
a nested API v2 host with DEBUG_ATOMIC_SLEEP this warns at boot:

  BUG: sleeping function called from invalid context at include/linux/sched/mm.h:322
  in_atomic(): 1, irqs_disabled(): 1, non_block: 0, pid: 1, name: swapper/0
  preempt_count: 1, expected: 0
  RCU nest depth: 0, expected: 0
  locks held by swapper/0/1: 1, on CPU#0:
   #0: c000000004ad95b8 (lock_l0_stats){....}-{3:3}, at: kvmppc_register_pmu+0x50/0x270
  CPU: 0 UID: 0 PID: 1 Comm: swapper/0 Not tainted 7.4.0-rc2-00028-ge5a8bf3a3ee9-dirty #124 PREEMPT
  Call Trace:
   dump_stack_lvl+0xe8/0x150 (unreliable)
   __might_resched+0x190/0x30c
   __kmalloc_cache_noprof+0x4dc/0x760
   kvmppc_gsm_new+0x68/0xcc
   kvmppc_register_pmu+0xd4/0x270
   do_one_initcall+0xac/0x48c
   kernel_init_freeable+0x3cc/0x7f0
   kernel_init+0x3c/0x274
   ret_from_kernel_user_thread+0x14/0x1c

The lock is not needed for the allocation of gsm and gsb buffers.
Allocate and fill the message and buffer without the lock and only take
it to publish the two global pointers.

Fixes: f0c9c49c5067 ("powerpc/kvm-hv-pmu: Implement GSB message-ops for hostwide counters")
Cc: stable@vger.kernel.org
Reviewed-by: Mukesh Kumar Chaurasiya (IBM) <mkchauras@gmail.com>
Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 arch/powerpc/perf/kvm-hv-pmu.c | 65 ++++++++++++++++------------------
 1 file changed, 30 insertions(+), 35 deletions(-)

diff --git a/arch/powerpc/perf/kvm-hv-pmu.c b/arch/powerpc/perf/kvm-hv-pmu.c
index aa72b96b5a8c..a58634f656e9 100644
--- a/arch/powerpc/perf/kvm-hv-pmu.c
+++ b/arch/powerpc/perf/kvm-hv-pmu.c
@@ -314,53 +314,48 @@ static struct kvmppc_gs_msg_ops gsb_ops_l0_stats = {
 
 static int kvmppc_init_hostwide(void)
 {
-	int rc = 0;
+	struct kvmppc_gs_msg *gsm;
+	struct kvmppc_gs_buff *gsb;
 	unsigned long flags;
+	int rc;
 
-	spin_lock_irqsave(&lock_l0_stats, flags);
-
-	/* already registered ? */
-	if (gsm_l0_stats) {
-		rc = 0;
-		goto out;
-	}
-
-	/* setup the Guest state message/buffer to talk to L0 */
-	gsm_l0_stats = kvmppc_gsm_new(&gsb_ops_l0_stats, &l0_stats,
-				      GSM_SEND, GFP_KERNEL);
-	if (!gsm_l0_stats) {
-		rc = -ENOMEM;
-		goto out;
-	}
+	/* allocate the Guest state message/buffer to talk to L0 */
+	gsm = kvmppc_gsm_new(&gsb_ops_l0_stats, &l0_stats, GSM_SEND,
+			     GFP_KERNEL);
+	if (!gsm)
+		return -ENOMEM;
 
 	/* Populate the Idents */
-	kvmppc_gsm_include(gsm_l0_stats, KVMPPC_GSID_L0_GUEST_HEAP);
-	kvmppc_gsm_include(gsm_l0_stats, KVMPPC_GSID_L0_GUEST_HEAP_MAX);
-	kvmppc_gsm_include(gsm_l0_stats, KVMPPC_GSID_L0_GUEST_PGTABLE_SIZE);
-	kvmppc_gsm_include(gsm_l0_stats, KVMPPC_GSID_L0_GUEST_PGTABLE_SIZE_MAX);
-	kvmppc_gsm_include(gsm_l0_stats, KVMPPC_GSID_L0_GUEST_PGTABLE_RECLAIM);
+	kvmppc_gsm_include(gsm, KVMPPC_GSID_L0_GUEST_HEAP);
+	kvmppc_gsm_include(gsm, KVMPPC_GSID_L0_GUEST_HEAP_MAX);
+	kvmppc_gsm_include(gsm, KVMPPC_GSID_L0_GUEST_PGTABLE_SIZE);
+	kvmppc_gsm_include(gsm, KVMPPC_GSID_L0_GUEST_PGTABLE_SIZE_MAX);
+	kvmppc_gsm_include(gsm, KVMPPC_GSID_L0_GUEST_PGTABLE_RECLAIM);
 
 	/* allocate GSB. Guest/Vcpu Id is ignored */
-	gsb_l0_stats = kvmppc_gsb_new(kvmppc_gsm_size(gsm_l0_stats), 0, 0,
-				      GFP_KERNEL);
-	if (!gsb_l0_stats) {
+	gsb = kvmppc_gsb_new(kvmppc_gsm_size(gsm), 0, 0, GFP_KERNEL);
+	if (!gsb) {
 		rc = -ENOMEM;
-		goto out;
+		goto free_gsm;
 	}
 
 	/* ask the ops to fill in the info */
-	rc = kvmppc_gsm_fill_info(gsm_l0_stats, gsb_l0_stats);
+	rc = kvmppc_gsm_fill_info(gsm, gsb);
+	if (rc)
+		goto free_gsb;
 
-out:
-	if (rc) {
-		if (gsm_l0_stats)
-			kvmppc_gsm_free(gsm_l0_stats);
-		if (gsb_l0_stats)
-			kvmppc_gsb_free(gsb_l0_stats);
-		gsm_l0_stats = NULL;
-		gsb_l0_stats = NULL;
-	}
+	/* setup the Guest state message/buffer to talk to L0 */
+	spin_lock_irqsave(&lock_l0_stats, flags);
+	gsm_l0_stats = gsm;
+	gsb_l0_stats = gsb;
 	spin_unlock_irqrestore(&lock_l0_stats, flags);
+
+	return 0;
+
+free_gsb:
+	kvmppc_gsb_free(gsb);
+free_gsm:
+	kvmppc_gsm_free(gsm);
 	return rc;
 }
 
-- 
2.39.5


