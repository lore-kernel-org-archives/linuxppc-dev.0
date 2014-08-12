Return-Path: <zhong@linux.vnet.ibm.com>
Received: from e06smtp15.uk.ibm.com (e06smtp15.uk.ibm.com [195.75.94.111])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id ED24D1A0718
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Aug 2014 19:17:16 +1000 (EST)
Received: from /spool/local
 by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <zhong@linux.vnet.ibm.com>;
 Tue, 12 Aug 2014 10:17:12 +0100
Received: from b06cxnps4074.portsmouth.uk.ibm.com
 (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
 by d06dlp02.portsmouth.uk.ibm.com (Postfix) with ESMTP id 45E2A2190041
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Aug 2014 10:16:53 +0100 (BST)
Received: from d06av08.portsmouth.uk.ibm.com (d06av08.portsmouth.uk.ibm.com
 [9.149.37.249])
 by b06cxnps4074.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s7C9H9FK34013204
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Aug 2014 09:17:09 GMT
Received: from d06av08.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av08.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s7C9H9HL014612
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Aug 2014 03:17:09 -0600
Message-ID: <1407835024.3288.10.camel@TP420>
Subject: [PATCH powerpc] use machine_subsys_initcall() for
 opal_hmi_handler_init()
From: Li Zhong <zhong@linux.vnet.ibm.com>
To: PowerPC email list <linuxppc-dev@lists.ozlabs.org>
Date: Tue, 12 Aug 2014 17:17:04 +0800
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Michael Ellerman <michael@ellerman.id.au>, mahesh@linux.vnet.ibm.com,
 Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

As opal_message_init() uses machine_early_initcall(powernv, ), and
opal_hmi_handler_init() depends on that early initcall, so it also needs
use machine_* to check the machine_id.

Signed-off-by: Li Zhong <zhong@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/powernv/opal-hmi.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/powernv/opal-hmi.c b/arch/powerpc/platforms/powernv/opal-hmi.c
index 97ac8dc..5e1ed15 100644
--- a/arch/powerpc/platforms/powernv/opal-hmi.c
+++ b/arch/powerpc/platforms/powernv/opal-hmi.c
@@ -28,6 +28,7 @@
 
 #include <asm/opal.h>
 #include <asm/cputable.h>
+#include <asm/machdep.h>
 
 static int opal_hmi_handler_nb_init;
 struct OpalHmiEvtNode {
@@ -185,4 +186,4 @@ static int __init opal_hmi_handler_init(void)
 	}
 	return 0;
 }
-subsys_initcall(opal_hmi_handler_init);
+machine_subsys_initcall(powernv, opal_hmi_handler_init);
