Return-Path: <mikey@neuling.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vkCxr6md3zDqYY
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Mar 2017 14:04:48 +1100 (AEDT)
From: Michael Neuling <mikey@neuling.org>
To: mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org,
	mikey@neuling.org
Subject: [PATCH] powerpc: Teach oops about radix vectors
Date: Thu, 16 Mar 2017 14:04:40 +1100
Message-Id: <20170316030440.32320-1-mikey@neuling.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Currently if we oops caused by an 0x380 or 0x480 exception, we get a
print which assumes SLB problems. With radix, these vectors have
different meanings.

This patch updates the oops message to reflect these different
meanings.

Signed-off-by: Michael Neuling <mikey@neuling.org>
---
 arch/powerpc/xmon/xmon.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/xmon/xmon.c b/arch/powerpc/xmon/xmon.c
index 16321ad9e7..7781f78964 100644
--- a/arch/powerpc/xmon/xmon.c
+++ b/arch/powerpc/xmon/xmon.c
@@ -1347,9 +1347,19 @@ const char *getvecname(unsigned long vec)
 	case 0x100:	ret = "(System Reset)"; break;
 	case 0x200:	ret = "(Machine Check)"; break;
 	case 0x300:	ret = "(Data Access)"; break;
-	case 0x380:	ret = "(Data SLB Access)"; break;
+	case 0x380:
+		if (radix_enabled())
+			ret = "(Data Access Out of Range)";
+		else
+			ret = "(Data SLB Access)";
+		break;
 	case 0x400:	ret = "(Instruction Access)"; break;
-	case 0x480:	ret = "(Instruction SLB Access)"; break;
+	case 0x480:
+		if (radix_enabled())
+			ret = "(Instruction Access Out of Range)";
+		else
+			ret = "(Instruction SLB Access)";
+		break;
 	case 0x500:	ret = "(Hardware Interrupt)"; break;
 	case 0x600:	ret = "(Alignment)"; break;
 	case 0x700:	ret = "(Program Check)"; break;
-- 
2.9.3
