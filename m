Return-Path: <SRS0+9a9b41b4b968bc645e25+1394+infradead.org+dwmw2@pentafluge.srs.infradead.org>
Received: from pentafluge.infradead.org (pentafluge.infradead.org
	[213.146.154.40])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 31885DDEF3
	for <linuxppc-dev@ozlabs.org>; Mon, 18 Jun 2007 19:24:58 +1000 (EST)
Subject: Re: [PATCH] Wire up sys_sync_file_range() on powerpc
From: David Woodhouse <dwmw2@infradead.org>
To: Paul Mackerras <paulus@samba.org>
In-Reply-To: <18038.6658.854660.4233@cargo.ozlabs.ibm.com>
References: <1181992681.25228.683.camel@pmac.infradead.org>
	<1182018044.2808.75.camel@pmac.infradead.org>
	<18038.6658.854660.4233@cargo.ozlabs.ibm.com>
Content-Type: text/plain
Date: Mon, 18 Jun 2007 17:25:11 +0800
Message-Id: <1182158711.2799.78.camel@shinybook.infradead.org>
Mime-Version: 1.0
Cc: akpm@osdl.org, linux-arch@vger.kernel.org, linuxppc-dev@ozlabs.org,
	torvalds@osdl.org, drepper@redhat.com, rmk@arm.linux.org.uk
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 2007-06-18 at 15:37 +1000, Paul Mackerras wrote:
> David Woodhouse writes:
> 
> > Pants.
> 
> Ah.  Is that a naughty word in the UK?  If so I'll have to remember
> that when I go to kernel summit. :)

I think the most important thing you have to remember about 'pants'
while in the UK is that you don't wear them on the outside.

> > It doesn't work because the 'flags' argument ends up in r9, and
> > we can only use r3-r8 for syscall arguments. We'll need to do it the
> > same way as ARM does, with the flags as the second argument.
> 
> Yes.  We'll need a wrapper for both 32-bit and for 32-on-64.
> 
> > Or is it? Can we ditch sys_sync_file_range now and implement a new
> > sys_sync_file_range2 with the two 32-bit arguments first?
> 
> Would be nice...

It might look something like this... I can't test it sensibly till I get
home next week; anyone else want to poke at it?

(Note that glibc's syscall() doesn't get 64-bit arguments like this
right; you'll want to implement do_sync_file_range() in assembly if
you're using Andrew's original test program.)

        .section ".text"
        .globl do_sync_file_range
        .type   do_sync_file_range, @function
do_sync_file_range:
        stwu 1,-16(1)
        mflr 0
        stw 31,12(1)
        stw 0,20(1)
        li 0,308
        sc           
        mfcr 0      
        andis. 9,0,4096
        mr 31,3
        beq 0,.L6
        bl __errno_location
        li 0,-1
        stw 31,0(3)
.L6:
        mr 3,0
        lwz 0,20(1)
        lwz 31,12(1)
        addi 1,1,16
        mtlr 0
        blr
        .size   do_sync_file_range,.-do_sync_file_range

---
[PATCH] Add sys_sync_file_range2() system call
... with more sensible ABI, for those architectures which hated
sys_sync_file_range() for wasting argument slots by misaligning 64-bit
values. Convert ARM to use it, wire it up on PowerPC, and prevent the
missing syscall checker from bitching about sync_file_range if you have
sync_file_range2 instead.

Signed-off-by: David Woodhouse <dwmw2@infradead.org>

diff --git a/arch/arm/kernel/calls.S b/arch/arm/kernel/calls.S
index 19326d7..a98d0c9 100644
--- a/arch/arm/kernel/calls.S
+++ b/arch/arm/kernel/calls.S
@@ -350,7 +350,7 @@
 		CALL(sys_set_robust_list)
 		CALL(sys_get_robust_list)
 /* 340 */	CALL(sys_splice)
-		CALL(sys_arm_sync_file_range)
+		CALL(sys_sync_file_range2)
 		CALL(sys_tee)
 		CALL(sys_vmsplice)
 		CALL(sys_move_pages)
