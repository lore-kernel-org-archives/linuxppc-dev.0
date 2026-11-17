Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E011606A330
	for <linuxppc-dev@archiver.kernel.org>; Tue, 17 Nov 2026 04:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hzhSc5Dz
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jTBDD48Stz2xcB;
	Tue, 17 Nov 2026 15:13:16 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1229"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794888796;
	cv=none; b=i5ZaoThzv4pU80wYQ9dAyGP5fKN9VsDMIusoyjXy/lvP0+C+LPZVMT4CBtzI7aEzFfFmbG7vwO7jFl8n5oMuMM1HkmuyU70viN84odzltyetHejqXcXuy4odZiVOlVZxnQFL5lrdC6lcMzfYZWL8S6c6XKvV65Bjl2JRWv/iNbF0GG0M1iDEEC5/CZ6ybJiaCbkoGW8IgzZ+S4kdQHjJvYa3Mo02AU3jBVMrH2Gp7DUXs9RJrSGuP+bnMFXxN4ss7vnJdRR/J9sPzl5INRmnYmuIg2FIm3ByBVDQsCCQbpsLzQD0Hg7kOpfuZHDdAtem7U7ozKatB6L1yeS7QyLVjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794888796; c=relaxed/relaxed;
	bh=AK+gHSxZdcAvKZ7cQ385RlBq7MDtihQM1tWGeZNK/Ig=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=c8T7VT7n6I2TMNET3s/Z03Bj+gxRmNaqpauWp44HNdhLedlfxyGO2JCv6ImaeHr5teEd+umAFzVtEwmAB+ks5KoXwwARFy+VRdAdTTidPuSIQOsYNmskfpn4JVHJdMqT6SbbWp6cMA9cUT1CmXBZlf+lNHkqSS+wjWhJpNMqsohviFi8C5n/5O3JLJPXtWzx5JLYhpsfg4ndKn+6YWaHq+CHO5O5ABD/YuC87OJvtithIYvAw6BO1RsdhN0ZuvL6B+NQbRSdvPJvr48aMO6XBSs+08qPDfcLOzefgRG1bcLutPgWFmsivI2go7aKFssUy595nclIX3jNEi3W6XWBSw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hzhSc5Dz; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1229; helo=mail-dl1-x1229.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hzhSc5Dz;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1229; helo=mail-dl1-x1229.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-dl1-x1229.google.com (mail-dl1-x1229.google.com [IPv6:2607:f8b0:4864:20::1229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jTBDC6nTpz2xNT
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Nov 2026 15:13:15 +1100 (AEDT)
Received: by mail-dl1-x1229.google.com with SMTP id a92af1059eb24-15dd124bbe7so460688c88.1
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Nov 2026 20:13:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794888794; x=1795493594; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=AK+gHSxZdcAvKZ7cQ385RlBq7MDtihQM1tWGeZNK/Ig=;
        b=hzhSc5DzMdb0ueUsZ1am2iu9/vDUqRmNCeTGSZROjyvKP8UCqwxe8C+ORCbZQmIO6a
         M9km0mdGP0WnTBrU0l+bolCUQYLRzt6qq7Kkt037Luw9J4AaB8OxELPygGb+w9TBhI/p
         OPKo2ZDEMWcVA5KXQsNJFlprLNvhT2MvkcL4mGCqSd6TBQ+5csqtqz4LVF7gzjWdX/Pq
         8Fs95TI8K23dG34aFlqOh4bB+FPoDKltQO6RLSGL0JVVzt8el2YZ4zvigKHlF3COZQ6x
         SOHTfa1nlpmKeNfm9YfQ7yV/FywFjbX1YZJvPr6dMigR318Al3VmZLBo9SlLHbllc/7n
         amcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794888794; x=1795493594;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=AK+gHSxZdcAvKZ7cQ385RlBq7MDtihQM1tWGeZNK/Ig=;
        b=Hj7jRB0PB3RL98NnBjtYSQebsuINN/Us/FDhRXnZXgGL8KrkH0Bay+gxG6ECp2guhK
         A8Vc/8qQj1U6I4CmyABU0iyTxhgLcPWEWmFKkRpysEqVnHIEFQmW2fMCBioGXQZYTk2k
         07uxfO+ihWjkhyQeYIudzCVkBZON0U1Su0kZNKyiDb3w69D9Lv5elc6sveth1vz4FQff
         l4F/+tJPgVnuItI9DqJoxEazlsuSSsraAxSAcyhK2PMtrylxNuWux5cOih2B7KQ5ie+D
         85J0eSzIqIo7Ck1kU1Gs6XgTta4msJuoyvVuXCBTdhPS6v+fWnAQaVwOufEdLhG3v8rF
         db/g==
X-Gm-Message-State: APuU4Z8Vw6TgOldgAH56ZAnQVyZLIe1ILOPFlrrv6hHHCWkKiIK0pfMC
	hao1bOUKvx3YrcmXMKE6aFYcYap0Z+hMAVMdVchFA0j5n2QTPmmU4OGyxVggS0EU
X-Gm-Gg: AYBFou177LRvZihNcpor/EvqSBg6IckwmmwwnqZzuDQAK745IG6/s3PX8NeVNmffP18
	Z8D82+mSxUyNEHaErEYuHkns7p32mP326ZdIvlXX+hOe0H/bQwzKwXUCmS4IPK/Wso5yZ+ZW4Pz
	UOWDAXO3h5+g4WqBgSw3l5aZDo/W3RAvXx2yezO9maK/GcdkMRc60Y3snYt4SNu2ikNJZ0QO5Il
	WhartumTpII7RqBySmT7q0Z8KF4h3dJyHDKoz6qMA/uLNSl3AhbnGd7BT8V4BgMDqIqg3O22HJM
	AynpmlMRPKZJV1vBD0GK0ljsq4PGiEM0umFFc3OetzBlnkSa4s2e+WFeR3jSvs7HG1PC5LteW08
	Yj67vVn7MQjw+raI+/i1Wjh6Ao/hEtz1HbSlFCIwwrvR+gy6Vl+65JK9XqFwOAfYFM+vM74d7Py
	FDt/nqbjDmGV+Ito519iEiWF1nu3qYI5Uc+8Z9Zg4qqizIjaexRK0dD64speYpiK2qwcG+6cuFg
	ypG9QwJ5OACHtXU8P6PTka9nTUJ3MnN6sJinJMJ10weGHwKlXM/mhNMZ2Wjn+rbOmkIznaXzstz
	Br5bDv9HpyvBk7wxXei8b4t8KpVZ3DlO0t56xZxQfRwSzEhgYZEHMvo=
X-Received: by 2002:a05:7022:2529:b0:1b4:fa58:9d8 with SMTP id a92af1059eb24-1b5031759b2mr18176689c88.20.1794888793525;
        Mon, 16 Nov 2026 20:13:13 -0800 (PST)
Received: from pve-server.rlab ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b5031b98e5sm40433851c88.14.2026.11.16.20.13.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 20:13:12 -0800 (PST)
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
Subject: [PATCH 2/3] powerpc/kvm-hv-pmu: Don't allocate gsm/gsb GFP_KERNEL allocations under spinlock
Date: Tue, 17 Nov 2026 09:42:52 +0530
Message-Id: <871eecaace022e3d49e5afbbeadf0b26d16f10dd.1794887659.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <cover.1794887659.git.ritesh.list@gmail.com>
References: <cover.1794887659.git.ritesh.list@gmail.com>
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


