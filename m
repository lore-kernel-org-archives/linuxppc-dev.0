Return-Path: <xerofoify@gmail.com>
Received: from mail-io0-x232.google.com (mail-io0-x232.google.com
 [IPv6:2607:f8b0:4001:c06::232])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 8D5F71A0023
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  7 Aug 2015 23:47:15 +1000 (AEST)
Received: by ioii16 with SMTP id i16so112079141ioi.0
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 07 Aug 2015 06:47:13 -0700 (PDT)
From: Nicholas Krause <xerofoify@gmail.com>
To: agraf@suse.com
Cc: gleb@kernel.org, pbonzini@redhat.com, kvm-ppc@vger.kernel.org,
 kvm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH] kvm:powerpc:Fix error handling in the function
 mpic_set_default_irq_routing
Date: Fri,  7 Aug 2015 09:47:08 -0400
Message-Id: <1438955228-30116-1-git-send-email-xerofoify@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This fixes error handling in the function mpic_set_default_irq_routing
by checking if the call to the function kvm_set_irq_routing has failed
and if so exit immediately to the caller by first freeing the structure
pointer routing in order to avoid a memory leak before returning the error
code returned by the call to mpic_set_default_irq_routing.

Signed-off-by: Nicholas Krause <xerofoify@gmail.com>
---
 arch/powerpc/kvm/mpic.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/kvm/mpic.c b/arch/powerpc/kvm/mpic.c
index 6249cdc..7b1375a 100644
--- a/arch/powerpc/kvm/mpic.c
+++ b/arch/powerpc/kvm/mpic.c
@@ -1641,13 +1641,18 @@ static void mpic_destroy(struct kvm_device *dev)
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
+	if (ret) {
+		kfree(routing);
+		return ret;
+	}
 
 	kfree(routing);
 	return 0;
-- 
2.1.4
