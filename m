Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 388CC606A324
	for <linuxppc-dev@archiver.kernel.org>; Sun,  1 Nov 2026 14:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=bFGJRFeM
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jHd316NQfz2yST;
	Mon, 02 Nov 2026 01:47:09 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::132c"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793544429;
	cv=none; b=Lh+zqF7kWeh5OsrSmahJgOxNm0F99ox3XJX5A2FXQZqlQsr3jh4sIlxqjD5eBnTuP4/96HlvC52QnDp3zPrnne1ZNNuTJ+7l8tWN2ZCLcGcm3OFNn9c3DBtOmvmmdLx/A/1n6C+XkkyLPGV2hDVn4O6LddgrJdD1lgS4/1P7SeeVs8Ax7mKR5FCUNWepe617Ilbfmh4ejdLWotHFQTgZ+Z64h89TCAJrB0A/LUsAO69SCebiT+BIYHhstK/5Yo2b3gUXuikDmpBUfCe5E4/Nk9EWF+Ce1nfkgHgzmTgXNsAFPWGZygZSb3LnNFFf2qbZ2Nkle6cc2J+sJh4opVNTtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793544429; c=relaxed/relaxed;
	bh=FazxrWHX2Tn7PurYTqREXzQh0pHc6RTMEU3g/b7/CQI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hIalbRSPlN9+V29TYv9ze4q5fVZk91hLrW7RZtXSiS/UL82UR/9UNX6F+NxqlINIe3HlXJkOfI/1DG31aIEXdZKvNryU10rE9cf0BKu/ynwwqjkS6lFSDfpACN+GolE1B0yozYnECPNF1zirz3f8JLxvc7H47cMUJ9KT8lRHV5f2Qn2dBZlvr8VKfkEFZ8VfhTtHyJ7tQ6i8hZ8fzLo0hnFhfVApHRsCHu3mo4rsXEBtbGPF9eeYmFl0fuM6NzcoaRdoFjuh81GSYgLQXH7Y00aVK6wZ29tw3qUAFbzc1+aCWzu9mTcsumCA2WXPw+7c/ksfRqH1pALfSXPfw2bhPQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=bFGJRFeM; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::132c; helo=mail-dy1-x132c.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=bFGJRFeM;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::132c; helo=mail-dy1-x132c.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-dy1-x132c.google.com (mail-dy1-x132c.google.com [IPv6:2607:f8b0:4864:20::132c])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jHd311Bd6z2xgv
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 02 Nov 2026 01:47:09 +1100 (AEDT)
Received: by mail-dy1-x132c.google.com with SMTP id 5a478bee46e88-36a17a332ecso3643051eec.1
        for <linuxppc-dev@lists.ozlabs.org>; Sun, 01 Nov 2026 06:47:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793544427; x=1794149227; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FazxrWHX2Tn7PurYTqREXzQh0pHc6RTMEU3g/b7/CQI=;
        b=bFGJRFeMcWXwJUedrpWmti+zSQ8EwhzX1OAz09Yy3vcyygsB1ZsnLhj9Ye6IhTdf3M
         Q6jlRrZbqooyZBltsh9qFct5H6qd/PGxOst2HUMJ0mPOa0ckI7i45ka54VjKT932DCvf
         Z3wi+4GRafV8ZHnq33kjSNIXAj1EHGS6Ba/te2gOYdgtczraJvME9pfdm5Mx12SFF5Pj
         qtDYWfvXDwkibRmPLc/jM2u2dmXcj456G750wXaT9jfXajOktkPmFEKD/Ff8BxVW7RRU
         VHmHr5MyxWMjEfsC6WDbJKLeby3vmckbAuT9ntGqUgpp14CFpnOcSQhXYekWOrOfsZ12
         3a5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793544427; x=1794149227;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=FazxrWHX2Tn7PurYTqREXzQh0pHc6RTMEU3g/b7/CQI=;
        b=XOCw1z+aQyN5UO4dR2bSakaCgXT5nzMCjIhxeh7ZxnMhsKLEMM+etY35RTK3YFS4wp
         Trc2voobuTSisH+h9SHYY2HZsrNU0Y7ZSbFDAPaNLJ/C7xBOgHatbd6apViQo25jOjOh
         eu+8GowP9JzM/Zg0J3aRIVtCN16Ujz2bSs82JhIgd8jGWZk7XQIFcwLYJtd5UWZlHdhT
         KjdBsd57Dh9+wbbwDvfWIqFsUkogS2xEPolJG+67V4qtZQnsaku1JNYk/qTg2kuxHVQH
         8ELHVgmfpouaTbS6uvocIrpzC4BietiquCjKR7NthcqqDPOLuLAkbs+jvtbmvHb1+c9R
         NEsQ==
