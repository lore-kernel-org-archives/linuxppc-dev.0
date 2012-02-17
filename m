Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mx2.suse.de", Issuer "CAcert Class 3 Root" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 3AAF2100806
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 18 Feb 2012 04:14:12 +1100 (EST)
From: Alexander Graf <agraf@suse.de>
To: kvm-ppc@vger.kernel.org
Subject: [PATCH 30/30] KVM: PPC: bookehv: add comment about shadow_msr
Date: Fri, 17 Feb 2012 18:13:57 +0100
Message-Id: <1329498837-11717-31-git-send-email-agraf@suse.de>
In-Reply-To: <1329498837-11717-1-git-send-email-agraf@suse.de>
References: <1329498837-11717-1-git-send-email-agraf@suse.de>
Cc: Scott Wood <scottwood@freescale.com>, linuxppc-dev@lists.ozlabs.org,
 kvm@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

For BookE HV the guest visible MSR is shared->msr and is identical to
the MSR that is in use while the guest is running, because we can't trap
reads from/to MSR.

So shadow_msr is unused there. Indicate that with a comment.

Signed-off-by: Alexander Graf <agraf@suse.de>
---
 arch/powerpc/include/asm/kvm_host.h |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/include/asm/kvm_host.h b/arch/powerpc/include/asm/kvm_host.h
index ed95f53..633d68f 100644
--- a/arch/powerpc/include/asm/kvm_host.h
+++ b/arch/powerpc/include/asm/kvm_host.h
@@ -386,6 +386,7 @@ struct kvm_vcpu_arch {
 #endif
 	u32 vrsave; /* also USPRG0 */
 	u32 mmucr;
+	/* shadow_msr is unused for BookE HV */
 	ulong shadow_msr;
 	ulong csrr0;
 	ulong csrr1;
-- 
1.6.0.2
