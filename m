Return-Path: <schwab@suse.de>
Received: from mx1.suse.de (ns.suse.de [195.135.220.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx1.suse.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 752AA67BB6
	for <linuxppc-dev@ozlabs.org>; Tue,  5 Sep 2006 05:27:32 +1000 (EST)
Received: from Relay1.suse.de (mail2.suse.de [195.135.221.8])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.suse.de (Postfix) with ESMTP id 68F11FE3A
	for <linuxppc-dev@ozlabs.org>; Mon,  4 Sep 2006 21:27:27 +0200 (CEST)
From: Andreas Schwab <schwab@suse.de>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] Unwire set/get_robust_list
Date: Mon, 04 Sep 2006 21:27:26 +0200
Message-ID: <jeodtvfn4x.fsf@sykes.suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The syscalls set/get_robust_list must not be wired up until
futex_atomic_cmpxchg_inatomic is implemented.  Otherwise the kernel will
hang in handle_futex_death.

Signed-off-by: Andreas Schwab <schwab@suse.de>

Index: linux-2.6.18-rc6/include/asm-powerpc/systbl.h
===================================================================
--- linux-2.6.18-rc6.orig/include/asm-powerpc/systbl.h	2006-09-04 18:12:43.000000000 +0200
+++ linux-2.6.18-rc6/include/asm-powerpc/systbl.h	2006-09-04 20:54:42.000000000 +0200
@@ -302,5 +302,5 @@ SYSCALL_SPU(symlinkat)
 SYSCALL_SPU(readlinkat)
 SYSCALL_SPU(fchmodat)
 SYSCALL_SPU(faccessat)
-COMPAT_SYS_SPU(get_robust_list)
-COMPAT_SYS_SPU(set_robust_list)
+SYSCALL(ni_syscall)
+SYSCALL(ni_syscall)
Index: linux-2.6.18-rc6/include/asm-powerpc/unistd.h
===================================================================
--- linux-2.6.18-rc6.orig/include/asm-powerpc/unistd.h	2006-09-04 18:12:43.000000000 +0200
+++ linux-2.6.18-rc6/include/asm-powerpc/unistd.h	2006-09-04 20:55:30.000000000 +0200
@@ -321,8 +321,8 @@
 #define __NR_readlinkat		296
 #define __NR_fchmodat		297
 #define __NR_faccessat		298
-#define __NR_get_robust_list	299
-#define __NR_set_robust_list	300
+/* Number 299 reserved for get_robust_list */
+/* Number 300 reserved for set_robust_list */
 
 #ifdef __KERNEL__
 

Andreas.

-- 
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE Linux Products GmbH, Maxfeldstraße 5, 90409 Nürnberg, Germany
PGP key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
