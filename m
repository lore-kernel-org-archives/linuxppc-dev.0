Subject: Re: [YABOOT] Preliminary ofpath with 2.6 kernel support NEEDS TESTING
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Ethan Benson <erbenson@alaska.net>
Cc: yaboot-users@lists.penguinppc.org,
	yaboot-devel@lists.penguinppc.org,
	"debian-powerpc@lists.debian.org" <debian-powerpc@lists.debian.org>,
	Linux/PPC-devel <linuxppc-dev@lists.linuxppc.org>,
	yellowdog-general@lists.terrasoftsolutions.com,
	yellowdog-devel@lists.terrasoftsolutions.com,
	g5-test@lists.terrasoftsolutions.com
In-Reply-To: <20040322023536.GB21226@plato.local.lan>
References: <20040322023536.GB21226@plato.local.lan>
Content-Type: text/plain
Message-Id: <1079924850.912.171.camel@gaston>
Mime-Version: 1.0
Date: Mon, 22 Mar 2004 14:07:31 +1100
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, 2004-03-22 at 13:35, Ethan Benson wrote:

> * You must have 2.6.4 or newer, previous versions lack necessary sysfs
>   information.

Isn't 2.6.3 enough ?

> * You must have sysfs mounted (normally on /sys, but ofpath should be
>   able to detect where its mounted).
>
> * You must still have /proc/ide so if this becomes a configurable
>   option like /proc/scsi you must have it enabled (/proc/scsi is also
>   required for machines with SATA drives).

Note that if you are using a G5 with DART enabled (that is with more
than 2Gb of RAM), you _MUST_ apply the following patch, or access to
the /proc/scsi/sata_svw entry will break the driver:

diff -Nru a/arch/ppc64/kernel/pmac_iommu.c b/arch/ppc64/kernel/pmac_iommu.c
--- a/arch/ppc64/kernel/pmac_iommu.c	Tue Mar 16 08:10:33 2004
+++ b/arch/ppc64/kernel/pmac_iommu.c	Tue Mar 16 08:10:33 2004
@@ -289,8 +289,11 @@
 	 * things simple. Setup all PCI devices to point to this table
 	 */
 	while ((dev = pci_find_device(PCI_ANY_ID, PCI_ANY_ID, dev)) != NULL) {
-		dn = PCI_GET_DN(dev);
-
+		/* We must use pci_device_to_OF_node() to make sure that
+		 * we get the real "final" pointer to the device in the
+		 * pci_dev sysdata and not the temporary PHB one
+		 */
+		struct device_node *dn = pci_device_to_OF_node(dev);
 		if (dn)
 			dn->iommu_table = &iommu_table_pmac;
 	}

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
