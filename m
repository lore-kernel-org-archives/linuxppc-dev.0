Return-Path: <stefanr@s5r6.in-berlin.de>
Received: from einhorn.in-berlin.de (einhorn.in-berlin.de [192.109.42.8])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail.vr.in-berlin.de",
	Issuer "IN-Berlin Server CA (G2)" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 4BBE5DDE19
	for <linuxppc-dev@ozlabs.org>; Thu,  6 Sep 2007 17:51:02 +1000 (EST)
Date: Thu, 6 Sep 2007 09:50:30 +0200 (CEST)
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
Subject: [PATCH update] Re: Sleep problems with kernels >= 2.6.21 on powerpc
To: Andrew Morton <akpm@linux-foundation.org>
In-Reply-To: <tkrat.29a16d2ec8698ff2@s5r6.in-berlin.de>
Message-ID: <tkrat.c799685836167333@s5r6.in-berlin.de>
References: <6540c930708251937o2a9a23efv72a0f2b8947067bd@mail.gmail.com>
	<6bffcb0e0708261621q25316becqce7b3ae2176f45a8@mail.gmail.com>
	<20070827065246.GA21220@ime.usp.br> <46D279E8.10001@edge.ping.de>
	<46D72BC6.3020809@edge.ping.de>
	<20070905100754.57ab4e3e.akpm@linux-foundation.org>
	<46DEEBBE.4070201@s5r6.in-berlin.de>
	<20070905124411.bc15f48c.akpm@linux-foundation.org>
	<tkrat.29a16d2ec8698ff2@s5r6.in-berlin.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=us-ascii
Cc: michal.k.k.piotrowski@gmail.com, rbrito@gmail.com, krh@redhat.com,
	linux-kernel@vger.kernel.org, rjw@sisk.pl,
	linuxppc-dev@ozlabs.org, debian-powerpc@lists.debian.org,
	linux-pm@lists.linux-foundation.org, rael@edge.ping.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On  5 Sep, Stefan Richter wrote:
> On  5 Sep, Andrew Morton wrote:
>>> >>> Trying to free already-free IRQ 40
>>> >>> pci_set_power_state(): 0002:20:0e.0: state=3, current state=5
>>> >>> firewire_ohci: pci_set_power_state failed with -22<3>pci_device_suspend(): pci_suspend+0x0/0x9c [firewire_ohci]() returns -22
...
>> It's not clear _why_ pci_set_power_state() is failing.
> 
> The only -22 error path in pci_set_power_state is this:
> 
> 	/* Validate current state:
> 	 * Can enter D0 from any state, but if we can only go deeper 
> 	 * to sleep if we're already in a low power state
> 	 */
> 	if (state != PCI_D0 && dev->current_state > state) {
> 		printk(KERN_ERR "%s(): %s: state=%d, current state=%d\n",
> 			__FUNCTION__, pci_name(dev), state, dev->current_state);
> 		return -EINVAL;
> 	} [...else...]


From: Stefan Richter <stefanr@s5r6.in-berlin.de>
Subject: firewire: fw-ohci: ignore failure of pci_set_power_state (fix suspend regression)

Fixes (papers over) "Sleep problems with kernels >= 2.6.21 on powerpc",
http://lkml.org/lkml/2007/8/25/155.  The issue is that the FireWire
controller's pci_dev.current_state of iBook G3 and presumably older
PowerBooks is still in PCI_UNKNOWN instead of PCI_D0 when the firewire
driver's .suspend method is called.

Like it was suggested earlier in http://lkml.org/lkml/2006/10/24/13, we
do not fail .suspend anymore if pci_set_power_state failed.

Signed-off-by: Stefan Richter <stefanr@s5r6.in-berlin.de>
---

Update:
  - omit comment which will become outdated if the underlying problem is fixed
  - log the error return value
  - document the actual bug in the patch description

IMO the actual bug here (operating the controller while it is in
PCI_UNKNOWN state, which is surely a fault in the PPC platform code) is
something to be fixed post 2.6.23 release.

 drivers/firewire/fw-ohci.c |    6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

Index: linux/drivers/firewire/fw-ohci.c
===================================================================
--- linux.orig/drivers/firewire/fw-ohci.c
+++ linux/drivers/firewire/fw-ohci.c
@@ -1973,10 +1973,8 @@ static int pci_suspend(struct pci_dev *p
 		return err;
 	}
 	err = pci_set_power_state(pdev, pci_choose_state(pdev, state));
-	if (err) {
-		fw_error("pci_set_power_state failed\n");
-		return err;
-	}
+	if (err)
+		fw_error("pci_set_power_state failed with %d\n", err);
 
 	return 0;
 }


-- 
Stefan Richter
-=====-=-=== =--= --==-
http://arcgraph.de/sr/
