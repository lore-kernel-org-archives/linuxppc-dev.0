Return-Path: <anton@samba.org>
Date: Tue, 4 Sep 2012 12:48:46 +1000
From: Anton Blanchard <anton@samba.org>
To: benh@kernel.crashing.org, paulus@samba.org
Subject: [PATCH 2/4] powerpc: Keep thread.dscr and thread.dscr_inherit in sync
Message-ID: <20120904124846.27edd33c@kryten>
In-Reply-To: <20120904124756.4ddeb535@kryten>
References: <20120904124756.4ddeb535@kryten>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


When we update the DSCR either via emulation of mtspr(DSCR) or via
a change to dscr_default in sysfs we don't update thread.dscr.
We will eventually update it at context switch time but there is
a period where thread.dscr is incorrect.

If we fork at this point we will copy the old value of thread.dscr
into the child. To avoid this, always keep thread.dscr in sync with
reality.

This issue was found with the following testcase:

http://ozlabs.org/~anton/junkcode/dscr_inherit_test.c

Signed-off-by: Anton Blanchard <anton@samba.org>  
Cc: <stable@kernel.org> # 3.0+
---

Index: b/arch/powerpc/kernel/traps.c
===================================================================
--- a/arch/powerpc/kernel/traps.c
+++ b/arch/powerpc/kernel/traps.c
@@ -972,8 +972,9 @@ static int emulate_instruction(struct pt
 			cpu_has_feature(CPU_FTR_DSCR)) {
 		PPC_WARN_EMULATED(mtdscr, regs);
 		rd = (instword >> 21) & 0x1f;
-		mtspr(SPRN_DSCR, regs->gpr[rd]);
+		current->thread.dscr = regs->gpr[rd];
 		current->thread.dscr_inherit = 1;
+		mtspr(SPRN_DSCR, current->thread.dscr);
 		return 0;
 	}
 #endif
Index: b/arch/powerpc/kernel/sysfs.c
===================================================================
--- a/arch/powerpc/kernel/sysfs.c
+++ b/arch/powerpc/kernel/sysfs.c
@@ -196,8 +196,10 @@ static ssize_t show_dscr_default(struct
 
 static void update_dscr(void *dummy)
 {
-	if (!current->thread.dscr_inherit)
+	if (!current->thread.dscr_inherit) {
+		current->thread.dscr = dscr_default;
 		mtspr(SPRN_DSCR, dscr_default);
+	}
 }
 
 static ssize_t __used store_dscr_default(struct device *dev,
