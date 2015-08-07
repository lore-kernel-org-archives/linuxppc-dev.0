Return-Path: <xerofoify@gmail.com>
Received: from mail-ig0-x22b.google.com (mail-ig0-x22b.google.com
 [IPv6:2607:f8b0:4001:c05::22b])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 682891A0023
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  8 Aug 2015 01:54:59 +1000 (AEST)
Received: by igk11 with SMTP id 11so34331618igk.1
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 07 Aug 2015 08:54:57 -0700 (PDT)
From: Nicholas Krause <xerofoify@gmail.com>
To: gleb@kernel.org
Cc: pbonzini@redhat.com, agraf@suse.com, kvm@vger.kernel.org,
 kvm-ppc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH] kvm:powerpc:Fix incorrect return statement in the function
 mpic_set_default_irq_routing
Date: Fri,  7 Aug 2015 11:54:53 -0400
Message-Id: <1438962893-3370-1-git-send-email-xerofoify@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This fixes the incorrect return statement in the function
mpic_set_default_irq_routing from always returning zero
to signal success to this function's caller to instead
return the return value of kvm_set_irq_routing as this
function can fail and we need to correctly signal the
caller of mpic_set_default_irq_routing when the call
to this particular function has failed.

Signed-off-by: Nicholas Krause <xerofoify@gmail.com>
---
 arch/powerpc/kvm/mpic.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kvm/mpic.c b/arch/powerpc/kvm/mpic.c
index 6249cdc..b14b85a 100644
--- a/arch/powerpc/kvm/mpic.c
+++ b/arch/powerpc/kvm/mpic.c
@@ -1641,16 +1641,17 @@ static void mpic_destroy(struct kvm_device *dev)
 static int mpic_set_default_irq_routing(struct openpic *opp)
 {
 	struct kvm_irq_routing_entry *routing;
+	int ret;
 
 	/* Create a nop default map, so that dereferencing it still works */
 	routing = kzalloc((sizeof(*routing)), GFP_KERNEL);
 	if (!routing)
 		return -ENOMEM;
 
-	kvm_set_irq_routing(opp->kvm, routing, 0, 0);
+	ret = kvm_set_irq_routing(opp->kvm, routing, 0, 0);
 
 	kfree(routing);
-	return 0;
+	return ret;
 }
 
 static int mpic_create(struct kvm_device *dev, u32 type)
-- 
2.1.4
