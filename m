Return-Path: <linuxppc-dev+bounces-21429-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E0B7CD5BB1
	for <linuxppc-dev@archiver.kernel.org>; Sat, 23 May 2026 11:15:24 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gN01G2MR4z2yS0;
	Sat, 23 May 2026 21:15:14 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::433"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779534914;
	cv=none; b=Y+G0dfncrl1D1fJaNcc0viTKMO6vaAu5uP/WFwtw9+obTyyp5OjqDRHYLF43gpggIAasjypGAIaBLe+Rf5TRIATkKEY6cN04uP73b2Pr+IeiYYglJ+pNN38YC0Vo8IXN9vdu4j/STtuqHDlOPM36QUYhc5/mhZZi3scU6R8Q4sp2661t1Dnn5nK0y9WFHJ9zlRFmvjFlQdlbDtmOsbFdpuLhePuzZbeiJXBqs13esjsN4LPGjrMgrdW8yeftP4f9tmYH7fBvHqY1/QUt+qkX2E74jEe/OGJvb73GoaG4+gMtkGeASB5DvJ2GcAc6MuwiUHq+RxbBj8OVGoDB4wW0Jw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779534914; c=relaxed/relaxed;
	bh=WHUxe7lnPztFxDQVjPCLiqbcKDb3U3X7b1X5k1GLWTA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZWY/GVAwphOkECEzoSM5MjUFTcqLm1dnG40qeh+b/PfE3N1Bh6pxoaxC9XAEucnkVY9hrEn2lWqpg1Lz8PDOiEmuwEfCw6BcV6WFr8uWNsTAomnGdQpkfOK9BOWuT6cbX2a38PPhIkHFxeKOG4Ci6EQE0BG+kai9l+Rkds9cOikNttwgnF1Qw3l/uzhF9k2VIYzu/uLfnX6mbN9v95AlhdNCCpyzJL0lhbG8PDaairuqHQbaivMQj7JSdpHj2ko0OlGyx9df9weTDOohZiEocCAB21OKQJ0ooSUVByitS6PfvnL0eMonngTOcPbjYfgLAbLcMfMsP2+vHIlXU2uNOw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=EslPulWB; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::433; helo=mail-pf1-x433.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=EslPulWB;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::433; helo=mail-pf1-x433.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gN01F4HxNz2xJT
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 23 May 2026 21:15:13 +1000 (AEST)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-824c9da9928so3629734b3a.3
        for <linuxppc-dev@lists.ozlabs.org>; Sat, 23 May 2026 04:15:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779534912; x=1780139712; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WHUxe7lnPztFxDQVjPCLiqbcKDb3U3X7b1X5k1GLWTA=;
        b=EslPulWBmUhsDlSj4CoqkBei4OAazHEDSH6hWlkL/mM++CgXHFIgY2ebmpAIgQb4p5
         u+9CfBAfEVyvd8JL7AqPHqibRqUu7X+V8WSvAXAIQedmuZc+JFprE6CiP+gsAGRrku+4
         Wi0jTQdqidZtH2XRvHDmBQhZ0Y1pAsgP5RfrbfSDMGsZUZzgdT69W4syezJoTCMEedt7
         p4Hbb6L1vDD2OeKbpzo6SeUlqe2jUyNhiOBkjuKE9PZ/kBtzh3eMbzEd9lYb8r0XVt9F
         H2rVNwYz7Te1SHep68sAas3ecMT8C/zG3FXzYfxUby+jyxoVwelWW6NjbafZFKDAbL27
         cxHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779534912; x=1780139712;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WHUxe7lnPztFxDQVjPCLiqbcKDb3U3X7b1X5k1GLWTA=;
        b=pg/yP1kJa/Jo7qoFYUW9RVEw97i787kOl4XMAHcqLpYJltgDcQaYjCgjdWU/CXI2Ls
         v7CGPcRZ1dMR9FoDDi02U5pXcbZFsMeMALUfxXz5CouroEvIGyEudagS7/xl9/HEmAf3
         gHk9Yj8hld3iLVvn1RMbFGCP3rFFCTPZje+aEG0lZsuOmKQ74HF/ilSv1fDK4BqgRgTh
         eNJ2phVnbE0TXy2zgLqg87n1UBnxMoVyrUNkjNX3KbQGoChZvqE0Z1UflR6YFVrKidB9
         wTDpFEGW4xlv0cY1sJHDgnk7HoXqYVn4QjlfI9jzQaCHQ7NNJInjnUrceuZAYnlqG0Zp
         +ETA==
