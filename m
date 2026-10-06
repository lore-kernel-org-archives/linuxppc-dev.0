Return-Path: <linuxppc-dev+bounces-28961-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1101ECA5FF0
	for <linuxppc-dev@archiver.kernel.org>; Tue,  6 Oct 2026 10:30:55 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hzXZt5tXpz30VL;
	Tue, 06 Oct 2026 21:30:30 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1336"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1791282630;
	cv=none; b=nbYO7SJ2iBb4VjH0tFhiuLTzAZ8///G5pDprT5KIM573HpJ0kvuxe/ASSf9Xw7jSu/Ov7uEkg/BidD4VO+nOzH/eCw99hH9dkNeJvyewq7M2JIuo2MarBAH6kwth2fOnB0WCfUnW17vE+oFtxxFHtJ9s9+j2dmlHjNY721CE4Q+h3zsa2/l0//Y1zPz9v7ERrp+ONN4RwW9EFPJMEx6gRO2IufOrLQUpD/kEtx/erwW2Wc25fuvOF1oZ5X5YoaJFV5mtbGtgy2jwkTgrlRgLSxYRVz6nBONm3mY2Nbkx2I9x2jeodua19iZ46zJusWwN/Gi3A5u67hD2fGwx/j8Z2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1791282630; c=relaxed/relaxed;
	bh=EA/0ZEGZrte27R/NKRLHTW1lEfVA+wxAewcBQb4Z8UU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=l1VvIOq1vLQ0RZp0GvJWlhUNRJK2OXGVxgTV/vhT06oMPidOEwbxUT37Nn4UmhECQscGRptg1IqvrJVVvdOGFyUMUzx0DB/FUBqxHWWRvy4fqndL7WTXa0RjCniZJfSLCb1q1zOWaNrVMiA+ZZjxOGbvUKUp6V6OCSpIBzfKFlqygzN5B+nBYVJS+vG0prpyErr8tV+4bcN007z32dAxt7EFEqOYgY4Zee/f2Rriaqnom/qATBXpWvtuhPeiFp5jOkfhNtRhMMi6jZ9ZEn/Fj8Sgq6P7R7g6ANdFsuiaMGwJ/QbecMR087ow7chhlGERk1uM4M+Fv0VrIReT3vOURA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=hyAmZqi+; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1336; helo=mail-dy1-x1336.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=hyAmZqi+;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1336; helo=mail-dy1-x1336.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-dy1-x1336.google.com (mail-dy1-x1336.google.com [IPv6:2607:f8b0:4864:20::1336])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hzXZt0pL4z2xwd
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 06 Oct 2026 21:30:30 +1100 (AEDT)
Received: by mail-dy1-x1336.google.com with SMTP id 5a478bee46e88-34ef8f66a6bso732213eec.1
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 06 Oct 2026 03:30:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791282628; x=1791887428; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=EA/0ZEGZrte27R/NKRLHTW1lEfVA+wxAewcBQb4Z8UU=;
        b=hyAmZqi+dNG+FvTuusOpjJPwRa7blTy8YHEyEuwmhGNAaMkdg6R7isdPIhgbfMrQod
         uElA53BpWNvt+L0FK1pUvtX6unANjqGjvFbT0QXe39NIABV3lhgiqGp26I5b3iwzin6e
         XErxqR0Thatt1DeDGuzYlegqH5kZc8yNIZfOoS20cWC7HJvvmFoeDLMdsGwYvee2JVsj
         bt6hUpuJhzCfHC+lXpHyLUaD83ZK6z2RQzThiwuBjW/hz50nSoUvdyb73W6Utc5GzMrE
         XuMq5+QUEdREMtowmrlC6MzgHJWw1+8yiN9tCU9xVRLV3jHzxMC54W441qOwhMUm7BLy
         Lx/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791282628; x=1791887428;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=EA/0ZEGZrte27R/NKRLHTW1lEfVA+wxAewcBQb4Z8UU=;
        b=pBFyk66UKSOizjnnSpCehpWkATUISRdSjh4DY033hHMtUVKSwDCW+jm9vPzgVFgJXX
         JFO4GlLplQbXpwrNApPvNurgPShyhceaFhyYiMRGUbx3MBn6y2Fmn/gX/XQDZ5+2heQP
         QhnvYXmgzO7SHHMsR0iPJyhYrwuOlXyOMYhO1WhkzsvIh04LZDFlwRS3NS0zmLL5iGw/
         26pUttMYkFUKoSBafdsQwh+4xW1yV5DtY2UiYVovguUmy6n2ILz3qtJ1j3cpLYlBuIZa
         DlsMbclR3luj1R7++v04C8fD84czOS9aq4VBg7YQocn7tV308vb6bBssAFOQJKnomacI
         7RqQ==
