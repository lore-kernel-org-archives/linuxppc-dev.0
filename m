Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 8D5AE1A074D
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  8 Jan 2015 16:40:58 +1100 (AEDT)
Received: from /spool/local
 by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Thu, 8 Jan 2015 15:40:57 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 9FB1D2CE8040
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  8 Jan 2015 16:40:54 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t085es2k38928588
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 8 Jan 2015 16:40:54 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t085er0a012605
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 8 Jan 2015 16:40:53 +1100
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] powerpc/kernel: Avoid memory corruption at early stage
Date: Thu,  8 Jan 2015 16:40:51 +1100
Message-Id: <1420695651-574-1-git-send-email-gwshan@linux.vnet.ibm.com>
Cc: Gavin Shan <gwshan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

When calling to early_setup(), we picks "boot_paca" up for the
master CPU and initialize that with initialise_paca(). At the
point, SLB shadow buffer isn't populated yet. Updating the SLB
shadow buffer should corrupt what we had in physical address 0
where the trap instruction is usually stored.

Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
---
 arch/powerpc/kernel/paca.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/powerpc/kernel/paca.c b/arch/powerpc/kernel/paca.c
index d6e195e..048a6ee 100644
--- a/arch/powerpc/kernel/paca.c
+++ b/arch/powerpc/kernel/paca.c
@@ -115,6 +115,9 @@ static struct slb_shadow * __init init_slb_shadow(int cpu)
 {
 	struct slb_shadow *s = &slb_shadow[cpu];
 
+	if (!slb_shadow)
+		return NULL;
+
 	s->persistent = cpu_to_be32(SLB_NUM_BOLTED);
 	s->buffer_length = cpu_to_be32(sizeof(*s));
 
-- 
1.8.3.2
