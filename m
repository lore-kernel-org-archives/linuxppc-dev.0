Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 5EE89DDE4A
	for <linuxppc-dev@ozlabs.org>; Sun, 22 Jul 2007 00:37:26 +1000 (EST)
Date: Sun, 22 Jul 2007 00:37:38 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: paulus@samba.org
Subject: [PATCH] [POWERPC] quiet section mismatch warning on pcibios_setup
Message-Id: <20070722003738.cc0854f8.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: ppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

WARNING: vmlinux.o(.text+0x1cefcc): Section mismatch: reference to .init.text:.pcibios_setup (between '.pci_setup' and '.pci_init')

pci_setup() is marked __devinit and calls pcibios_setup.

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 arch/powerpc/kernel/pci-common.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

Built for PowerPC allmodconfig and ppc64_defconfig.
-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au

diff --git a/arch/powerpc/kernel/pci-common.c b/arch/powerpc/kernel/pci-common.c
index 94b4a02..fe7d125 100644
--- a/arch/powerpc/kernel/pci-common.c
+++ b/arch/powerpc/kernel/pci-common.c
@@ -166,7 +166,7 @@ int pcibios_add_platform_entries(struct pci_dev *pdev)
 
 }
 
-char __init *pcibios_setup(char *str)
+char __devinit *pcibios_setup(char *str)
 {
 	return str;
 }
-- 
1.5.2.3
