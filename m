Return-Path: <linuxppc-dev+bounces-28900-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E4EACA5FE2
	for <linuxppc-dev@archiver.kernel.org>; Mon,  5 Oct 2026 03:48:07 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hylhw2qxdz2ylm;
	Mon, 05 Oct 2026 14:48:00 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::132e"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1791172080;
	cv=none; b=KwFVZDGzL8UeUy8newvxvu7yBK93wBIB2dhHPz9UbOb7cnbpQ/P6ISBq1syFi7Os+6Yvfiu0fQXOoGQujSpZnebuqf1MOUYHzV1gZzuF4IM7Rk8s13KroxhNXfvnIpnNEaa7bVdqpBiq8Edv5lFUJXmJnrgwRAUHTmF2unj+Nw83arLE44vrzZwtvw3CFXrgbFnKCOdP2Dt6crJXjOTjHBmw+yYTZnsQMpZHUxv1DFrohDxJuCjyvOaDOjx5FM62lHv7vJoRMM+w9+z2WumikuWCk5GHHI0slgxq30Do8n34KPGR+NwCJIEz7ZUOFV4ceIIFIZ9QHho6pjw3le/eFA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1791172080; c=relaxed/relaxed;
	bh=h1SCblXYMeeDfQwJe65yiAdl+ST+ro3b/dUm5JimbFA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EYPNTQSPWrwN11+s1PN5WmasdZdCGbcBCHWw3ra8UgIRSfw5Pyx6hHrh61MQJUjomq9xrBrKBpABzWIXuYyGQ1ALHgwCtdz0i1xUxiggY5rT7XE+XEyJJAu6MPOm1hSPfsiBzdXzajoe2OKLA5F9T/bTnNp+CxYTx4iWUrZixQHKJkkHDID1h+t6qByfsoLRrkYk89GBHJQhVPO8auFQWluTNlSgNxJ0gggYrdhNHCNaPTYNtlNRmVmoWjZXRVBrG5Ef2oERLLsHP+7vWQTdL+f/lnyV4ZDv4rO809T2pSFdVCqtj9KyNprg0PIEYE3939ubVjbaBHks/IOE//2lBg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=IWRNxMWe; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::132e; helo=mail-dy1-x132e.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=IWRNxMWe;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::132e; helo=mail-dy1-x132e.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-dy1-x132e.google.com (mail-dy1-x132e.google.com [IPv6:2607:f8b0:4864:20::132e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hylhv5fNQz2yjw
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 05 Oct 2026 14:47:59 +1100 (AEDT)
Received: by mail-dy1-x132e.google.com with SMTP id 5a478bee46e88-3282db206d3so4827140eec.0
        for <linuxppc-dev@lists.ozlabs.org>; Sun, 04 Oct 2026 20:47:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791172078; x=1791776878; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=h1SCblXYMeeDfQwJe65yiAdl+ST+ro3b/dUm5JimbFA=;
        b=IWRNxMWeoy/9ZMJiWW+q/6IE2p/WL+dII8kFS23rVAAgav7GbJJazDM4x5bgFixY+G
         TNF7ytj7uxSdhKcOfFJ7W0vVEzzTKAipPMxmjOtM66JifuVBjmAAhR7hzJAZ/WvQ8zPI
         VPiQM8PCpDwQe113TJkVp4zfr6pefh9F/JNkgD46/aGgSSebdPSnxQtuSF73NpO2ED0e
         cEo28WCC7ADprSGwAwIIVHrA9D9qKSmh2mrqNulPSLSkRBpJExnPFYR9Lh1BRHVF1aEl
         ODImx2F6LhO6hTgvMLlZYypBPSn0IDB4EZpBHBurnxAGxTSfbFCM3HTv0Iurl29j02Ax
         xp6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791172078; x=1791776878;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=h1SCblXYMeeDfQwJe65yiAdl+ST+ro3b/dUm5JimbFA=;
        b=Q1Cy4vgFqnkOiknK5Xvz/UwnfnXD3SGIJ+asv/BACfapbRr4eRBUfBmecHhtBthjtz
         u/66cpMkx0Wt/2wb6VI6/lR2fILeGwaUculGcyfLM43dGzmAWfAzdl9HkO0IsMm8hXlU
         GGSMaknZi+SNtP4SCIv6yFBvoa5L3VQRy0jNgEvQBkTfh/ahmzSjx797Vw864XIXg6JT
         zmzvBML4NF1aUOxSjTMQkEMc3zQsFmeftUIsAFqsQT306u3JgY9KANt1QTTDDne3HN3x
         Jw4w5qZqMwYg6b/osT3HMJ2cP8LDiifvjqbkbPDRCd8jE5CVsHYoLgaQWw4vBCovfcYg
         7fTg==
