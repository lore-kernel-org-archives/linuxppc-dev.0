Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18776.5641.616932.285903@cargo.ozlabs.ibm.com>
Date: Mon, 29 Dec 2008 11:12:57 +1100
From: Paul Mackerras <paulus@samba.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc: Fix something
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

X has been failing to start on my quad G5 powermac since commit
1fd0f52583a85b21a394201b007bc1ee104b235d ("powerpc: Fix domain numbers
in /proc on 64-bit") went in.  The reason is that the change allows X
to see the PCI-PCI bridge above the video card (previously it was
obscured by the fact that there were two "00" directories in
/proc/bus/pci), and the pciconfig_iobase system call on the bridge is
failing because of a hack that we have to return information about the
AGP bus when X asks about bus 0.  This machine doesn't have an AGP bus
(it has PCI Express) and so the pciconfig_iobase call is returning -1,
which ultimately causes X to fail to start.

This fixes it by checking that we have an AGP bridge before
redirecting the pciconfig_iobase call to return information about the
AGP bus.  With this, X starts successfully both on a quad G5 with
PCI Express and on an older dual G5 with AGP.

Signed-off-by: Paul Mackerras <paulus@samba.org>
---

diff --git a/arch/powerpc/kernel/pci_64.c b/arch/powerpc/kernel/pci_64.c
index 39fadc6..586962f 100644
--- a/arch/powerpc/kernel/pci_64.c
+++ b/arch/powerpc/kernel/pci_64.c
@@ -560,9 +560,14 @@ long sys_pciconfig_iobase(long which, unsigned long in_bus,
 	 * G5 machines... So when something asks for bus 0 io base
 	 * (bus 0 is HT root), we return the AGP one instead.
 	 */
-	if (machine_is_compatible("MacRISC4"))
-		if (in_bus == 0)
+	if (in_bus == 0 && machine_is_compatible("MacRISC4")) {
+		struct device_node *agp;
+
+		agp = of_find_compatible_node(NULL, NULL, "u3-agp");
+		if (agp)
 			in_bus = 0xf0;
+		of_node_put(agp);
+	}
 
 	/* That syscall isn't quite compatible with PCI domains, but it's
 	 * used on pre-domains setup. We return the first match
