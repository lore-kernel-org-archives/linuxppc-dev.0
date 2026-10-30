Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA21F606B794
	for <linuxppc-dev@archiver.kernel.org>; Fri, 30 Oct 2026 21:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=b5nhez2p
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jGYts1lfRz3bfP;
	Sat, 31 Oct 2026 08:21:25 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1045"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793395285;
	cv=none; b=oyniDEDaVU155QNXPx2W+/7dDSAVdpz92UqX30un1vv5HbEV/TSlp5WWc/K8cJY6xG7jM5fJ6xWNy3V7utOsyYhMJ9OiaW6xHzi8SZnZpxLOAiL4XBa9ha+VuxGL2Il2472Y3nFvoW4pQhHfpOUMuYcNJka5tzLhYjMFkDSLI7WEDTfcx/47wI3yux4ABk5EjzQ38sms74w9uvaEzfjelBSPXQbBb0F1McsrWRZ5IersuSIeMdgggMKefN0pN2dwnvEuWyD+ngbTfSGNnjUj1N0Xsda2PEuFPMrzZynlgRbCS8jW/i58GkxCebr92OYKWiceNIvrnKgmvdkJ1WuKew==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793395285; c=relaxed/relaxed;
	bh=ffYJqqyy7PxUyTG9nWCiYNGOf2D1TYjdOFe2IcBzjU8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ZCYdRx4uR2bm5yJ1UbEjff4SBl2qnC4R0Ci69XQum+LAHj1jfxI/qlNwkX06hiUqEzUAGQfGW1En5NxyYJGbpS7R5IG61Sx43vxl/DPabQJjFMOAIYlws2O7HSstHbzF3d8R7mI1CJgGl7o2gMpGwQZngH3wWcWNuv3BOMmAMM/Mu4FQ7/yNnBbzwV0MSL0piQ44mwEbD95GtJgOcA+at0WQBJAcZ4h+YbTsikmBOWKpSSyfTBb200lqBb+TGuSj0y1CneAxE9316tUEHhMc5Kh9l8DwDxBQCa25orESZfHkStkX2elubTcAPglM/ceFgjH/0L91jv++wVnTchwx+g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=b5nhez2p; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1045; helo=mail-pj1-x1045.google.com; envelope-from=3ugrlagykdfkj51ea37ff7c5.3fdc9elogg3-45mc9jkj.fqc12j.fi7@flex--seanjc.bounces.google.com; receiver=lists.ozlabs.org) smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=b5nhez2p;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=flex--seanjc.bounces.google.com (client-ip=2607:f8b0:4864:20::1045; helo=mail-pj1-x1045.google.com; envelope-from=3ugrlagykdfkj51ea37ff7c5.3fdc9elogg3-45mc9jkj.fqc12j.fi7@flex--seanjc.bounces.google.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x1045.google.com (mail-pj1-x1045.google.com [IPv6:2607:f8b0:4864:20::1045])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jGYtr3cg5z3bjb
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 31 Oct 2026 08:21:24 +1100 (AEDT)
Received: by mail-pj1-x1045.google.com with SMTP id 98e67ed59e1d1-3ae1d132d52so1024152a91.0
        for <linuxppc-dev@lists.ozlabs.org>; Fri, 30 Oct 2026 14:21:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793395282; x=1794000082; darn=lists.ozlabs.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=ffYJqqyy7PxUyTG9nWCiYNGOf2D1TYjdOFe2IcBzjU8=;
        b=b5nhez2p+sA0f6qT+wr9GyeKaiR/9oKE4usZvfK1uh2FDwxekp5PfnDoriC7cN8/BB
         oXLxIwz+vJUIFnDsBUVWKhy+JFfxMCG+mewbVd343eHmOew3lOZ1Y+52q6FRiZ9RMTmM
         mbOfzyBkYaNs/UQmfXAX3Xhp16L+GS/qgqtXrKDCTM8Qw3MhARPWmJQhN6+VWF7pBV3A
         6beoE4afw3NHSMTkBc7zFO75160zuNwMpTxkVtChl8UzFjEcKrkD4uuY/dRKWUAG1eXQ
         DW2AVp0lv+N2kMASFpxeSycM1TmLAwVFHj0y7n5e4BRTiPMm1OjH6f1b3yGVYZhiYIco
         8Sjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793395282; x=1794000082;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ffYJqqyy7PxUyTG9nWCiYNGOf2D1TYjdOFe2IcBzjU8=;
        b=bhbgo6SKhuAsOa3/y2+s9mAe7UTSRsIbgnckmqikFa7Hc0RriLTaAZplI59qH3vCX3
         00ybOWo2ayBkIhKekonlPEyXTBx35Tl0SR0AYGAq/vop9HTyjLeN7ACphrdpN5Az9TTy
         Oxi2h82k/sEe/Wk2kZIOGcvwdfH7Imt5IGPyrL1rgyMLE5GklxYonZNJ1jwmLZzZECOK
         PZei9V/O/ozYNiSl7B92jWLmjahDBHCRrgIJcniaqPM0PjxXSdhCeIzpp0sf49SPxcno
         56pVILb2YCt6gdg4rwfPL83vbVSZeEFBEJeBDMMbQmx26yYcTQXnMpC2JmNvZyiUlS6E
         75ug==
X-Forwarded-Encrypted: i=1; AKwUvByimpRfNY5wJGZwVoi0PYfhrxaVpuWo5bseuT1/d63epfZh53cBFT+mPZTIP7ILVsdSNOb8Typn9GNIfd0=@lists.ozlabs.org
X-Gm-Message-State: AFq9FYLRtdQ9t/nireKMDPephJKigbPSsfo44Vgo5Kl6A4ck2TwsbUb0
	bNWgPsza1aLce2Wzif6zRczVO2qyrKnhPgSekKmltgUpFqJWd/lNSPUXW9ECST55/7TbtKdzXMJ
	53nE1DA==
X-Received: from pjbhl4.prod.google.com ([2002:a17:90b:1344:b0:3aa:dfda:ecdb])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:35c8:b0:3ac:9a5e:9ce7
 with SMTP id 98e67ed59e1d1-3ae897aa7aemr3117147a91.49.1793395282021; Fri, 30
 Oct 2026 14:21:22 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 30 Oct 2026 14:20:55 -0700
In-Reply-To: <20261030212112.2598640-1-seanjc@google.com>
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
Mime-Version: 1.0
References: <20261030212112.2598640-1-seanjc@google.com>
X-Mailer: git-send-email 2.56.0.385.gac671c819a-goog
Message-ID: <20261030212112.2598640-8-seanjc@google.com>
Subject: [PATCH v4 07/23] KVM: x86: Delete non-SMM internal memslot if
 creating SMM memslot fails
From: Sean Christopherson <seanjc@google.com>
To: Madhavan Srinivasan <maddy@linux.ibm.com>, Sean Christopherson <seanjc@google.com>, 
	Paolo Bonzini <pbonzini@redhat.com>
Cc: Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Jim Mattson <jmattson@google.com>, 
	James Houghton <jthoughton@google.com>, Chris Mason <mason@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-26.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

When installing a KVM-internal memslot, delete the non-SMM memslot if
creating the SMM memslot fails.  Leaving the non-SMM memslot in-place
makes it impossible for userspace to recover (not that any VMM tries), as
subsequent tries to install the internal memslot will fail with -EEXIST.

Fixes: 9da0e4d5ac96 ("KVM: x86: work on all available address spaces")
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/x86.c | 32 +++++++++++++++++++++++---------
 1 file changed, 23 insertions(+), 9 deletions(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 489631686ba6..326f8a9a5d18 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -10006,6 +10006,19 @@ int kvm_arch_init_vm(struct kvm *kvm, unsigned long type)
 	return ret;
 }
 
+static int x86_set_internal_memslot(struct kvm *kvm, int id, int as_id,
+				    gpa_t gpa, unsigned long hva, u32 size)
+{
+	struct kvm_userspace_memory_region2 m;
+
+	m.slot = id | (as_id << 16);
+	m.flags = 0;
+	m.guest_phys_addr = gpa;
+	m.userspace_addr = hva;
+	m.memory_size = size;
+	return kvm_set_internal_memslot(kvm, &m);
+}
+
 /**
  * __x86_set_memory_region: Setup KVM internal memory slot
  *
@@ -10062,16 +10075,17 @@ void __user * __x86_set_memory_region(struct kvm *kvm, int id, gpa_t gpa,
 	}
 
 	for (i = 0; i < kvm_arch_nr_memslot_as_ids(kvm); i++) {
-		struct kvm_userspace_memory_region2 m;
+		r = x86_set_internal_memslot(kvm, id, i, gpa, hva, size);
+		if (!r)
+			continue;
 
-		m.slot = id | (i << 16);
-		m.flags = 0;
-		m.guest_phys_addr = gpa;
-		m.userspace_addr = hva;
-		m.memory_size = size;
-		r = kvm_set_internal_memslot(kvm, &m);
-		if (r < 0)
-			return ERR_PTR_USR(r);
+		if (size) {
+			for (i--; i >= 0; i--)
+				x86_set_internal_memslot(kvm, id, i, gpa, 0, 0);
+
+			vm_munmap(hva, size);
+		}
+		return ERR_PTR_USR(r);
 	}
 
 	return (void __user *)hva;
-- 
2.56.0.385.gac671c819a-goog


