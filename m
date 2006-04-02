Return-Path: <anton@ozlabs.org>
Date: Sun, 2 Apr 2006 19:54:09 +1000
From: Anton Blanchard <anton@samba.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc: Ensure runlatch is off in the idle loop
Message-ID: <20060402095409.GJ23416@krispykreme>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Since external and decrementer interrupts set the runlatch on, we need
to ensure its set off again in the idle loop. At the moment we dont turn
it off in the inner loop.

Signed-off-by: Anton Blanchard <anton@samba.org>
---

Index: build/arch/powerpc/kernel/idle.c
===================================================================
--- build.orig/arch/powerpc/kernel/idle.c	2006-03-30 10:08:47.000000000 +1100
+++ build/arch/powerpc/kernel/idle.c	2006-04-01 21:35:54.000000000 +1100
@@ -50,9 +50,9 @@ void cpu_idle(void)
 
 	set_thread_flag(TIF_POLLING_NRFLAG);
 	while (1) {
-		ppc64_runlatch_off();
-
 		while (!need_resched() && !cpu_should_die()) {
+			ppc64_runlatch_off();
+
 			if (ppc_md.power_save) {
 				clear_thread_flag(TIF_POLLING_NRFLAG);
 				/*
