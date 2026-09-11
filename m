Return-Path: <linuxppc-dev+bounces-27088-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E0A9C88E41
	for <linuxppc-dev@archiver.kernel.org>; Fri, 11 Sep 2026 04:57:28 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hh2Mz5q2cz2yjN;
	Fri, 11 Sep 2026 14:57:19 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::629"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789102639;
	cv=none; b=hGWV8L5ZY/0uGPsKGPmGS3icxYXadb7l54dWAS+9dFwpWmrU8d+eoNztLPJw2mkXNnDvVu34nqM6VdFR1Ol6Q/nEea67FTZwW0Mctlfb5/+YzvUywJV78GRSqnb+hXBRiK4j3R1HNJSVIMBw16tPvZv/cHqyhpbOpJS4kdkYERiYYlpgag1inRes8KdVs+2VYkMaZ1lKnSy64jH7V3ya6MlKagPG4daAO0zYG/i222Qj5w43VRP5kNWMfNE5/MoD3XpSCPODJEvvaMyCBCH1IYoZFdApzYBbPtpZOksjooheMJyvnwKxe4E1zz0kgqz8lnH0YHQvrTcQgTxcZTKiaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789102639; c=relaxed/relaxed;
	bh=bNCb33ZXLrWvVF+B0ZOBHM6IgfnW37C+yUxO/5EOyVA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AdzEEdJ13oiJvNCXUB+IIWIum8L0Y4om/Z7YiwyFJA/NxdidIyTQhsZwlRu1uAXoSa2a+Q5/4OpvSscnd0jbh9+GUsmIG1HFigXWYtpT/qS5buhp5nnz0xPl4d7lNqpAN5jJagOrKDJMCGQSPWh35vCmGQ/sUz4Em/3YrgjGD6vGMnu+/eMXxiylt52esURv71DIf4nptSVBkmUvEMJYodrJuucwY8RGRsSXfD/XdL97xD6RbwRTkiHtmLl/tVS1v3dIw/MYeHDB05rznueB163txsTf8kN6btCeCO5gFp/+LEtKmXuPjSMlrT7UkTJ33z7QEg/WvNWMyWeF0yeRHw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=XV6wzbPM; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::629; helo=mail-pl1-x629.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=XV6wzbPM;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::629; helo=mail-pl1-x629.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hh2Mz04gnz2yFj
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 Sep 2026 14:57:18 +1000 (AEST)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-2cc891373e0so4802905ad.2
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Sep 2026 21:57:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789102637; x=1789707437; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bNCb33ZXLrWvVF+B0ZOBHM6IgfnW37C+yUxO/5EOyVA=;
        b=XV6wzbPMEHudT5UZ5eJR2auqbd4jK0VbKmHgUEBobPUf9CsmeLflxSvT/oEkLAMngA
         F9sNAR++5yLI2NUhefUTnhKodKjGVXb4RMz8sPuwET0jfFOG2Iq+vKNMm4ZsW12XKNem
         3h4++pNADVqtKEGagC7NhMM0OXM5mLTTVSVL9Zzhdc8DoUkAKfq4kYixawL9HhM+3035
         QbfQeTA9ic21XS58dFiYy4cjHL/Go8az1+oWuzPaYhJ9kz4GY7NfUG9h19hmr9fNLGtu
         ON6pjrZmgQGVimT7I9Wi4kiBzCiDDsJ0nix5sbXAda6mToBdeZzi2/wpMkhOHWTMLmM1
         zuPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789102637; x=1789707437;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=bNCb33ZXLrWvVF+B0ZOBHM6IgfnW37C+yUxO/5EOyVA=;
        b=HnRmskywW2UvGGny6qDHvLzVBBJCsDGWmQXHrv2GUn3T0rZOys05UcLgqTzRBW+moc
         IyJQdG9GTYfrKg4R1kMfcrfo7nSAtk+C47Aws1KV+91+72B3HUZHndfgE79x4l2TXyjZ
         4xL0Yw83qpeIutSPAt4g3fqFuebz79uxks4qw1NbU6OlM355htLXnf2AjN5PI4qDIQBY
         5sSFaAPCjJWfXkE2JEjY2pF9sSLyikYPWGQ+Z8Vc4Q69hHTB/evbbCa7vyJD/ueU6Bz/
         lgolr3NAcKFCC5bBRcpC28M7aCirXxmjYvJgNaCK62mOfusLK5OGGxcB2Axot+1szpbr
         zVYg==