X-Gm-Message-State: AOJu0Yxi9I4y2uRaACzMP7Lqu7yEHXiNmQdhVAEjGth5xrklVlimhkNG
	62NE/l7Fy1/198/sYAnhFO6/eDEW+79zr9eafIZpgyO30OOaBxsnVDUj
X-Gm-Gg: Acq92OE2qMIHpkgihS/IzwCurqn/kz0mlMh2qCoj5zJ8xzDt0D8qLwpLeUZDK1r2pZG
	YbVuMOZEnVzOzJNGlEixqMjrHqNFthLyBiRlyzks9DmNzuaves8smAaNzRruhipa+Y6OtGv3K30
	aoOW6vpnjQMiaWr6aGkjitwsPGjADmWhEa8q/JUZHFRrKdPPyTWu0/PAtMd0A7AjXR7gqN8DXYx
	Vx+Iy4KnIivGDafeOvf2DyXfBLhO0drlqrwHZV4iNK9DwoY/vJUdgGnseZFTNCmhJYOEniumPPx
	1zuTPHJZ6PArLyiqMYB6XIyYDWO9FgIzBFXAPS9Wvca2UR/8AQ4mCI70FZHE6nn9i4LfSXLHDlC
	KASPMEWP8lkqeDDgSL+lSU919QJu5dgrD0SMemW8JPOEe2xeOirp1N9wtwu/98MhyMIxU0BnGlL
	qpMxPFnm3HPR7tAdMjKJjti82mvLSCtyIvnq7MzqE=
X-Received: by 2002:a05:6a00:bd0e:b0:81e:f1c3:89df with SMTP id d2e1a72fcca58-8415f3f73b2mr7274322b3a.50.1779534911562;
        Sat, 23 May 2026 04:15:11 -0700 (PDT)
Received: from Mac.ibm.com ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84164ac9c77sm5249140b3a.2.2026.05.23.04.15.06
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 23 May 2026 04:15:11 -0700 (PDT)
From: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To: kvm@vger.kernel.org
Cc: linuxppc-dev@lists.ozlabs.org,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Harsh Prateek Bora <harshpb@linux.ibm.com>,
	Christophe Leroy <chleroy@kernel.org>,
	Venkat Rao Bagalkote <venkat88@linux.ibm.com>,
	Nicholas Piggin <npiggin@gmail.com>,
	Misbah Anjum N <misanjum@linux.ibm.com>,
	Anushree Mathur <anushree.mathur@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	linux-kernel@vger.kernel.org,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Subject: [RFC v2 4/5] KVM: PPC: selftests: powerpc enable kvm_create_max_vcpus test
Date: Sat, 23 May 2026 16:44:23 +0530
Message-ID: <cb27fdc2348a933351619bbf1beff53a242b045e.1779524962.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <cover.1779524962.git.ritesh.list@gmail.com>
References: <cover.1779524962.git.ritesh.list@gmail.com>
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

From: Nicholas Piggin <npiggin@gmail.com>

powerpc's maximum permitted vCPU ID depends on the VM's SMT mode, and
the maximum reported by KVM_CAP_MAX_VCPU_ID exceeds a simple non-SMT
VM's limit.

The powerpc KVM selftest port uses non-SMT VMs, so add a workaround
to the kvm_create_max_vcpus test case to limit vCPU IDs to
KVM_CAP_MAX_VCPUS on powerpc.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
[Rebased to latest mainline tree]
Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 tools/testing/selftests/kvm/kvm_create_max_vcpus.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/tools/testing/selftests/kvm/kvm_create_max_vcpus.c b/tools/testing/selftests/kvm/kvm_create_max_vcpus.c
index c5310736ed06..a82c13d6cdf5 100644
--- a/tools/testing/selftests/kvm/kvm_create_max_vcpus.c
+++ b/tools/testing/selftests/kvm/kvm_create_max_vcpus.c
@@ -56,6 +56,15 @@ int main(int argc, char *argv[])
 		    "KVM_MAX_VCPU_IDS (%d) must be at least as large as KVM_MAX_VCPUS (%d).",
 		    kvm_max_vcpu_id, kvm_max_vcpus);

+#ifdef __powerpc64__
+	/*
+	 * powerpc has a particular format for the vcpu ID that depends on
+	 * the guest SMT mode, and the max ID cap is too large for non-SMT
+	 * modes, where the maximum ID is the same as the maximum vCPUs.
+	 */
+	kvm_max_vcpu_id = kvm_max_vcpus;
+#endif
+
 	test_vcpu_creation(0, kvm_max_vcpus);

 	if (kvm_max_vcpu_id > kvm_max_vcpus)
--
2.39.5


