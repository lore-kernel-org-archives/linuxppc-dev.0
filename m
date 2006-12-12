Return-Path: <kou.ishizaki@toshiba.co.jp>
Received: from inet-tsb5.toshiba.co.jp (inet-tsb5.toshiba.co.jp [202.33.96.24])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id DEF6067C65
	for <linuxppc-dev@ozlabs.org>; Tue, 12 Dec 2006 15:02:35 +1100 (EST)
Date: Tue, 12 Dec 2006 13:02:29 +0900 (JST)
Message-Id: <200612120402.kBC42USg007674@toshiba.co.jp>
To: paulus@samba.org, linuxppc-dev@ozlabs.org
Subject: [PATCH 12/15] powerpc: Do not use op_model_cell under LPAR 
From: Ishizaki Kou <kou.ishizaki@toshiba.co.jp>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

op_model_cell supports native Cell processor. Under LPAR environment,
it cannot work.

Signed-off-by: Kou Ishizaki <kou.ishizaki.co.jp>
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