X-Gm-Message-State: AFuF++lF7ulg9z2/jZBoYU2uLDeVSSTdyj0TC/pbXZtNWC3p2dLTnqDK
	d76P0ndeOhZtrfIA0kkKb92S+uWnIUugxk6Edh6p4f4uZmeLYrAhcVH16mwqiw==
X-Gm-Gg: AYBFou3lrYB1a0oJ2LKrdQoTbUaSUk6EvTBY30cMkIOFCMQ7sOdSk4nlP5IWLAwneni
	b+2v5vwupM/q1+xsc80Qaq6P3pWReJUkKf1wvN3GM8sV+NYo6FQmjP4Jr8KxKXzODIe2uPLqR1q
	A7j1SffG/zLSN21ycOD/Z1LMlXmLekhxb3vc+5s270DGPWxhwXtf58lStpYnboDP/YPbZ/Y+5JS
	AxOsACUMqpwFFRteFRvoIjYz1IE4Lat80sA3jOKwmMnzXD1YXKcRnSPNSUKwl39F2dBk1NzkcqA
	dyQECcJMUT6gzJDEjBIv5m49a/HDagK5wCn4dyiJNTCN2UPlUjAg3rcA9ZuXPmWYFBaSaylVn9k
	r/vnjhT2p9Q8YrVbvZg/wtr8N9q1PmkbmcqvHml5Hm8MxCOMGU30AZaCsI7SClnNnTq6pfiJPlZ
	JFzPmdFLdZFvMfQUtxQ75pzKSA90ziiyk6wIGt/Co42knSoZiCHXDsTKBLo9ljZZ+l7iBFZ/o+7
	F1zAKlIM6cQsGRC5ANjKS0WKM7IswKkPq7dIMlTVDuY7V7gxb2XHIGChOkdVA==
X-Received: by 2002:a17:90b:5807:b0:398:e96a:8999 with SMTP id 98e67ed59e1d1-39d9c1befffmr3979865a91.16.1789102636722;
        Thu, 10 Sep 2026 21:57:16 -0700 (PDT)
Received: from pve-server.rlab ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33ba4e9a3casm2837953eec.12.2026.09.10.21.57.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2026 21:57:15 -0700 (PDT)
From: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Michael Ellerman <mpe@ellerman.id.au>,
	Christophe Leroy <chleroy@kernel.org>,
	Anushree Mathur <anushree.mathur@linux.ibm.com>,
	Venkat Rao Bagalkote <venkat88@linux.ibm.com>,
	Harsh Prateek Bora <harshpb@linux.ibm.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Subject: [RFC 3/3] KVM: PPC: Book3S HV nestedv2: cap max vcpus to PAPR limit
Date: Fri, 11 Sep 2026 10:26:47 +0530
Message-Id: <e2c1ef05eaa19beb28a3db08fb697a80528cd43a.1789099725.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <cover.1789099725.git.ritesh.list@gmail.com>
References: <cover.1789099725.git.ritesh.list@gmail.com>
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

PAPR spec for H_GUEST_CREATE_VCPU says:

 "Only 2048 VCPUs can be created, and the specified ID must be in the range of 0
  to 2047"

However, KVM reports KVM_CAP_MAX_VCPUS as NR_CPUS and KVM_CAP_MAX_VCPU_ID as
8 * NR_CPUS. It also passes the userspace vCPU id through to the hcall unchanged.
On a nestedv2 host (KVM on PowerVM / pseries nested PAPR) built with
NR_CPUS > 2048, kvm selftest e.g. kvm_create_max_vcpus will create vCPU
2048 and fail with EINVAL when the hypervisor returns H_P3.

