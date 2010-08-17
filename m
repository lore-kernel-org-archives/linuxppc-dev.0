Return-Path: <agraf@suse.de>
Received: from mx1.suse.de (cantor.suse.de [195.135.220.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx1.suse.de", Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 87F42B7249
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 17 Aug 2010 23:58:13 +1000 (EST)
From: Alexander Graf <agraf@suse.de>
To: kvm-ppc@vger.kernel.org
Subject: [PATCH 21/26] KVM: PPC: Force enable nap on KVM
Date: Tue, 17 Aug 2010 15:57:56 +0200
Message-Id: <1282053481-18787-22-git-send-email-agraf@suse.de>
In-Reply-To: <1282053481-18787-1-git-send-email-agraf@suse.de>
References: <1282053481-18787-1-git-send-email-agraf@suse.de>
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
	KVM list <kvm@vger.kernel.org>
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
