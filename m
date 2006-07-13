Return-Path: <michael@ozlabs.org>
To: Stephen Rothwell <sfr@canb.auug.org.au>
From: Michael Ellerman <michael@ellerman.id.au>
Date: Thu, 13 Jul 2006 17:54:44 +1000
Subject: [PATCH 3/3] iseries: Fix a compiler warning in
	platforms/iseries/vpdinfo.c
In-Reply-To: <1152777279.500377.573076823663.qpush@concordia>
Message-Id: <20060713075444.9C0C167B95@ozlabs.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

PhbId might be used unitialised, so set it to 0xff (nothing) always.

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---

 arch/powerpc/platforms/iseries/vpdinfo.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: to-merge/arch/powerpc/platforms/iseries/vpdinfo.c
===================================================================
--- to-merge.orig/arch/powerpc/platforms/iseries/vpdinfo.c
+++ to-merge/arch/powerpc/platforms/iseries/vpdinfo.c
@@ -188,7 +188,7 @@ static void __init iSeries_Parse_Vpd(u8 
 {
 	u8 *TagPtr = VpdData;
 	int DataLen = VpdDataLen - 3;
-	u8 PhbId;
+	u8 PhbId = 0xff;
 
 	while ((*TagPtr != VpdEndOfAreaTag) && (DataLen > 0)) {
 		int AreaLen = *(TagPtr + 1) + (*(TagPtr + 2) * 256);
