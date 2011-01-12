Return-Path: <anton@samba.org>
Date: Wed, 12 Jan 2011 16:48:14 +1100
From: Anton Blanchard <anton@samba.org>
To: benh@kernel.crashing.org, paulus@samba.org
Subject: [PATCH 5/9] powerpc: Don't silently handle machine checks from
	userspace
Message-ID: <20110112164814.4f6e27f4@kryten>
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


If a machine check comes from userspace we send a SIGBUS to the task and
fail to printk anything.

If we are taking machine checks due to bad hardware we want to know about
it right away. Furthermore if we don't complain loudly then it will look
a lot like a bug in the userspace application, potentially causing a lot
of confusion.

Signed-off-by: Anton Blanchard <anton@samba.org>
---

I seem to remember this might be here for X on 32bit. If necessary I can
wrap it in an ifdef CONFIG_PPC32.

Index: powerpc.git/arch/powerpc/kernel/traps.c
===================================================================
--- powerpc.git.orig/arch/powerpc/kernel/traps.c	2011-01-11 13:46:47.391281975 +1100
+++ powerpc.git/arch/powerpc/kernel/traps.c	2011-01-11 13:46:49.141336198 +1100
@@ -626,11 +626,6 @@ void machine_check_exception(struct pt_r
 	if (recover > 0)
 		return;
 
-	if (user_mode(regs)) {
-		_exception(SIGBUS, regs, BUS_ADRERR, regs->nip);
-		return;
-	}
-
 #if defined(CONFIG_8xx) && defined(CONFIG_PCI)
 	/* the qspan pci read routines can cause machine checks -- Cort
 	 *