X-Forwarded-Encrypted: i=1; AKwUvBygyxtVqrHZeqBm4jELADdbOIOt0Ych4dqhI1WsFrSf7VqZrUxtOx5LFtUIOiM4D17b67OB9kqAWr7RpMs=@lists.ozlabs.org
X-Gm-Message-State: AFuF++kXK9nPSJmdU2bzwj/HswmVKt77g9wBr5dpvSYXaBAtnP+5dFP5
	KMnepiShRw7MAb8JMPxX2JBfGaGCmLUGAKCQJDhKrgXrUJMQMaQGUwCF
X-Gm-Gg: AYBFou0nIw53G75GuCTnyz8R7KFWABEBe3eUXpcbFfV8jZV8wrclk/QQHYIHwR7p7Mn
	Yo62O/E8oc1PcSZKcX4oO5zM4Eqy1EwB/lDfPBo646TXH6vxPWJZDiZuElLrXvIeINoZEbaO2eL
	5lWktsGbV885Iamw0+VgvhrK606ZdgPsxWLZJ54jU92xnrq6FXg+Vdss4GQA2YEIlhMF7wzfOrD
	BHqGqr7iD4e94cMbrdeXQJXSi7M1M4vcmNdDac8VOCE+FNtbx6Sz3OMpXG7a5hawHh9l8blS5Za
	Oi3+DRpCtEXC+hc59xZkUxtEA6FCdSNfGl6UmkiYV0BA4lsGyMhEJby59F9RIWny+lHZrNYpBPW
	SVCYaAg8QRD0N7nEfQC1uEen0lGpz5kAMlfhND2m9Jrpiesxr/itaT8/CdE/p6GIkTqpkygx+hR
	/N9g9xiPoSK4McH8AKhdG71HqfCUVLBFbKCVMDs2+E3M+RmiNQE28lKJ5dleNqcVVyspMvxblFD
	N2Q1GrcuhXtaDMNdR69g9cfyhVORi7ff4ypsQFirBsT6BH1zSFZkXzGqMQpWbj4+YepXufn
X-Received: by 2002:a05:7300:8282:b0:340:9d9f:a5c with SMTP id 5a478bee46e88-351117064b9mr9289417eec.36.1791172077441;
        Sun, 04 Oct 2026 20:47:57 -0700 (PDT)
Received: from pve-server.rlab ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3512718a18esm10840958eec.17.2026.10.04.20.47.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Oct 2026 20:47:56 -0700 (PDT)
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
Subject: [PATCH v6 3/5] KVM: PPC: selftests: Add helper for checking if running nested
Date: Mon,  5 Oct 2026 09:17:26 +0530
Message-Id: <2f57ae5266c12f34cb12d68c65abb643d2065ef4.1791014924.git.ritesh.list@gmail.com>
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

access_tracking_perf_test needs detection if we are running nested guests.
This adds the needed helper.

Tested-by: Anushree Mathur <anushree.mathur@linux.ibm.com>
Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 tools/testing/selftests/kvm/include/powerpc/processor.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/tools/testing/selftests/kvm/include/powerpc/processor.h b/tools/testing/selftests/kvm/include/powerpc/processor.h
index f0ee21a8e2d4..a46f6828991c 100644
--- a/tools/testing/selftests/kvm/include/powerpc/processor.h
+++ b/tools/testing/selftests/kvm/include/powerpc/processor.h
@@ -6,6 +6,8 @@
 #define SELFTEST_KVM_PROCESSOR_H
 
 #include <linux/compiler.h>
+#include <unistd.h>
+
 #include "ppc_asm.h"
 #include "kvm_util_types.h"
 
@@ -36,4 +38,9 @@ static inline void cpu_relax(void)
 	asm volatile("" ::: "memory");
 }
 
+static inline bool is_pseries_lpar(void)
+{
+	return !access("/proc/device-tree/rtas/ibm,hypertas-functions", F_OK);
+}
+
 #endif
-- 
2.39.5


