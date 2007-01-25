Return-Path: <michael@ozlabs.org>
To: linux-pci@atrey.karlin.mff.cuni.cz
From: Michael Ellerman <michael@ellerman.id.au>
Date: Thu, 25 Jan 2007 19:34:18 +1100
Subject: [RFC/PATCH 16/16] Activate MSI for the MPIC backend on U3
In-Reply-To: <1169714047.65693.647693675533.qpush@cradle>
Message-Id: <20070125083419.AF227DE3FA@ozlabs.org>
Cc: Greg Kroah-Hartman <greg@kroah.com>, Kyle McMartin <kyle@parisc-linux.org>,
	linuxppc-dev@ozlabs.org, Brice Goglin <brice@myri.com>,
	shaohua.li@intel.com, "David S. Miller" <davem@davemloft.net>,
	"Eric W. Biederman" <ebiederm@xmission.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

If we have a U3 and it's the primary, enable MSIs via HT.

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---

 arch/powerpc/sysdev/mpic.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

Index: msi/arch/powerpc/sysdev/mpic.c
===================================================================
--- msi.orig/arch/powerpc/sysdev/mpic.c
+++ msi/arch/powerpc/sysdev/mpic.c
@@ -1171,8 +1171,10 @@ void __init mpic_init(struct mpic *mpic)
 
 	/* Do the HT PIC fixups on U3 broken mpic */
 	DBG("MPIC flags: %x\n", mpic->flags);
-	if ((mpic->flags & MPIC_BROKEN_U3) && (mpic->flags & MPIC_PRIMARY))
- 		mpic_scan_ht_pics(mpic);
+	if ((mpic->flags & MPIC_BROKEN_U3) && (mpic->flags & MPIC_PRIMARY)) {
+		mpic_scan_ht_pics(mpic);
+		mpic_htmsi_init(mpic);
+	}
 
 	for (i = 0; i < mpic->num_sources; i++) {
 		/* start with vector = source number, and masked */
