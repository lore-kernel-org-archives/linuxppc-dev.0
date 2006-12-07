Return-Path: <MAILER-DAEMON@rune.sasl.smtp.pobox.com>
Received: from lollipop.listbox.com (lollipop.listbox.com [208.210.124.78])
	by ozlabs.org (Postfix) with ESMTP id 37AEE67C42
	for <linuxppc-dev@ozlabs.org>; Thu,  7 Dec 2006 13:28:46 +1100 (EST)
Received: from rune.pobox.com (rune.pobox.com [208.210.124.79])
	by lollipop.listbox.com (Postfix) with ESMTP id 6D58D48BDF7
	for <linuxppc-dev@ozlabs.org>; Wed,  6 Dec 2006 19:51:28 -0500 (EST)
From: Nathan Lynch <ntl@pobox.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 1/4] maple: match "pcie" name for CPC945
Date: Wed,  6 Dec 2006 18:50:43 -0600
Message-Id: <11654526463043-git-send-email-ntl@pobox.com>
Cc: paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Some firmwares have "pcie" for the "name" property of the CPC945 PCI
Express host bridge.  Check for "pcie" in addition to "pci" so we
don't miss it.

Signed-off-by: Nathan Lynch <ntl@pobox.com>
---
 arch/powerpc/platforms/maple/pci.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/platforms/maple/pci.c b/arch/powerpc/platforms/maple/pci.c
index 3a32ded..3f6a69f 100644
--- a/arch/powerpc/platforms/maple/pci.c
+++ b/arch/powerpc/platforms/maple/pci.c
@@ -562,7 +562,7 @@ void __init maple_pci_init(void)
 	for (np = NULL; (np = of_get_next_child(root, np)) != NULL;) {
 		if (np->name == NULL)
 			continue;
-		if (strcmp(np->name, "pci") == 0) {
+		if (!strcmp(np->name, "pci") || !strcmp(np->name, "pcie")) {
 			if (add_bridge(np) == 0)
 				of_node_get(np);
 		}
-- 
1.4.4.1
