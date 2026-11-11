Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70AD2606A31C
	for <linuxppc-dev@archiver.kernel.org>; Wed, 11 Nov 2026 08:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=GI0+G6C1
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jPcYt0NpKz2y2h;
	Wed, 11 Nov 2026 19:46:10 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1334"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794386770;
	cv=none; b=aIQVvFVHYYF3Af9LGgw70Km2ROs0/xDSzMPwEsfBcQ4LG6Lh7Kou703HaaxAwLbT//AIT1AW4wliM3ksbs3VMMP0QeY3U4+w6rpp1lzYnncy5vCAZvexDpabzGrpH4KDzvAH1ZV0XF2riMQbtQwdNOZf7nZTuBmrnG0mqLNP/scrKXJesyRyBuoJLQfQlUd7dZUpGm3XGN12hvXv/MPHW6NpjU+EAPgUURSkGs+xVuwU7LsXDHZtDaYJztwXIRJQsst4h5pUSam7ur9XJ5mnh4CixdMUWd4L7ttc5ZCRmr61/2+qaNZaW4oOkI8VyE6yTp8VOyKd/4WGL4v8nffmVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794386770; c=relaxed/relaxed;
	bh=/9IvjTxyM4LdWMjExg8wu4Ta4lNWPMsKxY0SwENgoys=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gBctBro5aPTbQ/ybnCC12snriblIk5gvfuzfQO2vYGCQDp+4Jq+uPUm6DOS/qSO6bY6BSCm5jJpPAgoc79WVbRF7oPr1Dv+Y2vN5PEJs7qhyxC7E+k+k1Kifq+QI6Kp11sCX77eqmA9p68qzIsje0oxC5zLRm58hDNxtRDTcOBs89eErkvnqGf995saoqPFdfJHS2ClwO4iK4G/aKcCU89ea9utJPUoaBBvcY+bXKrYX8idVi7lgeCbKNXTxunzDsD7+ZC1aHPkg0NbCam5JZKByt9yPHQfkqEZsz2VOXk2Q7VN/OptIjzQWqP8nhse1r+r6o3kFzIRuvinU1ayOfA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=GI0+G6C1; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1334; helo=mail-dy1-x1334.google.com; envelope-from=hj351016@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=GI0+G6C1;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1334; helo=mail-dy1-x1334.google.com; envelope-from=hj351016@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-dy1-x1334.google.com (mail-dy1-x1334.google.com [IPv6:2607:f8b0:4864:20::1334])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jPcYr3k1Zz2y8W
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Nov 2026 19:46:07 +1100 (AEDT)
Received: by mail-dy1-x1334.google.com with SMTP id 5a478bee46e88-36e795af1d4so2472556eec.1
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Nov 2026 00:46:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794386765; x=1794991565; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=/9IvjTxyM4LdWMjExg8wu4Ta4lNWPMsKxY0SwENgoys=;
        b=GI0+G6C1z71MKlK5bNXRoOiPkCy2zqMhmGCuRgAtt89D6jqEWZjEO35ihpJ6/7ukOK
         /fzLH0ATkE4E3k34axbbobcBplV6z40pgKqa/YACvgJf/IHuzGkaVXZ5n2OeV51AJAn9
         LjRPFROW83EHBnqRPCjLA73sTtT09lARv9biaIIN1ORAIQYwKeZobI9XIjsJwkvwIOcz
         wgUqzxMJouErWcjq1KPDHY8QaB2RF7uTfO7DqlsE6/+1pGh3X+sQcPNJhtm2bp1dsNQ/
         lO86lYuaE7sV2iIOx7lFM4GUA92u/YsyvnId22CwkJiuY+QISLhJMostIJtp7k9Woay6
         XuqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794386765; x=1794991565;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/9IvjTxyM4LdWMjExg8wu4Ta4lNWPMsKxY0SwENgoys=;
        b=CDZ5gdPzt6MrjgnM0uk3vZGNJ/eVEr5lAmrMXYLoeHB6MM+pscKfRI40Od3zCD2riN
         eoWu35W+ls+Khzz4U6R1sZBdqtyv+yaFnpmjfrDRLk8Lddcc/znYGDn0HdB8Upetnmmk
         AGMb5urSccLxLKjjzx/x/eOC7XNL3zD4+J7nTGaL1r6TwtMPyq11PsPmZE6mv1IRj6ty
         /JEDpdHkgUxZCYOT41XpmI3kFIciakXIZgLDuRBuTS+Oee1Rh8/xBw/fGVJ1rG6vrwZN
         rTJ6dsaU7fw27U4wFdKwfpwINVUb9xJKv/srZWmLonw4IUccV/0zSQE1Od9GXgkTI56e
         jFJg==
X-Forwarded-Encrypted: i=1; AL+hErE613ohA89uxD+NACOYMALgfcZDGkze2uQCq0KknmVlgvGlWfMcsGx6Ca0J+D2FmVk4ly9nLWguM6tKWCg=@lists.ozlabs.org
X-Gm-Message-State: APuU4Z8qxmp9OFYTudjygd8jfIMsFSPWtxas0UwqVvQY7wTao+hn3s4E
	asYDxLFkg4Ose0bN7fO76JCq0K7Fb/b9OUzyAPveElf5uKZEjucvh1/z
