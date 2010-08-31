Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
	by ozlabs.org (Postfix) with ESMTP id AA8C7B710B
	for <linuxppc-dev@ozlabs.org>; Tue, 31 Aug 2010 12:32:20 +1000 (EST)
From: Alexander Graf <agraf@suse.de>
To: kvm-ppc@vger.kernel.org
Subject: [PATCH 21/35] KVM: PPC: Force enable nap on KVM
Date: Tue, 31 Aug 2010 04:32:02 +0200
Message-Id: <1283221937-21006-22-git-send-email-agraf@suse.de>
In-Reply-To: <1283221937-21006-1-git-send-email-agraf@suse.de>
References: <1283221937-21006-1-git-send-email-agraf@suse.de>
Cc: Linuxppc-dev <linuxppc-dev@ozlabs.org>, KVM list <kvm@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

There are some heuristics in the PPC power management code that try to find
out if the particular hardware we're running on supports proper power management
or just hangs the machine when going into nap mode.

Since we know that KVM is safe with nap, let's force enable it in the PV code
once we're certain that we are on a KVM VM.

Signed-off-by: Alexander Graf <agraf@suse.de>
---
 arch/powerpc/kernel/kvm.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/kernel/kvm.c b/arch/powerpc/kernel/kvm.c
index 517da39..95aed6b 100644
--- a/arch/powerpc/kernel/kvm.c
+++ b/arch/powerpc/kernel/kvm.c
@@ -583,6 +583,9 @@ static int __init kvm_guest_init(void)
 	if (kvm_para_has_feature(KVM_FEATURE_MAGIC_PAGE))
 		kvm_use_magic_page();
 
+	/* Enable napping */
+	powersave_nap = 1;
+
 free_tmp:
 	kvm_free_tmp();
 
-- 
1.6.0.2
