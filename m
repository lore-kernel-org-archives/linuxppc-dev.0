Return-Path: <mroos@linux.ee>
Received: from smtp2.it.da.ut.ee (smtp2.it.da.ut.ee
 [IPv6:2001:bb8:2002:500:20f:1fff:fe04:1bbb])
 by lists.ozlabs.org (Postfix) with ESMTP id 3yh1Q11NffzDrRY
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Nov 2017 21:03:50 +1100 (AEDT)
Date: Tue, 21 Nov 2017 12:03:40 +0200 (EET)
From: Meelis Roos <mroos@linux.ee>
Sender: mroos@math.ut.ee
To: Christophe Leroy <christophe.leroy@c-s.fr>
cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Scott Wood <oss@buserror.net>, Balbir Singh <bsingharora@gmail.com>,
 Linux Kernel list <linux-kernel@vger.kernel.org>,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] powerpc: fix boot on BOOK3S_32 with
 CONFIG_STRICT_KERNEL_RWX
In-Reply-To: <20171121094816.5EEC2687C5@po15668-vm-win7.idsi0.si.c-s.fr>
Message-ID: <alpine.LRH.2.21.1711211202460.30004@math.ut.ee>
References: <20171121094816.5EEC2687C5@po15668-vm-win7.idsi0.si.c-s.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-7
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> On powerpc32, patch_instruction() is called by apply_feature_fixups()
> which is called from early_init()
>=20
> There is the following note in front of early_init():
>  * Note that the kernel may be running at an address which is different
>  * from the address that it was linked at, so we must use RELOC/PTRRELO=
C
>  * to access static data (including strings).  -- paulus
>=20
> Therefore, slab_is_available() cannot be called yet, and
> text_poke_area must be addressed with PTRRELOC()

The patch does not build - does PTRRELOC need some additional header or=20
something?

  CHK     include/config/kernel.release
  CHK     include/generated/uapi/linux/version.h
  CHK     include/generated/utsrelease.h
  CHK     include/generated/bounds.h
  CHK     include/generated/timeconst.h
  CHK     include/generated/asm-offsets.h
  CALL    scripts/checksyscalls.sh
  CHK     scripts/mod/devicetable-offsets.h
  CHK     include/generated/compile.h
  CALL    arch/powerpc/kernel/systbl_chk.sh
  CALL    arch/powerpc/kernel/prom_init_check.sh
  CC      arch/powerpc/lib/code-patching.o
In file included from ./include/asm-generic/percpu.h:7:0,
                 from ./arch/powerpc/include/asm/percpu.h:20,
                 from ./include/linux/percpu.h:13,
                 from ./include/linux/kprobes.h:38,
                 from arch/powerpc/lib/code-patching.c:11:
arch/powerpc/lib/code-patching.c: In function =A1patch_instruction=A2:
arch/powerpc/lib/code-patching.c:150:22: error: implicit declaration of f=
unction =A1PTRRELOC=A2; did you mean =A1PTR_ERR=A2? [-Werror=3Dimplicit-f=
unction-declaration]
  if (!this_cpu_read(*PTRRELOC(&text_poke_area)))
                      ^
./include/linux/percpu-defs.h:305:9: note: in definition of macro =A1__pc=
pu_size_call_return=A2
  typeof(variable) pscr_ret__;     \
         ^~~~~~~~
arch/powerpc/lib/code-patching.c:150:7: note: in expansion of macro =A1th=
is_cpu_read=A2
  if (!this_cpu_read(*PTRRELOC(&text_poke_area)))
       ^~~~~~~~~~~~~
arch/powerpc/lib/code-patching.c:150:21: error: invalid type argument of =
unary =A1*=A2 (have =A1int=A2)
  if (!this_cpu_read(*PTRRELOC(&text_poke_area)))
                     ^~~~~~~~~~~~~~~~~~~~~~~~~~
./include/linux/percpu-defs.h:305:9: note: in definition of macro =A1__pc=
pu_size_call_return=A2
  typeof(variable) pscr_ret__;     \
         ^~~~~~~~
arch/powerpc/lib/code-patching.c:150:7: note: in expansion of macro =A1th=
is_cpu_read=A2
  if (!this_cpu_read(*PTRRELOC(&text_poke_area)))
       ^~~~~~~~~~~~~
arch/powerpc/lib/code-patching.c:150:21: error: invalid type argument of =
unary =A1*=A2 (have =A1int=A2)
  if (!this_cpu_read(*PTRRELOC(&text_poke_area)))
                     ^~~~~~~~~~~~~~~~~~~~~~~~~~
./include/linux/percpu-defs.h:206:47: note: in definition of macro =A1__v=
erify_pcpu_ptr=A2
  const void __percpu *__vpp_verify =3D (typeof((ptr) + 0))NULL; \
                                               ^~~
./include/linux/percpu-defs.h:494:29: note: in expansion of macro =A1__pc=
pu_size_call_return=A2
 #define this_cpu_read(pcp)  __pcpu_size_call_return(this_cpu_read_, pcp)
                             ^~~~~~~~~~~~~~~~~~~~~~~
arch/powerpc/lib/code-patching.c:150:7: note: in expansion of macro =A1th=
is_cpu_read=A2
  if (!this_cpu_read(*PTRRELOC(&text_poke_area)))
       ^~~~~~~~~~~~~
arch/powerpc/lib/code-patching.c:150:21: error: invalid type argument of =
unary =A1*=A2 (have =A1int=A2)
  if (!this_cpu_read(*PTRRELOC(&text_poke_area)))
                     ^~~~~~~~~~~~~~~~~~~~~~~~~~
./include/linux/percpu-defs.h:307:16: note: in definition of macro =A1__p=
cpu_size_call_return=A2
  switch(sizeof(variable)) {     \
                ^~~~~~~~
arch/powerpc/lib/code-patching.c:150:7: note: in expansion of macro =A1th=
is_cpu_read=A2
  if (!this_cpu_read(*PTRRELOC(&text_poke_area)))
       ^~~~~~~~~~~~~
In file included from ./arch/powerpc/include/asm/percpu.h:20:0,
                 from ./include/linux/percpu.h:13,
                 from ./include/linux/kprobes.h:38,
                 from arch/powerpc/lib/code-patching.c:11:
arch/powerpc/lib/code-patching.c:150:21: error: invalid type argument of =
unary =A1*=A2 (have =A1int=A2)
  if (!this_cpu_read(*PTRRELOC(&text_poke_area)))
                     ^~~~~~~~~~~~~~~~~~~~~~~~~~
./include/asm-generic/percpu.h:140:9: note: in definition of macro =A1thi=
s_cpu_generic_read=A2
  typeof(pcp) __ret;      \
         ^~~
./include/linux/percpu-defs.h:308:23: note: in expansion of macro =A1this=
_cpu_read_1=A2
  case 1: pscr_ret__ =3D stem##1(variable); break;   \
                       ^~~~
./include/linux/percpu-defs.h:494:29: note: in expansion of macro =A1__pc=
pu_size_call_return=A2
 #define this_cpu_read(pcp)  __pcpu_size_call_return(this_cpu_read_, pcp)
                             ^~~~~~~~~~~~~~~~~~~~~~~
arch/powerpc/lib/code-patching.c:150:7: note: in expansion of macro =A1th=
is_cpu_read=A2
  if (!this_cpu_read(*PTRRELOC(&text_poke_area)))
       ^~~~~~~~~~~~~
In file included from ./include/linux/linkage.h:5:0,
                 from ./include/linux/kernel.h:7,
                 from arch/powerpc/lib/code-patching.c:10:
arch/powerpc/lib/code-patching.c:150:21: error: invalid type argument of =
unary =A1*=A2 (have =A1int=A2)
  if (!this_cpu_read(*PTRRELOC(&text_poke_area)))
                     ^~~~~~~~~~~~~~~~~~~~~~~~~~
./include/linux/compiler.h:524:35: note: in definition of macro =A1__nati=
ve_word=A2
 # define __native_word(t) (sizeof(t) =3D=3D sizeof(char) || sizeof(t) =3D=
=3D sizeof(short) || sizeof(t) =3D=3D sizeof(int) || sizeof(t) =3D=3D siz=
eof(long))
                                   ^
./include/asm-generic/percpu.h:324:31: note: in expansion of macro =A1thi=
s_cpu_generic_read=A2
 #define this_cpu_read_1(pcp)  this_cpu_generic_read(pcp)
                               ^~~~~~~~~~~~~~~~~~~~~
./include/linux/percpu-defs.h:308:23: note: in expansion of macro =A1this=
_cpu_read_1=A2
  case 1: pscr_ret__ =3D stem##1(variable); break;   \
                       ^~~~
./include/linux/percpu-defs.h:494:29: note: in expansion of macro =A1__pc=
pu_size_call_return=A2
 #define this_cpu_read(pcp)  __pcpu_size_call_return(this_cpu_read_, pcp)
                             ^~~~~~~~~~~~~~~~~~~~~~~
arch/powerpc/lib/code-patching.c:150:7: note: in expansion of macro =A1th=
is_cpu_read=A2
  if (!this_cpu_read(*PTRRELOC(&text_poke_area)))
       ^~~~~~~~~~~~~
arch/powerpc/lib/code-patching.c:150:21: error: invalid type argument of =
unary =A1*=A2 (have =A1int=A2)
  if (!this_cpu_read(*PTRRELOC(&text_poke_area)))
                     ^~~~~~~~~~~~~~~~~~~~~~~~~~
./include/linux/compiler.h:524:64: note: in definition of macro =A1__nati=
ve_word=A2
 # define __native_word(t) (sizeof(t) =3D=3D sizeof(char) || sizeof(t) =3D=
=3D sizeof(short) || sizeof(t) =3D=3D sizeof(int) || sizeof(t) =3D=3D siz=
eof(long))
                                                                ^
./include/asm-generic/percpu.h:324:31: note: in expansion of macro =A1thi=
s_cpu_generic_read=A2
 #define this_cpu_read_1(pcp)  this_cpu_generic_read(pcp)
                               ^~~~~~~~~~~~~~~~~~~~~
./include/linux/percpu-defs.h:308:23: note: in expansion of macro =A1this=
_cpu_read_1=A2
  case 1: pscr_ret__ =3D stem##1(variable); break;   \
                       ^~~~
./include/linux/percpu-defs.h:494:29: note: in expansion of macro =A1__pc=
pu_size_call_return=A2
 #define this_cpu_read(pcp)  __pcpu_size_call_return(this_cpu_read_, pcp)
                             ^~~~~~~~~~~~~~~~~~~~~~~
arch/powerpc/lib/code-patching.c:150:7: note: in expansion of macro =A1th=
is_cpu_read=A2
  if (!this_cpu_read(*PTRRELOC(&text_poke_area)))
       ^~~~~~~~~~~~~
arch/powerpc/lib/code-patching.c:150:21: error: invalid type argument of =
unary =A1*=A2 (have =A1int=A2)
  if (!this_cpu_read(*PTRRELOC(&text_poke_area)))
                     ^~~~~~~~~~~~~~~~~~~~~~~~~~
./include/linux/compiler.h:524:94: note: in definition of macro =A1__nati=
ve_word=A2
 # define __native_word(t) (sizeof(t) =3D=3D sizeof(char) || sizeof(t) =3D=
=3D sizeof(short) || sizeof(t) =3D=3D sizeof(int) || sizeof(t) =3D=3D siz=
eof(long))
                                                                         =
                     ^
./include/asm-generic/percpu.h:324:31: note: in expansion of macro =A1thi=
s_cpu_generic_read=A2
 #define this_cpu_read_1(pcp)  this_cpu_generic_read(pcp)
                               ^~~~~~~~~~~~~~~~~~~~~
./include/linux/percpu-defs.h:308:23: note: in expansion of macro =A1this=
_cpu_read_1=A2
  case 1: pscr_ret__ =3D stem##1(variable); break;   \
                       ^~~~
./include/linux/percpu-defs.h:494:29: note: in expansion of macro =A1__pc=
pu_size_call_return=A2
 #define this_cpu_read(pcp)  __pcpu_size_call_return(this_cpu_read_, pcp)
                             ^~~~~~~~~~~~~~~~~~~~~~~
arch/powerpc/lib/code-patching.c:150:7: note: in expansion of macro =A1th=
is_cpu_read=A2
  if (!this_cpu_read(*PTRRELOC(&text_poke_area)))
       ^~~~~~~~~~~~~
arch/powerpc/lib/code-patching.c:150:21: error: invalid type argument of =
unary =A1*=A2 (have =A1int=A2)
  if (!this_cpu_read(*PTRRELOC(&text_poke_area)))
                     ^~~~~~~~~~~~~~~~~~~~~~~~~~
./include/linux/compiler.h:524:122: note: in definition of macro =A1__nat=
ive_word=A2
 # define __native_word(t) (sizeof(t) =3D=3D sizeof(char) || sizeof(t) =3D=
=3D sizeof(short) || sizeof(t) =3D=3D sizeof(int) || sizeof(t) =3D=3D siz=
eof(long))
                                                                         =
                                                 ^
./include/asm-generic/percpu.h:324:31: note: in expansion of macro =A1thi=
s_cpu_generic_read=A2
 #define this_cpu_read_1(pcp)  this_cpu_generic_read(pcp)
                               ^~~~~~~~~~~~~~~~~~~~~
./include/linux/percpu-defs.h:308:23: note: in expansion of macro =A1this=
_cpu_read_1=A2
  case 1: pscr_ret__ =3D stem##1(variable); break;   \
                       ^~~~
./include/linux/percpu-defs.h:494:29: note: in expansion of macro =A1__pc=
pu_size_call_return=A2
 #define this_cpu_read(pcp)  __pcpu_size_call_return(this_cpu_read_, pcp)
                             ^~~~~~~~~~~~~~~~~~~~~~~
arch/powerpc/lib/code-patching.c:150:7: note: in expansion of macro =A1th=
is_cpu_read=A2
  if (!this_cpu_read(*PTRRELOC(&text_poke_area)))
       ^~~~~~~~~~~~~
In file included from ./arch/powerpc/include/asm/percpu.h:20:0,
                 from ./include/linux/percpu.h:13,
                 from ./include/linux/kprobes.h:38,
                 from arch/powerpc/lib/code-patching.c:11:
arch/powerpc/lib/code-patching.c:150:21: error: invalid type argument of =
unary =A1*=A2 (have =A1int=A2)
  if (!this_cpu_read(*PTRRELOC(&text_poke_area)))
                     ^~~~~~~~~~~~~~~~~~~~~~~~~~
./include/asm-generic/percpu.h:121:9: note: in definition of macro =A1__t=
his_cpu_generic_read_nopreempt=A2
  typeof(pcp) __ret;      \
         ^~~
./include/asm-generic/percpu.h:324:31: note: in expansion of macro =A1thi=
s_cpu_generic_read=A2
 #define this_cpu_read_1(pcp)  this_cpu_generic_read(pcp)
                               ^~~~~~~~~~~~~~~~~~~~~
./include/linux/percpu-defs.h:308:23: note: in expansion of macro =A1this=
_cpu_read_1=A2
  case 1: pscr_ret__ =3D stem##1(variable); break;   \
                       ^~~~
./include/linux/percpu-defs.h:494:29: note: in expansion of macro =A1__pc=
pu_size_call_return=A2
 #define this_cpu_read(pcp)  __pcpu_size_call_return(this_cpu_read_, pcp)
                             ^~~~~~~~~~~~~~~~~~~~~~~
arch/powerpc/lib/code-patching.c:150:7: note: in expansion of macro =A1th=
is_cpu_read=A2
  if (!this_cpu_read(*PTRRELOC(&text_poke_area)))
       ^~~~~~~~~~~~~
In file included from ./include/linux/linkage.h:5:0,
                 from ./include/linux/kernel.h:7,
                 from arch/powerpc/lib/code-patching.c:10:
arch/powerpc/lib/code-patching.c:150:21: error: invalid type argument of =
unary =A1*=A2 (have =A1int=A2)
  if (!this_cpu_read(*PTRRELOC(&text_poke_area)))
                     ^~~~~~~~~~~~~~~~~~~~~~~~~~
./include/linux/compiler.h:339:17: note: in definition of macro =A1__READ=
_ONCE=A2
  union { typeof(x) __val; char __c[1]; } __u;   \
                 ^
./include/asm-generic/percpu.h:123:10: note: in expansion of macro =A1REA=
D_ONCE=A2
  __ret =3D READ_ONCE(*raw_cpu_ptr(&(pcp)));   \
          ^~~~~~~~~
./include/linux/percpu-defs.h:246:2: note: in expansion of macro =A1__ver=
ify_pcpu_ptr=A2
  __verify_pcpu_ptr(__p);      \
  ^~~~~~~~~~~~~~~~~
./include/linux/percpu-defs.h:250:47: note: in expansion of macro =A1VERI=
FY_PERCPU_PTR=A2
 #define per_cpu_ptr(ptr, cpu) ({ (void)(cpu); VERIFY_PERCPU_PTR(ptr); })
                                               ^~~~~~~~~~~~~~~~~
./include/linux/percpu-defs.h:251:26: note: in expansion of macro =A1per_=
cpu_ptr=A2
 #define raw_cpu_ptr(ptr) per_cpu_ptr(ptr, 0)
                          ^~~~~~~~~~~
./include/asm-generic/percpu.h:123:21: note: in expansion of macro =A1raw=
_cpu_ptr=A2
  __ret =3D READ_ONCE(*raw_cpu_ptr(&(pcp)));   \
                     ^~~~~~~~~~~
./include/asm-generic/percpu.h:142:11: note: in expansion of macro =A1__t=
his_cpu_generic_read_nopreempt=A2
   __ret =3D __this_cpu_generic_read_nopreempt(pcp);  \
           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
./include/asm-generic/percpu.h:324:31: note: in expansion of macro =A1thi=
s_cpu_generic_read=A2
 #define this_cpu_read_1(pcp)  this_cpu_generic_read(pcp)
                               ^~~~~~~~~~~~~~~~~~~~~
./include/linux/percpu-defs.h:308:23: note: in expansion of macro =A1this=
_cpu_read_1=A2
  case 1: pscr_ret__ =3D stem##1(variable); break;   \
                       ^~~~
./include/linux/percpu-defs.h:494:29: note: in expansion of macro =A1__pc=
pu_size_call_return=A2
 #define this_cpu_read(pcp)  __pcpu_size_call_return(this_cpu_read_, pcp)
                             ^~~~~~~~~~~~~~~~~~~~~~~
arch/powerpc/lib/code-patching.c:150:7: note: in expansion of macro =A1th=
is_cpu_read=A2
  if (!this_cpu_read(*PTRRELOC(&text_poke_area)))
       ^~~~~~~~~~~~~
arch/powerpc/lib/code-patching.c:150:21: error: invalid type argument of =
unary =A1*=A2 (have =A1int=A2)
  if (!this_cpu_read(*PTRRELOC(&text_poke_area)))
                     ^~~~~~~~~~~~~~~~~~~~~~~~~~
./include/linux/compiler.h:339:17: note: in definition of macro =A1__READ=
_ONCE=A2
  union { typeof(x) __val; char __c[1]; } __u;   \
                 ^
./include/asm-generic/percpu.h:123:10: note: in expansion of macro =A1REA=
D_ONCE=A2
  __ret =3D READ_ONCE(*raw_cpu_ptr(&(pcp)));   \
          ^~~~~~~~~
./include/linux/percpu-defs.h:250:47: note: in expansion of macro =A1VERI=
FY_PERCPU_PTR=A2
 #define per_cpu_ptr(ptr, cpu) ({ (void)(cpu); VERIFY_PERCPU_PTR(ptr); })
                                               ^~~~~~~~~~~~~~~~~
./include/linux/percpu-defs.h:251:26: note: in expansion of macro =A1per_=
cpu_ptr=A2
 #define raw_cpu_ptr(ptr) per_cpu_ptr(ptr, 0)
                          ^~~~~~~~~~~
./include/asm-generic/percpu.h:123:21: note: in expansion of macro =A1raw=
_cpu_ptr=A2
  __ret =3D READ_ONCE(*raw_cpu_ptr(&(pcp)));   \
                     ^~~~~~~~~~~
./include/asm-generic/percpu.h:142:11: note: in expansion of macro =A1__t=
his_cpu_generic_read_nopreempt=A2
   __ret =3D __this_cpu_generic_read_nopreempt(pcp);  \
           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
./include/asm-generic/percpu.h:324:31: note: in expansion of macro =A1thi=
s_cpu_generic_read=A2
 #define this_cpu_read_1(pcp)  this_cpu_generic_read(pcp)
                               ^~~~~~~~~~~~~~~~~~~~~
./include/linux/percpu-defs.h:308:23: note: in expansion of macro =A1this=
_cpu_read_1=A2
  case 1: pscr_ret__ =3D stem##1(variable); break;   \
                       ^~~~
./include/linux/percpu-defs.h:494:29: note: in expansion of macro =A1__pc=
pu_size_call_return=A2
 #define this_cpu_read(pcp)  __pcpu_size_call_return(this_cpu_read_, pcp)
                             ^~~~~~~~~~~~~~~~~~~~~~~
arch/powerpc/lib/code-patching.c:150:7: note: in expansion of macro =A1th=
is_cpu_read=A2
  if (!this_cpu_read(*PTRRELOC(&text_poke_area)))
       ^~~~~~~~~~~~~
arch/powerpc/lib/code-patching.c:150:21: error: invalid type argument of =
unary =A1*=A2 (have =A1int=A2)
  if (!this_cpu_read(*PTRRELOC(&text_poke_area)))
                     ^~~~~~~~~~~~~~~~~~~~~~~~~~
./include/linux/compiler.h:339:17: note: in definition of macro =A1__READ=
_ONCE=A2
  union { typeof(x) __val; char __c[1]; } __u;   \
                 ^
./include/asm-generic/percpu.h:123:10: note: in expansion of macro =A1REA=
D_ONCE=A2
  __ret =3D READ_ONCE(*raw_cpu_ptr(&(pcp)));   \
          ^~~~~~~~~
./include/linux/percpu-defs.h:250:47: note: in expansion of macro =A1VERI=
FY_PERCPU_PTR=A2
 #define per_cpu_ptr(ptr, cpu) ({ (void)(cpu); VERIFY_PERCPU_PTR(ptr); })
                                               ^~~~~~~~~~~~~~~~~
./include/linux/percpu-defs.h:251:26: note: in expansion of macro =A1per_=
cpu_ptr=A2
 #define raw_cpu_ptr(ptr) per_cpu_ptr(ptr, 0)
                          ^~~~~~~~~~~
./include/asm-generic/percpu.h:123:21: note: in expansion of macro =A1raw=
_cpu_ptr=A2
  __ret =3D READ_ONCE(*raw_cpu_ptr(&(pcp)));   \
                     ^~~~~~~~~~~
./include/asm-generic/percpu.h:142:11: note: in expansion of macro =A1__t=
his_cpu_generic_read_nopreempt=A2
   __ret =3D __this_cpu_generic_read_nopreempt(pcp);  \
           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
./include/asm-generic/percpu.h:324:31: note: in expansion of macro =A1thi=
s_cpu_generic_read=A2
 #define this_cpu_read_1(pcp)  this_cpu_generic_read(pcp)
                               ^~~~~~~~~~~~~~~~~~~~~
./include/linux/percpu-defs.h:308:23: note: in expansion of macro =A1this=
_cpu_read_1=A2
  case 1: pscr_ret__ =3D stem##1(variable); break;   \
                       ^~~~
./include/linux/percpu-defs.h:494:29: note: in expansion of macro =A1__pc=
pu_size_call_return=A2
 #define this_cpu_read(pcp)  __pcpu_size_call_return(this_cpu_read_, pcp)
                             ^~~~~~~~~~~~~~~~~~~~~~~
arch/powerpc/lib/code-patching.c:150:7: note: in expansion of macro =A1th=
is_cpu_read=A2
  if (!this_cpu_read(*PTRRELOC(&text_poke_area)))
       ^~~~~~~~~~~~~
arch/powerpc/lib/code-patching.c:150:21: error: invalid type argument of =
unary =A1*=A2 (have =A1int=A2)
  if (!this_cpu_read(*PTRRELOC(&text_poke_area)))
                     ^~~~~~~~~~~~~~~~~~~~~~~~~~
./include/linux/compiler.h:341:22: note: in definition of macro =A1__READ=
_ONCE=A2
   __read_once_size(&(x), __u.__c, sizeof(x));  \
                      ^
./include/asm-generic/percpu.h:123:10: note: in expansion of macro =A1REA=
D_ONCE=A2
  __ret =3D READ_ONCE(*raw_cpu_ptr(&(pcp)));   \
          ^~~~~~~~~
./include/linux/percpu-defs.h:246:2: note: in expansion of macro =A1__ver=
ify_pcpu_ptr=A2
  __verify_pcpu_ptr(__p);      \
  ^~~~~~~~~~~~~~~~~
./include/linux/percpu-defs.h:250:47: note: in expansion of macro =A1VERI=
FY_PERCPU_PTR=A2
 #define per_cpu_ptr(ptr, cpu) ({ (void)(cpu); VERIFY_PERCPU_PTR(ptr); })
                                               ^~~~~~~~~~~~~~~~~
./include/linux/percpu-defs.h:251:26: note: in expansion of macro =A1per_=
cpu_ptr=A2
 #define raw_cpu_ptr(ptr) per_cpu_ptr(ptr, 0)
                          ^~~~~~~~~~~
./include/asm-generic/percpu.h:123:21: note: in expansion of macro =A1raw=
_cpu_ptr=A2
  __ret =3D READ_ONCE(*raw_cpu_ptr(&(pcp)));   \
                     ^~~~~~~~~~~
./include/asm-generic/percpu.h:142:11: note: in expansion of macro =A1__t=
his_cpu_generic_read_nopreempt=A2
   __ret =3D __this_cpu_generic_read_nopreempt(pcp);  \
           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
./include/asm-generic/percpu.h:324:31: note: in expansion of macro =A1thi=
s_cpu_generic_read=A2
 #define this_cpu_read_1(pcp)  this_cpu_generic_read(pcp)
                               ^~~~~~~~~~~~~~~~~~~~~
./include/linux/percpu-defs.h:308:23: note: in expansion of macro =A1this=
_cpu_read_1=A2
  case 1: pscr_ret__ =3D stem##1(variable); break;   \
                       ^~~~
./include/linux/percpu-defs.h:494:29: note: in expansion of macro =A1__pc=
pu_size_call_return=A2
 #define this_cpu_read(pcp)  __pcpu_size_call_return(this_cpu_read_, pcp)
                             ^~~~~~~~~~~~~~~~~~~~~~~
arch/powerpc/lib/code-patching.c:150:7: note: in expansion of macro =A1th=
is_cpu_read=A2
  if (!this_cpu_read(*PTRRELOC(&text_poke_area)))
       ^~~~~~~~~~~~~
arch/powerpc/lib/code-patching.c:150:21: error: invalid type argument of =
unary =A1*=A2 (have =A1int=A2)
  if (!this_cpu_read(*PTRRELOC(&text_poke_area)))
                     ^~~~~~~~~~~~~~~~~~~~~~~~~~
./include/linux/compiler.h:341:22: note: in definition of macro =A1__READ=
_ONCE=A2
   __read_once_size(&(x), __u.__c, sizeof(x));  \
                      ^
./include/asm-generic/percpu.h:123:10: note: in expansion of macro =A1REA=
D_ONCE=A2
  __ret =3D READ_ONCE(*raw_cpu_ptr(&(pcp)));   \
          ^~~~~~~~~
./include/linux/percpu-defs.h:250:47: note: in expansion of macro =A1VERI=
FY_PERCPU_PTR=A2
 #define per_cpu_ptr(ptr, cpu) ({ (void)(cpu); VERIFY_PERCPU_PTR(ptr); })
                                               ^~~~~~~~~~~~~~~~~
./include/linux/percpu-defs.h:251:26: note: in expansion of macro =A1per_=
cpu_ptr=A2
 #define raw_cpu_ptr(ptr) per_cpu_ptr(ptr, 0)
                          ^~~~~~~~~~~
./include/asm-generic/percpu.h:123:21: note: in expansion of macro =A1raw=
_cpu_ptr=A2
  __ret =3D READ_ONCE(*raw_cpu_ptr(&(pcp)));   \
                     ^~~~~~~~~~~
./include/asm-generic/percpu.h:142:11: note: in expansion of macro =A1__t=
his_cpu_generic_read_nopreempt=A2
   __ret =3D __this_cpu_generic_read_nopreempt(pcp);  \
           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
./include/asm-generic/percpu.h:324:31: note: in expansion of macro =A1thi=
s_cpu_generic_read=A2
 #define this_cpu_read_1(pcp)  this_cpu_generic_read(pcp)
                               ^~~~~~~~~~~~~~~~~~~~~
./include/linux/percpu-defs.h:308:23: note: in expansion of macro =A1this=
_cpu_read_1=A2
  case 1: pscr_ret__ =3D stem##1(variable); break;   \
                       ^~~~
./include/linux/percpu-defs.h:494:29: note: in expansion of macro =A1__pc=
pu_size_call_return=A2
 #define this_cpu_read(pcp)  __pcpu_size_call_return(this_cpu_read_, pcp)
                             ^~~~~~~~~~~~~~~~~~~~~~~
arch/powerpc/lib/code-patching.c:150:7: note: in expansion of macro =A1th=
is_cpu_read=A2
  if (!this_cpu_read(*PTRRELOC(&text_poke_area)))
       ^~~~~~~~~~~~~
arch/powerpc/lib/code-patching.c:150:21: error: invalid type argument of =
unary =A1*=A2 (have =A1int=A2)
  if (!this_cpu_read(*PTRRELOC(&text_poke_area)))
                     ^~~~~~~~~~~~~~~~~~~~~~~~~~
./include/linux/compiler.h:341:22: note: in definition of macro =A1__READ=
_ONCE=A2
   __read_once_size(&(x), __u.__c, sizeof(x));  \
                      ^
./include/asm-generic/percpu.h:123:10: note: in expansion of macro =A1REA=
D_ONCE=A2
  __ret =3D READ_ONCE(*raw_cpu_ptr(&(pcp)));   \
          ^~~~~~~~~
./include/linux/percpu-defs.h:250:47: note: in expansion of macro =A1VERI=
FY_PERCPU_PTR=A2
 #define per_cpu_ptr(ptr, cpu) ({ (void)(cpu); VERIFY_PERCPU_PTR(ptr); })
                                               ^~~~~~~~~~~~~~~~~
./include/linux/percpu-defs.h:251:26: note: in expansion of macro =A1per_=
cpu_ptr=A2
 #define raw_cpu_ptr(ptr) per_cpu_ptr(ptr, 0)
                          ^~~~~~~~~~~
./include/asm-generic/percpu.h:123:21: note: in expansion of macro =A1raw=
_cpu_ptr=A2
  __ret =3D READ_ONCE(*raw_cpu_ptr(&(pcp)));   \
                     ^~~~~~~~~~~
