Return-Path: <agraf@suse.de>
Received: from mx1.suse.de (cantor.suse.de [195.135.220.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx1.suse.de", Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 205DDB7230
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 17 Aug 2010 23:58:13 +1000 (EST)
From: Alexander Graf <agraf@suse.de>
To: kvm-ppc@vger.kernel.org
Subject: [PATCH 14/26] KVM: PPC: Move BAT handling code into spr handler
Date: Tue, 17 Aug 2010 15:57:49 +0200
Message-Id: <1282053481-18787-15-git-send-email-agraf@suse.de>
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

The current approach duplicates the spr->bat finding logic and makes it harder
to reuse the actually used variables. So let's move everything down to the spr
handler.

Signed-off-by: Alexander Graf <agraf@suse.de>
---
 arch/powerpc/kvm/book3s_emulate.c |   48 ++++++++++++------------------------
 1 files changed, 16 insertions(+), 32 deletions(-)

diff --git a/arch/powerpc/kvm/book3s_emulate.c b/arch/powerpc/kvm/book3s_emulate.c
index f333cb4..4668465 100644
--- a/arch/powerpc/kvm/book3s_emulate.c
+++ b/arch/powerpc/kvm/book3s_emulate.c
@@ -264,7 +264,7 @@ void kvmppc_set_bat(struct kvm_vcpu *vcpu, struct kvmppc_bat *bat, bool upper,
 	}
 }
 
-static u32 kvmppc_read_bat(struct kvm_vcpu *vcpu, int sprn)
+static struct kvmppc_bat *kvmppc_find_bat(struct kvm_vcpu *vcpu, int sprn)
 {
 	struct kvmppc_vcpu_book3s *vcpu_book3s = to_book3s(vcpu);
 	struct kvmppc_bat *bat;
@@ -286,35 +286,7 @@ static u32 kvmppc_read_bat(struct kvm_vcpu *vcpu, int sprn)
 		BUG();
 	}
 
-	if (sprn % 2)
-		return bat->raw >> 32;
-	else
-		return bat->raw;
-}
-
-static void kvmppc_write_bat(struct kvm_vcpu *vcpu, int sprn, u32 val)
-{
-	struct kvmppc_vcpu_book3s *vcpu_book3s = to_book3s(vcpu);
-	struct kvmppc_bat *bat;
-
-	switch (sprn) {
-	case SPRN_IBAT0U ... SPRN_IBAT3L:
-		bat = &vcpu_book3s->ibat[(sprn - SPRN_IBAT0U) / 2];
-		break;
-	case SPRN_IBAT4U ... SPRN_IBAT7L:
-		bat = &vcpu_book3s->ibat[4 + ((sprn - SPRN_IBAT4U) / 2)];
-		break;
-	case SPRN_DBAT0U ... SPRN_DBAT3L:
-		bat = &vcpu_book3s->dbat[(sprn - SPRN_DBAT0U) / 2];
-		break;
-	case SPRN_DBAT4U ... SPRN_DBAT7L:
-		bat = &vcpu_book3s->dbat[4 + ((sprn - SPRN_DBAT4U) / 2)];
-		break;
-	default:
-		BUG();
-	}
-
-	kvmppc_set_bat(vcpu, bat, !(sprn % 2), val);
+	return bat;
 }
 
 int kvmppc_core_emulate_mtspr(struct kvm_vcpu *vcpu, int sprn, int rs)
@@ -339,12 +311,16 @@ int kvmppc_core_emulate_mtspr(struct kvm_vcpu *vcpu, int sprn, int rs)
 	case SPRN_IBAT4U ... SPRN_IBAT7L:
 	case SPRN_DBAT0U ... SPRN_DBAT3L:
 	case SPRN_DBAT4U ... SPRN_DBAT7L:
-		kvmppc_write_bat(vcpu, sprn, (u32)spr_val);
+	{
+		struct kvmppc_bat *bat = kvmppc_find_bat(vcpu, sprn);
+
+		kvmppc_set_bat(vcpu, bat, !(sprn % 2), (u32)spr_val);
 		/* BAT writes happen so rarely that we're ok to flush
 		 * everything here */
 		kvmppc_mmu_pte_flush(vcpu, 0, 0);
 		kvmppc_mmu_flush_segments(vcpu);
 		break;
+	}
 	case SPRN_HID0:
 		to_book3s(vcpu)->hid[0] = spr_val;
 		break;
@@ -434,8 +410,16 @@ int kvmppc_core_emulate_mfspr(struct kvm_vcpu *vcpu, int sprn, int rt)
 	case SPRN_IBAT4U ... SPRN_IBAT7L:
 	case SPRN_DBAT0U ... SPRN_DBAT3L:
 	case SPRN_DBAT4U ... SPRN_DBAT7L:
-		kvmppc_set_gpr(vcpu, rt, kvmppc_read_bat(vcpu, sprn));
+	{
+		struct kvmppc_bat *bat = kvmppc_find_bat(vcpu, sprn);
+
+		if (sprn % 2)
+			kvmppc_set_gpr(vcpu, rt, bat->raw >> 32);
+		else
+			kvmppc_set_gpr(vcpu, rt, bat->raw);
+
 		break;
+	}
 	case SPRN_SDR1:
 		kvmppc_set_gpr(vcpu, rt, to_book3s(vcpu)->sdr1);
 		break;
-- 
1.6.0.2
