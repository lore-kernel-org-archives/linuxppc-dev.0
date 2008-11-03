Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id AEC51DDDEE
	for <linuxppc-dev@ozlabs.org>; Mon,  3 Nov 2008 18:07:16 +1100 (EST)
Date: Mon, 3 Nov 2008 18:07:12 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: pauus@samba.org
Subject: [PATCH] powerpc: remove unused variable from pci_dlpar.c
Message-Id: <20081103180712.0494af2b.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: ppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

And get rid of this build warning:

arch/powerpc/platforms/pseries/pci_dlpar.c: In function 'init_phb_dynamic':
arch/powerpc/platforms/pseries/pci_dlpar.c:192: warning: unused variable 'b'

This is one of the very few warnings left in a ppc64_defconfig build and
getting rid of it will make it easier to see future introduced ones (in
fact this was introduced very recently).

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 arch/powerpc/platforms/pseries/pci_dlpar.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

This patch is against Linus' tree and so could go into 2.6.28 if you
think it should.  This is also fixed by one of Ben's ominbus patches
(http://patchwork.ozlabs.org/patch/6041/) but this is more suitable for
upstream merge.

diff --git a/arch/powerpc/platforms/pseries/pci_dlpar.c b/arch/powerpc/platforms/pseries/pci_dlpar.c
index 31481dc..7190493 100644
--- a/arch/powerpc/platforms/pseries/pci_dlpar.c
+++ b/arch/powerpc/platforms/pseries/pci_dlpar.c
@@ -189,7 +189,6 @@ struct pci_controller * __devinit init_phb_dynamic(struct device_node *dn)
 {
 	struct pci_controller *phb;
 	int primary;
-	struct pci_bus *b;
 
 	primary = list_empty(&hose_list);
 	phb = pcibios_alloc_controller(dn);
-- 
1.5.6.5

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/
