Return-Path: <ebiederm@xmission.com>
Received: from ebiederm.dsl.xmission.com (ebiederm.dsl.xmission.com
	[166.70.28.69])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id F2CFDDDFEC
	for <linuxppc-dev@ozlabs.org>; Mon, 29 Jan 2007 06:48:35 +1100 (EST)
From: ebiederm@xmission.com (Eric W. Biederman)
To: Greg Kroah-Hartman <greg@kroah.com>
Subject: [PATCH 4/6] msi: Remove attach_msi_entry.
References: <1169714047.65693.647693675533.qpush@cradle>
	<m1hcubq6re.fsf@ebiederm.dsl.xmission.com>
	<m1d54zq6o3.fsf_-_@ebiederm.dsl.xmission.com>
	<m18xfnq6lm.fsf_-_@ebiederm.dsl.xmission.com>
	<m14pqbq6j1.fsf_-_@ebiederm.dsl.xmission.com>
Date: Sun, 28 Jan 2007 12:47:52 -0700
In-Reply-To: <m14pqbq6j1.fsf_-_@ebiederm.dsl.xmission.com> (Eric
	W. Biederman's message of "Sun, 28 Jan 2007 12:45:54 -0700")
Message-ID: <m1zm83orvb.fsf_-_@ebiederm.dsl.xmission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Tony Luck <tony.luck@intel.com>, Grant Grundler <grundler@parisc-linux.org>,
	Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
	Kyle McMartin <kyle@parisc-linux.org>, linuxppc-dev@ozlabs.org,
	Brice Goglin <brice@myri.com>, shaohua.li@intel.com,
	linux-pci@atrey.karlin.mff.cuni.cz, "David S. Miller" <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


The attach_msi_entry has been reduced to a single simple assignment,
so for simplicity remove the abstraction and directory perform the
assignment.

Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
---
 drivers/pci/msi.c |    9 ++-------
 1 files changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
index db9c1d7..b994012 100644
--- a/drivers/pci/msi.c
+++ b/drivers/pci/msi.c
@@ -193,11 +193,6 @@ static struct msi_desc* alloc_msi_entry(void)
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
@@ -502,7 +497,7 @@ static int msi_capability_init(struct pci_dev *dev)
 	}
 
 	dev->first_msi_irq = irq;
-	attach_msi_entry(entry, irq);
+	msi_desc[irq] = entry;
 	/* Set MSI enabled bits	 */
 	enable_msi_mode(dev, pos, PCI_CAP_ID_MSI);
 
@@ -581,7 +576,7 @@ static int msix_capability_init(struct pci_dev *dev,
 			break;
 		}
 
-		attach_msi_entry(entry, irq);
+		msi_desc[irq] = entry;
 	}
 	if (i != nvec) {
 		int avail = i - 1;
-- 
1.4.4.1.g278f
