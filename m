Return-Path: <michael@ozlabs.org>
To: <linuxppc-dev@ozlabs.org>
Message-Id: <ec7db3fa1052ff2797b77c41d441937b836a7ed0.1234865919.git.michael@ellerman.id.au>
From: Michael Ellerman <michael@ellerman.id.au>
Subject: [PATCH] powerpc/pseries: Return req#msi(-x) if request is larger
Date: Tue, 17 Feb 2009 21:18:49 +1100 (EST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

If a driver asks for more MSIs than the devices "req#msi(-x)" property,
we currently return -ENOSPC. This doesn't give the driver any chance to
make a new request with a number that might work.

So if "req#msi(-x)" is less than the request, return its value. To be
100% safe, make sure we return an error if req_msi == 0.

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---
 arch/powerpc/platforms/pseries/msi.c |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/msi.c b/arch/powerpc/platforms/pseries/msi.c
index b42dfa6..e56ae42 100644
--- a/arch/powerpc/platforms/pseries/msi.c
+++ b/arch/powerpc/platforms/pseries/msi.c
@@ -154,7 +154,11 @@ static int check_req(struct pci_dev *pdev, int nvec, char *prop_name)
 
 	if (*req_msi < nvec) {
 		pr_debug("rtas_msi: %s requests < %d MSIs\n", prop_name, nvec);
-		return -ENOSPC;
+
+		if (*req_msi == 0) /* Be paranoid */
+			return -ENOSPC;
+
+		return *req_msi;
 	}
 
 	return 0;
-- 
1.5.6.3