./include/asm-generic/percpu.h:142:11: note: in expansion of macro =A1__t=
his_cpu_generic_read_nopreempt=A2
   __ret =3D __this_cpu_generic_read_nopreempt(pcp);  \
           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
./include/asm-generic/percpu.h:324:31: note: in expansion of macro =A1thi=
s_cpu_generic_read=A2
 #define this_cpu_read_1(pcp)  this_cpu_generic_read(pcp)
                               ^~~~~~~~~~~~~~~~~~~~~
./include/linux/percpu-defs.h:308:23: note: in expansion of macro =A1this=
_cpu_read_1=A2
  case 1: pscr_ret__ =3D stem##1(variable); break;   \
                       ^~~~
./include/linux/percpu-defs.h:494:29: note: in expansion of macro =A1__pc=
pu_size_call_return=A2
 #define this_cpu_read(pcp)  __pcpu_size_call_return(this_cpu_read_, pcp)
                             ^~~~~~~~~~~~~~~~~~~~~~~
arch/powerpc/lib/code-patching.c:150:7: note: in expansion of macro =A1th=
is_cpu_read=A2
  if (!this_cpu_read(*PTRRELOC(&text_poke_area)))
       ^~~~~~~~~~~~~
arch/powerpc/lib/code-patching.c:150:21: error: invalid type argument of =
unary =A1*=A2 (have =A1int=A2)
  if (!this_cpu_read(*PTRRELOC(&text_poke_area)))
                     ^~~~~~~~~~~~~~~~~~~~~~~~~~
./include/linux/compiler.h:341:42: note: in definition of macro =A1__READ=
_ONCE=A2
   __read_once_size(&(x), __u.__c, sizeof(x));  \
                                          ^
./include/asm-generic/percpu.h:123:10: note: in expansion of macro =A1REA=
D_ONCE=A2
  __ret =3D READ_ONCE(*raw_cpu_ptr(&(pcp)));   \
          ^~~~~~~~~
./include/linux/percpu-defs.h:246:2: note: in expansion of macro =A1__ver=
ify_pcpu_ptr=A2
  __verify_pcpu_ptr(__p);      \
  ^~~~~~~~~~~~~~~~~
./include/linux/percpu-defs.h:250:47: note: in expansion of macro =A1VERI=
FY_PERCPU_PTR=A2
 #define per_cpu_ptr(ptr, cpu) ({ (void)(cpu); VERIFY_PERCPU_PTR(ptr); })
                                               ^~~~~~~~~~~~~~~~~
./include/linux/percpu-defs.h:251:26: note: in expansion of macro =A1per_=
cpu_ptr=A2
 #define raw_cpu_ptr(ptr) per_cpu_ptr(ptr, 0)
                          ^~~~~~~~~~~
./include/asm-generic/percpu.h:123:21: note: in expansion of macro =A1raw=
_cpu_ptr=A2
  __ret =3D READ_ONCE(*raw_cpu_ptr(&(pcp)));   \
                     ^~~~~~~~~~~
./include/asm-generic/percpu.h:142:11: note: in expansion of macro =A1__t=
his_cpu_generic_read_nopreempt=A2
   __ret =3D __this_cpu_generic_read_nopreempt(pcp);  \
           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
./include/asm-generic/percpu.h:324:31: note: in expansion of macro =A1thi=
s_cpu_generic_read=A2
 #define this_cpu_read_1(pcp)  this_cpu_generic_read(pcp)
                               ^~~~~~~~~~~~~~~~~~~~~
./include/linux/percpu-defs.h:308:23: note: in expansion of macro =A1this=
_cpu_read_1=A2
  case 1: pscr_ret__ =3D stem##1(variable); break;   \
                       ^~~~
./include/linux/percpu-defs.h:494:29: note: in expansion of macro =A1__pc=
pu_size_call_return=A2
 #define this_cpu_read(pcp)  __pcpu_size_call_return(this_cpu_read_, pcp)
                             ^~~~~~~~~~~~~~~~~~~~~~~
arch/powerpc/lib/code-patching.c:150:7: note: in expansion of macro =A1th=
is_cpu_read=A2
  if (!this_cpu_read(*PTRRELOC(&text_poke_area)))
       ^~~~~~~~~~~~~
arch/powerpc/lib/code-patching.c:150:21: error: invalid type argument of =
unary =A1*=A2 (have =A1int=A2)
  if (!this_cpu_read(*PTRRELOC(&text_poke_area)))
                     ^~~~~~~~~~~~~~~~~~~~~~~~~~
./include/linux/compiler.h:341:42: note: in definition of macro =A1__READ=
_ONCE=A2
   __read_once_size(&(x), __u.__c, sizeof(x));  \
                                          ^
./include/asm-generic/percpu.h:123:10: note: in expansion of macro =A1REA=
D_ONCE=A2
  __ret =3D READ_ONCE(*raw_cpu_ptr(&(pcp)));   \
          ^~~~~~~~~
./include/linux/percpu-defs.h:250:47: note: in expansion of macro =A1VERI=
FY_PERCPU_PTR=A2
 #define per_cpu_ptr(ptr, cpu) ({ (void)(cpu); VERIFY_PERCPU_PTR(ptr); })
                                               ^~~~~~~~~~~~~~~~~
./include/linux/percpu-defs.h:251:26: note: in expansion of macro =A1per_=
cpu_ptr=A2
 #define raw_cpu_ptr(ptr) per_cpu_ptr(ptr, 0)
                          ^~~~~~~~~~~
./include/asm-generic/percpu.h:123:21: note: in expansion of macro =A1raw=
_cpu_ptr=A2
  __ret =3D READ_ONCE(*raw_cpu_ptr(&(pcp)));   \
                     ^~~~~~~~~~~
./include/asm-generic/percpu.h:142:11: note: in expansion of macro =A1__t=
his_cpu_generic_read_nopreempt=A2
   __ret =3D __this_cpu_generic_read_nopreempt(pcp);  \
           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
./include/asm-generic/percpu.h:324:31: note: in expansion of macro =A1thi=
s_cpu_generic_read=A2
 #define this_cpu_read_1(pcp)  this_cpu_generic_read(pcp)
                               ^~~~~~~~~~~~~~~~~~~~~
./include/linux/percpu-defs.h:308:23: note: in expansion of macro =A1this=
_cpu_read_1=A2
  case 1: pscr_ret__ =3D stem##1(variable); break;   \
                       ^~~~
./include/linux/percpu-defs.h:494:29: note: in expansion of macro =A1__pc=
pu_size_call_return=A2
 #define this_cpu_read(pcp)  __pcpu_size_call_return(this_cpu_read_, pcp)
                             ^~~~~~~~~~~~~~~~~~~~~~~
arch/powerpc/lib/code-patching.c:150:7: note: in expansion of macro =A1th=
is_cpu_read=A2
  if (!this_cpu_read(*PTRRELOC(&text_poke_area)))
       ^~~~~~~~~~~~~
arch/powerpc/lib/code-patching.c:150:21: error: invalid type argument of =
unary =A1*=A2 (have =A1int=A2)
  if (!this_cpu_read(*PTRRELOC(&text_poke_area)))
                     ^~~~~~~~~~~~~~~~~~~~~~~~~~
./include/linux/compiler.h:341:42: note: in definition of macro =A1__READ=
_ONCE=A2
   __read_once_size(&(x), __u.__c, sizeof(x));  \
                                          ^
./include/asm-generic/percpu.h:123:10: note: in expansion of macro =A1REA=
D_ONCE=A2
  __ret =3D READ_ONCE(*raw_cpu_ptr(&(pcp)));   \
          ^~~~~~~~~
./include/linux/percpu-defs.h:250:47: note: in expansion of macro =A1VERI=
FY_PERCPU_PTR=A2
 #define per_cpu_ptr(ptr, cpu) ({ (void)(cpu); VERIFY_PERCPU_PTR(ptr); })
                                               ^~~~~~~~~~~~~~~~~
./include/linux/percpu-defs.h:251:26: note: in expansion of macro =A1per_=
cpu_ptr=A2
 #define raw_cpu_ptr(ptr) per_cpu_ptr(ptr, 0)
                          ^~~~~~~~~~~
./include/asm-generic/percpu.h:123:21: note: in expansion of macro =A1raw=
_cpu_ptr=A2
  __ret =3D READ_ONCE(*raw_cpu_ptr(&(pcp)));   \
                     ^~~~~~~~~~~
./include/asm-generic/percpu.h:142:11: note: in expansion of macro =A1__t=
his_cpu_generic_read_nopreempt=A2
   __ret =3D __this_cpu_generic_read_nopreempt(pcp);  \
           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
./include/asm-generic/percpu.h:324:31: note: in expansion of macro =A1thi=
s_cpu_generic_read=A2
 #define this_cpu_read_1(pcp)  this_cpu_generic_read(pcp)
                               ^~~~~~~~~~~~~~~~~~~~~
./include/linux/percpu-defs.h:308:23: note: in expansion of macro =A1this=
_cpu_read_1=A2
  case 1: pscr_ret__ =3D stem##1(variable); break;   \
                       ^~~~
./include/linux/percpu-defs.h:494:29: note: in expansion of macro =A1__pc=
pu_size_call_return=A2
 #define this_cpu_read(pcp)  __pcpu_size_call_return(this_cpu_read_, pcp)
                             ^~~~~~~~~~~~~~~~~~~~~~~
arch/powerpc/lib/code-patching.c:150:7: note: in expansion of macro =A1th=
is_cpu_read=A2
  if (!this_cpu_read(*PTRRELOC(&text_poke_area)))
       ^~~~~~~~~~~~~
arch/powerpc/lib/code-patching.c:150:21: error: invalid type argument of =
unary =A1*=A2 (have =A1int=A2)
  if (!this_cpu_read(*PTRRELOC(&text_poke_area)))
                     ^~~~~~~~~~~~~~~~~~~~~~~~~~
./include/linux/compiler.h:343:30: note: in definition of macro =A1__READ=
_ONCE=A2
   __read_once_size_nocheck(&(x), __u.__c, sizeof(x)); \
                              ^
./include/asm-generic/percpu.h:123:10: note: in expansion of macro =A1REA=
D_ONCE=A2
  __ret =3D READ_ONCE(*raw_cpu_ptr(&(pcp)));   \
          ^~~~~~~~~
./include/linux/percpu-defs.h:246:2: note: in expansion of macro =A1__ver=
ify_pcpu_ptr=A2
  __verify_pcpu_ptr(__p);      \
  ^~~~~~~~~~~~~~~~~
./include/linux/percpu-defs.h:250:47: note: in expansion of macro =A1VERI=
FY_PERCPU_PTR=A2
 #define per_cpu_ptr(ptr, cpu) ({ (void)(cpu); VERIFY_PERCPU_PTR(ptr); })
                                               ^~~~~~~~~~~~~~~~~
./include/linux/percpu-defs.h:251:26: note: in expansion of macro =A1per_=
cpu_ptr=A2
 #define raw_cpu_ptr(ptr) per_cpu_ptr(ptr, 0)
                          ^~~~~~~~~~~
./include/asm-generic/percpu.h:123:21: note: in expansion of macro =A1raw=
_cpu_ptr=A2
  __ret =3D READ_ONCE(*raw_cpu_ptr(&(pcp)));   \
                     ^~~~~~~~~~~
./include/asm-generic/percpu.h:142:11: note: in expansion of macro =A1__t=
his_cpu_generic_read_nopreempt=A2
   __ret =3D __this_cpu_generic_read_nopreempt(pcp);  \
           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
./include/asm-generic/percpu.h:324:31: note: in expansion of macro =A1thi=
s_cpu_generic_read=A2
 #define this_cpu_read_1(pcp)  this_cpu_generic_read(pcp)
                               ^~~~~~~~~~~~~~~~~~~~~
./include/linux/percpu-defs.h:308:23: note: in expansion of macro =A1this=
_cpu_read_1=A2
  case 1: pscr_ret__ =3D stem##1(variable); break;   \
                       ^~~~
./include/linux/percpu-defs.h:494:29: note: in expansion of macro =A1__pc=
pu_size_call_return=A2
 #define this_cpu_read(pcp)  __pcpu_size_call_return(this_cpu_read_, pcp)
                             ^~~~~~~~~~~~~~~~~~~~~~~
arch/powerpc/lib/code-patching.c:150:7: note: in expansion of macro =A1th=
is_cpu_read=A2
  if (!this_cpu_read(*PTRRELOC(&text_poke_area)))
       ^~~~~~~~~~~~~
arch/powerpc/lib/code-patching.c:150:21: error: invalid type argument of =
unary =A1*=A2 (have =A1int=A2)
  if (!this_cpu_read(*PTRRELOC(&text_poke_area)))
                     ^~~~~~~~~~~~~~~~~~~~~~~~~~
./include/linux/compiler.h:343:30: note: in definition of macro =A1__READ=
_ONCE=A2
   __read_once_size_nocheck(&(x), __u.__c, sizeof(x)); \
                              ^
./include/asm-generic/percpu.h:123:10: note: in expansion of macro =A1REA=
D_ONCE=A2
  __ret =3D READ_ONCE(*raw_cpu_ptr(&(pcp)));   \
          ^~~~~~~~~
./include/linux/percpu-defs.h:250:47: note: in expansion of macro =A1VERI=
FY_PERCPU_PTR=A2
 #define per_cpu_ptr(ptr, cpu) ({ (void)(cpu); VERIFY_PERCPU_PTR(ptr); })
                                               ^~~~~~~~~~~~~~~~~
./include/linux/percpu-defs.h:251:26: note: in expansion of macro =A1per_=
cpu_ptr=A2
 #define raw_cpu_ptr(ptr) per_cpu_ptr(ptr, 0)
                          ^~~~~~~~~~~
./include/asm-generic/percpu.h:123:21: note: in expansion of macro =A1raw=
_cpu_ptr=A2
  __ret =3D READ_ONCE(*raw_cpu_ptr(&(pcp)));   \
                     ^~~~~~~~~~~
./include/asm-generic/percpu.h:142:11: note: in expansion of macro =A1__t=
his_cpu_generic_read_nopreempt=A2
   __ret =3D __this_cpu_generic_read_nopreempt(pcp);  \
           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
./include/asm-generic/percpu.h:324:31: note: in expansion of macro =A1thi=
s_cpu_generic_read=A2
 #define this_cpu_read_1(pcp)  this_cpu_generic_read(pcp)
                               ^~~~~~~~~~~~~~~~~~~~~
./include/linux/percpu-defs.h:308:23: note: in expansion of macro =A1this=
_cpu_read_1=A2
  case 1: pscr_ret__ =3D stem##1(variable); break;   \
                       ^~~~
./include/linux/percpu-defs.h:494:29: note: in expansion of macro =A1__pc=
pu_size_call_return=A2
 #define this_cpu_read(pcp)  __pcpu_size_call_return(this_cpu_read_, pcp)
                             ^~~~~~~~~~~~~~~~~~~~~~~
arch/powerpc/lib/code-patching.c:150:7: note: in expansion of macro =A1th=
is_cpu_read=A2
  if (!this_cpu_read(*PTRRELOC(&text_poke_area)))
       ^~~~~~~~~~~~~
arch/powerpc/lib/code-patching.c:150:21: error: invalid type argument of =
unary =A1*=A2 (have =A1int=A2)
  if (!this_cpu_read(*PTRRELOC(&text_poke_area)))
                     ^~~~~~~~~~~~~~~~~~~~~~~~~~
./include/linux/compiler.h:343:30: note: in definition of macro =A1__READ=
_ONCE=A2
   __read_once_size_nocheck(&(x), __u.__c, sizeof(x)); \
                              ^
./include/asm-generic/percpu.h:123:10: note: in expansion of macro =A1REA=
D_ONCE=A2
  __ret =3D READ_ONCE(*raw_cpu_ptr(&(pcp)));   \
          ^~~~~~~~~
./include/linux/percpu-defs.h:250:47: note: in expansion of macro =A1VERI=
FY_PERCPU_PTR=A2
 #define per_cpu_ptr(ptr, cpu) ({ (void)(cpu); VERIFY_PERCPU_PTR(ptr); })
                                               ^~~~~~~~~~~~~~~~~
./include/linux/percpu-defs.h:251:26: note: in expansion of macro =A1per_=
cpu_ptr=A2
 #define raw_cpu_ptr(ptr) per_cpu_ptr(ptr, 0)
                          ^~~~~~~~~~~
./include/asm-generic/percpu.h:123:21: note: in expansion of macro =A1raw=
_cpu_ptr=A2
  __ret =3D READ_ONCE(*raw_cpu_ptr(&(pcp)));   \
                     ^~~~~~~~~~~
./include/asm-generic/percpu.h:142:11: note: in expansion of macro =A1__t=
his_cpu_generic_read_nopreempt=A2
   __ret =3D __this_cpu_generic_read_nopreempt(pcp);  \
           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
./include/asm-generic/percpu.h:324:31: note: in expansion of macro =A1thi=
s_cpu_generic_read=A2
 #define this_cpu_read_1(pcp)  this_cpu_generic_read(pcp)
                               ^~~~~~~~~~~~~~~~~~~~~
./include/linux/percpu-defs.h:308:23: note: in expansion of macro =A1this=
_cpu_read_1=A2
  case 1: pscr_ret__ =3D stem##1(variable); break;   \
                       ^~~~
./include/linux/percpu-defs.h:494:29: note: in expansion of macro =A1__pc=
pu_size_call_return=A2
 #define this_cpu_read(pcp)  __pcpu_size_call_return(this_cpu_read_, pcp)
                             ^~~~~~~~~~~~~~~~~~~~~~~
arch/powerpc/lib/code-patching.c:150:7: note: in expansion of macro =A1th=
is_cpu_read=A2
  if (!this_cpu_read(*PTRRELOC(&text_poke_area)))
       ^~~~~~~~~~~~~
arch/powerpc/lib/code-patching.c:150:21: error: invalid type argument of =
unary =A1*=A2 (have =A1int=A2)
  if (!this_cpu_read(*PTRRELOC(&text_poke_area)))
                     ^~~~~~~~~~~~~~~~~~~~~~~~~~
./include/linux/compiler.h:343:50: note: in definition of macro =A1__READ=
_ONCE=A2
   __read_once_size_nocheck(&(x), __u.__c, sizeof(x)); \
                                                  ^
./include/asm-generic/percpu.h:123:10: note: in expansion of macro =A1REA=
D_ONCE=A2
  __ret =3D READ_ONCE(*raw_cpu_ptr(&(pcp)));   \
          ^~~~~~~~~
./include/linux/percpu-defs.h:246:2: note: in expansion of macro =A1__ver=
ify_pcpu_ptr=A2
  __verify_pcpu_ptr(__p);      \
  ^~~~~~~~~~~~~~~~~
./include/linux/percpu-defs.h:250:47: note: in expansion of macro =A1VERI=
FY_PERCPU_PTR=A2
 #define per_cpu_ptr(ptr, cpu) ({ (void)(cpu); VERIFY_PERCPU_PTR(ptr); })
                                               ^~~~~~~~~~~~~~~~~
./include/linux/percpu-defs.h:251:26: note: in expansion of macro =A1per_=
cpu_ptr=A2
 #define raw_cpu_ptr(ptr) per_cpu_ptr(ptr, 0)
                          ^~~~~~~~~~~
./include/asm-generic/percpu.h:123:21: note: in expansion of macro =A1raw=
_cpu_ptr=A2
  __ret =3D READ_ONCE(*raw_cpu_ptr(&(pcp)));   \
                     ^~~~~~~~~~~
./include/asm-generic/percpu.h:142:11: note: in expansion of macro =A1__t=
his_cpu_generic_read_nopreempt=A2
   __ret =3D __this_cpu_generic_read_nopreempt(pcp);  \
           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
./include/asm-generic/percpu.h:324:31: note: in expansion of macro =A1thi=
s_cpu_generic_read=A2
 #define this_cpu_read_1(pcp)  this_cpu_generic_read(pcp)
                               ^~~~~~~~~~~~~~~~~~~~~
./include/linux/percpu-defs.h:308:23: note: in expansion of macro =A1this=
_cpu_read_1=A2
  case 1: pscr_ret__ =3D stem##1(variable); break;   \
                       ^~~~
./include/linux/percpu-defs.h:494:29: note: in expansion of macro =A1__pc=
pu_size_call_return=A2
 #define this_cpu_read(pcp)  __pcpu_size_call_return(this_cpu_read_, pcp)
                             ^~~~~~~~~~~~~~~~~~~~~~~
arch/powerpc/lib/code-patching.c:150:7: note: in expansion of macro =A1th=
is_cpu_read=A2
  if (!this_cpu_read(*PTRRELOC(&text_poke_area)))
       ^~~~~~~~~~~~~
arch/powerpc/lib/code-patching.c:150:21: error: invalid type argument of =
unary =A1*=A2 (have =A1int=A2)
  if (!this_cpu_read(*PTRRELOC(&text_poke_area)))
                     ^~~~~~~~~~~~~~~~~~~~~~~~~~
./include/linux/compiler.h:343:50: note: in definition of macro =A1__READ=
_ONCE=A2
   __read_once_size_nocheck(&(x), __u.__c, sizeof(x)); \
                                                  ^
./include/asm-generic/percpu.h:123:10: note: in expansion of macro =A1REA=
D_ONCE=A2
  __ret =3D READ_ONCE(*raw_cpu_ptr(&(pcp)));   \
          ^~~~~~~~~
./include/linux/percpu-defs.h:250:47: note: in expansion of macro =A1VERI=
FY_PERCPU_PTR=A2
 #define per_cpu_ptr(ptr, cpu) ({ (void)(cpu); VERIFY_PERCPU_PTR(ptr); })
                                               ^~~~~~~~~~~~~~~~~
./include/linux/percpu-defs.h:251:26: note: in expansion of macro =A1per_=
cpu_ptr=A2
 #define raw_cpu_ptr(ptr) per_cpu_ptr(ptr, 0)
                          ^~~~~~~~~~~
./include/asm-generic/percpu.h:123:21: note: in expansion of macro =A1raw=
_cpu_ptr=A2
  __ret =3D READ_ONCE(*raw_cpu_ptr(&(pcp)));   \
                     ^~~~~~~~~~~
./include/asm-generic/percpu.h:142:11: note: in expansion of macro =A1__t=
his_cpu_generic_read_nopreempt=A2
   __ret =3D __this_cpu_generic_read_nopreempt(pcp);  \
           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
./include/asm-generic/percpu.h:324:31: note: in expansion of macro =A1thi=
s_cpu_generic_read=A2
 #define this_cpu_read_1(pcp)  this_cpu_generic_read(pcp)
                               ^~~~~~~~~~~~~~~~~~~~~
./include/linux/percpu-defs.h:308:23: note: in expansion of macro =A1this=
_cpu_read_1=A2
  case 1: pscr_ret__ =3D stem##1(variable); break;   \
                       ^~~~
./include/linux/percpu-defs.h:494:29: note: in expansion of macro =A1__pc=
pu_size_call_return=A2
 #define this_cpu_read(pcp)  __pcpu_size_call_return(this_cpu_read_, pcp)
                             ^~~~~~~~~~~~~~~~~~~~~~~
arch/powerpc/lib/code-patching.c:150:7: note: in expansion of macro =A1th=
is_cpu_read=A2
  if (!this_cpu_read(*PTRRELOC(&text_poke_area)))
       ^~~~~~~~~~~~~
arch/powerpc/lib/code-patching.c:150:21: error: invalid type argument of =
unary =A1*=A2 (have =A1int=A2)
  if (!this_cpu_read(*PTRRELOC(&text_poke_area)))
                     ^~~~~~~~~~~~~~~~~~~~~~~~~~
./include/linux/compiler.h:343:50: note: in definition of macro =A1__READ=
_ONCE=A2
   __read_once_size_nocheck(&(x), __u.__c, sizeof(x)); \
                                                  ^
./include/asm-generic/percpu.h:123:10: note: in expansion of macro =A1REA=
D_ONCE=A2
  __ret =3D READ_ONCE(*raw_cpu_ptr(&(pcp)));   \
          ^~~~~~~~~
./include/linux/percpu-defs.h:250:47: note: in expansion of macro =A1VERI=
FY_PERCPU_PTR=A2
 #define per_cpu_ptr(ptr, cpu) ({ (void)(cpu); VERIFY_PERCPU_PTR(ptr); })
                                               ^~~~~~~~~~~~~~~~~
./include/linux/percpu-defs.h:251:26: note: in expansion of macro =A1per_=
cpu_ptr=A2
 #define raw_cpu_ptr(ptr) per_cpu_ptr(ptr, 0)
                          ^~~~~~~~~~~
./include/asm-generic/percpu.h:123:21: note: in expansion of macro =A1raw=
_cpu_ptr=A2
  __ret =3D READ_ONCE(*raw_cpu_ptr(&(pcp)));   \
                     ^~~~~~~~~~~
./include/asm-generic/percpu.h:142:11: note: in expansion of macro =A1__t=
his_cpu_generic_read_nopreempt=A2
   __ret =3D __this_cpu_generic_read_nopreempt(pcp);  \
           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
./include/asm-generic/percpu.h:324:31: note: in expansion of macro =A1thi=
s_cpu_generic_read=A2
 #define this_cpu_read_1(pcp)  this_cpu_generic_read(pcp)
                               ^~~~~~~~~~~~~~~~~~~~~
./include/linux/percpu-defs.h:308:23: note: in expansion of macro =A1this=
_cpu_read_1=A2
  case 1: pscr_ret__ =3D stem##1(variable); break;   \
                       ^~~~
./include/linux/percpu-defs.h:494:29: note: in expansion of macro =A1__pc=
pu_size_call_return=A2
 #define this_cpu_read(pcp)  __pcpu_size_call_return(this_cpu_read_, pcp)
                             ^~~~~~~~~~~~~~~~~~~~~~~
arch/powerpc/lib/code-patching.c:150:7: note: in expansion of macro =A1th=
is_cpu_read=A2
  if (!this_cpu_read(*PTRRELOC(&text_poke_area)))
       ^~~~~~~~~~~~~
In file included from ./arch/powerpc/include/asm/percpu.h:20:0,
                 from ./include/linux/percpu.h:13,
                 from ./include/linux/kprobes.h:38,
                 from arch/powerpc/lib/code-patching.c:11:
arch/powerpc/lib/code-patching.c:150:21: error: invalid type argument of =
unary =A1*=A2 (have =A1int=A2)
  if (!this_cpu_read(*PTRRELOC(&text_poke_area)))
                     ^~~~~~~~~~~~~~~~~~~~~~~~~~
./include/asm-generic/percpu.h:130:9: note: in definition of macro =A1__t=
his_cpu_generic_read_noirq=A2
  typeof(pcp) __ret;      \
         ^~~
./include/asm-generic/percpu.h:324:31: note: in expansion of macro =A1thi=
s_cpu_generic_read=A2
 #define this_cpu_read_1(pcp)  this_cpu_generic_read(pcp)
                               ^~~~~~~~~~~~~~~~~~~~~
./include/linux/percpu-defs.h:308:23: note: in expansion of macro =A1this=
_cpu_read_1=A2
  case 1: pscr_ret__ =3D stem##1(variable); break;   \
                       ^~~~
./include/linux/percpu-defs.h:494:29: note: in expansion of macro =A1__pc=
pu_size_call_return=A2
 #define this_cpu_read(pcp)  __pcpu_size_call_return(this_cpu_read_, pcp)
                             ^~~~~~~~~~~~~~~~~~~~~~~
arch/powerpc/lib/code-patching.c:150:7: note: in expansion of macro =A1th=
is_cpu_read=A2
  if (!this_cpu_read(*PTRRELOC(&text_poke_area)))
       ^~~~~~~~~~~~~
In file included from ./include/asm-generic/percpu.h:7:0,
                 from ./arch/powerpc/include/asm/percpu.h:20,
                 from ./include/linux/percpu.h:13,
                 from ./include/linux/kprobes.h:38,
                 from arch/powerpc/lib/code-patching.c:11:
arch/powerpc/lib/code-patching.c:150:21: error: invalid type argument of =
unary =A1*=A2 (have =A1int=A2)
  if (!this_cpu_read(*PTRRELOC(&text_poke_area)))
                     ^~~~~~~~~~~~~~~~~~~~~~~~~~
./include/linux/percpu-defs.h:206:47: note: in definition of macro =A1__v=
erify_pcpu_ptr=A2
  const void __percpu *__vpp_verify =3D (typeof((ptr) + 0))NULL; \
                                               ^~~
./include/linux/percpu-defs.h:250:47: note: in expansion of macro =A1VERI=
FY_PERCPU_PTR=A2
 #define per_cpu_ptr(ptr, cpu) ({ (void)(cpu); VERIFY_PERCPU_PTR(ptr); })
                                               ^~~~~~~~~~~~~~~~~
./include/linux/percpu-defs.h:251:26: note: in expansion of macro =A1per_=
cpu_ptr=A2
 #define raw_cpu_ptr(ptr) per_cpu_ptr(ptr, 0)
                          ^~~~~~~~~~~
./include/asm-generic/percpu.h:71:3: note: in expansion of macro =A1raw_c=
pu_ptr=A2
  *raw_cpu_ptr(&(pcp));      \
   ^~~~~~~~~~~
./include/asm-generic/percpu.h:133:10: note: in expansion of macro =A1raw=
_cpu_generic_read=A2
  __ret =3D raw_cpu_generic_read(pcp);    \
          ^~~~~~~~~~~~~~~~~~~~
./include/asm-generic/percpu.h:144:11: note: in expansion of macro =A1__t=
his_cpu_generic_read_noirq=A2
   __ret =3D __this_cpu_generic_read_noirq(pcp);  \
           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
./include/asm-generic/percpu.h:324:31: note: in expansion of macro =A1thi=
s_cpu_generic_read=A2
 #define this_cpu_read_1(pcp)  this_cpu_generic_read(pcp)
                               ^~~~~~~~~~~~~~~~~~~~~
./include/linux/percpu-defs.h:308:23: note: in expansion of macro =A1this=
_cpu_read_1=A2
  case 1: pscr_ret__ =3D stem##1(variable); break;   \
                       ^~~~
./include/linux/percpu-defs.h:494:29: note: in expansion of macro =A1__pc=
pu_size_call_return=A2
 #define this_cpu_read(pcp)  __pcpu_size_call_return(this_cpu_read_, pcp)
                             ^~~~~~~~~~~~~~~~~~~~~~~
arch/powerpc/lib/code-patching.c:150:7: note: in expansion of macro =A1th=
is_cpu_read=A2
  if (!this_cpu_read(*PTRRELOC(&text_poke_area)))
       ^~~~~~~~~~~~~
arch/powerpc/lib/code-patching.c:150:21: error: invalid type argument of =
unary =A1*=A2 (have =A1int=A2)
  if (!this_cpu_read(*PTRRELOC(&text_poke_area)))
                     ^~~~~~~~~~~~~~~~~~~~~~~~~~
./include/linux/percpu-defs.h:247:12: note: in definition of macro =A1VER=
IFY_PERCPU_PTR=A2
  (typeof(*(__p)) __kernel __force *)(__p);   \
            ^~~
