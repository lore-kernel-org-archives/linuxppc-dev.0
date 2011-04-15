Return-Path: <michael@ozlabs.org>
To: <linuxppc-dev@ozlabs.org>
Message-Id: <bbe411555c95e56ba427ebf638d5333b1870af77.1302856271.git.michael@ellerman.id.au>
In-Reply-To: <d284a5076d7760656470a5fd16d98ec6501a9bf3.1302856271.git.michael@ellerman.id.au>
References: <d284a5076d7760656470a5fd16d98ec6501a9bf3.1302856271.git.michael@ellerman.id.au>
Subject: [PATCH 12/15] powerpc/book3e: Use way 3 for linear mapping bolted
	entry
Date: Fri, 15 Apr 2011 18:32:04 +1000 (EST)
From: michael@ozlabs.org (Michael Ellerman)
Cc: Jimi Xenidis <jimix@watson.ibm.com>, jack@codezen.org, imunsie@au.ibm.com,
	David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Benjamin Herrenschmidt <benh@kernel.crashing.org>

An erratum on A2 can lead to the bolted entry we insert for the linear
mapping being evicted, to avoid that write the bolted entry to way 3.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---
 arch/powerpc/kernel/exceptions-64e.S |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kernel/exceptions-64e.S b/arch/powerpc/kernel/exceptions-64e.S
index 5c43063..e6c0926 100644
--- a/arch/powerpc/kernel/exceptions-64e.S
+++ b/arch/powerpc/kernel/exceptions-64e.S
@@ -864,8 +864,9 @@ have_hes:
 	 * that will have to be made dependent on whether we are running under
 	 * a hypervisor I suppose.
 	 */
-	ori	r3,r3,MAS0_HES | MAS0_WQ_ALLWAYS
-	mtspr	SPRN_MAS0,r3
+	ori	r11,r3,MAS0_WQ_ALLWAYS
+	oris	r11,r11,MAS0_ESEL(3)@h /* Use way 3: workaround A2 erratum 376 */
+	mtspr	SPRN_MAS0,r11
 	lis	r3,(MAS1_VALID | MAS1_IPROT)@h
 	ori	r3,r3,BOOK3E_PAGESZ_1GB << MAS1_TSIZE_SHIFT
 	mtspr	SPRN_MAS1,r3
-- 
1.7.1
