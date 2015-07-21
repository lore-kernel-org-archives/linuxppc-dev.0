Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 170DE1A009B
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Jul 2015 20:08:17 +1000 (AEST)
In-Reply-To: <1437461926-8908-8-git-send-email-khandual@linux.vnet.ibm.com>
To: Anshuman Khandual <khandual@linux.vnet.ibm.com>, linuxppc-dev@ozlabs.org
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: mikey@neuling.org
Subject: Re: [RFC,
 8/8] powerpc/xmon: Add some more elements to the existing PACA dump
 list
Message-Id: <20150721100816.EE0AD14076E@ozlabs.org>
Date: Tue, 21 Jul 2015 20:08:16 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2015-21-07 at 06:58:46 UTC, Anshuman Khandual wrote:
> From: "khandual@linux.vnet.ibm.com" <khandual@linux.vnet.ibm.com>
> 
> This patch adds some more elements to the existing PACA dump list
> inside a xmon session which can be listed here.
> 
> 	- hmi_event_available
> 	- dscr_default
> 	- vmalloc_sllp
> 	- slb_cache_ptr
> 	- sprg_vdso
> 	- tm_scratch
> 	- core_idle_state_ptr
> 	- thread_idle_state
> 	- thread_mask

This is probably OK, except you broke the ppc64e build again.

cheers


../arch/powerpc/xmon/xmon.c: In function ‘dump_one_paca’:
../arch/powerpc/xmon/xmon.c:2095:63: error: ‘struct paca_struct’ has no member named ‘vmalloc_sllp’
  printf(" %-*s = %#-*"format"\t(0x%lx)\n", 20, #name, 18, paca->name, \
                                                               ^
../arch/powerpc/xmon/xmon.c:2114:2: note: in expansion of macro ‘DUMP’
  DUMP(p, vmalloc_sllp, "x");
  ^
In file included from ../include/linux/compiler.h:56:0,
                 from ../include/uapi/linux/stddef.h:1,
                 from ../include/linux/stddef.h:4,
                 from ../include/uapi/linux/posix_types.h:4,
                 from ../include/uapi/linux/types.h:13,
                 from ../include/linux/types.h:5,
                 from ../include/uapi/linux/capability.h:16,
                 from ../include/linux/capability.h:15,
                 from ../include/linux/sched.h:15,
                 from ../arch/powerpc/xmon/xmon.c:14:
../include/linux/compiler-gcc.h:158:2: error: ‘struct paca_struct’ has no member named ‘vmalloc_sllp’
  __builtin_offsetof(a, b)
  ^
../include/linux/stddef.h:16:32: note: in expansion of macro ‘__compiler_offsetof’
 #define offsetof(TYPE, MEMBER) __compiler_offsetof(TYPE, MEMBER)
                                ^
../arch/powerpc/xmon/xmon.c:2096:3: note: in expansion of macro ‘offsetof’
   offsetof(struct paca_struct, name));
   ^
../arch/powerpc/xmon/xmon.c:2114:2: note: in expansion of macro ‘DUMP’
  DUMP(p, vmalloc_sllp, "x");
  ^
../arch/powerpc/xmon/xmon.c:2095:63: error: ‘struct paca_struct’ has no member named ‘slb_cache_ptr’
  printf(" %-*s = %#-*"format"\t(0x%lx)\n", 20, #name, 18, paca->name, \
                                                               ^
../arch/powerpc/xmon/xmon.c:2115:2: note: in expansion of macro ‘DUMP’
  DUMP(p, slb_cache_ptr, "x");
  ^
In file included from ../include/linux/compiler.h:56:0,
                 from ../include/uapi/linux/stddef.h:1,
                 from ../include/linux/stddef.h:4,
                 from ../include/uapi/linux/posix_types.h:4,
                 from ../include/uapi/linux/types.h:13,
                 from ../include/linux/types.h:5,
                 from ../include/uapi/linux/capability.h:16,
                 from ../include/linux/capability.h:15,
                 from ../include/linux/sched.h:15,
                 from ../arch/powerpc/xmon/xmon.c:14:
../include/linux/compiler-gcc.h:158:2: error: ‘struct paca_struct’ has no member named ‘slb_cache_ptr’
  __builtin_offsetof(a, b)
  ^
../include/linux/stddef.h:16:32: note: in expansion of macro ‘__compiler_offsetof’
 #define offsetof(TYPE, MEMBER) __compiler_offsetof(TYPE, MEMBER)
                                ^
../arch/powerpc/xmon/xmon.c:2096:3: note: in expansion of macro ‘offsetof’
   offsetof(struct paca_struct, name));
   ^
../arch/powerpc/xmon/xmon.c:2115:2: note: in expansion of macro ‘DUMP’
  DUMP(p, slb_cache_ptr, "x");
  ^
../arch/powerpc/xmon/xmon.c:2116:19: error: ‘struct paca_struct’ has no member named ‘slb_cache_ptr’
  for (i = 0; i < p->slb_cache_ptr; i++)
                   ^
../arch/powerpc/xmon/xmon.c:2117:50: error: ‘struct paca_struct’ has no member named ‘slb_cache’
   printf(" slb_cache[%d]:        = 0x%lx\n", i, p->slb_cache[i]);
                                                  ^
make[2]: *** [arch/powerpc/xmon/xmon.o] Error 1
make[1]: *** [arch/powerpc/xmon] Error 2
