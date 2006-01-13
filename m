Return-Path: <galak@gate.crashing.org>
Date: Fri, 13 Jan 2006 10:15:17 -0600 (CST)
From: Kumar Gala <galak@gate.crashing.org>
To: Paul Mackerras <paulus@samba.org>
Subject: [PATCH] powerpc: Allow for ppc_md restart, power_off, and halt to
	be NULL
Message-ID: <Pine.LNX.4.44.0601131014350.18314-100000@gate.crashing.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, linuxppc64-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On a number of embedded reference boards there isn't always a
way to reset, power_off, or halt the board.  Rather than having
each board implement a spin loop just let the generic code do
it.

Signed-off-by: Kumar Gala <galak@kernel.crashing.org>

---
commit be64cad3bdcae667f790fcf6f3e066be498baa83
tree 1437c325cfda412ded472c3dee505f81468f41b0
parent 66c0ddd1284ef56bfeb41374b51edfd0c8a980a8
author Kumar Gala <galak@kernel.crashing.org> Fri, 13 Jan 2006 09:46:28 -0600
committer Kumar Gala <galak@kernel.crashing.org> Fri, 13 Jan 2006 09:46:28 -0600

 arch/powerpc/kernel/setup-common.c |    9 ++++++---
 1 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/kernel/setup-common.c b/arch/powerpc/kernel/setup-common.c
index d5c52fa..be12041 100644
--- a/arch/powerpc/kernel/setup-common.c
+++ b/arch/powerpc/kernel/setup-common.c
@@ -100,7 +100,8 @@ void machine_shutdown(void)
 void machine_restart(char *cmd)
 {
 	machine_shutdown();
-	ppc_md.restart(cmd);
+	if (ppc_md.restart)
+		ppc_md.restart(cmd);
 #ifdef CONFIG_SMP
 	smp_send_stop();
 #endif
@@ -112,7 +113,8 @@ void machine_restart(char *cmd)
 void machine_power_off(void)
 {
 	machine_shutdown();
-	ppc_md.power_off();
+	if (ppc_md.power_off)
+		ppc_md.power_off();
 #ifdef CONFIG_SMP
 	smp_send_stop();
 #endif
@@ -129,7 +131,8 @@ EXPORT_SYMBOL_GPL(pm_power_off);
 void machine_halt(void)
 {
 	machine_shutdown();
-	ppc_md.halt();
+	if (ppc_md.halt)
+		ppc_md.halt();
 #ifdef CONFIG_SMP
 	smp_send_stop();
 #endif
