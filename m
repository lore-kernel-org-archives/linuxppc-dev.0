Return-Path: <linuxppc-dev+bounces-28960-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 276D6CA5FF0
	for <linuxppc-dev@archiver.kernel.org>; Tue,  6 Oct 2026 10:30:47 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hzXZm5Ht6z30V0;
	Tue, 06 Oct 2026 21:30:24 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1332"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1791282624;
	cv=none; b=mLMvyRnQHIaWwrcptygeIdKQi/DFzPNz/flXExTmAx5EIC0rALc8ktGa4ryMBrzuohoPaMqg3JZZNH2bFzGelVWN27lMGJ0yEdfjaGUb2C25YTgmYZmQi1WX3rQOzDnt2G2JE/HY18X5jv4x8vn2+73hm6ZxFMVBDbgpplG86SuhiLi+wKOiWWfEzqJ4kHO1ocXzZuHcf9HTXIj19ofA7/hXzpaepfFgn9JaXahgBOgU27gT7iXr2hy03M6SjfV3gGX/oUR2H+mx2yn7nUBPRfmBKRSIHfWTTTWRY94tr9IRzn7Rsp6zT+KdB8SgHGGcbjXmng8SRmsj1n+7wdvyCw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1791282624; c=relaxed/relaxed;
	bh=bol8X0wJHH74pShfR9ELa5dHnrFIGHJN+N1Iz8VFSIU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Gj1GGfyYavQRDuwvcYnzuaxEdKUEGAIlTd6jVp5rJ+04H1G4sPaxo0tCx5I8tiCIRZkeOrw8o4s7UNkR1UTYAfiC/7+KZUWBeRkyaRrYhczvlg87DKs98ds2k2P9LaOTl6jL0qlS/8QQrCl/2vlk+RYSmahJ2v8Y+v05VkQqv9060VGWXgX78xj+3NyjS9VtWy4Uo1NJoAAI2gbmdNiJaL2DshkMGFsjS8NjyVB03IptYAVGo6/1BKKY+05kl6XdhD1IIkdU43QEidHHHsshygeGj1TXAHMrqIg+dqMNM8wlvC+DJX7hftwEQ83V7uuRT6mKrxsIa30zPKj34Jvulg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=bIfUxLsn; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1332; helo=mail-dy1-x1332.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=bIfUxLsn;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1332; helo=mail-dy1-x1332.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-dy1-x1332.google.com (mail-dy1-x1332.google.com [IPv6:2607:f8b0:4864:20::1332])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hzXZm04Wrz2xwd
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 06 Oct 2026 21:30:23 +1100 (AEDT)
Received: by mail-dy1-x1332.google.com with SMTP id 5a478bee46e88-3514b90bb89so626745eec.1
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 06 Oct 2026 03:30:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791282622; x=1791887422; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bol8X0wJHH74pShfR9ELa5dHnrFIGHJN+N1Iz8VFSIU=;
        b=bIfUxLsniQabTqDcNtRC5oxyBwlku3ehUJAyt3Gu91K6ibawJgLQaXu+ZXw8z/KGsn
         Jx0oG/wjWf/T1MVJsuB0USLS7SjW04hQHgqmtHK7O0DMOommVdM43pa92V2NUBTmrf8P
         eV0XGwLZUC6p/HkQ+IvO5M5RANURNWvAp0RWYrlClRT4alO/peol54Zrg/BdM+jmwxAE
         yNSwEP/tZiFeT9vgKxsvtsaVA/fRnZECif1eYBJs47+nj5ZARGHdQfZxFcWrIiJL2KmK
         DdRX3xA8Fw+KKgl6VWLKvsDe/YFt4Q3zb0oHq9nKerchoRvdIR1rsM68ZNE9deNgxrWU
         SpAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791282622; x=1791887422;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=bol8X0wJHH74pShfR9ELa5dHnrFIGHJN+N1Iz8VFSIU=;
        b=S2dZji7KdJtzsdFZludubiNz6pf8rH8njg75A/Mp7hlY9WSMxFAc1BocTA6c72u8pC
         UShkfcajFDjlDiE/nS1CgS+kKc24+KGw4ux2YEYFigSp3WJM29DdhewMnvt38RaYzMvy
         K6JiP/iCL/FuuIpnZjmDMg3zw4jhMnmpkKFat4VxgeXZwpNkdi4XE6CcOlXYn09GDhaz
         YugrO9439eKjdVEzPoCywY+fUg6jATCl55BMssk8acuKnVioX/fioJB0xtNNpjEt1qDT
         YtRni6W5HmvKP1X8dUiHnNIX1n2O8AQaf07E6ZKJD9cB/VHAWaAVs/kaWiTzXSVwWDm4
         YwqQ==
X-Forwarded-Encrypted: i=1; AKwUvBwYiMjEyJi+M5d03tyZyVMGE3NE1Wt8yAxDOWsJJxmcE6nUslLSzjCb7fPdklT0QGfXFUJRmF02ZqDfFI8=@lists.ozlabs.org
X-Gm-Message-State: AFq9FYLQo4bCfrLlUjtQmnWtsUfBhU6OBK648VhrAgKKXV+hm1dmFQb8
	A0GIEQAqSCgKfukpumVavINe+DfzoRc2C1mm+fS0sPM3R/xPFddytTZh