./include/linux/percpu-defs.h:251:26: note: in expansion of macro =A1per_=
cpu_ptr=A2
 #define raw_cpu_ptr(ptr) per_cpu_ptr(ptr, 0)
                          ^~~~~~~~~~~
./include/asm-generic/percpu.h:71:3: note: in expansion of macro =A1raw_c=
pu_ptr=A2
  *raw_cpu_ptr(&(pcp));      \
   ^~~~~~~~~~~
./include/asm-generic/percpu.h:133:10: note: in expansion of macro =A1raw=
_cpu_generic_read=A2
  __ret =3D raw_cpu_generic_read(pcp);    \
          ^~~~~~~~~~~~~~~~~~~~
./include/asm-generic/percpu.h:144:11: note: in expansion of macro =A1__t=
his_cpu_generic_read_noirq=A2
   __ret =3D __this_cpu_generic_read_noirq(pcp);  \
           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
./include/asm-generic/percpu.h:324:31: note: in expansion of macro =A1thi=
s_cpu_generic_read=A2
 #define this_cpu_read_1(pcp)  this_cpu_generic_read(pcp)
                               ^~~~~~~~~~~~~~~~~~~~~
./include/linux/percpu-defs.h:308:23: note: in expansion of macro =A1this=
_cpu_read_1=A2
  case 1: pscr_ret__ =3D stem##1(variable); break;   \
                       ^~~~
./include/linux/percpu-defs.h:494:29: note: in expansion of macro =A1__pc=
pu_size_call_return=A2
 #define this_cpu_read(pcp)  __pcpu_size_call_return(this_cpu_read_, pcp)
                             ^~~~~~~~~~~~~~~~~~~~~~~
arch/powerpc/lib/code-patching.c:150:7: note: in expansion of macro =A1th=
is_cpu_read=A2
  if (!this_cpu_read(*PTRRELOC(&text_poke_area)))
       ^~~~~~~~~~~~~
arch/powerpc/lib/code-patching.c:150:21: error: invalid type argument of =
unary =A1*=A2 (have =A1int=A2)
  if (!this_cpu_read(*PTRRELOC(&text_poke_area)))
                     ^~~~~~~~~~~~~~~~~~~~~~~~~~
./include/linux/percpu-defs.h:247:38: note: in definition of macro =A1VER=
IFY_PERCPU_PTR=A2
  (typeof(*(__p)) __kernel __force *)(__p);   \
                                      ^~~
./include/linux/percpu-defs.h:251:26: note: in expansion of macro =A1per_=
cpu_ptr=A2
 #define raw_cpu_ptr(ptr) per_cpu_ptr(ptr, 0)
                          ^~~~~~~~~~~
./include/asm-generic/percpu.h:71:3: note: in expansion of macro =A1raw_c=
pu_ptr=A2
  *raw_cpu_ptr(&(pcp));      \
   ^~~~~~~~~~~
./include/asm-generic/percpu.h:133:10: note: in expansion of macro =A1raw=
_cpu_generic_read=A2
  __ret =3D raw_cpu_generic_read(pcp);    \
          ^~~~~~~~~~~~~~~~~~~~
./include/asm-generic/percpu.h:144:11: note: in expansion of macro =A1__t=
his_cpu_generic_read_noirq=A2
   __ret =3D __this_cpu_generic_read_noirq(pcp);  \
           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
./include/asm-generic/percpu.h:324:31: note: in expansion of macro =A1thi=
s_cpu_generic_read=A2
 #define this_cpu_read_1(pcp)  this_cpu_generic_read(pcp)
                               ^~~~~~~~~~~~~~~~~~~~~
./include/linux/percpu-defs.h:308:23: note: in expansion of macro =A1this=
_cpu_read_1=A2
  case 1: pscr_ret__ =3D stem##1(variable); break;   \
                       ^~~~
./include/linux/percpu-defs.h:494:29: note: in expansion of macro =A1__pc=
pu_size_call_return=A2
 #define this_cpu_read(pcp)  __pcpu_size_call_return(this_cpu_read_, pcp)
                             ^~~~~~~~~~~~~~~~~~~~~~~
arch/powerpc/lib/code-patching.c:150:7: note: in expansion of macro =A1th=
is_cpu_read=A2
  if (!this_cpu_read(*PTRRELOC(&text_poke_area)))
       ^~~~~~~~~~~~~
In file included from ./arch/powerpc/include/asm/percpu.h:20:0,
                 from ./include/linux/percpu.h:13,
                 from ./include/linux/kprobes.h:38,
                 from arch/powerpc/lib/code-patching.c:11:
arch/powerpc/lib/code-patching.c:150:21: error: invalid type argument of =
unary =A1*=A2 (have =A1int=A2)
  if (!this_cpu_read(*PTRRELOC(&text_poke_area)))
                     ^~~~~~~~~~~~~~~~~~~~~~~~~~
./include/asm-generic/percpu.h:140:9: note: in definition of macro =A1thi=
s_cpu_generic_read=A2
  typeof(pcp) __ret;      \
         ^~~
./include/linux/percpu-defs.h:309:23: note: in expansion of macro =A1this=
_cpu_read_2=A2
  case 2: pscr_ret__ =3D stem##2(variable); break;   \
                       ^~~~
./include/linux/percpu-defs.h:494:29: note: in expansion of macro =A1__pc=
pu_size_call_return=A2
 #define this_cpu_read(pcp)  __pcpu_size_call_return(this_cpu_read_, pcp)
                             ^~~~~~~~~~~~~~~~~~~~~~~
arch/powerpc/lib/code-patching.c:150:7: note: in expansion of macro =A1th=
is_cpu_read=A2
  if (!this_cpu_read(*PTRRELOC(&text_poke_area)))
       ^~~~~~~~~~~~~
In file included from ./include/linux/linkage.h:5:0,
                 from ./include/linux/kernel.h:7,
                 from arch/powerpc/lib/code-patching.c:10:
arch/powerpc/lib/code-patching.c:150:21: error: invalid type argument of =
unary =A1*=A2 (have =A1int=A2)
  if (!this_cpu_read(*PTRRELOC(&text_poke_area)))
                     ^~~~~~~~~~~~~~~~~~~~~~~~~~
./include/linux/compiler.h:524:35: note: in definition of macro =A1__nati=
ve_word=A2
 # define __native_word(t) (sizeof(t) =3D=3D sizeof(char) || sizeof(t) =3D=
=3D sizeof(short) || sizeof(t) =3D=3D sizeof(int) || sizeof(t) =3D=3D siz=
eof(long))
                                   ^
./include/asm-generic/percpu.h:327:31: note: in expansion of macro =A1thi=
s_cpu_generic_read=A2
 #define this_cpu_read_2(pcp)  this_cpu_generic_read(pcp)
                               ^~~~~~~~~~~~~~~~~~~~~
./include/linux/percpu-defs.h:309:23: note: in expansion of macro =A1this=
_cpu_read_2=A2
  case 2: pscr_ret__ =3D stem##2(variable); break;   \
                       ^~~~
./include/linux/percpu-defs.h:494:29: note: in expansion of macro =A1__pc=
pu_size_call_return=A2
 #define this_cpu_read(pcp)  __pcpu_size_call_return(this_cpu_read_, pcp)
                             ^~~~~~~~~~~~~~~~~~~~~~~
arch/powerpc/lib/code-patching.c:150:7: note: in expansion of macro =A1th=
is_cpu_read=A2
  if (!this_cpu_read(*PTRRELOC(&text_poke_area)))
       ^~~~~~~~~~~~~
arch/powerpc/lib/code-patching.c:150:21: error: invalid type argument of =
unary =A1*=A2 (have =A1int=A2)
  if (!this_cpu_read(*PTRRELOC(&text_poke_area)))
                     ^~~~~~~~~~~~~~~~~~~~~~~~~~
./include/linux/compiler.h:524:64: note: in definition of macro =A1__nati=
ve_word=A2
 # define __native_word(t) (sizeof(t) =3D=3D sizeof(char) || sizeof(t) =3D=
=3D sizeof(short) || sizeof(t) =3D=3D sizeof(int) || sizeof(t) =3D=3D siz=
eof(long))
                                                                ^
./include/asm-generic/percpu.h:327:31: note: in expansion of macro =A1thi=
s_cpu_generic_read=A2
 #define this_cpu_read_2(pcp)  this_cpu_generic_read(pcp)
                               ^~~~~~~~~~~~~~~~~~~~~
./include/linux/percpu-defs.h:309:23: note: in expansion of macro =A1this=
_cpu_read_2=A2
  case 2: pscr_ret__ =3D stem##2(variable); break;   \
                       ^~~~
./include/linux/percpu-defs.h:494:29: note: in expansion of macro =A1__pc=
pu_size_call_return=A2
 #define this_cpu_read(pcp)  __pcpu_size_call_return(this_cpu_read_, pcp)
                             ^~~~~~~~~~~~~~~~~~~~~~~
arch/powerpc/lib/code-patching.c:150:7: note: in expansion of macro =A1th=
is_cpu_read=A2
  if (!this_cpu_read(*PTRRELOC(&text_poke_area)))
       ^~~~~~~~~~~~~
arch/powerpc/lib/code-patching.c:150:21: error: invalid type argument of =
unary =A1*=A2 (have =A1int=A2)
  if (!this_cpu_read(*PTRRELOC(&text_poke_area)))
                     ^~~~~~~~~~~~~~~~~~~~~~~~~~
./include/linux/compiler.h:524:94: note: in definition of macro =A1__nati=
ve_word=A2
 # define __native_word(t) (sizeof(t) =3D=3D sizeof(char) || sizeof(t) =3D=
=3D sizeof(short) || sizeof(t) =3D=3D sizeof(int) || sizeof(t) =3D=3D siz=
eof(long))
                                                                         =
                     ^
./include/asm-generic/percpu.h:327:31: note: in expansion of macro =A1thi=
s_cpu_generic_read=A2
 #define this_cpu_read_2(pcp)  this_cpu_generic_read(pcp)
                               ^~~~~~~~~~~~~~~~~~~~~
./include/linux/percpu-defs.h:309:23: note: in expansion of macro =A1this=
_cpu_read_2=A2
  case 2: pscr_ret__ =3D stem##2(variable); break;   \
                       ^~~~
./include/linux/percpu-defs.h:494:29: note: in expansion of macro =A1__pc=
pu_size_call_return=A2
 #define this_cpu_read(pcp)  __pcpu_size_call_return(this_cpu_read_, pcp)
                             ^~~~~~~~~~~~~~~~~~~~~~~
arch/powerpc/lib/code-patching.c:150:7: note: in expansion of macro =A1th=
is_cpu_read=A2
  if (!this_cpu_read(*PTRRELOC(&text_poke_area)))
       ^~~~~~~~~~~~~
arch/powerpc/lib/code-patching.c:150:21: error: invalid type argument of =
unary =A1*=A2 (have =A1int=A2)
  if (!this_cpu_read(*PTRRELOC(&text_poke_area)))
                     ^~~~~~~~~~~~~~~~~~~~~~~~~~
./include/linux/compiler.h:524:122: note: in definition of macro =A1__nat=
ive_word=A2
 # define __native_word(t) (sizeof(t) =3D=3D sizeof(char) || sizeof(t) =3D=
=3D sizeof(short) || sizeof(t) =3D=3D sizeof(int) || sizeof(t) =3D=3D siz=
eof(long))
                                                                         =
                                                 ^
./include/asm-generic/percpu.h:327:31: note: in expansion of macro =A1thi=
s_cpu_generic_read=A2
 #define this_cpu_read_2(pcp)  this_cpu_generic_read(pcp)
                               ^~~~~~~~~~~~~~~~~~~~~
./include/linux/percpu-defs.h:309:23: note: in expansion of macro =A1this=
_cpu_read_2=A2
  case 2: pscr_ret__ =3D stem##2(variable); break;   \
                       ^~~~
./include/linux/percpu-defs.h:494:29: note: in expansion of macro =A1__pc=
pu_size_call_return=A2
 #define this_cpu_read(pcp)  __pcpu_size_call_return(this_cpu_read_, pcp)
                             ^~~~~~~~~~~~~~~~~~~~~~~
arch/powerpc/lib/code-patching.c:150:7: note: in expansion of macro =A1th=
is_cpu_read=A2
  if (!this_cpu_read(*PTRRELOC(&text_poke_area)))
       ^~~~~~~~~~~~~
In file included from ./arch/powerpc/include/asm/percpu.h:20:0,
                 from ./include/linux/percpu.h:13,
                 from ./include/linux/kprobes.h:38,
                 from arch/powerpc/lib/code-patching.c:11:
arch/powerpc/lib/code-patching.c:150:21: error: invalid type argument of =
unary =A1*=A2 (have =A1int=A2)
  if (!this_cpu_read(*PTRRELOC(&text_poke_area)))
                     ^~~~~~~~~~~~~~~~~~~~~~~~~~
./include/asm-generic/percpu.h:121:9: note: in definition of macro =A1__t=
his_cpu_generic_read_nopreempt=A2
  typeof(pcp) __ret;      \
         ^~~
./include/asm-generic/percpu.h:327:31: note: in expansion of macro =A1thi=
s_cpu_generic_read=A2
 #define this_cpu_read_2(pcp)  this_cpu_generic_read(pcp)
                               ^~~~~~~~~~~~~~~~~~~~~
./include/linux/percpu-defs.h:309:23: note: in expansion of macro =A1this=
_cpu_read_2=A2
  case 2: pscr_ret__ =3D stem##2(variable); break;   \
                       ^~~~
./include/linux/percpu-defs.h:494:29: note: in expansion of macro =A1__pc=
pu_size_call_return=A2
 #define this_cpu_read(pcp)  __pcpu_size_call_return(this_cpu_read_, pcp)
                             ^~~~~~~~~~~~~~~~~~~~~~~
arch/powerpc/lib/code-patching.c:150:7: note: in expansion of macro =A1th=
is_cpu_read=A2
  if (!this_cpu_read(*PTRRELOC(&text_poke_area)))
       ^~~~~~~~~~~~~
In file included from ./include/linux/linkage.h:5:0,
                 from ./include/linux/kernel.h:7,
                 from arch/powerpc/lib/code-patching.c:10:
arch/powerpc/lib/code-patching.c:150:21: error: invalid type argument of =
unary =A1*=A2 (have =A1int=A2)
  if (!this_cpu_read(*PTRRELOC(&text_poke_area)))
                     ^~~~~~~~~~~~~~~~~~~~~~~~~~
./include/linux/compiler.h:339:17: note: in definition of macro =A1__READ=
_ONCE=A2
  union { typeof(x) __val; char __c[1]; } __u;   \
                 ^
./include/asm-generic/percpu.h:123:10: note: in expansion of macro =A1REA=
D_ONCE=A2
  __ret =3D READ_ONCE(*raw_cpu_ptr(&(pcp)));   \
          ^~~~~~~~~
./include/linux/percpu-defs.h:246:2: note: in expansion of macro =A1__ver=
ify_pcpu_ptr=A2
  __verify_pcpu_ptr(__p);      \
  ^~~~~~~~~~~~~~~~~
./include/linux/percpu-defs.h:250:47: note: in expansion of macro =A1VERI=
FY_PERCPU_PTR=A2
 #define per_cpu_ptr(ptr, cpu) ({ (void)(cpu); VERIFY_PERCPU_PTR(ptr); })
                                               ^~~~~~~~~~~~~~~~~
./include/linux/percpu-defs.h:251:26: note: in expansion of macro =A1per_=
cpu_ptr=A2
 #define raw_cpu_ptr(ptr) per_cpu_ptr(ptr, 0)
                          ^~~~~~~~~~~
./include/asm-generic/percpu.h:123:21: note: in expansion of macro =A1raw=
_cpu_ptr=A2
  __ret =3D READ_ONCE(*raw_cpu_ptr(&(pcp)));   \
                     ^~~~~~~~~~~
./include/asm-generic/percpu.h:142:11: note: in expansion of macro =A1__t=
his_cpu_generic_read_nopreempt=A2
   __ret =3D __this_cpu_generic_read_nopreempt(pcp);  \
           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
./include/asm-generic/percpu.h:327:31: note: in expansion of macro =A1thi=
s_cpu_generic_read=A2
 #define this_cpu_read_2(pcp)  this_cpu_generic_read(pcp)
                               ^~~~~~~~~~~~~~~~~~~~~
./include/linux/percpu-defs.h:309:23: note: in expansion of macro =A1this=
_cpu_read_2=A2
  case 2: pscr_ret__ =3D stem##2(variable); break;   \
                       ^~~~
./include/linux/percpu-defs.h:494:29: note: in expansion of macro =A1__pc=
pu_size_call_return=A2
 #define this_cpu_read(pcp)  __pcpu_size_call_return(this_cpu_read_, pcp)
                             ^~~~~~~~~~~~~~~~~~~~~~~
arch/powerpc/lib/code-patching.c:150:7: note: in expansion of macro =A1th=
is_cpu_read=A2
  if (!this_cpu_read(*PTRRELOC(&text_poke_area)))
       ^~~~~~~~~~~~~
arch/powerpc/lib/code-patching.c:150:21: error: invalid type argument of =
unary =A1*=A2 (have =A1int=A2)
  if (!this_cpu_read(*PTRRELOC(&text_poke_area)))
                     ^~~~~~~~~~~~~~~~~~~~~~~~~~
./include/linux/compiler.h:339:17: note: in definition of macro =A1__READ=
_ONCE=A2
  union { typeof(x) __val; char __c[1]; } __u;   \
                 ^
./include/asm-generic/percpu.h:123:10: note: in expansion of macro =A1REA=
D_ONCE=A2
  __ret =3D READ_ONCE(*raw_cpu_ptr(&(pcp)));   \
          ^~~~~~~~~
./include/linux/percpu-defs.h:250:47: note: in expansion of macro =A1VERI=
FY_PERCPU_PTR=A2
 #define per_cpu_ptr(ptr, cpu) ({ (void)(cpu); VERIFY_PERCPU_PTR(ptr); })
                                               ^~~~~~~~~~~~~~~~~
./include/linux/percpu-defs.h:251:26: note: in expansion of macro =A1per_=
cpu_ptr=A2
 #define raw_cpu_ptr(ptr) per_cpu_ptr(ptr, 0)
                          ^~~~~~~~~~~
./include/asm-generic/percpu.h:123:21: note: in expansion of macro =A1raw=
_cpu_ptr=A2
  __ret =3D READ_ONCE(*raw_cpu_ptr(&(pcp)));   \
                     ^~~~~~~~~~~
./include/asm-generic/percpu.h:142:11: note: in expansion of macro =A1__t=
his_cpu_generic_read_nopreempt=A2
   __ret =3D __this_cpu_generic_read_nopreempt(pcp);  \
           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
./include/asm-generic/percpu.h:327:31: note: in expansion of macro =A1thi=
s_cpu_generic_read=A2
 #define this_cpu_read_2(pcp)  this_cpu_generic_read(pcp)
                               ^~~~~~~~~~~~~~~~~~~~~
./include/linux/percpu-defs.h:309:23: note: in expansion of macro =A1this=
_cpu_read_2=A2
  case 2: pscr_ret__ =3D stem##2(variable); break;   \
                       ^~~~
./include/linux/percpu-defs.h:494:29: note: in expansion of macro =A1__pc=
pu_size_call_return=A2
 #define this_cpu_read(pcp)  __pcpu_size_call_return(this_cpu_read_, pcp)
                             ^~~~~~~~~~~~~~~~~~~~~~~
arch/powerpc/lib/code-patching.c:150:7: note: in expansion of macro =A1th=
is_cpu_read=A2
  if (!this_cpu_read(*PTRRELOC(&text_poke_area)))
       ^~~~~~~~~~~~~
arch/powerpc/lib/code-patching.c:150:21: error: invalid type argument of =
unary =A1*=A2 (have =A1int=A2)
  if (!this_cpu_read(*PTRRELOC(&text_poke_area)))
                     ^~~~~~~~~~~~~~~~~~~~~~~~~~
./include/linux/compiler.h:339:17: note: in definition of macro =A1__READ=
_ONCE=A2
  union { typeof(x) __val; char __c[1]; } __u;   \
                 ^
./include/asm-generic/percpu.h:123:10: note: in expansion of macro =A1REA=
D_ONCE=A2
  __ret =3D READ_ONCE(*raw_cpu_ptr(&(pcp)));   \
          ^~~~~~~~~
./include/linux/percpu-defs.h:250:47: note: in expansion of macro =A1VERI=
FY_PERCPU_PTR=A2
 #define per_cpu_ptr(ptr, cpu) ({ (void)(cpu); VERIFY_PERCPU_PTR(ptr); })
                                               ^~~~~~~~~~~~~~~~~
./include/linux/percpu-defs.h:251:26: note: in expansion of macro =A1per_=
cpu_ptr=A2
 #define raw_cpu_ptr(ptr) per_cpu_ptr(ptr, 0)
                          ^~~~~~~~~~~
./include/asm-generic/percpu.h:123:21: note: in expansion of macro =A1raw=
_cpu_ptr=A2
  __ret =3D READ_ONCE(*raw_cpu_ptr(&(pcp)));   \
                     ^~~~~~~~~~~
./include/asm-generic/percpu.h:142:11: note: in expansion of macro =A1__t=
his_cpu_generic_read_nopreempt=A2
   __ret =3D __this_cpu_generic_read_nopreempt(pcp);  \
           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
./include/asm-generic/percpu.h:327:31: note: in expansion of macro =A1thi=
s_cpu_generic_read=A2
 #define this_cpu_read_2(pcp)  this_cpu_generic_read(pcp)
                               ^~~~~~~~~~~~~~~~~~~~~
./include/linux/percpu-defs.h:309:23: note: in expansion of macro =A1this=
_cpu_read_2=A2
  case 2: pscr_ret__ =3D stem##2(variable); break;   \
                       ^~~~
./include/linux/percpu-defs.h:494:29: note: in expansion of macro =A1__pc=
pu_size_call_return=A2
 #define this_cpu_read(pcp)  __pcpu_size_call_return(this_cpu_read_, pcp)
                             ^~~~~~~~~~~~~~~~~~~~~~~
arch/powerpc/lib/code-patching.c:150:7: note: in expansion of macro =A1th=
is_cpu_read=A2
  if (!this_cpu_read(*PTRRELOC(&text_poke_area)))
       ^~~~~~~~~~~~~
arch/powerpc/lib/code-patching.c:150:21: error: invalid type argument of =
unary =A1*=A2 (have =A1int=A2)
  if (!this_cpu_read(*PTRRELOC(&text_poke_area)))
                     ^~~~~~~~~~~~~~~~~~~~~~~~~~
./include/linux/compiler.h:341:22: note: in definition of macro =A1__READ=
_ONCE=A2
   __read_once_size(&(x), __u.__c, sizeof(x));  \
                      ^
./include/asm-generic/percpu.h:123:10: note: in expansion of macro =A1REA=
D_ONCE=A2
  __ret =3D READ_ONCE(*raw_cpu_ptr(&(pcp)));   \
          ^~~~~~~~~
./include/linux/percpu-defs.h:246:2: note: in expansion of macro =A1__ver=
ify_pcpu_ptr=A2
  __verify_pcpu_ptr(__p);      \
  ^~~~~~~~~~~~~~~~~
./include/linux/percpu-defs.h:250:47: note: in expansion of macro =A1VERI=
FY_PERCPU_PTR=A2
 #define per_cpu_ptr(ptr, cpu) ({ (void)(cpu); VERIFY_PERCPU_PTR(ptr); })
                                               ^~~~~~~~~~~~~~~~~
./include/linux/percpu-defs.h:251:26: note: in expansion of macro =A1per_=
cpu_ptr=A2
 #define raw_cpu_ptr(ptr) per_cpu_ptr(ptr, 0)
                          ^~~~~~~~~~~
./include/asm-generic/percpu.h:123:21: note: in expansion of macro =A1raw=
_cpu_ptr=A2
  __ret =3D READ_ONCE(*raw_cpu_ptr(&(pcp)));   \
                     ^~~~~~~~~~~
./include/asm-generic/percpu.h:142:11: note: in expansion of macro =A1__t=
his_cpu_generic_read_nopreempt=A2
   __ret =3D __this_cpu_generic_read_nopreempt(pcp);  \
           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
./include/asm-generic/percpu.h:327:31: note: in expansion of macro =A1thi=
s_cpu_generic_read=A2
 #define this_cpu_read_2(pcp)  this_cpu_generic_read(pcp)
                               ^~~~~~~~~~~~~~~~~~~~~
./include/linux/percpu-defs.h:309:23: note: in expansion of macro =A1this=
_cpu_read_2=A2
  case 2: pscr_ret__ =3D stem##2(variable); break;   \
                       ^~~~
./include/linux/percpu-defs.h:494:29: note: in expansion of macro =A1__pc=
pu_size_call_return=A2
 #define this_cpu_read(pcp)  __pcpu_size_call_return(this_cpu_read_, pcp)
                             ^~~~~~~~~~~~~~~~~~~~~~~
arch/powerpc/lib/code-patching.c:150:7: note: in expansion of macro =A1th=
is_cpu_read=A2
  if (!this_cpu_read(*PTRRELOC(&text_poke_area)))
       ^~~~~~~~~~~~~
arch/powerpc/lib/code-patching.c:150:21: error: invalid type argument of =
unary =A1*=A2 (have =A1int=A2)
  if (!this_cpu_read(*PTRRELOC(&text_poke_area)))
                     ^~~~~~~~~~~~~~~~~~~~~~~~~~
./include/linux/compiler.h:341:22: note: in definition of macro =A1__READ=
_ONCE=A2
   __read_once_size(&(x), __u.__c, sizeof(x));  \
                      ^
./include/asm-generic/percpu.h:123:10: note: in expansion of macro =A1REA=
D_ONCE=A2
  __ret =3D READ_ONCE(*raw_cpu_ptr(&(pcp)));   \
          ^~~~~~~~~
./include/linux/percpu-defs.h:250:47: note: in expansion of macro =A1VERI=
FY_PERCPU_PTR=A2
 #define per_cpu_ptr(ptr, cpu) ({ (void)(cpu); VERIFY_PERCPU_PTR(ptr); })
                                               ^~~~~~~~~~~~~~~~~
./include/linux/percpu-defs.h:251:26: note: in expansion of macro =A1per_=
cpu_ptr=A2
 #define raw_cpu_ptr(ptr) per_cpu_ptr(ptr, 0)
                          ^~~~~~~~~~~
./include/asm-generic/percpu.h:123:21: note: in expansion of macro =A1raw=
_cpu_ptr=A2
  __ret =3D READ_ONCE(*raw_cpu_ptr(&(pcp)));   \
                     ^~~~~~~~~~~
./include/asm-generic/percpu.h:142:11: note: in expansion of macro =A1__t=
his_cpu_generic_read_nopreempt=A2
   __ret =3D __this_cpu_generic_read_nopreempt(pcp);  \
           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
./include/asm-generic/percpu.h:327:31: note: in expansion of macro =A1thi=
s_cpu_generic_read=A2
 #define this_cpu_read_2(pcp)  this_cpu_generic_read(pcp)
                               ^~~~~~~~~~~~~~~~~~~~~
./include/linux/percpu-defs.h:309:23: note: in expansion of macro =A1this=
_cpu_read_2=A2
  case 2: pscr_ret__ =3D stem##2(variable); break;   \
                       ^~~~
./include/linux/percpu-defs.h:494:29: note: in expansion of macro =A1__pc=
pu_size_call_return=A2
 #define this_cpu_read(pcp)  __pcpu_size_call_return(this_cpu_read_, pcp)
                             ^~~~~~~~~~~~~~~~~~~~~~~
arch/powerpc/lib/code-patching.c:150:7: note: in expansion of macro =A1th=
is_cpu_read=A2
  if (!this_cpu_read(*PTRRELOC(&text_poke_area)))
       ^~~~~~~~~~~~~
arch/powerpc/lib/code-patching.c:150:21: error: invalid type argument of =
unary =A1*=A2 (have =A1int=A2)
  if (!this_cpu_read(*PTRRELOC(&text_poke_area)))
                     ^~~~~~~~~~~~~~~~~~~~~~~~~~
./include/linux/compiler.h:341:22: note: in definition of macro =A1__READ=
_ONCE=A2
   __read_once_size(&(x), __u.__c, sizeof(x));  \
                      ^
./include/asm-generic/percpu.h:123:10: note: in expansion of macro =A1REA=
D_ONCE=A2
  __ret =3D READ_ONCE(*raw_cpu_ptr(&(pcp)));   \
          ^~~~~~~~~
./include/linux/percpu-defs.h:250:47: note: in expansion of macro =A1VERI=
FY_PERCPU_PTR=A2
 #define per_cpu_ptr(ptr, cpu) ({ (void)(cpu); VERIFY_PERCPU_PTR(ptr); })
                                               ^~~~~~~~~~~~~~~~~
./include/linux/percpu-defs.h:251:26: note: in expansion of macro =A1per_=
cpu_ptr=A2
 #define raw_cpu_ptr(ptr) per_cpu_ptr(ptr, 0)
                          ^~~~~~~~~~~
./include/asm-generic/percpu.h:123:21: note: in expansion of macro =A1raw=
_cpu_ptr=A2
  __ret =3D READ_ONCE(*raw_cpu_ptr(&(pcp)));   \
                     ^~~~~~~~~~~
./include/asm-generic/percpu.h:142:11: note: in expansion of macro =A1__t=
his_cpu_generic_read_nopreempt=A2
   __ret =3D __this_cpu_generic_read_nopreempt(pcp);  \
           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
./include/asm-generic/percpu.h:327:31: note: in expansion of macro =A1thi=
s_cpu_generic_read=A2
 #define this_cpu_read_2(pcp)  this_cpu_generic_read(pcp)
                               ^~~~~~~~~~~~~~~~~~~~~
./include/linux/percpu-defs.h:309:23: note: in expansion of macro =A1this=
_cpu_read_2=A2
  case 2: pscr_ret__ =3D stem##2(variable); break;   \
                       ^~~~
./include/linux/percpu-defs.h:494:29: note: in expansion of macro =A1__pc=
pu_size_call_return=A2
 #define this_cpu_read(pcp)  __pcpu_size_call_return(this_cpu_read_, pcp)
                             ^~~~~~~~~~~~~~~~~~~~~~~
arch/powerpc/lib/code-patching.c:150:7: note: in expansion of macro =A1th=
is_cpu_read=A2
  if (!this_cpu_read(*PTRRELOC(&text_poke_area)))
       ^~~~~~~~~~~~~
arch/powerpc/lib/code-patching.c:150:21: error: invalid type argument of =
unary =A1*=A2 (have =A1int=A2)
  if (!this_cpu_read(*PTRRELOC(&text_poke_area)))
                     ^~~~~~~~~~~~~~~~~~~~~~~~~~
./include/linux/compiler.h:341:42: note: in definition of macro =A1__READ=
_ONCE=A2
   __read_once_size(&(x), __u.__c, sizeof(x));  \
                                          ^
