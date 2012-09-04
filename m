Return-Path: <anton@samba.org>
Date: Tue, 4 Sep 2012 12:49:47 +1000
From: Anton Blanchard <anton@samba.org>
To: benh@kernel.crashing.org, paulus@samba.org
Subject: [PATCH 3/4] powerpc: Fix DSCR inheritance in copy_thread()
Message-ID: <20120904124947.009dd177@kryten>
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


If the default DSCR is non zero we set thread.dscr_inherit in
copy_thread() meaning the new thread and all its children will ignore
future updates to the default DSCR. This is not intended and is
a change in behaviour that a number of our users have hit.

We just need to inherit thread.dscr and thread.dscr_inherit from
the parent which ends up being much simpler.

This was found with the following test case:

http://ozlabs.org/~anton/junkcode/dscr_default_test.c

Signed-off-by: Anton Blanchard <anton@samba.org>  
Cc: <stable@kernel.org> # 3.0+
---

Index: b/arch/powerpc/kernel/process.c
===================================================================
--- a/arch/powerpc/kernel/process.c
+++ b/arch/powerpc/kernel/process.c
@@ -802,16 +802,8 @@ int copy_thread(unsigned long clone_flag
 #endif /* CONFIG_PPC_STD_MMU_64 */
 #ifdef CONFIG_PPC64 
 	if (cpu_has_feature(CPU_FTR_DSCR)) {
-		if (current->thread.dscr_inherit) {
-			p->thread.dscr_inherit = 1;
-			p->thread.dscr = current->thread.dscr;
-		} else if (0 != dscr_default) {
-			p->thread.dscr_inherit = 1;
-			p->thread.dscr = dscr_default;
-		} else {
-			p->thread.dscr_inherit = 0;
-			p->thread.dscr = 0;
-		}
+		p->thread.dscr_inherit = current->thread.dscr_inherit;
+		p->thread.dscr = current->thread.dscr;
 	}
 #endif
 