X-Gm-Gg: AYBFou3qoSQoe3L5DNvw1wGOWSVi41a/lzDqQVjkpirJtC5FTz7zL9DvFil0TD8XjQT
	z12rcfmuygqfntT+ksoDgJ921NEpejRDBSbOcACEocfZOE8Ul62z2m9g2LZETZtrgAuRuA01LMZ
	bhBrzTzaTbPJvz21nqelhrG7FqGTTrJwyDmOXJPk/maz+wKRDbLxySkKgPvXuNTfAjEygvQ7y/J
	QT7n/GVtfU5TLrfFJ/m0nwba09ZH5ovNZenNY50zfeNBrm1N7nwvDNTn/JvDTg0sYHQkckrjWUE
	YWE8DkPUwhkvGDUoiL64QUq+bXZc1nFaTUOFpW6xZuwIWlo6Iheaoz5lgN0pxaGhWGMgpvqE6Aq
	4VOus4wH2z9jrceEIQz/TvZXwWWcwOOvnKT7ArRuETiXApaNoq84JbddmvJwNKXlBm221Xs6Vsw
	+pSRZK/75m6NVASahGwkINwWYFYaUNMpdvTfwQEcKGudrof9mcYgiN+WX5tsW4LvOzgFMhQLEFC
	Umlf7/VPkxuXa3qy1d3gDdFuecuwXvpO3ZGu0SbTDzmhobhqWzgZtYwLj1sO6uleOxwBOroscNk
	fkqXV9UoZ8YWj+rwA8hlvyGmuVhoiuX3Fse7hGulxa4h+Xb0
X-Received: by 2002:a05:693c:830b:b0:358:c5c9:2661 with SMTP id 5a478bee46e88-37686755b1amr1894499eec.10.1794386764680;
        Wed, 11 Nov 2026 00:46:04 -0800 (PST)
Received: from hj.. ([163.239.22.29])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3751dae6377sm12811395eec.3.2026.11.11.00.46.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 00:46:04 -0800 (PST)
From: Hyunjung Ko <hj351016@gmail.com>
To: Madhavan Srinivasan <maddy@linux.ibm.com>,
	Vaibhav Jain <vaibhav@linux.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Athira Rajeev <atrajeev@linux.ibm.com>,
	Christophe Leroy <chleroy@kernel.org>,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	Hyunjung Ko <hj351016@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] powerpc/kvm-hv-pmu: don't allocate under lock_l0_stats in kvmppc_init_hostwide
Date: Wed, 11 Nov 2026 17:45:52 +0900
Message-ID: <20261111084553.3039506-1-hj351016@gmail.com>
X-Mailer: git-send-email 2.43.0
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

kvmppc_init_hostwide() builds the hostwide L0-stats guest-state message and
buffer with kvmppc_gsm_new() and kvmppc_gsb_new() while holding
lock_l0_stats, which is taken with spin_lock_irqsave(). Both helpers
allocate with GFP_KERNEL (and kvmppc_gsb_new() does a further GFP_KERNEL
allocation internally), so they can sleep in atomic context, triggering
"BUG: sleeping function called from invalid context" under
CONFIG_DEBUG_ATOMIC_SLEEP.

lock_l0_stats is a spinlock because it also serializes the PMU ->read path
(kvmppc_pmu_event_update()), so it cannot be turned into a mutex. Build the
message and buffer in local variables outside the lock and only take the
lock to publish them, rechecking for a concurrent registration.

Fixes: f0c9c49c5067 ("powerpc/kvm-hv-pmu: Implement GSB message-ops for hostwide counters")
Cc: stable@vger.kernel.org
Signed-off-by: Hyunjung Ko <hj351016@gmail.com>
---
 arch/powerpc/perf/kvm-hv-pmu.c | 70 ++++++++++++++++++++++++++----------------
 1 file changed, 42 insertions(+), 28 deletions(-)

diff --git a/arch/powerpc/perf/kvm-hv-pmu.c b/arch/powerpc/perf/kvm-hv-pmu.c
index aa72b96b5a8c..deba59cbe234 100644
--- a/arch/powerpc/perf/kvm-hv-pmu.c
+++ b/arch/powerpc/perf/kvm-hv-pmu.c
@@ -314,53 +314,67 @@ static struct kvmppc_gs_msg_ops gsb_ops_l0_stats = {
 
 static int kvmppc_init_hostwide(void)
 {
-	int rc = 0;
+	struct kvmppc_gs_msg *gsm;
+	struct kvmppc_gs_buff *gsb;
 	unsigned long flags;
+	int rc;
 
 	spin_lock_irqsave(&lock_l0_stats, flags);
-
 	/* already registered ? */
 	if (gsm_l0_stats) {
-		rc = 0;
-		goto out;
+		spin_unlock_irqrestore(&lock_l0_stats, flags);
+		return 0;
 	}
+	spin_unlock_irqrestore(&lock_l0_stats, flags);
+
+	/*
+	 * kvmppc_gsm_new() and kvmppc_gsb_new() allocate with GFP_KERNEL and
+	 * may sleep, so build the message and buffer outside lock_l0_stats,
+	 * which is a spinlock (it also serializes the PMU ->read path), and
+	 * only take the lock to publish them.
+	 */
 
 	/* setup the Guest state message/buffer to talk to L0 */
-	gsm_l0_stats = kvmppc_gsm_new(&gsb_ops_l0_stats, &l0_stats,
-				      GSM_SEND, GFP_KERNEL);
-	if (!gsm_l0_stats) {
-		rc = -ENOMEM;
-		goto out;
-	}
+	gsm = kvmppc_gsm_new(&gsb_ops_l0_stats, &l0_stats, GSM_SEND, GFP_KERNEL);
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
+	spin_lock_irqsave(&lock_l0_stats, flags);
+	if (gsm_l0_stats) {
+		/* raced with another CPU; use the existing registration */
+		spin_unlock_irqrestore(&lock_l0_stats, flags);
+		rc = 0;
+		goto free_gsb;
 	}
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
2.43.0

