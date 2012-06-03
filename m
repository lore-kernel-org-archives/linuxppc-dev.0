Return-Path: <anton@samba.org>
Date: Mon, 4 Jun 2012 09:15:45 +1000
From: Anton Blanchard <anton@samba.org>
To: benh@kernel.crashing.org, paulus@samba.org, michael@ellerman.id.au
Subject: [PATCH] powerpc: pseries: Round up MSI-X requests
Message-ID: <20120604091545.03ce738b@kryten>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


The pseries firmware currently refuses any non power of two MSI-X
request. Unfortunately most network drivers end up asking for that
because they want a power of two for RX queues and one or two extra
for everything else.

This patch rounds up the firmware request to the next power of two
if the quota allows it.

Signed-off-by: Anton Blanchard <anton@samba.org>
---        

Index: linux-build/arch/powerpc/platforms/pseries/msi.c
===================================================================
--- linux-build.orig/arch/powerpc/platforms/pseries/msi.c	2012-06-03 20:49:29.082280031 +1000
+++ linux-build/arch/powerpc/platforms/pseries/msi.c	2012-06-04 09:06:55.909732276 +1000
@@ -402,6 +402,18 @@ static int rtas_setup_msi_irqs(struct pc
 		return -EINVAL;
 
 	/*
+	 * Firmware currently refuse any non power of two allocation
+	 * so we round up if the quota will allow it.
+	 */
+	if (type == PCI_CAP_ID_MSIX) {
+		int m = roundup_pow_of_two(nvec);
+		int quota = msi_quota_for_device(pdev, m);
+
+		if (quota >= m)
+			nvec = m;
+	}
+
+	/*
 	 * Try the new more explicit firmware interface, if that fails fall
 	 * back to the old interface. The old interface is known to never
 	 * return MSI-Xs.
