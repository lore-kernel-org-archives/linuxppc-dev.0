Return-Path: <anton@samba.org>
Date: Wed, 12 Jan 2011 16:47:20 +1100
From: Anton Blanchard <anton@samba.org>
To: benh@kernel.crashing.org, paulus@samba.org
Subject: [PATCH 4/9] powerpc: Remove duplicate debugger hook in
	machine_check_exception
Message-ID: <20110112164720.7022e1b7@kryten>
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


We are calling debugger_fault_handler twice in machine_check_exception.

Signed-off-by: Anton Blanchard <anton@samba.org>
---

Index: powerpc.git/arch/powerpc/kernel/traps.c
===================================================================
--- powerpc.git.orig/arch/powerpc/kernel/traps.c	2011-01-11 13:46:42.601133580 +1100
+++ powerpc.git/arch/powerpc/kernel/traps.c	2011-01-11 13:46:47.391281975 +1100
@@ -648,8 +648,6 @@ void machine_check_exception(struct pt_r
 	if (check_io_access(regs))
 		return;
 
-	if (debugger_fault_handler(regs))
-		return;
 	die("Machine check", regs, SIGBUS);
 
 	/* Must die if the interrupt is not recoverable */