./include/asm-generic/percpu.h:123:10: note: in expansion of macro =A1REA=
D_ONCE=A2
  __ret =3D READ_ONCE(*raw_cpu_ptr(&(pcp)));   \
          ^~~~~~~~~
./include/linux/percpu-defs.h:246:2: note: in expansion of macro =A1__ver=
ify_pcpu_ptr=A2
  __verify_pcpu_ptr(__p);      \
  ^~~~~~~~~~~~~~~~~
./include/linux/percpu-defs.h:250:47: note: in expansion of macro =A1VERI=
FY_PERCPU_PTR=A2
 #define per_cpu_ptr(ptr, cpu) ({ (void)(cpu); VERIFY_PERCPU_PTR(ptr); })
                                               ^~~~~~~~~~~~~~~~~
./include/linux/percpu-defs.h:251:26: note: in expansion of macro =A1per_=
cpu_ptr=A2
 #define raw_cpu_ptr(ptr) per_cpu_ptr(ptr, 0)
                          ^~~~~~~~~~~
./include/asm-generic/percpu.h:123:21: note: in expansion of macro =A1raw=
_cpu_ptr=A2
  __ret =3D READ_ONCE(*raw_cpu_ptr(&(pcp)));   \
                     ^~~~~~~~~~~
./include/asm-generic/percpu.h:142:11: note: in expansion of macro =A1__t=
his_cpu_generic_read_nopreempt=A2
   __ret =3D __this_cpu_generic_read_nopreempt(pcp);  \
           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
./include/asm-generic/percpu.h:327:31: note: in expansion of macro =A1thi=
s_cpu_generic_read=A2
 #define this_cpu_read_2(pcp)  this_cpu_generic_read(pcp)
                               ^~~~~~~~~~~~~~~~~~~~~
./include/linux/percpu-defs.h:309:23: note: in expansion of macro =A1this=
_cpu_read_2=A2
  case 2: pscr_ret__ =3D stem##2(variable); break;   \
                       ^~~~
./include/linux/percpu-defs.h:494:29: note: in expansion of macro =A1__pc=
pu_size_call_return=A2
 #define this_cpu_read(pcp)  __pcpu_size_call_return(this_cpu_read_, pcp)
                             ^~~~~~~~~~~~~~~~~~~~~~~
arch/powerpc/lib/code-patching.c:150:7: note: in expansion of macro =A1th=
is_cpu_read=A2
  if (!this_cpu_read(*PTRRELOC(&text_poke_area)))
       ^~~~~~~~~~~~~
arch/powerpc/lib/code-patching.c:150:21: error: invalid type argument of =
unary =A1*=A2 (have =A1int=A2)
  if (!this_cpu_read(*PTRRELOC(&text_poke_area)))
                     ^~~~~~~~~~~~~~~~~~~~~~~~~~
./include/linux/compiler.h:341:42: note: in definition of macro =A1__READ=
_ONCE=A2
   __read_once_size(&(x), __u.__c, sizeof(x));  \
                                          ^
./include/asm-generic/percpu.h:123:10: note: in expansion of macro =A1REA=
D_ONCE=A2
  __ret =3D READ_ONCE(*raw_cpu_ptr(&(pcp)));   \
          ^~~~~~~~~
./include/linux/percpu-defs.h:250:47: note: in expansion of macro =A1VERI=
FY_PERCPU_PTR=A2
 #define per_cpu_ptr(ptr, cpu) ({ (void)(cpu); VERIFY_PERCPU_PTR(ptr); })
                                               ^~~~~~~~~~~~~~~~~
./include/linux/percpu-defs.h:251:26: note: in expansion of macro =A1per_=
cpu_ptr=A2
 #define raw_cpu_ptr(ptr) per_cpu_ptr(ptr, 0)
                          ^~~~~~~~~~~
./include/asm-generic/percpu.h:123:21: note: in expansion of macro =A1raw=
_cpu_ptr=A2
  __ret =3D READ_ONCE(*raw_cpu_ptr(&(pcp)));   \
                     ^~~~~~~~~~~
./include/asm-generic/percpu.h:142:11: note: in expansion of macro =A1__t=
his_cpu_generic_read_nopreempt=A2
   __ret =3D __this_cpu_generic_read_nopreempt(pcp);  \
           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
./include/asm-generic/percpu.h:327:31: note: in expansion of macro =A1thi=
s_cpu_generic_read=A2
 #define this_cpu_read_2(pcp)  this_cpu_generic_read(pcp)
                               ^~~~~~~~~~~~~~~~~~~~~
./include/linux/percpu-defs.h:309:23: note: in expansion of macro =A1this=
_cpu_read_2=A2
  case 2: pscr_ret__ =3D stem##2(variable); break;   \
                       ^~~~
./include/linux/percpu-defs.h:494:29: note: in expansion of macro =A1__pc=
pu_size_call_return=A2
 #define this_cpu_read(pcp)  __pcpu_size_call_return(this_cpu_read_, pcp)
                             ^~~~~~~~~~~~~~~~~~~~~~~
arch/powerpc/lib/code-patching.c:150:7: note: in expansion of macro =A1th=
is_cpu_read=A2
  if (!this_cpu_read(*PTRRELOC(&text_poke_area)))
       ^~~~~~~~~~~~~
arch/powerpc/lib/code-patching.c:150:21: error: invalid type argument of =
unary =A1*=A2 (have =A1int=A2)
  if (!this_cpu_read(*PTRRELOC(&text_poke_area)))
                     ^~~~~~~~~~~~~~~~~~~~~~~~~~
./include/linux/compiler.h:341:42: note: in definition of macro =A1__READ=
_ONCE=A2
   __read_once_size(&(x), __u.__c, sizeof(x));  \
                                          ^
./include/asm-generic/percpu.h:123:10: note: in expansion of macro =A1REA=
D_ONCE=A2
  __ret =3D READ_ONCE(*raw_cpu_ptr(&(pcp)));   \
          ^~~~~~~~~
./include/linux/percpu-defs.h:250:47: note: in expansion of macro =A1VERI=
FY_PERCPU_PTR=A2
 #define per_cpu_ptr(ptr, cpu) ({ (void)(cpu); VERIFY_PERCPU_PTR(ptr); })
                                               ^~~~~~~~~~~~~~~~~
./include/linux/percpu-defs.h:251:26: note: in expansion of macro =A1per_=
cpu_ptr=A2
 #define raw_cpu_ptr(ptr) per_cpu_ptr(ptr, 0)
                          ^~~~~~~~~~~
./include/asm-generic/percpu.h:123:21: note: in expansion of macro =A1raw=
_cpu_ptr=A2
  __ret =3D READ_ONCE(*raw_cpu_ptr(&(pcp)));   \
                     ^~~~~~~~~~~
./include/asm-generic/percpu.h:142:11: note: in expansion of macro =A1__t=
his_cpu_generic_read_nopreempt=A2
   __ret =3D __this_cpu_generic_read_nopreempt(pcp);  \
           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
./include/asm-generic/percpu.h:327:31: note: in expansion of macro =A1thi=
s_cpu_generic_read=A2
 #define this_cpu_read_2(pcp)  this_cpu_generic_read(pcp)
                               ^~~~~~~~~~~~~~~~~~~~~
./include/linux/percpu-defs.h:309:23: note: in expansion of macro =A1this=
_cpu_read_2=A2
  case 2: pscr_ret__ =3D stem##2(variable); break;   \
                       ^~~~
./include/linux/percpu-defs.h:494:29: note: in expansion of macro =A1__pc=
pu_size_call_return=A2
 #define this_cpu_read(pcp)  __pcpu_size_call_return(this_cpu_read_, pcp)
                             ^~~~~~~~~~~~~~~~~~~~~~~
arch/powerpc/lib/code-patching.c:150:7: note: in expansion of macro =A1th=
is_cpu_read=A2
  if (!this_cpu_read(*PTRRELOC(&text_poke_area)))
       ^~~~~~~~~~~~~
arch/powerpc/lib/code-patching.c:150:21: error: invalid type argument of =
unary =A1*=A2 (have =A1int=A2)
  if (!this_cpu_read(*PTRRELOC(&text_poke_area)))
                     ^~~~~~~~~~~~~~~~~~~~~~~~~~
./include/linux/compiler.h:343:30: note: in definition of macro =A1__READ=
_ONCE=A2
   __read_once_size_nocheck(&(x), __u.__c, sizeof(x)); \
                              ^
./include/asm-generic/percpu.h:123:10: note: in expansion of macro =A1REA=
D_ONCE=A2
  __ret =3D READ_ONCE(*raw_cpu_ptr(&(pcp)));   \
          ^~~~~~~~~
./include/linux/percpu-defs.h:246:2: note: in expansion of macro =A1__ver=
ify_pcpu_ptr=A2
  __verify_pcpu_ptr(__p);      \
  ^~~~~~~~~~~~~~~~~
./include/linux/percpu-defs.h:250:47: note: in expansion of macro =A1VERI=
FY_PERCPU_PTR=A2
 #define per_cpu_ptr(ptr, cpu) ({ (void)(cpu); VERIFY_PERCPU_PTR(ptr); })
                                               ^~~~~~~~~~~~~~~~~
./include/linux/percpu-defs.h:251:26: note: in expansion of macro =A1per_=
cpu_ptr=A2
 #define raw_cpu_ptr(ptr) per_cpu_ptr(ptr, 0)
                          ^~~~~~~~~~~
./include/asm-generic/percpu.h:123:21: note: in expansion of macro =A1raw=
_cpu_ptr=A2
  __ret =3D READ_ONCE(*raw_cpu_ptr(&(pcp)));   \
                     ^~~~~~~~~~~
./include/asm-generic/percpu.h:142:11: note: in expansion of macro =A1__t=
his_cpu_generic_read_nopreempt=A2
   __ret =3D __this_cpu_generic_read_nopreempt(pcp);  \
           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
./include/asm-generic/percpu.h:327:31: note: in expansion of macro =A1thi=
s_cpu_generic_read=A2
 #define this_cpu_read_2(pcp)  this_cpu_generic_read(pcp)
                               ^~~~~~~~~~~~~~~~~~~~~
./include/linux/percpu-defs.h:309:23: note: in expansion of macro =A1this=
_cpu_read_2=A2
  case 2: pscr_ret__ =3D stem##2(variable); break;   \
                       ^~~~
./include/linux/percpu-defs.h:494:29: note: in expansion of macro =A1__pc=
pu_size_call_return=A2
 #define this_cpu_read(pcp)  __pcpu_size_call_return(this_cpu_read_, pcp)
                             ^~~~~~~~~~~~~~~~~~~~~~~
arch/powerpc/lib/code-patching.c:150:7: note: in expansion of macro =A1th=
is_cpu_read=A2
  if (!this_cpu_read(*PTRRELOC(&text_poke_area)))
       ^~~~~~~~~~~~~
arch/powerpc/lib/code-patching.c:150:21: error: invalid type argument of =
unary =A1*=A2 (have =A1int=A2)
  if (!this_cpu_read(*PTRRELOC(&text_poke_area)))
                     ^~~~~~~~~~~~~~~~~~~~~~~~~~
./include/linux/compiler.h:343:30: note: in definition of macro =A1__READ=
_ONCE=A2
   __read_once_size_nocheck(&(x), __u.__c, sizeof(x)); \
                              ^
./include/asm-generic/percpu.h:123:10: note: in expansion of macro =A1REA=
D_ONCE=A2
  __ret =3D READ_ONCE(*raw_cpu_ptr(&(pcp)));   \
          ^~~~~~~~~
./include/linux/percpu-defs.h:250:47: note: in expansion of macro =A1VERI=
FY_PERCPU_PTR=A2
 #define per_cpu_ptr(ptr, cpu) ({ (void)(cpu); VERIFY_PERCPU_PTR(ptr); })
                                               ^~~~~~~~~~~~~~~~~
./include/linux/percpu-defs.h:251:26: note: in expansion of macro =A1per_=
cpu_ptr=A2
 #define raw_cpu_ptr(ptr) per_cpu_ptr(ptr, 0)
                          ^~~~~~~~~~~
./include/asm-generic/percpu.h:123:21: note: in expansion of macro =A1raw=
_cpu_ptr=A2
  __ret =3D READ_ONCE(*raw_cpu_ptr(&(pcp)));   \
                     ^~~~~~~~~~~
./include/asm-generic/percpu.h:142:11: note: in expansion of macro =A1__t=
his_cpu_generic_read_nopreempt=A2
   __ret =3D __this_cpu_generic_read_nopreempt(pcp);  \
           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
./include/asm-generic/percpu.h:327:31: note: in expansion of macro =A1thi=
s_cpu_generic_read=A2
 #define this_cpu_read_2(pcp)  this_cpu_generic_read(pcp)
                               ^~~~~~~~~~~~~~~~~~~~~
./include/linux/percpu-defs.h:309:23: note: in expansion of macro =A1this=
_cpu_read_2=A2
  case 2: pscr_ret__ =3D stem##2(variable); break;   \
                       ^~~~
./include/linux/percpu-defs.h:494:29: note: in expansion of macro =A1__pc=
pu_size_call_return=A2
 #define this_cpu_read(pcp)  __pcpu_size_call_return(this_cpu_read_, pcp)
                             ^~~~~~~~~~~~~~~~~~~~~~~
arch/powerpc/lib/code-patching.c:150:7: note: in expansion of macro =A1th=
is_cpu_read=A2
  if (!this_cpu_read(*PTRRELOC(&text_poke_area)))
       ^~~~~~~~~~~~~
arch/powerpc/lib/code-patching.c:150:21: error: invalid type argument of =
unary =A1*=A2 (have =A1int=A2)
  if (!this_cpu_read(*PTRRELOC(&text_poke_area)))
                     ^~~~~~~~~~~~~~~~~~~~~~~~~~
./include/linux/compiler.h:343:30: note: in definition of macro =A1__READ=
_ONCE=A2
   __read_once_size_nocheck(&(x), __u.__c, sizeof(x)); \
                              ^
./include/asm-generic/percpu.h:123:10: note: in expansion of macro =A1REA=
D_ONCE=A2
  __ret =3D READ_ONCE(*raw_cpu_ptr(&(pcp)));   \
          ^~~~~~~~~
./include/linux/percpu-defs.h:250:47: note: in expansion of macro =A1VERI=
FY_PERCPU_PTR=A2
 #define per_cpu_ptr(ptr, cpu) ({ (void)(cpu); VERIFY_PERCPU_PTR(ptr); })
                                               ^~~~~~~~~~~~~~~~~
./include/linux/percpu-defs.h:251:26: note: in expansion of macro =A1per_=
cpu_ptr=A2
 #define raw_cpu_ptr(ptr) per_cpu_ptr(ptr, 0)
                          ^~~~~~~~~~~
./include/asm-generic/percpu.h:123:21: note: in expansion of macro =A1raw=
_cpu_ptr=A2
  __ret =3D READ_ONCE(*raw_cpu_ptr(&(pcp)));   \
                     ^~~~~~~~~~~
./include/asm-generic/percpu.h:142:11: note: in expansion of macro =A1__t=
his_cpu_generic_read_nopreempt=A2
   __ret =3D __this_cpu_generic_read_nopreempt(pcp);  \
           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
./include/asm-generic/percpu.h:327:31: note: in expansion of macro =A1thi=
s_cpu_generic_read=A2
 #define this_cpu_read_2(pcp)  this_cpu_generic_read(pcp)
                               ^~~~~~~~~~~~~~~~~~~~~
./include/linux/percpu-defs.h:309:23: note: in expansion of macro =A1this=
_cpu_read_2=A2
  case 2: pscr_ret__ =3D stem##2(variable); break;   \
                       ^~~~
./include/linux/percpu-defs.h:494:29: note: in expansion of macro =A1__pc=
pu_size_call_return=A2
 #define this_cpu_read(pcp)  __pcpu_size_call_return(this_cpu_read_, pcp)
                             ^~~~~~~~~~~~~~~~~~~~~~~
arch/powerpc/lib/code-patching.c:150:7: note: in expansion of macro =A1th=
is_cpu_read=A2
  if (!this_cpu_read(*PTRRELOC(&text_poke_area)))
       ^~~~~~~~~~~~~
arch/powerpc/lib/code-patching.c:150:21: error: invalid type argument of =
unary =A1*=A2 (have =A1int=A2)
  if (!this_cpu_read(*PTRRELOC(&text_poke_area)))
                     ^~~~~~~~~~~~~~~~~~~~~~~~~~
./include/linux/compiler.h:343:50: note: in definition of macro =A1__READ=
_ONCE=A2
   __read_once_size_nocheck(&(x), __u.__c, sizeof(x)); \
                                                  ^
./include/asm-generic/percpu.h:123:10: note: in expansion of macro =A1REA=
D_ONCE=A2
  __ret =3D READ_ONCE(*raw_cpu_ptr(&(pcp)));   \
          ^~~~~~~~~
./include/linux/percpu-defs.h:246:2: note: in expansion of macro =A1__ver=
ify_pcpu_ptr=A2
  __verify_pcpu_ptr(__p);      \
  ^~~~~~~~~~~~~~~~~
./include/linux/percpu-defs.h:250:47: note: in expansion of macro =A1VERI=
FY_PERCPU_PTR=A2
 #define per_cpu_ptr(ptr, cpu) ({ (void)(cpu); VERIFY_PERCPU_PTR(ptr); })
                                               ^~~~~~~~~~~~~~~~~
./include/linux/percpu-defs.h:251:26: note: in expansion of macro =A1per_=
cpu_ptr=A2
 #define raw_cpu_ptr(ptr) per_cpu_ptr(ptr, 0)
                          ^~~~~~~~~~~
./include/asm-generic/percpu.h:123:21: note: in expansion of macro =A1raw=
_cpu_ptr=A2
  __ret =3D READ_ONCE(*raw_cpu_ptr(&(pcp)));   \
                     ^~~~~~~~~~~
./include/asm-generic/percpu.h:142:11: note: in expansion of macro =A1__t=
his_cpu_generic_read_nopreempt=A2
   __ret =3D __this_cpu_generic_read_nopreempt(pcp);  \
           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
./include/asm-generic/percpu.h:327:31: note: in expansion of macro =A1thi=
s_cpu_generic_read=A2
 #define this_cpu_read_2(pcp)  this_cpu_generic_read(pcp)
                               ^~~~~~~~~~~~~~~~~~~~~
./include/linux/percpu-defs.h:309:23: note: in expansion of macro =A1this=
_cpu_read_2=A2
  case 2: pscr_ret__ =3D stem##2(variable); break;   \
                       ^~~~
./include/linux/percpu-defs.h:494:29: note: in expansion of macro =A1__pc=
pu_size_call_return=A2
 #define this_cpu_read(pcp)  __pcpu_size_call_return(this_cpu_read_, pcp)
                             ^~~~~~~~~~~~~~~~~~~~~~~
arch/powerpc/lib/code-patching.c:150:7: note: in expansion of macro =A1th=
is_cpu_read=A2
  if (!this_cpu_read(*PTRRELOC(&text_poke_area)))
       ^~~~~~~~~~~~~
arch/powerpc/lib/code-patching.c:150:21: error: invalid type argument of =
unary =A1*=A2 (have =A1int=A2)
  if (!this_cpu_read(*PTRRELOC(&text_poke_area)))
                     ^~~~~~~~~~~~~~~~~~~~~~~~~~
./include/linux/compiler.h:343:50: note: in definition of macro =A1__READ=
_ONCE=A2
   __read_once_size_nocheck(&(x), __u.__c, sizeof(x)); \
                                                  ^
./include/asm-generic/percpu.h:123:10: note: in expansion of macro =A1REA=
D_ONCE=A2
  __ret =3D READ_ONCE(*raw_cpu_ptr(&(pcp)));   \
          ^~~~~~~~~
./include/linux/percpu-defs.h:250:47: note: in expansion of macro =A1VERI=
FY_PERCPU_PTR=A2
 #define per_cpu_ptr(ptr, cpu) ({ (void)(cpu); VERIFY_PERCPU_PTR(ptr); })
                                               ^~~~~~~~~~~~~~~~~
./include/linux/percpu-defs.h:251:26: note: in expansion of macro =A1per_=
cpu_ptr=A2
 #define raw_cpu_ptr(ptr) per_cpu_ptr(ptr, 0)
                          ^~~~~~~~~~~
./include/asm-generic/percpu.h:123:21: note: in expansion of macro =A1raw=
_cpu_ptr=A2
  __ret =3D READ_ONCE(*raw_cpu_ptr(&(pcp)));   \
                     ^~~~~~~~~~~
./include/asm-generic/percpu.h:142:11: note: in expansion of macro =A1__t=
his_cpu_generic_read_nopreempt=A2
   __ret =3D __this_cpu_generic_read_nopreempt(pcp);  \
           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
./include/asm-generic/percpu.h:327:31: note: in expansion of macro =A1thi=
s_cpu_generic_read=A2
 #define this_cpu_read_2(pcp)  this_cpu_generic_read(pcp)
                               ^~~~~~~~~~~~~~~~~~~~~
./include/linux/percpu-defs.h:309:23: note: in expansion of macro =A1this=
_cpu_read_2=A2
  case 2: pscr_ret__ =3D stem##2(variable); break;   \
                       ^~~~
./include/linux/percpu-defs.h:494:29: note: in expansion of macro =A1__pc=
pu_size_call_return=A2
 #define this_cpu_read(pcp)  __pcpu_size_call_return(this_cpu_read_, pcp)
                             ^~~~~~~~~~~~~~~~~~~~~~~
arch/powerpc/lib/code-patching.c:150:7: note: in expansion of macro =A1th=
is_cpu_read=A2
  if (!this_cpu_read(*PTRRELOC(&text_poke_area)))
       ^~~~~~~~~~~~~
arch/powerpc/lib/code-patching.c:150:21: error: invalid type argument of =
unary =A1*=A2 (have =A1int=A2)
  if (!this_cpu_read(*PTRRELOC(&text_poke_area)))
                     ^~~~~~~~~~~~~~~~~~~~~~~~~~
./include/linux/compiler.h:343:50: note: in definition of macro =A1__READ=
_ONCE=A2
   __read_once_size_nocheck(&(x), __u.__c, sizeof(x)); \
                                                  ^
./include/asm-generic/percpu.h:123:10: note: in expansion of macro =A1REA=
D_ONCE=A2
  __ret =3D READ_ONCE(*raw_cpu_ptr(&(pcp)));   \
          ^~~~~~~~~
./include/linux/percpu-defs.h:250:47: note: in expansion of macro =A1VERI=
FY_PERCPU_PTR=A2
 #define per_cpu_ptr(ptr, cpu) ({ (void)(cpu); VERIFY_PERCPU_PTR(ptr); })
                                               ^~~~~~~~~~~~~~~~~
./include/linux/percpu-defs.h:251:26: note: in expansion of macro =A1per_=
cpu_ptr=A2
 #define raw_cpu_ptr(ptr) per_cpu_ptr(ptr, 0)
                          ^~~~~~~~~~~
./include/asm-generic/percpu.h:123:21: note: in expansion of macro =A1raw=
_cpu_ptr=A2
  __ret =3D READ_ONCE(*raw_cpu_ptr(&(pcp)));   \
                     ^~~~~~~~~~~
./include/asm-generic/percpu.h:142:11: note: in expansion of macro =A1__t=
his_cpu_generic_read_nopreempt=A2
   __ret =3D __this_cpu_generic_read_nopreempt(pcp);  \
           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
./include/asm-generic/percpu.h:327:31: note: in expansion of macro =A1thi=
s_cpu_generic_read=A2
 #define this_cpu_read_2(pcp)  this_cpu_generic_read(pcp)
                               ^~~~~~~~~~~~~~~~~~~~~
./include/linux/percpu-defs.h:309:23: note: in expansion of macro =A1this=
_cpu_read_2=A2
  case 2: pscr_ret__ =3D stem##2(variable); break;   \
                       ^~~~
./include/linux/percpu-defs.h:494:29: note: in expansion of macro =A1__pc=
pu_size_call_return=A2
 #define this_cpu_read(pcp)  __pcpu_size_call_return(this_cpu_read_, pcp)
                             ^~~~~~~~~~~~~~~~~~~~~~~
arch/powerpc/lib/code-patching.c:150:7: note: in expansion of macro =A1th=
is_cpu_read=A2
  if (!this_cpu_read(*PTRRELOC(&text_poke_area)))
       ^~~~~~~~~~~~~
In file included from ./arch/powerpc/include/asm/percpu.h:20:0,
                 from ./include/linux/percpu.h:13,
                 from ./include/linux/kprobes.h:38,
                 from arch/powerpc/lib/code-patching.c:11:
arch/powerpc/lib/code-patching.c:150:21: error: invalid type argument of =
unary =A1*=A2 (have =A1int=A2)
  if (!this_cpu_read(*PTRRELOC(&text_poke_area)))
                     ^~~~~~~~~~~~~~~~~~~~~~~~~~
./include/asm-generic/percpu.h:130:9: note: in definition of macro =A1__t=
his_cpu_generic_read_noirq=A2
  typeof(pcp) __ret;      \
         ^~~
./include/asm-generic/percpu.h:327:31: note: in expansion of macro =A1thi=
s_cpu_generic_read=A2
 #define this_cpu_read_2(pcp)  this_cpu_generic_read(pcp)
                               ^~~~~~~~~~~~~~~~~~~~~
./include/linux/percpu-defs.h:309:23: note: in expansion of macro =A1this=
_cpu_read_2=A2
  case 2: pscr_ret__ =3D stem##2(variable); break;   \
                       ^~~~
./include/linux/percpu-defs.h:494:29: note: in expansion of macro =A1__pc=
pu_size_call_return=A2
 #define this_cpu_read(pcp)  __pcpu_size_call_return(this_cpu_read_, pcp)
                             ^~~~~~~~~~~~~~~~~~~~~~~
arch/powerpc/lib/code-patching.c:150:7: note: in expansion of macro =A1th=
is_cpu_read=A2
  if (!this_cpu_read(*PTRRELOC(&text_poke_area)))
       ^~~~~~~~~~~~~
In file included from ./include/asm-generic/percpu.h:7:0,
                 from ./arch/powerpc/include/asm/percpu.h:20,
                 from ./include/linux/percpu.h:13,
                 from ./include/linux/kprobes.h:38,
                 from arch/powerpc/lib/code-patching.c:11:
arch/powerpc/lib/code-patching.c:150:21: error: invalid type argument of =
unary =A1*=A2 (have =A1int=A2)
  if (!this_cpu_read(*PTRRELOC(&text_poke_area)))
                     ^~~~~~~~~~~~~~~~~~~~~~~~~~
./include/linux/percpu-defs.h:206:47: note: in definition of macro =A1__v=
erify_pcpu_ptr=A2
  const void __percpu *__vpp_verify =3D (typeof((ptr) + 0))NULL; \
                                               ^~~
./include/linux/percpu-defs.h:250:47: note: in expansion of macro =A1VERI=
FY_PERCPU_PTR=A2
 #define per_cpu_ptr(ptr, cpu) ({ (void)(cpu); VERIFY_PERCPU_PTR(ptr); })
                                               ^~~~~~~~~~~~~~~~~
./include/linux/percpu-defs.h:251:26: note: in expansion of macro =A1per_=
cpu_ptr=A2
 #define raw_cpu_ptr(ptr) per_cpu_ptr(ptr, 0)
                          ^~~~~~~~~~~
./include/asm-generic/percpu.h:71:3: note: in expansion of macro =A1raw_c=
pu_ptr=A2
  *raw_cpu_ptr(&(pcp));      \
   ^~~~~~~~~~~
./include/asm-generic/percpu.h:133:10: note: in expansion of macro =A1raw=
_cpu_generic_read=A2
  __ret =3D raw_cpu_generic_read(pcp);    \
          ^~~~~~~~~~~~~~~~~~~~
./include/asm-generic/percpu.h:144:11: note: in expansion of macro =A1__t=
his_cpu_generic_read_noirq=A2
   __ret =3D __this_cpu_generic_read_noirq(pcp);  \
           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
./include/asm-generic/percpu.h:327:31: note: in expansion of macro =A1thi=
s_cpu_generic_read=A2
 #define this_cpu_read_2(pcp)  this_cpu_generic_read(pcp)
                               ^~~~~~~~~~~~~~~~~~~~~
./include/linux/percpu-defs.h:309:23: note: in expansion of macro =A1this=
_cpu_read_2=A2
  case 2: pscr_ret__ =3D stem##2(variable); break;   \
                       ^~~~
./include/linux/percpu-defs.h:494:29: note: in expansion of macro =A1__pc=
pu_size_call_return=A2
 #define this_cpu_read(pcp)  __pcpu_size_call_return(this_cpu_read_, pcp)
                             ^~~~~~~~~~~~~~~~~~~~~~~
arch/powerpc/lib/code-patching.c:150:7: note: in expansion of macro =A1th=
is_cpu_read=A2
  if (!this_cpu_read(*PTRRELOC(&text_poke_area)))
       ^~~~~~~~~~~~~
arch/powerpc/lib/code-patching.c:150:21: error: invalid type argument of =
unary =A1*=A2 (have =A1int=A2)
  if (!this_cpu_read(*PTRRELOC(&text_poke_area)))
                     ^~~~~~~~~~~~~~~~~~~~~~~~~~
./include/linux/percpu-defs.h:247:12: note: in definition of macro =A1VER=
IFY_PERCPU_PTR=A2
  (typeof(*(__p)) __kernel __force *)(__p);   \
            ^~~
./include/linux/percpu-defs.h:251:26: note: in expansion of macro =A1per_=
cpu_ptr=A2
 #define raw_cpu_ptr(ptr) per_cpu_ptr(ptr, 0)
                          ^~~~~~~~~~~
./include/asm-generic/percpu.h:71:3: note: in expansion of macro =A1raw_c=
pu_ptr=A2
  *raw_cpu_ptr(&(pcp));      \
   ^~~~~~~~~~~
./include/asm-generic/percpu.h:133:10: note: in expansion of macro =A1raw=
_cpu_generic_read=A2
  __ret =3D raw_cpu_generic_read(pcp);    \
          ^~~~~~~~~~~~~~~~~~~~
./include/asm-generic/percpu.h:144:11: note: in expansion of macro =A1__t=
his_cpu_generic_read_noirq=A2
   __ret =3D __this_cpu_generic_read_noirq(pcp);  \
           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
./include/asm-generic/percpu.h:327:31: note: in expansion of macro =A1thi=
s_cpu_generic_read=A2
 #define this_cpu_read_2(pcp)  this_cpu_generic_read(pcp)
                               ^~~~~~~~~~~~~~~~~~~~~
./include/linux/percpu-defs.h:309:23: note: in expansion of macro =A1this=
_cpu_read_2=A2
  case 2: pscr_ret__ =3D stem##2(variable); break;   \
                       ^~~~