Following error gets reported (with a debug print added to selftest to
print failed vcpu_id number):
    ./kvm_create_max_vcpus
    Random seed: 0x6ec3f539
    KVM_CAP_MAX_VCPU_ID: 65536
    KVM_CAP_MAX_VCPUS: 8192
    Testing creating 8192 vCPUs, with IDs 0...8191.
    [   62.655458][  T302] KVM: Create Guest vcpu hcall failed, rc=-56
    [   62.655458][  T302] KVM: Create Guest vcpu hcall failed, rc=-56
    Failed KVM_CREATE_VCPU for vcpu_id 2048 with errno 22

    ==== Test Assertion Failure ====
      lib/kvm_util.c:1395: vcpu->fd >= 0
      pid=302 tid=302 errno=22 - Invalid argument
         1  0x00000000100061d3: __vm_vcpu_add at kvm_util.c:1395 (discriminator 6)
         2  0x0000000010001a6b: test_vcpu_creation at kvm_create_max_vcpus.c:32 (discriminator 3)
         3  0x000000001000160b: main at kvm_create_max_vcpus.c:59
         4  0x000000001001b713: __libc_start_call_main at libc-start.o:?
         5  0x000000001001bb47: __libc_start_main_impl at ??:?
      KVM_CREATE_VCPU failed, rc: -1 errno: 22 (Invalid argument)
    [   65.316986][  T302] KVM: TLB LPID invalidation hcall failed, rc=-2
    [   65.316986][  T302] KVM: TLB LPID invalidation hcall failed, rc=-2

Cap both extensions at 2048 when kvmhv_is_nestedv2() is set, so
userspace never requests an id the L0 cannot create. PowerNV and
nestedv1 are unchanged. The issue is only seen with nestedv2.
While at it, this also fixes the limit for KVM_CAP_NR_VCPUS.

Fixes: 19d31c5f1157 ("KVM: PPC: Add support for nestedv2 guests")
Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 arch/powerpc/include/asm/kvm_host.h | 1 +
 arch/powerpc/kvm/powerpc.c          | 6 ++++++
 2 files changed, 7 insertions(+)

diff --git a/arch/powerpc/include/asm/kvm_host.h b/arch/powerpc/include/asm/kvm_host.h
index 2d139c807577..d48232557259 100644
--- a/arch/powerpc/include/asm/kvm_host.h
+++ b/arch/powerpc/include/asm/kvm_host.h
@@ -37,6 +37,7 @@
 #ifdef CONFIG_KVM_BOOK3S_HV_POSSIBLE
 #include <asm/kvm_book3s_asm.h>		/* for MAX_SMT_THREADS */
 #define KVM_MAX_VCPU_IDS	(MAX_SMT_THREADS * KVM_MAX_VCORES)
+#define KVM_MAX_VCPU_IDS_NESTEDv2	2048	/* PAPR H_GUEST_CREATE_VCPU vcpuId */

 /*
  * Limit the nested partition table to 4096 entries (because that's what
diff --git a/arch/powerpc/kvm/powerpc.c b/arch/powerpc/kvm/powerpc.c
index 9194cf492d1c..cf620b6534de 100644
--- a/arch/powerpc/kvm/powerpc.c
+++ b/arch/powerpc/kvm/powerpc.c
@@ -663,12 +663,18 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
 			r = min(num_present_cpus(), KVM_MAX_VCPUS);
 		else
 			r = min(num_online_cpus(), KVM_MAX_VCPUS);
+		if (kvmhv_is_nestedv2())
+			r = min(r, KVM_MAX_VCPU_IDS_NESTEDv2);
 		break;
 	case KVM_CAP_MAX_VCPUS:
 		r = KVM_MAX_VCPUS;
+		if (kvmhv_is_nestedv2())
+			r = min(r, KVM_MAX_VCPU_IDS_NESTEDv2);
 		break;
 	case KVM_CAP_MAX_VCPU_ID:
 		r = KVM_MAX_VCPU_IDS;
+		if (kvmhv_is_nestedv2())
+			r = min(r, KVM_MAX_VCPU_IDS_NESTEDv2);
 		break;
 #ifdef CONFIG_PPC_BOOK3S_64
 	case KVM_CAP_PPC_GET_SMMU_INFO:
--
2.39.5


