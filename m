Return-Path: <anton@samba.org>
Date: Wed, 12 Jan 2011 16:45:31 +1100
From: Anton Blanchard <anton@samba.org>
To: benh@kernel.crashing.org, paulus@samba.org
Subject: [PATCH 2/9] powerpc: Don't force MSR_RI in machine_check_exception
Message-ID: <20110112164531.0f8ea467@kryten>
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


We should never force MSR_RI on. If we take a machine check with MSR_RI off
then we have no chance of recovering safely.

Signed-off-by: Anton Blanchard <anton@samba.org>
---

Index: powerpc.git/arch/powerpc/kernel/traps.c
===================================================================
--- powerpc.git.orig/arch/powerpc/kernel/traps.c	2011-01-11 13:46:39.541038778 +1100
+++ powerpc.git/arch/powerpc/kernel/traps.c	2011-01-11 13:46:42.601133580 +1100
@@ -627,7 +627,6 @@ void machine_check_exception(struct pt_r
 		return;
 
 	if (user_mode(regs)) {
-		regs->msr |= MSR_RI;
 		_exception(SIGBUS, regs, BUS_ADRERR, regs->nip);
 		return;
 	}
@@ -643,10 +642,8 @@ void machine_check_exception(struct pt_r
 	return;
 #endif
 
-	if (debugger_fault_handler(regs)) {
-		regs->msr |= MSR_RI;
+	if (debugger_fault_handler(regs))
 		return;
-	}
 
 	if (check_io_access(regs))
 		return;
