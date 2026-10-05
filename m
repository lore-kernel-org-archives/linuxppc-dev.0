Return-Path: <linuxppc-dev+bounces-28901-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36855CA5FE2
	for <linuxppc-dev@archiver.kernel.org>; Mon,  5 Oct 2026 03:48:14 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hylj24KgXz30TY;
	Mon, 05 Oct 2026 14:48:06 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:38::28"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1791172086;
	cv=none; b=SHTZ/XkwuwhrKm0O1p232iRtdORyN9s5VdvDje1CgsjmVEf0Qngmb708/h27NAwskLNo4+QCx8VWW6fV41QxJoVVi3rmIeWCYFQX8g3bQ1v1mbHs1GxUPjZ6mYxuBpJhFyWLZDNo7aJVljPRKqq982Qwwyy3ZBmFJZY/sODXxGNmQSVxQ/4JotX/yiK0yI4Ooxyrt7HruGzK3Wkep8ModTV+1KxdRGF+5Qnj0j6eEHt3z1pibNnUA6TsrgdiBrd46oEIBLmqDokF30dTMWfUosB7UG+pZPyiVpDnctjS4sW5xnlZT9dvKMbNsa+e2DY2LsEQDiLF7W4Bgwq/xqYrUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1791172086; c=relaxed/relaxed;
	bh=HLwPHwcyBpbEdHoUdZEu0832fJUKg87xyYGklLfVx8A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RT9JdEIygfrClz0z/guEYT4665A/l+wG6TidFkCkX/vWVOECKBnp6zzCpvVTJNY64QiiANRHgVTyQ/W5R/hGAkpaPHjWpRB3K7h7IlTokzzvSrh5lFC1ZKJkVb/qmgaC1Av/ugY4xvlaqPMGfYQDMYSb0zjq7eC4EbZoXANAIB2hFpiicxGYnb84qx3ChvKMBbdqI8kG23olDSXd6VXZLpIo2NZPmLIWVRySC5YqleUFVTtovItFDgFMXCLtPdMHafce6myUmWltVbutD6zg96cN3kK0iYJoIZZ8aK2GCnVD7FzFgWCVPWtc09yO9hwiD9VU8NUSMK6nDDg6M1/fcg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=SRkx1bzv; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:38::28; helo=mail-dl2-x28.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=SRkx1bzv;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:38::28; helo=mail-dl2-x28.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-dl2-x28.google.com (mail-dl2-x28.google.com [IPv6:2607:f8b0:4864:38::28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hylj11sl0z2yjw
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 05 Oct 2026 14:48:05 +1100 (AEDT)
Received: by mail-dl2-x28.google.com with SMTP id a92af1059eb24-14373bcc010so1027332c88.1
        for <linuxppc-dev@lists.ozlabs.org>; Sun, 04 Oct 2026 20:48:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791172083; x=1791776883; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HLwPHwcyBpbEdHoUdZEu0832fJUKg87xyYGklLfVx8A=;
        b=SRkx1bzvQxH7RvZFR40NGa5x3o9J8X36+PfNv1PNOpghQ/MIMXw8uCKCzAdQrJ88T4
         5Z5yYdjOfGHbcDliizHbBX4k6cB1qApfbiurpJTJptz0qfEtmh/BRWhc7bz/X7/86Iq7
         yHETYzO4Ko5rh9S/OklQSNtA+CM8/caJLe2Kys3nJKJ0/25c0l1DVO2d15x8V3+5noo9
         sDPAF2B9KigC8kmb7PQm7/XYaCYHrmHhb0nku1Oe6YdSRcJm7oA0gdwSX3PLGjn4Ypoi
         oRhJEKgpRuJq+ysLvSTv4yqIJBBFW3eKT0BjJCYZUpXUHsbAeO4hmIwg7Bd1o8p051bz
         FGkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791172083; x=1791776883;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=HLwPHwcyBpbEdHoUdZEu0832fJUKg87xyYGklLfVx8A=;
        b=uroGnA8e0zmP94eWtlctJfUBk4YO8YhvLx7VGwhqnuQTLuvfy7W2zr9QNe23W1DVwS
         2zkKHrDbPtMIv/aVZqdYWle1VCpb3D1UvYos8EshBzOkSMzqGy+uP3LTuMTC85ar18ko
         7Dst/H+CCmr+f/yooBoSIziEpdmMHNFfNDHhjf4q6Z0fJOCNIs6S7vn1sKDchtzQus4Z
         SMdcZj6P6Y6Vis1ku8kM4iy94tCAK0iHvHh/t3of3jaAb0Q6YBR2dSAVAV55dpNVBU1P
         uZp6rae0/866TKLyn25xkoKinZwZN6E5gTYa56krvaia4Jx0P8eRt9Mxg5wlfnEXACtU
         aR0w==
X-Forwarded-Encrypted: i=1; AKwUvBy+QNGZyo3y59nQ/xJBbC5O8WQx36N2wuO7Qy6u0HxVOMqwf1ulYasTb/GOmWH8C1fUKkXJ6+78B/F4PII=@lists.ozlabs.org
X-Gm-Message-State: AFuF++mfYofHSpI30jm6/vkosdwldratJDbTs5SCueIR8eTGuhZgEQSU
	edK5GvYAF3K/XKg3ufV3c0xX/36wD+DVsKUpV298/fwSPyafVkECR7Q1
X-Gm-Gg: AYBFou2gB4+kPd32xnfSwGcwvTSP/CF5UxFodOL+/dmgvGLLa5olVs2Qp0xKe3Rwzq3
	ADD+4O4N3N/j4O3zKj8WPNI5Y7ZEm8unb3DvLuEFYNiIa/o9v7ECu6iORohagPl7ewy1Z20kF2a
	L4HkyS+PIgW7sCPov+3MQ+0QxrQnfQ6tMB9Uhco9btLoQCYxryjkC5NMAlKZNGqG3SvxFyqZKEC
	fa4N7jVNSDlV8RFhNx3mqskLgCQGH5FTv59EEeRNmtBlqMPX2+oA/TqaRRVLP735qS6WIDEw5Mz
	bMxg5ePg2vtS39uhCjeF+zKM6pyu1pOXRdXe8v4xXFeXnCPLI7fYnU9vt0KZa2xMk/jmdkvHsed
	Iz5Ry6f+hK/e09k1zwjE7xdpu2wlIXMoO5lAvRqYES9rvTvvdys1e6KwgdN30mVBwCyA+uPOS/O
	4DTEAEuug1GDgxAXauSXuZNf/FSvlMC4XPueZr7Jfw0lo5ecavpGTC4jVDgqw8UfK1d2Azqq2DJ
	z3TBGzY5Z8Jn3ptmdLBqBshN3Sb2OY8/YUjM+eszB4Gqbb3ruO7pVyJ2q/87g==
X-Received: by 2002:a05:701b:2803:b0:157:cbf6:8a1c with SMTP id a92af1059eb24-157cbf68f96mr2608778c88.33.1791172082536;
        Sun, 04 Oct 2026 20:48:02 -0700 (PDT)
Received: from pve-server.rlab ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3512718a18esm10840958eec.17.2026.10.04.20.47.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Oct 2026 20:48:01 -0700 (PDT)
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
Subject: [PATCH v6 4/5] KVM: PPC: selftests: Skip idle-page check when running nested on pseries LPAR
Date: Mon,  5 Oct 2026 09:17:27 +0530
Message-Id: <4e9622b3c3329cd32c120175b06bd30a933b8375.1791014924.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <cover.1791014923.git.ritesh.list@gmail.com>
References: <cover.1791014923.git.ritesh.list@gmail.com>
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

Same nested TLB/access bit issue like x86. Use the is_pseries_lpar()
check to detect when running nested kvm on pseries LPAR to only warn on
idle-page check.

Reported-by: Anushree Mathur <anushree.mathur@linux.ibm.com>
Tested-by: Anushree Mathur <anushree.mathur@linux.ibm.com>
Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 tools/testing/selftests/kvm/Makefile.kvm              |  1 +
 .../testing/selftests/kvm/access_tracking_perf_test.c | 11 +++++++++++
 2 files changed, 12 insertions(+)

diff --git a/tools/testing/selftests/kvm/Makefile.kvm b/tools/testing/selftests/kvm/Makefile.kvm
index a7ecd7a242a9..57d1bf994fe8 100644
--- a/tools/testing/selftests/kvm/Makefile.kvm
+++ b/tools/testing/selftests/kvm/Makefile.kvm
@@ -263,6 +263,7 @@ TEST_GEN_PROGS_powerpc += kvm_page_table_test
 TEST_GEN_PROGS_powerpc += set_memory_region_test
 TEST_GEN_PROGS_powerpc += memslot_modification_stress_test
 TEST_GEN_PROGS_powerpc += memslot_perf_test
+TEST_GEN_PROGS_powerpc += access_tracking_perf_test
 
 SPLIT_TESTS += arch_timer
 SPLIT_TESTS += get-reg-list
diff --git a/tools/testing/selftests/kvm/access_tracking_perf_test.c b/tools/testing/selftests/kvm/access_tracking_perf_test.c
index 4415c94b2866..94bfb82f7b79 100644
--- a/tools/testing/selftests/kvm/access_tracking_perf_test.c
+++ b/tools/testing/selftests/kvm/access_tracking_perf_test.c
@@ -470,6 +470,17 @@ static int access_tracking_unreliable(void)
 		puts("Skipping idle page count sanity check, because the test is run nested");
 		return 1;
 	}
+#endif
+#ifdef __powerpc64__
+	/*
+	 * Nested KVM (pSeries LPAR) can hide accessed/idle, since KVM doesn't
+	 * explicitely flush the TLB for access bit update. L0 keeps
+	 * translations cached so the guest won't see the idle bit cleared.
+	 */
+	if (is_pseries_lpar()) {
+		puts("Skipping idle page count sanity check, because the test is run nested");
+		return 1;
+	}
 #endif
 	/*
 	 * When NUMA balancing is enabled, guest memory will be unmapped to get
-- 
2.39.5


