Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 410N4V5V5czF1g0
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  5 Jun 2018 17:00:58 +1000 (AEST)
Subject: Re: [v3] powerpc: fix build failure by disabling attribute-alias
 warning
To: Michael Ellerman <patch-notifications@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, segher@kernel.crashing.org
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <40zxgb4SmTz9s7c@ozlabs.org>
From: Christophe LEROY <christophe.leroy@c-s.fr>
Message-ID: <0332913c-04c0-362f-313f-8d42099f168d@c-s.fr>
Date: Tue, 5 Jun 2018 09:00:53 +0200
MIME-Version: 1.0
In-Reply-To: <40zxgb4SmTz9s7c@ozlabs.org>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



Le 04/06/2018 à 16:11, Michael Ellerman a écrit :
> On Tue, 2018-05-29 at 16:06:41 UTC, Christophe Leroy wrote:
>> Latest GCC version emit the following warnings
>>
>> As arch/powerpc code is built with -Werror, this breaks build with
>> GCC 8.1
>>
>> This patch inhibits those warnings
>>
>>    CC      arch/powerpc/kernel/syscalls.o
>> In file included from arch/powerpc/kernel/syscalls.c:24:
>> ./include/linux/syscalls.h:233:18: error: 'sys_mmap2' alias between functions of incompatible types 'long int(long unsigned int,  size_t,  long unsigned int,  long unsigned int,  long unsigned int,  long unsigned int)' {aka 'long int(long unsigned int,  long unsigned int,  long unsigned int,  long unsigned int,  long unsigned int,  long unsigned int)'} and 'long int(long int,  long int,  long int,  long int,  long int,  long int)' [-Werror=attribute-alias]
>>    asmlinkage long sys##name(__MAP(x,__SC_DECL,__VA_ARGS__)) \
>>                    ^~~
>> ./include/linux/syscalls.h:222:2: note: in expansion of macro '__SYSCALL_DEFINEx'
>>    __SYSCALL_DEFINEx(x, sname, __VA_ARGS__)
>>    ^~~~~~~~~~~~~~~~~
>> ./include/linux/syscalls.h:216:36: note: in expansion of macro 'SYSCALL_DEFINEx'
>>   #define SYSCALL_DEFINE6(name, ...) SYSCALL_DEFINEx(6, _##name, __VA_ARGS__)
>>                                      ^~~~~~~~~~~~~~~
>> arch/powerpc/kernel/syscalls.c:65:1: note: in expansion of macro 'SYSCALL_DEFINE6'
>>   SYSCALL_DEFINE6(mmap2, unsigned long, addr, size_t, len,
>>   ^~~~~~~~~~~~~~~
>> ./include/linux/syscalls.h:238:18: note: aliased declaration here
>>    asmlinkage long __se_sys##name(__MAP(x,__SC_LONG,__VA_ARGS__)) \
>>                    ^~~~~~~~
>> ./include/linux/syscalls.h:222:2: note: in expansion of macro '__SYSCALL_DEFINEx'
>>    __SYSCALL_DEFINEx(x, sname, __VA_ARGS__)
>>    ^~~~~~~~~~~~~~~~~
>> ./include/linux/syscalls.h:216:36: note: in expansion of macro 'SYSCALL_DEFINEx'
>>   #define SYSCALL_DEFINE6(name, ...) SYSCALL_DEFINEx(6, _##name, __VA_ARGS__)
>>                                      ^~~~~~~~~~~~~~~
>> arch/powerpc/kernel/syscalls.c:65:1: note: in expansion of macro 'SYSCALL_DEFINE6'
>>   SYSCALL_DEFINE6(mmap2, unsigned long, addr, size_t, len,
>>   ^~~~~~~~~~~~~~~
>> ./include/linux/syscalls.h:233:18: error: 'sys_mmap' alias between functions of incompatible types 'long int(long unsigned int,  size_t,  long unsigned int,  long unsigned int,  long unsigned int,  off_t)' {aka 'long int(long unsigned int,  long unsigned int,  long unsigned int,  long unsigned int,  long unsigned int,  long int)'} and 'long int(long int,  long int,  long int,  long int,  long int,  long int)' [-Werror=attribute-alias]
>>    asmlinkage long sys##name(__MAP(x,__SC_DECL,__VA_ARGS__)) \
>>                    ^~~
>> ./include/linux/syscalls.h:222:2: note: in expansion of macro '__SYSCALL_DEFINEx'
>>    __SYSCALL_DEFINEx(x, sname, __VA_ARGS__)
>>    ^~~~~~~~~~~~~~~~~
>> ./include/linux/syscalls.h:216:36: note: in expansion of macro 'SYSCALL_DEFINEx'
>>   #define SYSCALL_DEFINE6(name, ...) SYSCALL_DEFINEx(6, _##name, __VA_ARGS__)
>>                                      ^~~~~~~~~~~~~~~
>> arch/powerpc/kernel/syscalls.c:72:1: note: in expansion of macro 'SYSCALL_DEFINE6'
>>   SYSCALL_DEFINE6(mmap, unsigned long, addr, size_t, len,
>>   ^~~~~~~~~~~~~~~
>> ./include/linux/syscalls.h:238:18: note: aliased declaration here
>>    asmlinkage long __se_sys##name(__MAP(x,__SC_LONG,__VA_ARGS__)) \
>>                    ^~~~~~~~
>> ./include/linux/syscalls.h:222:2: note: in expansion of macro '__SYSCALL_DEFINEx'
>>    __SYSCALL_DEFINEx(x, sname, __VA_ARGS__)
>>    ^~~~~~~~~~~~~~~~~
>> ./include/linux/syscalls.h:216:36: note: in expansion of macro 'SYSCALL_DEFINEx'
>>   #define SYSCALL_DEFINE6(name, ...) SYSCALL_DEFINEx(6, _##name, __VA_ARGS__)
>>                                      ^~~~~~~~~~~~~~~
>> arch/powerpc/kernel/syscalls.c:72:1: note: in expansion of macro 'SYSCALL_DEFINE6'
>>   SYSCALL_DEFINE6(mmap, unsigned long, addr, size_t, len,
>>   ^~~~~~~~~~~~~~~
>>    CC      arch/powerpc/kernel/signal_32.o
>> In file included from arch/powerpc/kernel/signal_32.c:31:
>> ./include/linux/compat.h:74:18: error: 'compat_sys_swapcontext' alias between functions of incompatible types 'long int(struct ucontext32 *, struct ucontext32 *, int)' and 'long int(long int,  long int,  long int)' [-Werror=attribute-alias]
>>    asmlinkage long compat_sys##name(__MAP(x,__SC_DECL,__VA_ARGS__)) \
>>                    ^~~~~~~~~~
>> ./include/linux/compat.h:58:2: note: in expansion of macro 'COMPAT_SYSCALL_DEFINEx'
>>    COMPAT_SYSCALL_DEFINEx(3, _##name, __VA_ARGS__)
>>    ^~~~~~~~~~~~~~~~~~~~~~
>> arch/powerpc/kernel/signal_32.c:1041:1: note: in expansion of macro 'COMPAT_SYSCALL_DEFINE3'
>>   COMPAT_SYSCALL_DEFINE3(swapcontext, struct ucontext __user *, old_ctx,
>>   ^~~~~~~~~~~~~~~~~~~~~~
>> ./include/linux/compat.h:79:18: note: aliased declaration here
>>    asmlinkage long __se_compat_sys##name(__MAP(x,__SC_LONG,__VA_ARGS__)) \
>>                    ^~~~~~~~~~~~~~~
>> ./include/linux/compat.h:58:2: note: in expansion of macro 'COMPAT_SYSCALL_DEFINEx'
>>    COMPAT_SYSCALL_DEFINEx(3, _##name, __VA_ARGS__)
>>    ^~~~~~~~~~~~~~~~~~~~~~
>> arch/powerpc/kernel/signal_32.c:1041:1: note: in expansion of macro 'COMPAT_SYSCALL_DEFINE3'
>>   COMPAT_SYSCALL_DEFINE3(swapcontext, struct ucontext __user *, old_ctx,
>>   ^~~~~~~~~~~~~~~~~~~~~~
>>    CC      arch/powerpc/kernel/signal_64.o
>> In file included from arch/powerpc/kernel/signal_64.c:27:
>> ./include/linux/syscalls.h:233:18: error: 'sys_swapcontext' alias between functions of incompatible types 'long int(struct ucontext *, struct ucontext *, long int)' and 'long int(long int,  long int,  long int)' [-Werror=attribute-alias]
>>    asmlinkage long sys##name(__MAP(x,__SC_DECL,__VA_ARGS__)) \
>>                    ^~~
>> ./include/linux/syscalls.h:222:2: note: in expansion of macro '__SYSCALL_DEFINEx'
>>    __SYSCALL_DEFINEx(x, sname, __VA_ARGS__)
>>    ^~~~~~~~~~~~~~~~~
>> ./include/linux/syscalls.h:213:36: note: in expansion of macro 'SYSCALL_DEFINEx'
>>   #define SYSCALL_DEFINE3(name, ...) SYSCALL_DEFINEx(3, _##name, __VA_ARGS__)
>>                                      ^~~~~~~~~~~~~~~
>> arch/powerpc/kernel/signal_64.c:628:1: note: in expansion of macro 'SYSCALL_DEFINE3'
>>   SYSCALL_DEFINE3(swapcontext, struct ucontext __user *, old_ctx,
>>   ^~~~~~~~~~~~~~~
>> ./include/linux/syscalls.h:238:18: note: aliased declaration here
>>    asmlinkage long __se_sys##name(__MAP(x,__SC_LONG,__VA_ARGS__)) \
>>                    ^~~~~~~~
>> ./include/linux/syscalls.h:222:2: note: in expansion of macro '__SYSCALL_DEFINEx'
>>    __SYSCALL_DEFINEx(x, sname, __VA_ARGS__)
>>    ^~~~~~~~~~~~~~~~~
>> ./include/linux/syscalls.h:213:36: note: in expansion of macro 'SYSCALL_DEFINEx'
>>   #define SYSCALL_DEFINE3(name, ...) SYSCALL_DEFINEx(3, _##name, __VA_ARGS__)
>>                                      ^~~~~~~~~~~~~~~
>> arch/powerpc/kernel/signal_64.c:628:1: note: in expansion of macro 'SYSCALL_DEFINE3'
>>   SYSCALL_DEFINE3(swapcontext, struct ucontext __user *, old_ctx,
>>   ^~~~~~~~~~~~~~~
>>    CC      arch/powerpc/kernel/rtas.o
>> In file included from arch/powerpc/kernel/rtas.c:29:
>> ./include/linux/syscalls.h:233:18: error: 'sys_rtas' alias between functions of incompatible types 'long int(struct rtas_args *)' and 'long int(long int)' [-Werror=attribute-alias]
>>    asmlinkage long sys##name(__MAP(x,__SC_DECL,__VA_ARGS__)) \
>>                    ^~~
>> ./include/linux/syscalls.h:222:2: note: in expansion of macro '__SYSCALL_DEFINEx'
>>    __SYSCALL_DEFINEx(x, sname, __VA_ARGS__)
>>    ^~~~~~~~~~~~~~~~~
>> ./include/linux/syscalls.h:211:36: note: in expansion of macro 'SYSCALL_DEFINEx'
>>   #define SYSCALL_DEFINE1(name, ...) SYSCALL_DEFINEx(1, _##name, __VA_ARGS__)
>>                                      ^~~~~~~~~~~~~~~
>> arch/powerpc/kernel/rtas.c:1054:1: note: in expansion of macro 'SYSCALL_DEFINE1'
>>   SYSCALL_DEFINE1(rtas, struct rtas_args __user *, uargs)
>>   ^~~~~~~~~~~~~~~
>> ./include/linux/syscalls.h:238:18: note: aliased declaration here
>>    asmlinkage long __se_sys##name(__MAP(x,__SC_LONG,__VA_ARGS__)) \
>>                    ^~~~~~~~
>> ./include/linux/syscalls.h:222:2: note: in expansion of macro '__SYSCALL_DEFINEx'
>>    __SYSCALL_DEFINEx(x, sname, __VA_ARGS__)
>>    ^~~~~~~~~~~~~~~~~
>> ./include/linux/syscalls.h:211:36: note: in expansion of macro 'SYSCALL_DEFINEx'
>>   #define SYSCALL_DEFINE1(name, ...) SYSCALL_DEFINEx(1, _##name, __VA_ARGS__)
>>                                      ^~~~~~~~~~~~~~~
>> arch/powerpc/kernel/rtas.c:1054:1: note: in expansion of macro 'SYSCALL_DEFINE1'
>>   SYSCALL_DEFINE1(rtas, struct rtas_args __user *, uargs)
>>   ^~~~~~~~~~~~~~~
>>    CC      arch/powerpc/kernel/pci_64.o
>> In file included from arch/powerpc/kernel/pci_64.c:23:
>> ./include/linux/syscalls.h:233:18: error: 'sys_pciconfig_iobase' alias between functions of incompatible types 'long int(long int,  long unsigned int,  long unsigned int)' and 'long int(long int,  long int,  long int)' [-Werror=attribute-alias]
>>    asmlinkage long sys##name(__MAP(x,__SC_DECL,__VA_ARGS__)) \
>>                    ^~~
>> ./include/linux/syscalls.h:222:2: note: in expansion of macro '__SYSCALL_DEFINEx'
>>    __SYSCALL_DEFINEx(x, sname, __VA_ARGS__)
>>    ^~~~~~~~~~~~~~~~~
>> ./include/linux/syscalls.h:213:36: note: in expansion of macro 'SYSCALL_DEFINEx'
>>   #define SYSCALL_DEFINE3(name, ...) SYSCALL_DEFINEx(3, _##name, __VA_ARGS__)
>>                                      ^~~~~~~~~~~~~~~
>> arch/powerpc/kernel/pci_64.c:206:1: note: in expansion of macro 'SYSCALL_DEFINE3'
>>   SYSCALL_DEFINE3(pciconfig_iobase, long, which, unsigned long, in_bus,
>>   ^~~~~~~~~~~~~~~
>> ./include/linux/syscalls.h:238:18: note: aliased declaration here
>>    asmlinkage long __se_sys##name(__MAP(x,__SC_LONG,__VA_ARGS__)) \
>>                    ^~~~~~~~
>> ./include/linux/syscalls.h:222:2: note: in expansion of macro '__SYSCALL_DEFINEx'
>>    __SYSCALL_DEFINEx(x, sname, __VA_ARGS__)
>>    ^~~~~~~~~~~~~~~~~
>> ./include/linux/syscalls.h:213:36: note: in expansion of macro 'SYSCALL_DEFINEx'
>>   #define SYSCALL_DEFINE3(name, ...) SYSCALL_DEFINEx(3, _##name, __VA_ARGS__)
>>                                      ^~~~~~~~~~~~~~~
>> arch/powerpc/kernel/pci_64.c:206:1: note: in expansion of macro 'SYSCALL_DEFINE3'
>>   SYSCALL_DEFINE3(pciconfig_iobase, long, which, unsigned long, in_bus,
>>   ^~~~~~~~~~~~~~~
>>
>> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
> 
> Applied to powerpc next, thanks.
> 
> https://git.kernel.org/powerpc/c/2479bfc9bc600dcce7f932d52dcfa8

Oops, you didn't take v4 but v3 which was missing the fix into pci_32.c

I'll send you a patch to add the fix in pci_32.c

Christophe

> 
> cheers
> 