./include/linux/percpu-defs.h:494:29: note: in expansion of macro =A1__pc=
pu_size_call_return=A2
 #define this_cpu_read(pcp)  __pcpu_size_call_return(this_cpu_read_, pcp)
                             ^~~~~~~~~~~~~~~~~~~~~~~
arch/powerpc/lib/code-patching.c:150:7: note: in expansion of macro =A1th=
is_cpu_read=A2
  if (!this_cpu_read(*PTRRELOC(&text_poke_area)))
       ^~~~~~~~~~~~~
arch/powerpc/lib/code-patching.c:150:21: error: invalid type argument of =
unary =A1*=A2 (have =A1int=A2)
  if (!this_cpu_read(*PTRRELOC(&text_poke_area)))
                     ^~~~~~~~~~~~~~~~~~~~~~~~~~
./include/linux/percpu-defs.h:247:38: note: in definition of macro =A1VER=
IFY_PERCPU_PTR=A2
  (typeof(*(__p)) __kernel __force *)(__p);   \
                                      ^~~
./include/linux/percpu-defs.h:251:26: note: in expansion of macro =A1per_=
cpu_ptr=A2
 #define raw_cpu_ptr(ptr) per_cpu_ptr(ptr, 0)
                          ^~~~~~~~~~~
./include/asm-generic/percpu.h:71:3: note: in expansion of macro =A1raw_c=
pu_ptr=A2
  *raw_cpu_ptr(&(pcp));      \
   ^~~~~~~~~~~
./include/asm-generic/percpu.h:133:10: note: in expansion of macro =A1raw=
_cpu_generic_read=A2
  __ret =3D raw_cpu_generic_read(pcp);    \
          ^~~~~~~~~~~~~~~~~~~~
./include/asm-generic/percpu.h:144:11: note: in expansion of macro =A1__t=
his_cpu_generic_read_noirq=A2
   __ret =3D __this_cpu_generic_read_noirq(pcp);  \
           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
./include/asm-generic/percpu.h:327:31: note: in expansion of macro =A1thi=
s_cpu_generic_read=A2
 #define this_cpu_read_2(pcp)  this_cpu_generic_read(pcp)
                               ^~~~~~~~~~~~~~~~~~~~~
./include/linux/percpu-defs.h:309:23: note: in expansion of macro =A1this=
_cpu_read_2=A2
  case 2: pscr_ret__ =3D stem##2(variable); break;   \
                       ^~~~
./include/linux/percpu-defs.h:494:29: note: in expansion of macro =A1__pc=
pu_size_call_return=A2
 #define this_cpu_read(pcp)  __pcpu_size_call_return(this_cpu_read_, pcp)
                             ^~~~~~~~~~~~~~~~~~~~~~~
arch/powerpc/lib/code-patching.c:150:7: note: in expansion of macro =A1th=
is_cpu_read=A2
  if (!this_cpu_read(*PTRRELOC(&text_poke_area)))
       ^~~~~~~~~~~~~
In file included from ./arch/powerpc/include/asm/percpu.h:20:0,
                 from ./include/linux/percpu.h:13,
                 from ./include/linux/kprobes.h:38,
                 from arch/powerpc/lib/code-patching.c:11:
arch/powerpc/lib/code-patching.c:150:21: error: invalid type argument of =
unary =A1*=A2 (have =A1int=A2)
  if (!this_cpu_read(*PTRRELOC(&text_poke_area)))
                     ^~~~~~~~~~~~~~~~~~~~~~~~~~
./include/asm-generic/percpu.h:140:9: note: in definition of macro =A1thi=
s_cpu_generic_read=A2
  typeof(pcp) __ret;      \
         ^~~
./include/linux/percpu-defs.h:310:23: note: in expansion of macro =A1this=
_cpu_read_4=A2
  case 4: pscr_ret__ =3D stem##4(variable); break;   \
                       ^~~~
./include/linux/percpu-defs.h:494:29: note: in expansion of macro =A1__pc=
pu_size_call_return=A2
 #define this_cpu_read(pcp)  __pcpu_size_call_return(this_cpu_read_, pcp)
                             ^~~~~~~~~~~~~~~~~~~~~~~
arch/powerpc/lib/code-patching.c:150:7: note: in expansion of macro =A1th=
is_cpu_read=A2
  if (!this_cpu_read(*PTRRELOC(&text_poke_area)))
       ^~~~~~~~~~~~~
In file included from ./include/linux/linkage.h:5:0,
                 from ./include/linux/kernel.h:7,
                 from arch/powerpc/lib/code-patching.c:10:
arch/powerpc/lib/code-patching.c:150:21: error: invalid type argument of =
unary =A1*=A2 (have =A1int=A2)
  if (!this_cpu_read(*PTRRELOC(&text_poke_area)))
                     ^~~~~~~~~~~~~~~~~~~~~~~~~~
./include/linux/compiler.h:524:35: note: in definition of macro =A1__nati=
ve_word=A2
 # define __native_word(t) (sizeof(t) =3D=3D sizeof(char) || sizeof(t) =3D=
=3D sizeof(short) || sizeof(t) =3D=3D sizeof(int) || sizeof(t) =3D=3D siz=
eof(long))
                                   ^
./include/asm-generic/percpu.h:330:31: note: in expansion of macro =A1thi=
s_cpu_generic_read=A2
 #define this_cpu_read_4(pcp)  this_cpu_generic_read(pcp)
                               ^~~~~~~~~~~~~~~~~~~~~
./include/linux/percpu-defs.h:310:23: note: in expansion of macro =A1this=
_cpu_read_4=A2
  case 4: pscr_ret__ =3D stem##4(variable); break;   \
                       ^~~~
./include/linux/percpu-defs.h:494:29: note: in expansion of macro =A1__pc=
pu_size_call_return=A2
 #define this_cpu_read(pcp)  __pcpu_size_call_return(this_cpu_read_, pcp)
                             ^~~~~~~~~~~~~~~~~~~~~~~
arch/powerpc/lib/code-patching.c:150:7: note: in expansion of macro =A1th=
is_cpu_read=A2
  if (!this_cpu_read(*PTRRELOC(&text_poke_area)))
       ^~~~~~~~~~~~~
arch/powerpc/lib/code-patching.c:150:21: error: invalid type argument of =
unary =A1*=A2 (have =A1int=A2)
  if (!this_cpu_read(*PTRRELOC(&text_poke_area)))
                     ^~~~~~~~~~~~~~~~~~~~~~~~~~
./include/linux/compiler.h:524:64: note: in definition of macro =A1__nati=
ve_word=A2
 # define __native_word(t) (sizeof(t) =3D=3D sizeof(char) || sizeof(t) =3D=
=3D sizeof(short) || sizeof(t) =3D=3D sizeof(int) || sizeof(t) =3D=3D siz=
eof(long))
                                                                ^
./include/asm-generic/percpu.h:330:31: note: in expansion of macro =A1thi=
s_cpu_generic_read=A2
 #define this_cpu_read_4(pcp)  this_cpu_generic_read(pcp)
                               ^~~~~~~~~~~~~~~~~~~~~
./include/linux/percpu-defs.h:310:23: note: in expansion of macro =A1this=
_cpu_read_4=A2
  case 4: pscr_ret__ =3D stem##4(variable); break;   \
                       ^~~~
./include/linux/percpu-defs.h:494:29: note: in expansion of macro =A1__pc=
pu_size_call_return=A2
 #define this_cpu_read(pcp)  __pcpu_size_call_return(this_cpu_read_, pcp)
                             ^~~~~~~~~~~~~~~~~~~~~~~
arch/powerpc/lib/code-patching.c:150:7: note: in expansion of macro =A1th=
is_cpu_read=A2
  if (!this_cpu_read(*PTRRELOC(&text_poke_area)))
       ^~~~~~~~~~~~~
arch/powerpc/lib/code-patching.c:150:21: error: invalid type argument of =
unary =A1*=A2 (have =A1int=A2)
  if (!this_cpu_read(*PTRRELOC(&text_poke_area)))
                     ^~~~~~~~~~~~~~~~~~~~~~~~~~
./include/linux/compiler.h:524:94: note: in definition of macro =A1__nati=
ve_word=A2
 # define __native_word(t) (sizeof(t) =3D=3D sizeof(char) || sizeof(t) =3D=
=3D sizeof(short) || sizeof(t) =3D=3D sizeof(int) || sizeof(t) =3D=3D siz=
eof(long))
                                                                         =
                     ^
./include/asm-generic/percpu.h:330:31: note: in expansion of macro =A1thi=
s_cpu_generic_read=A2
 #define this_cpu_read_4(pcp)  this_cpu_generic_read(pcp)
                               ^~~~~~~~~~~~~~~~~~~~~
./include/linux/percpu-defs.h:310:23: note: in expansion of macro =A1this=
_cpu_read_4=A2
  case 4: pscr_ret__ =3D stem##4(variable); break;   \
                       ^~~~
./include/linux/percpu-defs.h:494:29: note: in expansion of macro =A1__pc=
pu_size_call_return=A2
 #define this_cpu_read(pcp)  __pcpu_size_call_return(this_cpu_read_, pcp)
                             ^~~~~~~~~~~~~~~~~~~~~~~
arch/powerpc/lib/code-patching.c:150:7: note: in expansion of macro =A1th=
is_cpu_read=A2
  if (!this_cpu_read(*PTRRELOC(&text_poke_area)))
       ^~~~~~~~~~~~~
arch/powerpc/lib/code-patching.c:150:21: error: invalid type argument of =
unary =A1*=A2 (have =A1int=A2)
  if (!this_cpu_read(*PTRRELOC(&text_poke_area)))
                     ^~~~~~~~~~~~~~~~~~~~~~~~~~
./include/linux/compiler.h:524:122: note: in definition of macro =A1__nat=
ive_word=A2
 # define __native_word(t) (sizeof(t) =3D=3D sizeof(char) || sizeof(t) =3D=
=3D sizeof(short) || sizeof(t) =3D=3D sizeof(int) || sizeof(t) =3D=3D siz=
eof(long))
                                                                         =
                                                 ^
./include/asm-generic/percpu.h:330:31: note: in expansion of macro =A1thi=
s_cpu_generic_read=A2
 #define this_cpu_read_4(pcp)  this_cpu_generic_read(pcp)
                               ^~~~~~~~~~~~~~~~~~~~~
./include/linux/percpu-defs.h:310:23: note: in expansion of macro =A1this=
_cpu_read_4=A2
  case 4: pscr_ret__ =3D stem##4(variable); break;   \
                       ^~~~
./include/linux/percpu-defs.h:494:29: note: in expansion of macro =A1__pc=
pu_size_call_return=A2
 #define this_cpu_read(pcp)  __pcpu_size_call_return(this_cpu_read_, pcp)
                             ^~~~~~~~~~~~~~~~~~~~~~~
arch/powerpc/lib/code-patching.c:150:7: note: in expansion of macro =A1th=
is_cpu_read=A2
  if (!this_cpu_read(*PTRRELOC(&text_poke_area)))
       ^~~~~~~~~~~~~
In file included from ./arch/powerpc/include/asm/percpu.h:20:0,
                 from ./include/linux/percpu.h:13,
                 from ./include/linux/kprobes.h:38,
                 from arch/powerpc/lib/code-patching.c:11:
arch/powerpc/lib/code-patching.c:150:21: error: invalid type argument of =
unary =A1*=A2 (have =A1int=A2)
  if (!this_cpu_read(*PTRRELOC(&text_poke_area)))
                     ^~~~~~~~~~~~~~~~~~~~~~~~~~
./include/asm-generic/percpu.h:121:9: note: in definition of macro =A1__t=
his_cpu_generic_read_nopreempt=A2
  typeof(pcp) __ret;      \
         ^~~
./include/asm-generic/percpu.h:330:31: note: in expansion of macro =A1thi=
s_cpu_generic_read=A2
 #define this_cpu_read_4(pcp)  this_cpu_generic_read(pcp)
                               ^~~~~~~~~~~~~~~~~~~~~
./include/linux/percpu-defs.h:310:23: note: in expansion of macro =A1this=
_cpu_read_4=A2
  case 4: pscr_ret__ =3D stem##4(variable); break;   \
                       ^~~~
./include/linux/percpu-defs.h:494:29: note: in expansion of macro =A1__pc=
pu_size_call_return=A2
 #define this_cpu_read(pcp)  __pcpu_size_call_return(this_cpu_read_, pcp)
                             ^~~~~~~~~~~~~~~~~~~~~~~
arch/powerpc/lib/code-patching.c:150:7: note: in expansion of macro =A1th=
is_cpu_read=A2
  if (!this_cpu_read(*PTRRELOC(&text_poke_area)))
       ^~~~~~~~~~~~~
In file included from ./include/linux/linkage.h:5:0,
                 from ./include/linux/kernel.h:7,
                 from arch/powerpc/lib/code-patching.c:10:
arch/powerpc/lib/code-patching.c:150:21: error: invalid type argument of =
unary =A1*=A2 (have =A1int=A2)
  if (!this_cpu_read(*PTRRELOC(&text_poke_area)))
                     ^~~~~~~~~~~~~~~~~~~~~~~~~~
./include/linux/compiler.h:339:17: note: in definition of macro =A1__READ=
_ONCE=A2
  union { typeof(x) __val; char __c[1]; } __u;   \
                 ^
./include/asm-generic/percpu.h:123:10: note: in expansion of macro =A1REA=
D_ONCE=A2
  __ret =3D READ_ONCE(*raw_cpu_ptr(&(pcp)));   \
          ^~~~~~~~~
./include/linux/percpu-defs.h:246:2: note: in expansion of macro =A1__ver=
ify_pcpu_ptr=A2
  __verify_pcpu_ptr(__p);      \
  ^~~~~~~~~~~~~~~~~
./include/linux/percpu-defs.h:250:47: note: in expansion of macro =A1VERI=
FY_PERCPU_PTR=A2
 #define per_cpu_ptr(ptr, cpu) ({ (void)(cpu); VERIFY_PERCPU_PTR(ptr); })
                                               ^~~~~~~~~~~~~~~~~
./include/linux/percpu-defs.h:251:26: note: in expansion of macro =A1per_=
cpu_ptr=A2
 #define raw_cpu_ptr(ptr) per_cpu_ptr(ptr, 0)
                          ^~~~~~~~~~~
./include/asm-generic/percpu.h:123:21: note: in expansion of macro =A1raw=
_cpu_ptr=A2
  __ret =3D READ_ONCE(*raw_cpu_ptr(&(pcp)));   \
                     ^~~~~~~~~~~
./include/asm-generic/percpu.h:142:11: note: in expansion of macro =A1__t=
his_cpu_generic_read_nopreempt=A2
   __ret =3D __this_cpu_generic_read_nopreempt(pcp);  \
           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
./include/asm-generic/percpu.h:330:31: note: in expansion of macro =A1thi=
s_cpu_generic_read=A2
 #define this_cpu_read_4(pcp)  this_cpu_generic_read(pcp)
                               ^~~~~~~~~~~~~~~~~~~~~
./include/linux/percpu-defs.h:310:23: note: in expansion of macro =A1this=
_cpu_read_4=A2
  case 4: pscr_ret__ =3D stem##4(variable); break;   \
                       ^~~~
./include/linux/percpu-defs.h:494:29: note: in expansion of macro =A1__pc=
pu_size_call_return=A2
 #define this_cpu_read(pcp)  __pcpu_size_call_return(this_cpu_read_, pcp)
                             ^~~~~~~~~~~~~~~~~~~~~~~
arch/powerpc/lib/code-patching.c:150:7: note: in expansion of macro =A1th=
is_cpu_read=A2
  if (!this_cpu_read(*PTRRELOC(&text_poke_area)))
       ^~~~~~~~~~~~~
arch/powerpc/lib/code-patching.c:150:21: error: invalid type argument of =
unary =A1*=A2 (have =A1int=A2)
  if (!this_cpu_read(*PTRRELOC(&text_poke_area)))
                     ^~~~~~~~~~~~~~~~~~~~~~~~~~
./include/linux/compiler.h:339:17: note: in definition of macro =A1__READ=
_ONCE=A2
  union { typeof(x) __val; char __c[1]; } __u;   \
                 ^
./include/asm-generic/percpu.h:123:10: note: in expansion of macro =A1REA=
D_ONCE=A2
  __ret =3D READ_ONCE(*raw_cpu_ptr(&(pcp)));   \
          ^~~~~~~~~
./include/linux/percpu-defs.h:250:47: note: in expansion of macro =A1VERI=
FY_PERCPU_PTR=A2
 #define per_cpu_ptr(ptr, cpu) ({ (void)(cpu); VERIFY_PERCPU_PTR(ptr); })
                                               ^~~~~~~~~~~~~~~~~
./include/linux/percpu-defs.h:251:26: note: in expansion of macro =A1per_=
cpu_ptr=A2
 #define raw_cpu_ptr(ptr) per_cpu_ptr(ptr, 0)
                          ^~~~~~~~~~~
./include/asm-generic/percpu.h:123:21: note: in expansion of macro =A1raw=
_cpu_ptr=A2
  __ret =3D READ_ONCE(*raw_cpu_ptr(&(pcp)));   \
                     ^~~~~~~~~~~
./include/asm-generic/percpu.h:142:11: note: in expansion of macro =A1__t=
his_cpu_generic_read_nopreempt=A2
   __ret =3D __this_cpu_generic_read_nopreempt(pcp);  \
           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
./include/asm-generic/percpu.h:330:31: note: in expansion of macro =A1thi=
s_cpu_generic_read=A2
 #define this_cpu_read_4(pcp)  this_cpu_generic_read(pcp)
                               ^~~~~~~~~~~~~~~~~~~~~
./include/linux/percpu-defs.h:310:23: note: in expansion of macro =A1this=
_cpu_read_4=A2
  case 4: pscr_ret__ =3D stem##4(variable); break;   \
                       ^~~~
./include/linux/percpu-defs.h:494:29: note: in expansion of macro =A1__pc=
pu_size_call_return=A2
 #define this_cpu_read(pcp)  __pcpu_size_call_return(this_cpu_read_, pcp)
                             ^~~~~~~~~~~~~~~~~~~~~~~
arch/powerpc/lib/code-patching.c:150:7: note: in expansion of macro =A1th=
is_cpu_read=A2
  if (!this_cpu_read(*PTRRELOC(&text_poke_area)))
       ^~~~~~~~~~~~~
arch/powerpc/lib/code-patching.c:150:21: error: invalid type argument of =
unary =A1*=A2 (have =A1int=A2)
  if (!this_cpu_read(*PTRRELOC(&text_poke_area)))
                     ^~~~~~~~~~~~~~~~~~~~~~~~~~
./include/linux/compiler.h:339:17: note: in definition of macro =A1__READ=
_ONCE=A2
  union { typeof(x) __val; char __c[1]; } __u;   \
                 ^
./include/asm-generic/percpu.h:123:10: note: in expansion of macro =A1REA=
D_ONCE=A2
  __ret =3D READ_ONCE(*raw_cpu_ptr(&(pcp)));   \
          ^~~~~~~~~
./include/linux/percpu-defs.h:250:47: note: in expansion of macro =A1VERI=
FY_PERCPU_PTR=A2
 #define per_cpu_ptr(ptr, cpu) ({ (void)(cpu); VERIFY_PERCPU_PTR(ptr); })
                                               ^~~~~~~~~~~~~~~~~
./include/linux/percpu-defs.h:251:26: note: in expansion of macro =A1per_=
cpu_ptr=A2
 #define raw_cpu_ptr(ptr) per_cpu_ptr(ptr, 0)
                          ^~~~~~~~~~~
./include/asm-generic/percpu.h:123:21: note: in expansion of macro =A1raw=
_cpu_ptr=A2
  __ret =3D READ_ONCE(*raw_cpu_ptr(&(pcp)));   \
                     ^~~~~~~~~~~
./include/asm-generic/percpu.h:142:11: note: in expansion of macro =A1__t=
his_cpu_generic_read_nopreempt=A2
   __ret =3D __this_cpu_generic_read_nopreempt(pcp);  \
           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
./include/asm-generic/percpu.h:330:31: note: in expansion of macro =A1thi=
s_cpu_generic_read=A2
 #define this_cpu_read_4(pcp)  this_cpu_generic_read(pcp)
                               ^~~~~~~~~~~~~~~~~~~~~
./include/linux/percpu-defs.h:310:23: note: in expansion of macro =A1this=
_cpu_read_4=A2
  case 4: pscr_ret__ =3D stem##4(variable); break;   \
                       ^~~~
./include/linux/percpu-defs.h:494:29: note: in expansion of macro =A1__pc=
pu_size_call_return=A2
 #define this_cpu_read(pcp)  __pcpu_size_call_return(this_cpu_read_, pcp)
                             ^~~~~~~~~~~~~~~~~~~~~~~
arch/powerpc/lib/code-patching.c:150:7: note: in expansion of macro =A1th=
is_cpu_read=A2
  if (!this_cpu_read(*PTRRELOC(&text_poke_area)))
       ^~~~~~~~~~~~~
arch/powerpc/lib/code-patching.c:150:21: error: invalid type argument of =
unary =A1*=A2 (have =A1int=A2)
  if (!this_cpu_read(*PTRRELOC(&text_poke_area)))
                     ^~~~~~~~~~~~~~~~~~~~~~~~~~
./include/linux/compiler.h:341:22: note: in definition of macro =A1__READ=
_ONCE=A2
   __read_once_size(&(x), __u.__c, sizeof(x));  \
                      ^
./include/asm-generic/percpu.h:123:10: note: in expansion of macro =A1REA=
D_ONCE=A2
  __ret =3D READ_ONCE(*raw_cpu_ptr(&(pcp)));   \
          ^~~~~~~~~
./include/linux/percpu-defs.h:246:2: note: in expansion of macro =A1__ver=
ify_pcpu_ptr=A2
  __verify_pcpu_ptr(__p);      \
  ^~~~~~~~~~~~~~~~~
./include/linux/percpu-defs.h:250:47: note: in expansion of macro =A1VERI=
FY_PERCPU_PTR=A2
 #define per_cpu_ptr(ptr, cpu) ({ (void)(cpu); VERIFY_PERCPU_PTR(ptr); })
                                               ^~~~~~~~~~~~~~~~~
./include/linux/percpu-defs.h:251:26: note: in expansion of macro =A1per_=
cpu_ptr=A2
 #define raw_cpu_ptr(ptr) per_cpu_ptr(ptr, 0)
                          ^~~~~~~~~~~
./include/asm-generic/percpu.h:123:21: note: in expansion of macro =A1raw=
_cpu_ptr=A2
  __ret =3D READ_ONCE(*raw_cpu_ptr(&(pcp)));   \
                     ^~~~~~~~~~~
./include/asm-generic/percpu.h:142:11: note: in expansion of macro =A1__t=
his_cpu_generic_read_nopreempt=A2
   __ret =3D __this_cpu_generic_read_nopreempt(pcp);  \
           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
./include/asm-generic/percpu.h:330:31: note: in expansion of macro =A1thi=
s_cpu_generic_read=A2
 #define this_cpu_read_4(pcp)  this_cpu_generic_read(pcp)
                               ^~~~~~~~~~~~~~~~~~~~~
./include/linux/percpu-defs.h:310:23: note: in expansion of macro =A1this=
_cpu_read_4=A2
  case 4: pscr_ret__ =3D stem##4(variable); break;   \
                       ^~~~
./include/linux/percpu-defs.h:494:29: note: in expansion of macro =A1__pc=
pu_size_call_return=A2
 #define this_cpu_read(pcp)  __pcpu_size_call_return(this_cpu_read_, pcp)
                             ^~~~~~~~~~~~~~~~~~~~~~~
arch/powerpc/lib/code-patching.c:150:7: note: in expansion of macro =A1th=
is_cpu_read=A2
  if (!this_cpu_read(*PTRRELOC(&text_poke_area)))
       ^~~~~~~~~~~~~
arch/powerpc/lib/code-patching.c:150:21: error: invalid type argument of =
unary =A1*=A2 (have =A1int=A2)
  if (!this_cpu_read(*PTRRELOC(&text_poke_area)))
                     ^~~~~~~~~~~~~~~~~~~~~~~~~~
./include/linux/compiler.h:341:22: note: in definition of macro =A1__READ=
_ONCE=A2
   __read_once_size(&(x), __u.__c, sizeof(x));  \
                      ^
./include/asm-generic/percpu.h:123:10: note: in expansion of macro =A1REA=
D_ONCE=A2
  __ret =3D READ_ONCE(*raw_cpu_ptr(&(pcp)));   \
          ^~~~~~~~~
./include/linux/percpu-defs.h:250:47: note: in expansion of macro =A1VERI=
FY_PERCPU_PTR=A2
 #define per_cpu_ptr(ptr, cpu) ({ (void)(cpu); VERIFY_PERCPU_PTR(ptr); })
                                               ^~~~~~~~~~~~~~~~~
./include/linux/percpu-defs.h:251:26: note: in expansion of macro =A1per_=
cpu_ptr=A2
 #define raw_cpu_ptr(ptr) per_cpu_ptr(ptr, 0)
                          ^~~~~~~~~~~
./include/asm-generic/percpu.h:123:21: note: in expansion of macro =A1raw=
_cpu_ptr=A2
  __ret =3D READ_ONCE(*raw_cpu_ptr(&(pcp)));   \
                     ^~~~~~~~~~~
./include/asm-generic/percpu.h:142:11: note: in expansion of macro =A1__t=
his_cpu_generic_read_nopreempt=A2
   __ret =3D __this_cpu_generic_read_nopreempt(pcp);  \
           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
./include/asm-generic/percpu.h:330:31: note: in expansion of macro =A1thi=
s_cpu_generic_read=A2
 #define this_cpu_read_4(pcp)  this_cpu_generic_read(pcp)
                               ^~~~~~~~~~~~~~~~~~~~~
./include/linux/percpu-defs.h:310:23: note: in expansion of macro =A1this=
_cpu_read_4=A2
  case 4: pscr_ret__ =3D stem##4(variable); break;   \
                       ^~~~
./include/linux/percpu-defs.h:494:29: note: in expansion of macro =A1__pc=
pu_size_call_return=A2
 #define this_cpu_read(pcp)  __pcpu_size_call_return(this_cpu_read_, pcp)
                             ^~~~~~~~~~~~~~~~~~~~~~~
arch/powerpc/lib/code-patching.c:150:7: note: in expansion of macro =A1th=
is_cpu_read=A2
  if (!this_cpu_read(*PTRRELOC(&text_poke_area)))
       ^~~~~~~~~~~~~
arch/powerpc/lib/code-patching.c:150:21: error: invalid type argument of =
unary =A1*=A2 (have =A1int=A2)
  if (!this_cpu_read(*PTRRELOC(&text_poke_area)))
                     ^~~~~~~~~~~~~~~~~~~~~~~~~~
./include/linux/compiler.h:341:22: note: in definition of macro =A1__READ=
_ONCE=A2
   __read_once_size(&(x), __u.__c, sizeof(x));  \
                      ^
./include/asm-generic/percpu.h:123:10: note: in expansion of macro =A1REA=
D_ONCE=A2
  __ret =3D READ_ONCE(*raw_cpu_ptr(&(pcp)));   \
          ^~~~~~~~~
./include/linux/percpu-defs.h:250:47: note: in expansion of macro =A1VERI=
FY_PERCPU_PTR=A2
 #define per_cpu_ptr(ptr, cpu) ({ (void)(cpu); VERIFY_PERCPU_PTR(ptr); })
                                               ^~~~~~~~~~~~~~~~~
./include/linux/percpu-defs.h:251:26: note: in expansion of macro =A1per_=
cpu_ptr=A2
 #define raw_cpu_ptr(ptr) per_cpu_ptr(ptr, 0)
                          ^~~~~~~~~~~
./include/asm-generic/percpu.h:123:21: note: in expansion of macro =A1raw=
_cpu_ptr=A2
  __ret =3D READ_ONCE(*raw_cpu_ptr(&(pcp)));   \
                     ^~~~~~~~~~~
./include/asm-generic/percpu.h:142:11: note: in expansion of macro =A1__t=
his_cpu_generic_read_nopreempt=A2
   __ret =3D __this_cpu_generic_read_nopreempt(pcp);  \
           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
./include/asm-generic/percpu.h:330:31: note: in expansion of macro =A1thi=
s_cpu_generic_read=A2
 #define this_cpu_read_4(pcp)  this_cpu_generic_read(pcp)
                               ^~~~~~~~~~~~~~~~~~~~~
./include/linux/percpu-defs.h:310:23: note: in expansion of macro =A1this=
_cpu_read_4=A2
  case 4: pscr_ret__ =3D stem##4(variable); break;   \
                       ^~~~
./include/linux/percpu-defs.h:494:29: note: in expansion of macro =A1__pc=
pu_size_call_return=A2
 #define this_cpu_read(pcp)  __pcpu_size_call_return(this_cpu_read_, pcp)
                             ^~~~~~~~~~~~~~~~~~~~~~~
arch/powerpc/lib/code-patching.c:150:7: note: in expansion of macro =A1th=
is_cpu_read=A2
  if (!this_cpu_read(*PTRRELOC(&text_poke_area)))
       ^~~~~~~~~~~~~
arch/powerpc/lib/code-patching.c:150:21: error: invalid type argument of =
unary =A1*=A2 (have =A1int=A2)
  if (!this_cpu_read(*PTRRELOC(&text_poke_area)))
                     ^~~~~~~~~~~~~~~~~~~~~~~~~~
./include/linux/compiler.h:341:42: note: in definition of macro =A1__READ=
_ONCE=A2
   __read_once_size(&(x), __u.__c, sizeof(x));  \
                                          ^
./include/asm-generic/percpu.h:123:10: note: in expansion of macro =A1REA=
D_ONCE=A2
  __ret =3D READ_ONCE(*raw_cpu_ptr(&(pcp)));   \
          ^~~~~~~~~
./include/linux/percpu-defs.h:246:2: note: in expansion of macro =A1__ver=
ify_pcpu_ptr=A2
  __verify_pcpu_ptr(__p);      \
  ^~~~~~~~~~~~~~~~~
./include/linux/percpu-defs.h:250:47: note: in expansion of macro =A1VERI=
FY_PERCPU_PTR=A2
 #define per_cpu_ptr(ptr, cpu) ({ (void)(cpu); VERIFY_PERCPU_PTR(ptr); })
                                               ^~~~~~~~~~~~~~~~~
./include/linux/percpu-defs.h:251:26: note: in expansion of macro =A1per_=
cpu_ptr=A2
 #define raw_cpu_ptr(ptr) per_cpu_ptr(ptr, 0)
                          ^~~~~~~~~~~
./include/asm-generic/percpu.h:123:21: note: in expansion of macro =A1raw=
_cpu_ptr=A2
  __ret =3D READ_ONCE(*raw_cpu_ptr(&(pcp)));   \
                     ^~~~~~~~~~~
./include/asm-generic/percpu.h:142:11: note: in expansion of macro =A1__t=
his_cpu_generic_read_nopreempt=A2
   __ret =3D __this_cpu_generic_read_nopreempt(pcp);  \
           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
