Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.179]) by ozlabs.org (Postfix) with ESMTP id 15803DDE33
	for <linuxppc-dev@ozlabs.org>; Thu, 29 Nov 2007 00:33:34 +1100 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: 2.6.24-rc3-mm2 - Build Failure on powerpc timerfd() undeclared
Date: Wed, 28 Nov 2007 14:32:07 +0100
References: <20071128034140.648383f0.akpm@linux-foundation.org>
	<474D61CF.6080400@linux.vnet.ibm.com>
In-Reply-To: <474D61CF.6080400@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200711281432.09178.arnd@arndb.de>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Balbir Singh <balbir@linux.vnet.ibm.com>,
	Paul Mackerras <paulus@samba.org>, linux-kernel@vger.kernel.org,
	Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wednesday 28 November 2007, Kamalesh Babulal wrote:
> Kernel build fails, with build error
>=20
> =C2=A0 CC =C2=A0 =C2=A0 =C2=A0arch/powerpc/platforms/cell/spu_callbacks.o
> In file included from arch/powerpc/platforms/cell/spu_callbacks.c:49:
> include/asm/systbl.h:312: error: =E2=80=98sys_timerfd=E2=80=99 undeclared=
 here (not in a function)
> make[2]: *** [arch/powerpc/platforms/cell/spu_callbacks.o] Error 1
> make[1]: *** [arch/powerpc/platforms/cell] Error 2
> make: *** [arch/powerpc/platforms] Error 2
>=20

I guess all architectures except x86 are currently broken because they
reference the old sys_timerfd function. This patch should add the missing
bits to powerpc.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>

=2D--

Disclaimer: Not tested at all, just applied common sense.
Disclaimer2: conflicts with the sys_indirect kernel implementation
sent by paulus last week.

diff --git a/include/asm-powerpc/systbl.h b/include/asm-powerpc/systbl.h
index 11d5383..b029368 100644
=2D-- a/include/asm-powerpc/systbl.h
+++ b/include/asm-powerpc/systbl.h
@@ -309,7 +309,9 @@ SYSCALL_SPU(getcpu)
 COMPAT_SYS(epoll_pwait)
 COMPAT_SYS_SPU(utimensat)
 COMPAT_SYS_SPU(signalfd)
=2DCOMPAT_SYS_SPU(timerfd)
+COMPAT_SYS_SPU(timerfd_create)
 SYSCALL_SPU(eventfd)
 COMPAT_SYS_SPU(sync_file_range2)
 COMPAT_SYS(fallocate)
+COMPAT_SYS_SPU(sys_timerfd_settime)
+COMPAT_SYS_SPU(sys_timerfd_gettime)
diff --git a/include/asm-powerpc/unistd.h b/include/asm-powerpc/unistd.h
index 97d82b6..4ba2d20 100644
=2D-- a/include/asm-powerpc/unistd.h
+++ b/include/asm-powerpc/unistd.h
@@ -328,14 +328,16 @@
 #define __NR_epoll_pwait	303
 #define __NR_utimensat		304
 #define __NR_signalfd		305
=2D#define __NR_timerfd		306
+#define __NR_timerfd_create	306
 #define __NR_eventfd		307
 #define __NR_sync_file_range2	308
 #define __NR_fallocate		309
+#define __NR_sys_timerfd_settime 310
+#define __NR_sys_timerfd_gettime 311
=20
 #ifdef __KERNEL__
=20
=2D#define __NR_syscalls		310
+#define __NR_syscalls		312
=20
 #define __NR__exit __NR_exit
 #define NR_syscalls	__NR_syscalls
