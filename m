Return-Path: <kou.ishizaki@toshiba.co.jp>
Received: from imx12.toshiba.co.jp (imx12.toshiba.co.jp [61.202.160.132])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 481D6DDDF2
	for <linuxppc-dev@ozlabs.org>; Fri, 12 Jan 2007 11:56:50 +1100 (EST)
Date: Fri, 12 Jan 2007 09:56:44 +0900 (JST)
Message-Id: <200701120056.l0C0uiaf015567@toshiba.co.jp>
Subject: [PATCH 3/19] powerpc: Fix oprofile support on Cell LPAR
To: paulus@samba.org
From: Ishizaki Kou <kou.ishizaki@toshiba.co.jp>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Op_model_cell supports native Cell. By returning -EINVAL, oprofile
uses timer interrupt on Cell LPAR.

Signed-off-by: Kou Ishizaki <kou.ishizaki@toshiba.co.jp>
Acked-by: Arnd Bergmann <arnd.bergmann@de.ibm.com>
---

Index: linux-powerpc-git/arch/powerpc/oprofile/common.c
diff -u linux-powerpc-git/arch/powerpc/oprofile/common.c:1.1.1.1 linux-powerpc-git/arch/powerpc/oprofile/common.c:1.2
--- linux-powerpc-git/arch/powerpc/oprofile/common.c:1.1.1.1	Wed Dec  6 08:25:43 2006
+++ linux-powerpc-git/arch/powerpc/oprofile/common.c	Wed Dec  6 08:43:15 2006
@@ -149,6 +149,8 @@
 #ifdef CONFIG_PPC64
 #ifdef CONFIG_PPC_CELL_NATIVE
 		case PPC_OPROFILE_CELL:
+			if (firmware_has_feature(FW_FEATURE_LPAR))
+				return -ENODEV;
 			model = &op_model_cell;
 			break;
 #endif
