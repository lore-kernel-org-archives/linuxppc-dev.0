Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id 20410DDD04
	for <linuxppc-dev@ozlabs.org>; Thu, 31 Jan 2008 14:34:38 +1100 (EST)
Date: Wed, 30 Jan 2008 21:34:47 -0600
From: Olof Johansson <olof@lixom.net>
To: Paul Mackerras <paulus@samba.org>
Subject: [PATCH] [POWERPC] Fix compilation for CONFIG_DEBUGGER=n and
	CONFIG_KEXEC=y
Message-ID: <20080131033447.GA28125@lixom.net>
References: <18337.8955.539106.868486@cargo.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <18337.8955.539106.868486@cargo.ozlabs.ibm.com>
Cc: linuxppc-dev@ozlabs.org, torvalds@linux-foundation.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Looks like "[POWERPC] kdump shutdown hook support" broke builds when
CONFIG_DEBUGGER=n and CONFIG_KEXEC=y, such as in g5_defconfig:

arch/powerpc/kernel/crash.c: In function 'default_machine_crash_shutdown':
arch/powerpc/kernel/crash.c:388: error: '__debugger_fault_handler' undeclared (first use in this function)
arch/powerpc/kernel/crash.c:388: error: (Each undeclared identifier is reported only once
arch/powerpc/kernel/crash.c:388: error: for each function it appears in.)

Move the debugger hooks to under CONFIG_DEBUGGER || CONFIG_KEXEC, since
that's when the crash code is enabled.

(I should have caught this with my build-script pre-merge, my bad. :( )


Signed-off-by: Olof Johansson <olof@lixom.net>


diff --git a/arch/powerpc/kernel/traps.c b/arch/powerpc/kernel/traps.c
index 848a204..4b5b7ff 100644
--- a/arch/powerpc/kernel/traps.c
+++ b/arch/powerpc/kernel/traps.c
@@ -54,7 +54,7 @@
 #endif
 #include <asm/kexec.h>
 
-#ifdef CONFIG_DEBUGGER
+#if defined(CONFIG_DEBUGGER) || defined(CONFIG_KEXEC)
 int (*__debugger)(struct pt_regs *regs);
 int (*__debugger_ipi)(struct pt_regs *regs);
 int (*__debugger_bpt)(struct pt_regs *regs);
diff --git a/include/asm-powerpc/system.h b/include/asm-powerpc/system.h
index bc9739d..8d37283 100644
--- a/include/asm-powerpc/system.h
+++ b/include/asm-powerpc/system.h
@@ -65,7 +65,7 @@
 struct task_struct;
 struct pt_regs;
 
-#ifdef CONFIG_DEBUGGER
+#if defined(CONFIG_DEBUGGER) || defined(CONFIG_KEXEC)
 
 extern int (*__debugger)(struct pt_regs *regs);
 extern int (*__debugger_ipi)(struct pt_regs *regs);
