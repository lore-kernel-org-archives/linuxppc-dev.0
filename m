Return-Path: <Geoffrey.Levand@am.sony.com>
Received: from outbound4-sin-R.bigfish.com (outbound-sin.frontbridge.com
	[207.46.51.80])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id A50EEDDEEA
	for <linuxppc-dev@ozlabs.org>; Sat, 10 Feb 2007 04:08:02 +1100 (EST)
Message-ID: <45CCA568.6090607@am.sony.com>
Date: Fri, 09 Feb 2007 08:46:32 -0800
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: Geoff Levand <geoffrey.levand@am.sony.com>
Subject: Re: [PATCH] ps3 usb missed the addition of new argument
	to	ps3_alloc_io_irq()
References: <E1HFYFg-0004rz-19@ZenIV.linux.org.uk>
	<45CC9DDC.2060305@am.sony.com>
In-Reply-To: <45CC9DDC.2060305@am.sony.com>
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev@ozlabs.org, torvalds@linux-foundation.org,
	linux-kernel@vger.kernel.org, greg@kroah.com,
	Al Viro <viro@ftp.linux.org.uk>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Geoff Levand wrote:
> Al Viro wrote:
>> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> 
> Greg had this same change queued for his usb tree.
> 
> Acked-by: Geoff Levand <geoffrey.levand@am.sony.com>
> 

Update the PS3 irq allocation routines to take an argument indicating which
cpu (processor thread) the interrupt should be serviced on.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Geoff Levand <geoffrey.levand@am.sony.com>

---
I fixed Al's patch to have the proper line lengths.

-Geoff

 drivers/usb/host/ehci-ps3.c |    3 ++-
 drivers/usb/host/ohci-ps3.c |    3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

--- ps3-linux-dev.orig/drivers/usb/host/ehci-ps3.c
+++ ps3-linux-dev/drivers/usb/host/ehci-ps3.c
@@ -104,7 +104,8 @@ static int ps3_ehci_sb_probe(struct ps3_
 	dev_dbg(&dev->core, "%s:%d: mmio mapped_addr %lxh\n", __func__,
 		__LINE__, dev->m_region->lpar_addr);
 
-	result = ps3_alloc_io_irq(dev->interrupt_id, &virq);
+	result = ps3_alloc_io_irq(PS3_BINDING_CPU_ANY, dev->interrupt_id,
+		&virq);
 
 	if (result) {
 		dev_dbg(&dev->core, "%s:%d: ps3_construct_io_irq(%d) failed.\n",
--- ps3-linux-dev.orig/drivers/usb/host/ohci-ps3.c
+++ ps3-linux-dev/drivers/usb/host/ohci-ps3.c
@@ -107,7 +107,8 @@ static int ps3_ohci_sb_probe(struct ps3_
 	dev_dbg(&dev->core, "%s:%d: mmio mapped_addr %lxh\n", __func__,
 		__LINE__, dev->m_region->lpar_addr);
 
-	result = ps3_alloc_io_irq(dev->interrupt_id, &virq);
+	result = ps3_alloc_io_irq(PS3_BINDING_CPU_ANY, dev->interrupt_id,
+		&virq);
 
 	if (result) {
 		dev_dbg(&dev->core, "%s:%d: ps3_construct_io_irq(%d) failed.\n",
