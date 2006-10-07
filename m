Return-Path: <Geoffrey.Levand@am.sony.com>
Received: from outbound2-blu-R.bigfish.com (outbound-blu.frontbridge.com
	[65.55.251.16])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 72D5767EC0
	for <linuxppc-dev@ozlabs.org>; Sat,  7 Oct 2006 11:53:43 +1000 (EST)
Message-ID: <452708A0.1040208@am.sony.com>
Date: Fri, 06 Oct 2006 18:53:36 -0700
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] spufs: change ppc_rtas declaration to weak
References: <45255069.2020206@am.sony.com> <200610061354.00398.arnd@arndb.de>
In-Reply-To: <200610061354.00398.arnd@arndb.de>
Content-Type: text/plain; charset=UTF-8
Cc: Andrew_Pinski@PlayStation.Sony.Com, linuxppc-dev@ozlabs.org,
	paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Arnd Bergmann wrote:
> On Thursday 05 October 2006 20:35, Geoff Levand wrote:
>> Index: cell--common--5/include/asm-powerpc/syscalls.h
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> --- cell--common--5.orig/include/asm-powerpc/syscalls.h
>> +++ cell--common--5/include/asm-powerpc/syscalls.h
>> @@ -37,7 +37,7 @@
>> =EF=BF=BDasmlinkage int sys_ipc(uint call, int first, unsigned long se=
cond,
>> =EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=
=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BDl=
ong third, void __user *ptr, long fifth);
>> =EF=BF=BDasmlinkage long ppc64_personality(unsigned long personality);
>> -asmlinkage int ppc_rtas(struct rtas_args __user *uargs);
>> +asmlinkage int ppc_rtas(struct rtas_args __user *uargs) __attribute__=
((weak));
>> =EF=BF=BDasmlinkage time_t sys64_time(time_t __user * tloc);
>> =EF=BF=BDasmlinkage long ppc_newuname(struct new_utsname __user * name=
);
>> =EF=BF=BD
>=20
> Hmm, I can't see why this does the right thing. __attribute__((weak)) s=
hould
> normally be put only into the definition of a function, not into the co=
mmon
> declaration. This looks like it makes _both_ definitions (kernel/sys.c =
and
> arch/powerpc/kernel/rtas.c) weak, so on pseries it becomes unspecific w=
hich
> one is actually used.


You're right, I see now that that fix just worked by pure chance.


> The problem that this is trying to work around is probably caused by th=
e
> dot-symbols: cond_syscall defines a ".ppc_rtas", but not a "ppc_rtas" s=
ymbol,
> which spufs tries to resolve.


Yes, on studying the code produced I found that the problem was that
cond_syscall() didn't create a non-dot symbol that the C linkage of
spu_syscall_table[] expected, as seen here:

./arch/powerpc/platforms/cell/spu_callbacks.o
                 U ppc_rtas
./kernel/sys_ni.o
0000000000000000 W .ppc_rtas

As you suggested to try, the method used by ia64 works properly, creating=
 both
a dot and a non-dot weak symbol:

./kernel/sys_ni.o
0000000000000000 W .ppc_rtas
0000000000000000 W ppc_rtas

Updated patch follows.

-Geoff



Change the definition of powerpc's cond_syscall() to use the standard gcc
weak attribute specifier which provides proper support for C linkage as
needed by spu_syscall_table[].

Fixes this powerpc build error with CONFIG_SPU_FS=3Dy, CONFIG_PPC_RTAS=3D=
n:

 arch/powerpc/platforms/built-in.o: undefined reference to `ppc_rtas'


Signed-off-by: Geoff Levand <geoffrey.levand@am.sony.com>

---

Build tests done with pseries_defconfig, cell_defconfig and ebony_defconf=
ig.

>From what I could determine, the toolchain troubles are no longer relevan=
t
with the recent change to a minimum version of gcc 3.2 for kernel builds.
Confirmation of this point would be appreciated.

=20
Index: cell--common--5/include/asm-powerpc/unistd.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- cell--common--5.orig/include/asm-powerpc/unistd.h
+++ cell--common--5/include/asm-powerpc/unistd.h
@@ -445,7 +445,6 @@
 #include <linux/types.h>
 #include <linux/compiler.h>
 #include <linux/linkage.h>
-#include <asm/syscalls.h>
=20
 #define __ARCH_WANT_IPC_PARSE_VERSION
 #define __ARCH_WANT_OLD_READDIR
@@ -487,16 +486,9 @@
=20
 /*
  * "Conditional" syscalls
- *
- * What we want is __attribute__((weak,alias("sys_ni_syscall"))),
- * but it doesn't work on all toolchains, so we just do it by hand
  */
-#ifdef CONFIG_PPC32
-#define cond_syscall(x) asm(".weak\t" #x "\n\t.set\t" #x ",sys_ni_syscal=
l")
-#else
-#define cond_syscall(x) asm(".weak\t." #x "\n\t.set\t." #x ",.sys_ni_sys=
call")
-#endif
-
+#define cond_syscall(x) \
+	asmlinkage long x (void) __attribute__((weak,alias("sys_ni_syscall")))
=20
 #endif		/* __ASSEMBLY__ */
 #endif		/* __KERNEL__ */
