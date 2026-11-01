Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3129E606A336
	for <linuxppc-dev@archiver.kernel.org>; Sun,  1 Nov 2026 15:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=wL/Y4vHv
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jHdyy1SXMz30Tf;
	Mon, 02 Nov 2026 02:28:42 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1231"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793546922;
	cv=none; b=EIVcKujD9wUA1X8nHbZIEK8XqUmVfIrHDq6XfMZJke4P+f+duFD4pgqXgenp0oJaReIwKWUSfx13q3AGWkRyST2ycnQnI963t8Sni7axq8oxfAh7C5iArw8NC2Lf/JmFbulwz4u2udtWz9lHhAHHbtDLHofnbagtuAJ1oD5ww2veN86LEgKtIJAu3VLyHlxTvgxLHo08VyTlc+mLowme3+g+PiXe+x6dBz1Q9GvzkkKygOxlbX5BlCI2WKQ0aulvuP5guDy2TtUt5h1Iy6Rp26S7v8uNehgY3e3PHst8RVcCL4zPccnc/4oCtAvqa0aBwGTPLiJYl2WlApnYNPIYkw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793546922; c=relaxed/relaxed;
	bh=FazxrWHX2Tn7PurYTqREXzQh0pHc6RTMEU3g/b7/CQI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Y3qAKr4nmDQnlvcGAmlfpBTZkGjOwMBWwtUjC7UrQVSXZDhN1uMx2bUdXTtldp0oaAqb0w3bMq1Z3XK5NgE/k8bu2dQtE+3TQT03cB9lKj00goX3l3Q1sPr4BDOLJETVgrpeKUNUo1gYO8KnyK5OhPmzL1LGKl0qCJ6CFEEe9xcDU9LJPiPH7jaSobKrnu052+mHiw4AMVFkf+R16M9QcSX/H8lMo6/SL6/v4tAu+m4A8SWZc2JdufFcEnXzo8pPhRL28eNS+BtUsz5wpzwDsxddH+ZjCkksyeex8ztebFJFikUKu6GhGKuoyEhUyS6a08pApQcAcRxNqdr/rZBN1A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=wL/Y4vHv; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1231; helo=mail-dl1-x1231.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=wL/Y4vHv;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1231; helo=mail-dl1-x1231.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-dl1-x1231.google.com (mail-dl1-x1231.google.com [IPv6:2607:f8b0:4864:20::1231])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jHdyx3y3qz2yST
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 02 Nov 2026 02:28:41 +1100 (AEDT)
Received: by mail-dl1-x1231.google.com with SMTP id a92af1059eb24-1adbf62dd31so2180278c88.0
        for <linuxppc-dev@lists.ozlabs.org>; Sun, 01 Nov 2026 07:28:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793546919; x=1794151719; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FazxrWHX2Tn7PurYTqREXzQh0pHc6RTMEU3g/b7/CQI=;
        b=wL/Y4vHvrBl7yDV+SjhQV9itYjqJN94G9xYnGujkngbftYcIQbt6Ai+0Ge70O08aLO
         4np1FMOCyh43OXNRZjtgwsnzuRKui1k4X6A5CEpLk1tk/PTCdXBEhKxqLwQH+ClQgU8X
         6cpqvdmWOlgg8XN1woWLFRR/aDxaL1fzuP/a4A3AmTsqVV1nUE2rdy/h78C3i5lxiE3Z
         KDGlXripAQEpAhas4O+yfmnJXupsE6qJvOr8uJX64H7hCS0LjaAXU2QmM6wvKcanShDT
         BdYl1/tTF5lavlnLuUT3Av8I/DN3q8Mt2sjpNNJ+ZJGIvE/LtS0YzIB4EAwhRhN6qEDR
         D0Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793546919; x=1794151719;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=FazxrWHX2Tn7PurYTqREXzQh0pHc6RTMEU3g/b7/CQI=;
        b=nwRw/0GSbqmt9c9taKpn1TxOYGlhRgJmylqEmdLgZ/NAmdoR8cocUkdGr747zylnJf
         HpflUJ5TydvlTrIYCWJZwbllRlLe03wqSg/0QDxxnBA9YxesJpHvqz4vNfKnOZyxoXcb
         tPfy+0mKY6pcne5Cf7nsb6DpuImK3s4jhl9ip/jboLN1tBbPgf7nPU1BASLAFlL/urnb
         RRdGaOHyXSIRO+T5m+y97wz5JR34ZsRbLJe8WZBfqkdrU1uGfSFEq3055HuuGSYKL4Ji
         wxm19bXCfBrtwYbtSVsX6CwFQwZqs0aBX6WhzLszwc6NmjHWOFsX+T37SsgqU3NnaT0E
         g8kw==
X-Gm-Message-State: AFq9FYKiirwPFYhmh3xit380LMdsFg5uByy+5pfDHnBvL1t7SNxZOl4S
	zP+AO/8+khBo8iPKnUkUouQeWD+EaKQ/T8C0UykaIxlZIaBkrR33Cja8f1fiGA==
X-Gm-Gg: AYBFou1hTL4g/gPD6OOuxpHtoC05ItUvlTg+LS5RywIp3PQgmIdQ2BQ73YMUr7K/mxG
	crGyokZ7mSfo08p+e69T7p01KgxyJDC9M3DRUcoSddugnOWqp+rM++OMAK/2Sy92SIsg0q1CRRe
	EBCvSZyrFJ1QBLbwgOa7V4iYOMFjKD/0/yJbpWJAAgVqmu8LLtcYslnMaS5JJcO9aIP6boSLz6n
	Ob9tmVOnerm2gJifr6pTWre/NYl5ptdyQpFjtiwnB1vAGNyl1Kn1XCWbX79RKgotg4h/rGAn/WC
	d9xklI01Rla6Rrn0HmQ5BJro74TSU7PgTM1ZsDyhADeWaSZw+FKEHLLKW3DfXq9313Qz2+b9JPG
	3yC7Y6PhhZ9cDCwoL507o+jKFCGABz0PFY9SYGjLtpaOqk66UpPidnQd4sCD1DODRc9+4JEVfHC
	4k4Uqqq5f24qmeJPcY50SNDN042Eu7X3cnOdf5fAROmyLZegGAjQwLYnOT66J6IauIA/U3Gr6WZ
	O40uWxegLlHpMcUBXNlT6pnP7v81pr68yPu6EHPz1MZc+SjVQIYxccNcpvOalWzDubTWJNTZrIn
	WyqZPr0mZ0opyOSxVnwxBHaP5xYAPHqT3q0=
X-Received: by 2002:a05:701b:4193:10b0:15a:4155:3d9d with SMTP id a92af1059eb24-1ac5da76f61mr11637801c88.31.1793546919481;
        Sun, 01 Nov 2026 07:28:39 -0800 (PST)
Received: from pve-server.rlab ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1ac18458e07sm24862665c88.8.2026.11.01.07.28.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2026 07:28:38 -0800 (PST)
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
Subject: [PATCHv3 4/7] KVM: PPC: Book3S HV nestedv2: cap max vcpus to PAPR limit
Date: Sun,  1 Nov 2026 20:58:09 +0530
Message-Id: <f9c26aefa325bb4b6a3222718d6d605aa4993dff.1793546707.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <cover.1793546707.git.ritesh.list@gmail.com>
References: <cover.1793546707.git.ritesh.list@gmail.com>
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


