Return-Path: <michael@ozlabs.org>
To: Paul Mackerras <paulus@samba.org>
From: Michael Ellerman <michael@ellerman.id.au>
Date: Tue, 21 Mar 2006 20:46:10 +1100
Subject: [PATCH 10/11] powerpc: iseries: Add bootargs to /chosen
In-Reply-To: <1142934351.193140.181086235013.qpush@concordia>
Message-Id: <20060321094639.7DCE067AC7@ozlabs.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Add the command line args to the device tree as /chosen/bootargs.

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---

 arch/powerpc/platforms/iseries/setup.c |    1 +
 1 files changed, 1 insertion(+)

Index: to-merge/arch/powerpc/platforms/iseries/setup.c
===================================================================
--- to-merge.orig/arch/powerpc/platforms/iseries/setup.c
+++ to-merge/arch/powerpc/platforms/iseries/setup.c
@@ -931,6 +931,7 @@ void build_flat_dt(struct iseries_flat_d
 	/* /chosen */
 	dt_start_node(dt, "chosen");
 	dt_prop_u32(dt, "linux,platform", PLATFORM_ISERIES_LPAR);
+	dt_prop_str(dt, "bootargs", cmd_line);
 	if (cmd_mem_limit)
 		dt_prop_u64(dt, "linux,memory-limit", cmd_mem_limit);
 	dt_end_node(dt);
