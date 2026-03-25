Return-Path: <linuxppc-dev+bounces-18776-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E76F1106B52D
	for <linuxppc-dev@archiver.kernel.org>; Wed, 25 Mar 2026 12:54:16 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fgn0l4pgnz2xcB;
	Wed, 25 Mar 2026 23:54:15 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=198.175.65.18
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774430569;
	cv=none; b=aw2NMV8h0Jt4WWBXx1S8CIcTlYp+vKzqIReh0/ld+5mt8ABiIkmrF3gQK0PyuKW2nIuS0ExhNcSc8B/vq88LVYi6EkAIWrdGpn+qGDRfAHfaRgecCJYN2T2/U7oqRzeYl8gmPXr4hISW6Pk414xID/F3Ck4bMZz7o0IHXqshxl6RRoEi9mjXnmRl6vvhicOGUGP0VxUkGwv0GenBc4ylz1zOzOhBNUgzldSb+ALnAd6/oJBrE+BaikzgGQmGKjlBIZQNEDjnC2ExsROc6J1wCLHXSK7AciYlNHa7Odf2HSr5jqFxK1yQ43B07Fz5gQBDWiM/3FfPnp5CnAKptrzK6A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774430569; c=relaxed/relaxed;
	bh=TEPNRJHcwW8MthLeWh05Ocwv0EyoU1X4S59sZJKRYWY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dFc6J4UwUQILS7RNtMpdQlkATM1F46nKYXu2zjrK1RSClF0+hn4+gDTKz4D4G5UWpXm0gkkVbBuiDA91JMO0Sf2rK+HaTzWJ6WU91Y5Z51teTymXPshUwKbr7NLd0vLsGFOtLRqSmO8QFZs3mpctjQzVrUFMnd1uQEIeHT5o1pYK/ogHC1dkRlv0RLIAUDZ76Q4peVSPHvO/V56EcwOn40QU+f+Gr5yz2oxnEqaQWQKz3gpU91R1CRZng9ZuHuJfQx/uOgpH2VLKD8Objg67hyypooD2GKftA+LAm3Ny1GB4O7FTcczYK5LocRGm+ss6/bHT1T38iTFLN3CXmOMDDg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=iEBCVdag; dkim-atps=neutral; spf=pass (client-ip=198.175.65.18; helo=mgamail.intel.com; envelope-from=peter.fang@intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=iEBCVdag;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=intel.com (client-ip=198.175.65.18; helo=mgamail.intel.com; envelope-from=peter.fang@intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fghJl0MDQz2xMt
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Mar 2026 20:22:45 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774430568; x=1805966568;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=YvJCLeYzS5c4wGvH6ty0BM9THyyLKkk8rn2stjariRI=;
  b=iEBCVdagLwOwePk5nL5VP5J8J0cLxM4Sl+U4ctgOxk7VKS5PxHVi2S7C
   vR5XnDNzJc61AB7+CMScJKh+5ndHncIwP4VKdCzM78gjG3Fk/6w3mmKDV
   X2hLqCFaqPtSwUHU7mSQEaOLn5pttm0/ywYFXd1OX81fllzPhOeeBcTDb
   Plqc4L/JgBgO5fNXZzZnzqQnrOb5u4vnEdgfy69/vZwwPgZAt1Y7YPjq2
   ycBEkBNVjT4QNb5kmYpG4HIwUdLC2CiOIRdePlNjwneJSsCYDDnvsQQ5/
   lsts1Yny2BxD5NzgMNnQELCm7PMr2g8eAfByY4bl+/gc68qFlj/dXoAij
   w==;
X-CSE-ConnectionGUID: lZSNxPPKRMSN39nkbge1Zw==
X-CSE-MsgGUID: l366WWe4R0injBYkjbXYDQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11739"; a="75485072"
X-IronPort-AV: E=Sophos;i="6.23,139,1770624000"; 
   d="scan'208";a="75485072"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2026 02:22:43 -0700
X-CSE-ConnectionGUID: CBHXsM8bQGGn+mPoUgQuJQ==
X-CSE-MsgGUID: yiKoLH6QSgqivBCc9U9b3A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,139,1770624000"; 
   d="scan'208";a="223827898"
Received: from scvirtpf.sc.intel.com (HELO pedri.otc) ([10.144.232.27])
  by orviesa010.jf.intel.com with ESMTP; 25 Mar 2026 02:22:42 -0700
From: Peter Fang <peter.fang@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
	Sean Christopherson <seanjc@google.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Nicholas Piggin <npiggin@gmail.com>
Cc: kvm@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	Peter Fang <peter.fang@intel.com>,
	KarimAllah Ahmed <karahmed@amazon.de>,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Subject: [PATCH] KVM: Fix kvm_vcpu_map[_readonly]() function prototypes
Date: Wed, 25 Mar 2026 02:15:11 -0700
Message-ID: <20260325092001.613025-1-peter.fang@intel.com>
X-Mailer: git-send-email 2.52.0
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

kvm_vcpu_map() and kvm_vcpu_map_readonly() should take a gfn instead of
a gpa. This appears to be a result of the original kvm_vcpu_map() being
declared with the wrong function prototype in kvm_host.h, even though
it was correct in the actual implementation in kvm_main.c.

No actual harm has been done yet as all of the call sites are correctly
passing in a gfn. Plus, both gfn_t and gpa_t are typedef'd to u64 so
this change shouldn't have any functional impact.

Compile-tested on x86 and ppc, which are the current users of these
interfaces.

Fixes: e45adf665a53 ("KVM: Introduce a new guest mapping API")
Cc: KarimAllah Ahmed <karahmed@amazon.de>
Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Signed-off-by: Peter Fang <peter.fang@intel.com>
---
 include/linux/kvm_host.h | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index 6b76e7a6f4c2..4e3bea92a06b 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -1382,20 +1382,20 @@ void mark_page_dirty_in_slot(struct kvm *kvm, const struct kvm_memory_slot *mems
 void mark_page_dirty(struct kvm *kvm, gfn_t gfn);
 void kvm_vcpu_mark_page_dirty(struct kvm_vcpu *vcpu, gfn_t gfn);
 
-int __kvm_vcpu_map(struct kvm_vcpu *vcpu, gpa_t gpa, struct kvm_host_map *map,
+int __kvm_vcpu_map(struct kvm_vcpu *vcpu, gfn_t gfn, struct kvm_host_map *map,
 		   bool writable);
 void kvm_vcpu_unmap(struct kvm_vcpu *vcpu, struct kvm_host_map *map);
 
-static inline int kvm_vcpu_map(struct kvm_vcpu *vcpu, gpa_t gpa,
+static inline int kvm_vcpu_map(struct kvm_vcpu *vcpu, gfn_t gfn,
 			       struct kvm_host_map *map)
 {
-	return __kvm_vcpu_map(vcpu, gpa, map, true);
+	return __kvm_vcpu_map(vcpu, gfn, map, true);
 }
 
-static inline int kvm_vcpu_map_readonly(struct kvm_vcpu *vcpu, gpa_t gpa,
+static inline int kvm_vcpu_map_readonly(struct kvm_vcpu *vcpu, gfn_t gfn,
 					struct kvm_host_map *map)
 {
-	return __kvm_vcpu_map(vcpu, gpa, map, false);
+	return __kvm_vcpu_map(vcpu, gfn, map, false);
 }
 
 static inline void kvm_vcpu_map_mark_dirty(struct kvm_vcpu *vcpu,

base-commit: d2ea4ff1ce50787a98a3900b3fb1636f3620b7cf
-- 
2.52.0


