Return-Path: <gpiccoli@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yH92c2F9zzDqJ7
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Oct 2017 22:34:47 +1100 (AEDT)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v9IBY9b7051853
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Oct 2017 07:34:45 -0400
Received: from e18.ny.us.ibm.com (e18.ny.us.ibm.com [129.33.205.208])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2dp5fm3cqr-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Oct 2017 07:34:45 -0400
Received: from localhost
 by e18.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gpiccoli@linux.vnet.ibm.com>;
 Wed, 18 Oct 2017 07:34:44 -0400
From: "Guilherme G. Piccoli" <gpiccoli@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: gpiccoli@linux.vnet.ibm.com, benh@kernel.crashing.org, paulus@samba.org,
 mpe@ellerman.id.au, brking@linux.vnet.ibm.com
Subject: [PATCH] powerpc/xmon: Always enable xmon sysrq trigger
Date: Wed, 18 Oct 2017 09:34:36 -0200
Message-Id: <20171018113436.16112-1-gpiccoli@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Distros vary the way they enable SysRq by default - mostly they seem
to enable some mask and then majority of the SysRq functions are
disabled. For instance, xmon does not even have a mask, and unsless
SysRq are completely enabled ( == 1), xmon trigger keeps disabled.

Countless times while investigating hangs we needed xmon and it was
disabled - machine just got hung and while in serial console, we just
couldn't drop to xmon, forcing to a new attempt to reproduce the issue
with SysRq fully enabled.

This patch "fixes" this by having xmon enabled in all possible masks
of SysRq. In other words, xmon trigger will only be disabled if SysRq
is 0 (completely disabled). So, while debugging a hung, when one tries
to drop to xmon this patch prevents the frustrating message:
"This sysrq operation is disabled".

Signed-off-by: Guilherme G. Piccoli <gpiccoli@linux.vnet.ibm.com>
---
Patch built and tested against powerpc/next.

 arch/powerpc/xmon/xmon.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/powerpc/xmon/xmon.c b/arch/powerpc/xmon/xmon.c
index 4679aeb84767..780d708472a2 100644
--- a/arch/powerpc/xmon/xmon.c
+++ b/arch/powerpc/xmon/xmon.c
@@ -3514,6 +3514,7 @@ static struct sysrq_key_op sysrq_xmon_op = {
 	.handler =	sysrq_handle_xmon,
 	.help_msg =	"xmon(x)",
 	.action_msg =	"Entering xmon",
+	.enable_mask =	0xFFFF,
 };
 
 static int __init setup_xmon_sysrq(void)
-- 
2.14.2
