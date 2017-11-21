Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yh1Tk6LX5zDrRY
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Nov 2017 21:07:06 +1100 (AEDT)
Subject: Re: [PATCH] powerpc: fix boot on BOOK3S_32 with
 CONFIG_STRICT_KERNEL_RWX
To: Meelis Roos <mroos@linux.ee>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Scott Wood <oss@buserror.net>, Balbir Singh <bsingharora@gmail.com>,
 Linux Kernel list <linux-kernel@vger.kernel.org>,
 linuxppc-dev@lists.ozlabs.org
References: <20171121094816.5EEC2687C5@po15668-vm-win7.idsi0.si.c-s.fr>
 <alpine.LRH.2.21.1711211202460.30004@math.ut.ee>
From: Christophe LEROY <christophe.leroy@c-s.fr>
Message-ID: <6962f873-b94e-e0a3-62e9-f11ea1303584@c-s.fr>
Date: Tue, 21 Nov 2017 11:07:01 +0100
MIME-Version: 1.0
In-Reply-To: <alpine.LRH.2.21.1711211202460.30004@math.ut.ee>
Content-Type: text/plain; charset=UTF-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


Le 21/11/2017 à 11:03, Meelis Roos a écrit :
>> On powerpc32, patch_instruction() is called by apply_feature_fixups()
>> which is called from early_init()
>>
>> There is the following note in front of early_init():
>>   * Note that the kernel may be running at an address which is different
>>   * from the address that it was linked at, so we must use RELOC/PTRRELOC
>>   * to access static data (including strings).  -- paulus
>>
>> Therefore, slab_is_available() cannot be called yet, and
>> text_poke_area must be addressed with PTRRELOC()
> 
> The patch does not build - does PTRRELOC need some additional header or
> something?

Oops, asm/setup.h is needed, don't know why it disappeared from the PATCH.
I'll submit a v2 once you have been able to test it.

Christophe


