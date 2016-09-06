Return-Path: <dja@axtens.net>
Received: from mail-pf0-x241.google.com (mail-pf0-x241.google.com
 [IPv6:2607:f8b0:400e:c00::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sSwHF2KBWzDrpp
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  6 Sep 2016 15:33:13 +1000 (AEST)
Received: by mail-pf0-x241.google.com with SMTP id h186so10788910pfg.2
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 05 Sep 2016 22:33:13 -0700 (PDT)
From: Daniel Axtens <dja@axtens.net>
To: linuxppc-dev@lists.ozlabs.org
Cc: Daniel Axtens <dja@axtens.net>
Subject: [PATCH v2 1/5] powerpc/cell: drop unused iic_get_irq_host()
Date: Tue,  6 Sep 2016 15:32:39 +1000
Message-Id: <1473139963-7496-1-git-send-email-dja@axtens.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Sparse checking revealed that it is no longer used.
There is an EXPORT_SYMBOL_GPL, but there's no header that
provides a prototype, so nothing should be using it anyway.

Remove it.

Signed-off-by: Daniel Axtens <dja@axtens.net>
---
 arch/powerpc/platforms/cell/interrupt.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/arch/powerpc/platforms/cell/interrupt.c b/arch/powerpc/platforms/cell/interrupt.c
index 9f609fc8d331..4d16b368b6f5 100644
--- a/arch/powerpc/platforms/cell/interrupt.c
+++ b/arch/powerpc/platforms/cell/interrupt.c
@@ -187,12 +187,6 @@ void iic_message_pass(int cpu, int msg)
 	out_be64(&per_cpu(cpu_iic, cpu).regs->generate, (0xf - msg) << 4);
 }
 
-struct irq_domain *iic_get_irq_host(int node)
-{
-	return iic_host;
-}
-EXPORT_SYMBOL_GPL(iic_get_irq_host);
-
 static void iic_request_ipi(int msg)
 {
 	int virq;
-- 
2.7.4
