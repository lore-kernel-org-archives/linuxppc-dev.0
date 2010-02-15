Return-Path: <anton@ozlabs.org>
Date: Mon, 15 Feb 2010 12:40:28 +1100
From: Anton Blanchard <anton@samba.org>
To: benh@kernel.crashing.org, paulus@samba.org
Subject: [PATCH] powerpc: Don't clear larx reservation on system call exit
Message-ID: <20100215014028.GB13355@kryten>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


Right now we clear the larx reservation on every system call exit. No code
should exist that tries to make use of larx/stcx across a system call (because
it would fail 100% of the time).

We could continue to play it safe but system call latency affects so many
workloads. In the past we have already cut down the set of registers we
save and restore across a system call and this could be seen as an
extension of that. The PowerPC system call ABI does not (and could not)
preserve a larx reservation.

On POWER6 the poster child for system call improvements, getppid, improves 6%.

A more useful test is the private futex wake system call and that improves 5%.
This is a decent speedup on an important system call for threaded applications.

Signed-off-by: Anton Blanchard <anton@samba.org>
---
If my previous patches didn't worry you then this one is sure to.

Getting this wrong will make someone's life miserable, so it could do with
some double checking (eg we don't branch through there on other exceptions and
we dont invoke system calls from the kernel that rely on the reservation being
cleared).

Index: powerpc.git/arch/powerpc/kernel/entry_64.S
===================================================================
--- powerpc.git.orig/arch/powerpc/kernel/entry_64.S	2010-02-13 16:26:43.794322638 +1100
+++ powerpc.git/arch/powerpc/kernel/entry_64.S	2010-02-13 16:27:03.205575405 +1100
@@ -202,7 +202,6 @@ syscall_exit:
 	bge-	syscall_error
 syscall_error_cont:
 	ld	r7,_NIP(r1)
-	stdcx.	r0,0,r1			/* to clear the reservation */
 	andi.	r6,r8,MSR_PR
 	ld	r4,_LINK(r1)
 	/*
