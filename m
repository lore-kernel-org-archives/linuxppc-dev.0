Return-Path: <npiggin@gmail.com>
Received: from mail-pg0-x244.google.com (mail-pg0-x244.google.com
 [IPv6:2607:f8b0:400e:c05::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yb8Ww4WDpzDqZB
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Nov 2017 23:07:08 +1100 (AEDT)
Received: by mail-pg0-x244.google.com with SMTP id l19so9941104pgo.2
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Nov 2017 04:07:08 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>
Subject: [PATCH] powerpc/32: Add .data.rel* sections explicitly
Date: Mon, 13 Nov 2017 23:06:55 +1100
Message-Id: <20171113120655.30725-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Match powerpc/64 and include .data.rel* input sections in the .data output
section explicitly.

This solves the warning:

powerpc-linux-gnu-ld: warning: orphan section `.data.rel.ro' from `arch/powerpc/kernel/head_44x.o' being placed in section `.data.rel.ro'.

Link: https://lists.01.org/pipermail/kbuild-all/2017-November/040010.html
Reported-by: kbuild test robot <fengguang.wu@intel.com>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/kernel/vmlinux.lds.S | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/powerpc/kernel/vmlinux.lds.S b/arch/powerpc/kernel/vmlinux.lds.S
index 0494e1566ee2..51e4ec92ade1 100644
--- a/arch/powerpc/kernel/vmlinux.lds.S
+++ b/arch/powerpc/kernel/vmlinux.lds.S
@@ -264,6 +264,7 @@ SECTIONS
 #ifdef CONFIG_PPC32
 	.data : AT(ADDR(.data) - LOAD_OFFSET) {
 		DATA_DATA
+		*(.data.rel*)
 		*(.sdata)
 		*(.sdata2)
 		*(.got.plt) *(.got)
-- 
2.15.0
