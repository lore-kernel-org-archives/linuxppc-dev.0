Return-Path: <B32579@freescale.com>
Received: from VA3EHSOBE007.bigfish.com (va3ehsobe006.messaging.microsoft.com
	[216.32.180.16]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Cybertrust SureServer Standard Validation CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 55A36B6EDD
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed,  6 Apr 2011 17:25:12 +1000 (EST)
From: Prabhakar Kushwaha <prabhakar@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH] powerpc/kernel: Don't add disabled serial device
Date: Wed, 6 Apr 2011 12:56:29 +0530
Message-ID: <1302074789-442-1-git-send-email-prabhakar@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: meet2prabhu@gmail.com, Prabhakar Kushwaha <prabhakar@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

serial port nodes with the property status="disabled" are not usable and so
avoid adding "disabled" port with the system.

Signed-off-by: Prabhakar Kushwaha <prabhakar@freescale.com>
---
 Based upon git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git(branch master)
 
 This patch is made to support "Re-organizing P1020RDB P2020RDB dts". Creation
 of Serial port node doesn't follow of_platform_device_create() way which takes
 care case status = "disabled".

 arch/powerpc/kernel/legacy_serial.c |    8 +++++---
 1 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/kernel/legacy_serial.c b/arch/powerpc/kernel/legacy_serial.c
index c834757..26566ca 100644
--- a/arch/powerpc/kernel/legacy_serial.c
+++ b/arch/powerpc/kernel/legacy_serial.c
@@ -330,9 +330,11 @@ void __init find_legacy_serial_ports(void)
 		if (!parent)
 			continue;
 		if (of_match_node(legacy_serial_parents, parent) != NULL) {
-			index = add_legacy_soc_port(np, np);
-			if (index >= 0 && np == stdout)
-				legacy_serial_console = index;
+			if (of_device_is_available(np)) {
+				index = add_legacy_soc_port(np, np);
+				if (index >= 0 && np == stdout)
+					legacy_serial_console = index;
+			}
 		}
 		of_node_put(parent);
 	}
-- 
1.7.3
