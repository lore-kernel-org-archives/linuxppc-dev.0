Return-Path: <dank@kegel.com>
Received: from relay03.pair.com (relay03.pair.com [209.68.5.17])
	by ozlabs.org (Postfix) with SMTP id 0EE0367A72
	for <linuxppc-dev@ozlabs.org>; Sat, 19 Mar 2005 12:58:28 +1100 (EST)
Message-ID: <423B788F.7040705@kegel.com>
Date: Fri, 18 Mar 2005 16:55:43 -0800
From: Dan Kegel <dank@kegel.com>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
Content-Type: text/plain; charset=us-ascii; format=flowed
Subject: gcc4 compile fixes
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Howdy all.  I'm trying to bring up gcc-4.0 toolchains
using the headers from linux-2.6.11.3, and as a sanity
check, I'm trying to build ppc750 and ppc970 kernels, too.

I'm finding things here and there that need patching to let
the build finish.  For instance:

In file included from include/asm/setup.h:8,
                  from include/asm/machdep.h:8,
                  from include/asm/irq.h:6,
                  from include/asm/hardirq.h:8,
                  from include/linux/hardirq.h:6,
                  from include/asm-generic/local.h:6,
                  from include/asm/local.h:4,
                  from include/linux/module.h:21,
                  from init/main.c:16:
include/asm-m68k/setup.h:365: error: array type has incomplete element type

(This pops up because asm-ppc/setup.h just includes asm-m68k/setup.h.)

That's a garden-variety 'used before defined' problem, fixed thus:

--- linux-2.6.11.3/include/asm-m68k/setup.h.old Fri Mar 18 13:48:03 2005
+++ linux-2.6.11.3/include/asm-m68k/setup.h     Fri Mar 18 13:48:14 2005
@@ -362,12 +362,13 @@
  #ifndef __ASSEMBLY__
  extern int m68k_num_memory;            /* # of memory blocks found (and used) */
  extern int m68k_realnum_memory;                /* real # of memory blocks found */
-extern struct mem_info m68k_memory[NUM_MEMINFO];/* memory description */

  struct mem_info {
         unsigned long addr;             /* physical address of memory chunk */
         unsigned long size;             /* length of memory chunk (in bytes) */
  };
+
+extern struct mem_info m68k_memory[NUM_MEMINFO];/* memory description */
  #endif

  #endif /* __KERNEL__ */
--- snip ---

Ditto for the next one:

In file included from include/asm/current.h:4,
                  from include/linux/wait.h:27,
                  from include/asm/semaphore.h:15,
                  from include/linux/sched.h:19,
                  from arch/ppc64/kernel/asm-offsets.c:18:
include/asm/paca.h:25: error: array type has incomplete element type
make[1]: *** [arch/ppc64/kernel/asm-offsets.s] Error 1

--- linux-2.6.11.3/include/asm-ppc64/paca.h.old Fri Mar 18 13:23:40 2005
+++ linux-2.6.11.3/include/asm-ppc64/paca.h     Fri Mar 18 13:24:04 2005
@@ -22,7 +22,6 @@
  #include       <asm/iSeries/ItLpRegSave.h>
  #include       <asm/mmu.h>

-extern struct paca_struct paca[];
  register struct paca_struct *local_paca asm("r13");
  #define get_paca()     local_paca

@@ -114,5 +113,7 @@
         struct ItLpRegSave reg_save;
  #endif
  };
+
+extern struct paca_struct paca[];

  #endif /* _PPC64_PACA_H */
--- snip ---

If somebody else has already fixed all of these, I'd rather
just use their sources.   So... shall I keep on patching
and posting, or are these already fixed somewhere?

Thanks,
Dan

-- 
Trying to get a job as a c++ developer?  See http://kegel.com/academy/getting-hired.html
