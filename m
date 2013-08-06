Return-Path: <R65777@freescale.com>
Received: from co1outboundpool.messaging.microsoft.com
 (co1ehsobe006.messaging.microsoft.com [216.32.180.189])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id E3A9D2C0120
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  6 Aug 2013 21:37:07 +1000 (EST)
From: Bharat Bhushan <r65777@freescale.com>
To: <scottwood@freescale.com>, <benh@kernel.crashing.org>, <agraf@suse.de>,
 <paulus@samba.org>, <kvm@vger.kernel.org>, <kvm-ppc@vger.kernel.org>,
 <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH 3/6 v3] kvm: powerpc: allow guest control "G" attribute in mas2
Date: Tue, 6 Aug 2013 17:01:11 +0530
Message-ID: <1375788674-13140-4-git-send-email-Bharat.Bhushan@freescale.com>
In-Reply-To: <1375788674-13140-1-git-send-email-Bharat.Bhushan@freescale.com>
References: <1375788674-13140-1-git-send-email-Bharat.Bhushan@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Bharat Bhushan <bharat.bhushan@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

"G" bit in MAS2 indicates whether the page is Guarded.
There is no reason to stop guest setting  "G", so allow him.

Signed-off-by: Bharat Bhushan <bharat.bhushan@freescale.com>
---
v2->v3
 - no change
v1->v2
 - no change
 arch/powerpc/kvm/e500.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/kvm/e500.h b/arch/powerpc/kvm/e500.h
index 277cb18..4fd9650 100644
--- a/arch/powerpc/kvm/e500.h
+++ b/arch/powerpc/kvm/e500.h
@@ -117,7 +117,7 @@ static inline struct kvmppc_vcpu_e500 *to_e500(struct kvm_vcpu *vcpu)
 #define E500_TLB_USER_PERM_MASK (MAS3_UX|MAS3_UR|MAS3_UW)
 #define E500_TLB_SUPER_PERM_MASK (MAS3_SX|MAS3_SR|MAS3_SW)
 #define MAS2_ATTRIB_MASK \
-	  (MAS2_X0 | MAS2_X1 | MAS2_E)
+	  (MAS2_X0 | MAS2_X1 | MAS2_E | MAS2_G)
 #define MAS3_ATTRIB_MASK \
 	  (MAS3_U0 | MAS3_U1 | MAS3_U2 | MAS3_U3 \
 	   | E500_TLB_USER_PERM_MASK | E500_TLB_SUPER_PERM_MASK)
-- 
1.7.0.4
