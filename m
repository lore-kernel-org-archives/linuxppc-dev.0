Return-Path: <paubert@iram.es>
Received: from ltgp.iram.es (ltgp.iram.es [150.214.224.138])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 551152BF0D
	for <linuxppc-dev@ozlabs.org>; Fri, 19 Nov 2004 22:15:50 +1100 (EST)
From: Gabriel Paubert <paubert@iram.es>
Date: Fri, 19 Nov 2004 12:06:09 +0100
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Message-ID: <20041119110609.GA2924@iram.es>
References: <1100847411.25521.42.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1100847411.25521.42.camel@gaston>
Cc: linuxppc-dev@ozlabs.org
Subject: Re: TEST: Sleep suppport for iBook G4 & Aluminium PowerBooks (ATI
	based)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Nov 19, 2004 at 05:56:50PM +1100, Benjamin Herrenschmidt wrote:
> NOTE: Owners of _OTHER_ Apple laptops that could already sleep, like
> earlier iBooks, or Titanium PowerBooks, please test this patch as well
> for regression. More specifically, test if sleep still works, X/DRI, and
> backlight control as I have made significant changes to radeonfb in ways
> that could affect those areas.

Everytime my Pismo wakes up I have the following:

Badness in enable_irq at kernel/irq/manage.c:106
Call trace:
 [c0006db4] dump_stack+0x18/0x28
 [c0004dfc] check_bug_trap+0x84/0xac
 [c0004f84] ProgramCheckException+0x160/0x1a0
 [c00044e0] ret_from_except_full+0x0/0x4c
 [c002f8dc] enable_irq+0xa0/0xa8
 [c0205570] ohci_pci_resume+0xe4/0xfc
 [c01fc018] usb_hcd_pci_resume+0xb0/0x114
 [c013a9f0] pci_device_resume+0x4c/0x50
 [c0181474] resume_device+0x44/0x4c
 [c01815ac] dpm_resume+0x130/0x148
 [c01815fc] device_resume+0x38/0x78
 [c0424ac8] 0xc0424ac8
 [c0424fb0] 0xc0424fb0
 [c042581c] 0xc042581c
 [c0064680] sys_ioctl+0xdc/0x2f4
Badness in enable_irq at kernel/irq/manage.c:106
Call trace:
 [c0006db4] dump_stack+0x18/0x28
 [c0004dfc] check_bug_trap+0x84/0xac
 [c0004f84] ProgramCheckException+0x160/0x1a0
 [c00044e0] ret_from_except_full+0x0/0x4c
 [c002f8dc] enable_irq+0xa0/0xa8
 [c0205570] ohci_pci_resume+0xe4/0xfc
 [c01fc018] usb_hcd_pci_resume+0xb0/0x114
 [c013a9f0] pci_device_resume+0x4c/0x50
 [c0181474] resume_device+0x44/0x4c
 [c01815ac] dpm_resume+0x130/0x148
 [c01815fc] device_resume+0x38/0x78
 [c0424ac8] 0xc0424ac8
 [c0424fb0] 0xc0424fb0
 [c042581c] 0xc042581c
 [c0064680] sys_ioctl+0xdc/0x2f4

It happens when reenabling USB interrupts (before the recent 
irq consolidation it was a one line message about unbalanced
irq_enable IIRC). The appended patch fixes the problem for my 
machine, the explanation being that some higher level code now
does an explicit free_irq() before suspending and request_irq()
on resume (in drivers/usb/core/hcd-pci.c).

	Gabriel

===== drivers/usb/host/ohci-pci.c 1.33 vs edited =====
--- 1.33/drivers/usb/host/ohci-pci.c	2004-11-07 23:31:07 +01:00
+++ edited/drivers/usb/host/ohci-pci.c	2004-11-19 11:55:10 +01:00
@@ -119,14 +119,11 @@
 
 	/* let things settle down a bit */
 	msleep (100);
-	
-#ifdef CONFIG_PMAC_PBOOK
-	if (_machine == _MACH_Pmac)
-		disable_irq ((to_pci_dev(hcd->self.controller))->irq);
 
+#ifdef CONFIG_PMAC_PBOOK
 	{
-	   	struct device_node	*of_node;
- 
+		struct device_node	*of_node;
+
 		/* Disable USB PAD & cell clock */
 		of_node = pci_device_to_OF_node (to_pci_dev(hcd->self.controller));
 		if (of_node)
@@ -164,13 +161,6 @@
 	retval = ohci_hub_resume (hcd);
 	usb_unlock_device (hcd->self.root_hub);
 #endif
-
-	if (retval == 0) {
-#ifdef CONFIG_PMAC_PBOOK
-		if (_machine == _MACH_Pmac)
-			enable_irq (to_pci_dev(hcd->self.controller)->irq);
-#endif
-	}
 	return retval;
 }
 
