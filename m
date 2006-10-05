Return-Path: <Geoffrey.Levand@am.sony.com>
Received: from outbound3-sin-R.bigfish.com (outbound-sin.frontbridge.com
	[207.46.51.80])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 90B2867D39
	for <linuxppc-dev@ozlabs.org>; Fri,  6 Oct 2006 04:56:09 +1000 (EST)
Message-ID: <45255069.2020206@am.sony.com>
Date: Thu, 05 Oct 2006 11:35:21 -0700
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: paulus@samba.org
Subject: [PATCH] spufs: change ppc_rtas declaration to weak
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev@ozlabs.org, Arnd Bergmann <arnd@arndb.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The symbol ppc_rtas is defined as weak, but the declaration is missing the
weak attribute specifier.  The improper declaration causes problems when
linking the ppc_rtas reference in spu_syscall_table[] (spu_callbacks.c)
when RTAS support is not enabled.

Fixes this powerpc build error with CONFIG_SPU_FS=y, CONFIG_PPC_RTAS=n:

 arch/powerpc/platforms/built-in.o: undefined reference to `ppc_rtas'


Signed-off-by: Geoff Levand <geoffrey.levand@am.sony.com>

---

I did a test build with pseries_defconfig and verified the proper routine is
linked in.  No run time test done.


Index: cell--common--5/include/asm-powerpc/syscalls.h
===================================================================
--- cell--common--5.orig/include/asm-powerpc/syscalls.h
+++ cell--common--5/include/asm-powerpc/syscalls.h
@@ -37,7 +37,7 @@
 asmlinkage int sys_ipc(uint call, int first, unsigned long second,
 		long third, void __user *ptr, long fifth);
 asmlinkage long ppc64_personality(unsigned long personality);
-asmlinkage int ppc_rtas(struct rtas_args __user *uargs);
+asmlinkage int ppc_rtas(struct rtas_args __user *uargs) __attribute__((weak));
 asmlinkage time_t sys64_time(time_t __user * tloc);
 asmlinkage long ppc_newuname(struct new_utsname __user * name);
 
