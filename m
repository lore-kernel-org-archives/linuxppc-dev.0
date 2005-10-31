Return-Path: <horms@koto.vergenet.net>
Received: from koto.vergenet.net (koto.vergenet.net [210.128.90.7])
	by ozlabs.org (Postfix) with ESMTP id 25ECA68641
	for <linuxppc-dev@ozlabs.org>; Tue,  1 Nov 2005 00:29:48 +1100 (EST)
Date: Mon, 31 Oct 2005 22:11:00 +0900
From: Horms <horms@verge.net.au>
To: linuxppc-dev@ozlabs.org
Message-ID: <20051031131059.GA7645@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Andrew Morton <akpm@osdl.org>, david@woodhou.se
Subject: audit_sysctl_exit can only be used with CONF_AUDIT_SYSCTL
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This section of code calls .audit_syscal_exit,
but is inside CONFIG_AUDIT, so it will fail to build
if CONFIG_AUDITSYSCALL is not defined. 

After discussion with David Woodhouse, change the 
ifdef to CONFIG_AUDITSYSCALL


Signed-off-by: Horms <horms@verge.net.au>

diff --git a/arch/powerpc/kernel/entry_64.S b/arch/powerpc/kernel/entry_64.S
index 984a106..2d22bf0 100644
--- a/arch/powerpc/kernel/entry_64.S
+++ b/arch/powerpc/kernel/entry_64.S
@@ -279,7 +279,7 @@ _GLOBAL(ppc32_rt_sigsuspend)
 	bne	syscall_exit
 	/* If sigsuspend() returns zero, we are going into a signal handler. We
 	   may need to call audit_syscall_exit() to mark the exit from sigsuspend() */
-#ifdef CONFIG_AUDIT
+#ifdef CONFIG_AUDITSYSCALL
 	ld	r3,PACACURRENT(r13)
 	ld	r4,AUDITCONTEXT(r3)
 	cmpdi	0,r4,0
