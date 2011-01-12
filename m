Return-Path: <anton@samba.org>
Date: Wed, 12 Jan 2011 16:44:30 +1100
From: Anton Blanchard <anton@samba.org>
To: benh@kernel.crashing.org, paulus@samba.org
Subject: [PATCH 1/9] powerpc: Print 32 bits of DSISR in show_regs
Message-ID: <20110112164430.5ac00b94@kryten>
In-Reply-To: <20110112164318.753a435b@kryten>
References: <20110112164318.753a435b@kryten>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


We were printing 64 bits of DSISR in show_regs even though it is 32 bit.

Signed-off-by: Anton Blanchard <anton@samba.org>
---

Index: powerpc.git/arch/powerpc/kernel/process.c
===================================================================
--- powerpc.git.orig/arch/powerpc/kernel/process.c	2010-10-15 13:23:24.911164446 +1100
+++ powerpc.git/arch/powerpc/kernel/process.c	2010-10-15 13:23:28.611206248 +1100
@@ -631,7 +631,7 @@ void show_regs(struct pt_regs * regs)
 #ifdef CONFIG_PPC_ADV_DEBUG_REGS
 		printk("DEAR: "REG", ESR: "REG"\n", regs->dar, regs->dsisr);
 #else
-		printk("DAR: "REG", DSISR: "REG"\n", regs->dar, regs->dsisr);
+		printk("DAR: "REG", DSISR: %08lx\n", regs->dar, regs->dsisr);
 #endif
 	printk("TASK = %p[%d] '%s' THREAD: %p",
 	       current, task_pid_nr(current), current->comm, task_thread_info(current));