X-Gm-Message-State: APuU4Z/1OOfvv8UzraxM7B6C7En+9zb0WC66mkdXr2FZxc1YE4QyiGb4
	jUdnLG+TVw6yF1ciF4ESc667TxMzDEYl/LxIVl4OYcvgMSiom7icK80D3kI0PA==
X-Gm-Gg: AYBFou0ryqwts6xv/zWrhbCdis3H1YqlARXcMk5xcLY6MRyMVvysCFrlQcue1HJr6iW
	0jWHPXNa0b8f3j4nU3vVwZUazrrvbUTx+wvgpkwcTgkJ0m7X74xW/DBSp2xXXb+NkNrssMHyLy1
	DV5xKYFdHbLGJBNuuKWFSGBAYFjBM7QJwYoM0J9/MUtZ7gfU+4fA9vzwxiceGkY7V7XMsXGahzL
	07KvulETIJUlkQsqEXxtLHlqTEMYljhb37JtHvW2wD+aUXkofhPpapH4cZz7g0aG5VeCLj10RQh
	PrKZZ/4JgWMIRg8NOq4zAy5yy00Cq3LFbTnZm+u9wpedsAO9xdqJcrW6do+VgnI5mh9dcBS1Hcu
	X4nfzyvlm46WFAAqgJucUkzoqlLvwTLzWF69Z/K/F/GNKcHwUVQsOOuE4wOde4tDiguv/isEFod
	xjYB84flqm7z+IomiwPoHXsgJ6OCXbYIrGbULP0lrJ+PbKWw+lRBFrFB6sWY1BE+g8CyZ4Wo4BF
	kGJ6nvo7wpBJXekkdUaU0mxwxek4w/yywdkJ1+eWtzbvkHxQhAOSDhyQIpNLntY4cTZ0qJtDyBe
	ricm6AKnzBBDOvY/qsqFWOQqn3isFAVPeWc9Ptzh283LelDjBLEC/kg=
X-Received: by 2002:a05:7301:4b10:b0:35c:85fa:5a61 with SMTP id 5a478bee46e88-36a424940d9mr12002995eec.38.1793544426610;
        Sun, 01 Nov 2026 06:47:06 -0800 (PST)
Received: from pve-server.rlab ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a42a6f7f9sm32747545eec.25.2026.11.01.06.47.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2026 06:47:05 -0800 (PST)
From: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>,
	Venkat Rao Bagalkote <venkat88@linux.ibm.com>,
	linux-kernel@vger.kernel.org,
	chleroy@kernel.org,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	kvm@vger.kernel.org,
	Anushree Mathur <anushree.mathur@linux.ibm.com>,
	Harsh Prateek Bora <harshpb@linux.ibm.com>,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Subject: [PATCHv2 4/7] KVM: PPC: Book3S HV nestedv2: cap max vcpus to PAPR limit
Date: Sun,  1 Nov 2026 20:16:29 +0530
Message-Id: <07e2642826613998b6b1ecd7acd239fbdbaba110.1793543627.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <cover.1793543627.git.ritesh.list@gmail.com>
References: <cover.1793543627.git.ritesh.list@gmail.com>
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

Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 arch/powerpc/include/asm/kvm_host.h | 1 +
 arch/powerpc/kvm/powerpc.c          | 6 ++++++
 2 files changed, 7 insertions(+)

diff --git a/arch/powerpc/include/asm/kvm_host.h b/arch/powerpc/include/asm/kvm_host.h
index 708a32f89776..c068cc1dd51f 100644
--- a/arch/powerpc/include/asm/kvm_host.h
+++ b/arch/powerpc/include/asm/kvm_host.h
@@ -35,6 +35,7 @@
 
 #define KVM_MAX_VCPUS		NR_CPUS
 #define KVM_MAX_VCORES		NR_CPUS
+#define KVM_MAX_VCPU_IDS_NESTEDv2	2048	/* PAPR H_GUEST_CREATE_VCPU vcpuId */
 
 #include <asm/cputhreads.h>
 
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


