Return-Path: <benh@ozlabs.org>
To: Paul Mackerras <paulus@samba.org>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Tue, 13 Nov 2007 13:46:52 +1100
Subject: [PATCH] powerpc: Fix early btext debug on PowerMac
Message-Id: <20071113024730.C7DC4DDE23@ozlabs.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The early btext debug wouldn't work on PowerMac when booted from BootX
due to the code looking for the wrong property name.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---

 arch/powerpc/kernel/btext.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

Index: linux-work/arch/powerpc/kernel/btext.c
===================================================================
--- linux-work.orig/arch/powerpc/kernel/btext.c	2007-11-13 13:39:09.000000000 +1100
+++ linux-work/arch/powerpc/kernel/btext.c	2007-11-13 13:43:23.000000000 +1100
@@ -186,7 +186,9 @@ int btext_initialize(struct device_node 
 		pitch = *prop;
 	if (pitch == 1)
 		pitch = 0x1000;
-	prop = of_get_property(np, "address", NULL);
+	prop = of_get_property(np, "linux,bootx-addr", NULL);
+	if (prop == NULL)
+		prop = of_get_property(np, "address", NULL);
 	if (prop)
 		address = *prop;
 
