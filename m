Return-Path: <SRS0+5a82b16ffd545f977f24+1392+infradead.org+dwmw2@canuck.srs.infradead.org>
Received: from canuck.infradead.org (canuck.infradead.org [209.217.80.40])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 083A3DDDFD
	for <linuxppc-dev@ozlabs.org>; Sat, 16 Jun 2007 21:18:11 +1000 (EST)
Subject: [PATCH] Wire up sys_sync_file_range() on powerpc
From: David Woodhouse <dwmw2@infradead.org>
To: paulus@samba.org, akpm@osdl.org
Content-Type: text/plain
Date: Sat, 16 Jun 2007 12:18:00 +0100
Message-Id: <1181992681.25228.683.camel@pmac.infradead.org>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Every time I build a ppc kernel it bitches at me that
sys_sync_file_range is unimplemented. Shut it up...

Signed-off-by: David Woodhouse <dwmw2@infradead.org>

---
The compat bit is untested although the assembly looks right, when
compared with 32-bit calls to sys_sync_file_range(). Test kernel
building now, although I leave for the airport within 24 hours and may
not get round to actually testing it.

diff --git a/arch/powerpc/kernel/sys_ppc32.c b/arch/powerpc/kernel/sys_ppc32.c
index 047246a..14a2654 100644
--- a/arch/powerpc/kernel/sys_ppc32.c
+++ b/arch/powerpc/kernel/sys_ppc32.c
@@ -810,3 +810,13 @@ asmlinkage long compat_sys_request_key(const char __user *_type,
 	return sys_request_key(_type, _description, _callout_info, destringid);
 }
 
+asmlinkage long compat_sys_sync_file_range(int fd, int dummy,
+				   unsigned offset_hi, unsigned offset_lo,
+				   unsigned nbytes_hi, unsigned nbytes_lo,
+				   int flags)
+{
+	loff_t offset = ((loff_t)offset_hi << 32) | offset_lo;
+	loff_t nbytes = ((loff_t)nbytes_hi << 32) | nbytes_lo;
+
+	return sys_sync_file_range(fd, offset, nbytes, flags);
+}
diff --git a/include/asm-powerpc/systbl.h b/include/asm-powerpc/systbl.h
index 700ca59..b75ce1c 100644
--- a/include/asm-powerpc/systbl.h
+++ b/include/asm-powerpc/systbl.h
@@ -311,3 +311,4 @@ COMPAT_SYS_SPU(utimensat)
 COMPAT_SYS_SPU(signalfd)
 COMPAT_SYS_SPU(timerfd)
 SYSCALL_SPU(eventfd)
+COMPAT_SYS_SPU(sync_file_range)
diff --git a/include/asm-powerpc/unistd.h b/include/asm-powerpc/unistd.h
index e3c28dc..a4f8e7f 100644
--- a/include/asm-powerpc/unistd.h
+++ b/include/asm-powerpc/unistd.h
@@ -330,10 +330,11 @@
 #define __NR_signalfd		305
 #define __NR_timerfd		306
 #define __NR_eventfd		307
+#define __NR_sync_file_range	308
 
 #ifdef __KERNEL__
 
-#define __NR_syscalls		308
+#define __NR_syscalls		309
 
 #define __NR__exit __NR_exit
 #define NR_syscalls	__NR_syscalls

-- 
dwmw2