./include/asm-generic/percpu.h:330:31: note: in expansion of macro =A1thi=
s_cpu_generic_read=A2
 #define this_cpu_read_4(pcp)  this_cpu_generic_read(pcp)
                               ^~~~~~~~~~~~~~~~~~~~~
./include/linux/percpu-defs.h:310:23: note: in expansion of macro =A1this=
_cpu_read_4=A2
  case 4: pscr_ret__ =3D stem##4(variable); break;   \
                       ^~~~
./include/linux/percpu-defs.h:494:29: note: in expansion of macro =A1__pc=
pu_size_call_return=A2
 #define this_cpu_read(pcp)  __pcpu_size_call_return(this_cpu_read_, pcp)
                             ^~~~~~~~~~~~~~~~~~~~~~~
arch/powerpc/lib/code-patching.c:150:7: note: in expansion of macro =A1th=
is_cpu_read=A2
  if (!this_cpu_read(*PTRRELOC(&text_poke_area)))
       ^~~~~~~~~~~~~
arch/powerpc/lib/code-patching.c:150:21: error: invalid type argument of =
unary =A1*=A2 (have =A1int=A2)
  if (!this_cpu_read(*PTRRELOC(&text_poke_area)))
                     ^~~~~~~~~~~~~~~~~~~~~~~~~~
./include/linux/compiler.h:341:42: note: in definition of macro =A1__READ=
_ONCE=A2
   __read_once_size(&(x), __u.__c, sizeof(x));  \
                                          ^
./include/asm-generic/percpu.h:123:10: note: in expansion of macro =A1REA=
D_ONCE=A2
  __ret =3D READ_ONCE(*raw_cpu_ptr(&(pcp)));   \
          ^~~~~~~~~
./include/linux/percpu-defs.h:250:47: note: in expansion of macro =A1VERI=
FY_PERCPU_PTR=A2
 #define per_cpu_ptr(ptr, cpu) ({ (void)(cpu); VERIFY_PERCPU_PTR(ptr); })
                                               ^~~~~~~~~~~~~~~~~
./include/linux/percpu-defs.h:251:26: note: in expansion of macro =A1per_=
cpu_ptr=A2
 #define raw_cpu_ptr(ptr) per_cpu_ptr(ptr, 0)
                          ^~~~~~~~~~~
./include/asm-generic/percpu.h:123:21: note: in expansion of macro =A1raw=
_cpu_ptr=A2
  __ret =3D READ_ONCE(*raw_cpu_ptr(&(pcp)));   \
                     ^~~~~~~~~~~
./include/asm-generic/percpu.h:142:11: note: in expansion of macro =A1__t=
his_cpu_generic_read_nopreempt=A2
   __ret =3D __this_cpu_generic_read_nopreempt(pcp);  \
           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
./include/asm-generic/percpu.h:330:31: note: in expansion of macro =A1thi=
s_cpu_generic_read=A2
 #define this_cpu_read_4(pcp)  this_cpu_generic_read(pcp)
                               ^~~~~~~~~~~~~~~~~~~~~
./include/linux/percpu-defs.h:310:23: note: in expansion of macro =A1this=
_cpu_read_4=A2
  case 4: pscr_ret__ =3D stem##4(variable); break;   \
                       ^~~~
./include/linux/percpu-defs.h:494:29: note: in expansion of macro =A1__pc=
pu_size_call_return=A2
 #define this_cpu_read(pcp)  __pcpu_size_call_return(this_cpu_read_, pcp)
                             ^~~~~~~~~~~~~~~~~~~~~~~
arch/powerpc/lib/code-patching.c:150:7: note: in expansion of macro =A1th=
is_cpu_read=A2
  if (!this_cpu_read(*PTRRELOC(&text_poke_area)))
       ^~~~~~~~~~~~~
arch/powerpc/lib/code-patching.c:150:21: error: invalid type argument of =
unary =A1*=A2 (have =A1int=A2)
  if (!this_cpu_read(*PTRRELOC(&text_poke_area)))
                     ^~~~~~~~~~~~~~~~~~~~~~~~~~
./include/linux/compiler.h:341:42: note: in definition of macro =A1__READ=
_ONCE=A2
   __read_once_size(&(x), __u.__c, sizeof(x));  \
                                          ^
./include/asm-generic/percpu.h:123:10: note: in expansion of macro =A1REA=
D_ONCE=A2
  __ret =3D READ_ONCE(*raw_cpu_ptr(&(pcp)));   \
          ^~~~~~~~~
./include/linux/percpu-defs.h:250:47: note: in expansion of macro =A1VERI=
FY_PERCPU_PTR=A2
 #define per_cpu_ptr(ptr, cpu) ({ (void)(cpu); VERIFY_PERCPU_PTR(ptr); })
                                               ^~~~~~~~~~~~~~~~~
./include/linux/percpu-defs.h:251:26: note: in expansion of macro =A1per_=
cpu_ptr=A2
 #define raw_cpu_ptr(ptr) per_cpu_ptr(ptr, 0)
                          ^~~~~~~~~~~
./include/asm-generic/percpu.h:123:21: note: in expansion of macro =A1raw=
_cpu_ptr=A2
  __ret =3D READ_ONCE(*raw_cpu_ptr(&(pcp)));   \
                     ^~~~~~~~~~~
./include/asm-generic/percpu.h:142:11: note: in expansion of macro =A1__t=
his_cpu_generic_read_nopreempt=A2
   __ret =3D __this_cpu_generic_read_nopreempt(pcp);  \
           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
./include/asm-generic/percpu.h:330:31: note: in expansion of macro =A1thi=
s_cpu_generic_read=A2
 #define this_cpu_read_4(pcp)  this_cpu_generic_read(pcp)
                               ^~~~~~~~~~~~~~~~~~~~~
./include/linux/percpu-defs.h:310:23: note: in expansion of macro =A1this=
_cpu_read_4=A2
  case 4: pscr_ret__ =3D stem##4(variable); break;   \
                       ^~~~
./include/linux/percpu-defs.h:494:29: note: in expansion of macro =A1__pc=
pu_size_call_return=A2
 #define this_cpu_read(pcp)  __pcpu_size_call_return(this_cpu_read_, pcp)
                             ^~~~~~~~~~~~~~~~~~~~~~~
arch/powerpc/lib/code-patching.c:150:7: note: in expansion of macro =A1th=
is_cpu_read=A2
  if (!this_cpu_read(*PTRRELOC(&text_poke_area)))
       ^~~~~~~~~~~~~
arch/powerpc/lib/code-patching.c:150:21: error: invalid type argument of =
unary =A1*=A2 (have =A1int=A2)
  if (!this_cpu_read(*PTRRELOC(&text_poke_area)))
                     ^~~~~~~~~~~~~~~~~~~~~~~~~~
./include/linux/compiler.h:343:30: note: in definition of macro =A1__READ=
_ONCE=A2
   __read_once_size_nocheck(&(x), __u.__c, sizeof(x)); \
                              ^
./include/asm-generic/percpu.h:123:10: note: in expansion of macro =A1REA=
D_ONCE=A2
  __ret =3D READ_ONCE(*raw_cpu_ptr(&(pcp)));   \
          ^~~~~~~~~
./include/linux/percpu-defs.h:246:2: note: in expansion of macro =A1__ver=
ify_pcpu_ptr=A2
  __verify_pcpu_ptr(__p);      \
  ^~~~~~~~~~~~~~~~~
./include/linux/percpu-defs.h:250:47: note: in expansion of macro =A1VERI=
FY_PERCPU_PTR=A2
 #define per_cpu_ptr(ptr, cpu) ({ (void)(cpu); VERIFY_PERCPU_PTR(ptr); })
                                               ^~~~~~~~~~~~~~~~~
./include/linux/percpu-defs.h:251:26: note: in expansion of macro =A1per_=
cpu_ptr=A2
 #define raw_cpu_ptr(ptr) per_cpu_ptr(ptr, 0)
                          ^~~~~~~~~~~
./include/asm-generic/percpu.h:123:21: note: in expansion of macro =A1raw=
_cpu_ptr=A2
  __ret =3D READ_ONCE(*raw_cpu_ptr(&(pcp)));   \
                     ^~~~~~~~~~~
./include/asm-generic/percpu.h:142:11: note: in expansion of macro =A1__t=
his_cpu_generic_read_nopreempt=A2
   __ret =3D __this_cpu_generic_read_nopreempt(pcp);  \
           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
./include/asm-generic/percpu.h:330:31: note: in expansion of macro =A1thi=
s_cpu_generic_read=A2
 #define this_cpu_read_4(pcp)  this_cpu_generic_read(pcp)
                               ^~~~~~~~~~~~~~~~~~~~~
./include/linux/percpu-defs.h:310:23: note: in expansion of macro =A1this=
_cpu_read_4=A2
  case 4: pscr_ret__ =3D stem##4(variable); break;   \
                       ^~~~
./include/linux/percpu-defs.h:494:29: note: in expansion of macro =A1__pc=
pu_size_call_return=A2
 #define this_cpu_read(pcp)  __pcpu_size_call_return(this_cpu_read_, pcp)
                             ^~~~~~~~~~~~~~~~~~~~~~~
arch/powerpc/lib/code-patching.c:150:7: note: in expansion of macro =A1th=
is_cpu_read=A2
  if (!this_cpu_read(*PTRRELOC(&text_poke_area)))
       ^~~~~~~~~~~~~
arch/powerpc/lib/code-patching.c:150:21: error: invalid type argument of =
unary =A1*=A2 (have =A1int=A2)
  if (!this_cpu_read(*PTRRELOC(&text_poke_area)))
                     ^~~~~~~~~~~~~~~~~~~~~~~~~~
./include/linux/compiler.h:343:30: note: in definition of macro =A1__READ=
_ONCE=A2
   __read_once_size_nocheck(&(x), __u.__c, sizeof(x)); \
                              ^
./include/asm-generic/percpu.h:123:10: note: in expansion of macro =A1REA=
D_ONCE=A2
  __ret =3D READ_ONCE(*raw_cpu_ptr(&(pcp)));   \
          ^~~~~~~~~
./include/linux/percpu-defs.h:250:47: note: in expansion of macro =A1VERI=
FY_PERCPU_PTR=A2
 #define per_cpu_ptr(ptr, cpu) ({ (void)(cpu); VERIFY_PERCPU_PTR(ptr); })
                                               ^~~~~~~~~~~~~~~~~
./include/linux/percpu-defs.h:251:26: note: in expansion of macro =A1per_=
cpu_ptr=A2
 #define raw_cpu_ptr(ptr) per_cpu_ptr(ptr, 0)
                          ^~~~~~~~~~~
./include/asm-generic/percpu.h:123:21: note: in expansion of macro =A1raw=
_cpu_ptr=A2
  __ret =3D READ_ONCE(*raw_cpu_ptr(&(pcp)));   \
                     ^~~~~~~~~~~
./include/asm-generic/percpu.h:142:11: note: in expansion of macro =A1__t=
his_cpu_generic_read_nopreempt=A2
   __ret =3D __this_cpu_generic_read_nopreempt(pcp);  \
           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
./include/asm-generic/percpu.h:330:31: note: in expansion of macro =A1thi=
s_cpu_generic_read=A2
 #define this_cpu_read_4(pcp)  this_cpu_generic_read(pcp)
                               ^~~~~~~~~~~~~~~~~~~~~
./include/linux/percpu-defs.h:310:23: note: in expansion of macro =A1this=
_cpu_read_4=A2
  case 4: pscr_ret__ =3D stem##4(variable); break;   \
                       ^~~~
./include/linux/percpu-defs.h:494:29: note: in expansion of macro =A1__pc=
pu_size_call_return=A2
 #define this_cpu_read(pcp)  __pcpu_size_call_return(this_cpu_read_, pcp)
                             ^~~~~~~~~~~~~~~~~~~~~~~
arch/powerpc/lib/code-patching.c:150:7: note: in expansion of macro =A1th=
is_cpu_read=A2
  if (!this_cpu_read(*PTRRELOC(&text_poke_area)))
       ^~~~~~~~~~~~~
arch/powerpc/lib/code-patching.c:150:21: error: invalid type argument of =
unary =A1*=A2 (have =A1int=A2)
  if (!this_cpu_read(*PTRRELOC(&text_poke_area)))
                     ^~~~~~~~~~~~~~~~~~~~~~~~~~
./include/linux/compiler.h:343:30: note: in definition of macro =A1__READ=
_ONCE=A2
   __read_once_size_nocheck(&(x), __u.__c, sizeof(x)); \
                              ^
./include/asm-generic/percpu.h:123:10: note: in expansion of macro =A1REA=
D_ONCE=A2
  __ret =3D READ_ONCE(*raw_cpu_ptr(&(pcp)));   \
          ^~~~~~~~~
./include/linux/percpu-defs.h:250:47: note: in expansion of macro =A1VERI=
FY_PERCPU_PTR=A2
 #define per_cpu_ptr(ptr, cpu) ({ (void)(cpu); VERIFY_PERCPU_PTR(ptr); })
                                               ^~~~~~~~~~~~~~~~~
./include/linux/percpu-defs.h:251:26: note: in expansion of macro =A1per_=
cpu_ptr=A2
 #define raw_cpu_ptr(ptr) per_cpu_ptr(ptr, 0)
                          ^~~~~~~~~~~
./include/asm-generic/percpu.h:123:21: note: in expansion of macro =A1raw=
_cpu_ptr=A2
  __ret =3D READ_ONCE(*raw_cpu_ptr(&(pcp)));   \
                     ^~~~~~~~~~~
./include/asm-generic/percpu.h:142:11: note: in expansion of macro =A1__t=
his_cpu_generic_read_nopreempt=A2
   __ret =3D __this_cpu_generic_read_nopreempt(pcp);  \
           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
./include/asm-generic/percpu.h:330:31: note: in expansion of macro =A1thi=
s_cpu_generic_read=A2
 #define this_cpu_read_4(pcp)  this_cpu_generic_read(pcp)
                               ^~~~~~~~~~~~~~~~~~~~~
./include/linux/percpu-defs.h:310:23: note: in expansion of macro =A1this=
_cpu_read_4=A2
  case 4: pscr_ret__ =3D stem##4(variable); break;   \
                       ^~~~
./include/linux/percpu-defs.h:494:29: note: in expansion of macro =A1__pc=
pu_size_call_return=A2
 #define this_cpu_read(pcp)  __pcpu_size_call_return(this_cpu_read_, pcp)
                             ^~~~~~~~~~~~~~~~~~~~~~~
arch/powerpc/lib/code-patching.c:150:7: note: in expansion of macro =A1th=
is_cpu_read=A2
  if (!this_cpu_read(*PTRRELOC(&text_poke_area)))
       ^~~~~~~~~~~~~
arch/powerpc/lib/code-patching.c:150:21: error: invalid type argument of =
unary =A1*=A2 (have =A1int=A2)
  if (!this_cpu_read(*PTRRELOC(&text_poke_area)))
                     ^~~~~~~~~~~~~~~~~~~~~~~~~~
./include/linux/compiler.h:343:50: note: in definition of macro =A1__READ=
_ONCE=A2
   __read_once_size_nocheck(&(x), __u.__c, sizeof(x)); \
                                                  ^
./include/asm-generic/percpu.h:123:10: note: in expansion of macro =A1REA=
D_ONCE=A2
  __ret =3D READ_ONCE(*raw_cpu_ptr(&(pcp)));   \
          ^~~~~~~~~
./include/linux/percpu-defs.h:246:2: note: in expansion of macro =A1__ver=
ify_pcpu_ptr=A2
  __verify_pcpu_ptr(__p);      \
  ^~~~~~~~~~~~~~~~~
./include/linux/percpu-defs.h:250:47: note: in expansion of macro =A1VERI=
FY_PERCPU_PTR=A2
 #define per_cpu_ptr(ptr, cpu) ({ (void)(cpu); VERIFY_PERCPU_PTR(ptr); })
                                               ^~~~~~~~~~~~~~~~~
./include/linux/percpu-defs.h:251:26: note: in expansion of macro =A1per_=
cpu_ptr=A2
 #define raw_cpu_ptr(ptr) per_cpu_ptr(ptr, 0)
                          ^~~~~~~~~~~
./include/asm-generic/percpu.h:123:21: note: in expansion of macro =A1raw=
_cpu_ptr=A2
  __ret =3D READ_ONCE(*raw_cpu_ptr(&(pcp)));   \
                     ^~~~~~~~~~~
./include/asm-generic/percpu.h:142:11: note: in expansion of macro =A1__t=
his_cpu_generic_read_nopreempt=A2
   __ret =3D __this_cpu_generic_read_nopreempt(pcp);  \
           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
./include/asm-generic/percpu.h:330:31: note: in expansion of macro =A1thi=
s_cpu_generic_read=A2
 #define this_cpu_read_4(pcp)  this_cpu_generic_read(pcp)
                               ^~~~~~~~~~~~~~~~~~~~~
./include/linux/percpu-defs.h:310:23: note: in expansion of macro =A1this=
_cpu_read_4=A2
  case 4: pscr_ret__ =3D stem##4(variable); break;   \
                       ^~~~
./include/linux/percpu-defs.h:494:29: note: in expansion of macro =A1__pc=
pu_size_call_return=A2
 #define this_cpu_read(pcp)  __pcpu_size_call_return(this_cpu_read_, pcp)
                             ^~~~~~~~~~~~~~~~~~~~~~~
arch/powerpc/lib/code-patching.c:150:7: note: in expansion of macro =A1th=
is_cpu_read=A2
  if (!this_cpu_read(*PTRRELOC(&text_poke_area)))
       ^~~~~~~~~~~~~
arch/powerpc/lib/code-patching.c:150:21: error: invalid type argument of =
unary =A1*=A2 (have =A1int=A2)
  if (!this_cpu_read(*PTRRELOC(&text_poke_area)))
                     ^~~~~~~~~~~~~~~~~~~~~~~~~~
./include/linux/compiler.h:343:50: note: in definition of macro =A1__READ=
_ONCE=A2
   __read_once_size_nocheck(&(x), __u.__c, sizeof(x)); \
                                                  ^
./include/asm-generic/percpu.h:123:10: note: in expansion of macro =A1REA=
D_ONCE=A2
  __ret =3D READ_ONCE(*raw_cpu_ptr(&(pcp)));   \
          ^~~~~~~~~
./include/linux/percpu-defs.h:250:47: note: in expansion of macro =A1VERI=
FY_PERCPU_PTR=A2
 #define per_cpu_ptr(ptr, cpu) ({ (void)(cpu); VERIFY_PERCPU_PTR(ptr); })
                                               ^~~~~~~~~~~~~~~~~
./include/linux/percpu-defs.h:251:26: note: in expansion of macro =A1per_=
cpu_ptr=A2
 #define raw_cpu_ptr(ptr) per_cpu_ptr(ptr, 0)
                          ^~~~~~~~~~~
./include/asm-generic/percpu.h:123:21: note: in expansion of macro =A1raw=
_cpu_ptr=A2
  __ret =3D READ_ONCE(*raw_cpu_ptr(&(pcp)));   \
                     ^~~~~~~~~~~
./include/asm-generic/percpu.h:142:11: note: in expansion of macro =A1__t=
his_cpu_generic_read_nopreempt=A2
   __ret =3D __this_cpu_generic_read_nopreempt(pcp);  \
           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
./include/asm-generic/percpu.h:330:31: note: in expansion of macro =A1thi=
s_cpu_generic_read=A2
 #define this_cpu_read_4(pcp)  this_cpu_generic_read(pcp)
                               ^~~~~~~~~~~~~~~~~~~~~
./include/linux/percpu-defs.h:310:23: note: in expansion of macro =A1this=
_cpu_read_4=A2
  case 4: pscr_ret__ =3D stem##4(variable); break;   \
                       ^~~~
./include/linux/percpu-defs.h:494:29: note: in expansion of macro =A1__pc=
pu_size_call_return=A2
 #define this_cpu_read(pcp)  __pcpu_size_call_return(this_cpu_read_, pcp)
                             ^~~~~~~~~~~~~~~~~~~~~~~
arch/powerpc/lib/code-patching.c:150:7: note: in expansion of macro =A1th=
is_cpu_read=A2
  if (!this_cpu_read(*PTRRELOC(&text_poke_area)))
       ^~~~~~~~~~~~~
arch/powerpc/lib/code-patching.c:150:21: error: invalid type argument of =
unary =A1*=A2 (have =A1int=A2)
  if (!this_cpu_read(*PTRRELOC(&text_poke_area)))
                     ^~~~~~~~~~~~~~~~~~~~~~~~~~
./include/linux/compiler.h:343:50: note: in definition of macro =A1__READ=
_ONCE=A2
   __read_once_size_nocheck(&(x), __u.__c, sizeof(x)); \
                                                  ^
./include/asm-generic/percpu.h:123:10: note: in expansion of macro =A1REA=
D_ONCE=A2
  __ret =3D READ_ONCE(*raw_cpu_ptr(&(pcp)));   \
          ^~~~~~~~~
./include/linux/percpu-defs.h:250:47: note: in expansion of macro =A1VERI=
FY_PERCPU_PTR=A2
 #define per_cpu_ptr(ptr, cpu) ({ (void)(cpu); VERIFY_PERCPU_PTR(ptr); })
                                               ^~~~~~~~~~~~~~~~~
./include/linux/percpu-defs.h:251:26: note: in expansion of macro =A1per_=
cpu_ptr=A2
 #define raw_cpu_ptr(ptr) per_cpu_ptr(ptr, 0)
                          ^~~~~~~~~~~
./include/asm-generic/percpu.h:123:21: note: in expansion of macro =A1raw=
_cpu_ptr=A2
  __ret =3D READ_ONCE(*raw_cpu_ptr(&(pcp)));   \
                     ^~~~~~~~~~~
./include/asm-generic/percpu.h:142:11: note: in expansion of macro =A1__t=
his_cpu_generic_read_nopreempt=A2
   __ret =3D __this_cpu_generic_read_nopreempt(pcp);  \
           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
./include/asm-generic/percpu.h:330:31: note: in expansion of macro =A1thi=
s_cpu_generic_read=A2
 #define this_cpu_read_4(pcp)  this_cpu_generic_read(pcp)
                               ^~~~~~~~~~~~~~~~~~~~~
./include/linux/percpu-defs.h:310:23: note: in expansion of macro =A1this=
_cpu_read_4=A2
  case 4: pscr_ret__ =3D stem##4(variable); break;   \
                       ^~~~
./include/linux/percpu-defs.h:494:29: note: in expansion of macro =A1__pc=
pu_size_call_return=A2
 #define this_cpu_read(pcp)  __pcpu_size_call_return(this_cpu_read_, pcp)
                             ^~~~~~~~~~~~~~~~~~~~~~~
arch/powerpc/lib/code-patching.c:150:7: note: in expansion of macro =A1th=
is_cpu_read=A2
  if (!this_cpu_read(*PTRRELOC(&text_poke_area)))
       ^~~~~~~~~~~~~
In file included from ./arch/powerpc/include/asm/percpu.h:20:0,
                 from ./include/linux/percpu.h:13,
                 from ./include/linux/kprobes.h:38,
                 from arch/powerpc/lib/code-patching.c:11:
arch/powerpc/lib/code-patching.c:150:21: error: invalid type argument of =
unary =A1*=A2 (have =A1int=A2)
  if (!this_cpu_read(*PTRRELOC(&text_poke_area)))
                     ^~~~~~~~~~~~~~~~~~~~~~~~~~
./include/asm-generic/percpu.h:130:9: note: in definition of macro =A1__t=
his_cpu_generic_read_noirq=A2
  typeof(pcp) __ret;      \
         ^~~
./include/asm-generic/percpu.h:330:31: note: in expansion of macro =A1thi=
s_cpu_generic_read=A2
 #define this_cpu_read_4(pcp)  this_cpu_generic_read(pcp)
                               ^~~~~~~~~~~~~~~~~~~~~
./include/linux/percpu-defs.h:310:23: note: in expansion of macro =A1this=
_cpu_read_4=A2
  case 4: pscr_ret__ =3D stem##4(variable); break;   \
                       ^~~~
./include/linux/percpu-defs.h:494:29: note: in expansion of macro =A1__pc=
pu_size_call_return=A2
 #define this_cpu_read(pcp)  __pcpu_size_call_return(this_cpu_read_, pcp)
                             ^~~~~~~~~~~~~~~~~~~~~~~
arch/powerpc/lib/code-patching.c:150:7: note: in expansion of macro =A1th=
is_cpu_read=A2
  if (!this_cpu_read(*PTRRELOC(&text_poke_area)))
       ^~~~~~~~~~~~~
In file included from ./include/asm-generic/percpu.h:7:0,
                 from ./arch/powerpc/include/asm/percpu.h:20,
                 from ./include/linux/percpu.h:13,
                 from ./include/linux/kprobes.h:38,
                 from arch/powerpc/lib/code-patching.c:11:
arch/powerpc/lib/code-patching.c:150:21: error: invalid type argument of =
unary =A1*=A2 (have =A1int=A2)
  if (!this_cpu_read(*PTRRELOC(&text_poke_area)))
                     ^~~~~~~~~~~~~~~~~~~~~~~~~~
./include/linux/percpu-defs.h:206:47: note: in definition of macro =A1__v=
erify_pcpu_ptr=A2
  const void __percpu *__vpp_verify =3D (typeof((ptr) + 0))NULL; \
                                               ^~~
./include/linux/percpu-defs.h:250:47: note: in expansion of macro =A1VERI=
FY_PERCPU_PTR=A2
 #define per_cpu_ptr(ptr, cpu) ({ (void)(cpu); VERIFY_PERCPU_PTR(ptr); })
                                               ^~~~~~~~~~~~~~~~~
./include/linux/percpu-defs.h:251:26: note: in expansion of macro =A1per_=
cpu_ptr=A2
 #define raw_cpu_ptr(ptr) per_cpu_ptr(ptr, 0)
                          ^~~~~~~~~~~
./include/asm-generic/percpu.h:71:3: note: in expansion of macro =A1raw_c=
pu_ptr=A2
  *raw_cpu_ptr(&(pcp));      \
   ^~~~~~~~~~~
./include/asm-generic/percpu.h:133:10: note: in expansion of macro =A1raw=
_cpu_generic_read=A2
  __ret =3D raw_cpu_generic_read(pcp);    \
          ^~~~~~~~~~~~~~~~~~~~
./include/asm-generic/percpu.h:144:11: note: in expansion of macro =A1__t=
his_cpu_generic_read_noirq=A2
   __ret =3D __this_cpu_generic_read_noirq(pcp);  \
           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
./include/asm-generic/percpu.h:330:31: note: in expansion of macro =A1thi=
s_cpu_generic_read=A2
 #define this_cpu_read_4(pcp)  this_cpu_generic_read(pcp)
                               ^~~~~~~~~~~~~~~~~~~~~
./include/linux/percpu-defs.h:310:23: note: in expansion of macro =A1this=
_cpu_read_4=A2
  case 4: pscr_ret__ =3D stem##4(variable); break;   \
                       ^~~~
./include/linux/percpu-defs.h:494:29: note: in expansion of macro =A1__pc=
pu_size_call_return=A2
 #define this_cpu_read(pcp)  __pcpu_size_call_return(this_cpu_read_, pcp)
                             ^~~~~~~~~~~~~~~~~~~~~~~
arch/powerpc/lib/code-patching.c:150:7: note: in expansion of macro =A1th=
is_cpu_read=A2
  if (!this_cpu_read(*PTRRELOC(&text_poke_area)))
       ^~~~~~~~~~~~~
arch/powerpc/lib/code-patching.c:150:21: error: invalid type argument of =
unary =A1*=A2 (have =A1int=A2)
  if (!this_cpu_read(*PTRRELOC(&text_poke_area)))
                     ^~~~~~~~~~~~~~~~~~~~~~~~~~
./include/linux/percpu-defs.h:247:12: note: in definition of macro =A1VER=
IFY_PERCPU_PTR=A2
  (typeof(*(__p)) __kernel __force *)(__p);   \
            ^~~
./include/linux/percpu-defs.h:251:26: note: in expansion of macro =A1per_=
cpu_ptr=A2
 #define raw_cpu_ptr(ptr) per_cpu_ptr(ptr, 0)
                          ^~~~~~~~~~~
./include/asm-generic/percpu.h:71:3: note: in expansion of macro =A1raw_c=
pu_ptr=A2
  *raw_cpu_ptr(&(pcp));      \
   ^~~~~~~~~~~
./include/asm-generic/percpu.h:133:10: note: in expansion of macro =A1raw=
_cpu_generic_read=A2
  __ret =3D raw_cpu_generic_read(pcp);    \
          ^~~~~~~~~~~~~~~~~~~~
./include/asm-generic/percpu.h:144:11: note: in expansion of macro =A1__t=
his_cpu_generic_read_noirq=A2
   __ret =3D __this_cpu_generic_read_noirq(pcp);  \
           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
./include/asm-generic/percpu.h:330:31: note: in expansion of macro =A1thi=
s_cpu_generic_read=A2
 #define this_cpu_read_4(pcp)  this_cpu_generic_read(pcp)
                               ^~~~~~~~~~~~~~~~~~~~~
./include/linux/percpu-defs.h:310:23: note: in expansion of macro =A1this=
_cpu_read_4=A2
  case 4: pscr_ret__ =3D stem##4(variable); break;   \
                       ^~~~
./include/linux/percpu-defs.h:494:29: note: in expansion of macro =A1__pc=
pu_size_call_return=A2
 #define this_cpu_read(pcp)  __pcpu_size_call_return(this_cpu_read_, pcp)
                             ^~~~~~~~~~~~~~~~~~~~~~~
arch/powerpc/lib/code-patching.c:150:7: note: in expansion of macro =A1th=
is_cpu_read=A2
  if (!this_cpu_read(*PTRRELOC(&text_poke_area)))
       ^~~~~~~~~~~~~
arch/powerpc/lib/code-patching.c:150:21: error: invalid type argument of =
unary =A1*=A2 (have =A1int=A2)
  if (!this_cpu_read(*PTRRELOC(&text_poke_area)))
                     ^~~~~~~~~~~~~~~~~~~~~~~~~~
./include/linux/percpu-defs.h:247:38: note: in definition of macro =A1VER=
IFY_PERCPU_PTR=A2
  (typeof(*(__p)) __kernel __force *)(__p);   \
                                      ^~~
./include/linux/percpu-defs.h:251:26: note: in expansion of macro =A1per_=
cpu_ptr=A2
 #define raw_cpu_ptr(ptr) per_cpu_ptr(ptr, 0)
                          ^~~~~~~~~~~
./include/asm-generic/percpu.h:71:3: note: in expansion of macro =A1raw_c=
pu_ptr=A2
  *raw_cpu_ptr(&(pcp));      \
   ^~~~~~~~~~~
./include/asm-generic/percpu.h:133:10: note: in expansion of macro =A1raw=
_cpu_generic_read=A2
  __ret =3D raw_cpu_generic_read(pcp);    \
          ^~~~~~~~~~~~~~~~~~~~