X-Forwarded-Encrypted: i=1; AKwUvBx0XJxjfDggPcsiGMbvBDqsEym62cRB6AMoMzSdFSlthrJp5n/8el4a4ZVDLnKlcGYcTnlOIfsKDscBa4M=@lists.ozlabs.org
X-Gm-Message-State: AFq9FYIiYeZv8dkyYqsbQ6tKZgpMm0YGSq01EmoiTa9v+jmgXzOK0Yem
	iUx1br00zZYj4bdTzFgo0PeHiWvuzlJSsdMeG8zhJ/cVCA04qmFtvf5g
X-Gm-Gg: AYBFou25dJNz6xwfoyCSXtgPYHl/dXe4nstguflPyJKgbu12ZHkxycmAHPCPCuS6cxf
	ccuBKuV8WRd+n3ebjHCXz6KeU6nSZXwvPQVJ2+gRi+6FNTxEdWoPjKbQURTE7Oz1jcOdq6OBxp5
	yPNm4u7V2GLG0f7zAJ+GW27nBzrIy3dks8sDPyUcUmHGQyzQ47WEJo4YdlkCr9EcxkoAyAr/omB
	GE6aN52rMC68CRVFR1Pl6n8gRfZF/22iZcN3qTJjQ9ujVCrp5HQke26Pnsw8ONkvlNcLY6Z9oxE
	YGHm6auOXcx3ZVVqwud9tLgU2RDV4RI01faa2kkZmZwpfdq9O1iOM7ZkVvsXDAxX5zvx7+O0ZtX
	ouVHPRQf1neMZxtndrCeBcQudDNJ3276gtkqC0zwD6VsSJiLsxWNI7kU8Za/r/JTlt842wfFqrY
	0E0WItdUYlQTqp+T6PwHOMCVc27fnfIzqjpnDeKfST5XvgWjHt+dW+w0C8T4krNSj2EYMkwlwYh
	kb/Dy+DntwIi+mQlV3h3h2oCaCPC19Pli09ylmbxrga6RJ4M5ZB4abzVDn8
X-Received: by 2002:a05:7300:a98e:b0:351:4648:3611 with SMTP id 5a478bee46e88-3514e334d5emr1545061eec.26.1791282627586;
        Tue, 06 Oct 2026 03:30:27 -0700 (PDT)
Received: from pve-server.rlab ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-351469fa189sm7443970eec.6.2026.10.06.03.30.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2026 03:30:26 -0700 (PDT)
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
Subject: [PATCH v7 8/8] KVM: selftests: Skip hardware_disable_test on powerpc pseries LPAR
Date: Tue,  6 Oct 2026 15:58:42 +0530
Message-Id: <23f36aab5e9c849719ffeb796e1a74e69eb5d142.1791280439.git.ritesh.list@gmail.com>
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

The test forks 512 children, each of which does KVM_CREATE_VM and then
SIGKILLs without waiting. On a PAPR LPAR that ioctl is H_GUEST_CREATE
and unreaped guests may still occupy L0 Guest Management Space, which
means create can fail with -ENOMEM error.
Hence, skip the test when we are running on powerpc pseries LPAR.

Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 tools/testing/selftests/kvm/Makefile.kvm            | 1 +
 tools/testing/selftests/kvm/hardware_disable_test.c | 3 +++
 2 files changed, 4 insertions(+)

diff --git a/tools/testing/selftests/kvm/Makefile.kvm b/tools/testing/selftests/kvm/Makefile.kvm
index 692bbae44a65..38c3900cac68 100644
--- a/tools/testing/selftests/kvm/Makefile.kvm
+++ b/tools/testing/selftests/kvm/Makefile.kvm
@@ -258,6 +258,7 @@ TEST_GEN_PROGS_loongarch += steal_time
 
 TEST_GEN_PROGS_powerpc = $(TEST_GEN_PROGS_COMMON)
 TEST_GEN_PROGS_powerpc += access_tracking_perf_test
+TEST_GEN_PROGS_powerpc += hardware_disable_test
 
 SPLIT_TESTS += arch_timer
 SPLIT_TESTS += get-reg-list
diff --git a/tools/testing/selftests/kvm/hardware_disable_test.c b/tools/testing/selftests/kvm/hardware_disable_test.c
index 43a36ef3ead8..0104b7e840b5 100644
--- a/tools/testing/selftests/kvm/hardware_disable_test.c
+++ b/tools/testing/selftests/kvm/hardware_disable_test.c
@@ -130,6 +130,9 @@ int main(int argc, char **argv)
 	int s, r, cpu, i;
 	pid_t pid;
 
+	/* PowerPC PAPR L0 cannot guarantee 512 overlapping H_GUEST_CREATE from fork+SIGKILL. */
+	TEST_REQUIRE(!kvm_is_ppc_pseries_lpar());
+
 	kvm_sched_getaffinity(0, sizeof(cpu_set_t), &allowed_cpu_set);
 
 	for (i = 0; i < NR_VCPUS && CPU_COUNT(&allowed_cpu_set); i++) {
-- 
2.39.5


