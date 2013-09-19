Return-Path: <R65777@freescale.com>
Received: from db9outboundpool.messaging.microsoft.com
 (mail-db9lp0250.outbound.messaging.microsoft.com [213.199.154.250])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id BBA462C0167
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Sep 2013 16:10:29 +1000 (EST)
From: Bharat Bhushan <r65777@freescale.com>
To: <benh@kernel.crashing.org>, <agraf@suse.de>, <paulus@samba.org>,
 <kvm@vger.kernel.org>, <kvm-ppc@vger.kernel.org>,
 <linuxppc-dev@lists.ozlabs.org>, <scottwood@freescale.com>
Subject: [PATCH 2/6 v5] kvm: powerpc: allow guest control "E" attribute in mas2
Date: Thu, 19 Sep 2013 11:32:42 +0530
Message-ID: <1379570566-3715-3-git-send-email-Bharat.Bhushan@freescale.com>
In-Reply-To: <1379570566-3715-1-git-send-email-Bharat.Bhushan@freescale.com>
References: <1379570566-3715-1-git-send-email-Bharat.Bhushan@freescale.com>
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

"E" bit in MAS2 bit indicates whether the page is accessed
in Little-Endian or Big-Endian byte order.
There is no reason to stop guest setting  "E", so allow him."

Signed-off-by: Bharat Bhushan <bharat.bhushan@freescale.com>
---
v1->v5
 - no change
 arch/powerpc/kvm/e500.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/kvm/e500.h b/arch/powerpc/kvm/e500.h
index c2e5e98..277cb18 100644
--- a/arch/powerpc/kvm/e500.h
+++ b/arch/powerpc/kvm/e500.h
@@ -117,7 +117,7 @@ static inline struct kvmppc_vcpu_e500 *to_e500(struct kvm_vcpu *vcpu)
 #define E500_TLB_USER_PERM_MASK (MAS3_UX|MAS3_UR|MAS3_UW)
 #define E500_TLB_SUPER_PERM_MASK (MAS3_SX|MAS3_SR|MAS3_SW)
 #define MAS2_ATTRIB_MASK \
-	  (MAS2_X0 | MAS2_X1)
+	  (MAS2_X0 | MAS2_X1 | MAS2_E)
 #define MAS3_ATTRIB_MASK \
 	  (MAS3_U0 | MAS3_U1 | MAS3_U2 | MAS3_U3 \
 	   | E500_TLB_USER_PERM_MASK | E500_TLB_SUPER_PERM_MASK)
-- 
1.7.0.4
