Return-Path: <geoff@infradead.org>
Message-Id: <72c642c83a42c0d3b007afafd9456f087b2f52a2.1421109719.git.geoff@infradead.org>
In-Reply-To: <cover.1421109719.git.geoff@infradead.org>
References: <cover.1421109719.git.geoff@infradead.org>
From: Geoff Levand <geoff@infradead.org>
Subject: [PATCH 5/6] powerpc/ps3: Fix sys-manager-core sparse warnings
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Tue, 13 Jan 2015 01:00:20 +0000
Cc: cbe-oss-dev@lists.ozlabs.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Fixes warnings like these:

  drivers/ps3/sys-manager-core.c: error: symbol 'ps3_sys_manager_power_off' redeclared with different type

Signed-off-by: Geoff Levand <geoff@infradead.org>
---
 drivers/ps3/sys-manager-core.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/ps3/sys-manager-core.c b/drivers/ps3/sys-manager-core.c
index 0e41737..c429ffc 100644
--- a/drivers/ps3/sys-manager-core.c
+++ b/drivers/ps3/sys-manager-core.c
@@ -47,7 +47,7 @@ void ps3_sys_manager_register_ops(const struct ps3_sys_manager_ops *ops)
 }
 EXPORT_SYMBOL_GPL(ps3_sys_manager_register_ops);
 
-void ps3_sys_manager_power_off(void)
+void __noreturn ps3_sys_manager_power_off(void)
 {
 	if (ps3_sys_manager_ops.power_off)
 		ps3_sys_manager_ops.power_off(ps3_sys_manager_ops.dev);
@@ -55,7 +55,7 @@ void ps3_sys_manager_power_off(void)
 	ps3_sys_manager_halt();
 }
 
-void ps3_sys_manager_restart(void)
+void __noreturn ps3_sys_manager_restart(void)
 {
 	if (ps3_sys_manager_ops.restart)
 		ps3_sys_manager_ops.restart(ps3_sys_manager_ops.dev);
@@ -63,7 +63,7 @@ void ps3_sys_manager_restart(void)
 	ps3_sys_manager_halt();
 }
 
-void ps3_sys_manager_halt(void)
+void __noreturn ps3_sys_manager_halt(void)
 {
 	pr_emerg("System Halted, OK to turn off power\n");
 	local_irq_disable();
-- 
1.9.1
