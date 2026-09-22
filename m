Return-Path: <linuxppc-dev+bounces-27942-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35045C982FA
	for <linuxppc-dev@archiver.kernel.org>; Tue, 22 Sep 2026 18:30:18 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hq7tN6YZ3z30M6;
	Wed, 23 Sep 2026 04:29:48 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:38::f"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790101788;
	cv=none; b=n05Cw5xoVL89kZlJUAnNJbcG/cCD3EP0Qf1XZAXVDm2b6JyhwC0Bb5kWrrMxCll+cUTX+epaLWvE1u85YO73Us+ilnJ7gcknXg0CFN9mMMv+DQexNPGiFEoU0oe+ZekHhvBs550K4F0Kot3UGxECqQJcNPXO+WNW+oS27AyABo+gp/Zml9e2kaFw6JzyEv+UT8lGxDm03OTrgii8bbCUwPL2P3gPV2EOoUn9nARMD1FZu8EINlwvSl+NbxgE8nbdOzWXoOXpD/NCnFHFHXxYlesdcwpVLzuncbSQ7FiWIgwgYMPz2rXQIFBUUP8tulzn00ib373db9ZrtsWW8IcgVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790101788; c=relaxed/relaxed;
	bh=iWNx5fuW8O/XLl14TRTirLP01kUfwqrdwxvRgBlb4x4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dzD41TMatYDxOhtcexS+lELwv+kQfYUsc2i/HY7OEl8SNK21N/kBmbN8Ayipc46iZopHReA/9KRX9MY7BpKwICkRQHWvIhJoZ5IFq/mLoLekx8opHFcIBv1yx5TG1MN0J+jDcgDbhwtr0ykIpRuSvfzXljULqtdXibQ/d8SnTHw3ey7VzzHuEGUqsifuqLGxx2SS1OM/47jb1Pa2JufVkUKsrtNLeml1ViWui0WdSR1JJIRP075BBduji81Govol45FwpOlqs3RNVmK6aeylTv9+Wz3BgfKGJ7B7QkvKrIPFaqPOv2JRfFQwdzkpV/Ivb8DEibceUyLVFtwP+xPnuQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=dVhc4mlK; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:38::f; helo=mail-dl2-x0f.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=dVhc4mlK;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:38::f; helo=mail-dl2-x0f.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-dl2-x0f.google.com (mail-dl2-x0f.google.com [IPv6:2607:f8b0:4864:38::f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hq7tN175Kz2yr0
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Sep 2026 04:29:48 +1000 (AEST)
Received: by mail-dl2-x0f.google.com with SMTP id a92af1059eb24-1438e88300cso121498c88.0
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Sep 2026 11:29:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790101786; x=1790706586; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=iWNx5fuW8O/XLl14TRTirLP01kUfwqrdwxvRgBlb4x4=;
        b=dVhc4mlKcoYL18nKp4eSDYBvaLg8J7SmhzI67T8H+Sw0tzWBsafPq7+fAf/tc9uCPx
         05p0cIWVFBcTr5PyKuj27o6Id3BFsUsRshZyKFn/uRX4cJI+fF3G0VGCKmLsbETocKLC
         C72aD0YSvwNY4D95GTGsQsVkePhkMmLVjGi9dAFPUelFyMZXWkmm2CynudYPpWRkyJwE
         CI0vJz9RHGQuCTNwamzXPXtGQwyNAKWQKeqjVJQ+1OP4rCIcIkiUgWtY6e5eqAuvWqek
         amnIErON0e3dc7uJ/i/N/Yn3uaCrURCSnbzDL1cNo1SpKZxuprvgKZ8NUzu8fByM3dN4
         c3cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790101786; x=1790706586;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=iWNx5fuW8O/XLl14TRTirLP01kUfwqrdwxvRgBlb4x4=;
        b=BzE/U6bI4PHeY+9fvhvXNenuls2z4eNZgFINVIVzukTS2k3OTJBb9KK8J+WY3loHVi
         SG8pw9F57T6OOE0O3lyh1vihaF4e/rloq7yKK2lrT46PtxxnmMuW00orZW8G3/t2Mkt/
         l0CdFfV2LmqoBBWKT7XwEEqIqJeU7LJqQB4DfAjHd1FyrBJ2X7Kk8lRHW49sF5ptL2Ta
         Bet2mjgX6I1laiTsgmye86cnQXsCrs/nc/vLcfnL702xgFjrqI3K0h6t2ENgOYMU8IhL
         1TrUNXgm/hO6knZnzEv1/+P/VK5exPVYwVidG+ZtdUidCScRJ7a3zLmgCYKF6EsEn9Ot
         Wukg==
X-Forwarded-Encrypted: i=1; AKwUvBzn6Q2HB9+5BqvF1UJSvR/LZrAwhXFyV/LJhGeGDcnoUjd0fV3EU0AvqjAE6XWnM6wc1kSRk3f5vl2bezY=@lists.ozlabs.org
X-Gm-Message-State: AFuF++lYjLjhet7dbl2v+YdIrgYn2UknRRqQYk6CbA7OjTjGbeEkgDL3
	n2Ph63vqPnIfqReTOP70zJVesc1jHa029ffhIuHaCwewIrfAYTcDlPZY
X-Gm-Gg: AYBFou1OYd8MOjeLpfWgfcxovRu5ukbNvDz4eCSePIXuRmrLRLx9vjL1FYODkMWFKlO
	U300rjAPjQik+QGU3O6GC5lo924cvGqMpQfeKzyD5gTqFRvr8+b4qMabxbMD4uDyQbh6Xfk5AtC
	5Ev3Ndz6Gd6EWO9xgdE61dbiooLnyOvpHs0mwW05opNEF5AtX77Yn6R2e3A4kfatCGmmKYBl9yK
	xIs8ECY+aqIFHe8MzHkReOKGnx46qlM1xHmC5SSnKVFv60xY+h56zQO52yUURSQcrcmUFM6USts
	zIR33YFw8UFUGrbS1QUuLmLsAqZJvCWgJ+Bv6xh8IcUpCeCtTb//wK2iZGnFbvoFaUeHkhAdDif
	RgrSvu6PAjfKoJ8PbgTJcAE8kruII55m4V7fQm0HzdVmEcxPboiXvjJbHD9m/sxZWHQJMc1a7qH
	B/MuGju3JAPrCSkrepVzYlicPpXcVRkG124cT7lD4ez/sctifboBQgJDAGwGiP8ooB4cWAz8XxA
	mn363vL8hvUyphpp0evhXP4VrreSmXfl4fS80R5XM6DbSD+OZG7gR7XGVKT
X-Received: by 2002:a05:7022:2099:b0:143:7dea:f6a with SMTP id a92af1059eb24-144f91dd840mr209295c88.32.1790101786036;
        Tue, 22 Sep 2026 11:29:46 -0700 (PDT)
Received: from pve-server.rlab ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33e939fdabcsm154315eec.3.2026.09.22.11.29.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 11:29:45 -0700 (PDT)
From: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To: kvm@vger.kernel.org
Cc: Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
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
Subject: [PATCH v5 6/9] KVM: selftests: Limit the number of VM creates in hardware_disable_test
Date: Tue, 22 Sep 2026 23:58:50 +0530
Message-Id: <db32438dee67a69609e75d8c43cb070f021137b1.1790101179.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <cover.1790101179.git.ritesh.list@gmail.com>
References: <cover.1790101179.git.ritesh.list@gmail.com>
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

hardware_disable_test forks several VMs (NR_IERATIONS=512). This patch
limits that number to 4 when we know that we are running in constraint
host environment. The number 4 is just a safe minimum when
kvm_arch_vm_create_may_enomem() can be true.

Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 tools/testing/selftests/kvm/hardware_disable_test.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/kvm/hardware_disable_test.c b/tools/testing/selftests/kvm/hardware_disable_test.c
index 43a36ef3ead8..e90a17b8160e 100644
--- a/tools/testing/selftests/kvm/hardware_disable_test.c
+++ b/tools/testing/selftests/kvm/hardware_disable_test.c
@@ -20,6 +20,7 @@
 #define NR_VCPUS		4
 #define NR_SLEEPERS_PER_VCPU	16
 #define NR_ITERATIONS		512
+#define NR_ITERATIONS_LIMIT	4
 #define DELAY_US_MAX		2000
 
 static cpu_set_t threads_cpu_set;
@@ -127,7 +128,7 @@ void wait_for_child_setup(pid_t pid)
 int main(int argc, char **argv)
 {
 	cpu_set_t allowed_cpu_set;
-	int s, r, cpu, i;
+	int s, r, cpu, i, nr_iterations;
 	pid_t pid;
 
 	kvm_sched_getaffinity(0, sizeof(cpu_set_t), &allowed_cpu_set);
@@ -141,7 +142,9 @@ int main(int argc, char **argv)
 	sem = sem_open("vm_sem", O_CREAT | O_EXCL, 0644, 0);
 	sem_unlink("vm_sem");
 
-	for (i = 0; i < NR_ITERATIONS; ++i) {
+	nr_iterations = kvm_arch_vm_create_may_enomem() ? NR_ITERATIONS_LIMIT :
+							  NR_ITERATIONS;
+	for (i = 0; i < nr_iterations; ++i) {
 		pid = fork();
 		TEST_ASSERT(pid >= 0, "%s: unable to fork", __func__);
 		if (pid == 0)
-- 
2.39.5


