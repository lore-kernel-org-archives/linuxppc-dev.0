Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 8B50CDDE2D
	for <linuxppc-dev@ozlabs.org>; Tue,  5 Feb 2008 13:13:16 +1100 (EST)
Date: Tue, 5 Feb 2008 13:13:15 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Michael Ellerman <michael@ellerman.id.au>
Subject: [PATCH] [POWERPC] avoid possible extra of_node_put in axon_msi.c
Message-Id: <20080205131315.b8e652e8.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: ppc-dev <linuxppc-dev@ozlabs.org>, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

I got this warning from gcc:
arch/powerpc/platforms/cell/axon_msi.c:118: warning: 'tmp' may be used uninitialized in this function

Which turns out to be a false positive, but pointed out that it was
possible for the error path in find_msi_translator() to do an extra
of_node_put on a node.  This fixes it by localising the ref counting
a bit. As a side effect, the warning goes away.

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 arch/powerpc/platforms/cell/axon_msi.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/platforms/cell/axon_msi.c b/arch/powerpc/platforms/cell/axon_msi.c
index 095988f..7a177ba 100644
--- a/arch/powerpc/platforms/cell/axon_msi.c
+++ b/arch/powerpc/platforms/cell/axon_msi.c
@@ -139,6 +139,7 @@ static struct axon_msic *find_msi_translator(struct pci_dev *dev)
 
 	tmp = dn;
 	dn = of_find_node_by_phandle(*ph);
+	of_node_put(tmp);
 	if (!dn) {
 		dev_dbg(&dev->dev,
 			"axon_msi: msi-translator doesn't point to a node\n");
@@ -156,7 +157,6 @@ static struct axon_msic *find_msi_translator(struct pci_dev *dev)
 
 out_error:
 	of_node_put(dn);
-	of_node_put(tmp);
 
 	return msic;
 }
-- 
1.5.4

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/
