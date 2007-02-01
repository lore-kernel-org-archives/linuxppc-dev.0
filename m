Return-Path: <gregkh@suse.de>
Received: from mx1.suse.de (mail.suse.de [195.135.220.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx1.suse.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id BBC44DDF0B
	for <linuxppc-dev@ozlabs.org>; Thu,  1 Feb 2007 17:09:12 +1100 (EST)
Subject: patch msi-remove-attach_msi_entry.patch added to gregkh-2.6 tree
To: greg@kroah.com, brice@myri.com, davem@davemloft.net,
	ebiederm@xmission.com, gregkh@suse.de, grundler@parisc-linux.org,
	kyle@parisc-linux.org, linuxppc-dev@ozlabs.org,
	michael@ellerman.id.au, mingo@elte.hu, shaohua.li@intel.com,
	tony.luck@intel.com
From: <gregkh@suse.de>
Date: Wed, 31 Jan 2007 22:08:08 -0800
In-Reply-To: <m1zm83orvb.fsf_-_@ebiederm.dsl.xmission.com>
Message-Id: <20070201060906.7FB75B9DC74@imap.suse.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


This is a note to let you know that I've just added the patch titled

     Subject: msi: Remove attach_msi_entry.

to my gregkh-2.6 tree.  Its filename is

     msi-remove-attach_msi_entry.patch

This tree can be found at 
    http://www.kernel.org/pub/linux/kernel/people/gregkh/gregkh-2.6/patches/


>From owner-linux-pci@atrey.karlin.mff.cuni.cz  Wed Jan 31 22:00:56 2007
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Sun, 28 Jan 2007 12:47:52 -0700
Subject: msi: Remove attach_msi_entry.
To: Greg Kroah-Hartman <greg@kroah.com>
Cc: "David S. Miller" <davem@davemloft.net>, Kyle McMartin <kyle@parisc-linux.org>, <linuxppc-dev@ozlabs.org>, Brice Goglin <brice@myri.com>, <shaohua.li@intel.com>, Michael Ellerman <michael@ellerman.id.au>, Grant Grundler <grundler@parisc-linux.org>, Tony Luck <tony.luck@intel.com>, Ingo Molnar <mingo@elte.hu>
Message-ID: <m1zm83orvb.fsf_-_@ebiederm.dsl.xmission.com>

The attach_msi_entry has been reduced to a single simple assignment,
so for simplicity remove the abstraction and directory perform the
assignment.

Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
Acked-by: Ingo Molnar <mingo@elte.hu>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 drivers/pci/msi.c |    9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

--- gregkh-2.6.orig/drivers/pci/msi.c
+++ gregkh-2.6/drivers/pci/msi.c
@@ -193,11 +193,6 @@ static struct msi_desc* alloc_msi_entry(
 	return entry;
 }
 
-static void attach_msi_entry(struct msi_desc *entry, int irq)
-{
-	msi_desc[irq] = entry;
-}
-
 static int create_msi_irq(void)
 {
 	struct msi_desc *entry;
@@ -491,7 +486,7 @@ static int msi_capability_init(struct pc
 	}
 
 	dev->first_msi_irq = irq;
-	attach_msi_entry(entry, irq);
+	msi_desc[irq] = entry;
 	/* Set MSI enabled bits	 */
 	enable_msi_mode(dev, pos, PCI_CAP_ID_MSI);
 
@@ -570,7 +565,7 @@ static int msix_capability_init(struct p
 			break;
 		}
 
-		attach_msi_entry(entry, irq);
+		msi_desc[irq] = entry;
 	}
 	if (i != nvec) {
 		int avail = i - 1;


Patches currently in gregkh-2.6 which might be from greg@kroah.com are