diff --git a/arch/arm/kernel/sys_arm.c b/arch/arm/kernel/sys_arm.c
index 1ca2d51..4d25e49 100644
--- a/arch/arm/kernel/sys_arm.c
+++ b/arch/arm/kernel/sys_arm.c
@@ -328,16 +328,3 @@ asmlinkage long sys_arm_fadvise64_64(int fd, int advice,
 {
 	return sys_fadvise64_64(fd, offset, len, advice);
 }
-
-/*
- * Yet more syscall fsckage - we can't fit sys_sync_file_range's
- * arguments into the available registers with EABI.  So, let's
- * create an ARM specific syscall for this which has _sane_
- * arguments.  (This incidentally also has an ABI-independent
- * argument layout.)
- */
-asmlinkage long sys_arm_sync_file_range(int fd, unsigned int flags,
-					loff_t offset, loff_t nbytes)
-{
-	return sys_sync_file_range(fd, offset, nbytes, flags);
-}
diff --git a/arch/powerpc/kernel/sys_ppc32.c b/arch/powerpc/kernel/sys_ppc32.c
index 047246a..b42cbf1 100644
--- a/arch/powerpc/kernel/sys_ppc32.c
+++ b/arch/powerpc/kernel/sys_ppc32.c
@@ -810,3 +810,12 @@ asmlinkage long compat_sys_request_key(const char __user *_type,
 	return sys_request_key(_type, _description, _callout_info, destringid);
 }
 
+asmlinkage long compat_sys_sync_file_range2(int fd, unsigned int flags,
+				   unsigned offset_hi, unsigned offset_lo,
+				   unsigned nbytes_hi, unsigned nbytes_lo)
+{
+	loff_t offset = ((loff_t)offset_hi << 32) | offset_lo;
+	loff_t nbytes = ((loff_t)nbytes_hi << 32) | nbytes_lo;
+
+	return sys_sync_file_range(fd, offset, nbytes, flags);
+}
diff --git a/fs/sync.c b/fs/sync.c
index 2f97576..7cd005e 100644
--- a/fs/sync.c
+++ b/fs/sync.c
@@ -236,6 +236,14 @@ out:
 	return ret;
 }
 
+/* It would be nice if people remember that not all the world's an i386
+   when they introduce new system calls */
+asmlinkage long sys_sync_file_range2(int fd, unsigned int flags,
+				     loff_t offset, loff_t nbytes)
+{
+	return sys_sync_file_range(fd, offset, nbytes, flags);
+}
+
 /*
  * `endbyte' is inclusive
  */
diff --git a/include/asm-arm/unistd.h b/include/asm-arm/unistd.h
index 250d7f1..bfdbebe 100644
--- a/include/asm-arm/unistd.h
+++ b/include/asm-arm/unistd.h
@@ -367,6 +367,7 @@
 #define __NR_get_robust_list		(__NR_SYSCALL_BASE+339)
 #define __NR_splice			(__NR_SYSCALL_BASE+340)
 #define __NR_arm_sync_file_range	(__NR_SYSCALL_BASE+341)
+#define __NR_sync_file_range2		__NR_arm_sync_file_range
 #define __NR_tee			(__NR_SYSCALL_BASE+342)
 #define __NR_vmsplice			(__NR_SYSCALL_BASE+343)
 #define __NR_move_pages			(__NR_SYSCALL_BASE+344)
diff --git a/include/asm-powerpc/systbl.h b/include/asm-powerpc/systbl.h
index 700ca59..1cc3f9c 100644
--- a/include/asm-powerpc/systbl.h
+++ b/include/asm-powerpc/systbl.h
@@ -311,3 +311,4 @@ COMPAT_SYS_SPU(utimensat)
 COMPAT_SYS_SPU(signalfd)
 COMPAT_SYS_SPU(timerfd)
 SYSCALL_SPU(eventfd)
+COMPAT_SYS_SPU(sync_file_range2)
diff --git a/include/asm-powerpc/unistd.h b/include/asm-powerpc/unistd.h
index e3c28dc..f71c606 100644
--- a/include/asm-powerpc/unistd.h
+++ b/include/asm-powerpc/unistd.h
@@ -330,10 +330,11 @@
 #define __NR_signalfd		305
 #define __NR_timerfd		306
 #define __NR_eventfd		307
+#define __NR_sync_file_range2	308
 
 #ifdef __KERNEL__
 
-#define __NR_syscalls		308
+#define __NR_syscalls		309
 
 #define __NR__exit __NR_exit
 #define NR_syscalls	__NR_syscalls
diff --git a/scripts/checksyscalls.sh b/scripts/checksyscalls.sh
index f98171f..0dcc01c 100755
--- a/scripts/checksyscalls.sh
+++ b/scripts/checksyscalls.sh
@@ -99,6 +99,11 @@ cat << EOF
 #define __IGNORE_setfsuid32
 #define __IGNORE_setfsgid32
 
+/* sync_file_range had a stupid ABI. Allow sync_file_range2 instead */
+#ifdef __NR_sync_file_range2
+#define __IGNORE_sync_file_range
+#endif
+
 /* Unmerged syscalls for AFS, STREAMS, etc. */
 #define __IGNORE_afs_syscall
 #define __IGNORE_getpmsg


-- 
dwmw2
