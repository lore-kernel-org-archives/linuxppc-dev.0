Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 6DFCD1A0206
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Nov 2014 09:27:06 +1100 (AEDT)
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 5053B1400DE
 for <linuxppc-dev@ozlabs.org>; Tue, 25 Nov 2014 09:27:06 +1100 (AEDT)
Received: from /spool/local
 by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Tue, 25 Nov 2014 08:27:05 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 2166F2BB0068
 for <linuxppc-dev@ozlabs.org>; Tue, 25 Nov 2014 09:27:03 +1100 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 sAOMR2FW30277876
 for <linuxppc-dev@ozlabs.org>; Tue, 25 Nov 2014 09:27:03 +1100
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 sAOMR2u2002699
 for <linuxppc-dev@ozlabs.org>; Tue, 25 Nov 2014 09:27:02 +1100
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 1/3] powerpc/eeh: Fix PE state format
Date: Tue, 25 Nov 2014 09:26:58 +1100
Message-Id: <1416868020-4129-1-git-send-email-gwshan@linux.vnet.ibm.com>
Cc: Gavin Shan <gwshan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Obviously I had wrong format given to the PE state output from
/sys/bus/pci/devices/xxxx/eeh_pe_state with some typoes, which
was introduced by commit 2013add4 ("powerpc/eeh: Show hex prefix
for PE state sysfs"). The patch fixes it up.

Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
---
 arch/powerpc/kernel/eeh_sysfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/eeh_sysfs.c b/arch/powerpc/kernel/eeh_sysfs.c
index f19b1e5..1ceecdd 100644
--- a/arch/powerpc/kernel/eeh_sysfs.c
+++ b/arch/powerpc/kernel/eeh_sysfs.c
@@ -65,7 +65,7 @@ static ssize_t eeh_pe_state_show(struct device *dev,
 		return -ENODEV;
 
 	state = eeh_ops->get_state(edev->pe, NULL);
-	return sprintf(buf, "%0x08x %0x08x\n",
+	return sprintf(buf, "0x%08x 0x%08x\n",
 		       state, edev->pe->state);
 }
 
-- 
1.8.3.2