> 
>    CHK     include/config/kernel.release
>    CHK     include/generated/uapi/linux/version.h
>    CHK     include/generated/utsrelease.h
>    CHK     include/generated/bounds.h
>    CHK     include/generated/timeconst.h
>    CHK     include/generated/asm-offsets.h
>    CALL    scripts/checksyscalls.sh
>    CHK     scripts/mod/devicetable-offsets.h
>    CHK     include/generated/compile.h
>    CALL    arch/powerpc/kernel/systbl_chk.sh
>    CALL    arch/powerpc/kernel/prom_init_check.sh
>    CC      arch/powerpc/lib/code-patching.o
> In file included from ./include/asm-generic/percpu.h:7:0,
>                   from ./arch/powerpc/include/asm/percpu.h:20,
>                   from ./include/linux/percpu.h:13,
>                   from ./include/linux/kprobes.h:38,
>                   from arch/powerpc/lib/code-patching.c:11:
> arch/powerpc/lib/code-patching.c: In function ‘patch_instruction’:
> arch/powerpc/lib/code-patching.c:150:22: error: implicit declaration of function ‘PTRRELOC’; did you mean ‘PTR_ERR’? [-Werror=implicit-function-declaration]
>    if (!this_cpu_read(*PTRRELOC(&text_poke_area)))
>                        ^
> ./include/linux/percpu-defs.h:305:9: note: in definition of macro ‘__pcpu_size_call_return’
>    typeof(variable) pscr_ret__;     \
>           ^~~~~~~~
> arch/powerpc/lib/code-patching.c:150:7: note: in expansion of macro ‘this_cpu_read’
>    if (!this_cpu_read(*PTRRELOC(&text_poke_area)))
>         ^~~~~~~~~~~~~
> arch/powerpc/lib/code-patching.c:150:21: error: invalid type argument of unary ‘*’ (have ‘int’)
>    if (!this_cpu_read(*PTRRELOC(&text_poke_area)))
>                       ^~~~~~~~~~~~~~~~~~~~~~~~~~
> ./include/linux/percpu-defs.h:305:9: note: in definition of macro ‘__pcpu_size_call_return’
>    typeof(variable) pscr_ret__;     \
>           ^~~~~~~~
> arch/powerpc/lib/code-patching.c:150:7: note: in expansion of macro ‘this_cpu_read’
>    if (!this_cpu_read(*PTRRELOC(&text_poke_area)))
>         ^~~~~~~~~~~~~
> arch/powerpc/lib/code-patching.c:150:21: error: invalid type argument of unary ‘*’ (have ‘int’)
>    if (!this_cpu_read(*PTRRELOC(&text_poke_area)))
>                       ^~~~~~~~~~~~~~~~~~~~~~~~~~
> ./include/linux/percpu-defs.h:206:47: note: in definition of macro ‘__verify_pcpu_ptr’
>    const void __percpu *__vpp_verify = (typeof((ptr) + 0))NULL; \
>                                                 ^~~
> ./include/linux/percpu-defs.h:494:29: note: in expansion of macro ‘__pcpu_size_call_return’
>   #define this_cpu_read(pcp)  __pcpu_size_call_return(this_cpu_read_, pcp)
>                               ^~~~~~~~~~~~~~~~~~~~~~~
> arch/powerpc/lib/code-patching.c:150:7: note: in expansion of macro ‘this_cpu_read’
>    if (!this_cpu_read(*PTRRELOC(&text_poke_area)))
>         ^~~~~~~~~~~~~
> arch/powerpc/lib/code-patching.c:150:21: error: invalid type argument of unary ‘*’ (have ‘int’)
>    if (!this_cpu_read(*PTRRELOC(&text_poke_area)))
>                       ^~~~~~~~~~~~~~~~~~~~~~~~~~
> ./include/linux/percpu-defs.h:307:16: note: in definition of macro ‘__pcpu_size_call_return’
>    switch(sizeof(variable)) {     \
>                  ^~~~~~~~
> arch/powerpc/lib/code-patching.c:150:7: note: in expansion of macro ‘this_cpu_read’
>    if (!this_cpu_read(*PTRRELOC(&text_poke_area)))
>         ^~~~~~~~~~~~~
> In file included from ./arch/powerpc/include/asm/percpu.h:20:0,
>                   from ./include/linux/percpu.h:13,
>                   from ./include/linux/kprobes.h:38,
>                   from arch/powerpc/lib/code-patching.c:11:
> arch/powerpc/lib/code-patching.c:150:21: error: invalid type argument of unary ‘*’ (have ‘int’)
>    if (!this_cpu_read(*PTRRELOC(&text_poke_area)))
>                       ^~~~~~~~~~~~~~~~~~~~~~~~~~
> ./include/asm-generic/percpu.h:140:9: note: in definition of macro ‘this_cpu_generic_read’
>    typeof(pcp) __ret;      \
>           ^~~
> ./include/linux/percpu-defs.h:308:23: note: in expansion of macro ‘this_cpu_read_1’
>    case 1: pscr_ret__ = stem##1(variable); break;   \
>                         ^~~~
> ./include/linux/percpu-defs.h:494:29: note: in expansion of macro ‘__pcpu_size_call_return’
>   #define this_cpu_read(pcp)  __pcpu_size_call_return(this_cpu_read_, pcp)
>                               ^~~~~~~~~~~~~~~~~~~~~~~
> arch/powerpc/lib/code-patching.c:150:7: note: in expansion of macro ‘this_cpu_read’
>    if (!this_cpu_read(*PTRRELOC(&text_poke_area)))
>         ^~~~~~~~~~~~~
> In file included from ./include/linux/linkage.h:5:0,
>                   from ./include/linux/kernel.h:7,
>                   from arch/powerpc/lib/code-patching.c:10:
> arch/powerpc/lib/code-patching.c:150:21: error: invalid type argument of unary ‘*’ (have ‘int’)
>    if (!this_cpu_read(*PTRRELOC(&text_poke_area)))
>                       ^~~~~~~~~~~~~~~~~~~~~~~~~~
> ./include/linux/compiler.h:524:35: note: in definition of macro ‘__native_word’
>   # define __native_word(t) (sizeof(t) == sizeof(char) || sizeof(t) == sizeof(short) || sizeof(t) == sizeof(int) || sizeof(t) == sizeof(long))
>                                     ^
> ./include/asm-generic/percpu.h:324:31: note: in expansion of macro ‘this_cpu_generic_read’
>   #define this_cpu_read_1(pcp)  this_cpu_generic_read(pcp)
>                                 ^~~~~~~~~~~~~~~~~~~~~
> ./include/linux/percpu-defs.h:308:23: note: in expansion of macro ‘this_cpu_read_1’
>    case 1: pscr_ret__ = stem##1(variable); break;   \
>                         ^~~~
> ./include/linux/percpu-defs.h:494:29: note: in expansion of macro ‘__pcpu_size_call_return’
>   #define this_cpu_read(pcp)  __pcpu_size_call_return(this_cpu_read_, pcp)
>                               ^~~~~~~~~~~~~~~~~~~~~~~
> arch/powerpc/lib/code-patching.c:150:7: note: in expansion of macro ‘this_cpu_read’
>    if (!this_cpu_read(*PTRRELOC(&text_poke_area)))
>         ^~~~~~~~~~~~~
> arch/powerpc/lib/code-patching.c:150:21: error: invalid type argument of unary ‘*’ (have ‘int’)
>    if (!this_cpu_read(*PTRRELOC(&text_poke_area)))
>                       ^~~~~~~~~~~~~~~~~~~~~~~~~~
> ./include/linux/compiler.h:524:64: note: in definition of macro ‘__native_word’
>   # define __native_word(t) (sizeof(t) == sizeof(char) || sizeof(t) == sizeof(short) || sizeof(t) == sizeof(int) || sizeof(t) == sizeof(long))
>                                                                  ^
> ./include/asm-generic/percpu.h:324:31: note: in expansion of macro ‘this_cpu_generic_read’
>   #define this_cpu_read_1(pcp)  this_cpu_generic_read(pcp)
>                                 ^~~~~~~~~~~~~~~~~~~~~
> ./include/linux/percpu-defs.h:308:23: note: in expansion of macro ‘this_cpu_read_1’
>    case 1: pscr_ret__ = stem##1(variable); break;   \
>                         ^~~~
> ./include/linux/percpu-defs.h:494:29: note: in expansion of macro ‘__pcpu_size_call_return’
>   #define this_cpu_read(pcp)  __pcpu_size_call_return(this_cpu_read_, pcp)
>                               ^~~~~~~~~~~~~~~~~~~~~~~
> arch/powerpc/lib/code-patching.c:150:7: note: in expansion of macro ‘this_cpu_read’
>    if (!this_cpu_read(*PTRRELOC(&text_poke_area)))
>         ^~~~~~~~~~~~~
> arch/powerpc/lib/code-patching.c:150:21: error: invalid type argument of unary ‘*’ (have ‘int’)
>    if (!this_cpu_read(*PTRRELOC(&text_poke_area)))
>                       ^~~~~~~~~~~~~~~~~~~~~~~~~~
> ./include/linux/compiler.h:524:94: note: in definition of macro ‘__native_word’
>   # define __native_word(t) (sizeof(t) == sizeof(char) || sizeof(t) == sizeof(short) || sizeof(t) == sizeof(int) || sizeof(t) == sizeof(long))
>                                                                                                ^
> ./include/asm-generic/percpu.h:324:31: note: in expansion of macro ‘this_cpu_generic_read’
>   #define this_cpu_read_1(pcp)  this_cpu_generic_read(pcp)
>                                 ^~~~~~~~~~~~~~~~~~~~~
> ./include/linux/percpu-defs.h:308:23: note: in expansion of macro ‘this_cpu_read_1’
>    case 1: pscr_ret__ = stem##1(variable); break;   \
>                         ^~~~
> ./include/linux/percpu-defs.h:494:29: note: in expansion of macro ‘__pcpu_size_call_return’
>   #define this_cpu_read(pcp)  __pcpu_size_call_return(this_cpu_read_, pcp)
>                               ^~~~~~~~~~~~~~~~~~~~~~~
> arch/powerpc/lib/code-patching.c:150:7: note: in expansion of macro ‘this_cpu_read’
>    if (!this_cpu_read(*PTRRELOC(&text_poke_area)))
>         ^~~~~~~~~~~~~
> arch/powerpc/lib/code-patching.c:150:21: error: invalid type argument of unary ‘*’ (have ‘int’)
>    if (!this_cpu_read(*PTRRELOC(&text_poke_area)))
>                       ^~~~~~~~~~~~~~~~~~~~~~~~~~
> ./include/linux/compiler.h:524:122: note: in definition of macro ‘__native_word’
>   # define __native_word(t) (sizeof(t) == sizeof(char) || sizeof(t) == sizeof(short) || sizeof(t) == sizeof(int) || sizeof(t) == sizeof(long))
>                                                                                                                            ^
> ./include/asm-generic/percpu.h:324:31: note: in expansion of macro ‘this_cpu_generic_read’
>   #define this_cpu_read_1(pcp)  this_cpu_generic_read(pcp)
>                                 ^~~~~~~~~~~~~~~~~~~~~
> ./include/linux/percpu-defs.h:308:23: note: in expansion of macro ‘this_cpu_read_1’
>    case 1: pscr_ret__ = stem##1(variable); break;   \
>                         ^~~~
> ./include/linux/percpu-defs.h:494:29: note: in expansion of macro ‘__pcpu_size_call_return’
>   #define this_cpu_read(pcp)  __pcpu_size_call_return(this_cpu_read_, pcp)
>                               ^~~~~~~~~~~~~~~~~~~~~~~
> arch/powerpc/lib/code-patching.c:150:7: note: in expansion of macro ‘this_cpu_read’
>    if (!this_cpu_read(*PTRRELOC(&text_poke_area)))
>         ^~~~~~~~~~~~~
> In file included from ./arch/powerpc/include/asm/percpu.h:20:0,
>                   from ./include/linux/percpu.h:13,
>                   from ./include/linux/kprobes.h:38,
>                   from arch/powerpc/lib/code-patching.c:11:
> arch/powerpc/lib/code-patching.c:150:21: error: invalid type argument of unary ‘*’ (have ‘int’)
>    if (!this_cpu_read(*PTRRELOC(&text_poke_area)))
>                       ^~~~~~~~~~~~~~~~~~~~~~~~~~
> ./include/asm-generic/percpu.h:121:9: note: in definition of macro ‘__this_cpu_generic_read_nopreempt’
>    typeof(pcp) __ret;      \
>           ^~~
> ./include/asm-generic/percpu.h:324:31: note: in expansion of macro ‘this_cpu_generic_read’
>   #define this_cpu_read_1(pcp)  this_cpu_generic_read(pcp)
>                                 ^~~~~~~~~~~~~~~~~~~~~
> ./include/linux/percpu-defs.h:308:23: note: in expansion of macro ‘this_cpu_read_1’
>    case 1: pscr_ret__ = stem##1(variable); break;   \
>                         ^~~~
> ./include/linux/percpu-defs.h:494:29: note: in expansion of macro ‘__pcpu_size_call_return’
>   #define this_cpu_read(pcp)  __pcpu_size_call_return(this_cpu_read_, pcp)
>                               ^~~~~~~~~~~~~~~~~~~~~~~
> arch/powerpc/lib/code-patching.c:150:7: note: in expansion of macro ‘this_cpu_read’
>    if (!this_cpu_read(*PTRRELOC(&text_poke_area)))
>         ^~~~~~~~~~~~~
> In file included from ./include/linux/linkage.h:5:0,
>                   from ./include/linux/kernel.h:7,
>                   from arch/powerpc/lib/code-patching.c:10:
> arch/powerpc/lib/code-patching.c:150:21: error: invalid type argument of unary ‘*’ (have ‘int’)
>    if (!this_cpu_read(*PTRRELOC(&text_poke_area)))
>                       ^~~~~~~~~~~~~~~~~~~~~~~~~~
> ./include/linux/compiler.h:339:17: note: in definition of macro ‘__READ_ONCE’
>    union { typeof(x) __val; char __c[1]; } __u;   \
>                   ^
> ./include/asm-generic/percpu.h:123:10: note: in expansion of macro ‘READ_ONCE’
>    __ret = READ_ONCE(*raw_cpu_ptr(&(pcp)));   \
>            ^~~~~~~~~
> ./include/linux/percpu-defs.h:246:2: note: in expansion of macro ‘__verify_pcpu_ptr’
>    __verify_pcpu_ptr(__p);      \
>    ^~~~~~~~~~~~~~~~~
> ./include/linux/percpu-defs.h:250:47: note: in expansion of macro ‘VERIFY_PERCPU_PTR’
>   #define per_cpu_ptr(ptr, cpu) ({ (void)(cpu); VERIFY_PERCPU_PTR(ptr); })
>                                                 ^~~~~~~~~~~~~~~~~
> ./include/linux/percpu-defs.h:251:26: note: in expansion of macro ‘per_cpu_ptr’
>   #define raw_cpu_ptr(ptr) per_cpu_ptr(ptr, 0)
>                            ^~~~~~~~~~~
> ./include/asm-generic/percpu.h:123:21: note: in expansion of macro ‘raw_cpu_ptr’
>    __ret = READ_ONCE(*raw_cpu_ptr(&(pcp)));   \
>                       ^~~~~~~~~~~
> ./include/asm-generic/percpu.h:142:11: note: in expansion of macro ‘__this_cpu_generic_read_nopreempt’
>     __ret = __this_cpu_generic_read_nopreempt(pcp);  \
>             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> ./include/asm-generic/percpu.h:324:31: note: in expansion of macro ‘this_cpu_generic_read’
>   #define this_cpu_read_1(pcp)  this_cpu_generic_read(pcp)
>                                 ^~~~~~~~~~~~~~~~~~~~~
> ./include/linux/percpu-defs.h:308:23: note: in expansion of macro ‘this_cpu_read_1’
>    case 1: pscr_ret__ = stem##1(variable); break;   \
>                         ^~~~
> ./include/linux/percpu-defs.h:494:29: note: in expansion of macro ‘__pcpu_size_call_return’
>   #define this_cpu_read(pcp)  __pcpu_size_call_return(this_cpu_read_, pcp)
>                               ^~~~~~~~~~~~~~~~~~~~~~~
> arch/powerpc/lib/code-patching.c:150:7: note: in expansion of macro ‘this_cpu_read’
>    if (!this_cpu_read(*PTRRELOC(&text_poke_area)))
>         ^~~~~~~~~~~~~
> arch/powerpc/lib/code-patching.c:150:21: error: invalid type argument of unary ‘*’ (have ‘int’)
>    if (!this_cpu_read(*PTRRELOC(&text_poke_area)))
>                       ^~~~~~~~~~~~~~~~~~~~~~~~~~
> ./include/linux/compiler.h:339:17: note: in definition of macro ‘__READ_ONCE’
>    union { typeof(x) __val; char __c[1]; } __u;   \
>                   ^
> ./include/asm-generic/percpu.h:123:10: note: in expansion of macro ‘READ_ONCE’
>    __ret = READ_ONCE(*raw_cpu_ptr(&(pcp)));   \
>            ^~~~~~~~~
> ./include/linux/percpu-defs.h:250:47: note: in expansion of macro ‘VERIFY_PERCPU_PTR’
>   #define per_cpu_ptr(ptr, cpu) ({ (void)(cpu); VERIFY_PERCPU_PTR(ptr); })
>                                                 ^~~~~~~~~~~~~~~~~
> ./include/linux/percpu-defs.h:251:26: note: in expansion of macro ‘per_cpu_ptr’
>   #define raw_cpu_ptr(ptr) per_cpu_ptr(ptr, 0)
>                            ^~~~~~~~~~~
> ./include/asm-generic/percpu.h:123:21: note: in expansion of macro ‘raw_cpu_ptr’
>    __ret = READ_ONCE(*raw_cpu_ptr(&(pcp)));   \
>                       ^~~~~~~~~~~
> ./include/asm-generic/percpu.h:142:11: note: in expansion of macro ‘__this_cpu_generic_read_nopreempt’
>     __ret = __this_cpu_generic_read_nopreempt(pcp);  \
>             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> ./include/asm-generic/percpu.h:324:31: note: in expansion of macro ‘this_cpu_generic_read’
>   #define this_cpu_read_1(pcp)  this_cpu_generic_read(pcp)
>                                 ^~~~~~~~~~~~~~~~~~~~~
> ./include/linux/percpu-defs.h:308:23: note: in expansion of macro ‘this_cpu_read_1’
>    case 1: pscr_ret__ = stem##1(variable); break;   \
>                         ^~~~
> ./include/linux/percpu-defs.h:494:29: note: in expansion of macro ‘__pcpu_size_call_return’
>   #define this_cpu_read(pcp)  __pcpu_size_call_return(this_cpu_read_, pcp)
>                               ^~~~~~~~~~~~~~~~~~~~~~~
> arch/powerpc/lib/code-patching.c:150:7: note: in expansion of macro ‘this_cpu_read’
>    if (!this_cpu_read(*PTRRELOC(&text_poke_area)))
>         ^~~~~~~~~~~~~
> arch/powerpc/lib/code-patching.c:150:21: error: invalid type argument of unary ‘*’ (have ‘int’)
>    if (!this_cpu_read(*PTRRELOC(&text_poke_area)))
>                       ^~~~~~~~~~~~~~~~~~~~~~~~~~
> ./include/linux/compiler.h:339:17: note: in definition of macro ‘__READ_ONCE’
>    union { typeof(x) __val; char __c[1]; } __u;   \
>                   ^
> ./include/asm-generic/percpu.h:123:10: note: in expansion of macro ‘READ_ONCE’
>    __ret = READ_ONCE(*raw_cpu_ptr(&(pcp)));   \
>            ^~~~~~~~~
> ./include/linux/percpu-defs.h:250:47: note: in expansion of macro ‘VERIFY_PERCPU_PTR’
>   #define per_cpu_ptr(ptr, cpu) ({ (void)(cpu); VERIFY_PERCPU_PTR(ptr); })
>                                                 ^~~~~~~~~~~~~~~~~
> ./include/linux/percpu-defs.h:251:26: note: in expansion of macro ‘per_cpu_ptr’
>   #define raw_cpu_ptr(ptr) per_cpu_ptr(ptr, 0)
>                            ^~~~~~~~~~~
> ./include/asm-generic/percpu.h:123:21: note: in expansion of macro ‘raw_cpu_ptr’
>    __ret = READ_ONCE(*raw_cpu_ptr(&(pcp)));   \
>                       ^~~~~~~~~~~
> ./include/asm-generic/percpu.h:142:11: note: in expansion of macro ‘__this_cpu_generic_read_nopreempt’
>     __ret = __this_cpu_generic_read_nopreempt(pcp);  \
>             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> ./include/asm-generic/percpu.h:324:31: note: in expansion of macro ‘this_cpu_generic_read’
>   #define this_cpu_read_1(pcp)  this_cpu_generic_read(pcp)
>                                 ^~~~~~~~~~~~~~~~~~~~~
> ./include/linux/percpu-defs.h:308:23: note: in expansion of macro ‘this_cpu_read_1’
>    case 1: pscr_ret__ = stem##1(variable); break;   \
>                         ^~~~
> ./include/linux/percpu-defs.h:494:29: note: in expansion of macro ‘__pcpu_size_call_return’
>   #define this_cpu_read(pcp)  __pcpu_size_call_return(this_cpu_read_, pcp)
>                               ^~~~~~~~~~~~~~~~~~~~~~~
> arch/powerpc/lib/code-patching.c:150:7: note: in expansion of macro ‘this_cpu_read’
>    if (!this_cpu_read(*PTRRELOC(&text_poke_area)))
>         ^~~~~~~~~~~~~
> arch/powerpc/lib/code-patching.c:150:21: error: invalid type argument of unary ‘*’ (have ‘int’)
>    if (!this_cpu_read(*PTRRELOC(&text_poke_area)))
>                       ^~~~~~~~~~~~~~~~~~~~~~~~~~
> ./include/linux/compiler.h:341:22: note: in definition of macro ‘__READ_ONCE’
>     __read_once_size(&(x), __u.__c, sizeof(x));  \
>                        ^
> ./include/asm-generic/percpu.h:123:10: note: in expansion of macro ‘READ_ONCE’
>    __ret = READ_ONCE(*raw_cpu_ptr(&(pcp)));   \
>            ^~~~~~~~~
> ./include/linux/percpu-defs.h:246:2: note: in expansion of macro ‘__verify_pcpu_ptr’
>    __verify_pcpu_ptr(__p);      \
>    ^~~~~~~~~~~~~~~~~
> ./include/linux/percpu-defs.h:250:47: note: in expansion of macro ‘VERIFY_PERCPU_PTR’
>   #define per_cpu_ptr(ptr, cpu) ({ (void)(cpu); VERIFY_PERCPU_PTR(ptr); })
>                                                 ^~~~~~~~~~~~~~~~~
> ./include/linux/percpu-defs.h:251:26: note: in expansion of macro ‘per_cpu_ptr’
>   #define raw_cpu_ptr(ptr) per_cpu_ptr(ptr, 0)
>                            ^~~~~~~~~~~
> ./include/asm-generic/percpu.h:123:21: note: in expansion of macro ‘raw_cpu_ptr’
>    __ret = READ_ONCE(*raw_cpu_ptr(&(pcp)));   \
>                       ^~~~~~~~~~~
> ./include/asm-generic/percpu.h:142:11: note: in expansion of macro ‘__this_cpu_generic_read_nopreempt’
>     __ret = __this_cpu_generic_read_nopreempt(pcp);  \
>             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> ./include/asm-generic/percpu.h:324:31: note: in expansion of macro ‘this_cpu_generic_read’
>   #define this_cpu_read_1(pcp)  this_cpu_generic_read(pcp)
>                                 ^~~~~~~~~~~~~~~~~~~~~
> ./include/linux/percpu-defs.h:308:23: note: in expansion of macro ‘this_cpu_read_1’
>    case 1: pscr_ret__ = stem##1(variable); break;   \
>                         ^~~~
> ./include/linux/percpu-defs.h:494:29: note: in expansion of macro ‘__pcpu_size_call_return’
>   #define this_cpu_read(pcp)  __pcpu_size_call_return(this_cpu_read_, pcp)
>                               ^~~~~~~~~~~~~~~~~~~~~~~
> arch/powerpc/lib/code-patching.c:150:7: note: in expansion of macro ‘this_cpu_read’
>    if (!this_cpu_read(*PTRRELOC(&text_poke_area)))
>         ^~~~~~~~~~~~~
> arch/powerpc/lib/code-patching.c:150:21: error: invalid type argument of unary ‘*’ (have ‘int’)
>    if (!this_cpu_read(*PTRRELOC(&text_poke_area)))
>                       ^~~~~~~~~~~~~~~~~~~~~~~~~~
> ./include/linux/compiler.h:341:22: note: in definition of macro ‘__READ_ONCE’
>     __read_once_size(&(x), __u.__c, sizeof(x));  \
>                        ^
> ./include/asm-generic/percpu.h:123:10: note: in expansion of macro ‘READ_ONCE’
>    __ret = READ_ONCE(*raw_cpu_ptr(&(pcp)));   \
>            ^~~~~~~~~
> ./include/linux/percpu-defs.h:250:47: note: in expansion of macro ‘VERIFY_PERCPU_PTR’
>   #define per_cpu_ptr(ptr, cpu) ({ (void)(cpu); VERIFY_PERCPU_PTR(ptr); })
>                                                 ^~~~~~~~~~~~~~~~~
> ./include/linux/percpu-defs.h:251:26: note: in expansion of macro ‘per_cpu_ptr’
>   #define raw_cpu_ptr(ptr) per_cpu_ptr(ptr, 0)
>                            ^~~~~~~~~~~
> ./include/asm-generic/percpu.h:123:21: note: in expansion of macro ‘raw_cpu_ptr’
>    __ret = READ_ONCE(*raw_cpu_ptr(&(pcp)));   \
>                       ^~~~~~~~~~~
> ./include/asm-generic/percpu.h:142:11: note: in expansion of macro ‘__this_cpu_generic_read_nopreempt’
>     __ret = __this_cpu_generic_read_nopreempt(pcp);  \
>             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> ./include/asm-generic/percpu.h:324:31: note: in expansion of macro ‘this_cpu_generic_read’
>   #define this_cpu_read_1(pcp)  this_cpu_generic_read(pcp)
>                                 ^~~~~~~~~~~~~~~~~~~~~
> ./include/linux/percpu-defs.h:308:23: note: in expansion of macro ‘this_cpu_read_1’
>    case 1: pscr_ret__ = stem##1(variable); break;   \
>                         ^~~~
> ./include/linux/percpu-defs.h:494:29: note: in expansion of macro ‘__pcpu_size_call_return’
>   #define this_cpu_read(pcp)  __pcpu_size_call_return(this_cpu_read_, pcp)
>                               ^~~~~~~~~~~~~~~~~~~~~~~
> arch/powerpc/lib/code-patching.c:150:7: note: in expansion of macro ‘this_cpu_read’
>    if (!this_cpu_read(*PTRRELOC(&text_poke_area)))
>         ^~~~~~~~~~~~~
> arch/powerpc/lib/code-patching.c:150:21: error: invalid type argument of unary ‘*’ (have ‘int’)
>    if (!this_cpu_read(*PTRRELOC(&text_poke_area)))
>                       ^~~~~~~~~~~~~~~~~~~~~~~~~~
> ./include/linux/compiler.h:341:22: note: in definition of macro ‘__READ_ONCE’
>     __read_once_size(&(x), __u.__c, sizeof(x));  \
>                        ^
> ./include/asm-generic/percpu.h:123:10: note: in expansion of macro ‘READ_ONCE’
>    __ret = READ_ONCE(*raw_cpu_ptr(&(pcp)));   \
>            ^~~~~~~~~
> ./include/linux/percpu-defs.h:250:47: note: in expansion of macro ‘VERIFY_PERCPU_PTR’
>   #define per_cpu_ptr(ptr, cpu) ({ (void)(cpu); VERIFY_PERCPU_PTR(ptr); })
>                                                 ^~~~~~~~~~~~~~~~~
> ./include/linux/percpu-defs.h:251:26: note: in expansion of macro ‘per_cpu_ptr’
>   #define raw_cpu_ptr(ptr) per_cpu_ptr(ptr, 0)
>                            ^~~~~~~~~~~
> ./include/asm-generic/percpu.h:123:21: note: in expansion of macro ‘raw_cpu_ptr’
>    __ret = READ_ONCE(*raw_cpu_ptr(&(pcp)));   \
>                       ^~~~~~~~~~~
> ./include/asm-generic/percpu.h:142:11: note: in expansion of macro ‘__this_cpu_generic_read_nopreempt’
>     __ret = __this_cpu_generic_read_nopreempt(pcp);  \
>             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> ./include/asm-generic/percpu.h:324:31: note: in expansion of macro ‘this_cpu_generic_read’
>   #define this_cpu_read_1(pcp)  this_cpu_generic_read(pcp)
>                                 ^~~~~~~~~~~~~~~~~~~~~
> ./include/linux/percpu-defs.h:308:23: note: in expansion of macro ‘this_cpu_read_1’
>    case 1: pscr_ret__ = stem##1(variable); break;   \
>                         ^~~~
> ./include/linux/percpu-defs.h:494:29: note: in expansion of macro ‘__pcpu_size_call_return’
>   #define this_cpu_read(pcp)  __pcpu_size_call_return(this_cpu_read_, pcp)
>                               ^~~~~~~~~~~~~~~~~~~~~~~
> arch/powerpc/lib/code-patching.c:150:7: note: in expansion of macro ‘this_cpu_read’
>    if (!this_cpu_read(*PTRRELOC(&text_poke_area)))
>         ^~~~~~~~~~~~~
> arch/powerpc/lib/code-patching.c:150:21: error: invalid type argument of unary ‘*’ (have ‘int’)
>    if (!this_cpu_read(*PTRRELOC(&text_poke_area)))
>                       ^~~~~~~~~~~~~~~~~~~~~~~~~~
> ./include/linux/compiler.h:341:42: note: in definition of macro ‘__READ_ONCE’
>     __read_once_size(&(x), __u.__c, sizeof(x));  \
>                                            ^
> ./include/asm-generic/percpu.h:123:10: note: in expansion of macro ‘READ_ONCE’
>    __ret = READ_ONCE(*raw_cpu_ptr(&(pcp)));   \
>            ^~~~~~~~~
> ./include/linux/percpu-defs.h:246:2: note: in expansion of macro ‘__verify_pcpu_ptr’
>    __verify_pcpu_ptr(__p);      \
>    ^~~~~~~~~~~~~~~~~
> ./include/linux/percpu-defs.h:250:47: note: in expansion of macro ‘VERIFY_PERCPU_PTR’
>   #define per_cpu_ptr(ptr, cpu) ({ (void)(cpu); VERIFY_PERCPU_PTR(ptr); })
>                                                 ^~~~~~~~~~~~~~~~~
> ./include/linux/percpu-defs.h:251:26: note: in expansion of macro ‘per_cpu_ptr’
>   #define raw_cpu_ptr(ptr) per_cpu_ptr(ptr, 0)
>                            ^~~~~~~~~~~
> ./include/asm-generic/percpu.h:123:21: note: in expansion of macro ‘raw_cpu_ptr’
>    __ret = READ_ONCE(*raw_cpu_ptr(&(pcp)));   \
>                       ^~~~~~~~~~~
> ./include/asm-generic/percpu.h:142:11: note: in expansion of macro ‘__this_cpu_generic_read_nopreempt’
>     __ret = __this_cpu_generic_read_nopreempt(pcp);  \
>             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> ./include/asm-generic/percpu.h:324:31: note: in expansion of macro ‘this_cpu_generic_read’
>   #define this_cpu_read_1(pcp)  this_cpu_generic_read(pcp)
>                                 ^~~~~~~~~~~~~~~~~~~~~
> ./include/linux/percpu-defs.h:308:23: note: in expansion of macro ‘this_cpu_read_1’
>    case 1: pscr_ret__ = stem##1(variable); break;   \
>                         ^~~~
> ./include/linux/percpu-defs.h:494:29: note: in expansion of macro ‘__pcpu_size_call_return’
>   #define this_cpu_read(pcp)  __pcpu_size_call_return(this_cpu_read_, pcp)
>                               ^~~~~~~~~~~~~~~~~~~~~~~
> arch/powerpc/lib/code-patching.c:150:7: note: in expansion of macro ‘this_cpu_read’
>    if (!this_cpu_read(*PTRRELOC(&text_poke_area)))
>         ^~~~~~~~~~~~~
> arch/powerpc/lib/code-patching.c:150:21: error: invalid type argument of unary ‘*’ (have ‘int’)
>    if (!this_cpu_read(*PTRRELOC(&text_poke_area)))
>                       ^~~~~~~~~~~~~~~~~~~~~~~~~~
> ./include/linux/compiler.h:341:42: note: in definition of macro ‘__READ_ONCE’
>     __read_once_size(&(x), __u.__c, sizeof(x));  \
>                                            ^
> ./include/asm-generic/percpu.h:123:10: note: in expansion of macro ‘READ_ONCE’
>    __ret = READ_ONCE(*raw_cpu_ptr(&(pcp)));   \
>            ^~~~~~~~~
> ./include/linux/percpu-defs.h:250:47: note: in expansion of macro ‘VERIFY_PERCPU_PTR’
>   #define per_cpu_ptr(ptr, cpu) ({ (void)(cpu); VERIFY_PERCPU_PTR(ptr); })
>                                                 ^~~~~~~~~~~~~~~~~
> ./include/linux/percpu-defs.h:251:26: note: in expansion of macro ‘per_cpu_ptr’
>   #define raw_cpu_ptr(ptr) per_cpu_ptr(ptr, 0)
>                            ^~~~~~~~~~~
> ./include/asm-generic/percpu.h:123:21: note: in expansion of macro ‘raw_cpu_ptr’
>    __ret = READ_ONCE(*raw_cpu_ptr(&(pcp)));   \
>                       ^~~~~~~~~~~
> ./include/asm-generic/percpu.h:142:11: note: in expansion of macro ‘__this_cpu_generic_read_nopreempt’
>     __ret = __this_cpu_generic_read_nopreempt(pcp);  \
>             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> ./include/asm-generic/percpu.h:324:31: note: in expansion of macro ‘this_cpu_generic_read’
>   #define this_cpu_read_1(pcp)  this_cpu_generic_read(pcp)
>                                 ^~~~~~~~~~~~~~~~~~~~~
> ./include/linux/percpu-defs.h:308:23: note: in expansion of macro ‘this_cpu_read_1’
>    case 1: pscr_ret__ = stem##1(variable); break;   \
>                         ^~~~
> ./include/linux/percpu-defs.h:494:29: note: in expansion of macro ‘__pcpu_size_call_return’
>   #define this_cpu_read(pcp)  __pcpu_size_call_return(this_cpu_read_, pcp)
>                               ^~~~~~~~~~~~~~~~~~~~~~~
> arch/powerpc/lib/code-patching.c:150:7: note: in expansion of macro ‘this_cpu_read’
>    if (!this_cpu_read(*PTRRELOC(&text_poke_area)))
>         ^~~~~~~~~~~~~
> arch/powerpc/lib/code-patching.c:150:21: error: invalid type argument of unary ‘*’ (have ‘int’)
>    if (!this_cpu_read(*PTRRELOC(&text_poke_area)))
>                       ^~~~~~~~~~~~~~~~~~~~~~~~~~
> ./include/linux/compiler.h:341:42: note: in definition of macro ‘__READ_ONCE’
>     __read_once_size(&(x), __u.__c, sizeof(x));  \
>                                            ^
> ./include/asm-generic/percpu.h:123:10: note: in expansion of macro ‘READ_ONCE’
>    __ret = READ_ONCE(*raw_cpu_ptr(&(pcp)));   \
>            ^~~~~~~~~
> ./include/linux/percpu-defs.h:250:47: note: in expansion of macro ‘VERIFY_PERCPU_PTR’
>   #define per_cpu_ptr(ptr, cpu) ({ (void)(cpu); VERIFY_PERCPU_PTR(ptr); })
>                                                 ^~~~~~~~~~~~~~~~~
> ./include/linux/percpu-defs.h:251:26: note: in expansion of macro ‘per_cpu_ptr’
>   #define raw_cpu_ptr(ptr) per_cpu_ptr(ptr, 0)
>                            ^~~~~~~~~~~
> ./include/asm-generic/percpu.h:123:21: note: in expansion of macro ‘raw_cpu_ptr’
>    __ret = READ_ONCE(*raw_cpu_ptr(&(pcp)));   \
>                       ^~~~~~~~~~~
> ./include/asm-generic/percpu.h:142:11: note: in expansion of macro ‘__this_cpu_generic_read_nopreempt’
>     __ret = __this_cpu_generic_read_nopreempt(pcp);  \
>             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> ./include/asm-generic/percpu.h:324:31: note: in expansion of macro ‘this_cpu_generic_read’
>   #define this_cpu_read_1(pcp)  this_cpu_generic_read(pcp)
>                                 ^~~~~~~~~~~~~~~~~~~~~
> ./include/linux/percpu-defs.h:308:23: note: in expansion of macro ‘this_cpu_read_1’
>    case 1: pscr_ret__ = stem##1(variable); break;   \
>                         ^~~~
> ./include/linux/percpu-defs.h:494:29: note: in expansion of macro ‘__pcpu_size_call_return’
>   #define this_cpu_read(pcp)  __pcpu_size_call_return(this_cpu_read_, pcp)
>                               ^~~~~~~~~~~~~~~~~~~~~~~
> arch/powerpc/lib/code-patching.c:150:7: note: in expansion of macro ‘this_cpu_read’
>    if (!this_cpu_read(*PTRRELOC(&text_poke_area)))
>         ^~~~~~~~~~~~~
> arch/powerpc/lib/code-patching.c:150:21: error: invalid type argument of unary ‘*’ (have ‘int’)
>    if (!this_cpu_read(*PTRRELOC(&text_poke_area)))
>                       ^~~~~~~~~~~~~~~~~~~~~~~~~~
> ./include/linux/compiler.h:343:30: note: in definition of macro ‘__READ_ONCE’
>     __read_once_size_nocheck(&(x), __u.__c, sizeof(x)); \
>                                ^
> ./include/asm-generic/percpu.h:123:10: note: in expansion of macro ‘READ_ONCE’
>    __ret = READ_ONCE(*raw_cpu_ptr(&(pcp)));   \
>            ^~~~~~~~~
> ./include/linux/percpu-defs.h:246:2: note: in expansion of macro ‘__verify_pcpu_ptr’
>    __verify_pcpu_ptr(__p);      \
>    ^~~~~~~~~~~~~~~~~
> ./include/linux/percpu-defs.h:250:47: note: in expansion of macro ‘VERIFY_PERCPU_PTR’
>   #define per_cpu_ptr(ptr, cpu) ({ (void)(cpu); VERIFY_PERCPU_PTR(ptr); })
>                                                 ^~~~~~~~~~~~~~~~~
> ./include/linux/percpu-defs.h:251:26: note: in expansion of macro ‘per_cpu_ptr’
>   #define raw_cpu_ptr(ptr) per_cpu_ptr(ptr, 0)
>                            ^~~~~~~~~~~
> ./include/asm-generic/percpu.h:123:21: note: in expansion of macro ‘raw_cpu_ptr’
>    __ret = READ_ONCE(*raw_cpu_ptr(&(pcp)));   \
>                       ^~~~~~~~~~~
> ./include/asm-generic/percpu.h:142:11: note: in expansion of macro ‘__this_cpu_generic_read_nopreempt’
>     __ret = __this_cpu_generic_read_nopreempt(pcp);  \
>             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> ./include/asm-generic/percpu.h:324:31: note: in expansion of macro ‘this_cpu_generic_read’
>   #define this_cpu_read_1(pcp)  this_cpu_generic_read(pcp)
>                                 ^~~~~~~~~~~~~~~~~~~~~
> ./include/linux/percpu-defs.h:308:23: note: in expansion of macro ‘this_cpu_read_1’
>    case 1: pscr_ret__ = stem##1(variable); break;   \
>                         ^~~~
> ./include/linux/percpu-defs.h:494:29: note: in expansion of macro ‘__pcpu_size_call_return’
>   #define this_cpu_read(pcp)  __pcpu_size_call_return(this_cpu_read_, pcp)
>                               ^~~~~~~~~~~~~~~~~~~~~~~
> arch/powerpc/lib/code-patching.c:150:7: note: in expansion of macro ‘this_cpu_read’
>    if (!this_cpu_read(*PTRRELOC(&text_poke_area)))
>         ^~~~~~~~~~~~~
> arch/powerpc/lib/code-patching.c:150:21: error: invalid type argument of unary ‘*’ (have ‘int’)
>    if (!this_cpu_read(*PTRRELOC(&text_poke_area)))
>                       ^~~~~~~~~~~~~~~~~~~~~~~~~~
> ./include/linux/compiler.h:343:30: note: in definition of macro ‘__READ_ONCE’
>     __read_once_size_nocheck(&(x), __u.__c, sizeof(x)); \
>                                ^
> ./include/asm-generic/percpu.h:123:10: note: in expansion of macro ‘READ_ONCE’
>    __ret = READ_ONCE(*raw_cpu_ptr(&(pcp)));   \
>            ^~~~~~~~~
> ./include/linux/percpu-defs.h:250:47: note: in expansion of macro ‘VERIFY_PERCPU_PTR’
>   #define per_cpu_ptr(ptr, cpu) ({ (void)(cpu); VERIFY_PERCPU_PTR(ptr); })
>                                                 ^~~~~~~~~~~~~~~~~
> ./include/linux/percpu-defs.h:251:26: note: in expansion of macro ‘per_cpu_ptr’
>   #define raw_cpu_ptr(ptr) per_cpu_ptr(ptr, 0)
>                            ^~~~~~~~~~~
> ./include/asm-generic/percpu.h:123:21: note: in expansion of macro ‘raw_cpu_ptr’
>    __ret = READ_ONCE(*raw_cpu_ptr(&(pcp)));   \
>                       ^~~~~~~~~~~
> ./include/asm-generic/percpu.h:142:11: note: in expansion of macro ‘__this_cpu_generic_read_nopreempt’
>     __ret = __this_cpu_generic_read_nopreempt(pcp);  \
>             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> ./include/asm-generic/percpu.h:324:31: note: in expansion of macro ‘this_cpu_generic_read’
>   #define this_cpu_read_1(pcp)  this_cpu_generic_read(pcp)
>                                 ^~~~~~~~~~~~~~~~~~~~~
> ./include/linux/percpu-defs.h:308:23: note: in expansion of macro ‘this_cpu_read_1’
>    case 1: pscr_ret__ = stem##1(variable); break;   \
>                         ^~~~
> ./include/linux/percpu-defs.h:494:29: note: in expansion of macro ‘__pcpu_size_call_return’
>   #define this_cpu_read(pcp)  __pcpu_size_call_return(this_cpu_read_, pcp)
>                               ^~~~~~~~~~~~~~~~~~~~~~~
> arch/powerpc/lib/code-patching.c:150:7: note: in expansion of macro ‘this_cpu_read’
>    if (!this_cpu_read(*PTRRELOC(&text_poke_area)))
>         ^~~~~~~~~~~~~
> arch/powerpc/lib/code-patching.c:150:21: error: invalid type argument of unary ‘*’ (have ‘int’)
>    if (!this_cpu_read(*PTRRELOC(&text_poke_area)))
>                       ^~~~~~~~~~~~~~~~~~~~~~~~~~
> ./include/linux/compiler.h:343:30: note: in definition of macro ‘__READ_ONCE’
>     __read_once_size_nocheck(&(x), __u.__c, sizeof(x)); \
>                                ^
> ./include/asm-generic/percpu.h:123:10: note: in expansion of macro ‘READ_ONCE’
>    __ret = READ_ONCE(*raw_cpu_ptr(&(pcp)));   \
>            ^~~~~~~~~
> ./include/linux/percpu-defs.h:250:47: note: in expansion of macro ‘VERIFY_PERCPU_PTR’
>   #define per_cpu_ptr(ptr, cpu) ({ (void)(cpu); VERIFY_PERCPU_PTR(ptr); })
>                                                 ^~~~~~~~~~~~~~~~~
> ./include/linux/percpu-defs.h:251:26: note: in expansion of macro ‘per_cpu_ptr’
>   #define raw_cpu_ptr(ptr) per_cpu_ptr(ptr, 0)
>                            ^~~~~~~~~~~
> ./include/asm-generic/percpu.h:123:21: note: in expansion of macro ‘raw_cpu_ptr’
>    __ret = READ_ONCE(*raw_cpu_ptr(&(pcp)));   \
>                       ^~~~~~~~~~~
> ./include/asm-generic/percpu.h:142:11: note: in expansion of macro ‘__this_cpu_generic_read_nopreempt’
>     __ret = __this_cpu_generic_read_nopreempt(pcp);  \
>             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> ./include/asm-generic/percpu.h:324:31: note: in expansion of macro ‘this_cpu_generic_read’
>   #define this_cpu_read_1(pcp)  this_cpu_generic_read(pcp)
>                                 ^~~~~~~~~~~~~~~~~~~~~
> ./include/linux/percpu-defs.h:308:23: note: in expansion of macro ‘this_cpu_read_1’
>    case 1: pscr_ret__ = stem##1(variable); break;   \
>                         ^~~~
> ./include/linux/percpu-defs.h:494:29: note: in expansion of macro ‘__pcpu_size_call_return’
>   #define this_cpu_read(pcp)  __pcpu_size_call_return(this_cpu_read_, pcp)
>                               ^~~~~~~~~~~~~~~~~~~~~~~
> arch/powerpc/lib/code-patching.c:150:7: note: in expansion of macro ‘this_cpu_read’
>    if (!this_cpu_read(*PTRRELOC(&text_poke_area)))
>         ^~~~~~~~~~~~~
> arch/powerpc/lib/code-patching.c:150:21: error: invalid type argument of unary ‘*’ (have ‘int’)
>    if (!this_cpu_read(*PTRRELOC(&text_poke_area)))
>                       ^~~~~~~~~~~~~~~~~~~~~~~~~~
> ./include/linux/compiler.h:343:50: note: in definition of macro ‘__READ_ONCE’
>     __read_once_size_nocheck(&(x), __u.__c, sizeof(x)); \
>                                                    ^
> ./include/asm-generic/percpu.h:123:10: note: in expansion of macro ‘READ_ONCE’
>    __ret = READ_ONCE(*raw_cpu_ptr(&(pcp)));   \
>            ^~~~~~~~~
> ./include/linux/percpu-defs.h:246:2: note: in expansion of macro ‘__verify_pcpu_ptr’
>    __verify_pcpu_ptr(__p);      \
>    ^~~~~~~~~~~~~~~~~
> ./include/linux/percpu-defs.h:250:47: note: in expansion of macro ‘VERIFY_PERCPU_PTR’
>   #define per_cpu_ptr(ptr, cpu) ({ (void)(cpu); VERIFY_PERCPU_PTR(ptr); })
>                                                 ^~~~~~~~~~~~~~~~~
> ./include/linux/percpu-defs.h:251:26: note: in expansion of macro ‘per_cpu_ptr’
>   #define raw_cpu_ptr(ptr) per_cpu_ptr(ptr, 0)
>                            ^~~~~~~~~~~
> ./include/asm-generic/percpu.h:123:21: note: in expansion of macro ‘raw_cpu_ptr’
>    __ret = READ_ONCE(*raw_cpu_ptr(&(pcp)));   \
>                       ^~~~~~~~~~~
> ./include/asm-generic/percpu.h:142:11: note: in expansion of macro ‘__this_cpu_generic_read_nopreempt’
>     __ret = __this_cpu_generic_read_nopreempt(pcp);  \
>             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> ./include/asm-generic/percpu.h:324:31: note: in expansion of macro ‘this_cpu_generic_read’
>   #define this_cpu_read_1(pcp)  this_cpu_generic_read(pcp)
>                                 ^~~~~~~~~~~~~~~~~~~~~
> ./include/linux/percpu-defs.h:308:23: note: in expansion of macro ‘this_cpu_read_1’
>    case 1: pscr_ret__ = stem##1(variable); break;   \
>                         ^~~~
> ./include/linux/percpu-defs.h:494:29: note: in expansion of macro ‘__pcpu_size_call_return’
>   #define this_cpu_read(pcp)  __pcpu_size_call_return(this_cpu_read_, pcp)
>                               ^~~~~~~~~~~~~~~~~~~~~~~
> arch/powerpc/lib/code-patching.c:150:7: note: in expansion of macro ‘this_cpu_read’
>    if (!this_cpu_read(*PTRRELOC(&text_poke_area)))
>         ^~~~~~~~~~~~~
> arch/powerpc/lib/code-patching.c:150:21: error: invalid type argument of unary ‘*’ (have ‘int’)
>    if (!this_cpu_read(*PTRRELOC(&text_poke_area)))
>                       ^~~~~~~~~~~~~~~~~~~~~~~~~~
> ./include/linux/compiler.h:343:50: note: in definition of macro ‘__READ_ONCE’
>     __read_once_size_nocheck(&(x), __u.__c, sizeof(x)); \
>                                                    ^
> ./include/asm-generic/percpu.h:123:10: note: in expansion of macro ‘READ_ONCE’
>    __ret = READ_ONCE(*raw_cpu_ptr(&(pcp)));   \
>            ^~~~~~~~~
> ./include/linux/percpu-defs.h:250:47: note: in expansion of macro ‘VERIFY_PERCPU_PTR’
>   #define per_cpu_ptr(ptr, cpu) ({ (void)(cpu); VERIFY_PERCPU_PTR(ptr); })
>                                                 ^~~~~~~~~~~~~~~~~
> ./include/linux/percpu-defs.h:251:26: note: in expansion of macro ‘per_cpu_ptr’
>   #define raw_cpu_ptr(ptr) per_cpu_ptr(ptr, 0)
>                            ^~~~~~~~~~~
> ./include/asm-generic/percpu.h:123:21: note: in expansion of macro ‘raw_cpu_ptr’
>    __ret = READ_ONCE(*raw_cpu_ptr(&(pcp)));   \
>                       ^~~~~~~~~~~
> ./include/asm-generic/percpu.h:142:11: note: in expansion of macro ‘__this_cpu_generic_read_nopreempt’
>     __ret = __this_cpu_generic_read_nopreempt(pcp);  \
>             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> ./include/asm-generic/percpu.h:324:31: note: in expansion of macro ‘this_cpu_generic_read’
>   #define this_cpu_read_1(pcp)  this_cpu_generic_read(pcp)
>                                 ^~~~~~~~~~~~~~~~~~~~~
> ./include/linux/percpu-defs.h:308:23: note: in expansion of macro ‘this_cpu_read_1’
>    case 1: pscr_ret__ = stem##1(variable); break;   \
>                         ^~~~
> ./include/linux/percpu-defs.h:494:29: note: in expansion of macro ‘__pcpu_size_call_return’
>   #define this_cpu_read(pcp)  __pcpu_size_call_return(this_cpu_read_, pcp)
>                               ^~~~~~~~~~~~~~~~~~~~~~~
> arch/powerpc/lib/code-patching.c:150:7: note: in expansion of macro ‘this_cpu_read’
>    if (!this_cpu_read(*PTRRELOC(&text_poke_area)))
>         ^~~~~~~~~~~~~
> arch/powerpc/lib/code-patching.c:150:21: error: invalid type argument of unary ‘*’ (have ‘int’)
>    if (!this_cpu_read(*PTRRELOC(&text_poke_area)))
>                       ^~~~~~~~~~~~~~~~~~~~~~~~~~
> ./include/linux/compiler.h:343:50: note: in definition of macro ‘__READ_ONCE’
>     __read_once_size_nocheck(&(x), __u.__c, sizeof(x)); \
>                                                    ^
> ./include/asm-generic/percpu.h:123:10: note: in expansion of macro ‘READ_ONCE’
>    __ret = READ_ONCE(*raw_cpu_ptr(&(pcp)));   \
>            ^~~~~~~~~
> ./include/linux/percpu-defs.h:250:47: note: in expansion of macro ‘VERIFY_PERCPU_PTR’
>   #define per_cpu_ptr(ptr, cpu) ({ (void)(cpu); VERIFY_PERCPU_PTR(ptr); })
>                                                 ^~~~~~~~~~~~~~~~~
> ./include/linux/percpu-defs.h:251:26: note: in expansion of macro ‘per_cpu_ptr’
>   #define raw_cpu_ptr(ptr) per_cpu_ptr(ptr, 0)
>                            ^~~~~~~~~~~
> ./include/asm-generic/percpu.h:123:21: note: in expansion of macro ‘raw_cpu_ptr’
>    __ret = READ_ONCE(*raw_cpu_ptr(&(pcp)));   \
>                       ^~~~~~~~~~~
> ./include/asm-generic/percpu.h:142:11: note: in expansion of macro ‘__this_cpu_generic_read_nopreempt’
>     __ret = __this_cpu_generic_read_nopreempt(pcp);  \
>             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> ./include/asm-generic/percpu.h:324:31: note: in expansion of macro ‘this_cpu_generic_read’
>   #define this_cpu_read_1(pcp)  this_cpu_generic_read(pcp)
>                                 ^~~~~~~~~~~~~~~~~~~~~
> ./include/linux/percpu-defs.h:308:23: note: in expansion of macro ‘this_cpu_read_1’
>    case 1: pscr_ret__ = stem##1(variable); break;   \
>                         ^~~~
> ./include/linux/percpu-defs.h:494:29: note: in expansion of macro ‘__pcpu_size_call_return’
>   #define this_cpu_read(pcp)  __pcpu_size_call_return(this_cpu_read_, pcp)
>                               ^~~~~~~~~~~~~~~~~~~~~~~
> arch/powerpc/lib/code-patching.c:150:7: note: in expansion of macro ‘this_cpu_read’
>    if (!this_cpu_read(*PTRRELOC(&text_poke_area)))
>         ^~~~~~~~~~~~~
> In file included from ./arch/powerpc/include/asm/percpu.h:20:0,
>                   from ./include/linux/percpu.h:13,
>                   from ./include/linux/kprobes.h:38,
>                   from arch/powerpc/lib/code-patching.c:11:
> arch/powerpc/lib/code-patching.c:150:21: error: invalid type argument of unary ‘*’ (have ‘int’)
>    if (!this_cpu_read(*PTRRELOC(&text_poke_area)))
>                       ^~~~~~~~~~~~~~~~~~~~~~~~~~
> ./include/asm-generic/percpu.h:130:9: note: in definition of macro ‘__this_cpu_generic_read_noirq’
>    typeof(pcp) __ret;      \
>           ^~~
> ./include/asm-generic/percpu.h:324:31: note: in expansion of macro ‘this_cpu_generic_read’
>   #define this_cpu_read_1(pcp)  this_cpu_generic_read(pcp)
>                                 ^~~~~~~~~~~~~~~~~~~~~
> ./include/linux/percpu-defs.h:308:23: note: in expansion of macro ‘this_cpu_read_1’
>    case 1: pscr_ret__ = stem##1(variable); break;   \
>                         ^~~~
> ./include/linux/percpu-defs.h:494:29: note: in expansion of macro ‘__pcpu_size_call_return’
>   #define this_cpu_read(pcp)  __pcpu_size_call_return(this_cpu_read_, pcp)
>                               ^~~~~~~~~~~~~~~~~~~~~~~
> arch/powerpc/lib/code-patching.c:150:7: note: in expansion of macro ‘this_cpu_read’
>    if (!this_cpu_read(*PTRRELOC(&text_poke_area)))
>         ^~~~~~~~~~~~~
> In file included from ./include/asm-generic/percpu.h:7:0,
>                   from ./arch/powerpc/include/asm/percpu.h:20,
>                   from ./include/linux/percpu.h:13,
>                   from ./include/linux/kprobes.h:38,
>                   from arch/powerpc/lib/code-patching.c:11:
> arch/powerpc/lib/code-patching.c:150:21: error: invalid type argument of unary ‘*’ (have ‘int’)
>    if (!this_cpu_read(*PTRRELOC(&text_poke_area)))
>                       ^~~~~~~~~~~~~~~~~~~~~~~~~~
> ./include/linux/percpu-defs.h:206:47: note: in definition of macro ‘__verify_pcpu_ptr’
>    const void __percpu *__vpp_verify = (typeof((ptr) + 0))NULL; \
>                                                 ^~~
> ./include/linux/percpu-defs.h:250:47: note: in expansion of macro ‘VERIFY_PERCPU_PTR’
>   #define per_cpu_ptr(ptr, cpu) ({ (void)(cpu); VERIFY_PERCPU_PTR(ptr); })
>                                                 ^~~~~~~~~~~~~~~~~
> ./include/linux/percpu-defs.h:251:26: note: in expansion of macro ‘per_cpu_ptr’
>   #define raw_cpu_ptr(ptr) per_cpu_ptr(ptr, 0)
>                            ^~~~~~~~~~~
> ./include/asm-generic/percpu.h:71:3: note: in expansion of macro ‘raw_cpu_ptr’
>    *raw_cpu_ptr(&(pcp));      \
>     ^~~~~~~~~~~
> ./include/asm-generic/percpu.h:133:10: note: in expansion of macro ‘raw_cpu_generic_read’
>    __ret = raw_cpu_generic_read(pcp);    \
>            ^~~~~~~~~~~~~~~~~~~~
> ./include/asm-generic/percpu.h:144:11: note: in expansion of macro ‘__this_cpu_generic_read_noirq’
>     __ret = __this_cpu_generic_read_noirq(pcp);  \
>             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> ./include/asm-generic/percpu.h:324:31: note: in expansion of macro ‘this_cpu_generic_read’
>   #define this_cpu_read_1(pcp)  this_cpu_generic_read(pcp)
>                                 ^~~~~~~~~~~~~~~~~~~~~
> ./include/linux/percpu-defs.h:308:23: note: in expansion of macro ‘this_cpu_read_1’
>    case 1: pscr_ret__ = stem##1(variable); break;   \
>                         ^~~~
> ./include/linux/percpu-defs.h:494:29: note: in expansion of macro ‘__pcpu_size_call_return’
>   #define this_cpu_read(pcp)  __pcpu_size_call_return(this_cpu_read_, pcp)
>                               ^~~~~~~~~~~~~~~~~~~~~~~
> arch/powerpc/lib/code-patching.c:150:7: note: in expansion of macro ‘this_cpu_read’
>    if (!this_cpu_read(*PTRRELOC(&text_poke_area)))
>         ^~~~~~~~~~~~~
> arch/powerpc/lib/code-patching.c:150:21: error: invalid type argument of unary ‘*’ (have ‘int’)
>    if (!this_cpu_read(*PTRRELOC(&text_poke_area)))
>                       ^~~~~~~~~~~~~~~~~~~~~~~~~~
> ./include/linux/percpu-defs.h:247:12: note: in definition of macro ‘VERIFY_PERCPU_PTR’
>    (typeof(*(__p)) __kernel __force *)(__p);   \
>              ^~~
> ./include/linux/percpu-defs.h:251:26: note: in expansion of macro ‘per_cpu_ptr’
>   #define raw_cpu_ptr(ptr) per_cpu_ptr(ptr, 0)
>                            ^~~~~~~~~~~
> ./include/asm-generic/percpu.h:71:3: note: in expansion of macro ‘raw_cpu_ptr’
>    *raw_cpu_ptr(&(pcp));      \
>     ^~~~~~~~~~~
> ./include/asm-generic/percpu.h:133:10: note: in expansion of macro ‘raw_cpu_generic_read’
>    __ret = raw_cpu_generic_read(pcp);    \
>            ^~~~~~~~~~~~~~~~~~~~
> ./include/asm-generic/percpu.h:144:11: note: in expansion of macro ‘__this_cpu_generic_read_noirq’
>     __ret = __this_cpu_generic_read_noirq(pcp);  \
>             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> ./include/asm-generic/percpu.h:324:31: note: in expansion of macro ‘this_cpu_generic_read’
>   #define this_cpu_read_1(pcp)  this_cpu_generic_read(pcp)
>                                 ^~~~~~~~~~~~~~~~~~~~~
> ./include/linux/percpu-defs.h:308:23: note: in expansion of macro ‘this_cpu_read_1’
>    case 1: pscr_ret__ = stem##1(variable); break;   \
>                         ^~~~
> ./include/linux/percpu-defs.h:494:29: note: in expansion of macro ‘__pcpu_size_call_return’
>   #define this_cpu_read(pcp)  __pcpu_size_call_return(this_cpu_read_, pcp)
>                               ^~~~~~~~~~~~~~~~~~~~~~~
> arch/powerpc/lib/code-patching.c:150:7: note: in expansion of macro ‘this_cpu_read’
>    if (!this_cpu_read(*PTRRELOC(&text_poke_area)))
>         ^~~~~~~~~~~~~
> arch/powerpc/lib/code-patching.c:150:21: error: invalid type argument of unary ‘*’ (have ‘int’)
>    if (!this_cpu_read(*PTRRELOC(&text_poke_area)))
>                       ^~~~~~~~~~~~~~~~~~~~~~~~~~
> ./include/linux/percpu-defs.h:247:38: note: in definition of macro ‘VERIFY_PERCPU_PTR’
>    (typeof(*(__p)) __kernel __force *)(__p);   \
>                                        ^~~
> ./include/linux/percpu-defs.h:251:26: note: in expansion of macro ‘per_cpu_ptr’
>   #define raw_cpu_ptr(ptr) per_cpu_ptr(ptr, 0)
>                            ^~~~~~~~~~~
> ./include/asm-generic/percpu.h:71:3: note: in expansion of macro ‘raw_cpu_ptr’
>    *raw_cpu_ptr(&(pcp));      \
>     ^~~~~~~~~~~
> ./include/asm-generic/percpu.h:133:10: note: in expansion of macro ‘raw_cpu_generic_read’
>    __ret = raw_cpu_generic_read(pcp);    \
>            ^~~~~~~~~~~~~~~~~~~~
> ./include/asm-generic/percpu.h:144:11: note: in expansion of macro ‘__this_cpu_generic_read_noirq’
>     __ret = __this_cpu_generic_read_noirq(pcp);  \
>             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> ./include/asm-generic/percpu.h:324:31: note: in expansion of macro ‘this_cpu_generic_read’
>   #define this_cpu_read_1(pcp)  this_cpu_generic_read(pcp)
>                                 ^~~~~~~~~~~~~~~~~~~~~
> ./include/linux/percpu-defs.h:308:23: note: in expansion of macro ‘this_cpu_read_1’
>    case 1: pscr_ret__ = stem##1(variable); break;   \
>                         ^~~~
> ./include/linux/percpu-defs.h:494:29: note: in expansion of macro ‘__pcpu_size_call_return’
>   #define this_cpu_read(pcp)  __pcpu_size_call_return(this_cpu_read_, pcp)
>                               ^~~~~~~~~~~~~~~~~~~~~~~
> arch/powerpc/lib/code-patching.c:150:7: note: in expansion of macro ‘this_cpu_read’
>    if (!this_cpu_read(*PTRRELOC(&text_poke_area)))
>         ^~~~~~~~~~~~~
> In file included from ./arch/powerpc/include/asm/percpu.h:20:0,
>                   from ./include/linux/percpu.h:13,
>                   from ./include/linux/kprobes.h:38,
>                   from arch/powerpc/lib/code-patching.c:11:
> arch/powerpc/lib/code-patching.c:150:21: error: invalid type argument of unary ‘*’ (have ‘int’)
>    if (!this_cpu_read(*PTRRELOC(&text_poke_area)))
>                       ^~~~~~~~~~~~~~~~~~~~~~~~~~
> ./include/asm-generic/percpu.h:140:9: note: in definition of macro ‘this_cpu_generic_read’
>    typeof(pcp) __ret;      \
>           ^~~
> ./include/linux/percpu-defs.h:309:23: note: in expansion of macro ‘this_cpu_read_2’
>    case 2: pscr_ret__ = stem##2(variable); break;   \
>                         ^~~~
> ./include/linux/percpu-defs.h:494:29: note: in expansion of macro ‘__pcpu_size_call_return’
>   #define this_cpu_read(pcp)  __pcpu_size_call_return(this_cpu_read_, pcp)
>                               ^~~~~~~~~~~~~~~~~~~~~~~
> arch/powerpc/lib/code-patching.c:150:7: note: in expansion of macro ‘this_cpu_read’
>    if (!this_cpu_read(*PTRRELOC(&text_poke_area)))
>         ^~~~~~~~~~~~~
> In file included from ./include/linux/linkage.h:5:0,
>                   from ./include/linux/kernel.h:7,
>                   from arch/powerpc/lib/code-patching.c:10:
> arch/powerpc/lib/code-patching.c:150:21: error: invalid type argument of unary ‘*’ (have ‘int’)
>    if (!this_cpu_read(*PTRRELOC(&text_poke_area)))
>                       ^~~~~~~~~~~~~~~~~~~~~~~~~~
> ./include/linux/compiler.h:524:35: note: in definition of macro ‘__native_word’
>   # define __native_word(t) (sizeof(t) == sizeof(char) || sizeof(t) == sizeof(short) || sizeof(t) == sizeof(int) || sizeof(t) == sizeof(long))
>                                     ^
> ./include/asm-generic/percpu.h:327:31: note: in expansion of macro ‘this_cpu_generic_read’
>   #define this_cpu_read_2(pcp)  this_cpu_generic_read(pcp)
>                                 ^~~~~~~~~~~~~~~~~~~~~
> ./include/linux/percpu-defs.h:309:23: note: in expansion of macro ‘this_cpu_read_2’
>    case 2: pscr_ret__ = stem##2(variable); break;   \
>                         ^~~~
> ./include/linux/percpu-defs.h:494:29: note: in expansion of macro ‘__pcpu_size_call_return’
>   #define this_cpu_read(pcp)  __pcpu_size_call_return(this_cpu_read_, pcp)
>                               ^~~~~~~~~~~~~~~~~~~~~~~
> arch/powerpc/lib/code-patching.c:150:7: note: in expansion of macro ‘this_cpu_read’
>    if (!this_cpu_read(*PTRRELOC(&text_poke_area)))
>         ^~~~~~~~~~~~~
> arch/powerpc/lib/code-patching.c:150:21: error: invalid type argument of unary ‘*’ (have ‘int’)
>    if (!this_cpu_read(*PTRRELOC(&text_poke_area)))
>                       ^~~~~~~~~~~~~~~~~~~~~~~~~~
> ./include/linux/compiler.h:524:64: note: in definition of macro ‘__native_word’
>   # define __native_word(t) (sizeof(t) == sizeof(char) || sizeof(t) == sizeof(short) || sizeof(t) == sizeof(int) || sizeof(t) == sizeof(long))
>                                                                  ^
> ./include/asm-generic/percpu.h:327:31: note: in expansion of macro ‘this_cpu_generic_read’
>   #define this_cpu_read_2(pcp)  this_cpu_generic_read(pcp)
>                                 ^~~~~~~~~~~~~~~~~~~~~
> ./include/linux/percpu-defs.h:309:23: note: in expansion of macro ‘this_cpu_read_2’
>    case 2: pscr_ret__ = stem##2(variable); break;   \
>                         ^~~~
> ./include/linux/percpu-defs.h:494:29: note: in expansion of macro ‘__pcpu_size_call_return’
>   #define this_cpu_read(pcp)  __pcpu_size_call_return(this_cpu_read_, pcp)
>                               ^~~~~~~~~~~~~~~~~~~~~~~
> arch/powerpc/lib/code-patching.c:150:7: note: in expansion of macro ‘this_cpu_read’
>    if (!this_cpu_read(*PTRRELOC(&text_poke_area)))
>         ^~~~~~~~~~~~~
> arch/powerpc/lib/code-patching.c:150:21: error: invalid type argument of unary ‘*’ (have ‘int’)
>    if (!this_cpu_read(*PTRRELOC(&text_poke_area)))
>                       ^~~~~~~~~~~~~~~~~~~~~~~~~~
> ./include/linux/compiler.h:524:94: note: in definition of macro ‘__native_word’
>   # define __native_word(t) (sizeof(t) == sizeof(char) || sizeof(t) == sizeof(short) || sizeof(t) == sizeof(int) || sizeof(t) == sizeof(long))
>                                                                                                ^
> ./include/asm-generic/percpu.h:327:31: note: in expansion of macro ‘this_cpu_generic_read’
>   #define this_cpu_read_2(pcp)  this_cpu_generic_read(pcp)
>                                 ^~~~~~~~~~~~~~~~~~~~~
> ./include/linux/percpu-defs.h:309:23: note: in expansion of macro ‘this_cpu_read_2’
>    case 2: pscr_ret__ = stem##2(variable); break;   \
>                         ^~~~
> ./include/linux/percpu-defs.h:494:29: note: in expansion of macro ‘__pcpu_size_call_return’
>   #define this_cpu_read(pcp)  __pcpu_size_call_return(this_cpu_read_, pcp)
>                               ^~~~~~~~~~~~~~~~~~~~~~~
> arch/powerpc/lib/code-patching.c:150:7: note: in expansion of macro ‘this_cpu_read’
>    if (!this_cpu_read(*PTRRELOC(&text_poke_area)))
>         ^~~~~~~~~~~~~
> arch/powerpc/lib/code-patching.c:150:21: error: invalid type argument of unary ‘*’ (have ‘int’)
>    if (!this_cpu_read(*PTRRELOC(&text_poke_area)))
>                       ^~~~~~~~~~~~~~~~~~~~~~~~~~
> ./include/linux/compiler.h:524:122: note: in definition of macro ‘__native_word’
>   # define __native_word(t) (sizeof(t) == sizeof(char) || sizeof(t) == sizeof(short) || sizeof(t) == sizeof(int) || sizeof(t) == sizeof(long))
>                                                                                                                            ^
> ./include/asm-generic/percpu.h:327:31: note: in expansion of macro ‘this_cpu_generic_read’
>   #define this_cpu_read_2(pcp)  this_cpu_generic_read(pcp)
>                                 ^~~~~~~~~~~~~~~~~~~~~
> ./include/linux/percpu-defs.h:309:23: note: in expansion of macro ‘this_cpu_read_2’
>    case 2: pscr_ret__ = stem##2(variable); break;   \
>                         ^~~~
> ./include/linux/percpu-defs.h:494:29: note: in expansion of macro ‘__pcpu_size_call_return’
>   #define this_cpu_read(pcp)  __pcpu_size_call_return(this_cpu_read_, pcp)
>                               ^~~~~~~~~~~~~~~~~~~~~~~
> arch/powerpc/lib/code-patching.c:150:7: note: in expansion of macro ‘this_cpu_read’
>    if (!this_cpu_read(*PTRRELOC(&text_poke_area)))
>         ^~~~~~~~~~~~~
> In file included from ./arch/powerpc/include/asm/percpu.h:20:0,
>                   from ./include/linux/percpu.h:13,
>                   from ./include/linux/kprobes.h:38,
>                   from arch/powerpc/lib/code-patching.c:11:
> arch/powerpc/lib/code-patching.c:150:21: error: invalid type argument of unary ‘*’ (have ‘int’)
>    if (!this_cpu_read(*PTRRELOC(&text_poke_area)))
>                       ^~~~~~~~~~~~~~~~~~~~~~~~~~
> ./include/asm-generic/percpu.h:121:9: note: in definition of macro ‘__this_cpu_generic_read_nopreempt’
>    typeof(pcp) __ret;      \
>           ^~~
> ./include/asm-generic/percpu.h:327:31: note: in expansion of macro ‘this_cpu_generic_read’
>   #define this_cpu_read_2(pcp)  this_cpu_generic_read(pcp)
>                                 ^~~~~~~~~~~~~~~~~~~~~
> ./include/linux/percpu-defs.h:309:23: note: in expansion of macro ‘this_cpu_read_2’
>    case 2: pscr_ret__ = stem##2(variable); break;   \
>                         ^~~~
> ./include/linux/percpu-defs.h:494:29: note: in expansion of macro ‘__pcpu_size_call_return’
>   #define this_cpu_read(pcp)  __pcpu_size_call_return(this_cpu_read_, pcp)
>                               ^~~~~~~~~~~~~~~~~~~~~~~
> arch/powerpc/lib/code-patching.c:150:7: note: in expansion of macro ‘this_cpu_read’
>    if (!this_cpu_read(*PTRRELOC(&text_poke_area)))
>         ^~~~~~~~~~~~~
> In file included from ./include/linux/linkage.h:5:0,
>                   from ./include/linux/kernel.h:7,
>                   from arch/powerpc/lib/code-patching.c:10:
> arch/powerpc/lib/code-patching.c:150:21: error: invalid type argument of unary ‘*’ (have ‘int’)
>    if (!this_cpu_read(*PTRRELOC(&text_poke_area)))
>                       ^~~~~~~~~~~~~~~~~~~~~~~~~~
> ./include/linux/compiler.h:339:17: note: in definition of macro ‘__READ_ONCE’
>    union { typeof(x) __val; char __c[1]; } __u;   \
>                   ^
> ./include/asm-generic/percpu.h:123:10: note: in expansion of macro ‘READ_ONCE’
>    __ret = READ_ONCE(*raw_cpu_ptr(&(pcp)));   \
>            ^~~~~~~~~
> ./include/linux/percpu-defs.h:246:2: note: in expansion of macro ‘__verify_pcpu_ptr’
>    __verify_pcpu_ptr(__p);      \
>    ^~~~~~~~~~~~~~~~~
> ./include/linux/percpu-defs.h:250:47: note: in expansion of macro ‘VERIFY_PERCPU_PTR’
>   #define per_cpu_ptr(ptr, cpu) ({ (void)(cpu); VERIFY_PERCPU_PTR(ptr); })
>                                                 ^~~~~~~~~~~~~~~~~
> ./include/linux/percpu-defs.h:251:26: note: in expansion of macro ‘per_cpu_ptr’
>   #define raw_cpu_ptr(ptr) per_cpu_ptr(ptr, 0)
>                            ^~~~~~~~~~~
> ./include/asm-generic/percpu.h:123:21: note: in expansion of macro ‘raw_cpu_ptr’
>    __ret = READ_ONCE(*raw_cpu_ptr(&(pcp)));   \
>                       ^~~~~~~~~~~
> ./include/asm-generic/percpu.h:142:11: note: in expansion of macro ‘__this_cpu_generic_read_nopreempt’
>     __ret = __this_cpu_generic_read_nopreempt(pcp);  \
>             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> ./include/asm-generic/percpu.h:327:31: note: in expansion of macro ‘this_cpu_generic_read’
>   #define this_cpu_read_2(pcp)  this_cpu_generic_read(pcp)
>                                 ^~~~~~~~~~~~~~~~~~~~~
> ./include/linux/percpu-defs.h:309:23: note: in expansion of macro ‘this_cpu_read_2’
>    case 2: pscr_ret__ = stem##2(variable); break;   \
>                         ^~~~
> ./include/linux/percpu-defs.h:494:29: note: in expansion of macro ‘__pcpu_size_call_return’
>   #define this_cpu_read(pcp)  __pcpu_size_call_return(this_cpu_read_, pcp)
>                               ^~~~~~~~~~~~~~~~~~~~~~~
> arch/powerpc/lib/code-patching.c:150:7: note: in expansion of macro ‘this_cpu_read’
>    if (!this_cpu_read(*PTRRELOC(&text_poke_area)))
>         ^~~~~~~~~~~~~
> arch/powerpc/lib/code-patching.c:150:21: error: invalid type argument of unary ‘*’ (have ‘int’)
>    if (!this_cpu_read(*PTRRELOC(&text_poke_area)))
>                       ^~~~~~~~~~~~~~~~~~~~~~~~~~
> ./include/linux/compiler.h:339:17: note: in definition of macro ‘__READ_ONCE’
>    union { typeof(x) __val; char __c[1]; } __u;   \
>                   ^
> ./include/asm-generic/percpu.h:123:10: note: in expansion of macro ‘READ_ONCE’
>    __ret = READ_ONCE(*raw_cpu_ptr(&(pcp)));   \
>            ^~~~~~~~~
> ./include/linux/percpu-defs.h:250:47: note: in expansion of macro ‘VERIFY_PERCPU_PTR’
>   #define per_cpu_ptr(ptr, cpu) ({ (void)(cpu); VERIFY_PERCPU_PTR(ptr); })
>                                                 ^~~~~~~~~~~~~~~~~
> ./include/linux/percpu-defs.h:251:26: note: in expansion of macro ‘per_cpu_ptr’
>   #define raw_cpu_ptr(ptr) per_cpu_ptr(ptr, 0)
>                            ^~~~~~~~~~~
> ./include/asm-generic/percpu.h:123:21: note: in expansion of macro ‘raw_cpu_ptr’
>    __ret = READ_ONCE(*raw_cpu_ptr(&(pcp)));   \
>                       ^~~~~~~~~~~
> ./include/asm-generic/percpu.h:142:11: note: in expansion of macro ‘__this_cpu_generic_read_nopreempt’
>     __ret = __this_cpu_generic_read_nopreempt(pcp);  \
>             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> ./include/asm-generic/percpu.h:327:31: note: in expansion of macro ‘this_cpu_generic_read’
>   #define this_cpu_read_2(pcp)  this_cpu_generic_read(pcp)
>                                 ^~~~~~~~~~~~~~~~~~~~~
> ./include/linux/percpu-defs.h:309:23: note: in expansion of macro ‘this_cpu_read_2’
>    case 2: pscr_ret__ = stem##2(variable); break;   \
>                         ^~~~
> ./include/linux/percpu-defs.h:494:29: note: in expansion of macro ‘__pcpu_size_call_return’
>   #define this_cpu_read(pcp)  __pcpu_size_call_return(this_cpu_read_, pcp)
>                               ^~~~~~~~~~~~~~~~~~~~~~~
> arch/powerpc/lib/code-patching.c:150:7: note: in expansion of macro ‘this_cpu_read’
>    if (!this_cpu_read(*PTRRELOC(&text_poke_area)))
>         ^~~~~~~~~~~~~
> arch/powerpc/lib/code-patching.c:150:21: error: invalid type argument of unary ‘*’ (have ‘int’)
>    if (!this_cpu_read(*PTRRELOC(&text_poke_area)))
>                       ^~~~~~~~~~~~~~~~~~~~~~~~~~
> ./include/linux/compiler.h:339:17: note: in definition of macro ‘__READ_ONCE’
>    union { typeof(x) __val; char __c[1]; } __u;   \
>                   ^
> ./include/asm-generic/percpu.h:123:10: note: in expansion of macro ‘READ_ONCE’
>    __ret = READ_ONCE(*raw_cpu_ptr(&(pcp)));   \
>            ^~~~~~~~~
> ./include/linux/percpu-defs.h:250:47: note: in expansion of macro ‘VERIFY_PERCPU_PTR’
>   #define per_cpu_ptr(ptr, cpu) ({ (void)(cpu); VERIFY_PERCPU_PTR(ptr); })
>                                                 ^~~~~~~~~~~~~~~~~
> ./include/linux/percpu-defs.h:251:26: note: in expansion of macro ‘per_cpu_ptr’
>   #define raw_cpu_ptr(ptr) per_cpu_ptr(ptr, 0)
>                            ^~~~~~~~~~~
> ./include/asm-generic/percpu.h:123:21: note: in expansion of macro ‘raw_cpu_ptr’
>    __ret = READ_ONCE(*raw_cpu_ptr(&(pcp)));   \
>                       ^~~~~~~~~~~
> ./include/asm-generic/percpu.h:142:11: note: in expansion of macro ‘__this_cpu_generic_read_nopreempt’
>     __ret = __this_cpu_generic_read_nopreempt(pcp);  \
>             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> ./include/asm-generic/percpu.h:327:31: note: in expansion of macro ‘this_cpu_generic_read’
>   #define this_cpu_read_2(pcp)  this_cpu_generic_read(pcp)
>                                 ^~~~~~~~~~~~~~~~~~~~~
> ./include/linux/percpu-defs.h:309:23: note: in expansion of macro ‘this_cpu_read_2’
>    case 2: pscr_ret__ = stem##2(variable); break;   \
>                         ^~~~
> ./include/linux/percpu-defs.h:494:29: note: in expansion of macro ‘__pcpu_size_call_return’
>   #define this_cpu_read(pcp)  __pcpu_size_call_return(this_cpu_read_, pcp)
>                               ^~~~~~~~~~~~~~~~~~~~~~~
> arch/powerpc/lib/code-patching.c:150:7: note: in expansion of macro ‘this_cpu_read’
>    if (!this_cpu_read(*PTRRELOC(&text_poke_area)))
>         ^~~~~~~~~~~~~
> arch/powerpc/lib/code-patching.c:150:21: error: invalid type argument of unary ‘*’ (have ‘int’)
>    if (!this_cpu_read(*PTRRELOC(&text_poke_area)))
>                       ^~~~~~~~~~~~~~~~~~~~~~~~~~
> ./include/linux/compiler.h:341:22: note: in definition of macro ‘__READ_ONCE’
>     __read_once_size(&(x), __u.__c, sizeof(x));  \
>                        ^
> ./include/asm-generic/percpu.h:123:10: note: in expansion of macro ‘READ_ONCE’
>    __ret = READ_ONCE(*raw_cpu_ptr(&(pcp)));   \
>            ^~~~~~~~~
> ./include/linux/percpu-defs.h:246:2: note: in expansion of macro ‘__verify_pcpu_ptr’
>    __verify_pcpu_ptr(__p);      \
>    ^~~~~~~~~~~~~~~~~
> ./include/linux/percpu-defs.h:250:47: note: in expansion of macro ‘VERIFY_PERCPU_PTR’
>   #define per_cpu_ptr(ptr, cpu) ({ (void)(cpu); VERIFY_PERCPU_PTR(ptr); })
>                                                 ^~~~~~~~~~~~~~~~~
> ./include/linux/percpu-defs.h:251:26: note: in expansion of macro ‘per_cpu_ptr’
>   #define raw_cpu_ptr(ptr) per_cpu_ptr(ptr, 0)
>                            ^~~~~~~~~~~
> ./include/asm-generic/percpu.h:123:21: note: in expansion of macro ‘raw_cpu_ptr’
>    __ret = READ_ONCE(*raw_cpu_ptr(&(pcp)));   \
>                       ^~~~~~~~~~~
> ./include/asm-generic/percpu.h:142:11: note: in expansion of macro ‘__this_cpu_generic_read_nopreempt’
>     __ret = __this_cpu_generic_read_nopreempt(pcp);  \
>             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> ./include/asm-generic/percpu.h:327:31: note: in expansion of macro ‘this_cpu_generic_read’
>   #define this_cpu_read_2(pcp)  this_cpu_generic_read(pcp)
>                                 ^~~~~~~~~~~~~~~~~~~~~
> ./include/linux/percpu-defs.h:309:23: note: in expansion of macro ‘this_cpu_read_2’
>    case 2: pscr_ret__ = stem##2(variable); break;   \
>                         ^~~~
> ./include/linux/percpu-defs.h:494:29: note: in expansion of macro ‘__pcpu_size_call_return’
>   #define this_cpu_read(pcp)  __pcpu_size_call_return(this_cpu_read_, pcp)
>                               ^~~~~~~~~~~~~~~~~~~~~~~
> arch/powerpc/lib/code-patching.c:150:7: note: in expansion of macro ‘this_cpu_read’
>    if (!this_cpu_read(*PTRRELOC(&text_poke_area)))
>         ^~~~~~~~~~~~~
> arch/powerpc/lib/code-patching.c:150:21: error: invalid type argument of unary ‘*’ (have ‘int’)
>    if (!this_cpu_read(*PTRRELOC(&text_poke_area)))
>                       ^~~~~~~~~~~~~~~~~~~~~~~~~~
> ./include/linux/compiler.h:341:22: note: in definition of macro ‘__READ_ONCE’
>     __read_once_size(&(x), __u.__c, sizeof(x));  \
>                        ^
> ./include/asm-generic/percpu.h:123:10: note: in expansion of macro ‘READ_ONCE’
>    __ret = READ_ONCE(*raw_cpu_ptr(&(pcp)));   \
>            ^~~~~~~~~
> ./include/linux/percpu-defs.h:250:47: note: in expansion of macro ‘VERIFY_PERCPU_PTR’
>   #define per_cpu_ptr(ptr, cpu) ({ (void)(cpu); VERIFY_PERCPU_PTR(ptr); })
>                                                 ^~~~~~~~~~~~~~~~~
> ./include/linux/percpu-defs.h:251:26: note: in expansion of macro ‘per_cpu_ptr’
>   #define raw_cpu_ptr(ptr) per_cpu_ptr(ptr, 0)
>                            ^~~~~~~~~~~
> ./include/asm-generic/percpu.h:123:21: note: in expansion of macro ‘raw_cpu_ptr’
>    __ret = READ_ONCE(*raw_cpu_ptr(&(pcp)));   \
>                       ^~~~~~~~~~~
> ./include/asm-generic/percpu.h:142:11: note: in expansion of macro ‘__this_cpu_generic_read_nopreempt’
>     __ret = __this_cpu_generic_read_nopreempt(pcp);  \
>             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> ./include/asm-generic/percpu.h:327:31: note: in expansion of macro ‘this_cpu_generic_read’
>   #define this_cpu_read_2(pcp)  this_cpu_generic_read(pcp)
>                                 ^~~~~~~~~~~~~~~~~~~~~
> ./include/linux/percpu-defs.h:309:23: note: in expansion of macro ‘this_cpu_read_2’
>    case 2: pscr_ret__ = stem##2(variable); break;   \
>                         ^~~~
> ./include/linux/percpu-defs.h:494:29: note: in expansion of macro ‘__pcpu_size_call_return’
>   #define this_cpu_read(pcp)  __pcpu_size_call_return(this_cpu_read_, pcp)
>                               ^~~~~~~~~~~~~~~~~~~~~~~
> arch/powerpc/lib/code-patching.c:150:7: note: in expansion of macro ‘this_cpu_read’
>    if (!this_cpu_read(*PTRRELOC(&text_poke_area)))
>         ^~~~~~~~~~~~~
> arch/powerpc/lib/code-patching.c:150:21: error: invalid type argument of unary ‘*’ (have ‘int’)
>    if (!this_cpu_read(*PTRRELOC(&text_poke_area)))
>                       ^~~~~~~~~~~~~~~~~~~~~~~~~~
> ./include/linux/compiler.h:341:22: note: in definition of macro ‘__READ_ONCE’
>     __read_once_size(&(x), __u.__c, sizeof(x));  \
>                        ^
> ./include/asm-generic/percpu.h:123:10: note: in expansion of macro ‘READ_ONCE’
>    __ret = READ_ONCE(*raw_cpu_ptr(&(pcp)));   \
>            ^~~~~~~~~
> ./include/linux/percpu-defs.h:250:47: note: in expansion of macro ‘VERIFY_PERCPU_PTR’
>   #define per_cpu_ptr(ptr, cpu) ({ (void)(cpu); VERIFY_PERCPU_PTR(ptr); })
>                                                 ^~~~~~~~~~~~~~~~~
> ./include/linux/percpu-defs.h:251:26: note: in expansion of macro ‘per_cpu_ptr’
>   #define raw_cpu_ptr(ptr) per_cpu_ptr(ptr, 0)
>                            ^~~~~~~~~~~
> ./include/asm-generic/percpu.h:123:21: note: in expansion of macro ‘raw_cpu_ptr’
>    __ret = READ_ONCE(*raw_cpu_ptr(&(pcp)));   \
>                       ^~~~~~~~~~~
> ./include/asm-generic/percpu.h:142:11: note: in expansion of macro ‘__this_cpu_generic_read_nopreempt’
>     __ret = __this_cpu_generic_read_nopreempt(pcp);  \
>             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> ./include/asm-generic/percpu.h:327:31: note: in expansion of macro ‘this_cpu_generic_read’
>   #define this_cpu_read_2(pcp)  this_cpu_generic_read(pcp)
>                                 ^~~~~~~~~~~~~~~~~~~~~
> ./include/linux/percpu-defs.h:309:23: note: in expansion of macro ‘this_cpu_read_2’
>    case 2: pscr_ret__ = stem##2(variable); break;   \
>                         ^~~~
> ./include/linux/percpu-defs.h:494:29: note: in expansion of macro ‘__pcpu_size_call_return’
>   #define this_cpu_read(pcp)  __pcpu_size_call_return(this_cpu_read_, pcp)
>                               ^~~~~~~~~~~~~~~~~~~~~~~
> arch/powerpc/lib/code-patching.c:150:7: note: in expansion of macro ‘this_cpu_read’
>    if (!this_cpu_read(*PTRRELOC(&text_poke_area)))
>         ^~~~~~~~~~~~~
> arch/powerpc/lib/code-patching.c:150:21: error: invalid type argument of unary ‘*’ (have ‘int’)
>    if (!this_cpu_read(*PTRRELOC(&text_poke_area)))
>                       ^~~~~~~~~~~~~~~~~~~~~~~~~~
> ./include/linux/compiler.h:341:42: note: in definition of macro ‘__READ_ONCE’
>     __read_once_size(&(x), __u.__c, sizeof(x));  \
>                                            ^
> ./include/asm-generic/percpu.h:123:10: note: in expansion of macro ‘READ_ONCE’
>    __ret = READ_ONCE(*raw_cpu_ptr(&(pcp)));   \
>            ^~~~~~~~~
> ./include/linux/percpu-defs.h:246:2: note: in expansion of macro ‘__verify_pcpu_ptr’
>    __verify_pcpu_ptr(__p);      \
>    ^~~~~~~~~~~~~~~~~
> ./include/linux/percpu-defs.h:250:47: note: in expansion of macro ‘VERIFY_PERCPU_PTR’
>   #define per_cpu_ptr(ptr, cpu) ({ (void)(cpu); VERIFY_PERCPU_PTR(ptr); })
>                                                 ^~~~~~~~~~~~~~~~~
> ./include/linux/percpu-defs.h:251:26: note: in expansion of macro ‘per_cpu_ptr’
>   #define raw_cpu_ptr(ptr) per_cpu_ptr(ptr, 0)
>                            ^~~~~~~~~~~
> ./include/asm-generic/percpu.h:123:21: note: in expansion of macro ‘raw_cpu_ptr’
>    __ret = READ_ONCE(*raw_cpu_ptr(&(pcp)));   \
>                       ^~~~~~~~~~~
> ./include/asm-generic/percpu.h:142:11: note: in expansion of macro ‘__this_cpu_generic_read_nopreempt’
>     __ret = __this_cpu_generic_read_nopreempt(pcp);  \
>             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> ./include/asm-generic/percpu.h:327:31: note: in expansion of macro ‘this_cpu_generic_read’
>   #define this_cpu_read_2(pcp)  this_cpu_generic_read(pcp)
>                                 ^~~~~~~~~~~~~~~~~~~~~
> ./include/linux/percpu-defs.h:309:23: note: in expansion of macro ‘this_cpu_read_2’
>    case 2: pscr_ret__ = stem##2(variable); break;   \
>                         ^~~~
> ./include/linux/percpu-defs.h:494:29: note: in expansion of macro ‘__pcpu_size_call_return’
>   #define this_cpu_read(pcp)  __pcpu_size_call_return(this_cpu_read_, pcp)
>                               ^~~~~~~~~~~~~~~~~~~~~~~
> arch/powerpc/lib/code-patching.c:150:7: note: in expansion of macro ‘this_cpu_read’
>    if (!this_cpu_read(*PTRRELOC(&text_poke_area)))
>         ^~~~~~~~~~~~~
> arch/powerpc/lib/code-patching.c:150:21: error: invalid type argument of unary ‘*’ (have ‘int’)
>    if (!this_cpu_read(*PTRRELOC(&text_poke_area)))
>                       ^~~~~~~~~~~~~~~~~~~~~~~~~~
> ./include/linux/compiler.h:341:42: note: in definition of macro ‘__READ_ONCE’
>     __read_once_size(&(x), __u.__c, sizeof(x));  \
>                                            ^
> ./include/asm-generic/percpu.h:123:10: note: in expansion of macro ‘READ_ONCE’
>    __ret = READ_ONCE(*raw_cpu_ptr(&(pcp)));   \
>            ^~~~~~~~~
> ./include/linux/percpu-defs.h:250:47: note: in expansion of macro ‘VERIFY_PERCPU_PTR’
>   #define per_cpu_ptr(ptr, cpu) ({ (void)(cpu); VERIFY_PERCPU_PTR(ptr); })
>                                                 ^~~~~~~~~~~~~~~~~
> ./include/linux/percpu-defs.h:251:26: note: in expansion of macro ‘per_cpu_ptr’
>   #define raw_cpu_ptr(ptr) per_cpu_ptr(ptr, 0)
>                            ^~~~~~~~~~~
> ./include/asm-generic/percpu.h:123:21: note: in expansion of macro ‘raw_cpu_ptr’
>    __ret = READ_ONCE(*raw_cpu_ptr(&(pcp)));   \
>                       ^~~~~~~~~~~
> ./include/asm-generic/percpu.h:142:11: note: in expansion of macro ‘__this_cpu_generic_read_nopreempt’
>     __ret = __this_cpu_generic_read_nopreempt(pcp);  \
>             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> ./include/asm-generic/percpu.h:327:31: note: in expansion of macro ‘this_cpu_generic_read’
>   #define this_cpu_read_2(pcp)  this_cpu_generic_read(pcp)
>                                 ^~~~~~~~~~~~~~~~~~~~~
> ./include/linux/percpu-defs.h:309:23: note: in expansion of macro ‘this_cpu_read_2’
>    case 2: pscr_ret__ = stem##2(variable); break;   \
>                         ^~~~
> ./include/linux/percpu-defs.h:494:29: note: in expansion of macro ‘__pcpu_size_call_return’
>   #define this_cpu_read(pcp)  __pcpu_size_call_return(this_cpu_read_, pcp)
>                               ^~~~~~~~~~~~~~~~~~~~~~~
> arch/powerpc/lib/code-patching.c:150:7: note: in expansion of macro ‘this_cpu_read’
>    if (!this_cpu_read(*PTRRELOC(&text_poke_area)))
>         ^~~~~~~~~~~~~
> arch/powerpc/lib/code-patching.c:150:21: error: invalid type argument of unary ‘*’ (have ‘int’)
>    if (!this_cpu_read(*PTRRELOC(&text_poke_area)))
>                       ^~~~~~~~~~~~~~~~~~~~~~~~~~
> ./include/linux/compiler.h:341:42: note: in definition of macro ‘__READ_ONCE’
>     __read_once_size(&(x), __u.__c, sizeof(x));  \
>                                            ^
> ./include/asm-generic/percpu.h:123:10: note: in expansion of macro ‘READ_ONCE’
>    __ret = READ_ONCE(*raw_cpu_ptr(&(pcp)));   \
>            ^~~~~~~~~
> ./include/linux/percpu-defs.h:250:47: note: in expansion of macro ‘VERIFY_PERCPU_PTR’
>   #define per_cpu_ptr(ptr, cpu) ({ (void)(cpu); VERIFY_PERCPU_PTR(ptr); })
>                                                 ^~~~~~~~~~~~~~~~~
> ./include/linux/percpu-defs.h:251:26: note: in expansion of macro ‘per_cpu_ptr’
>   #define raw_cpu_ptr(ptr) per_cpu_ptr(ptr, 0)
>                            ^~~~~~~~~~~
> ./include/asm-generic/percpu.h:123:21: note: in expansion of macro ‘raw_cpu_ptr’
>    __ret = READ_ONCE(*raw_cpu_ptr(&(pcp)));   \
>                       ^~~~~~~~~~~
> ./include/asm-generic/percpu.h:142:11: note: in expansion of macro ‘__this_cpu_generic_read_nopreempt’
>     __ret = __this_cpu_generic_read_nopreempt(pcp);  \
>             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> ./include/asm-generic/percpu.h:327:31: note: in expansion of macro ‘this_cpu_generic_read’
>   #define this_cpu_read_2(pcp)  this_cpu_generic_read(pcp)
>                                 ^~~~~~~~~~~~~~~~~~~~~
> ./include/linux/percpu-defs.h:309:23: note: in expansion of macro ‘this_cpu_read_2’
>    case 2: pscr_ret__ = stem##2(variable); break;   \
>                         ^~~~
> ./include/linux/percpu-defs.h:494:29: note: in expansion of macro ‘__pcpu_size_call_return’
>   #define this_cpu_read(pcp)  __pcpu_size_call_return(this_cpu_read_, pcp)
>                               ^~~~~~~~~~~~~~~~~~~~~~~
> arch/powerpc/lib/code-patching.c:150:7: note: in expansion of macro ‘this_cpu_read’
>    if (!this_cpu_read(*PTRRELOC(&text_poke_area)))
>         ^~~~~~~~~~~~~
> arch/powerpc/lib/code-patching.c:150:21: error: invalid type argument of unary ‘*’ (have ‘int’)
>    if (!this_cpu_read(*PTRRELOC(&text_poke_area)))
>                       ^~~~~~~~~~~~~~~~~~~~~~~~~~
> ./include/linux/compiler.h:343:30: note: in definition of macro ‘__READ_ONCE’
>     __read_once_size_nocheck(&(x), __u.__c, sizeof(x)); \
>                                ^
> ./include/asm-generic/percpu.h:123:10: note: in expansion of macro ‘READ_ONCE’
>    __ret = READ_ONCE(*raw_cpu_ptr(&(pcp)));   \
>            ^~~~~~~~~
> ./include/linux/percpu-defs.h:246:2: note: in expansion of macro ‘__verify_pcpu_ptr’
>    __verify_pcpu_ptr(__p);      \
>    ^~~~~~~~~~~~~~~~~
> ./include/linux/percpu-defs.h:250:47: note: in expansion of macro ‘VERIFY_PERCPU_PTR’
>   #define per_cpu_ptr(ptr, cpu) ({ (void)(cpu); VERIFY_PERCPU_PTR(ptr); })
>                                                 ^~~~~~~~~~~~~~~~~
> ./include/linux/percpu-defs.h:251:26: note: in expansion of macro ‘per_cpu_ptr’
>   #define raw_cpu_ptr(ptr) per_cpu_ptr(ptr, 0)
>                            ^~~~~~~~~~~
> ./include/asm-generic/percpu.h:123:21: note: in expansion of macro ‘raw_cpu_ptr’
>    __ret = READ_ONCE(*raw_cpu_ptr(&(pcp)));   \
>                       ^~~~~~~~~~~
> ./include/asm-generic/percpu.h:142:11: note: in expansion of macro ‘__this_cpu_generic_read_nopreempt’
>     __ret = __this_cpu_generic_read_nopreempt(pcp);  \
>             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> ./include/asm-generic/percpu.h:327:31: note: in expansion of macro ‘this_cpu_generic_read’
>   #define this_cpu_read_2(pcp)  this_cpu_generic_read(pcp)
>                                 ^~~~~~~~~~~~~~~~~~~~~
> ./include/linux/percpu-defs.h:309:23: note: in expansion of macro ‘this_cpu_read_2’
>    case 2: pscr_ret__ = stem##2(variable); break;   \
>                         ^~~~
> ./include/linux/percpu-defs.h:494:29: note: in expansion of macro ‘__pcpu_size_call_return’
>   #define this_cpu_read(pcp)  __pcpu_size_call_return(this_cpu_read_, pcp)
>                               ^~~~~~~~~~~~~~~~~~~~~~~
> arch/powerpc/lib/code-patching.c:150:7: note: in expansion of macro ‘this_cpu_read’
>    if (!this_cpu_read(*PTRRELOC(&text_poke_area)))
>         ^~~~~~~~~~~~~
> arch/powerpc/lib/code-patching.c:150:21: error: invalid type argument of unary ‘*’ (have ‘int’)
>    if (!this_cpu_read(*PTRRELOC(&text_poke_area)))
>                       ^~~~~~~~~~~~~~~~~~~~~~~~~~
> ./include/linux/compiler.h:343:30: note: in definition of macro ‘__READ_ONCE’
>     __read_once_size_nocheck(&(x), __u.__c, sizeof(x)); \
>                                ^
> ./include/asm-generic/percpu.h:123:10: note: in expansion of macro ‘READ_ONCE’
>    __ret = READ_ONCE(*raw_cpu_ptr(&(pcp)));   \
>            ^~~~~~~~~
> ./include/linux/percpu-defs.h:250:47: note: in expansion of macro ‘VERIFY_PERCPU_PTR’
>   #define per_cpu_ptr(ptr, cpu) ({ (void)(cpu); VERIFY_PERCPU_PTR(ptr); })
>                                                 ^~~~~~~~~~~~~~~~~
> ./include/linux/percpu-defs.h:251:26: note: in expansion of macro ‘per_cpu_ptr’
>   #define raw_cpu_ptr(ptr) per_cpu_ptr(ptr, 0)
>                            ^~~~~~~~~~~
> ./include/asm-generic/percpu.h:123:21: note: in expansion of macro ‘raw_cpu_ptr’
>    __ret = READ_ONCE(*raw_cpu_ptr(&(pcp)));   \
>                       ^~~~~~~~~~~
> ./include/asm-generic/percpu.h:142:11: note: in expansion of macro ‘__this_cpu_generic_read_nopreempt’
>     __ret = __this_cpu_generic_read_nopreempt(pcp);  \
>             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> ./include/asm-generic/percpu.h:327:31: note: in expansion of macro ‘this_cpu_generic_read’
>   #define this_cpu_read_2(pcp)  this_cpu_generic_read(pcp)
>                                 ^~~~~~~~~~~~~~~~~~~~~
> ./include/linux/percpu-defs.h:309:23: note: in expansion of macro ‘this_cpu_read_2’
>    case 2: pscr_ret__ = stem##2(variable); break;   \
>                         ^~~~
> ./include/linux/percpu-defs.h:494:29: note: in expansion of macro ‘__pcpu_size_call_return’
>   #define this_cpu_read(pcp)  __pcpu_size_call_return(this_cpu_read_, pcp)
>                               ^~~~~~~~~~~~~~~~~~~~~~~
> arch/powerpc/lib/code-patching.c:150:7: note: in expansion of macro ‘this_cpu_read’
>    if (!this_cpu_read(*PTRRELOC(&text_poke_area)))
>         ^~~~~~~~~~~~~
> arch/powerpc/lib/code-patching.c:150:21: error: invalid type argument of unary ‘*’ (have ‘int’)
>    if (!this_cpu_read(*PTRRELOC(&text_poke_area)))
>                       ^~~~~~~~~~~~~~~~~~~~~~~~~~
> ./include/linux/compiler.h:343:30: note: in definition of macro ‘__READ_ONCE’
>     __read_once_size_nocheck(&(x), __u.__c, sizeof(x)); \
>                                ^
> ./include/asm-generic/percpu.h:123:10: note: in expansion of macro ‘READ_ONCE’
>    __ret = READ_ONCE(*raw_cpu_ptr(&(pcp)));   \
>            ^~~~~~~~~
> ./include/linux/percpu-defs.h:250:47: note: in expansion of macro ‘VERIFY_PERCPU_PTR’
>   #define per_cpu_ptr(ptr, cpu) ({ (void)(cpu); VERIFY_PERCPU_PTR(ptr); })
>                                                 ^~~~~~~~~~~~~~~~~
> ./include/linux/percpu-defs.h:251:26: note: in expansion of macro ‘per_cpu_ptr’
>   #define raw_cpu_ptr(ptr) per_cpu_ptr(ptr, 0)
>                            ^~~~~~~~~~~
> ./include/asm-generic/percpu.h:123:21: note: in expansion of macro ‘raw_cpu_ptr’
>    __ret = READ_ONCE(*raw_cpu_ptr(&(pcp)));   \
>                       ^~~~~~~~~~~
> ./include/asm-generic/percpu.h:142:11: note: in expansion of macro ‘__this_cpu_generic_read_nopreempt’
>     __ret = __this_cpu_generic_read_nopreempt(pcp);  \
>             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> ./include/asm-generic/percpu.h:327:31: note: in expansion of macro ‘this_cpu_generic_read’
>   #define this_cpu_read_2(pcp)  this_cpu_generic_read(pcp)
>                                 ^~~~~~~~~~~~~~~~~~~~~
> ./include/linux/percpu-defs.h:309:23: note: in expansion of macro ‘this_cpu_read_2’
>    case 2: pscr_ret__ = stem##2(variable); break;   \
>                         ^~~~
> ./include/linux/percpu-defs.h:494:29: note: in expansion of macro ‘__pcpu_size_call_return’
>   #define this_cpu_read(pcp)  __pcpu_size_call_return(this_cpu_read_, pcp)
>                               ^~~~~~~~~~~~~~~~~~~~~~~
> arch/powerpc/lib/code-patching.c:150:7: note: in expansion of macro ‘this_cpu_read’
>    if (!this_cpu_read(*PTRRELOC(&text_poke_area)))
>         ^~~~~~~~~~~~~
> arch/powerpc/lib/code-patching.c:150:21: error: invalid type argument of unary ‘*’ (have ‘int’)
>    if (!this_cpu_read(*PTRRELOC(&text_poke_area)))
>                       ^~~~~~~~~~~~~~~~~~~~~~~~~~
> ./include/linux/compiler.h:343:50: note: in definition of macro ‘__READ_ONCE’
>     __read_once_size_nocheck(&(x), __u.__c, sizeof(x)); \
>                                                    ^
> ./include/asm-generic/percpu.h:123:10: note: in expansion of macro ‘READ_ONCE’
>    __ret = READ_ONCE(*raw_cpu_ptr(&(pcp)));   \
>            ^~~~~~~~~
> ./include/linux/percpu-defs.h:246:2: note: in expansion of macro ‘__verify_pcpu_ptr’
>    __verify_pcpu_ptr(__p);      \
>    ^~~~~~~~~~~~~~~~~
> ./include/linux/percpu-defs.h:250:47: note: in expansion of macro ‘VERIFY_PERCPU_PTR’
>   #define per_cpu_ptr(ptr, cpu) ({ (void)(cpu); VERIFY_PERCPU_PTR(ptr); })
>                                                 ^~~~~~~~~~~~~~~~~
> ./include/linux/percpu-defs.h:251:26: note: in expansion of macro ‘per_cpu_ptr’
>   #define raw_cpu_ptr(ptr) per_cpu_ptr(ptr, 0)
>                            ^~~~~~~~~~~
> ./include/asm-generic/percpu.h:123:21: note: in expansion of macro ‘raw_cpu_ptr’
>    __ret = READ_ONCE(*raw_cpu_ptr(&(pcp)));   \
>                       ^~~~~~~~~~~
> ./include/asm-generic/percpu.h:142:11: note: in expansion of macro ‘__this_cpu_generic_read_nopreempt’
>     __ret = __this_cpu_generic_read_nopreempt(pcp);  \
>             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> ./include/asm-generic/percpu.h:327:31: note: in expansion of macro ‘this_cpu_generic_read’
>   #define this_cpu_read_2(pcp)  this_cpu_generic_read(pcp)
>                                 ^~~~~~~~~~~~~~~~~~~~~
> ./include/linux/percpu-defs.h:309:23: note: in expansion of macro ‘this_cpu_read_2’
>    case 2: pscr_ret__ = stem##2(variable); break;   \
>                         ^~~~
> ./include/linux/percpu-defs.h:494:29: note: in expansion of macro ‘__pcpu_size_call_return’
>   #define this_cpu_read(pcp)  __pcpu_size_call_return(this_cpu_read_, pcp)
>                               ^~~~~~~~~~~~~~~~~~~~~~~
> arch/powerpc/lib/code-patching.c:150:7: note: in expansion of macro ‘this_cpu_read’
>    if (!this_cpu_read(*PTRRELOC(&text_poke_area)))
>         ^~~~~~~~~~~~~
> arch/powerpc/lib/code-patching.c:150:21: error: invalid type argument of unary ‘*’ (have ‘int’)
>    if (!this_cpu_read(*PTRRELOC(&text_poke_area)))
>                       ^~~~~~~~~~~~~~~~~~~~~~~~~~
> ./include/linux/compiler.h:343:50: note: in definition of macro ‘__READ_ONCE’
>     __read_once_size_nocheck(&(x), __u.__c, sizeof(x)); \
>                                                    ^
> ./include/asm-generic/percpu.h:123:10: note: in expansion of macro ‘READ_ONCE’
>    __ret = READ_ONCE(*raw_cpu_ptr(&(pcp)));   \
>            ^~~~~~~~~
> ./include/linux/percpu-defs.h:250:47: note: in expansion of macro ‘VERIFY_PERCPU_PTR’
>   #define per_cpu_ptr(ptr, cpu) ({ (void)(cpu); VERIFY_PERCPU_PTR(ptr); })
>                                                 ^~~~~~~~~~~~~~~~~
> ./include/linux/percpu-defs.h:251:26: note: in expansion of macro ‘per_cpu_ptr’
>   #define raw_cpu_ptr(ptr) per_cpu_ptr(ptr, 0)
>                            ^~~~~~~~~~~
> ./include/asm-generic/percpu.h:123:21: note: in expansion of macro ‘raw_cpu_ptr’
>    __ret = READ_ONCE(*raw_cpu_ptr(&(pcp)));   \
>                       ^~~~~~~~~~~
> ./include/asm-generic/percpu.h:142:11: note: in expansion of macro ‘__this_cpu_generic_read_nopreempt’
>     __ret = __this_cpu_generic_read_nopreempt(pcp);  \
>             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> ./include/asm-generic/percpu.h:327:31: note: in expansion of macro ‘this_cpu_generic_read’
>   #define this_cpu_read_2(pcp)  this_cpu_generic_read(pcp)
>                                 ^~~~~~~~~~~~~~~~~~~~~
> ./include/linux/percpu-defs.h:309:23: note: in expansion of macro ‘this_cpu_read_2’
>    case 2: pscr_ret__ = stem##2(variable); break;   \
>                         ^~~~
> ./include/linux/percpu-defs.h:494:29: note: in expansion of macro ‘__pcpu_size_call_return’
>   #define this_cpu_read(pcp)  __pcpu_size_call_return(this_cpu_read_, pcp)
>                               ^~~~~~~~~~~~~~~~~~~~~~~
> arch/powerpc/lib/code-patching.c:150:7: note: in expansion of macro ‘this_cpu_read’
>    if (!this_cpu_read(*PTRRELOC(&text_poke_area)))
>         ^~~~~~~~~~~~~
> arch/powerpc/lib/code-patching.c:150:21: error: invalid type argument of unary ‘*’ (have ‘int’)
>    if (!this_cpu_read(*PTRRELOC(&text_poke_area)))
>                       ^~~~~~~~~~~~~~~~~~~~~~~~~~
> ./include/linux/compiler.h:343:50: note: in definition of macro ‘__READ_ONCE’
>     __read_once_size_nocheck(&(x), __u.__c, sizeof(x)); \
>                                                    ^
> ./include/asm-generic/percpu.h:123:10: note: in expansion of macro ‘READ_ONCE’
>    __ret = READ_ONCE(*raw_cpu_ptr(&(pcp)));   \
>            ^~~~~~~~~
> ./include/linux/percpu-defs.h:250:47: note: in expansion of macro ‘VERIFY_PERCPU_PTR’
>   #define per_cpu_ptr(ptr, cpu) ({ (void)(cpu); VERIFY_PERCPU_PTR(ptr); })
>                                                 ^~~~~~~~~~~~~~~~~
> ./include/linux/percpu-defs.h:251:26: note: in expansion of macro ‘per_cpu_ptr’
>   #define raw_cpu_ptr(ptr) per_cpu_ptr(ptr, 0)
>                            ^~~~~~~~~~~
> ./include/asm-generic/percpu.h:123:21: note: in expansion of macro ‘raw_cpu_ptr’
>    __ret = READ_ONCE(*raw_cpu_ptr(&(pcp)));   \
>                       ^~~~~~~~~~~
> ./include/asm-generic/percpu.h:142:11: note: in expansion of macro ‘__this_cpu_generic_read_nopreempt’
>     __ret = __this_cpu_generic_read_nopreempt(pcp);  \
>             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> ./include/asm-generic/percpu.h:327:31: note: in expansion of macro ‘this_cpu_generic_read’
>   #define this_cpu_read_2(pcp)  this_cpu_generic_read(pcp)
>                                 ^~~~~~~~~~~~~~~~~~~~~
> ./include/linux/percpu-defs.h:309:23: note: in expansion of macro ‘this_cpu_read_2’
>    case 2: pscr_ret__ = stem##2(variable); break;   \
>                         ^~~~
> ./include/linux/percpu-defs.h:494:29: note: in expansion of macro ‘__pcpu_size_call_return’
>   #define this_cpu_read(pcp)  __pcpu_size_call_return(this_cpu_read_, pcp)
>                               ^~~~~~~~~~~~~~~~~~~~~~~
> arch/powerpc/lib/code-patching.c:150:7: note: in expansion of macro ‘this_cpu_read’
>    if (!this_cpu_read(*PTRRELOC(&text_poke_area)))
>         ^~~~~~~~~~~~~
> In file included from ./arch/powerpc/include/asm/percpu.h:20:0,
>                   from ./include/linux/percpu.h:13,
>                   from ./include/linux/kprobes.h:38,
>                   from arch/powerpc/lib/code-patching.c:11:
> arch/powerpc/lib/code-patching.c:150:21: error: invalid type argument of unary ‘*’ (have ‘int’)
>    if (!this_cpu_read(*PTRRELOC(&text_poke_area)))
>                       ^~~~~~~~~~~~~~~~~~~~~~~~~~
> ./include/asm-generic/percpu.h:130:9: note: in definition of macro ‘__this_cpu_generic_read_noirq’
>    typeof(pcp) __ret;      \
>           ^~~
> ./include/asm-generic/percpu.h:327:31: note: in expansion of macro ‘this_cpu_generic_read’
>   #define this_cpu_read_2(pcp)  this_cpu_generic_read(pcp)
>                                 ^~~~~~~~~~~~~~~~~~~~~
> ./include/linux/percpu-defs.h:309:23: note: in expansion of macro ‘this_cpu_read_2’
>    case 2: pscr_ret__ = stem##2(variable); break;   \
>                         ^~~~
> ./include/linux/percpu-defs.h:494:29: note: in expansion of macro ‘__pcpu_size_call_return’
>   #define this_cpu_read(pcp)  __pcpu_size_call_return(this_cpu_read_, pcp)
>                               ^~~~~~~~~~~~~~~~~~~~~~~
> arch/powerpc/lib/code-patching.c:150:7: note: in expansion of macro ‘this_cpu_read’
>    if (!this_cpu_read(*PTRRELOC(&text_poke_area)))
>         ^~~~~~~~~~~~~
> In file included from ./include/asm-generic/percpu.h:7:0,
>                   from ./arch/powerpc/include/asm/percpu.h:20,
>                   from ./include/linux/percpu.h:13,
>                   from ./include/linux/kprobes.h:38,
>                   from arch/powerpc/lib/code-patching.c:11:
> arch/powerpc/lib/code-patching.c:150:21: error: invalid type argument of unary ‘*’ (have ‘int’)
>    if (!this_cpu_read(*PTRRELOC(&text_poke_area)))
>                       ^~~~~~~~~~~~~~~~~~~~~~~~~~
> ./include/linux/percpu-defs.h:206:47: note: in definition of macro ‘__verify_pcpu_ptr’
>    const void __percpu *__vpp_verify = (typeof((ptr) + 0))NULL; \
>                                                 ^~~
> ./include/linux/percpu-defs.h:250:47: note: in expansion of macro ‘VERIFY_PERCPU_PTR’
>   #define per_cpu_ptr(ptr, cpu) ({ (void)(cpu); VERIFY_PERCPU_PTR(ptr); })
>                                                 ^~~~~~~~~~~~~~~~~
> ./include/linux/percpu-defs.h:251:26: note: in expansion of macro ‘per_cpu_ptr’
>   #define raw_cpu_ptr(ptr) per_cpu_ptr(ptr, 0)
>                            ^~~~~~~~~~~
> ./include/asm-generic/percpu.h:71:3: note: in expansion of macro ‘raw_cpu_ptr’
>    *raw_cpu_ptr(&(pcp));      \
>     ^~~~~~~~~~~
> ./include/asm-generic/percpu.h:133:10: note: in expansion of macro ‘raw_cpu_generic_read’
>    __ret = raw_cpu_generic_read(pcp);    \
>            ^~~~~~~~~~~~~~~~~~~~
> ./include/asm-generic/percpu.h:144:11: note: in expansion of macro ‘__this_cpu_generic_read_noirq’
>     __ret = __this_cpu_generic_read_noirq(pcp);  \
>             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> ./include/asm-generic/percpu.h:327:31: note: in expansion of macro ‘this_cpu_generic_read’
>   #define this_cpu_read_2(pcp)  this_cpu_generic_read(pcp)
>                                 ^~~~~~~~~~~~~~~~~~~~~
> ./include/linux/percpu-defs.h:309:23: note: in expansion of macro ‘this_cpu_read_2’
>    case 2: pscr_ret__ = stem##2(variable); break;   \
>                         ^~~~
> ./include/linux/percpu-defs.h:494:29: note: in expansion of macro ‘__pcpu_size_call_return’
>   #define this_cpu_read(pcp)  __pcpu_size_call_return(this_cpu_read_, pcp)
>                               ^~~~~~~~~~~~~~~~~~~~~~~
> arch/powerpc/lib/code-patching.c:150:7: note: in expansion of macro ‘this_cpu_read’
>    if (!this_cpu_read(*PTRRELOC(&text_poke_area)))
>         ^~~~~~~~~~~~~
> arch/powerpc/lib/code-patching.c:150:21: error: invalid type argument of unary ‘*’ (have ‘int’)
>    if (!this_cpu_read(*PTRRELOC(&text_poke_area)))
>                       ^~~~~~~~~~~~~~~~~~~~~~~~~~
> ./include/linux/percpu-defs.h:247:12: note: in definition of macro ‘VERIFY_PERCPU_PTR’
>    (typeof(*(__p)) __kernel __force *)(__p);   \
>              ^~~
> ./include/linux/percpu-defs.h:251:26: note: in expansion of macro ‘per_cpu_ptr’
>   #define raw_cpu_ptr(ptr) per_cpu_ptr(ptr, 0)
>                            ^~~~~~~~~~~
> ./include/asm-generic/percpu.h:71:3: note: in expansion of macro ‘raw_cpu_ptr’
>    *raw_cpu_ptr(&(pcp));      \
>     ^~~~~~~~~~~
> ./include/asm-generic/percpu.h:133:10: note: in expansion of macro ‘raw_cpu_generic_read’
>    __ret = raw_cpu_generic_read(pcp);    \
>            ^~~~~~~~~~~~~~~~~~~~
> ./include/asm-generic/percpu.h:144:11: note: in expansion of macro ‘__this_cpu_generic_read_noirq’
>     __ret = __this_cpu_generic_read_noirq(pcp);  \
>             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> ./include/asm-generic/percpu.h:327:31: note: in expansion of macro ‘this_cpu_generic_read’
>   #define this_cpu_read_2(pcp)  this_cpu_generic_read(pcp)
>                                 ^~~~~~~~~~~~~~~~~~~~~
> ./include/linux/percpu-defs.h:309:23: note: in expansion of macro ‘this_cpu_read_2’
>    case 2: pscr_ret__ = stem##2(variable); break;   \
>                         ^~~~
> ./include/linux/percpu-defs.h:494:29: note: in expansion of macro ‘__pcpu_size_call_return’
>   #define this_cpu_read(pcp)  __pcpu_size_call_return(this_cpu_read_, pcp)
>                               ^~~~~~~~~~~~~~~~~~~~~~~
> arch/powerpc/lib/code-patching.c:150:7: note: in expansion of macro ‘this_cpu_read’
>    if (!this_cpu_read(*PTRRELOC(&text_poke_area)))
>         ^~~~~~~~~~~~~
> arch/powerpc/lib/code-patching.c:150:21: error: invalid type argument of unary ‘*’ (have ‘int’)
>    if (!this_cpu_read(*PTRRELOC(&text_poke_area)))
>                       ^~~~~~~~~~~~~~~~~~~~~~~~~~
> ./include/linux/percpu-defs.h:247:38: note: in definition of macro ‘VERIFY_PERCPU_PTR’
>    (typeof(*(__p)) __kernel __force *)(__p);   \
>                                        ^~~
> ./include/linux/percpu-defs.h:251:26: note: in expansion of macro ‘per_cpu_ptr’
>   #define raw_cpu_ptr(ptr) per_cpu_ptr(ptr, 0)
>                            ^~~~~~~~~~~
> ./include/asm-generic/percpu.h:71:3: note: in expansion of macro ‘raw_cpu_ptr’
>    *raw_cpu_ptr(&(pcp));      \
>     ^~~~~~~~~~~
> ./include/asm-generic/percpu.h:133:10: note: in expansion of macro ‘raw_cpu_generic_read’
>    __ret = raw_cpu_generic_read(pcp);    \
>            ^~~~~~~~~~~~~~~~~~~~
> ./include/asm-generic/percpu.h:144:11: note: in expansion of macro ‘__this_cpu_generic_read_noirq’
>     __ret = __this_cpu_generic_read_noirq(pcp);  \
>             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> ./include/asm-generic/percpu.h:327:31: note: in expansion of macro ‘this_cpu_generic_read’
>   #define this_cpu_read_2(pcp)  this_cpu_generic_read(pcp)
>                                 ^~~~~~~~~~~~~~~~~~~~~
> ./include/linux/percpu-defs.h:309:23: note: in expansion of macro ‘this_cpu_read_2’
>    case 2: pscr_ret__ = stem##2(variable); break;   \
>                         ^~~~
> ./include/linux/percpu-defs.h:494:29: note: in expansion of macro ‘__pcpu_size_call_return’
>   #define this_cpu_read(pcp)  __pcpu_size_call_return(this_cpu_read_, pcp)
>                               ^~~~~~~~~~~~~~~~~~~~~~~
> arch/powerpc/lib/code-patching.c:150:7: note: in expansion of macro ‘this_cpu_read’
>    if (!this_cpu_read(*PTRRELOC(&text_poke_area)))
>         ^~~~~~~~~~~~~
> In file included from ./arch/powerpc/include/asm/percpu.h:20:0,
>                   from ./include/linux/percpu.h:13,
>                   from ./include/linux/kprobes.h:38,
>                   from arch/powerpc/lib/code-patching.c:11:
> arch/powerpc/lib/code-patching.c:150:21: error: invalid type argument of unary ‘*’ (have ‘int’)
>    if (!this_cpu_read(*PTRRELOC(&text_poke_area)))
>                       ^~~~~~~~~~~~~~~~~~~~~~~~~~
> ./include/asm-generic/percpu.h:140:9: note: in definition of macro ‘this_cpu_generic_read’
>    typeof(pcp) __ret;      \
>           ^~~
> ./include/linux/percpu-defs.h:310:23: note: in expansion of macro ‘this_cpu_read_4’
>    case 4: pscr_ret__ = stem##4(variable); break;   \
>                         ^~~~
> ./include/linux/percpu-defs.h:494:29: note: in expansion of macro ‘__pcpu_size_call_return’
>   #define this_cpu_read(pcp)  __pcpu_size_call_return(this_cpu_read_, pcp)
>                               ^~~~~~~~~~~~~~~~~~~~~~~
> arch/powerpc/lib/code-patching.c:150:7: note: in expansion of macro ‘this_cpu_read’
>    if (!this_cpu_read(*PTRRELOC(&text_poke_area)))
>         ^~~~~~~~~~~~~
> In file included from ./include/linux/linkage.h:5:0,
>                   from ./include/linux/kernel.h:7,
>                   from arch/powerpc/lib/code-patching.c:10:
> arch/powerpc/lib/code-patching.c:150:21: error: invalid type argument of unary ‘*’ (have ‘int’)
>    if (!this_cpu_read(*PTRRELOC(&text_poke_area)))
>                       ^~~~~~~~~~~~~~~~~~~~~~~~~~
> ./include/linux/compiler.h:524:35: note: in definition of macro ‘__native_word’
>   # define __native_word(t) (sizeof(t) == sizeof(char) || sizeof(t) == sizeof(short) || sizeof(t) == sizeof(int) || sizeof(t) == sizeof(long))
>                                     ^
> ./include/asm-generic/percpu.h:330:31: note: in expansion of macro ‘this_cpu_generic_read’
>   #define this_cpu_read_4(pcp)  this_cpu_generic_read(pcp)
>                                 ^~~~~~~~~~~~~~~~~~~~~
> ./include/linux/percpu-defs.h:310:23: note: in expansion of macro ‘this_cpu_read_4’
>    case 4: pscr_ret__ = stem##4(variable); break;   \
>                         ^~~~
> ./include/linux/percpu-defs.h:494:29: note: in expansion of macro ‘__pcpu_size_call_return’
>   #define this_cpu_read(pcp)  __pcpu_size_call_return(this_cpu_read_, pcp)
>                               ^~~~~~~~~~~~~~~~~~~~~~~
> arch/powerpc/lib/code-patching.c:150:7: note: in expansion of macro ‘this_cpu_read’
>    if (!this_cpu_read(*PTRRELOC(&text_poke_area)))
>         ^~~~~~~~~~~~~
> arch/powerpc/lib/code-patching.c:150:21: error: invalid type argument of unary ‘*’ (have ‘int’)
>    if (!this_cpu_read(*PTRRELOC(&text_poke_area)))
>                       ^~~~~~~~~~~~~~~~~~~~~~~~~~
> ./include/linux/compiler.h:524:64: note: in definition of macro ‘__native_word’
>   # define __native_word(t) (sizeof(t) == sizeof(char) || sizeof(t) == sizeof(short) || sizeof(t) == sizeof(int) || sizeof(t) == sizeof(long))
>                                                                  ^
> ./include/asm-generic/percpu.h:330:31: note: in expansion of macro ‘this_cpu_generic_read’
>   #define this_cpu_read_4(pcp)  this_cpu_generic_read(pcp)
>                                 ^~~~~~~~~~~~~~~~~~~~~
> ./include/linux/percpu-defs.h:310:23: note: in expansion of macro ‘this_cpu_read_4’
>    case 4: pscr_ret__ = stem##4(variable); break;   \
>                         ^~~~
> ./include/linux/percpu-defs.h:494:29: note: in expansion of macro ‘__pcpu_size_call_return’
>   #define this_cpu_read(pcp)  __pcpu_size_call_return(this_cpu_read_, pcp)
>                               ^~~~~~~~~~~~~~~~~~~~~~~
> arch/powerpc/lib/code-patching.c:150:7: note: in expansion of macro ‘this_cpu_read’
>    if (!this_cpu_read(*PTRRELOC(&text_poke_area)))
>         ^~~~~~~~~~~~~
> arch/powerpc/lib/code-patching.c:150:21: error: invalid type argument of unary ‘*’ (have ‘int’)
>    if (!this_cpu_read(*PTRRELOC(&text_poke_area)))
>                       ^~~~~~~~~~~~~~~~~~~~~~~~~~
> ./include/linux/compiler.h:524:94: note: in definition of macro ‘__native_word’
>   # define __native_word(t) (sizeof(t) == sizeof(char) || sizeof(t) == sizeof(short) || sizeof(t) == sizeof(int) || sizeof(t) == sizeof(long))
>                                                                                                ^
> ./include/asm-generic/percpu.h:330:31: note: in expansion of macro ‘this_cpu_generic_read’
>   #define this_cpu_read_4(pcp)  this_cpu_generic_read(pcp)
>                                 ^~~~~~~~~~~~~~~~~~~~~
> ./include/linux/percpu-defs.h:310:23: note: in expansion of macro ‘this_cpu_read_4’
>    case 4: pscr_ret__ = stem##4(variable); break;   \
>                         ^~~~
> ./include/linux/percpu-defs.h:494:29: note: in expansion of macro ‘__pcpu_size_call_return’
>   #define this_cpu_read(pcp)  __pcpu_size_call_return(this_cpu_read_, pcp)
>                               ^~~~~~~~~~~~~~~~~~~~~~~
> arch/powerpc/lib/code-patching.c:150:7: note: in expansion of macro ‘this_cpu_read’
>    if (!this_cpu_read(*PTRRELOC(&text_poke_area)))
>         ^~~~~~~~~~~~~
> arch/powerpc/lib/code-patching.c:150:21: error: invalid type argument of unary ‘*’ (have ‘int’)
>    if (!this_cpu_read(*PTRRELOC(&text_poke_area)))
>                       ^~~~~~~~~~~~~~~~~~~~~~~~~~
> ./include/linux/compiler.h:524:122: note: in definition of macro ‘__native_word’
>   # define __native_word(t) (sizeof(t) == sizeof(char) || sizeof(t) == sizeof(short) || sizeof(t) == sizeof(int) || sizeof(t) == sizeof(long))
>                                                                                                                            ^
> ./include/asm-generic/percpu.h:330:31: note: in expansion of macro ‘this_cpu_generic_read’
>   #define this_cpu_read_4(pcp)  this_cpu_generic_read(pcp)
>                                 ^~~~~~~~~~~~~~~~~~~~~
> ./include/linux/percpu-defs.h:310:23: note: in expansion of macro ‘this_cpu_read_4’
>    case 4: pscr_ret__ = stem##4(variable); break;   \
>                         ^~~~
> ./include/linux/percpu-defs.h:494:29: note: in expansion of macro ‘__pcpu_size_call_return’
>   #define this_cpu_read(pcp)  __pcpu_size_call_return(this_cpu_read_, pcp)
>                               ^~~~~~~~~~~~~~~~~~~~~~~
> arch/powerpc/lib/code-patching.c:150:7: note: in expansion of macro ‘this_cpu_read’
>    if (!this_cpu_read(*PTRRELOC(&text_poke_area)))
>         ^~~~~~~~~~~~~
> In file included from ./arch/powerpc/include/asm/percpu.h:20:0,
>                   from ./include/linux/percpu.h:13,
>                   from ./include/linux/kprobes.h:38,
>                   from arch/powerpc/lib/code-patching.c:11:
> arch/powerpc/lib/code-patching.c:150:21: error: invalid type argument of unary ‘*’ (have ‘int’)
>    if (!this_cpu_read(*PTRRELOC(&text_poke_area)))
>                       ^~~~~~~~~~~~~~~~~~~~~~~~~~
> ./include/asm-generic/percpu.h:121:9: note: in definition of macro ‘__this_cpu_generic_read_nopreempt’
>    typeof(pcp) __ret;      \
>           ^~~
> ./include/asm-generic/percpu.h:330:31: note: in expansion of macro ‘this_cpu_generic_read’
>   #define this_cpu_read_4(pcp)  this_cpu_generic_read(pcp)
>                                 ^~~~~~~~~~~~~~~~~~~~~
> ./include/linux/percpu-defs.h:310:23: note: in expansion of macro ‘this_cpu_read_4’
>    case 4: pscr_ret__ = stem##4(variable); break;   \
>                         ^~~~
> ./include/linux/percpu-defs.h:494:29: note: in expansion of macro ‘__pcpu_size_call_return’
>   #define this_cpu_read(pcp)  __pcpu_size_call_return(this_cpu_read_, pcp)
>                               ^~~~~~~~~~~~~~~~~~~~~~~
> arch/powerpc/lib/code-patching.c:150:7: note: in expansion of macro ‘this_cpu_read’
>    if (!this_cpu_read(*PTRRELOC(&text_poke_area)))
>         ^~~~~~~~~~~~~
> In file included from ./include/linux/linkage.h:5:0,
>                   from ./include/linux/kernel.h:7,
>                   from arch/powerpc/lib/code-patching.c:10:
> arch/powerpc/lib/code-patching.c:150:21: error: invalid type argument of unary ‘*’ (have ‘int’)
>    if (!this_cpu_read(*PTRRELOC(&text_poke_area)))
>                       ^~~~~~~~~~~~~~~~~~~~~~~~~~
> ./include/linux/compiler.h:339:17: note: in definition of macro ‘__READ_ONCE’
>    union { typeof(x) __val; char __c[1]; } __u;   \
>                   ^
> ./include/asm-generic/percpu.h:123:10: note: in expansion of macro ‘READ_ONCE’
>    __ret = READ_ONCE(*raw_cpu_ptr(&(pcp)));   \
>            ^~~~~~~~~
> ./include/linux/percpu-defs.h:246:2: note: in expansion of macro ‘__verify_pcpu_ptr’
>    __verify_pcpu_ptr(__p);      \
>    ^~~~~~~~~~~~~~~~~
> ./include/linux/percpu-defs.h:250:47: note: in expansion of macro ‘VERIFY_PERCPU_PTR’
>   #define per_cpu_ptr(ptr, cpu) ({ (void)(cpu); VERIFY_PERCPU_PTR(ptr); })
>                                                 ^~~~~~~~~~~~~~~~~
> ./include/linux/percpu-defs.h:251:26: note: in expansion of macro ‘per_cpu_ptr’
>   #define raw_cpu_ptr(ptr) per_cpu_ptr(ptr, 0)
>                            ^~~~~~~~~~~
> ./include/asm-generic/percpu.h:123:21: note: in expansion of macro ‘raw_cpu_ptr’
>    __ret = READ_ONCE(*raw_cpu_ptr(&(pcp)));   \
>                       ^~~~~~~~~~~
> ./include/asm-generic/percpu.h:142:11: note: in expansion of macro ‘__this_cpu_generic_read_nopreempt’
>     __ret = __this_cpu_generic_read_nopreempt(pcp);  \
>             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> ./include/asm-generic/percpu.h:330:31: note: in expansion of macro ‘this_cpu_generic_read’
>   #define this_cpu_read_4(pcp)  this_cpu_generic_read(pcp)
>                                 ^~~~~~~~~~~~~~~~~~~~~
> ./include/linux/percpu-defs.h:310:23: note: in expansion of macro ‘this_cpu_read_4’
>    case 4: pscr_ret__ = stem##4(variable); break;   \
>                         ^~~~
> ./include/linux/percpu-defs.h:494:29: note: in expansion of macro ‘__pcpu_size_call_return’
>   #define this_cpu_read(pcp)  __pcpu_size_call_return(this_cpu_read_, pcp)
>                               ^~~~~~~~~~~~~~~~~~~~~~~
> arch/powerpc/lib/code-patching.c:150:7: note: in expansion of macro ‘this_cpu_read’
>    if (!this_cpu_read(*PTRRELOC(&text_poke_area)))
>         ^~~~~~~~~~~~~
> arch/powerpc/lib/code-patching.c:150:21: error: invalid type argument of unary ‘*’ (have ‘int’)
>    if (!this_cpu_read(*PTRRELOC(&text_poke_area)))
>                       ^~~~~~~~~~~~~~~~~~~~~~~~~~
> ./include/linux/compiler.h:339:17: note: in definition of macro ‘__READ_ONCE’
>    union { typeof(x) __val; char __c[1]; } __u;   \
>                   ^
> ./include/asm-generic/percpu.h:123:10: note: in expansion of macro ‘READ_ONCE’
>    __ret = READ_ONCE(*raw_cpu_ptr(&(pcp)));   \
>            ^~~~~~~~~
> ./include/linux/percpu-defs.h:250:47: note: in expansion of macro ‘VERIFY_PERCPU_PTR’
>   #define per_cpu_ptr(ptr, cpu) ({ (void)(cpu); VERIFY_PERCPU_PTR(ptr); })
>                                                 ^~~~~~~~~~~~~~~~~
> ./include/linux/percpu-defs.h:251:26: note: in expansion of macro ‘per_cpu_ptr’
>   #define raw_cpu_ptr(ptr) per_cpu_ptr(ptr, 0)
>                            ^~~~~~~~~~~
> ./include/asm-generic/percpu.h:123:21: note: in expansion of macro ‘raw_cpu_ptr’
>    __ret = READ_ONCE(*raw_cpu_ptr(&(pcp)));   \
>                       ^~~~~~~~~~~
> ./include/asm-generic/percpu.h:142:11: note: in expansion of macro ‘__this_cpu_generic_read_nopreempt’
>     __ret = __this_cpu_generic_read_nopreempt(pcp);  \
>             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> ./include/asm-generic/percpu.h:330:31: note: in expansion of macro ‘this_cpu_generic_read’
>   #define this_cpu_read_4(pcp)  this_cpu_generic_read(pcp)
>                                 ^~~~~~~~~~~~~~~~~~~~~
> ./include/linux/percpu-defs.h:310:23: note: in expansion of macro ‘this_cpu_read_4’
>    case 4: pscr_ret__ = stem##4(variable); break;   \
>                         ^~~~
> ./include/linux/percpu-defs.h:494:29: note: in expansion of macro ‘__pcpu_size_call_return’
>   #define this_cpu_read(pcp)  __pcpu_size_call_return(this_cpu_read_, pcp)
>                               ^~~~~~~~~~~~~~~~~~~~~~~
> arch/powerpc/lib/code-patching.c:150:7: note: in expansion of macro ‘this_cpu_read’
>    if (!this_cpu_read(*PTRRELOC(&text_poke_area)))
>         ^~~~~~~~~~~~~
> arch/powerpc/lib/code-patching.c:150:21: error: invalid type argument of unary ‘*’ (have ‘int’)
>    if (!this_cpu_read(*PTRRELOC(&text_poke_area)))
>                       ^~~~~~~~~~~~~~~~~~~~~~~~~~
> ./include/linux/compiler.h:339:17: note: in definition of macro ‘__READ_ONCE’
>    union { typeof(x) __val; char __c[1]; } __u;   \
>                   ^
> ./include/asm-generic/percpu.h:123:10: note: in expansion of macro ‘READ_ONCE’
>    __ret = READ_ONCE(*raw_cpu_ptr(&(pcp)));   \
>            ^~~~~~~~~
> ./include/linux/percpu-defs.h:250:47: note: in expansion of macro ‘VERIFY_PERCPU_PTR’
>   #define per_cpu_ptr(ptr, cpu) ({ (void)(cpu); VERIFY_PERCPU_PTR(ptr); })
>                                                 ^~~~~~~~~~~~~~~~~
> ./include/linux/percpu-defs.h:251:26: note: in expansion of macro ‘per_cpu_ptr’
>   #define raw_cpu_ptr(ptr) per_cpu_ptr(ptr, 0)
>                            ^~~~~~~~~~~
> ./include/asm-generic/percpu.h:123:21: note: in expansion of macro ‘raw_cpu_ptr’
>    __ret = READ_ONCE(*raw_cpu_ptr(&(pcp)));   \
>                       ^~~~~~~~~~~
> ./include/asm-generic/percpu.h:142:11: note: in expansion of macro ‘__this_cpu_generic_read_nopreempt’
>     __ret = __this_cpu_generic_read_nopreempt(pcp);  \
>             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> ./include/asm-generic/percpu.h:330:31: note: in expansion of macro ‘this_cpu_generic_read’
>   #define this_cpu_read_4(pcp)  this_cpu_generic_read(pcp)
>                                 ^~~~~~~~~~~~~~~~~~~~~
> ./include/linux/percpu-defs.h:310:23: note: in expansion of macro ‘this_cpu_read_4’
>    case 4: pscr_ret__ = stem##4(variable); break;   \
>                         ^~~~
> ./include/linux/percpu-defs.h:494:29: note: in expansion of macro ‘__pcpu_size_call_return’
>   #define this_cpu_read(pcp)  __pcpu_size_call_return(this_cpu_read_, pcp)
>                               ^~~~~~~~~~~~~~~~~~~~~~~
> arch/powerpc/lib/code-patching.c:150:7: note: in expansion of macro ‘this_cpu_read’
>    if (!this_cpu_read(*PTRRELOC(&text_poke_area)))
>         ^~~~~~~~~~~~~
> arch/powerpc/lib/code-patching.c:150:21: error: invalid type argument of unary ‘*’ (have ‘int’)
>    if (!this_cpu_read(*PTRRELOC(&text_poke_area)))
>                       ^~~~~~~~~~~~~~~~~~~~~~~~~~
> ./include/linux/compiler.h:341:22: note: in definition of macro ‘__READ_ONCE’
>     __read_once_size(&(x), __u.__c, sizeof(x));  \
>                        ^
> ./include/asm-generic/percpu.h:123:10: note: in expansion of macro ‘READ_ONCE’
>    __ret = READ_ONCE(*raw_cpu_ptr(&(pcp)));   \
>            ^~~~~~~~~
> ./include/linux/percpu-defs.h:246:2: note: in expansion of macro ‘__verify_pcpu_ptr’
>    __verify_pcpu_ptr(__p);      \
>    ^~~~~~~~~~~~~~~~~
> ./include/linux/percpu-defs.h:250:47: note: in expansion of macro ‘VERIFY_PERCPU_PTR’
>   #define per_cpu_ptr(ptr, cpu) ({ (void)(cpu); VERIFY_PERCPU_PTR(ptr); })
>                                                 ^~~~~~~~~~~~~~~~~
> ./include/linux/percpu-defs.h:251:26: note: in expansion of macro ‘per_cpu_ptr’
>   #define raw_cpu_ptr(ptr) per_cpu_ptr(ptr, 0)
>                            ^~~~~~~~~~~
> ./include/asm-generic/percpu.h:123:21: note: in expansion of macro ‘raw_cpu_ptr’
>    __ret = READ_ONCE(*raw_cpu_ptr(&(pcp)));   \
>                       ^~~~~~~~~~~
> ./include/asm-generic/percpu.h:142:11: note: in expansion of macro ‘__this_cpu_generic_read_nopreempt’
>     __ret = __this_cpu_generic_read_nopreempt(pcp);  \
>             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> ./include/asm-generic/percpu.h:330:31: note: in expansion of macro ‘this_cpu_generic_read’
>   #define this_cpu_read_4(pcp)  this_cpu_generic_read(pcp)
>                                 ^~~~~~~~~~~~~~~~~~~~~
> ./include/linux/percpu-defs.h:310:23: note: in expansion of macro ‘this_cpu_read_4’
>    case 4: pscr_ret__ = stem##4(variable); break;   \
>                         ^~~~
> ./include/linux/percpu-defs.h:494:29: note: in expansion of macro ‘__pcpu_size_call_return’
>   #define this_cpu_read(pcp)  __pcpu_size_call_return(this_cpu_read_, pcp)
>                               ^~~~~~~~~~~~~~~~~~~~~~~
> arch/powerpc/lib/code-patching.c:150:7: note: in expansion of macro ‘this_cpu_read’
>    if (!this_cpu_read(*PTRRELOC(&text_poke_area)))
>         ^~~~~~~~~~~~~
> arch/powerpc/lib/code-patching.c:150:21: error: invalid type argument of unary ‘*’ (have ‘int’)
>    if (!this_cpu_read(*PTRRELOC(&text_poke_area)))
>                       ^~~~~~~~~~~~~~~~~~~~~~~~~~
> ./include/linux/compiler.h:341:22: note: in definition of macro ‘__READ_ONCE’
>     __read_once_size(&(x), __u.__c, sizeof(x));  \
>                        ^
> ./include/asm-generic/percpu.h:123:10: note: in expansion of macro ‘READ_ONCE’
>    __ret = READ_ONCE(*raw_cpu_ptr(&(pcp)));   \
>            ^~~~~~~~~
> ./include/linux/percpu-defs.h:250:47: note: in expansion of macro ‘VERIFY_PERCPU_PTR’
>   #define per_cpu_ptr(ptr, cpu) ({ (void)(cpu); VERIFY_PERCPU_PTR(ptr); })
>                                                 ^~~~~~~~~~~~~~~~~
> ./include/linux/percpu-defs.h:251:26: note: in expansion of macro ‘per_cpu_ptr’
>   #define raw_cpu_ptr(ptr) per_cpu_ptr(ptr, 0)
>                            ^~~~~~~~~~~
> ./include/asm-generic/percpu.h:123:21: note: in expansion of macro ‘raw_cpu_ptr’
>    __ret = READ_ONCE(*raw_cpu_ptr(&(pcp)));   \
>                       ^~~~~~~~~~~
> ./include/asm-generic/percpu.h:142:11: note: in expansion of macro ‘__this_cpu_generic_read_nopreempt’
>     __ret = __this_cpu_generic_read_nopreempt(pcp);  \
>             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> ./include/asm-generic/percpu.h:330:31: note: in expansion of macro ‘this_cpu_generic_read’
>   #define this_cpu_read_4(pcp)  this_cpu_generic_read(pcp)
>                                 ^~~~~~~~~~~~~~~~~~~~~
> ./include/linux/percpu-defs.h:310:23: note: in expansion of macro ‘this_cpu_read_4’
>    case 4: pscr_ret__ = stem##4(variable); break;   \
>                         ^~~~
> ./include/linux/percpu-defs.h:494:29: note: in expansion of macro ‘__pcpu_size_call_return’
>   #define this_cpu_read(pcp)  __pcpu_size_call_return(this_cpu_read_, pcp)
>                               ^~~~~~~~~~~~~~~~~~~~~~~
> arch/powerpc/lib/code-patching.c:150:7: note: in expansion of macro ‘this_cpu_read’
>    if (!this_cpu_read(*PTRRELOC(&text_poke_area)))
>         ^~~~~~~~~~~~~
> arch/powerpc/lib/code-patching.c:150:21: error: invalid type argument of unary ‘*’ (have ‘int’)
>    if (!this_cpu_read(*PTRRELOC(&text_poke_area)))
>                       ^~~~~~~~~~~~~~~~~~~~~~~~~~
> ./include/linux/compiler.h:341:22: note: in definition of macro ‘__READ_ONCE’
>     __read_once_size(&(x), __u.__c, sizeof(x));  \
>                        ^
> ./include/asm-generic/percpu.h:123:10: note: in expansion of macro ‘READ_ONCE’
>    __ret = READ_ONCE(*raw_cpu_ptr(&(pcp)));   \
>            ^~~~~~~~~
> ./include/linux/percpu-defs.h:250:47: note: in expansion of macro ‘VERIFY_PERCPU_PTR’
>   #define per_cpu_ptr(ptr, cpu) ({ (void)(cpu); VERIFY_PERCPU_PTR(ptr); })
>                                                 ^~~~~~~~~~~~~~~~~
> ./include/linux/percpu-defs.h:251:26: note: in expansion of macro ‘per_cpu_ptr’
>   #define raw_cpu_ptr(ptr) per_cpu_ptr(ptr, 0)
>                            ^~~~~~~~~~~
> ./include/asm-generic/percpu.h:123:21: note: in expansion of macro ‘raw_cpu_ptr’
>    __ret = READ_ONCE(*raw_cpu_ptr(&(pcp)));   \
>                       ^~~~~~~~~~~
> ./include/asm-generic/percpu.h:142:11: note: in expansion of macro ‘__this_cpu_generic_read_nopreempt’
>     __ret = __this_cpu_generic_read_nopreempt(pcp);  \
>             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> ./include/asm-generic/percpu.h:330:31: note: in expansion of macro ‘this_cpu_generic_read’
>   #define this_cpu_read_4(pcp)  this_cpu_generic_read(pcp)
>                                 ^~~~~~~~~~~~~~~~~~~~~
> ./include/linux/percpu-defs.h:310:23: note: in expansion of macro ‘this_cpu_read_4’
>    case 4: pscr_ret__ = stem##4(variable); break;   \
>                         ^~~~
> ./include/linux/percpu-defs.h:494:29: note: in expansion of macro ‘__pcpu_size_call_return’
>   #define this_cpu_read(pcp)  __pcpu_size_call_return(this_cpu_read_, pcp)
>                               ^~~~~~~~~~~~~~~~~~~~~~~
> arch/powerpc/lib/code-patching.c:150:7: note: in expansion of macro ‘this_cpu_read’
>    if (!this_cpu_read(*PTRRELOC(&text_poke_area)))
>         ^~~~~~~~~~~~~
> arch/powerpc/lib/code-patching.c:150:21: error: invalid type argument of unary ‘*’ (have ‘int’)
>    if (!this_cpu_read(*PTRRELOC(&text_poke_area)))
>                       ^~~~~~~~~~~~~~~~~~~~~~~~~~
> ./include/linux/compiler.h:341:42: note: in definition of macro ‘__READ_ONCE’
>     __read_once_size(&(x), __u.__c, sizeof(x));  \
>                                            ^
> ./include/asm-generic/percpu.h:123:10: note: in expansion of macro ‘READ_ONCE’
>    __ret = READ_ONCE(*raw_cpu_ptr(&(pcp)));   \
>            ^~~~~~~~~
> ./include/linux/percpu-defs.h:246:2: note: in expansion of macro ‘__verify_pcpu_ptr’
>    __verify_pcpu_ptr(__p);      \
>    ^~~~~~~~~~~~~~~~~
> ./include/linux/percpu-defs.h:250:47: note: in expansion of macro ‘VERIFY_PERCPU_PTR’
>   #define per_cpu_ptr(ptr, cpu) ({ (void)(cpu); VERIFY_PERCPU_PTR(ptr); })
>                                                 ^~~~~~~~~~~~~~~~~
> ./include/linux/percpu-defs.h:251:26: note: in expansion of macro ‘per_cpu_ptr’
>   #define raw_cpu_ptr(ptr) per_cpu_ptr(ptr, 0)
>                            ^~~~~~~~~~~
> ./include/asm-generic/percpu.h:123:21: note: in expansion of macro ‘raw_cpu_ptr’
>    __ret = READ_ONCE(*raw_cpu_ptr(&(pcp)));   \
>                       ^~~~~~~~~~~
> ./include/asm-generic/percpu.h:142:11: note: in expansion of macro ‘__this_cpu_generic_read_nopreempt’
>     __ret = __this_cpu_generic_read_nopreempt(pcp);  \
>             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> ./include/asm-generic/percpu.h:330:31: note: in expansion of macro ‘this_cpu_generic_read’
>   #define this_cpu_read_4(pcp)  this_cpu_generic_read(pcp)
>                                 ^~~~~~~~~~~~~~~~~~~~~
> ./include/linux/percpu-defs.h:310:23: note: in expansion of macro ‘this_cpu_read_4’
>    case 4: pscr_ret__ = stem##4(variable); break;   \
>                         ^~~~
> ./include/linux/percpu-defs.h:494:29: note: in expansion of macro ‘__pcpu_size_call_return’
>   #define this_cpu_read(pcp)  __pcpu_size_call_return(this_cpu_read_, pcp)
>                               ^~~~~~~~~~~~~~~~~~~~~~~
> arch/powerpc/lib/code-patching.c:150:7: note: in expansion of macro ‘this_cpu_read’
>    if (!this_cpu_read(*PTRRELOC(&text_poke_area)))
>         ^~~~~~~~~~~~~
> arch/powerpc/lib/code-patching.c:150:21: error: invalid type argument of unary ‘*’ (have ‘int’)
>    if (!this_cpu_read(*PTRRELOC(&text_poke_area)))
>                       ^~~~~~~~~~~~~~~~~~~~~~~~~~
> ./include/linux/compiler.h:341:42: note: in definition of macro ‘__READ_ONCE’
>     __read_once_size(&(x), __u.__c, sizeof(x));  \
>                                            ^
> ./include/asm-generic/percpu.h:123:10: note: in expansion of macro ‘READ_ONCE’
>    __ret = READ_ONCE(*raw_cpu_ptr(&(pcp)));   \
>            ^~~~~~~~~
> ./include/linux/percpu-defs.h:250:47: note: in expansion of macro ‘VERIFY_PERCPU_PTR’
>   #define per_cpu_ptr(ptr, cpu) ({ (void)(cpu); VERIFY_PERCPU_PTR(ptr); })
>                                                 ^~~~~~~~~~~~~~~~~
> ./include/linux/percpu-defs.h:251:26: note: in expansion of macro ‘per_cpu_ptr’
>   #define raw_cpu_ptr(ptr) per_cpu_ptr(ptr, 0)
>                            ^~~~~~~~~~~
> ./include/asm-generic/percpu.h:123:21: note: in expansion of macro ‘raw_cpu_ptr’
>    __ret = READ_ONCE(*raw_cpu_ptr(&(pcp)));   \
>                       ^~~~~~~~~~~
> ./include/asm-generic/percpu.h:142:11: note: in expansion of macro ‘__this_cpu_generic_read_nopreempt’
>     __ret = __this_cpu_generic_read_nopreempt(pcp);  \
>             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> ./include/asm-generic/percpu.h:330:31: note: in expansion of macro ‘this_cpu_generic_read’
>   #define this_cpu_read_4(pcp)  this_cpu_generic_read(pcp)
>                                 ^~~~~~~~~~~~~~~~~~~~~
> ./include/linux/percpu-defs.h:310:23: note: in expansion of macro ‘this_cpu_read_4’
>    case 4: pscr_ret__ = stem##4(variable); break;   \
>                         ^~~~
> ./include/linux/percpu-defs.h:494:29: note: in expansion of macro ‘__pcpu_size_call_return’
>   #define this_cpu_read(pcp)  __pcpu_size_call_return(this_cpu_read_, pcp)
>                               ^~~~~~~~~~~~~~~~~~~~~~~
> arch/powerpc/lib/code-patching.c:150:7: note: in expansion of macro ‘this_cpu_read’
>    if (!this_cpu_read(*PTRRELOC(&text_poke_area)))
>         ^~~~~~~~~~~~~
> arch/powerpc/lib/code-patching.c:150:21: error: invalid type argument of unary ‘*’ (have ‘int’)
>    if (!this_cpu_read(*PTRRELOC(&text_poke_area)))
>                       ^~~~~~~~~~~~~~~~~~~~~~~~~~
> ./include/linux/compiler.h:341:42: note: in definition of macro ‘__READ_ONCE’
>     __read_once_size(&(x), __u.__c, sizeof(x));  \
>                                            ^
> ./include/asm-generic/percpu.h:123:10: note: in expansion of macro ‘READ_ONCE’
>    __ret = READ_ONCE(*raw_cpu_ptr(&(pcp)));   \
>            ^~~~~~~~~
> ./include/linux/percpu-defs.h:250:47: note: in expansion of macro ‘VERIFY_PERCPU_PTR’
>   #define per_cpu_ptr(ptr, cpu) ({ (void)(cpu); VERIFY_PERCPU_PTR(ptr); })
>                                                 ^~~~~~~~~~~~~~~~~
> ./include/linux/percpu-defs.h:251:26: note: in expansion of macro ‘per_cpu_ptr’
>   #define raw_cpu_ptr(ptr) per_cpu_ptr(ptr, 0)
>                            ^~~~~~~~~~~
> ./include/asm-generic/percpu.h:123:21: note: in expansion of macro ‘raw_cpu_ptr’
>    __ret = READ_ONCE(*raw_cpu_ptr(&(pcp)));   \
>                       ^~~~~~~~~~~
> ./include/asm-generic/percpu.h:142:11: note: in expansion of macro ‘__this_cpu_generic_read_nopreempt’
>     __ret = __this_cpu_generic_read_nopreempt(pcp);  \
>             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> ./include/asm-generic/percpu.h:330:31: note: in expansion of macro ‘this_cpu_generic_read’
>   #define this_cpu_read_4(pcp)  this_cpu_generic_read(pcp)
>                                 ^~~~~~~~~~~~~~~~~~~~~
> ./include/linux/percpu-defs.h:310:23: note: in expansion of macro ‘this_cpu_read_4’
>    case 4: pscr_ret__ = stem##4(variable); break;   \
>                         ^~~~
> ./include/linux/percpu-defs.h:494:29: note: in expansion of macro ‘__pcpu_size_call_return’
>   #define this_cpu_read(pcp)  __pcpu_size_call_return(this_cpu_read_, pcp)
>                               ^~~~~~~~~~~~~~~~~~~~~~~
> arch/powerpc/lib/code-patching.c:150:7: note: in expansion of macro ‘this_cpu_read’
>    if (!this_cpu_read(*PTRRELOC(&text_poke_area)))
>         ^~~~~~~~~~~~~
> arch/powerpc/lib/code-patching.c:150:21: error: invalid type argument of unary ‘*’ (have ‘int’)
>    if (!this_cpu_read(*PTRRELOC(&text_poke_area)))
>                       ^~~~~~~~~~~~~~~~~~~~~~~~~~
> ./include/linux/compiler.h:343:30: note: in definition of macro ‘__READ_ONCE’
>     __read_once_size_nocheck(&(x), __u.__c, sizeof(x)); \
>                                ^
> ./include/asm-generic/percpu.h:123:10: note: in expansion of macro ‘READ_ONCE’
>    __ret = READ_ONCE(*raw_cpu_ptr(&(pcp)));   \
>            ^~~~~~~~~
> ./include/linux/percpu-defs.h:246:2: note: in expansion of macro ‘__verify_pcpu_ptr’
>    __verify_pcpu_ptr(__p);      \
>    ^~~~~~~~~~~~~~~~~
> ./include/linux/percpu-defs.h:250:47: note: in expansion of macro ‘VERIFY_PERCPU_PTR’
>   #define per_cpu_ptr(ptr, cpu) ({ (void)(cpu); VERIFY_PERCPU_PTR(ptr); })
>                                                 ^~~~~~~~~~~~~~~~~
> ./include/linux/percpu-defs.h:251:26: note: in expansion of macro ‘per_cpu_ptr’
>   #define raw_cpu_ptr(ptr) per_cpu_ptr(ptr, 0)
>                            ^~~~~~~~~~~
> ./include/asm-generic/percpu.h:123:21: note: in expansion of macro ‘raw_cpu_ptr’
>    __ret = READ_ONCE(*raw_cpu_ptr(&(pcp)));   \
>                       ^~~~~~~~~~~
> ./include/asm-generic/percpu.h:142:11: note: in expansion of macro ‘__this_cpu_generic_read_nopreempt’
>     __ret = __this_cpu_generic_read_nopreempt(pcp);  \
>             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> ./include/asm-generic/percpu.h:330:31: note: in expansion of macro ‘this_cpu_generic_read’
>   #define this_cpu_read_4(pcp)  this_cpu_generic_read(pcp)
>                                 ^~~~~~~~~~~~~~~~~~~~~
> ./include/linux/percpu-defs.h:310:23: note: in expansion of macro ‘this_cpu_read_4’
>    case 4: pscr_ret__ = stem##4(variable); break;   \
>                         ^~~~
> ./include/linux/percpu-defs.h:494:29: note: in expansion of macro ‘__pcpu_size_call_return’
>   #define this_cpu_read(pcp)  __pcpu_size_call_return(this_cpu_read_, pcp)
>                               ^~~~~~~~~~~~~~~~~~~~~~~
> arch/powerpc/lib/code-patching.c:150:7: note: in expansion of macro ‘this_cpu_read’
>    if (!this_cpu_read(*PTRRELOC(&text_poke_area)))
>         ^~~~~~~~~~~~~
> arch/powerpc/lib/code-patching.c:150:21: error: invalid type argument of unary ‘*’ (have ‘int’)
>    if (!this_cpu_read(*PTRRELOC(&text_poke_area)))
>                       ^~~~~~~~~~~~~~~~~~~~~~~~~~
> ./include/linux/compiler.h:343:30: note: in definition of macro ‘__READ_ONCE’
>     __read_once_size_nocheck(&(x), __u.__c, sizeof(x)); \
>                                ^
> ./include/asm-generic/percpu.h:123:10: note: in expansion of macro ‘READ_ONCE’
>    __ret = READ_ONCE(*raw_cpu_ptr(&(pcp)));   \
>            ^~~~~~~~~
> ./include/linux/percpu-defs.h:250:47: note: in expansion of macro ‘VERIFY_PERCPU_PTR’
>   #define per_cpu_ptr(ptr, cpu) ({ (void)(cpu); VERIFY_PERCPU_PTR(ptr); })
>                                                 ^~~~~~~~~~~~~~~~~
> ./include/linux/percpu-defs.h:251:26: note: in expansion of macro ‘per_cpu_ptr’
>   #define raw_cpu_ptr(ptr) per_cpu_ptr(ptr, 0)
>                            ^~~~~~~~~~~
> ./include/asm-generic/percpu.h:123:21: note: in expansion of macro ‘raw_cpu_ptr’
>    __ret = READ_ONCE(*raw_cpu_ptr(&(pcp)));   \
>                       ^~~~~~~~~~~
> ./include/asm-generic/percpu.h:142:11: note: in expansion of macro ‘__this_cpu_generic_read_nopreempt’
>     __ret = __this_cpu_generic_read_nopreempt(pcp);  \
>             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> ./include/asm-generic/percpu.h:330:31: note: in expansion of macro ‘this_cpu_generic_read’
>   #define this_cpu_read_4(pcp)  this_cpu_generic_read(pcp)
>                                 ^~~~~~~~~~~~~~~~~~~~~
> ./include/linux/percpu-defs.h:310:23: note: in expansion of macro ‘this_cpu_read_4’
>    case 4: pscr_ret__ = stem##4(variable); break;   \
>                         ^~~~
> ./include/linux/percpu-defs.h:494:29: note: in expansion of macro ‘__pcpu_size_call_return’
>   #define this_cpu_read(pcp)  __pcpu_size_call_return(this_cpu_read_, pcp)
>                               ^~~~~~~~~~~~~~~~~~~~~~~
> arch/powerpc/lib/code-patching.c:150:7: note: in expansion of macro ‘this_cpu_read’
>    if (!this_cpu_read(*PTRRELOC(&text_poke_area)))
>         ^~~~~~~~~~~~~
> arch/powerpc/lib/code-patching.c:150:21: error: invalid type argument of unary ‘*’ (have ‘int’)
>    if (!this_cpu_read(*PTRRELOC(&text_poke_area)))
>                       ^~~~~~~~~~~~~~~~~~~~~~~~~~
> ./include/linux/compiler.h:343:30: note: in definition of macro ‘__READ_ONCE’
>     __read_once_size_nocheck(&(x), __u.__c, sizeof(x)); \
>                                ^
> ./include/asm-generic/percpu.h:123:10: note: in expansion of macro ‘READ_ONCE’
>    __ret = READ_ONCE(*raw_cpu_ptr(&(pcp)));   \
>            ^~~~~~~~~
> ./include/linux/percpu-defs.h:250:47: note: in expansion of macro ‘VERIFY_PERCPU_PTR’
>   #define per_cpu_ptr(ptr, cpu) ({ (void)(cpu); VERIFY_PERCPU_PTR(ptr); })
>                                                 ^~~~~~~~~~~~~~~~~
> ./include/linux/percpu-defs.h:251:26: note: in expansion of macro ‘per_cpu_ptr’
>   #define raw_cpu_ptr(ptr) per_cpu_ptr(ptr, 0)
>                            ^~~~~~~~~~~
> ./include/asm-generic/percpu.h:123:21: note: in expansion of macro ‘raw_cpu_ptr’
>    __ret = READ_ONCE(*raw_cpu_ptr(&(pcp)));   \
>                       ^~~~~~~~~~~
> ./include/asm-generic/percpu.h:142:11: note: in expansion of macro ‘__this_cpu_generic_read_nopreempt’
>     __ret = __this_cpu_generic_read_nopreempt(pcp);  \
>             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> ./include/asm-generic/percpu.h:330:31: note: in expansion of macro ‘this_cpu_generic_read’
>   #define this_cpu_read_4(pcp)  this_cpu_generic_read(pcp)
>                                 ^~~~~~~~~~~~~~~~~~~~~
> ./include/linux/percpu-defs.h:310:23: note: in expansion of macro ‘this_cpu_read_4’
>    case 4: pscr_ret__ = stem##4(variable); break;   \
>                         ^~~~
> ./include/linux/percpu-defs.h:494:29: note: in expansion of macro ‘__pcpu_size_call_return’
>   #define this_cpu_read(pcp)  __pcpu_size_call_return(this_cpu_read_, pcp)
>                               ^~~~~~~~~~~~~~~~~~~~~~~
> arch/powerpc/lib/code-patching.c:150:7: note: in expansion of macro ‘this_cpu_read’
>    if (!this_cpu_read(*PTRRELOC(&text_poke_area)))
>         ^~~~~~~~~~~~~
> arch/powerpc/lib/code-patching.c:150:21: error: invalid type argument of unary ‘*’ (have ‘int’)
>    if (!this_cpu_read(*PTRRELOC(&text_poke_area)))
>                       ^~~~~~~~~~~~~~~~~~~~~~~~~~
> ./include/linux/compiler.h:343:50: note: in definition of macro ‘__READ_ONCE’
>     __read_once_size_nocheck(&(x), __u.__c, sizeof(x)); \
>                                                    ^
> ./include/asm-generic/percpu.h:123:10: note: in expansion of macro ‘READ_ONCE’
>    __ret = READ_ONCE(*raw_cpu_ptr(&(pcp)));   \
>            ^~~~~~~~~
> ./include/linux/percpu-defs.h:246:2: note: in expansion of macro ‘__verify_pcpu_ptr’
>    __verify_pcpu_ptr(__p);      \
>    ^~~~~~~~~~~~~~~~~
> ./include/linux/percpu-defs.h:250:47: note: in expansion of macro ‘VERIFY_PERCPU_PTR’
>   #define per_cpu_ptr(ptr, cpu) ({ (void)(cpu); VERIFY_PERCPU_PTR(ptr); })
>                                                 ^~~~~~~~~~~~~~~~~
> ./include/linux/percpu-defs.h:251:26: note: in expansion of macro ‘per_cpu_ptr’
>   #define raw_cpu_ptr(ptr) per_cpu_ptr(ptr, 0)
>                            ^~~~~~~~~~~
> ./include/asm-generic/percpu.h:123:21: note: in expansion of macro ‘raw_cpu_ptr’
>    __ret = READ_ONCE(*raw_cpu_ptr(&(pcp)));   \
>                       ^~~~~~~~~~~
> ./include/asm-generic/percpu.h:142:11: note: in expansion of macro ‘__this_cpu_generic_read_nopreempt’
>     __ret = __this_cpu_generic_read_nopreempt(pcp);  \
>             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> ./include/asm-generic/percpu.h:330:31: note: in expansion of macro ‘this_cpu_generic_read’
>   #define this_cpu_read_4(pcp)  this_cpu_generic_read(pcp)
>                                 ^~~~~~~~~~~~~~~~~~~~~
> ./include/linux/percpu-defs.h:310:23: note: in expansion of macro ‘this_cpu_read_4’
>    case 4: pscr_ret__ = stem##4(variable); break;   \
>                         ^~~~
> ./include/linux/percpu-defs.h:494:29: note: in expansion of macro ‘__pcpu_size_call_return’
>   #define this_cpu_read(pcp)  __pcpu_size_call_return(this_cpu_read_, pcp)
>                               ^~~~~~~~~~~~~~~~~~~~~~~
> arch/powerpc/lib/code-patching.c:150:7: note: in expansion of macro ‘this_cpu_read’
>    if (!this_cpu_read(*PTRRELOC(&text_poke_area)))
>         ^~~~~~~~~~~~~
> arch/powerpc/lib/code-patching.c:150:21: error: invalid type argument of unary ‘*’ (have ‘int’)
>    if (!this_cpu_read(*PTRRELOC(&text_poke_area)))
>                       ^~~~~~~~~~~~~~~~~~~~~~~~~~
> ./include/linux/compiler.h:343:50: note: in definition of macro ‘__READ_ONCE’
>     __read_once_size_nocheck(&(x), __u.__c, sizeof(x)); \
>                                                    ^
> ./include/asm-generic/percpu.h:123:10: note: in expansion of macro ‘READ_ONCE’
>    __ret = READ_ONCE(*raw_cpu_ptr(&(pcp)));   \
>            ^~~~~~~~~
> ./include/linux/percpu-defs.h:250:47: note: in expansion of macro ‘VERIFY_PERCPU_PTR’
>   #define per_cpu_ptr(ptr, cpu) ({ (void)(cpu); VERIFY_PERCPU_PTR(ptr); })
>                                                 ^~~~~~~~~~~~~~~~~
> ./include/linux/percpu-defs.h:251:26: note: in expansion of macro ‘per_cpu_ptr’
>   #define raw_cpu_ptr(ptr) per_cpu_ptr(ptr, 0)
>                            ^~~~~~~~~~~
> ./include/asm-generic/percpu.h:123:21: note: in expansion of macro ‘raw_cpu_ptr’
>    __ret = READ_ONCE(*raw_cpu_ptr(&(pcp)));   \
>                       ^~~~~~~~~~~
> ./include/asm-generic/percpu.h:142:11: note: in expansion of macro ‘__this_cpu_generic_read_nopreempt’
>     __ret = __this_cpu_generic_read_nopreempt(pcp);  \
>             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> ./include/asm-generic/percpu.h:330:31: note: in expansion of macro ‘this_cpu_generic_read’
>   #define this_cpu_read_4(pcp)  this_cpu_generic_read(pcp)
>                                 ^~~~~~~~~~~~~~~~~~~~~
> ./include/linux/percpu-defs.h:310:23: note: in expansion of macro ‘this_cpu_read_4’
>    case 4: pscr_ret__ = stem##4(variable); break;   \
>                         ^~~~
> ./include/linux/percpu-defs.h:494:29: note: in expansion of macro ‘__pcpu_size_call_return’
>   #define this_cpu_read(pcp)  __pcpu_size_call_return(this_cpu_read_, pcp)
>                               ^~~~~~~~~~~~~~~~~~~~~~~
> arch/powerpc/lib/code-patching.c:150:7: note: in expansion of macro ‘this_cpu_read’
>    if (!this_cpu_read(*PTRRELOC(&text_poke_area)))
>         ^~~~~~~~~~~~~
> arch/powerpc/lib/code-patching.c:150:21: error: invalid type argument of unary ‘*’ (have ‘int’)
>    if (!this_cpu_read(*PTRRELOC(&text_poke_area)))
>                       ^~~~~~~~~~~~~~~~~~~~~~~~~~
> ./include/linux/compiler.h:343:50: note: in definition of macro ‘__READ_ONCE’
>     __read_once_size_nocheck(&(x), __u.__c, sizeof(x)); \
>                                                    ^
> ./include/asm-generic/percpu.h:123:10: note: in expansion of macro ‘READ_ONCE’
>    __ret = READ_ONCE(*raw_cpu_ptr(&(pcp)));   \
>            ^~~~~~~~~
> ./include/linux/percpu-defs.h:250:47: note: in expansion of macro ‘VERIFY_PERCPU_PTR’
>   #define per_cpu_ptr(ptr, cpu) ({ (void)(cpu); VERIFY_PERCPU_PTR(ptr); })
>                                                 ^~~~~~~~~~~~~~~~~
> ./include/linux/percpu-defs.h:251:26: note: in expansion of macro ‘per_cpu_ptr’
>   #define raw_cpu_ptr(ptr) per_cpu_ptr(ptr, 0)
>                            ^~~~~~~~~~~
> ./include/asm-generic/percpu.h:123:21: note: in expansion of macro ‘raw_cpu_ptr’
>    __ret = READ_ONCE(*raw_cpu_ptr(&(pcp)));   \
>                       ^~~~~~~~~~~
> ./include/asm-generic/percpu.h:142:11: note: in expansion of macro ‘__this_cpu_generic_read_nopreempt’
>     __ret = __this_cpu_generic_read_nopreempt(pcp);  \
>             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> ./include/asm-generic/percpu.h:330:31: note: in expansion of macro ‘this_cpu_generic_read’
>   #define this_cpu_read_4(pcp)  this_cpu_generic_read(pcp)
>                                 ^~~~~~~~~~~~~~~~~~~~~
> ./include/linux/percpu-defs.h:310:23: note: in expansion of macro ‘this_cpu_read_4’
>    case 4: pscr_ret__ = stem##4(variable); break;   \
>                         ^~~~
> ./include/linux/percpu-defs.h:494:29: note: in expansion of macro ‘__pcpu_size_call_return’
>   #define this_cpu_read(pcp)  __pcpu_size_call_return(this_cpu_read_, pcp)
>                               ^~~~~~~~~~~~~~~~~~~~~~~
> arch/powerpc/lib/code-patching.c:150:7: note: in expansion of macro ‘this_cpu_read’
>    if (!this_cpu_read(*PTRRELOC(&text_poke_area)))
>         ^~~~~~~~~~~~~
> In file included from ./arch/powerpc/include/asm/percpu.h:20:0,
>                   from ./include/linux/percpu.h:13,
>                   from ./include/linux/kprobes.h:38,
>                   from arch/powerpc/lib/code-patching.c:11:
> arch/powerpc/lib/code-patching.c:150:21: error: invalid type argument of unary ‘*’ (have ‘int’)
>    if (!this_cpu_read(*PTRRELOC(&text_poke_area)))
>                       ^~~~~~~~~~~~~~~~~~~~~~~~~~
> ./include/asm-generic/percpu.h:130:9: note: in definition of macro ‘__this_cpu_generic_read_noirq’
>    typeof(pcp) __ret;      \
>           ^~~
> ./include/asm-generic/percpu.h:330:31: note: in expansion of macro ‘this_cpu_generic_read’
>   #define this_cpu_read_4(pcp)  this_cpu_generic_read(pcp)
>                                 ^~~~~~~~~~~~~~~~~~~~~
> ./include/linux/percpu-defs.h:310:23: note: in expansion of macro ‘this_cpu_read_4’
>    case 4: pscr_ret__ = stem##4(variable); break;   \
>                         ^~~~
> ./include/linux/percpu-defs.h:494:29: note: in expansion of macro ‘__pcpu_size_call_return’
>   #define this_cpu_read(pcp)  __pcpu_size_call_return(this_cpu_read_, pcp)
>                               ^~~~~~~~~~~~~~~~~~~~~~~
> arch/powerpc/lib/code-patching.c:150:7: note: in expansion of macro ‘this_cpu_read’
>    if (!this_cpu_read(*PTRRELOC(&text_poke_area)))
>         ^~~~~~~~~~~~~
> In file included from ./include/asm-generic/percpu.h:7:0,
>                   from ./arch/powerpc/include/asm/percpu.h:20,
>                   from ./include/linux/percpu.h:13,
>                   from ./include/linux/kprobes.h:38,
>                   from arch/powerpc/lib/code-patching.c:11:
> arch/powerpc/lib/code-patching.c:150:21: error: invalid type argument of unary ‘*’ (have ‘int’)
>    if (!this_cpu_read(*PTRRELOC(&text_poke_area)))
>                       ^~~~~~~~~~~~~~~~~~~~~~~~~~
> ./include/linux/percpu-defs.h:206:47: note: in definition of macro ‘__verify_pcpu_ptr’
>    const void __percpu *__vpp_verify = (typeof((ptr) + 0))NULL; \
>                                                 ^~~
> ./include/linux/percpu-defs.h:250:47: note: in expansion of macro ‘VERIFY_PERCPU_PTR’
>   #define per_cpu_ptr(ptr, cpu) ({ (void)(cpu); VERIFY_PERCPU_PTR(ptr); })
>                                                 ^~~~~~~~~~~~~~~~~
> ./include/linux/percpu-defs.h:251:26: note: in expansion of macro ‘per_cpu_ptr’
>   #define raw_cpu_ptr(ptr) per_cpu_ptr(ptr, 0)
>                            ^~~~~~~~~~~
> ./include/asm-generic/percpu.h:71:3: note: in expansion of macro ‘raw_cpu_ptr’
>    *raw_cpu_ptr(&(pcp));      \
>     ^~~~~~~~~~~
> ./include/asm-generic/percpu.h:133:10: note: in expansion of macro ‘raw_cpu_generic_read’
>    __ret = raw_cpu_generic_read(pcp);    \
>            ^~~~~~~~~~~~~~~~~~~~
> ./include/asm-generic/percpu.h:144:11: note: in expansion of macro ‘__this_cpu_generic_read_noirq’
>     __ret = __this_cpu_generic_read_noirq(pcp);  \
>             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> ./include/asm-generic/percpu.h:330:31: note: in expansion of macro ‘this_cpu_generic_read’
>   #define this_cpu_read_4(pcp)  this_cpu_generic_read(pcp)
>                                 ^~~~~~~~~~~~~~~~~~~~~
> ./include/linux/percpu-defs.h:310:23: note: in expansion of macro ‘this_cpu_read_4’
>    case 4: pscr_ret__ = stem##4(variable); break;   \
>                         ^~~~
> ./include/linux/percpu-defs.h:494:29: note: in expansion of macro ‘__pcpu_size_call_return’
>   #define this_cpu_read(pcp)  __pcpu_size_call_return(this_cpu_read_, pcp)
>                               ^~~~~~~~~~~~~~~~~~~~~~~
> arch/powerpc/lib/code-patching.c:150:7: note: in expansion of macro ‘this_cpu_read’
>    if (!this_cpu_read(*PTRRELOC(&text_poke_area)))
>         ^~~~~~~~~~~~~
> arch/powerpc/lib/code-patching.c:150:21: error: invalid type argument of unary ‘*’ (have ‘int’)
>    if (!this_cpu_read(*PTRRELOC(&text_poke_area)))
>                       ^~~~~~~~~~~~~~~~~~~~~~~~~~
> ./include/linux/percpu-defs.h:247:12: note: in definition of macro ‘VERIFY_PERCPU_PTR’
>    (typeof(*(__p)) __kernel __force *)(__p);   \
>              ^~~
> ./include/linux/percpu-defs.h:251:26: note: in expansion of macro ‘per_cpu_ptr’
>   #define raw_cpu_ptr(ptr) per_cpu_ptr(ptr, 0)
>                            ^~~~~~~~~~~
> ./include/asm-generic/percpu.h:71:3: note: in expansion of macro ‘raw_cpu_ptr’
>    *raw_cpu_ptr(&(pcp));      \
>     ^~~~~~~~~~~
> ./include/asm-generic/percpu.h:133:10: note: in expansion of macro ‘raw_cpu_generic_read’
>    __ret = raw_cpu_generic_read(pcp);    \
>            ^~~~~~~~~~~~~~~~~~~~
> ./include/asm-generic/percpu.h:144:11: note: in expansion of macro ‘__this_cpu_generic_read_noirq’
>     __ret = __this_cpu_generic_read_noirq(pcp);  \
>             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> ./include/asm-generic/percpu.h:330:31: note: in expansion of macro ‘this_cpu_generic_read’
>   #define this_cpu_read_4(pcp)  this_cpu_generic_read(pcp)
>                                 ^~~~~~~~~~~~~~~~~~~~~
> ./include/linux/percpu-defs.h:310:23: note: in expansion of macro ‘this_cpu_read_4’
>    case 4: pscr_ret__ = stem##4(variable); break;   \
>                         ^~~~
> ./include/linux/percpu-defs.h:494:29: note: in expansion of macro ‘__pcpu_size_call_return’
>   #define this_cpu_read(pcp)  __pcpu_size_call_return(this_cpu_read_, pcp)
>                               ^~~~~~~~~~~~~~~~~~~~~~~
> arch/powerpc/lib/code-patching.c:150:7: note: in expansion of macro ‘this_cpu_read’
>    if (!this_cpu_read(*PTRRELOC(&text_poke_area)))
>         ^~~~~~~~~~~~~
> arch/powerpc/lib/code-patching.c:150:21: error: invalid type argument of unary ‘*’ (have ‘int’)
>    if (!this_cpu_read(*PTRRELOC(&text_poke_area)))
>                       ^~~~~~~~~~~~~~~~~~~~~~~~~~
> ./include/linux/percpu-defs.h:247:38: note: in definition of macro ‘VERIFY_PERCPU_PTR’
>    (typeof(*(__p)) __kernel __force *)(__p);   \
>                                        ^~~
> ./include/linux/percpu-defs.h:251:26: note: in expansion of macro ‘per_cpu_ptr’
>   #define raw_cpu_ptr(ptr) per_cpu_ptr(ptr, 0)
>                            ^~~~~~~~~~~
> ./include/asm-generic/percpu.h:71:3: note: in expansion of macro ‘raw_cpu_ptr’
>    *raw_cpu_ptr(&(pcp));      \
>     ^~~~~~~~~~~
> ./include/asm-generic/percpu.h:133:10: note: in expansion of macro ‘raw_cpu_generic_read’
>    __ret = raw_cpu_generic_read(pcp);    \
>            ^~~~~~~~~~~~~~~~~~~~
> ./include/asm-generic/percpu.h:144:11: note: in expansion of macro ‘__this_cpu_generic_read_noirq’
>     __ret = __this_cpu_generic_read_noirq(pcp);  \
>             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> ./include/asm-generic/percpu.h:330:31: note: in expansion of macro ‘this_cpu_generic_read’
>   #define this_cpu_read_4(pcp)  this_cpu_generic_read(pcp)
>                                 ^~~~~~~~~~~~~~~~~~~~~
> ./include/linux/percpu-defs.h:310:23: note: in expansion of macro ‘this_cpu_read_4’
>    case 4: pscr_ret__ = stem##4(variable); break;   \
>                         ^~~~
> ./include/linux/percpu-defs.h:494:29: note: in expansion of macro ‘__pcpu_size_call_return’
>   #define this_cpu_read(pcp)  __pcpu_size_call_return(this_cpu_read_, pcp)
>                               ^~~~~~~~~~~~~~~~~~~~~~~
> arch/powerpc/lib/code-patching.c:150:7: note: in expansion of macro ‘this_cpu_read’
>    if (!this_cpu_read(*PTRRELOC(&text_poke_area)))
>         ^~~~~~~~~~~~~
> In file included from ./arch/powerpc/include/asm/percpu.h:20:0,
>                   from ./include/linux/percpu.h:13,
>                   from ./include/linux/kprobes.h:38,
>                   from arch/powerpc/lib/code-patching.c:11:
> arch/powerpc/lib/code-patching.c:150:21: error: invalid type argument of unary ‘*’ (have ‘int’)
>    if (!this_cpu_read(*PTRRELOC(&text_poke_area)))
>                       ^~~~~~~~~~~~~~~~~~~~~~~~~~
> ./include/asm-generic/percpu.h:140:9: note: in definition of macro ‘this_cpu_generic_read’
>    typeof(pcp) __ret;      \
>           ^~~
> ./include/linux/percpu-defs.h:311:23: note: in expansion of macro ‘this_cpu_read_8’
>    case 8: pscr_ret__ = stem##8(variable); break;   \
>                         ^~~~
> ./include/linux/percpu-defs.h:494:29: note: in expansion of macro ‘__pcpu_size_call_return’
>   #define this_cpu_read(pcp)  __pcpu_size_call_return(this_cpu_read_, pcp)
>                               ^~~~~~~~~~~~~~~~~~~~~~~
> arch/powerpc/lib/code-patching.c:150:7: note: in expansion of macro ‘this_cpu_read’
>    if (!this_cpu_read(*PTRRELOC(&text_poke_area)))
>         ^~~~~~~~~~~~~
> In file included from ./include/linux/linkage.h:5:0,
>                   from ./include/linux/kernel.h:7,
>                   from arch/powerpc/lib/code-patching.c:10:
> arch/powerpc/lib/code-patching.c:150:21: error: invalid type argument of unary ‘*’ (have ‘int’)
>    if (!this_cpu_read(*PTRRELOC(&text_poke_area)))
>                       ^~~~~~~~~~~~~~~~~~~~~~~~~~
> ./include/linux/compiler.h:524:35: note: in definition of macro ‘__native_word’
>   # define __native_word(t) (sizeof(t) == sizeof(char) || sizeof(t) == sizeof(short) || sizeof(t) == sizeof(int) || sizeof(t) == sizeof(long))
>                                     ^
> ./include/asm-generic/percpu.h:333:31: note: in expansion of macro ‘this_cpu_generic_read’
>   #define this_cpu_read_8(pcp)  this_cpu_generic_read(pcp)
>                                 ^~~~~~~~~~~~~~~~~~~~~
> ./include/linux/percpu-defs.h:311:23: note: in expansion of macro ‘this_cpu_read_8’
>    case 8: pscr_ret__ = stem##8(variable); break;   \
>                         ^~~~
> ./include/linux/percpu-defs.h:494:29: note: in expansion of macro ‘__pcpu_size_call_return’
>   #define this_cpu_read(pcp)  __pcpu_size_call_return(this_cpu_read_, pcp)
>                               ^~~~~~~~~~~~~~~~~~~~~~~
> arch/powerpc/lib/code-patching.c:150:7: note: in expansion of macro ‘this_cpu_read’
>    if (!this_cpu_read(*PTRRELOC(&text_poke_area)))
>         ^~~~~~~~~~~~~
> arch/powerpc/lib/code-patching.c:150:21: error: invalid type argument of unary ‘*’ (have ‘int’)
>    if (!this_cpu_read(*PTRRELOC(&text_poke_area)))
>                       ^~~~~~~~~~~~~~~~~~~~~~~~~~
> ./include/linux/compiler.h:524:64: note: in definition of macro ‘__native_word’
>   # define __native_word(t) (sizeof(t) == sizeof(char) || sizeof(t) == sizeof(short) || sizeof(t) == sizeof(int) || sizeof(t) == sizeof(long))
>                                                                  ^
> ./include/asm-generic/percpu.h:333:31: note: in expansion of macro ‘this_cpu_generic_read’
>   #define this_cpu_read_8(pcp)  this_cpu_generic_read(pcp)
>                                 ^~~~~~~~~~~~~~~~~~~~~
> ./include/linux/percpu-defs.h:311:23: note: in expansion of macro ‘this_cpu_read_8’
>    case 8: pscr_ret__ = stem##8(variable); break;   \
>                         ^~~~
> ./include/linux/percpu-defs.h:494:29: note: in expansion of macro ‘__pcpu_size_call_return’
>   #define this_cpu_read(pcp)  __pcpu_size_call_return(this_cpu_read_, pcp)
>                               ^~~~~~~~~~~~~~~~~~~~~~~
> arch/powerpc/lib/code-patching.c:150:7: note: in expansion of macro ‘this_cpu_read’
>    if (!this_cpu_read(*PTRRELOC(&text_poke_area)))
>         ^~~~~~~~~~~~~
> arch/powerpc/lib/code-patching.c:150:21: error: invalid type argument of unary ‘*’ (have ‘int’)
>    if (!this_cpu_read(*PTRRELOC(&text_poke_area)))
>                       ^~~~~~~~~~~~~~~~~~~~~~~~~~
> ./include/linux/compiler.h:524:94: note: in definition of macro ‘__native_word’
>   # define __native_word(t) (sizeof(t) == sizeof(char) || sizeof(t) == sizeof(short) || sizeof(t) == sizeof(int) || sizeof(t) == sizeof(long))
>                                                                                                ^
> ./include/asm-generic/percpu.h:333:31: note: in expansion of macro ‘this_cpu_generic_read’
>   #define this_cpu_read_8(pcp)  this_cpu_generic_read(pcp)
>                                 ^~~~~~~~~~~~~~~~~~~~~
> ./include/linux/percpu-defs.h:311:23: note: in expansion of macro ‘this_cpu_read_8’
>    case 8: pscr_ret__ = stem##8(variable); break;   \
>                         ^~~~
> ./include/linux/percpu-defs.h:494:29: note: in expansion of macro ‘__pcpu_size_call_return’
>   #define this_cpu_read(pcp)  __pcpu_size_call_return(this_cpu_read_, pcp)
>                               ^~~~~~~~~~~~~~~~~~~~~~~
> arch/powerpc/lib/code-patching.c:150:7: note: in expansion of macro ‘this_cpu_read’
>    if (!this_cpu_read(*PTRRELOC(&text_poke_area)))
>         ^~~~~~~~~~~~~
> arch/powerpc/lib/code-patching.c:150:21: error: invalid type argument of unary ‘*’ (have ‘int’)
>    if (!this_cpu_read(*PTRRELOC(&text_poke_area)))
>                       ^~~~~~~~~~~~~~~~~~~~~~~~~~
> ./include/linux/compiler.h:524:122: note: in definition of macro ‘__native_word’
>   # define __native_word(t) (sizeof(t) == sizeof(char) || sizeof(t) == sizeof(short) || sizeof(t) == sizeof(int) || sizeof(t) == sizeof(long))
>                                                                                                                            ^
> ./include/asm-generic/percpu.h:333:31: note: in expansion of macro ‘this_cpu_generic_read’
>   #define this_cpu_read_8(pcp)  this_cpu_generic_read(pcp)
>                                 ^~~~~~~~~~~~~~~~~~~~~
> ./include/linux/percpu-defs.h:311:23: note: in expansion of macro ‘this_cpu_read_8’
>    case 8: pscr_ret__ = stem##8(variable); break;   \
>                         ^~~~
> ./include/linux/percpu-defs.h:494:29: note: in expansion of macro ‘__pcpu_size_call_return’
>   #define this_cpu_read(pcp)  __pcpu_size_call_return(this_cpu_read_, pcp)
>                               ^~~~~~~~~~~~~~~~~~~~~~~
> arch/powerpc/lib/code-patching.c:150:7: note: in expansion of macro ‘this_cpu_read’
>    if (!this_cpu_read(*PTRRELOC(&text_poke_area)))
>         ^~~~~~~~~~~~~
> In file included from ./arch/powerpc/include/asm/percpu.h:20:0,
>                   from ./include/linux/percpu.h:13,
>                   from ./include/linux/kprobes.h:38,
>                   from arch/powerpc/lib/code-patching.c:11:
> arch/powerpc/lib/code-patching.c:150:21: error: invalid type argument of unary ‘*’ (have ‘int’)
>    if (!this_cpu_read(*PTRRELOC(&text_poke_area)))
>                       ^~~~~~~~~~~~~~~~~~~~~~~~~~
> ./include/asm-generic/percpu.h:121:9: note: in definition of macro ‘__this_cpu_generic_read_nopreempt’
>    typeof(pcp) __ret;      \
>           ^~~
> ./include/asm-generic/percpu.h:333:31: note: in expansion of macro ‘this_cpu_generic_read’
>   #define this_cpu_read_8(pcp)  this_cpu_generic_read(pcp)
>                                 ^~~~~~~~~~~~~~~~~~~~~
> ./include/linux/percpu-defs.h:311:23: note: in expansion of macro ‘this_cpu_read_8’
>    case 8: pscr_ret__ = stem##8(variable); break;   \
>                         ^~~~
> ./include/linux/percpu-defs.h:494:29: note: in expansion of macro ‘__pcpu_size_call_return’
>   #define this_cpu_read(pcp)  __pcpu_size_call_return(this_cpu_read_, pcp)
>                               ^~~~~~~~~~~~~~~~~~~~~~~
> arch/powerpc/lib/code-patching.c:150:7: note: in expansion of macro ‘this_cpu_read’
>    if (!this_cpu_read(*PTRRELOC(&text_poke_area)))
>         ^~~~~~~~~~~~~
> In file included from ./include/linux/linkage.h:5:0,
>                   from ./include/linux/kernel.h:7,
>                   from arch/powerpc/lib/code-patching.c:10:
> arch/powerpc/lib/code-patching.c:150:21: error: invalid type argument of unary ‘*’ (have ‘int’)
>    if (!this_cpu_read(*PTRRELOC(&text_poke_area)))
>                       ^~~~~~~~~~~~~~~~~~~~~~~~~~
> ./include/linux/compiler.h:339:17: note: in definition of macro ‘__READ_ONCE’
>    union { typeof(x) __val; char __c[1]; } __u;   \
>                   ^
> ./include/asm-generic/percpu.h:123:10: note: in expansion of macro ‘READ_ONCE’
>    __ret = READ_ONCE(*raw_cpu_ptr(&(pcp)));   \
>            ^~~~~~~~~
> ./include/linux/percpu-defs.h:246:2: note: in expansion of macro ‘__verify_pcpu_ptr’
>    __verify_pcpu_ptr(__p);      \
>    ^~~~~~~~~~~~~~~~~
> ./include/linux/percpu-defs.h:250:47: note: in expansion of macro ‘VERIFY_PERCPU_PTR’
>   #define per_cpu_ptr(ptr, cpu) ({ (void)(cpu); VERIFY_PERCPU_PTR(ptr); })
>                                                 ^~~~~~~~~~~~~~~~~
> ./include/linux/percpu-defs.h:251:26: note: in expansion of macro ‘per_cpu_ptr’
>   #define raw_cpu_ptr(ptr) per_cpu_ptr(ptr, 0)
>                            ^~~~~~~~~~~
> ./include/asm-generic/percpu.h:123:21: note: in expansion of macro ‘raw_cpu_ptr’
>    __ret = READ_ONCE(*raw_cpu_ptr(&(pcp)));   \
>                       ^~~~~~~~~~~
> ./include/asm-generic/percpu.h:142:11: note: in expansion of macro ‘__this_cpu_generic_read_nopreempt’
>     __ret = __this_cpu_generic_read_nopreempt(pcp);  \
>             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> ./include/asm-generic/percpu.h:333:31: note: in expansion of macro ‘this_cpu_generic_read’
>   #define this_cpu_read_8(pcp)  this_cpu_generic_read(pcp)
>                                 ^~~~~~~~~~~~~~~~~~~~~
> ./include/linux/percpu-defs.h:311:23: note: in expansion of macro ‘this_cpu_read_8’
>    case 8: pscr_ret__ = stem##8(variable); break;   \
>                         ^~~~
> ./include/linux/percpu-defs.h:494:29: note: in expansion of macro ‘__pcpu_size_call_return’
>   #define this_cpu_read(pcp)  __pcpu_size_call_return(this_cpu_read_, pcp)
>                               ^~~~~~~~~~~~~~~~~~~~~~~
> arch/powerpc/lib/code-patching.c:150:7: note: in expansion of macro ‘this_cpu_read’
>    if (!this_cpu_read(*PTRRELOC(&text_poke_area)))
>         ^~~~~~~~~~~~~
> arch/powerpc/lib/code-patching.c:150:21: error: invalid type argument of unary ‘*’ (have ‘int’)
>    if (!this_cpu_read(*PTRRELOC(&text_poke_area)))
>                       ^~~~~~~~~~~~~~~~~~~~~~~~~~
> ./include/linux/compiler.h:339:17: note: in definition of macro ‘__READ_ONCE’
>    union { typeof(x) __val; char __c[1]; } __u;   \
>                   ^
> ./include/asm-generic/percpu.h:123:10: note: in expansion of macro ‘READ_ONCE’
>    __ret = READ_ONCE(*raw_cpu_ptr(&(pcp)));   \
>            ^~~~~~~~~
> ./include/linux/percpu-defs.h:250:47: note: in expansion of macro ‘VERIFY_PERCPU_PTR’
>   #define per_cpu_ptr(ptr, cpu) ({ (void)(cpu); VERIFY_PERCPU_PTR(ptr); })
>                                                 ^~~~~~~~~~~~~~~~~
> ./include/linux/percpu-defs.h:251:26: note: in expansion of macro ‘per_cpu_ptr’
>   #define raw_cpu_ptr(ptr) per_cpu_ptr(ptr, 0)
>                            ^~~~~~~~~~~
> ./include/asm-generic/percpu.h:123:21: note: in expansion of macro ‘raw_cpu_ptr’
>    __ret = READ_ONCE(*raw_cpu_ptr(&(pcp)));   \
>                       ^~~~~~~~~~~
> ./include/asm-generic/percpu.h:142:11: note: in expansion of macro ‘__this_cpu_generic_read_nopreempt’
>     __ret = __this_cpu_generic_read_nopreempt(pcp);  \
>             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> ./include/asm-generic/percpu.h:333:31: note: in expansion of macro ‘this_cpu_generic_read’
>   #define this_cpu_read_8(pcp)  this_cpu_generic_read(pcp)
>                                 ^~~~~~~~~~~~~~~~~~~~~
> ./include/linux/percpu-defs.h:311:23: note: in expansion of macro ‘this_cpu_read_8’
>    case 8: pscr_ret__ = stem##8(variable); break;   \
>                         ^~~~
> ./include/linux/percpu-defs.h:494:29: note: in expansion of macro ‘__pcpu_size_call_return’
>   #define this_cpu_read(pcp)  __pcpu_size_call_return(this_cpu_read_, pcp)
>                               ^~~~~~~~~~~~~~~~~~~~~~~
> arch/powerpc/lib/code-patching.c:150:7: note: in expansion of macro ‘this_cpu_read’
>    if (!this_cpu_read(*PTRRELOC(&text_poke_area)))
>         ^~~~~~~~~~~~~
> arch/powerpc/lib/code-patching.c:150:21: error: invalid type argument of unary ‘*’ (have ‘int’)
>    if (!this_cpu_read(*PTRRELOC(&text_poke_area)))
>                       ^~~~~~~~~~~~~~~~~~~~~~~~~~
> ./include/linux/compiler.h:339:17: note: in definition of macro ‘__READ_ONCE’
>    union { typeof(x) __val; char __c[1]; } __u;   \
>                   ^
> ./include/asm-generic/percpu.h:123:10: note: in expansion of macro ‘READ_ONCE’
>    __ret = READ_ONCE(*raw_cpu_ptr(&(pcp)));   \
>            ^~~~~~~~~
> ./include/linux/percpu-defs.h:250:47: note: in expansion of macro ‘VERIFY_PERCPU_PTR’
>   #define per_cpu_ptr(ptr, cpu) ({ (void)(cpu); VERIFY_PERCPU_PTR(ptr); })
>                                                 ^~~~~~~~~~~~~~~~~
> ./include/linux/percpu-defs.h:251:26: note: in expansion of macro ‘per_cpu_ptr’
>   #define raw_cpu_ptr(ptr) per_cpu_ptr(ptr, 0)
>                            ^~~~~~~~~~~
> ./include/asm-generic/percpu.h:123:21: note: in expansion of macro ‘raw_cpu_ptr’
>    __ret = READ_ONCE(*raw_cpu_ptr(&(pcp)));   \
>                       ^~~~~~~~~~~
> ./include/asm-generic/percpu.h:142:11: note: in expansion of macro ‘__this_cpu_generic_read_nopreempt’
>     __ret = __this_cpu_generic_read_nopreempt(pcp);  \
>             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> ./include/asm-generic/percpu.h:333:31: note: in expansion of macro ‘this_cpu_generic_read’
>   #define this_cpu_read_8(pcp)  this_cpu_generic_read(pcp)
>                                 ^~~~~~~~~~~~~~~~~~~~~
> ./include/linux/percpu-defs.h:311:23: note: in expansion of macro ‘this_cpu_read_8’
>    case 8: pscr_ret__ = stem##8(variable); break;   \
>                         ^~~~
> ./include/linux/percpu-defs.h:494:29: note: in expansion of macro ‘__pcpu_size_call_return’
>   #define this_cpu_read(pcp)  __pcpu_size_call_return(this_cpu_read_, pcp)
>                               ^~~~~~~~~~~~~~~~~~~~~~~
> arch/powerpc/lib/code-patching.c:150:7: note: in expansion of macro ‘this_cpu_read’
>    if (!this_cpu_read(*PTRRELOC(&text_poke_area)))
>         ^~~~~~~~~~~~~
> arch/powerpc/lib/code-patching.c:150:21: error: invalid type argument of unary ‘*’ (have ‘int’)
>    if (!this_cpu_read(*PTRRELOC(&text_poke_area)))
>                       ^~~~~~~~~~~~~~~~~~~~~~~~~~
> ./include/linux/compiler.h:341:22: note: in definition of macro ‘__READ_ONCE’
>     __read_once_size(&(x), __u.__c, sizeof(x));  \
>                        ^
> ./include/asm-generic/percpu.h:123:10: note: in expansion of macro ‘READ_ONCE’
>    __ret = READ_ONCE(*raw_cpu_ptr(&(pcp)));   \
>            ^~~~~~~~~
> ./include/linux/percpu-defs.h:246:2: note: in expansion of macro ‘__verify_pcpu_ptr’
>    __verify_pcpu_ptr(__p);      \
>    ^~~~~~~~~~~~~~~~~
> ./include/linux/percpu-defs.h:250:47: note: in expansion of macro ‘VERIFY_PERCPU_PTR’
>   #define per_cpu_ptr(ptr, cpu) ({ (void)(cpu); VERIFY_PERCPU_PTR(ptr); })
>                                                 ^~~~~~~~~~~~~~~~~
> ./include/linux/percpu-defs.h:251:26: note: in expansion of macro ‘per_cpu_ptr’
>   #define raw_cpu_ptr(ptr) per_cpu_ptr(ptr, 0)
>                            ^~~~~~~~~~~
> ./include/asm-generic/percpu.h:123:21: note: in expansion of macro ‘raw_cpu_ptr’
>    __ret = READ_ONCE(*raw_cpu_ptr(&(pcp)));   \
>                       ^~~~~~~~~~~
> ./include/asm-generic/percpu.h:142:11: note: in expansion of macro ‘__this_cpu_generic_read_nopreempt’
>     __ret = __this_cpu_generic_read_nopreempt(pcp);  \
>             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> ./include/asm-generic/percpu.h:333:31: note: in expansion of macro ‘this_cpu_generic_read’
>   #define this_cpu_read_8(pcp)  this_cpu_generic_read(pcp)
>                                 ^~~~~~~~~~~~~~~~~~~~~
> ./include/linux/percpu-defs.h:311:23: note: in expansion of macro ‘this_cpu_read_8’
>    case 8: pscr_ret__ = stem##8(variable); break;   \
>                         ^~~~
> ./include/linux/percpu-defs.h:494:29: note: in expansion of macro ‘__pcpu_size_call_return’
>   #define this_cpu_read(pcp)  __pcpu_size_call_return(this_cpu_read_, pcp)
>                               ^~~~~~~~~~~~~~~~~~~~~~~
> arch/powerpc/lib/code-patching.c:150:7: note: in expansion of macro ‘this_cpu_read’
>    if (!this_cpu_read(*PTRRELOC(&text_poke_area)))
>         ^~~~~~~~~~~~~
> arch/powerpc/lib/code-patching.c:150:21: error: invalid type argument of unary ‘*’ (have ‘int’)
>    if (!this_cpu_read(*PTRRELOC(&text_poke_area)))
>                       ^~~~~~~~~~~~~~~~~~~~~~~~~~
> ./include/linux/compiler.h:341:22: note: in definition of macro ‘__READ_ONCE’
>     __read_once_size(&(x), __u.__c, sizeof(x));  \
>                        ^
> ./include/asm-generic/percpu.h:123:10: note: in expansion of macro ‘READ_ONCE’
>    __ret = READ_ONCE(*raw_cpu_ptr(&(pcp)));   \
>            ^~~~~~~~~
> ./include/linux/percpu-defs.h:250:47: note: in expansion of macro ‘VERIFY_PERCPU_PTR’
>   #define per_cpu_ptr(ptr, cpu) ({ (void)(cpu); VERIFY_PERCPU_PTR(ptr); })
>                                                 ^~~~~~~~~~~~~~~~~
> ./include/linux/percpu-defs.h:251:26: note: in expansion of macro ‘per_cpu_ptr’
>   #define raw_cpu_ptr(ptr) per_cpu_ptr(ptr, 0)
>                            ^~~~~~~~~~~
> ./include/asm-generic/percpu.h:123:21: note: in expansion of macro ‘raw_cpu_ptr’
>    __ret = READ_ONCE(*raw_cpu_ptr(&(pcp)));   \
>                       ^~~~~~~~~~~
> ./include/asm-generic/percpu.h:142:11: note: in expansion of macro ‘__this_cpu_generic_read_nopreempt’
>     __ret = __this_cpu_generic_read_nopreempt(pcp);  \
>             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> ./include/asm-generic/percpu.h:333:31: note: in expansion of macro ‘this_cpu_generic_read’
>   #define this_cpu_read_8(pcp)  this_cpu_generic_read(pcp)
>                                 ^~~~~~~~~~~~~~~~~~~~~
> ./include/linux/percpu-defs.h:311:23: note: in expansion of macro ‘this_cpu_read_8’
>    case 8: pscr_ret__ = stem##8(variable); break;   \
>                         ^~~~
> ./include/linux/percpu-defs.h:494:29: note: in expansion of macro ‘__pcpu_size_call_return’
>   #define this_cpu_read(pcp)  __pcpu_size_call_return(this_cpu_read_, pcp)
>                               ^~~~~~~~~~~~~~~~~~~~~~~
> arch/powerpc/lib/code-patching.c:150:7: note: in expansion of macro ‘this_cpu_read’
>    if (!this_cpu_read(*PTRRELOC(&text_poke_area)))
>         ^~~~~~~~~~~~~
> arch/powerpc/lib/code-patching.c:150:21: error: invalid type argument of unary ‘*’ (have ‘int’)
>    if (!this_cpu_read(*PTRRELOC(&text_poke_area)))
>                       ^~~~~~~~~~~~~~~~~~~~~~~~~~
> ./include/linux/compiler.h:341:22: note: in definition of macro ‘__READ_ONCE’
>     __read_once_size(&(x), __u.__c, sizeof(x));  \
>                        ^
> ./include/asm-generic/percpu.h:123:10: note: in expansion of macro ‘READ_ONCE’
>    __ret = READ_ONCE(*raw_cpu_ptr(&(pcp)));   \
>            ^~~~~~~~~
> ./include/linux/percpu-defs.h:250:47: note: in expansion of macro ‘VERIFY_PERCPU_PTR’
>   #define per_cpu_ptr(ptr, cpu) ({ (void)(cpu); VERIFY_PERCPU_PTR(ptr); })
>                                                 ^~~~~~~~~~~~~~~~~
> ./include/linux/percpu-defs.h:251:26: note: in expansion of macro ‘per_cpu_ptr’
>   #define raw_cpu_ptr(ptr) per_cpu_ptr(ptr, 0)
>                            ^~~~~~~~~~~
> ./include/asm-generic/percpu.h:123:21: note: in expansion of macro ‘raw_cpu_ptr’
>    __ret = READ_ONCE(*raw_cpu_ptr(&(pcp)));   \
>                       ^~~~~~~~~~~
> ./include/asm-generic/percpu.h:142:11: note: in expansion of macro ‘__this_cpu_generic_read_nopreempt’
>     __ret = __this_cpu_generic_read_nopreempt(pcp);  \
>             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> ./include/asm-generic/percpu.h:333:31: note: in expansion of macro ‘this_cpu_generic_read’
>   #define this_cpu_read_8(pcp)  this_cpu_generic_read(pcp)
>                                 ^~~~~~~~~~~~~~~~~~~~~
> ./include/linux/percpu-defs.h:311:23: note: in expansion of macro ‘this_cpu_read_8’
>    case 8: pscr_ret__ = stem##8(variable); break;   \
>                         ^~~~
> ./include/linux/percpu-defs.h:494:29: note: in expansion of macro ‘__pcpu_size_call_return’
>   #define this_cpu_read(pcp)  __pcpu_size_call_return(this_cpu_read_, pcp)
>                               ^~~~~~~~~~~~~~~~~~~~~~~
> arch/powerpc/lib/code-patching.c:150:7: note: in expansion of macro ‘this_cpu_read’
>    if (!this_cpu_read(*PTRRELOC(&text_poke_area)))
>         ^~~~~~~~~~~~~
> arch/powerpc/lib/code-patching.c:150:21: error: invalid type argument of unary ‘*’ (have ‘int’)
>    if (!this_cpu_read(*PTRRELOC(&text_poke_area)))
>                       ^~~~~~~~~~~~~~~~~~~~~~~~~~
> ./include/linux/compiler.h:341:42: note: in definition of macro ‘__READ_ONCE’
>     __read_once_size(&(x), __u.__c, sizeof(x));  \
>                                            ^
> ./include/asm-generic/percpu.h:123:10: note: in expansion of macro ‘READ_ONCE’
>    __ret = READ_ONCE(*raw_cpu_ptr(&(pcp)));   \
>            ^~~~~~~~~
> ./include/linux/percpu-defs.h:246:2: note: in expansion of macro ‘__verify_pcpu_ptr’
>    __verify_pcpu_ptr(__p);      \
>    ^~~~~~~~~~~~~~~~~
> ./include/linux/percpu-defs.h:250:47: note: in expansion of macro ‘VERIFY_PERCPU_PTR’
>   #define per_cpu_ptr(ptr, cpu) ({ (void)(cpu); VERIFY_PERCPU_PTR(ptr); })
>                                                 ^~~~~~~~~~~~~~~~~
> ./include/linux/percpu-defs.h:251:26: note: in expansion of macro ‘per_cpu_ptr’
>   #define raw_cpu_ptr(ptr) per_cpu_ptr(ptr, 0)
>                            ^~~~~~~~~~~
> ./include/asm-generic/percpu.h:123:21: note: in expansion of macro ‘raw_cpu_ptr’
>    __ret = READ_ONCE(*raw_cpu_ptr(&(pcp)));   \
>                       ^~~~~~~~~~~
> ./include/asm-generic/percpu.h:142:11: note: in expansion of macro ‘__this_cpu_generic_read_nopreempt’
>     __ret = __this_cpu_generic_read_nopreempt(pcp);  \
>             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> ./include/asm-generic/percpu.h:333:31: note: in expansion of macro ‘this_cpu_generic_read’
>   #define this_cpu_read_8(pcp)  this_cpu_generic_read(pcp)
>                                 ^~~~~~~~~~~~~~~~~~~~~
> ./include/linux/percpu-defs.h:311:23: note: in expansion of macro ‘this_cpu_read_8’
>    case 8: pscr_ret__ = stem##8(variable); break;   \
>                         ^~~~
> ./include/linux/percpu-defs.h:494:29: note: in expansion of macro ‘__pcpu_size_call_return’
>   #define this_cpu_read(pcp)  __pcpu_size_call_return(this_cpu_read_, pcp)
>                               ^~~~~~~~~~~~~~~~~~~~~~~
> arch/powerpc/lib/code-patching.c:150:7: note: in expansion of macro ‘this_cpu_read’
>    if (!this_cpu_read(*PTRRELOC(&text_poke_area)))
>         ^~~~~~~~~~~~~
> arch/powerpc/lib/code-patching.c:150:21: error: invalid type argument of unary ‘*’ (have ‘int’)
>    if (!this_cpu_read(*PTRRELOC(&text_poke_area)))
>                       ^~~~~~~~~~~~~~~~~~~~~~~~~~
> ./include/linux/compiler.h:341:42: note: in definition of macro ‘__READ_ONCE’
>     __read_once_size(&(x), __u.__c, sizeof(x));  \
>                                            ^
> ./include/asm-generic/percpu.h:123:10: note: in expansion of macro ‘READ_ONCE’
>    __ret = READ_ONCE(*raw_cpu_ptr(&(pcp)));   \
>            ^~~~~~~~~
> ./include/linux/percpu-defs.h:250:47: note: in expansion of macro ‘VERIFY_PERCPU_PTR’
>   #define per_cpu_ptr(ptr, cpu) ({ (void)(cpu); VERIFY_PERCPU_PTR(ptr); })
>                                                 ^~~~~~~~~~~~~~~~~
> ./include/linux/percpu-defs.h:251:26: note: in expansion of macro ‘per_cpu_ptr’
>   #define raw_cpu_ptr(ptr) per_cpu_ptr(ptr, 0)
>                            ^~~~~~~~~~~
> ./include/asm-generic/percpu.h:123:21: note: in expansion of macro ‘raw_cpu_ptr’
>    __ret = READ_ONCE(*raw_cpu_ptr(&(pcp)));   \
>                       ^~~~~~~~~~~
> ./include/asm-generic/percpu.h:142:11: note: in expansion of macro ‘__this_cpu_generic_read_nopreempt’
>     __ret = __this_cpu_generic_read_nopreempt(pcp);  \
>             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> ./include/asm-generic/percpu.h:333:31: note: in expansion of macro ‘this_cpu_generic_read’
>   #define this_cpu_read_8(pcp)  this_cpu_generic_read(pcp)
>                                 ^~~~~~~~~~~~~~~~~~~~~
> ./include/linux/percpu-defs.h:311:23: note: in expansion of macro ‘this_cpu_read_8’
>    case 8: pscr_ret__ = stem##8(variable); break;   \
>                         ^~~~
> ./include/linux/percpu-defs.h:494:29: note: in expansion of macro ‘__pcpu_size_call_return’
>   #define this_cpu_read(pcp)  __pcpu_size_call_return(this_cpu_read_, pcp)
>                               ^~~~~~~~~~~~~~~~~~~~~~~
> arch/powerpc/lib/code-patching.c:150:7: note: in expansion of macro ‘this_cpu_read’
>    if (!this_cpu_read(*PTRRELOC(&text_poke_area)))
>         ^~~~~~~~~~~~~
> arch/powerpc/lib/code-patching.c:150:21: error: invalid type argument of unary ‘*’ (have ‘int’)
>    if (!this_cpu_read(*PTRRELOC(&text_poke_area)))
>                       ^~~~~~~~~~~~~~~~~~~~~~~~~~
> ./include/linux/compiler.h:341:42: note: in definition of macro ‘__READ_ONCE’
>     __read_once_size(&(x), __u.__c, sizeof(x));  \
>                                            ^
> ./include/asm-generic/percpu.h:123:10: note: in expansion of macro ‘READ_ONCE’
>    __ret = READ_ONCE(*raw_cpu_ptr(&(pcp)));   \
>            ^~~~~~~~~
> ./include/linux/percpu-defs.h:250:47: note: in expansion of macro ‘VERIFY_PERCPU_PTR’
>   #define per_cpu_ptr(ptr, cpu) ({ (void)(cpu); VERIFY_PERCPU_PTR(ptr); })
>                                                 ^~~~~~~~~~~~~~~~~
> ./include/linux/percpu-defs.h:251:26: note: in expansion of macro ‘per_cpu_ptr’
>   #define raw_cpu_ptr(ptr) per_cpu_ptr(ptr, 0)
>                            ^~~~~~~~~~~
> ./include/asm-generic/percpu.h:123:21: note: in expansion of macro ‘raw_cpu_ptr’
>    __ret = READ_ONCE(*raw_cpu_ptr(&(pcp)));   \
>                       ^~~~~~~~~~~
> ./include/asm-generic/percpu.h:142:11: note: in expansion of macro ‘__this_cpu_generic_read_nopreempt’
>     __ret = __this_cpu_generic_read_nopreempt(pcp);  \
>             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> ./include/asm-generic/percpu.h:333:31: note: in expansion of macro ‘this_cpu_generic_read’
>   #define this_cpu_read_8(pcp)  this_cpu_generic_read(pcp)
>                                 ^~~~~~~~~~~~~~~~~~~~~
> ./include/linux/percpu-defs.h:311:23: note: in expansion of macro ‘this_cpu_read_8’
>    case 8: pscr_ret__ = stem##8(variable); break;   \
>                         ^~~~
> ./include/linux/percpu-defs.h:494:29: note: in expansion of macro ‘__pcpu_size_call_return’
>   #define this_cpu_read(pcp)  __pcpu_size_call_return(this_cpu_read_, pcp)
>                               ^~~~~~~~~~~~~~~~~~~~~~~
> arch/powerpc/lib/code-patching.c:150:7: note: in expansion of macro ‘this_cpu_read’
>    if (!this_cpu_read(*PTRRELOC(&text_poke_area)))
>         ^~~~~~~~~~~~~
> arch/powerpc/lib/code-patching.c:150:21: error: invalid type argument of unary ‘*’ (have ‘int’)
>    if (!this_cpu_read(*PTRRELOC(&text_poke_area)))
>                       ^~~~~~~~~~~~~~~~~~~~~~~~~~
> ./include/linux/compiler.h:343:30: note: in definition of macro ‘__READ_ONCE’
>     __read_once_size_nocheck(&(x), __u.__c, sizeof(x)); \
>                                ^
> ./include/asm-generic/percpu.h:123:10: note: in expansion of macro ‘READ_ONCE’
>    __ret = READ_ONCE(*raw_cpu_ptr(&(pcp)));   \
>            ^~~~~~~~~
> ./include/linux/percpu-defs.h:246:2: note: in expansion of macro ‘__verify_pcpu_ptr’
>    __verify_pcpu_ptr(__p);      \
>    ^~~~~~~~~~~~~~~~~
> ./include/linux/percpu-defs.h:250:47: note: in expansion of macro ‘VERIFY_PERCPU_PTR’
>   #define per_cpu_ptr(ptr, cpu) ({ (void)(cpu); VERIFY_PERCPU_PTR(ptr); })
>                                                 ^~~~~~~~~~~~~~~~~
> ./include/linux/percpu-defs.h:251:26: note: in expansion of macro ‘per_cpu_ptr’
>   #define raw_cpu_ptr(ptr) per_cpu_ptr(ptr, 0)
>                            ^~~~~~~~~~~
> ./include/asm-generic/percpu.h:123:21: note: in expansion of macro ‘raw_cpu_ptr’
>    __ret = READ_ONCE(*raw_cpu_ptr(&(pcp)));   \
>                       ^~~~~~~~~~~
> ./include/asm-generic/percpu.h:142:11: note: in expansion of macro ‘__this_cpu_generic_read_nopreempt’
>     __ret = __this_cpu_generic_read_nopreempt(pcp);  \
>             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> ./include/asm-generic/percpu.h:333:31: note: in expansion of macro ‘this_cpu_generic_read’
>   #define this_cpu_read_8(pcp)  this_cpu_generic_read(pcp)
>                                 ^~~~~~~~~~~~~~~~~~~~~
> ./include/linux/percpu-defs.h:311:23: note: in expansion of macro ‘this_cpu_read_8’
>    case 8: pscr_ret__ = stem##8(variable); break;   \
>                         ^~~~
> ./include/linux/percpu-defs.h:494:29: note: in expansion of macro ‘__pcpu_size_call_return’
>   #define this_cpu_read(pcp)  __pcpu_size_call_return(this_cpu_read_, pcp)
>                               ^~~~~~~~~~~~~~~~~~~~~~~
> arch/powerpc/lib/code-patching.c:150:7: note: in expansion of macro ‘this_cpu_read’
>    if (!this_cpu_read(*PTRRELOC(&text_poke_area)))
>         ^~~~~~~~~~~~~
> arch/powerpc/lib/code-patching.c:150:21: error: invalid type argument of unary ‘*’ (have ‘int’)
>    if (!this_cpu_read(*PTRRELOC(&text_poke_area)))
>                       ^~~~~~~~~~~~~~~~~~~~~~~~~~
> ./include/linux/compiler.h:343:30: note: in definition of macro ‘__READ_ONCE’
>     __read_once_size_nocheck(&(x), __u.__c, sizeof(x)); \
>                                ^
> ./include/asm-generic/percpu.h:123:10: note: in expansion of macro ‘READ_ONCE’
>    __ret = READ_ONCE(*raw_cpu_ptr(&(pcp)));   \
>            ^~~~~~~~~
> ./include/linux/percpu-defs.h:250:47: note: in expansion of macro ‘VERIFY_PERCPU_PTR’
>   #define per_cpu_ptr(ptr, cpu) ({ (void)(cpu); VERIFY_PERCPU_PTR(ptr); })
>                                                 ^~~~~~~~~~~~~~~~~
> ./include/linux/percpu-defs.h:251:26: note: in expansion of macro ‘per_cpu_ptr’
>   #define raw_cpu_ptr(ptr) per_cpu_ptr(ptr, 0)
>                            ^~~~~~~~~~~
> ./include/asm-generic/percpu.h:123:21: note: in expansion of macro ‘raw_cpu_ptr’
>    __ret = READ_ONCE(*raw_cpu_ptr(&(pcp)));   \
>                       ^~~~~~~~~~~
> ./include/asm-generic/percpu.h:142:11: note: in expansion of macro ‘__this_cpu_generic_read_nopreempt’
>     __ret = __this_cpu_generic_read_nopreempt(pcp);  \
>             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> ./include/asm-generic/percpu.h:333:31: note: in expansion of macro ‘this_cpu_generic_read’
>   #define this_cpu_read_8(pcp)  this_cpu_generic_read(pcp)
>                                 ^~~~~~~~~~~~~~~~~~~~~
> ./include/linux/percpu-defs.h:311:23: note: in expansion of macro ‘this_cpu_read_8’
>    case 8: pscr_ret__ = stem##8(variable); break;   \
>                         ^~~~
> ./include/linux/percpu-defs.h:494:29: note: in expansion of macro ‘__pcpu_size_call_return’
>   #define this_cpu_read(pcp)  __pcpu_size_call_return(this_cpu_read_, pcp)
>                               ^~~~~~~~~~~~~~~~~~~~~~~
> arch/powerpc/lib/code-patching.c:150:7: note: in expansion of macro ‘this_cpu_read’
>    if (!this_cpu_read(*PTRRELOC(&text_poke_area)))
>         ^~~~~~~~~~~~~
> arch/powerpc/lib/code-patching.c:150:21: error: invalid type argument of unary ‘*’ (have ‘int’)
>    if (!this_cpu_read(*PTRRELOC(&text_poke_area)))
>                       ^~~~~~~~~~~~~~~~~~~~~~~~~~
> ./include/linux/compiler.h:343:30: note: in definition of macro ‘__READ_ONCE’
>     __read_once_size_nocheck(&(x), __u.__c, sizeof(x)); \
>                                ^
> ./include/asm-generic/percpu.h:123:10: note: in expansion of macro ‘READ_ONCE’
>    __ret = READ_ONCE(*raw_cpu_ptr(&(pcp)));   \
>            ^~~~~~~~~
> ./include/linux/percpu-defs.h:250:47: note: in expansion of macro ‘VERIFY_PERCPU_PTR’
>   #define per_cpu_ptr(ptr, cpu) ({ (void)(cpu); VERIFY_PERCPU_PTR(ptr); })
>                                                 ^~~~~~~~~~~~~~~~~
> ./include/linux/percpu-defs.h:251:26: note: in expansion of macro ‘per_cpu_ptr’
>   #define raw_cpu_ptr(ptr) per_cpu_ptr(ptr, 0)
>                            ^~~~~~~~~~~
> ./include/asm-generic/percpu.h:123:21: note: in expansion of macro ‘raw_cpu_ptr’
>    __ret = READ_ONCE(*raw_cpu_ptr(&(pcp)));   \
>                       ^~~~~~~~~~~
> ./include/asm-generic/percpu.h:142:11: note: in expansion of macro ‘__this_cpu_generic_read_nopreempt’
>     __ret = __this_cpu_generic_read_nopreempt(pcp);  \
>             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> ./include/asm-generic/percpu.h:333:31: note: in expansion of macro ‘this_cpu_generic_read’
>   #define this_cpu_read_8(pcp)  this_cpu_generic_read(pcp)
>                                 ^~~~~~~~~~~~~~~~~~~~~
> ./include/linux/percpu-defs.h:311:23: note: in expansion of macro ‘this_cpu_read_8’
>    case 8: pscr_ret__ = stem##8(variable); break;   \
>                         ^~~~
> ./include/linux/percpu-defs.h:494:29: note: in expansion of macro ‘__pcpu_size_call_return’
>   #define this_cpu_read(pcp)  __pcpu_size_call_return(this_cpu_read_, pcp)
>                               ^~~~~~~~~~~~~~~~~~~~~~~
> arch/powerpc/lib/code-patching.c:150:7: note: in expansion of macro ‘this_cpu_read’
>    if (!this_cpu_read(*PTRRELOC(&text_poke_area)))
>         ^~~~~~~~~~~~~
> arch/powerpc/lib/code-patching.c:150:21: error: invalid type argument of unary ‘*’ (have ‘int’)
>    if (!this_cpu_read(*PTRRELOC(&text_poke_area)))
>                       ^~~~~~~~~~~~~~~~~~~~~~~~~~
> ./include/linux/compiler.h:343:50: note: in definition of macro ‘__READ_ONCE’
>     __read_once_size_nocheck(&(x), __u.__c, sizeof(x)); \
>                                                    ^
> ./include/asm-generic/percpu.h:123:10: note: in expansion of macro ‘READ_ONCE’
>    __ret = READ_ONCE(*raw_cpu_ptr(&(pcp)));   \
>            ^~~~~~~~~
> ./include/linux/percpu-defs.h:246:2: note: in expansion of macro ‘__verify_pcpu_ptr’
>    __verify_pcpu_ptr(__p);      \
>    ^~~~~~~~~~~~~~~~~
> ./include/linux/percpu-defs.h:250:47: note: in expansion of macro ‘VERIFY_PERCPU_PTR’
>   #define per_cpu_ptr(ptr, cpu) ({ (void)(cpu); VERIFY_PERCPU_PTR(ptr); })
>                                                 ^~~~~~~~~~~~~~~~~
> ./include/linux/percpu-defs.h:251:26: note: in expansion of macro ‘per_cpu_ptr’
>   #define raw_cpu_ptr(ptr) per_cpu_ptr(ptr, 0)
>                            ^~~~~~~~~~~
> ./include/asm-generic/percpu.h:123:21: note: in expansion of macro ‘raw_cpu_ptr’
>    __ret = READ_ONCE(*raw_cpu_ptr(&(pcp)));   \
>                       ^~~~~~~~~~~
> ./include/asm-generic/percpu.h:142:11: note: in expansion of macro ‘__this_cpu_generic_read_nopreempt’
>     __ret = __this_cpu_generic_read_nopreempt(pcp);  \
>             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> ./include/asm-generic/percpu.h:333:31: note: in expansion of macro ‘this_cpu_generic_read’
>   #define this_cpu_read_8(pcp)  this_cpu_generic_read(pcp)
>                                 ^~~~~~~~~~~~~~~~~~~~~
> ./include/linux/percpu-defs.h:311:23: note: in expansion of macro ‘this_cpu_read_8’
>    case 8: pscr_ret__ = stem##8(variable); break;   \
>                         ^~~~
> ./include/linux/percpu-defs.h:494:29: note: in expansion of macro ‘__pcpu_size_call_return’
>   #define this_cpu_read(pcp)  __pcpu_size_call_return(this_cpu_read_, pcp)
>                               ^~~~~~~~~~~~~~~~~~~~~~~
> arch/powerpc/lib/code-patching.c:150:7: note: in expansion of macro ‘this_cpu_read’
>    if (!this_cpu_read(*PTRRELOC(&text_poke_area)))
>         ^~~~~~~~~~~~~
> arch/powerpc/lib/code-patching.c:150:21: error: invalid type argument of unary ‘*’ (have ‘int’)
>    if (!this_cpu_read(*PTRRELOC(&text_poke_area)))
>                       ^~~~~~~~~~~~~~~~~~~~~~~~~~
> ./include/linux/compiler.h:343:50: note: in definition of macro ‘__READ_ONCE’
>     __read_once_size_nocheck(&(x), __u.__c, sizeof(x)); \
>                                                    ^
> ./include/asm-generic/percpu.h:123:10: note: in expansion of macro ‘READ_ONCE’
>    __ret = READ_ONCE(*raw_cpu_ptr(&(pcp)));   \
>            ^~~~~~~~~
> ./include/linux/percpu-defs.h:250:47: note: in expansion of macro ‘VERIFY_PERCPU_PTR’
>   #define per_cpu_ptr(ptr, cpu) ({ (void)(cpu); VERIFY_PERCPU_PTR(ptr); })
>                                                 ^~~~~~~~~~~~~~~~~
> ./include/linux/percpu-defs.h:251:26: note: in expansion of macro ‘per_cpu_ptr’
>   #define raw_cpu_ptr(ptr) per_cpu_ptr(ptr, 0)
>                            ^~~~~~~~~~~
> ./include/asm-generic/percpu.h:123:21: note: in expansion of macro ‘raw_cpu_ptr’
>    __ret = READ_ONCE(*raw_cpu_ptr(&(pcp)));   \
>                       ^~~~~~~~~~~
> ./include/asm-generic/percpu.h:142:11: note: in expansion of macro ‘__this_cpu_generic_read_nopreempt’
>     __ret = __this_cpu_generic_read_nopreempt(pcp);  \
>             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> ./include/asm-generic/percpu.h:333:31: note: in expansion of macro ‘this_cpu_generic_read’
>   #define this_cpu_read_8(pcp)  this_cpu_generic_read(pcp)
>                                 ^~~~~~~~~~~~~~~~~~~~~
> ./include/linux/percpu-defs.h:311:23: note: in expansion of macro ‘this_cpu_read_8’
>    case 8: pscr_ret__ = stem##8(variable); break;   \
>                         ^~~~
> ./include/linux/percpu-defs.h:494:29: note: in expansion of macro ‘__pcpu_size_call_return’
>   #define this_cpu_read(pcp)  __pcpu_size_call_return(this_cpu_read_, pcp)
>                               ^~~~~~~~~~~~~~~~~~~~~~~
> arch/powerpc/lib/code-patching.c:150:7: note: in expansion of macro ‘this_cpu_read’
>    if (!this_cpu_read(*PTRRELOC(&text_poke_area)))
>         ^~~~~~~~~~~~~
> arch/powerpc/lib/code-patching.c:150:21: error: invalid type argument of unary ‘*’ (have ‘int’)
>    if (!this_cpu_read(*PTRRELOC(&text_poke_area)))
>                       ^~~~~~~~~~~~~~~~~~~~~~~~~~
> ./include/linux/compiler.h:343:50: note: in definition of macro ‘__READ_ONCE’
>     __read_once_size_nocheck(&(x), __u.__c, sizeof(x)); \
>                                                    ^
> ./include/asm-generic/percpu.h:123:10: note: in expansion of macro ‘READ_ONCE’
>    __ret = READ_ONCE(*raw_cpu_ptr(&(pcp)));   \
>            ^~~~~~~~~
> ./include/linux/percpu-defs.h:250:47: note: in expansion of macro ‘VERIFY_PERCPU_PTR’
>   #define per_cpu_ptr(ptr, cpu) ({ (void)(cpu); VERIFY_PERCPU_PTR(ptr); })
>                                                 ^~~~~~~~~~~~~~~~~
> ./include/linux/percpu-defs.h:251:26: note: in expansion of macro ‘per_cpu_ptr’
>   #define raw_cpu_ptr(ptr) per_cpu_ptr(ptr, 0)
>                            ^~~~~~~~~~~
> ./include/asm-generic/percpu.h:123:21: note: in expansion of macro ‘raw_cpu_ptr’
>    __ret = READ_ONCE(*raw_cpu_ptr(&(pcp)));   \
>                       ^~~~~~~~~~~
> ./include/asm-generic/percpu.h:142:11: note: in expansion of macro ‘__this_cpu_generic_read_nopreempt’
>     __ret = __this_cpu_generic_read_nopreempt(pcp);  \
>             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> ./include/asm-generic/percpu.h:333:31: note: in expansion of macro ‘this_cpu_generic_read’
>   #define this_cpu_read_8(pcp)  this_cpu_generic_read(pcp)
>                                 ^~~~~~~~~~~~~~~~~~~~~
> ./include/linux/percpu-defs.h:311:23: note: in expansion of macro ‘this_cpu_read_8’
>    case 8: pscr_ret__ = stem##8(variable); break;   \
>                         ^~~~
> ./include/linux/percpu-defs.h:494:29: note: in expansion of macro ‘__pcpu_size_call_return’
>   #define this_cpu_read(pcp)  __pcpu_size_call_return(this_cpu_read_, pcp)
>                               ^~~~~~~~~~~~~~~~~~~~~~~
> arch/powerpc/lib/code-patching.c:150:7: note: in expansion of macro ‘this_cpu_read’
>    if (!this_cpu_read(*PTRRELOC(&text_poke_area)))
>         ^~~~~~~~~~~~~
> In file included from ./arch/powerpc/include/asm/percpu.h:20:0,
>                   from ./include/linux/percpu.h:13,
>                   from ./include/linux/kprobes.h:38,
>                   from arch/powerpc/lib/code-patching.c:11:
> arch/powerpc/lib/code-patching.c:150:21: error: invalid type argument of unary ‘*’ (have ‘int’)
>    if (!this_cpu_read(*PTRRELOC(&text_poke_area)))
>                       ^~~~~~~~~~~~~~~~~~~~~~~~~~
> ./include/asm-generic/percpu.h:130:9: note: in definition of macro ‘__this_cpu_generic_read_noirq’
>    typeof(pcp) __ret;      \
>           ^~~
> ./include/asm-generic/percpu.h:333:31: note: in expansion of macro ‘this_cpu_generic_read’
>   #define this_cpu_read_8(pcp)  this_cpu_generic_read(pcp)
>                                 ^~~~~~~~~~~~~~~~~~~~~
> ./include/linux/percpu-defs.h:311:23: note: in expansion of macro ‘this_cpu_read_8’
>    case 8: pscr_ret__ = stem##8(variable); break;   \
>                         ^~~~
> ./include/linux/percpu-defs.h:494:29: note: in expansion of macro ‘__pcpu_size_call_return’
>   #define this_cpu_read(pcp)  __pcpu_size_call_return(this_cpu_read_, pcp)
>                               ^~~~~~~~~~~~~~~~~~~~~~~
> arch/powerpc/lib/code-patching.c:150:7: note: in expansion of macro ‘this_cpu_read’
>    if (!this_cpu_read(*PTRRELOC(&text_poke_area)))
>         ^~~~~~~~~~~~~
> In file included from ./include/asm-generic/percpu.h:7:0,
>                   from ./arch/powerpc/include/asm/percpu.h:20,
>                   from ./include/linux/percpu.h:13,
>                   from ./include/linux/kprobes.h:38,
>                   from arch/powerpc/lib/code-patching.c:11:
> arch/powerpc/lib/code-patching.c:150:21: error: invalid type argument of unary ‘*’ (have ‘int’)
>    if (!this_cpu_read(*PTRRELOC(&text_poke_area)))
>                       ^~~~~~~~~~~~~~~~~~~~~~~~~~
> ./include/linux/percpu-defs.h:206:47: note: in definition of macro ‘__verify_pcpu_ptr’
>    const void __percpu *__vpp_verify = (typeof((ptr) + 0))NULL; \
>                                                 ^~~
> ./include/linux/percpu-defs.h:250:47: note: in expansion of macro ‘VERIFY_PERCPU_PTR’
>   #define per_cpu_ptr(ptr, cpu) ({ (void)(cpu); VERIFY_PERCPU_PTR(ptr); })
>                                                 ^~~~~~~~~~~~~~~~~
> ./include/linux/percpu-defs.h:251:26: note: in expansion of macro ‘per_cpu_ptr’
>   #define raw_cpu_ptr(ptr) per_cpu_ptr(ptr, 0)
>                            ^~~~~~~~~~~
> ./include/asm-generic/percpu.h:71:3: note: in expansion of macro ‘raw_cpu_ptr’
>    *raw_cpu_ptr(&(pcp));      \
>     ^~~~~~~~~~~
> ./include/asm-generic/percpu.h:133:10: note: in expansion of macro ‘raw_cpu_generic_read’
>    __ret = raw_cpu_generic_read(pcp);    \
>            ^~~~~~~~~~~~~~~~~~~~
> ./include/asm-generic/percpu.h:144:11: note: in expansion of macro ‘__this_cpu_generic_read_noirq’
>     __ret = __this_cpu_generic_read_noirq(pcp);  \
>             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> ./include/asm-generic/percpu.h:333:31: note: in expansion of macro ‘this_cpu_generic_read’
>   #define this_cpu_read_8(pcp)  this_cpu_generic_read(pcp)
>                                 ^~~~~~~~~~~~~~~~~~~~~
> ./include/linux/percpu-defs.h:311:23: note: in expansion of macro ‘this_cpu_read_8’
>    case 8: pscr_ret__ = stem##8(variable); break;   \
>                         ^~~~
> ./include/linux/percpu-defs.h:494:29: note: in expansion of macro ‘__pcpu_size_call_return’
>   #define this_cpu_read(pcp)  __pcpu_size_call_return(this_cpu_read_, pcp)
>                               ^~~~~~~~~~~~~~~~~~~~~~~
> arch/powerpc/lib/code-patching.c:150:7: note: in expansion of macro ‘this_cpu_read’
>    if (!this_cpu_read(*PTRRELOC(&text_poke_area)))
>         ^~~~~~~~~~~~~
> arch/powerpc/lib/code-patching.c:150:21: error: invalid type argument of unary ‘*’ (have ‘int’)
>    if (!this_cpu_read(*PTRRELOC(&text_poke_area)))
>                       ^~~~~~~~~~~~~~~~~~~~~~~~~~
> ./include/linux/percpu-defs.h:247:12: note: in definition of macro ‘VERIFY_PERCPU_PTR’
>    (typeof(*(__p)) __kernel __force *)(__p);   \
>              ^~~
> ./include/linux/percpu-defs.h:251:26: note: in expansion of macro ‘per_cpu_ptr’
>   #define raw_cpu_ptr(ptr) per_cpu_ptr(ptr, 0)
>                            ^~~~~~~~~~~
> ./include/asm-generic/percpu.h:71:3: note: in expansion of macro ‘raw_cpu_ptr’
>    *raw_cpu_ptr(&(pcp));      \
>     ^~~~~~~~~~~
> ./include/asm-generic/percpu.h:133:10: note: in expansion of macro ‘raw_cpu_generic_read’
>    __ret = raw_cpu_generic_read(pcp);    \
>            ^~~~~~~~~~~~~~~~~~~~
> ./include/asm-generic/percpu.h:144:11: note: in expansion of macro ‘__this_cpu_generic_read_noirq’
>     __ret = __this_cpu_generic_read_noirq(pcp);  \
>             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> ./include/asm-generic/percpu.h:333:31: note: in expansion of macro ‘this_cpu_generic_read’
>   #define this_cpu_read_8(pcp)  this_cpu_generic_read(pcp)
>                                 ^~~~~~~~~~~~~~~~~~~~~
> ./include/linux/percpu-defs.h:311:23: note: in expansion of macro ‘this_cpu_read_8’
>    case 8: pscr_ret__ = stem##8(variable); break;   \
>                         ^~~~
> ./include/linux/percpu-defs.h:494:29: note: in expansion of macro ‘__pcpu_size_call_return’
>   #define this_cpu_read(pcp)  __pcpu_size_call_return(this_cpu_read_, pcp)
>                               ^~~~~~~~~~~~~~~~~~~~~~~
> arch/powerpc/lib/code-patching.c:150:7: note: in expansion of macro ‘this_cpu_read’
>    if (!this_cpu_read(*PTRRELOC(&text_poke_area)))
>         ^~~~~~~~~~~~~
> arch/powerpc/lib/code-patching.c:150:21: error: invalid type argument of unary ‘*’ (have ‘int’)
>    if (!this_cpu_read(*PTRRELOC(&text_poke_area)))
>                       ^~~~~~~~~~~~~~~~~~~~~~~~~~
> ./include/linux/percpu-defs.h:247:38: note: in definition of macro ‘VERIFY_PERCPU_PTR’
>    (typeof(*(__p)) __kernel __force *)(__p);   \
>                                        ^~~
> ./include/linux/percpu-defs.h:251:26: note: in expansion of macro ‘per_cpu_ptr’
>   #define raw_cpu_ptr(ptr) per_cpu_ptr(ptr, 0)
>                            ^~~~~~~~~~~
> ./include/asm-generic/percpu.h:71:3: note: in expansion of macro ‘raw_cpu_ptr’
>    *raw_cpu_ptr(&(pcp));      \
>     ^~~~~~~~~~~
> ./include/asm-generic/percpu.h:133:10: note: in expansion of macro ‘raw_cpu_generic_read’
>    __ret = raw_cpu_generic_read(pcp);    \
>            ^~~~~~~~~~~~~~~~~~~~
> ./include/asm-generic/percpu.h:144:11: note: in expansion of macro ‘__this_cpu_generic_read_noirq’
>     __ret = __this_cpu_generic_read_noirq(pcp);  \
>             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> ./include/asm-generic/percpu.h:333:31: note: in expansion of macro ‘this_cpu_generic_read’
>   #define this_cpu_read_8(pcp)  this_cpu_generic_read(pcp)
>                                 ^~~~~~~~~~~~~~~~~~~~~
> ./include/linux/percpu-defs.h:311:23: note: in expansion of macro ‘this_cpu_read_8’
>    case 8: pscr_ret__ = stem##8(variable); break;   \
>                         ^~~~
> ./include/linux/percpu-defs.h:494:29: note: in expansion of macro ‘__pcpu_size_call_return’
>   #define this_cpu_read(pcp)  __pcpu_size_call_return(this_cpu_read_, pcp)
>                               ^~~~~~~~~~~~~~~~~~~~~~~
> arch/powerpc/lib/code-patching.c:150:7: note: in expansion of macro ‘this_cpu_read’
>    if (!this_cpu_read(*PTRRELOC(&text_poke_area)))
>         ^~~~~~~~~~~~~
> cc1: all warnings being treated as errors
> scripts/Makefile.build:314: recipe for target 'arch/powerpc/lib/code-patching.o' failed
> make[1]: *** [arch/powerpc/lib/code-patching.o] Error 1
> Makefile:1024: recipe for target 'arch/powerpc/lib' failed
> make: *** [arch/powerpc/lib] Error 2
> 
