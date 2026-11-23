Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 770BD606A31A
	for <linuxppc-dev@archiver.kernel.org>; Mon, 23 Nov 2026 13:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ytN6JCIv
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jY6ng60chz2yhV;
	Tue, 24 Nov 2026 00:52:23 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::102e"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795441943;
	cv=none; b=DK736qRGoKrs/i4bnUQIBImUmrI3Vv68Y2u7JQiC690gy15YExjrO33Rl2AgmUPPMOrDaArDEhwuxpFyXrGelArGJvMteQ7DkF9yzcSyxxJ2n14hgHBJixwbBplCCyGFQw4f0yQmJ4LuvCQmGeXdxu+cxIKQnUH4icbLeAFL10jqg3JyvgT9GQcYoBitJqYeVesCKZXLisjeEl42oec3a3DRun/+mowAcQOBG8K973eFuYaoD2EWlqDtiM3gTTX9GwszdGjskOMFngKf7DB79pYGTfXUsgV8EeLd1eNDDzQuYGd7IrpeNzj9RXbDuqKjo8ErK0Y6uzYs9mRUlceihw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795441943; c=relaxed/relaxed;
	bh=AK+gHSxZdcAvKZ7cQ385RlBq7MDtihQM1tWGeZNK/Ig=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MzlcugRItYeF/VvDeAm+dFOTaBW5z0bk6BN/JEAeEx5m2fG+k+jeKObT5+POtdRn1FdD4Jp+6XC62xm7/PR5Pz5oz4oYylbvqxBrEQolt+0jMyhE3QP8rc6E2lMyMjArDZ/UpjI+hzGhhoL6XfRYBWf7Qfrq1j+BHn2xs5WH5E09T7VQ0+AnGT3IYuO1pEe6KeBd/mgeWgVKq4oh3vqSNqa587d0w0oOocIKUH5y5XavuV//WWV8tvbLyZFWk5gWriDpG3JCiF7eszKe8jAGL/1nm+nekEBYgZuCv7wDSOQuvsyeqTAVH7v6+rYduITZumMsv/t43Q/m/PqkSt++nQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ytN6JCIv; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::102e; helo=mail-pj1-x102e.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ytN6JCIv;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::102e; helo=mail-pj1-x102e.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jY6ng1ZxJz2ySc
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Nov 2026 00:52:23 +1100 (AEDT)
Received: by mail-pj1-x102e.google.com with SMTP id 98e67ed59e1d1-3b4a93d0814so382897a91.1
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Nov 2026 05:52:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795441941; x=1796046741; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=AK+gHSxZdcAvKZ7cQ385RlBq7MDtihQM1tWGeZNK/Ig=;
        b=ytN6JCIv6FpVtIP9476ON+2Y6Xqh3cfB061FtI984pQEJ9hsU+YVhosMb+SDDpwC9i
         4RgJEHpwC92Yf+hm43UHE60o711bbfVR8gsDoABJc6stdgWSBelp/xrkmEFJy6ivdkeJ
         pH6d0HQo/ZYNiuI3b4ZmVHpTsAmdffiIo+Zty8biFEGrCzCbEvdDDB5Om4Hcdj0mzhqS
         EfYnkMtUoljOK7qMOhsWZ4Uq1GvFMM6ZGjGKFavvuIZABC6hGBIe924Pk+aTXf2/M+o4
         Su5zCtowMsS23Mp/3MoShbi1R4RuQ8LG6/9tcMOTQ17ld6fmYg2kTPE9mkOl0Kff5orW
         OzvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795441941; x=1796046741;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=AK+gHSxZdcAvKZ7cQ385RlBq7MDtihQM1tWGeZNK/Ig=;
        b=eHYHVYknJQoxU13u3xal82Cqff+JN4KwZoWYTG3+/38tPr0zJL4NXRClul7UudbWrC
         JHyw0AftcDP+anObvr7DWNcdsjDvPYJW4IUs6+20R6/B1a+qXpDjx0ML2i6zDRcxf/m/
         lt/BjgO0A8JXLosJHyWK35mybqVCOo/OkADuNc0voKV+4vR5MxZ3Id+YNgTTRoIhFMT3
         eoewMMSrHfKAR8YGPjxSlN4tzNg8GJNNiwmzXuMnTPHJCqd13F/zH9g4CTMlQGEZObVY
         hSAsfeNOsZAp3ZsoWSAoL/2xByE4VOHEy/reGNQM2MXldeXDStYM2BR1+WMpLn1MFa7+
         DQKg==
X-Gm-Message-State: APuU4Z8IuTTgyPvMYgwfDn3t4QAbpo0ZGMK4UqF7tqqtKwpXepnm2lB4
	Kfctu7M2br0wI3LEVblyKdCRVnAUHt0mZHL+GQeZ453HfME9zmv/TYsL8MKK5w==
X-Gm-Gg: AZFdTZf2wHoRHqVPqzEDWLlOelLtb+W4uf9cKJfnhWFA3I0WG9o/3NaW4Am7PGhSLTE
	heysZp9PDhCdFaA3hlzmYO1cSJJDcYNTKGFue8WxI88C+DmOdy2NWHsGbnxJTxICFbTqevPgmys
	Pzl+Ov2DU2BrwzMpowPDmFnU/2+f1DBFTQdo8s9ZLqP7RzcK5DpSXcOsnCIMsojUD74YPK7NjIz
	acH9riby7aHd5yqx/sPWyjaCJmz7K+E5QPoe0IWs9ebT9QiPpluqPRgAFaxhlAL0GhAOrRPn+rQ
	x+bNSwgsVphz59z8pfxO438Ay4GkevG2LFiVHL0PUkPvPu9tatESHahR5VctMZy6tH+WmLJUobC
	2AhiHlH/aSSBEXVM/rsgqmdMHSw0A5RKgPZfJ8VRki3G3PKCjX/fxyotpwDQ4bz7DfSc33eAeAJ
	BOTl9I2TSR6ijW8cSunOxFAzhQSqpHc6+Y66go0BvrB6oVrJJh7yDzR7UhoTJdXXs4plJFTTtIU
	9yRa5+Y0CIW9yczlNMPQbCxhZK0ktl+VbIlIHo1cgleqPFI2dxu5OSF4DlhFGqwrjUZQXphh4Vo
	uJire4D89zaxNFilWX/5ppMOaLqZT2PXAg==
X-Received: by 2002:a17:90b:2fcd:b0:3a4:e934:e85c with SMTP id 98e67ed59e1d1-3b41c964869mr10595210a91.41.1795441940870;
        Mon, 23 Nov 2026 05:52:20 -0800 (PST)
Received: from pve-server.rlab ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b405ec698dsm20842512a91.14.2026.11.23.05.52.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 05:52:20 -0800 (PST)
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
Subject: [PATCHv3 3/4] powerpc/kvm-hv-pmu: Don't allocate gsm/gsb GFP_KERNEL allocations under spinlock
Date: Mon, 23 Nov 2026 19:21:52 +0530
Message-Id: <52381792ff2e208f213cf250d5122a1ab367de20.1795441238.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <cover.1795441238.git.ritesh.list@gmail.com>
References: <cover.1795441238.git.ritesh.list@gmail.com>
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


