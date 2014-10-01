Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 68BE31A041D
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  1 Oct 2014 14:35:53 +1000 (EST)
Received: from /spool/local
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Wed, 1 Oct 2014 14:35:51 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 9B2BC2CE802D
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  1 Oct 2014 14:35:49 +1000 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 s914bSRn33357934
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 1 Oct 2014 14:37:37 +1000
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s914ZGoG010656
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 1 Oct 2014 14:35:16 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: mpe@ellerman.id.au
Subject: [PATCH] powerpc/eeh: Show hex prefix for PE state sysfs
Date: Wed,  1 Oct 2014 14:34:51 +1000
Message-Id: <1412138091-26977-1-git-send-email-gwshan@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, Gavin Shan <gwshan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

As Michael suggested, the hex prefix for the output of EEH PE
state sysfs entry (/sys/bus/pci/devices/xxx/eeh_pe_state) is
always informative to users.

Suggested-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
---
 arch/powerpc/kernel/eeh_sysfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/eeh_sysfs.c b/arch/powerpc/kernel/eeh_sysfs.c
index 9a44010..f19b1e5 100644
--- a/arch/powerpc/kernel/eeh_sysfs.c
+++ b/arch/powerpc/kernel/eeh_sysfs.c
@@ -65,7 +65,7 @@ static ssize_t eeh_pe_state_show(struct device *dev,
 		return -ENODEV;
 
 	state = eeh_ops->get_state(edev->pe, NULL);
-	return sprintf(buf, "%08x %08x\n",
+	return sprintf(buf, "%0x08x %0x08x\n",
 		       state, edev->pe->state);
 }
 
-- 
1.8.3.2
