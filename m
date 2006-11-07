Return-Path: <michael@ozlabs.org>
To: <linuxppc-dev@ozlabs.org>
From: Michael Ellerman <michael@ellerman.id.au>
Date: Tue, 07 Nov 2006 18:21:20 +1100
Subject: [RFC/PATCH 0/7] Powerpc MSI Implementation
Message-Id: <1162884080.585336.70559261997.qpush@cradle>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>,
	Greg Kroah-Hartman <greg@kroah.com>, linux-pci@atrey.karlin.mff.cuni.cz,
	"David S. Miller" <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Another cut at a Powerpc MSI implementation. This is working with the MPIC
backend, still haven't tested the RTAS backend.

Things I remember changing since last time:
 * Fixed a few bugs pointed out by Jake.
 * We discover the MPIC magic address via the PCI config space rather than
   hard coding it.
 * We reuse pdev->irq in the MPIC backend for now. This is nasty but works.
 * Moved msi_info into the pci_dev. This is ugly, but not sure where else
   we can put it, pci_dn is no longer an option.
 * Added a place holder msi_info->msix_base pointer.
 * Still haven't implement raw MSIX enabled, todo.
 * Removed the msi_info->priv. No on was using it, can always put it back.
 * Added lots of debugging in anticipation of getting some firware to test on.
 ...

cheers