X-Gm-Gg: AYBFou1EP/b1FGYnE/vJOrhYTQTVh8AuwswSUDNKhYrB7dv/h9QCJStvLj0JaVEHFID
	odUd2o0PTM46c6VtNvKIuy7xrrZRc+OpHMnlgl/I58LD9Lhgk4f3UtEft0tmM8t/NlJ5Ap+q4mD
	TmrjRsDVdZ6C5ai17zPOX37/urGKxVLYskkJxGJE8YtQYQ4KEx7gPzdl8Gm6CDSDEx8SHF74hYf
	r0gJcVvlea+uIGWkN98vcr+WsmxFd/StpByDQxTD2eZ2kGU9HU+PS8Ykbj7mueG0/TpixOOoJjS
	SpGEYREQWbBNT0PDDwJk5BEAE7COmAtlbhcYumwepNZoQ9zsZjVGspiRdoFEcCJmy+3oQCnzrHG
	UQN8TuKAtnAMPP3CJ0kGf/3NkDCkjfJmXZ6k2Rv6JLRBqpLC1nj8qQQ0z0DDJKYpdh87kXvLJ2S
	NBCMrggpThhGPJ6qvKKQ6wbSwgt1Osv+rzbIY8r6PWNRXkCJSwg6FMt50+ngigJIYWfBBNZra0P
	sZ75Y7VSgLfrPQC8o0bh+X4Tvi+KIwVWbpR/4TSnG6ZMvuTyOZLSIjbkQ1u
X-Received: by 2002:a05:693c:88c8:10b0:34b:7c9c:9a71 with SMTP id 5a478bee46e88-3512e446222mr7496069eec.1.1791282621782;
        Tue, 06 Oct 2026 03:30:21 -0700 (PDT)
Received: from pve-server.rlab ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-351469fa189sm7443970eec.6.2026.10.06.03.30.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2026 03:30:20 -0700 (PDT)
From: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To: kvm@vger.kernel.org,
	Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	linuxppc-dev@lists.ozlabs.org,
	Michael Ellerman <mpe@ellerman.id.au>,
	Christophe Leroy <chleroy@kernel.org>,
	Anushree Mathur <anushree.mathur@linux.ibm.com>,
	Venkat Rao Bagalkote <venkat88@linux.ibm.com>,
	Harsh Prateek Bora <harshpb@linux.ibm.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	linux-kernel@vger.kernel.org,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Subject: [PATCH v7 7/8] KVM: selftests: Only warn for idle-page checks on powerpc pseries LPAR
Date: Tue,  6 Oct 2026 15:58:41 +0530
Message-Id: <0227000da4e6fe69b278dc971b74b3f65b73ead9.1791280439.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <cover.1791280439.git.ritesh.list@gmail.com>
References: <cover.1791280439.git.ritesh.list@gmail.com>
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
Content-Transfer-Encoding: 8bit

Same nested TLB/access bit issue like x86. PowerPC nested KVM (pSeries
LPAR) can hide accessed/idle, since KVM (L1) doesn't explicitly flush
the TLB for access bit update, so L0 keeps translations cached. That
also means that the L2 accesses do not refault and L1 thinks that the
pages for L2 memory are still idle.

Use kvm_is_ppc_pseries_lpar() check to detect when running nested on
powerpc pseries LPAR and only warn on the idle-page count.

Reported-by: Anushree Mathur <anushree.mathur@linux.ibm.com>
Tested-by: Anushree Mathur <anushree.mathur@linux.ibm.com>
Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 tools/testing/selftests/kvm/Makefile.kvm               |  1 +
 .../testing/selftests/kvm/access_tracking_perf_test.c  | 10 ++++++++++
 2 files changed, 11 insertions(+)

diff --git a/tools/testing/selftests/kvm/Makefile.kvm b/tools/testing/selftests/kvm/Makefile.kvm
index 4b7f6ab0ee54..692bbae44a65 100644
--- a/tools/testing/selftests/kvm/Makefile.kvm
+++ b/tools/testing/selftests/kvm/Makefile.kvm
@@ -257,6 +257,7 @@ TEST_GEN_PROGS_loongarch += set_memory_region_test
 TEST_GEN_PROGS_loongarch += steal_time
 
 TEST_GEN_PROGS_powerpc = $(TEST_GEN_PROGS_COMMON)
+TEST_GEN_PROGS_powerpc += access_tracking_perf_test
 
 SPLIT_TESTS += arch_timer
 SPLIT_TESTS += get-reg-list
diff --git a/tools/testing/selftests/kvm/access_tracking_perf_test.c b/tools/testing/selftests/kvm/access_tracking_perf_test.c
index 4415c94b2866..eb6939065e79 100644
--- a/tools/testing/selftests/kvm/access_tracking_perf_test.c
+++ b/tools/testing/selftests/kvm/access_tracking_perf_test.c
@@ -471,6 +471,16 @@ static int access_tracking_unreliable(void)
 		return 1;
 	}
 #endif
+	/*
+	 * PowerPC: Nested KVM (pSeries LPAR) can hide accessed/idle, since KVM
+	 * doesn't explicitely flush the TLB for access bit update. L0 keeps
+	 * translations cached so the guest won't see the idle bit cleared.
+	 */
+	if (kvm_is_ppc_pseries_lpar()) {
+		puts("Skipping idle page count sanity check, because the test is run nested");
+		return 1;
+	}
+
 	/*
 	 * When NUMA balancing is enabled, guest memory will be unmapped to get
 	 * NUMA faults, dropping the Accessed bits.
-- 
2.39.5


