Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8599A606A31C
	for <linuxppc-dev@archiver.kernel.org>; Tue, 17 Nov 2026 14:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=aTD5jmA/
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jTRq5378Mz2yfS;
	Wed, 18 Nov 2026 01:25:53 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::c34"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794925553;
	cv=none; b=BEFmrC7b+TOZG358IAPAj48zeY8N76Hs8kB9ZmqX+6Y7+bK+zHFKEnEB657wEsBmR+k62recCcGfOElgvV4xYjfayfSh3eplU1tL+IwajzCw7Y13coD7n8iK1yPN8LEj/yLIR8Gu3bIox4cjWctf3aigH7gRC+EgLxvP26bNkAH+FH9iXReajv7pkUj++Wf3ZevBWU7y7m2TV85ir1tT98jKvPXABE3ulZS4ZXTT5LhDAzx1Vy6BW9Xn+/NBj6u5pH9epGgJ75RviPdMPyV5j6fgmywiVzoEXjxnTVkbPYgdyoljnap7Rdi9mxRHUB05C1AInfaeARSfrazpJJuK0A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794925553; c=relaxed/relaxed;
	bh=AK+gHSxZdcAvKZ7cQ385RlBq7MDtihQM1tWGeZNK/Ig=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GI6qQkfpsDGdwR/uDLarTTyWhbFbajP43vITzY/ABdvain+ddEVXZ7DZG8lM65c6muq9xrlpEFzlmUkLxB/y4ww0Tw6gZdG9Hhlh5lyL3/fvHQqx6ZBjSdM/td5rgG7Ry1mJfyvxgemlvG1kOFB20Q69Erc3iKMgxwmdcNoaT/6xSH4ErkhVR1jRXBpImVtsOiA0ChLMR8Vh45J1iPK9TKYHyN06vLrq0x2AhpJeP7AYj178sg4e38tWhh3eldLlONgbSaQsWJj86IBNqhp6c4H17xV0p27cl44QMjG22ZlJlW+XbFAYh9jO+UOy6ObktcmZ8OKHw5kBohF6xCwU3w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=aTD5jmA/; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::c34; helo=mail-oo1-xc34.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=aTD5jmA/;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::c34; helo=mail-oo1-xc34.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-oo1-xc34.google.com (mail-oo1-xc34.google.com [IPv6:2607:f8b0:4864:20::c34])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jTRq43sdpz2xmk
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Nov 2026 01:25:52 +1100 (AEDT)
Received: by mail-oo1-xc34.google.com with SMTP id 006d021491bc7-70b875f6f1fso4819009eaf.2
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Nov 2026 06:25:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794925550; x=1795530350; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=AK+gHSxZdcAvKZ7cQ385RlBq7MDtihQM1tWGeZNK/Ig=;
        b=aTD5jmA/McFQdXo/HbqypTVkz+ZoWWoq88dYeWQzl7w+U5wUImQbDLD8X+gZ256dH8
         UiSeweyW29UdBuBSSW4ssZpf8F5DseMBABlB+2djoMCoE1rOREfvzxNWUNf1cMCP5ljm
         pg0PdSQjf08kTKr3hTFNCOuPkPBa/ySmHEDDVV7OyEjvh571sPsi3q5NzHTV6DG7JNtE
         DhltKerifQtUNAtnbWXkJNZxKQJOPYigENcCJI6pjuQ3sJzdsrxPhcQxa8p/MAkoyM05
         k7SqlmUkxghcRhOcfOh0BMokWcpIxH8PuMEng0bvGQlcS80ep/OjxyxdfljA6fNxhcMI
         Wf7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794925550; x=1795530350;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=AK+gHSxZdcAvKZ7cQ385RlBq7MDtihQM1tWGeZNK/Ig=;
        b=PmSRGhkPYVZeGGhGLjyA9jd/Bk9yurGUgN3DOSrUhNxxFHohoYZR6yGXzEUryf6ghi
         LJSB2UMzgpcyM0shFlzCih+KFSoZUaegkX/hBiwD+p2w3v88IVYRd6h93c0evqAjf4cp
         vxSwc6Smf3PQ0vgaD6ZKaGplZB5PfHnAEp10oxIaxpLQDVGRM/nWkggBZIDXQPEnQdzQ
         bXTdMVwkyZNd+OphpX4DUhxjCLidvJsPkWA651FojBJ96QWTsilxKF13bKrDewQtKlCp
         n53yd2ZEb3P8UTvPxEzSswKUAie+S6+HwC7mQvdnOTVK5gUyrwswZNR7HTo0EEuhVL8E
         dgKA==
X-Gm-Message-State: APuU4Z9dxNerTV2XGtJl7DgVQOYhLfdZJ+z70NrrDJ9G1fb7vS8YIaSz
	dQHtAq+sCb7XaVOHdQbF0DG++dsguTTIJYGohIGAlDER68DQZs5HWi/jI6Y/Rcj2
X-Gm-Gg: AYBFou0us0Uy4DZoNDVUoEkw0eCHbuNzVb5hKbaCIy67Ydz8n1vmQZiK7wHf6DLAaIp
	67MIfr6ZbC4qBn1iP5NW37n24qpWIIJG1p1sJXEK6+Mnn0aVUWQ2FyVzYfzTGgghg8zoHMC4m4j
	5aRDVWjxdiog12jgbdwADaJf4DoDoeopGbVwN1ejd8iFK9yITXzF1yVr9KIalbOR/bC8rtBPSjg
	K7Z9i2YNqueheMLN7mVOTq5Buz6Bt3FJwhX8tC0A9rAGDZbQHpF5OQoK1MWLQyS5kLTxGu1t0Q9
	IlYNkD4l1j+W0k2kpc3L7DUenRGW1PbWk/SVMkllUNIcTiCkNGcTtCxzhakG9Erq1UAQ6vOHqYa
	SXtmmB3Qx5EyfK8ZFrCGotkykNngdQS7unNUWaqVhSpH9B6lvhp7RPUJwjfVhyNwJVM1kkY642I
	a7JwjtGNzfUgRRW7qFI8aCqzVEzhahmlleWyxVzS8kWyPi0J82dXn5jKQzYTR3mwry7Sz2IwCVZ
	aq6IRUOV37g3TiZ+Iu3XNjHfvsFgPLQPOjj6JiLKwX+W71xerwywq2TI1zhs7OSVzvaqTr234ke
	xarY5qPlF0lJIubpC8IdBdr/ySVYgS8HGg==
X-Received: by 2002:a05:6820:2207:b0:716:bf6e:a4a5 with SMTP id 006d021491bc7-71ab52173d6mr7833605eaf.81.1794925549512;
        Tue, 17 Nov 2026 06:25:49 -0800 (PST)
Received: from pve-server.rlab ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-71af0a8a18csm5313709eaf.4.2026.11.17.06.25.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 06:25:48 -0800 (PST)
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
Subject: [PATCHv2 3/4] powerpc/kvm-hv-pmu: Don't allocate gsm/gsb GFP_KERNEL allocations under spinlock
Date: Tue, 17 Nov 2026 19:55:19 +0530
Message-Id: <f52c0f92dacb6d9102a92aa9c6059b3edfb694da.1794924821.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <cover.1794924821.git.ritesh.list@gmail.com>
References: <cover.1794924821.git.ritesh.list@gmail.com>
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


