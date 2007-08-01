Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 966B5DDDE9
	for <linuxppc-dev@ozlabs.org>; Thu,  2 Aug 2007 01:41:25 +1000 (EST)
From: Segher Boessenkool <segher@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] Fix a compile warning in pci_32.c
Date: Wed,  1 Aug 2007 17:41:13 +0200
Message-Id: <11859828761541-git-send-email-segher@kernel.crashing.org>
Message-Id: <576c3a210d014003c9d4b26f02a95099346f6716.1185982433.git.segher@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

__must_check, so do so.

Signed-off-by: Segher Boessenkool <segher@kernel.crashing.org>
---
 arch/powerpc/kernel/pci_32.c |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/kernel/pci_32.c b/arch/powerpc/kernel/pci_32.c
index cd35c96..04a3109 100644
--- a/arch/powerpc/kernel/pci_32.c
+++ b/arch/powerpc/kernel/pci_32.c
@@ -581,8 +581,11 @@ pcibios_assign_resources(void)
 			if ((r->flags & IORESOURCE_UNSET) && r->end &&
 			    (!ppc_md.pcibios_enable_device_hook ||
 			     !ppc_md.pcibios_enable_device_hook(dev, 1))) {
+				int rc;
+
 				r->flags &= ~IORESOURCE_UNSET;
-				pci_assign_resource(dev, idx);
+				rc = pci_assign_resource(dev, idx);
+				BUG_ON(rc);
 			}
 		}
 
-- 
1.5.2.1.144.gabc40-dirty
