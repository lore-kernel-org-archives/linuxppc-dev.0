Return-Path: <xerofoify@gmail.com>
Received: from mail-ig0-x234.google.com (mail-ig0-x234.google.com
 [IPv6:2607:f8b0:4001:c05::234])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 0BB611A088A
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  7 Aug 2015 03:13:16 +1000 (AEST)
Received: by igr7 with SMTP id 7so15470045igr.0
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 06 Aug 2015 10:13:14 -0700 (PDT)
From: Nicholas Krause <xerofoify@gmail.com>
To: agraf@suse.com
Cc: gleb@kernel.org, pbonzini@redhat.com, kvm-ppc@vger.kernel.org,
 kvm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH] kvm:powerpc:Fix error handling in the function
 mpic_set_default_irq_routing
Date: Thu,  6 Aug 2015 13:13:10 -0400
Message-Id: <1438881190-27287-1-git-send-email-xerofoify@gmail.com>
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
and if so exit immediately to the caller by returning the error code
returned by the call to mpic_set_default_irq_routing.

Signed-off-by: Nicholas Krause <xerofoify@gmail.com>
---
 arch/powerpc/kvm/mpic.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/kvm/mpic.c b/arch/powerpc/kvm/mpic.c
index 6249cdc..5a18859 100644
--- a/arch/powerpc/kvm/mpic.c
+++ b/arch/powerpc/kvm/mpic.c
@@ -1641,13 +1641,16 @@ static void mpic_destroy(struct kvm_device *dev)
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
+	if (ret)
+		return ret;
 
 	kfree(routing);
 	return 0;
-- 
2.1.4
