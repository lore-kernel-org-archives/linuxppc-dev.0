Return-Path: <agraf@suse.de>
Received: from mx1.suse.de (cantor.suse.de [195.135.220.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx1.suse.de", Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 71FAD1007D1
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 21 Jun 2010 23:25:02 +1000 (EST)
From: Alexander Graf <agraf@suse.de>
To: kvm-ppc@vger.kernel.org
Subject: [PATCH] KVM: PPC: Make BAT only guest segments work
Date: Mon, 21 Jun 2010 15:24:55 +0200
Message-Id: <1277126695-32081-1-git-send-email-agraf@suse.de>
Cc: linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

When a guest sets its SR entry to invalid, we may still find a
corresponding entry in a BAT. So we need to make sure we're not
faulting on invalid SR entries, but instead just claim them to be
BAT resolved.

This resolves breakage experienced when using libogc based guests.

Signed-off-by: Alexander Graf <agraf@suse.de>
---
 arch/powerpc/kvm/book3s_32_mmu.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/kvm/book3s_32_mmu.c b/arch/powerpc/kvm/book3s_32_mmu.c
index 0b10503..3292d76 100644
--- a/arch/powerpc/kvm/book3s_32_mmu.c
+++ b/arch/powerpc/kvm/book3s_32_mmu.c
@@ -354,10 +354,10 @@ static int kvmppc_mmu_book3s_32_esid_to_vsid(struct kvm_vcpu *vcpu, ulong esid,
 		*vsid = VSID_REAL_DR | gvsid;
 		break;
 	case MSR_DR|MSR_IR:
-		if (!sr->valid)
-			return -1;
-
-		*vsid = sr->vsid;
+		if (sr->valid)
+			*vsid = sr->vsid;
+		else
+			*vsid = VSID_BAT | gvsid;
 		break;
 	default:
 		BUG();
-- 
1.6.0.2