./include/asm-generic/percpu.h:144:11: note: in expansion of macro =A1__t=
his_cpu_generic_read_noirq=A2
   __ret =3D __this_cpu_generic_read_noirq(pcp);  \
           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
./include/asm-generic/percpu.h:330:31: note: in expansion of macro =A1thi=
s_cpu_generic_read=A2
 #define this_cpu_read_4(pcp)  this_cpu_generic_read(pcp)
                               ^~~~~~~~~~~~~~~~~~~~~
./include/linux/percpu-defs.h:310:23: note: in expansion of macro =A1this=
_cpu_read_4=A2
  case 4: pscr_ret__ =3D stem##4(variable); break;   \
                       ^~~~
./include/linux/percpu-defs.h:494:29: note: in expansion of macro =A1__pc=
pu_size_call_return=A2
 #define this_cpu_read(pcp)  __pcpu_size_call_return(this_cpu_read_, pcp)
                             ^~~~~~~~~~~~~~~~~~~~~~~
arch/powerpc/lib/code-patching.c:150:7: note: in expansion of macro =A1th=
is_cpu_read=A2
  if (!this_cpu_read(*PTRRELOC(&text_poke_area)))
       ^~~~~~~~~~~~~
In file included from ./arch/powerpc/include/asm/percpu.h:20:0,
                 from ./include/linux/percpu.h:13,
                 from ./include/linux/kprobes.h:38,
                 from arch/powerpc/lib/code-patching.c:11:
arch/powerpc/lib/code-patching.c:150:21: error: invalid type argument of =
unary =A1*=A2 (have =A1int=A2)
  if (!this_cpu_read(*PTRRELOC(&text_poke_area)))
                     ^~~~~~~~~~~~~~~~~~~~~~~~~~
./include/asm-generic/percpu.h:140:9: note: in definition of macro =A1thi=
s_cpu_generic_read=A2
  typeof(pcp) __ret;      \
         ^~~
./include/linux/percpu-defs.h:311:23: note: in expansion of macro =A1this=
_cpu_read_8=A2
  case 8: pscr_ret__ =3D stem##8(variable); break;   \
                       ^~~~
./include/linux/percpu-defs.h:494:29: note: in expansion of macro =A1__pc=
pu_size_call_return=A2
 #define this_cpu_read(pcp)  __pcpu_size_call_return(this_cpu_read_, pcp)
                             ^~~~~~~~~~~~~~~~~~~~~~~
arch/powerpc/lib/code-patching.c:150:7: note: in expansion of macro =A1th=
is_cpu_read=A2
  if (!this_cpu_read(*PTRRELOC(&text_poke_area)))
       ^~~~~~~~~~~~~
In file included from ./include/linux/linkage.h:5:0,
                 from ./include/linux/kernel.h:7,
                 from arch/powerpc/lib/code-patching.c:10:
arch/powerpc/lib/code-patching.c:150:21: error: invalid type argument of =
unary =A1*=A2 (have =A1int=A2)
  if (!this_cpu_read(*PTRRELOC(&text_poke_area)))
                     ^~~~~~~~~~~~~~~~~~~~~~~~~~
./include/linux/compiler.h:524:35: note: in definition of macro =A1__nati=
ve_word=A2
 # define __native_word(t) (sizeof(t) =3D=3D sizeof(char) || sizeof(t) =3D=
=3D sizeof(short) || sizeof(t) =3D=3D sizeof(int) || sizeof(t) =3D=3D siz=
eof(long))
                                   ^
./include/asm-generic/percpu.h:333:31: note: in expansion of macro =A1thi=
s_cpu_generic_read=A2
 #define this_cpu_read_8(pcp)  this_cpu_generic_read(pcp)
                               ^~~~~~~~~~~~~~~~~~~~~
./include/linux/percpu-defs.h:311:23: note: in expansion of macro =A1this=
_cpu_read_8=A2
  case 8: pscr_ret__ =3D stem##8(variable); break;   \
                       ^~~~
./include/linux/percpu-defs.h:494:29: note: in expansion of macro =A1__pc=
pu_size_call_return=A2
 #define this_cpu_read(pcp)  __pcpu_size_call_return(this_cpu_read_, pcp)
                             ^~~~~~~~~~~~~~~~~~~~~~~
arch/powerpc/lib/code-patching.c:150:7: note: in expansion of macro =A1th=
is_cpu_read=A2
  if (!this_cpu_read(*PTRRELOC(&text_poke_area)))
       ^~~~~~~~~~~~~
arch/powerpc/lib/code-patching.c:150:21: error: invalid type argument of =
unary =A1*=A2 (have =A1int=A2)
  if (!this_cpu_read(*PTRRELOC(&text_poke_area)))
                     ^~~~~~~~~~~~~~~~~~~~~~~~~~
./include/linux/compiler.h:524:64: note: in definition of macro =A1__nati=
ve_word=A2
 # define __native_word(t) (sizeof(t) =3D=3D sizeof(char) || sizeof(t) =3D=
=3D sizeof(short) || sizeof(t) =3D=3D sizeof(int) || sizeof(t) =3D=3D siz=
eof(long))
                                                                ^
./include/asm-generic/percpu.h:333:31: note: in expansion of macro =A1thi=
s_cpu_generic_read=A2
 #define this_cpu_read_8(pcp)  this_cpu_generic_read(pcp)
                               ^~~~~~~~~~~~~~~~~~~~~
./include/linux/percpu-defs.h:311:23: note: in expansion of macro =A1this=
_cpu_read_8=A2
  case 8: pscr_ret__ =3D stem##8(variable); break;   \
                       ^~~~
./include/linux/percpu-defs.h:494:29: note: in expansion of macro =A1__pc=
pu_size_call_return=A2
 #define this_cpu_read(pcp)  __pcpu_size_call_return(this_cpu_read_, pcp)
                             ^~~~~~~~~~~~~~~~~~~~~~~
arch/powerpc/lib/code-patching.c:150:7: note: in expansion of macro =A1th=
is_cpu_read=A2
  if (!this_cpu_read(*PTRRELOC(&text_poke_area)))
       ^~~~~~~~~~~~~
arch/powerpc/lib/code-patching.c:150:21: error: invalid type argument of =
unary =A1*=A2 (have =A1int=A2)
  if (!this_cpu_read(*PTRRELOC(&text_poke_area)))
                     ^~~~~~~~~~~~~~~~~~~~~~~~~~
./include/linux/compiler.h:524:94: note: in definition of macro =A1__nati=
ve_word=A2
 # define __native_word(t) (sizeof(t) =3D=3D sizeof(char) || sizeof(t) =3D=
=3D sizeof(short) || sizeof(t) =3D=3D sizeof(int) || sizeof(t) =3D=3D siz=
eof(long))
                                                                         =
                     ^
./include/asm-generic/percpu.h:333:31: note: in expansion of macro =A1thi=
s_cpu_generic_read=A2
 #define this_cpu_read_8(pcp)  this_cpu_generic_read(pcp)
                               ^~~~~~~~~~~~~~~~~~~~~
./include/linux/percpu-defs.h:311:23: note: in expansion of macro =A1this=
_cpu_read_8=A2
  case 8: pscr_ret__ =3D stem##8(variable); break;   \
                       ^~~~
./include/linux/percpu-defs.h:494:29: note: in expansion of macro =A1__pc=
pu_size_call_return=A2
 #define this_cpu_read(pcp)  __pcpu_size_call_return(this_cpu_read_, pcp)
                             ^~~~~~~~~~~~~~~~~~~~~~~
arch/powerpc/lib/code-patching.c:150:7: note: in expansion of macro =A1th=
is_cpu_read=A2
  if (!this_cpu_read(*PTRRELOC(&text_poke_area)))
       ^~~~~~~~~~~~~
arch/powerpc/lib/code-patching.c:150:21: error: invalid type argument of =
unary =A1*=A2 (have =A1int=A2)
  if (!this_cpu_read(*PTRRELOC(&text_poke_area)))
                     ^~~~~~~~~~~~~~~~~~~~~~~~~~
./include/linux/compiler.h:524:122: note: in definition of macro =A1__nat=
ive_word=A2
 # define __native_word(t) (sizeof(t) =3D=3D sizeof(char) || sizeof(t) =3D=
=3D sizeof(short) || sizeof(t) =3D=3D sizeof(int) || sizeof(t) =3D=3D siz=
eof(long))
                                                                         =
                                                 ^
./include/asm-generic/percpu.h:333:31: note: in expansion of macro =A1thi=
s_cpu_generic_read=A2
 #define this_cpu_read_8(pcp)  this_cpu_generic_read(pcp)
                               ^~~~~~~~~~~~~~~~~~~~~
./include/linux/percpu-defs.h:311:23: note: in expansion of macro =A1this=
_cpu_read_8=A2
  case 8: pscr_ret__ =3D stem##8(variable); break;   \
                       ^~~~
./include/linux/percpu-defs.h:494:29: note: in expansion of macro =A1__pc=
pu_size_call_return=A2
 #define this_cpu_read(pcp)  __pcpu_size_call_return(this_cpu_read_, pcp)
                             ^~~~~~~~~~~~~~~~~~~~~~~
arch/powerpc/lib/code-patching.c:150:7: note: in expansion of macro =A1th=
is_cpu_read=A2
  if (!this_cpu_read(*PTRRELOC(&text_poke_area)))
       ^~~~~~~~~~~~~
In file included from ./arch/powerpc/include/asm/percpu.h:20:0,
                 from ./include/linux/percpu.h:13,
                 from ./include/linux/kprobes.h:38,
                 from arch/powerpc/lib/code-patching.c:11:
arch/powerpc/lib/code-patching.c:150:21: error: invalid type argument of =
unary =A1*=A2 (have =A1int=A2)
  if (!this_cpu_read(*PTRRELOC(&text_poke_area)))
                     ^~~~~~~~~~~~~~~~~~~~~~~~~~
./include/asm-generic/percpu.h:121:9: note: in definition of macro =A1__t=
his_cpu_generic_read_nopreempt=A2
  typeof(pcp) __ret;      \
         ^~~
./include/asm-generic/percpu.h:333:31: note: in expansion of macro =A1thi=
s_cpu_generic_read=A2
 #define this_cpu_read_8(pcp)  this_cpu_generic_read(pcp)
                               ^~~~~~~~~~~~~~~~~~~~~
./include/linux/percpu-defs.h:311:23: note: in expansion of macro =A1this=
_cpu_read_8=A2
  case 8: pscr_ret__ =3D stem##8(variable); break;   \
                       ^~~~
./include/linux/percpu-defs.h:494:29: note: in expansion of macro =A1__pc=
pu_size_call_return=A2
 #define this_cpu_read(pcp)  __pcpu_size_call_return(this_cpu_read_, pcp)
                             ^~~~~~~~~~~~~~~~~~~~~~~
arch/powerpc/lib/code-patching.c:150:7: note: in expansion of macro =A1th=
is_cpu_read=A2
  if (!this_cpu_read(*PTRRELOC(&text_poke_area)))
       ^~~~~~~~~~~~~
In file included from ./include/linux/linkage.h:5:0,
                 from ./include/linux/kernel.h:7,
                 from arch/powerpc/lib/code-patching.c:10:
arch/powerpc/lib/code-patching.c:150:21: error: invalid type argument of =
unary =A1*=A2 (have =A1int=A2)
  if (!this_cpu_read(*PTRRELOC(&text_poke_area)))
                     ^~~~~~~~~~~~~~~~~~~~~~~~~~
./include/linux/compiler.h:339:17: note: in definition of macro =A1__READ=
_ONCE=A2
  union { typeof(x) __val; char __c[1]; } __u;   \
                 ^
./include/asm-generic/percpu.h:123:10: note: in expansion of macro =A1REA=
D_ONCE=A2
  __ret =3D READ_ONCE(*raw_cpu_ptr(&(pcp)));   \
          ^~~~~~~~~
./include/linux/percpu-defs.h:246:2: note: in expansion of macro =A1__ver=
ify_pcpu_ptr=A2
  __verify_pcpu_ptr(__p);      \
  ^~~~~~~~~~~~~~~~~
./include/linux/percpu-defs.h:250:47: note: in expansion of macro =A1VERI=
FY_PERCPU_PTR=A2
 #define per_cpu_ptr(ptr, cpu) ({ (void)(cpu); VERIFY_PERCPU_PTR(ptr); })
                                               ^~~~~~~~~~~~~~~~~
./include/linux/percpu-defs.h:251:26: note: in expansion of macro =A1per_=
cpu_ptr=A2
 #define raw_cpu_ptr(ptr) per_cpu_ptr(ptr, 0)
                          ^~~~~~~~~~~
./include/asm-generic/percpu.h:123:21: note: in expansion of macro =A1raw=
_cpu_ptr=A2
  __ret =3D READ_ONCE(*raw_cpu_ptr(&(pcp)));   \
                     ^~~~~~~~~~~
./include/asm-generic/percpu.h:142:11: note: in expansion of macro =A1__t=
his_cpu_generic_read_nopreempt=A2
   __ret =3D __this_cpu_generic_read_nopreempt(pcp);  \
           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
./include/asm-generic/percpu.h:333:31: note: in expansion of macro =A1thi=
s_cpu_generic_read=A2
 #define this_cpu_read_8(pcp)  this_cpu_generic_read(pcp)
                               ^~~~~~~~~~~~~~~~~~~~~
./include/linux/percpu-defs.h:311:23: note: in expansion of macro =A1this=
_cpu_read_8=A2
  case 8: pscr_ret__ =3D stem##8(variable); break;   \
                       ^~~~
./include/linux/percpu-defs.h:494:29: note: in expansion of macro =A1__pc=
pu_size_call_return=A2
 #define this_cpu_read(pcp)  __pcpu_size_call_return(this_cpu_read_, pcp)
                             ^~~~~~~~~~~~~~~~~~~~~~~
arch/powerpc/lib/code-patching.c:150:7: note: in expansion of macro =A1th=
is_cpu_read=A2
  if (!this_cpu_read(*PTRRELOC(&text_poke_area)))
       ^~~~~~~~~~~~~
arch/powerpc/lib/code-patching.c:150:21: error: invalid type argument of =
unary =A1*=A2 (have =A1int=A2)
  if (!this_cpu_read(*PTRRELOC(&text_poke_area)))
                     ^~~~~~~~~~~~~~~~~~~~~~~~~~
./include/linux/compiler.h:339:17: note: in definition of macro =A1__READ=
_ONCE=A2
  union { typeof(x) __val; char __c[1]; } __u;   \
                 ^
./include/asm-generic/percpu.h:123:10: note: in expansion of macro =A1REA=
D_ONCE=A2
  __ret =3D READ_ONCE(*raw_cpu_ptr(&(pcp)));   \
          ^~~~~~~~~
./include/linux/percpu-defs.h:250:47: note: in expansion of macro =A1VERI=
FY_PERCPU_PTR=A2
 #define per_cpu_ptr(ptr, cpu) ({ (void)(cpu); VERIFY_PERCPU_PTR(ptr); })
                                               ^~~~~~~~~~~~~~~~~
./include/linux/percpu-defs.h:251:26: note: in expansion of macro =A1per_=
cpu_ptr=A2
 #define raw_cpu_ptr(ptr) per_cpu_ptr(ptr, 0)
                          ^~~~~~~~~~~
./include/asm-generic/percpu.h:123:21: note: in expansion of macro =A1raw=
_cpu_ptr=A2
  __ret =3D READ_ONCE(*raw_cpu_ptr(&(pcp)));   \
                     ^~~~~~~~~~~
./include/asm-generic/percpu.h:142:11: note: in expansion of macro =A1__t=
his_cpu_generic_read_nopreempt=A2
   __ret =3D __this_cpu_generic_read_nopreempt(pcp);  \
           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
./include/asm-generic/percpu.h:333:31: note: in expansion of macro =A1thi=
s_cpu_generic_read=A2
 #define this_cpu_read_8(pcp)  this_cpu_generic_read(pcp)
                               ^~~~~~~~~~~~~~~~~~~~~
./include/linux/percpu-defs.h:311:23: note: in expansion of macro =A1this=
_cpu_read_8=A2
  case 8: pscr_ret__ =3D stem##8(variable); break;   \
                       ^~~~
./include/linux/percpu-defs.h:494:29: note: in expansion of macro =A1__pc=
pu_size_call_return=A2
 #define this_cpu_read(pcp)  __pcpu_size_call_return(this_cpu_read_, pcp)
                             ^~~~~~~~~~~~~~~~~~~~~~~
arch/powerpc/lib/code-patching.c:150:7: note: in expansion of macro =A1th=
is_cpu_read=A2
  if (!this_cpu_read(*PTRRELOC(&text_poke_area)))
       ^~~~~~~~~~~~~
arch/powerpc/lib/code-patching.c:150:21: error: invalid type argument of =
unary =A1*=A2 (have =A1int=A2)
  if (!this_cpu_read(*PTRRELOC(&text_poke_area)))
                     ^~~~~~~~~~~~~~~~~~~~~~~~~~
./include/linux/compiler.h:339:17: note: in definition of macro =A1__READ=
_ONCE=A2
  union { typeof(x) __val; char __c[1]; } __u;   \
                 ^
./include/asm-generic/percpu.h:123:10: note: in expansion of macro =A1REA=
D_ONCE=A2
  __ret =3D READ_ONCE(*raw_cpu_ptr(&(pcp)));   \
          ^~~~~~~~~
./include/linux/percpu-defs.h:250:47: note: in expansion of macro =A1VERI=
FY_PERCPU_PTR=A2
 #define per_cpu_ptr(ptr, cpu) ({ (void)(cpu); VERIFY_PERCPU_PTR(ptr); })
                                               ^~~~~~~~~~~~~~~~~
./include/linux/percpu-defs.h:251:26: note: in expansion of macro =A1per_=
cpu_ptr=A2
 #define raw_cpu_ptr(ptr) per_cpu_ptr(ptr, 0)
                          ^~~~~~~~~~~
./include/asm-generic/percpu.h:123:21: note: in expansion of macro =A1raw=
_cpu_ptr=A2
  __ret =3D READ_ONCE(*raw_cpu_ptr(&(pcp)));   \
                     ^~~~~~~~~~~
./include/asm-generic/percpu.h:142:11: note: in expansion of macro =A1__t=
his_cpu_generic_read_nopreempt=A2
   __ret =3D __this_cpu_generic_read_nopreempt(pcp);  \
           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
./include/asm-generic/percpu.h:333:31: note: in expansion of macro =A1thi=
s_cpu_generic_read=A2
 #define this_cpu_read_8(pcp)  this_cpu_generic_read(pcp)
                               ^~~~~~~~~~~~~~~~~~~~~
./include/linux/percpu-defs.h:311:23: note: in expansion of macro =A1this=
_cpu_read_8=A2
  case 8: pscr_ret__ =3D stem##8(variable); break;   \
                       ^~~~
./include/linux/percpu-defs.h:494:29: note: in expansion of macro =A1__pc=
pu_size_call_return=A2
 #define this_cpu_read(pcp)  __pcpu_size_call_return(this_cpu_read_, pcp)
                             ^~~~~~~~~~~~~~~~~~~~~~~
arch/powerpc/lib/code-patching.c:150:7: note: in expansion of macro =A1th=
is_cpu_read=A2
  if (!this_cpu_read(*PTRRELOC(&text_poke_area)))
       ^~~~~~~~~~~~~
arch/powerpc/lib/code-patching.c:150:21: error: invalid type argument of =
unary =A1*=A2 (have =A1int=A2)
  if (!this_cpu_read(*PTRRELOC(&text_poke_area)))
                     ^~~~~~~~~~~~~~~~~~~~~~~~~~
./include/linux/compiler.h:341:22: note: in definition of macro =A1__READ=
_ONCE=A2
   __read_once_size(&(x), __u.__c, sizeof(x));  \
                      ^
./include/asm-generic/percpu.h:123:10: note: in expansion of macro =A1REA=
D_ONCE=A2
  __ret =3D READ_ONCE(*raw_cpu_ptr(&(pcp)));   \
          ^~~~~~~~~
./include/linux/percpu-defs.h:246:2: note: in expansion of macro =A1__ver=
ify_pcpu_ptr=A2
  __verify_pcpu_ptr(__p);      \
  ^~~~~~~~~~~~~~~~~
./include/linux/percpu-defs.h:250:47: note: in expansion of macro =A1VERI=
FY_PERCPU_PTR=A2
 #define per_cpu_ptr(ptr, cpu) ({ (void)(cpu); VERIFY_PERCPU_PTR(ptr); })
                                               ^~~~~~~~~~~~~~~~~
./include/linux/percpu-defs.h:251:26: note: in expansion of macro =A1per_=
cpu_ptr=A2
 #define raw_cpu_ptr(ptr) per_cpu_ptr(ptr, 0)
                          ^~~~~~~~~~~
./include/asm-generic/percpu.h:123:21: note: in expansion of macro =A1raw=
_cpu_ptr=A2
  __ret =3D READ_ONCE(*raw_cpu_ptr(&(pcp)));   \
                     ^~~~~~~~~~~
./include/asm-generic/percpu.h:142:11: note: in expansion of macro =A1__t=
his_cpu_generic_read_nopreempt=A2
   __ret =3D __this_cpu_generic_read_nopreempt(pcp);  \
           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
./include/asm-generic/percpu.h:333:31: note: in expansion of macro =A1thi=
s_cpu_generic_read=A2
 #define this_cpu_read_8(pcp)  this_cpu_generic_read(pcp)
                               ^~~~~~~~~~~~~~~~~~~~~
./include/linux/percpu-defs.h:311:23: note: in expansion of macro =A1this=
_cpu_read_8=A2
  case 8: pscr_ret__ =3D stem##8(variable); break;   \
                       ^~~~
./include/linux/percpu-defs.h:494:29: note: in expansion of macro =A1__pc=
pu_size_call_return=A2
 #define this_cpu_read(pcp)  __pcpu_size_call_return(this_cpu_read_, pcp)
                             ^~~~~~~~~~~~~~~~~~~~~~~
arch/powerpc/lib/code-patching.c:150:7: note: in expansion of macro =A1th=
is_cpu_read=A2
  if (!this_cpu_read(*PTRRELOC(&text_poke_area)))
       ^~~~~~~~~~~~~
arch/powerpc/lib/code-patching.c:150:21: error: invalid type argument of =
unary =A1*=A2 (have =A1int=A2)
  if (!this_cpu_read(*PTRRELOC(&text_poke_area)))
                     ^~~~~~~~~~~~~~~~~~~~~~~~~~
./include/linux/compiler.h:341:22: note: in definition of macro =A1__READ=
_ONCE=A2
   __read_once_size(&(x), __u.__c, sizeof(x));  \
                      ^
./include/asm-generic/percpu.h:123:10: note: in expansion of macro =A1REA=
D_ONCE=A2
  __ret =3D READ_ONCE(*raw_cpu_ptr(&(pcp)));   \
          ^~~~~~~~~
./include/linux/percpu-defs.h:250:47: note: in expansion of macro =A1VERI=
FY_PERCPU_PTR=A2
 #define per_cpu_ptr(ptr, cpu) ({ (void)(cpu); VERIFY_PERCPU_PTR(ptr); })
                                               ^~~~~~~~~~~~~~~~~
./include/linux/percpu-defs.h:251:26: note: in expansion of macro =A1per_=
cpu_ptr=A2
 #define raw_cpu_ptr(ptr) per_cpu_ptr(ptr, 0)
                          ^~~~~~~~~~~
./include/asm-generic/percpu.h:123:21: note: in expansion of macro =A1raw=
_cpu_ptr=A2
  __ret =3D READ_ONCE(*raw_cpu_ptr(&(pcp)));   \
                     ^~~~~~~~~~~
./include/asm-generic/percpu.h:142:11: note: in expansion of macro =A1__t=
his_cpu_generic_read_nopreempt=A2
   __ret =3D __this_cpu_generic_read_nopreempt(pcp);  \
           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
./include/asm-generic/percpu.h:333:31: note: in expansion of macro =A1thi=
s_cpu_generic_read=A2
 #define this_cpu_read_8(pcp)  this_cpu_generic_read(pcp)
                               ^~~~~~~~~~~~~~~~~~~~~
./include/linux/percpu-defs.h:311:23: note: in expansion of macro =A1this=
_cpu_read_8=A2
  case 8: pscr_ret__ =3D stem##8(variable); break;   \
                       ^~~~
./include/linux/percpu-defs.h:494:29: note: in expansion of macro =A1__pc=
pu_size_call_return=A2
 #define this_cpu_read(pcp)  __pcpu_size_call_return(this_cpu_read_, pcp)
                             ^~~~~~~~~~~~~~~~~~~~~~~
arch/powerpc/lib/code-patching.c:150:7: note: in expansion of macro =A1th=
is_cpu_read=A2
  if (!this_cpu_read(*PTRRELOC(&text_poke_area)))
       ^~~~~~~~~~~~~
arch/powerpc/lib/code-patching.c:150:21: error: invalid type argument of =
unary =A1*=A2 (have =A1int=A2)
  if (!this_cpu_read(*PTRRELOC(&text_poke_area)))
                     ^~~~~~~~~~~~~~~~~~~~~~~~~~
./include/linux/compiler.h:341:22: note: in definition of macro =A1__READ=
_ONCE=A2
   __read_once_size(&(x), __u.__c, sizeof(x));  \
                      ^
./include/asm-generic/percpu.h:123:10: note: in expansion of macro =A1REA=
D_ONCE=A2
  __ret =3D READ_ONCE(*raw_cpu_ptr(&(pcp)));   \
          ^~~~~~~~~
./include/linux/percpu-defs.h:250:47: note: in expansion of macro =A1VERI=
FY_PERCPU_PTR=A2
 #define per_cpu_ptr(ptr, cpu) ({ (void)(cpu); VERIFY_PERCPU_PTR(ptr); })
                                               ^~~~~~~~~~~~~~~~~
./include/linux/percpu-defs.h:251:26: note: in expansion of macro =A1per_=
cpu_ptr=A2
 #define raw_cpu_ptr(ptr) per_cpu_ptr(ptr, 0)
                          ^~~~~~~~~~~
./include/asm-generic/percpu.h:123:21: note: in expansion of macro =A1raw=
_cpu_ptr=A2
  __ret =3D READ_ONCE(*raw_cpu_ptr(&(pcp)));   \
                     ^~~~~~~~~~~
./include/asm-generic/percpu.h:142:11: note: in expansion of macro =A1__t=
his_cpu_generic_read_nopreempt=A2
   __ret =3D __this_cpu_generic_read_nopreempt(pcp);  \
           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
./include/asm-generic/percpu.h:333:31: note: in expansion of macro =A1thi=
s_cpu_generic_read=A2
 #define this_cpu_read_8(pcp)  this_cpu_generic_read(pcp)
                               ^~~~~~~~~~~~~~~~~~~~~
./include/linux/percpu-defs.h:311:23: note: in expansion of macro =A1this=
_cpu_read_8=A2
  case 8: pscr_ret__ =3D stem##8(variable); break;   \
                       ^~~~
./include/linux/percpu-defs.h:494:29: note: in expansion of macro =A1__pc=
pu_size_call_return=A2
 #define this_cpu_read(pcp)  __pcpu_size_call_return(this_cpu_read_, pcp)
                             ^~~~~~~~~~~~~~~~~~~~~~~
arch/powerpc/lib/code-patching.c:150:7: note: in expansion of macro =A1th=
is_cpu_read=A2
  if (!this_cpu_read(*PTRRELOC(&text_poke_area)))
       ^~~~~~~~~~~~~
arch/powerpc/lib/code-patching.c:150:21: error: invalid type argument of =
unary =A1*=A2 (have =A1int=A2)
  if (!this_cpu_read(*PTRRELOC(&text_poke_area)))
                     ^~~~~~~~~~~~~~~~~~~~~~~~~~
./include/linux/compiler.h:341:42: note: in definition of macro =A1__READ=
_ONCE=A2
   __read_once_size(&(x), __u.__c, sizeof(x));  \
                                          ^
./include/asm-generic/percpu.h:123:10: note: in expansion of macro =A1REA=
D_ONCE=A2
  __ret =3D READ_ONCE(*raw_cpu_ptr(&(pcp)));   \
          ^~~~~~~~~
./include/linux/percpu-defs.h:246:2: note: in expansion of macro =A1__ver=
ify_pcpu_ptr=A2
  __verify_pcpu_ptr(__p);      \
  ^~~~~~~~~~~~~~~~~
./include/linux/percpu-defs.h:250:47: note: in expansion of macro =A1VERI=
FY_PERCPU_PTR=A2
 #define per_cpu_ptr(ptr, cpu) ({ (void)(cpu); VERIFY_PERCPU_PTR(ptr); })
                                               ^~~~~~~~~~~~~~~~~
./include/linux/percpu-defs.h:251:26: note: in expansion of macro =A1per_=
cpu_ptr=A2
 #define raw_cpu_ptr(ptr) per_cpu_ptr(ptr, 0)
                          ^~~~~~~~~~~
./include/asm-generic/percpu.h:123:21: note: in expansion of macro =A1raw=
_cpu_ptr=A2
  __ret =3D READ_ONCE(*raw_cpu_ptr(&(pcp)));   \
                     ^~~~~~~~~~~
./include/asm-generic/percpu.h:142:11: note: in expansion of macro =A1__t=
his_cpu_generic_read_nopreempt=A2
   __ret =3D __this_cpu_generic_read_nopreempt(pcp);  \
           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
./include/asm-generic/percpu.h:333:31: note: in expansion of macro =A1thi=
s_cpu_generic_read=A2
 #define this_cpu_read_8(pcp)  this_cpu_generic_read(pcp)
                               ^~~~~~~~~~~~~~~~~~~~~
./include/linux/percpu-defs.h:311:23: note: in expansion of macro =A1this=
_cpu_read_8=A2
  case 8: pscr_ret__ =3D stem##8(variable); break;   \
                       ^~~~
./include/linux/percpu-defs.h:494:29: note: in expansion of macro =A1__pc=
pu_size_call_return=A2
 #define this_cpu_read(pcp)  __pcpu_size_call_return(this_cpu_read_, pcp)
                             ^~~~~~~~~~~~~~~~~~~~~~~
arch/powerpc/lib/code-patching.c:150:7: note: in expansion of macro =A1th=
is_cpu_read=A2
  if (!this_cpu_read(*PTRRELOC(&text_poke_area)))
       ^~~~~~~~~~~~~
arch/powerpc/lib/code-patching.c:150:21: error: invalid type argument of =
unary =A1*=A2 (have =A1int=A2)
  if (!this_cpu_read(*PTRRELOC(&text_poke_area)))
                     ^~~~~~~~~~~~~~~~~~~~~~~~~~
./include/linux/compiler.h:341:42: note: in definition of macro =A1__READ=
_ONCE=A2
   __read_once_size(&(x), __u.__c, sizeof(x));  \
                                          ^
./include/asm-generic/percpu.h:123:10: note: in expansion of macro =A1REA=
D_ONCE=A2
  __ret =3D READ_ONCE(*raw_cpu_ptr(&(pcp)));   \
          ^~~~~~~~~
