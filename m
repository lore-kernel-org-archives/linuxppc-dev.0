Return-Path: <jdl@jdl.com>
Received: from jdl.com (jdl.com [66.118.10.122])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 1660B67B6B
	for <linuxppc-dev@ozlabs.org>; Mon, 11 Sep 2006 23:29:29 +1000 (EST)
Received: from jdl (helo=jdl.com) by jdl.com with local-esmtp (Exim 4.44)
	id 1GMlqi-0001PS-33
	for linuxppc-dev@ozlabs.org; Mon, 11 Sep 2006 08:29:21 -0500
To: linuxppc-dev@ozlabs.org
Subject: Reminder: [PATCH] Add new, missing argument to of_irq_map_raw().
Date: Mon, 11 Sep 2006 08:29:20 -0500
From: Jon Loeliger <jdl@jdl.com>
Message-Id: <E1GMlqi-0001PS-33@jdl.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Paul,

I just wanted to check with you that this patch isn't
slipping through the cracks as we close out 2.6.18.
Without this, the 86xx build is broken, of course.

Thanks!
jdl



------- Forwarded Message

From: Jon Loeliger <jdl@freescale.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] Add new, missing argument to of_irq_map_raw().
Date: Fri, 01 Sep 2006 10:17:20 -0500
Message-Id: <E1GJAlk-00053S-3U@jdl.com>

Ben speaks; we follow.

Signed-off-by: Jon Loeliger <jdl@freescale.com>
- ---

Paul,

This patch is needed in the 2.6.18 release for 86xx.
Ben's recent changes to of_irq_map_raw() missed one caller.
This patch cleans that up.

Thanks,
jdl


 arch/powerpc/platforms/86xx/mpc86xx_hpcn.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/platforms/86xx/mpc86xx_hpcn.c b/arch/powerpc/platforms/86xx/mpc86xx_hpcn.c
index 4a33d95..cdaf668 100644
- --- a/arch/powerpc/platforms/86xx/mpc86xx_hpcn.c
+++ b/arch/powerpc/platforms/86xx/mpc86xx_hpcn.c
@@ -154,7 +154,7 @@ get_pci_irq_from_of(struct pci_controlle
 
 	laddr[0] = (hose->first_busno << 16) | (PCI_DEVFN(slot, 0) << 8);
 	laddr[1] = laddr[2] = 0;
- -	of_irq_map_raw(hosenode, &pin, laddr, &oirq);
+	of_irq_map_raw(hosenode, &pin, 1, laddr, &oirq);
 	DBG("mpc86xx_hpcn: pci irq addr %x, slot %d, pin %d, irq %d\n",
 			laddr[0], slot, pin, oirq.specifier[0]);
 	return oirq.specifier[0];
- -- 
1.4.2.rc2.g85d6c-dirty

_______________________________________________
Linuxppc-dev mailing list
Linuxppc-dev@ozlabs.org
https://ozlabs.org/mailman/listinfo/linuxppc-dev

------- End of Forwarded Message
