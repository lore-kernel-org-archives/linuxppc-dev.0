Return-Path: <michael@ozlabs.org>
To: Greg Kroah-Hartman <greg@kroah.com>
From: Michael Ellerman <michael@ellerman.id.au>
Date: Thu, 11 Jan 2007 22:25:25 +1100
Subject: [PATCH 7/7] Activate MSI for the MPIC backend on U3
In-Reply-To: <1168514716.63474.857278133999.qpush@cradle>
Message-Id: <20070111112508.B224DDDEC9@ozlabs.org>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	Olof Johannsson <olof@lixom.net>, linux-pci@atrey.karlin.mff.cuni.cz
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