./include/linux/percpu-defs.h:250:47: note: in expansion of macro =A1VERI=
FY_PERCPU_PTR=A2
 #define per_cpu_ptr(ptr, cpu) ({ (void)(cpu); VERIFY_PERCPU_PTR(ptr); })
                                               ^~~~~~~~~~~~~~~~~
./include/linux/percpu-defs.h:251:26: note: in expansion of macro =A1per_=
cpu_ptr=A2
 #define raw_cpu_ptr(ptr) per_cpu_ptr(ptr, 0)
                          ^~~~~~~~~~~
./include/asm-generic/percpu.h:123:21: note: in expansion of macro =A1raw=
_cpu_ptr=A2
  __ret =3D READ_ONCE(*raw_cpu_ptr(&(pcp)));   \
                     ^~~~~~~~~~~
./include/asm-generic/percpu.h:142:11: note: in expansion of macro =A1__t=
his_cpu_generic_read_nopreempt=A2
   __ret =3D __this_cpu_generic_read_nopreempt(pcp);  \
           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
./include/asm-generic/percpu.h:333:31: note: in expansion of macro =A1thi=
s_cpu_generic_read=A2
 #define this_cpu_read_8(pcp)  this_cpu_generic_read(pcp)
                               ^~~~~~~~~~~~~~~~~~~~~
./include/linux/percpu-defs.h:311:23: note: in expansion of macro =A1this=
_cpu_read_8=A2
  case 8: pscr_ret__ =3D stem##8(variable); break;   \
                       ^~~~
./include/linux/percpu-defs.h:494:29: note: in expansion of macro =A1__pc=
pu_size_call_return=A2
 #define this_cpu_read(pcp)  __pcpu_size_call_return(this_cpu_read_, pcp)
                             ^~~~~~~~~~~~~~~~~~~~~~~
arch/powerpc/lib/code-patching.c:150:7: note: in expansion of macro =A1th=
is_cpu_read=A2
  if (!this_cpu_read(*PTRRELOC(&text_poke_area)))
       ^~~~~~~~~~~~~
arch/powerpc/lib/code-patching.c:150:21: error: invalid type argument of =
unary =A1*=A2 (have =A1int=A2)
  if (!this_cpu_read(*PTRRELOC(&text_poke_area)))
                     ^~~~~~~~~~~~~~~~~~~~~~~~~~
./include/linux/compiler.h:341:42: note: in definition of macro =A1__READ=
_ONCE=A2
   __read_once_size(&(x), __u.__c, sizeof(x));  \
                                          ^
./include/asm-generic/percpu.h:123:10: note: in expansion of macro =A1REA=
D_ONCE=A2
  __ret =3D READ_ONCE(*raw_cpu_ptr(&(pcp)));   \
          ^~~~~~~~~
./include/linux/percpu-defs.h:250:47: note: in expansion of macro =A1VERI=
FY_PERCPU_PTR=A2
 #define per_cpu_ptr(ptr, cpu) ({ (void)(cpu); VERIFY_PERCPU_PTR(ptr); })
                                               ^~~~~~~~~~~~~~~~~
./include/linux/percpu-defs.h:251:26: note: in expansion of macro =A1per_=
cpu_ptr=A2
 #define raw_cpu_ptr(ptr) per_cpu_ptr(ptr, 0)
                          ^~~~~~~~~~~
./include/asm-generic/percpu.h:123:21: note: in expansion of macro =A1raw=
_cpu_ptr=A2
  __ret =3D READ_ONCE(*raw_cpu_ptr(&(pcp)));   \
                     ^~~~~~~~~~~
./include/asm-generic/percpu.h:142:11: note: in expansion of macro =A1__t=
his_cpu_generic_read_nopreempt=A2
   __ret =3D __this_cpu_generic_read_nopreempt(pcp);  \
           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
./include/asm-generic/percpu.h:333:31: note: in expansion of macro =A1thi=
s_cpu_generic_read=A2
 #define this_cpu_read_8(pcp)  this_cpu_generic_read(pcp)
                               ^~~~~~~~~~~~~~~~~~~~~
./include/linux/percpu-defs.h:311:23: note: in expansion of macro =A1this=
_cpu_read_8=A2
  case 8: pscr_ret__ =3D stem##8(variable); break;   \
                       ^~~~
./include/linux/percpu-defs.h:494:29: note: in expansion of macro =A1__pc=
pu_size_call_return=A2
 #define this_cpu_read(pcp)  __pcpu_size_call_return(this_cpu_read_, pcp)
                             ^~~~~~~~~~~~~~~~~~~~~~~
arch/powerpc/lib/code-patching.c:150:7: note: in expansion of macro =A1th=
is_cpu_read=A2
  if (!this_cpu_read(*PTRRELOC(&text_poke_area)))
       ^~~~~~~~~~~~~
arch/powerpc/lib/code-patching.c:150:21: error: invalid type argument of =
unary =A1*=A2 (have =A1int=A2)
  if (!this_cpu_read(*PTRRELOC(&text_poke_area)))
                     ^~~~~~~~~~~~~~~~~~~~~~~~~~
./include/linux/compiler.h:343:30: note: in definition of macro =A1__READ=
_ONCE=A2
   __read_once_size_nocheck(&(x), __u.__c, sizeof(x)); \
                              ^
./include/asm-generic/percpu.h:123:10: note: in expansion of macro =A1REA=
D_ONCE=A2
  __ret =3D READ_ONCE(*raw_cpu_ptr(&(pcp)));   \
          ^~~~~~~~~
./include/linux/percpu-defs.h:246:2: note: in expansion of macro =A1__ver=
ify_pcpu_ptr=A2
  __verify_pcpu_ptr(__p);      \
  ^~~~~~~~~~~~~~~~~
./include/linux/percpu-defs.h:250:47: note: in expansion of macro =A1VERI=
FY_PERCPU_PTR=A2
 #define per_cpu_ptr(ptr, cpu) ({ (void)(cpu); VERIFY_PERCPU_PTR(ptr); })
                                               ^~~~~~~~~~~~~~~~~
./include/linux/percpu-defs.h:251:26: note: in expansion of macro =A1per_=
cpu_ptr=A2
 #define raw_cpu_ptr(ptr) per_cpu_ptr(ptr, 0)
                          ^~~~~~~~~~~
./include/asm-generic/percpu.h:123:21: note: in expansion of macro =A1raw=
_cpu_ptr=A2
  __ret =3D READ_ONCE(*raw_cpu_ptr(&(pcp)));   \
                     ^~~~~~~~~~~
./include/asm-generic/percpu.h:142:11: note: in expansion of macro =A1__t=
his_cpu_generic_read_nopreempt=A2
   __ret =3D __this_cpu_generic_read_nopreempt(pcp);  \
           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
./include/asm-generic/percpu.h:333:31: note: in expansion of macro =A1thi=
s_cpu_generic_read=A2
 #define this_cpu_read_8(pcp)  this_cpu_generic_read(pcp)
                               ^~~~~~~~~~~~~~~~~~~~~
./include/linux/percpu-defs.h:311:23: note: in expansion of macro =A1this=
_cpu_read_8=A2
  case 8: pscr_ret__ =3D stem##8(variable); break;   \
                       ^~~~
./include/linux/percpu-defs.h:494:29: note: in expansion of macro =A1__pc=
pu_size_call_return=A2
 #define this_cpu_read(pcp)  __pcpu_size_call_return(this_cpu_read_, pcp)
                             ^~~~~~~~~~~~~~~~~~~~~~~
arch/powerpc/lib/code-patching.c:150:7: note: in expansion of macro =A1th=
is_cpu_read=A2
  if (!this_cpu_read(*PTRRELOC(&text_poke_area)))
       ^~~~~~~~~~~~~
arch/powerpc/lib/code-patching.c:150:21: error: invalid type argument of =
unary =A1*=A2 (have =A1int=A2)
  if (!this_cpu_read(*PTRRELOC(&text_poke_area)))
                     ^~~~~~~~~~~~~~~~~~~~~~~~~~
./include/linux/compiler.h:343:30: note: in definition of macro =A1__READ=
_ONCE=A2
   __read_once_size_nocheck(&(x), __u.__c, sizeof(x)); \
                              ^
./include/asm-generic/percpu.h:123:10: note: in expansion of macro =A1REA=
D_ONCE=A2
  __ret =3D READ_ONCE(*raw_cpu_ptr(&(pcp)));   \
          ^~~~~~~~~
./include/linux/percpu-defs.h:250:47: note: in expansion of macro =A1VERI=
FY_PERCPU_PTR=A2
 #define per_cpu_ptr(ptr, cpu) ({ (void)(cpu); VERIFY_PERCPU_PTR(ptr); })
                                               ^~~~~~~~~~~~~~~~~
./include/linux/percpu-defs.h:251:26: note: in expansion of macro =A1per_=
cpu_ptr=A2
 #define raw_cpu_ptr(ptr) per_cpu_ptr(ptr, 0)
                          ^~~~~~~~~~~
./include/asm-generic/percpu.h:123:21: note: in expansion of macro =A1raw=
_cpu_ptr=A2
  __ret =3D READ_ONCE(*raw_cpu_ptr(&(pcp)));   \
                     ^~~~~~~~~~~
./include/asm-generic/percpu.h:142:11: note: in expansion of macro =A1__t=
his_cpu_generic_read_nopreempt=A2
   __ret =3D __this_cpu_generic_read_nopreempt(pcp);  \
           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
./include/asm-generic/percpu.h:333:31: note: in expansion of macro =A1thi=
s_cpu_generic_read=A2
 #define this_cpu_read_8(pcp)  this_cpu_generic_read(pcp)
                               ^~~~~~~~~~~~~~~~~~~~~
./include/linux/percpu-defs.h:311:23: note: in expansion of macro =A1this=
_cpu_read_8=A2
  case 8: pscr_ret__ =3D stem##8(variable); break;   \
                       ^~~~
./include/linux/percpu-defs.h:494:29: note: in expansion of macro =A1__pc=
pu_size_call_return=A2
 #define this_cpu_read(pcp)  __pcpu_size_call_return(this_cpu_read_, pcp)
                             ^~~~~~~~~~~~~~~~~~~~~~~
arch/powerpc/lib/code-patching.c:150:7: note: in expansion of macro =A1th=
is_cpu_read=A2
  if (!this_cpu_read(*PTRRELOC(&text_poke_area)))
       ^~~~~~~~~~~~~
arch/powerpc/lib/code-patching.c:150:21: error: invalid type argument of =
unary =A1*=A2 (have =A1int=A2)
  if (!this_cpu_read(*PTRRELOC(&text_poke_area)))
                     ^~~~~~~~~~~~~~~~~~~~~~~~~~
./include/linux/compiler.h:343:30: note: in definition of macro =A1__READ=
_ONCE=A2
   __read_once_size_nocheck(&(x), __u.__c, sizeof(x)); \
                              ^
./include/asm-generic/percpu.h:123:10: note: in expansion of macro =A1REA=
D_ONCE=A2
  __ret =3D READ_ONCE(*raw_cpu_ptr(&(pcp)));   \
          ^~~~~~~~~
./include/linux/percpu-defs.h:250:47: note: in expansion of macro =A1VERI=
FY_PERCPU_PTR=A2
 #define per_cpu_ptr(ptr, cpu) ({ (void)(cpu); VERIFY_PERCPU_PTR(ptr); })
                                               ^~~~~~~~~~~~~~~~~
./include/linux/percpu-defs.h:251:26: note: in expansion of macro =A1per_=
cpu_ptr=A2
 #define raw_cpu_ptr(ptr) per_cpu_ptr(ptr, 0)
                          ^~~~~~~~~~~
./include/asm-generic/percpu.h:123:21: note: in expansion of macro =A1raw=
_cpu_ptr=A2
  __ret =3D READ_ONCE(*raw_cpu_ptr(&(pcp)));   \
                     ^~~~~~~~~~~
./include/asm-generic/percpu.h:142:11: note: in expansion of macro =A1__t=
his_cpu_generic_read_nopreempt=A2
   __ret =3D __this_cpu_generic_read_nopreempt(pcp);  \
           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
./include/asm-generic/percpu.h:333:31: note: in expansion of macro =A1thi=
s_cpu_generic_read=A2
 #define this_cpu_read_8(pcp)  this_cpu_generic_read(pcp)
                               ^~~~~~~~~~~~~~~~~~~~~
./include/linux/percpu-defs.h:311:23: note: in expansion of macro =A1this=
_cpu_read_8=A2
  case 8: pscr_ret__ =3D stem##8(variable); break;   \
                       ^~~~
./include/linux/percpu-defs.h:494:29: note: in expansion of macro =A1__pc=
pu_size_call_return=A2
 #define this_cpu_read(pcp)  __pcpu_size_call_return(this_cpu_read_, pcp)
                             ^~~~~~~~~~~~~~~~~~~~~~~
arch/powerpc/lib/code-patching.c:150:7: note: in expansion of macro =A1th=
is_cpu_read=A2
  if (!this_cpu_read(*PTRRELOC(&text_poke_area)))
       ^~~~~~~~~~~~~
arch/powerpc/lib/code-patching.c:150:21: error: invalid type argument of =
unary =A1*=A2 (have =A1int=A2)
  if (!this_cpu_read(*PTRRELOC(&text_poke_area)))
                     ^~~~~~~~~~~~~~~~~~~~~~~~~~
./include/linux/compiler.h:343:50: note: in definition of macro =A1__READ=
_ONCE=A2
   __read_once_size_nocheck(&(x), __u.__c, sizeof(x)); \
                                                  ^
./include/asm-generic/percpu.h:123:10: note: in expansion of macro =A1REA=
D_ONCE=A2
  __ret =3D READ_ONCE(*raw_cpu_ptr(&(pcp)));   \
          ^~~~~~~~~
./include/linux/percpu-defs.h:246:2: note: in expansion of macro =A1__ver=
ify_pcpu_ptr=A2
  __verify_pcpu_ptr(__p);      \
  ^~~~~~~~~~~~~~~~~
./include/linux/percpu-defs.h:250:47: note: in expansion of macro =A1VERI=
FY_PERCPU_PTR=A2
 #define per_cpu_ptr(ptr, cpu) ({ (void)(cpu); VERIFY_PERCPU_PTR(ptr); })
                                               ^~~~~~~~~~~~~~~~~
./include/linux/percpu-defs.h:251:26: note: in expansion of macro =A1per_=
cpu_ptr=A2
 #define raw_cpu_ptr(ptr) per_cpu_ptr(ptr, 0)
                          ^~~~~~~~~~~
./include/asm-generic/percpu.h:123:21: note: in expansion of macro =A1raw=
_cpu_ptr=A2
  __ret =3D READ_ONCE(*raw_cpu_ptr(&(pcp)));   \
                     ^~~~~~~~~~~
./include/asm-generic/percpu.h:142:11: note: in expansion of macro =A1__t=
his_cpu_generic_read_nopreempt=A2
   __ret =3D __this_cpu_generic_read_nopreempt(pcp);  \
           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
./include/asm-generic/percpu.h:333:31: note: in expansion of macro =A1thi=
s_cpu_generic_read=A2
 #define this_cpu_read_8(pcp)  this_cpu_generic_read(pcp)
                               ^~~~~~~~~~~~~~~~~~~~~
./include/linux/percpu-defs.h:311:23: note: in expansion of macro =A1this=
_cpu_read_8=A2
  case 8: pscr_ret__ =3D stem##8(variable); break;   \
                       ^~~~
./include/linux/percpu-defs.h:494:29: note: in expansion of macro =A1__pc=
pu_size_call_return=A2
 #define this_cpu_read(pcp)  __pcpu_size_call_return(this_cpu_read_, pcp)
                             ^~~~~~~~~~~~~~~~~~~~~~~
arch/powerpc/lib/code-patching.c:150:7: note: in expansion of macro =A1th=
is_cpu_read=A2
  if (!this_cpu_read(*PTRRELOC(&text_poke_area)))
       ^~~~~~~~~~~~~
arch/powerpc/lib/code-patching.c:150:21: error: invalid type argument of =
unary =A1*=A2 (have =A1int=A2)
  if (!this_cpu_read(*PTRRELOC(&text_poke_area)))
                     ^~~~~~~~~~~~~~~~~~~~~~~~~~
./include/linux/compiler.h:343:50: note: in definition of macro =A1__READ=
_ONCE=A2
   __read_once_size_nocheck(&(x), __u.__c, sizeof(x)); \
                                                  ^
./include/asm-generic/percpu.h:123:10: note: in expansion of macro =A1REA=
D_ONCE=A2
  __ret =3D READ_ONCE(*raw_cpu_ptr(&(pcp)));   \
          ^~~~~~~~~
./include/linux/percpu-defs.h:250:47: note: in expansion of macro =A1VERI=
FY_PERCPU_PTR=A2
 #define per_cpu_ptr(ptr, cpu) ({ (void)(cpu); VERIFY_PERCPU_PTR(ptr); })
                                               ^~~~~~~~~~~~~~~~~
./include/linux/percpu-defs.h:251:26: note: in expansion of macro =A1per_=
cpu_ptr=A2
 #define raw_cpu_ptr(ptr) per_cpu_ptr(ptr, 0)
                          ^~~~~~~~~~~
./include/asm-generic/percpu.h:123:21: note: in expansion of macro =A1raw=
_cpu_ptr=A2
  __ret =3D READ_ONCE(*raw_cpu_ptr(&(pcp)));   \
                     ^~~~~~~~~~~
./include/asm-generic/percpu.h:142:11: note: in expansion of macro =A1__t=
his_cpu_generic_read_nopreempt=A2
   __ret =3D __this_cpu_generic_read_nopreempt(pcp);  \
           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
./include/asm-generic/percpu.h:333:31: note: in expansion of macro =A1thi=
s_cpu_generic_read=A2
 #define this_cpu_read_8(pcp)  this_cpu_generic_read(pcp)
                               ^~~~~~~~~~~~~~~~~~~~~
./include/linux/percpu-defs.h:311:23: note: in expansion of macro =A1this=
_cpu_read_8=A2
  case 8: pscr_ret__ =3D stem##8(variable); break;   \
                       ^~~~
./include/linux/percpu-defs.h:494:29: note: in expansion of macro =A1__pc=
pu_size_call_return=A2
 #define this_cpu_read(pcp)  __pcpu_size_call_return(this_cpu_read_, pcp)
                             ^~~~~~~~~~~~~~~~~~~~~~~
arch/powerpc/lib/code-patching.c:150:7: note: in expansion of macro =A1th=
is_cpu_read=A2
  if (!this_cpu_read(*PTRRELOC(&text_poke_area)))
       ^~~~~~~~~~~~~
arch/powerpc/lib/code-patching.c:150:21: error: invalid type argument of =
unary =A1*=A2 (have =A1int=A2)
  if (!this_cpu_read(*PTRRELOC(&text_poke_area)))
                     ^~~~~~~~~~~~~~~~~~~~~~~~~~
./include/linux/compiler.h:343:50: note: in definition of macro =A1__READ=
_ONCE=A2
   __read_once_size_nocheck(&(x), __u.__c, sizeof(x)); \
                                                  ^
./include/asm-generic/percpu.h:123:10: note: in expansion of macro =A1REA=
D_ONCE=A2
  __ret =3D READ_ONCE(*raw_cpu_ptr(&(pcp)));   \
          ^~~~~~~~~
./include/linux/percpu-defs.h:250:47: note: in expansion of macro =A1VERI=
FY_PERCPU_PTR=A2
 #define per_cpu_ptr(ptr, cpu) ({ (void)(cpu); VERIFY_PERCPU_PTR(ptr); })
                                               ^~~~~~~~~~~~~~~~~
./include/linux/percpu-defs.h:251:26: note: in expansion of macro =A1per_=
cpu_ptr=A2
 #define raw_cpu_ptr(ptr) per_cpu_ptr(ptr, 0)
                          ^~~~~~~~~~~
./include/asm-generic/percpu.h:123:21: note: in expansion of macro =A1raw=
_cpu_ptr=A2
  __ret =3D READ_ONCE(*raw_cpu_ptr(&(pcp)));   \
                     ^~~~~~~~~~~
./include/asm-generic/percpu.h:142:11: note: in expansion of macro =A1__t=
his_cpu_generic_read_nopreempt=A2
   __ret =3D __this_cpu_generic_read_nopreempt(pcp);  \
           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
./include/asm-generic/percpu.h:333:31: note: in expansion of macro =A1thi=
s_cpu_generic_read=A2
 #define this_cpu_read_8(pcp)  this_cpu_generic_read(pcp)
                               ^~~~~~~~~~~~~~~~~~~~~
./include/linux/percpu-defs.h:311:23: note: in expansion of macro =A1this=
_cpu_read_8=A2
  case 8: pscr_ret__ =3D stem##8(variable); break;   \
                       ^~~~
./include/linux/percpu-defs.h:494:29: note: in expansion of macro =A1__pc=
pu_size_call_return=A2
 #define this_cpu_read(pcp)  __pcpu_size_call_return(this_cpu_read_, pcp)
                             ^~~~~~~~~~~~~~~~~~~~~~~
arch/powerpc/lib/code-patching.c:150:7: note: in expansion of macro =A1th=
is_cpu_read=A2
  if (!this_cpu_read(*PTRRELOC(&text_poke_area)))
       ^~~~~~~~~~~~~
In file included from ./arch/powerpc/include/asm/percpu.h:20:0,
                 from ./include/linux/percpu.h:13,
                 from ./include/linux/kprobes.h:38,
                 from arch/powerpc/lib/code-patching.c:11:
arch/powerpc/lib/code-patching.c:150:21: error: invalid type argument of =
unary =A1*=A2 (have =A1int=A2)
  if (!this_cpu_read(*PTRRELOC(&text_poke_area)))
                     ^~~~~~~~~~~~~~~~~~~~~~~~~~
./include/asm-generic/percpu.h:130:9: note: in definition of macro =A1__t=
his_cpu_generic_read_noirq=A2
  typeof(pcp) __ret;      \
         ^~~
./include/asm-generic/percpu.h:333:31: note: in expansion of macro =A1thi=
s_cpu_generic_read=A2
 #define this_cpu_read_8(pcp)  this_cpu_generic_read(pcp)
                               ^~~~~~~~~~~~~~~~~~~~~
./include/linux/percpu-defs.h:311:23: note: in expansion of macro =A1this=
_cpu_read_8=A2
  case 8: pscr_ret__ =3D stem##8(variable); break;   \
                       ^~~~
./include/linux/percpu-defs.h:494:29: note: in expansion of macro =A1__pc=
pu_size_call_return=A2
 #define this_cpu_read(pcp)  __pcpu_size_call_return(this_cpu_read_, pcp)
                             ^~~~~~~~~~~~~~~~~~~~~~~
arch/powerpc/lib/code-patching.c:150:7: note: in expansion of macro =A1th=
is_cpu_read=A2
  if (!this_cpu_read(*PTRRELOC(&text_poke_area)))
       ^~~~~~~~~~~~~
In file included from ./include/asm-generic/percpu.h:7:0,
                 from ./arch/powerpc/include/asm/percpu.h:20,
                 from ./include/linux/percpu.h:13,
                 from ./include/linux/kprobes.h:38,
                 from arch/powerpc/lib/code-patching.c:11:
arch/powerpc/lib/code-patching.c:150:21: error: invalid type argument of =
unary =A1*=A2 (have =A1int=A2)
  if (!this_cpu_read(*PTRRELOC(&text_poke_area)))
                     ^~~~~~~~~~~~~~~~~~~~~~~~~~
./include/linux/percpu-defs.h:206:47: note: in definition of macro =A1__v=
erify_pcpu_ptr=A2
  const void __percpu *__vpp_verify =3D (typeof((ptr) + 0))NULL; \
                                               ^~~
./include/linux/percpu-defs.h:250:47: note: in expansion of macro =A1VERI=
FY_PERCPU_PTR=A2
 #define per_cpu_ptr(ptr, cpu) ({ (void)(cpu); VERIFY_PERCPU_PTR(ptr); })
                                               ^~~~~~~~~~~~~~~~~
./include/linux/percpu-defs.h:251:26: note: in expansion of macro =A1per_=
cpu_ptr=A2
 #define raw_cpu_ptr(ptr) per_cpu_ptr(ptr, 0)
                          ^~~~~~~~~~~
./include/asm-generic/percpu.h:71:3: note: in expansion of macro =A1raw_c=
pu_ptr=A2
  *raw_cpu_ptr(&(pcp));      \
   ^~~~~~~~~~~
./include/asm-generic/percpu.h:133:10: note: in expansion of macro =A1raw=
_cpu_generic_read=A2
  __ret =3D raw_cpu_generic_read(pcp);    \
          ^~~~~~~~~~~~~~~~~~~~
./include/asm-generic/percpu.h:144:11: note: in expansion of macro =A1__t=
his_cpu_generic_read_noirq=A2
   __ret =3D __this_cpu_generic_read_noirq(pcp);  \
           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
./include/asm-generic/percpu.h:333:31: note: in expansion of macro =A1thi=
s_cpu_generic_read=A2
 #define this_cpu_read_8(pcp)  this_cpu_generic_read(pcp)
                               ^~~~~~~~~~~~~~~~~~~~~
./include/linux/percpu-defs.h:311:23: note: in expansion of macro =A1this=
_cpu_read_8=A2
  case 8: pscr_ret__ =3D stem##8(variable); break;   \
                       ^~~~
./include/linux/percpu-defs.h:494:29: note: in expansion of macro =A1__pc=
pu_size_call_return=A2
 #define this_cpu_read(pcp)  __pcpu_size_call_return(this_cpu_read_, pcp)
                             ^~~~~~~~~~~~~~~~~~~~~~~
arch/powerpc/lib/code-patching.c:150:7: note: in expansion of macro =A1th=
is_cpu_read=A2
  if (!this_cpu_read(*PTRRELOC(&text_poke_area)))
       ^~~~~~~~~~~~~
arch/powerpc/lib/code-patching.c:150:21: error: invalid type argument of =
unary =A1*=A2 (have =A1int=A2)
  if (!this_cpu_read(*PTRRELOC(&text_poke_area)))
                     ^~~~~~~~~~~~~~~~~~~~~~~~~~
./include/linux/percpu-defs.h:247:12: note: in definition of macro =A1VER=
IFY_PERCPU_PTR=A2
  (typeof(*(__p)) __kernel __force *)(__p);   \
            ^~~
./include/linux/percpu-defs.h:251:26: note: in expansion of macro =A1per_=
cpu_ptr=A2
 #define raw_cpu_ptr(ptr) per_cpu_ptr(ptr, 0)
                          ^~~~~~~~~~~
./include/asm-generic/percpu.h:71:3: note: in expansion of macro =A1raw_c=
pu_ptr=A2
  *raw_cpu_ptr(&(pcp));      \
   ^~~~~~~~~~~
./include/asm-generic/percpu.h:133:10: note: in expansion of macro =A1raw=
_cpu_generic_read=A2
  __ret =3D raw_cpu_generic_read(pcp);    \
          ^~~~~~~~~~~~~~~~~~~~
./include/asm-generic/percpu.h:144:11: note: in expansion of macro =A1__t=
his_cpu_generic_read_noirq=A2
   __ret =3D __this_cpu_generic_read_noirq(pcp);  \
           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
./include/asm-generic/percpu.h:333:31: note: in expansion of macro =A1thi=
s_cpu_generic_read=A2
 #define this_cpu_read_8(pcp)  this_cpu_generic_read(pcp)
                               ^~~~~~~~~~~~~~~~~~~~~
./include/linux/percpu-defs.h:311:23: note: in expansion of macro =A1this=
_cpu_read_8=A2
  case 8: pscr_ret__ =3D stem##8(variable); break;   \
                       ^~~~
./include/linux/percpu-defs.h:494:29: note: in expansion of macro =A1__pc=
pu_size_call_return=A2
 #define this_cpu_read(pcp)  __pcpu_size_call_return(this_cpu_read_, pcp)
                             ^~~~~~~~~~~~~~~~~~~~~~~
arch/powerpc/lib/code-patching.c:150:7: note: in expansion of macro =A1th=
is_cpu_read=A2
  if (!this_cpu_read(*PTRRELOC(&text_poke_area)))
       ^~~~~~~~~~~~~
arch/powerpc/lib/code-patching.c:150:21: error: invalid type argument of =
unary =A1*=A2 (have =A1int=A2)
  if (!this_cpu_read(*PTRRELOC(&text_poke_area)))
                     ^~~~~~~~~~~~~~~~~~~~~~~~~~
./include/linux/percpu-defs.h:247:38: note: in definition of macro =A1VER=
IFY_PERCPU_PTR=A2
  (typeof(*(__p)) __kernel __force *)(__p);   \
                                      ^~~
./include/linux/percpu-defs.h:251:26: note: in expansion of macro =A1per_=
cpu_ptr=A2
 #define raw_cpu_ptr(ptr) per_cpu_ptr(ptr, 0)
                          ^~~~~~~~~~~
./include/asm-generic/percpu.h:71:3: note: in expansion of macro =A1raw_c=
pu_ptr=A2
  *raw_cpu_ptr(&(pcp));      \
   ^~~~~~~~~~~
./include/asm-generic/percpu.h:133:10: note: in expansion of macro =A1raw=
_cpu_generic_read=A2
  __ret =3D raw_cpu_generic_read(pcp);    \
          ^~~~~~~~~~~~~~~~~~~~
./include/asm-generic/percpu.h:144:11: note: in expansion of macro =A1__t=
his_cpu_generic_read_noirq=A2
   __ret =3D __this_cpu_generic_read_noirq(pcp);  \
           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
./include/asm-generic/percpu.h:333:31: note: in expansion of macro =A1thi=
s_cpu_generic_read=A2
 #define this_cpu_read_8(pcp)  this_cpu_generic_read(pcp)
                               ^~~~~~~~~~~~~~~~~~~~~
./include/linux/percpu-defs.h:311:23: note: in expansion of macro =A1this=
_cpu_read_8=A2
  case 8: pscr_ret__ =3D stem##8(variable); break;   \
                       ^~~~
./include/linux/percpu-defs.h:494:29: note: in expansion of macro =A1__pc=
pu_size_call_return=A2
 #define this_cpu_read(pcp)  __pcpu_size_call_return(this_cpu_read_, pcp)
                             ^~~~~~~~~~~~~~~~~~~~~~~
arch/powerpc/lib/code-patching.c:150:7: note: in expansion of macro =A1th=
is_cpu_read=A2
  if (!this_cpu_read(*PTRRELOC(&text_poke_area)))
       ^~~~~~~~~~~~~
cc1: all warnings being treated as errors
scripts/Makefile.build:314: recipe for target 'arch/powerpc/lib/code-patc=
hing.o' failed
make[1]: *** [arch/powerpc/lib/code-patching.o] Error 1
Makefile:1024: recipe for target 'arch/powerpc/lib' failed
make: *** [arch/powerpc/lib] Error 2

--=20
Meelis Roos (mroos@linux.ee)
