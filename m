Return-Path: <bsingharora@gmail.com>
Received: from mail-pf0-x234.google.com (mail-pf0-x234.google.com
 [IPv6:2607:f8b0:400e:c00::234])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 7B5B21A006C
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  1 Feb 2016 17:04:00 +1100 (AEDT)
Received: by mail-pf0-x234.google.com with SMTP id x125so78081546pfb.0
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 31 Jan 2016 22:04:00 -0800 (PST)
Date: Mon, 1 Feb 2016 17:03:25 +1100
From: Balbir Singh <bsingharora@gmail.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Paul Mackerras <paulus@samba.org>, kgdb-bugreport@lists.sourceforge.net,
 linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] Fix kgdb on little endian ppc64le
Message-ID: <20160201170325.4ec4324e@cotter.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Balbir Singh <bsingharora@gmail.com>

I spent some time trying to use kgdb and debugged my inability to
resume from kgdb_handle_breakpoint(). NIP is not incremented
and that leads to a loop in the debugger.

I've tested this lightly on a virtual instance with KDB enabled.
After the patch, I am able to get the "go" command to work as
expected

Signed-off-by: Balbir Singh <bsingharora@gmail.com>
---
 arch/powerpc/kernel/kgdb.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/powerpc/kernel/kgdb.c b/arch/powerpc/kernel/kgdb.c
index e77c3cc..92c8f80 100644
--- a/arch/powerpc/kernel/kgdb.c
+++ b/arch/powerpc/kernel/kgdb.c
@@ -445,7 +445,11 @@ int kgdb_arch_handle_exception(int vector, int signo, int err_code,
  * Global data
  */
 struct kgdb_arch arch_kgdb_ops = {
+#ifdef __LITTLE_ENDIAN__
+	.gdb_bpt_instr = {0x08, 0x10, 0x82, 0x7d},
+#else
 	.gdb_bpt_instr = {0x7d, 0x82, 0x10, 0x08},
+#endif /* __LITTLE_ENDIAN__ */
 };
 
 static int kgdb_not_implemented(struct pt_regs *regs)
-- 
2.5.0
