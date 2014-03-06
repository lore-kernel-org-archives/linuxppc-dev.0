Return-Path: <sukadev@linux.vnet.ibm.com>
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 738052C0098
 for <linuxppc-dev@ozlabs.org>; Thu,  6 Mar 2014 15:42:20 +1100 (EST)
Received: from /spool/local
 by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <sukadev@linux.vnet.ibm.com>;
 Wed, 5 Mar 2014 21:42:18 -0700
Received: from b03cxnp08025.gho.boulder.ibm.com
 (b03cxnp08025.gho.boulder.ibm.com [9.17.130.17])
 by d03dlp03.boulder.ibm.com (Postfix) with ESMTP id 926E919D8036
 for <linuxppc-dev@ozlabs.org>; Wed,  5 Mar 2014 21:42:12 -0700 (MST)
Received: from d03av05.boulder.ibm.com (d03av05.boulder.ibm.com [9.17.195.85])
 by b03cxnp08025.gho.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with
 ESMTP id s264gEfB8061400
 for <linuxppc-dev@ozlabs.org>; Thu, 6 Mar 2014 05:42:14 +0100
Received: from d03av05.boulder.ibm.com (localhost [127.0.0.1])
 by d03av05.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s264gDaM007967
 for <linuxppc-dev@ozlabs.org>; Wed, 5 Mar 2014 21:42:14 -0700
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
To: Arnaldo Carvalho de Melo <acme@ghostprotocols.net>
Subject: [PATCH 0/3] powerpc/perf: Enable linking with libunwind
Date: Wed,  5 Mar 2014 20:41:56 -0800
Message-Id: <1394080919-17957-1-git-send-email-sukadev@linux.vnet.ibm.com>
Cc: Michael Ellerman <michaele@au1.ibm.com>, linux-kernel@vger.kernel.org,
 Stephane Eranian <eranian@google.com>, linuxppc-dev@ozlabs.org,
 Paul Mackerras <paulus@samba.org>, Jiri Olsa <jolsa@redhat.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

When we try to create backtraces (call-graphs) with the perf tool

	perf record -g /tmp/sprintft

we get backtraces with duplicate arcs for sprintft[1]:

    14.61%  sprintft  libc-2.18.so       [.] __random                            
            |
            --- __random
               |
               |--61.09%-- __random
               |          |
               |          |--97.18%-- rand
               |          |          do_my_sprintf
               |          |          main
               |          |          generic_start_main.isra.0
               |          |          __libc_start_main
               |          |          0x0
               |          |
               |           --2.82%-- do_my_sprintf
               |                     main
               |                     generic_start_main.isra.0
               |                     __libc_start_main
               |                     0x0
               |
                --38.91%-- rand
                          |          
                          |--92.90%-- rand
                          |          |
                          |          |--99.87%-- do_my_sprintf
                          |          |          main
                          |          |          generic_start_main.isra.0
                          |          |          __libc_start_main
                          |          |          0x0
                          |           --0.13%-- [...]
                          |
                           --7.10%-- do_my_sprintf
                                     main
                                     generic_start_main.isra.0
                                     __libc_start_main
                                     0x0

(where the two arcs both have the same backtrace but are not merged).

Linking with libunwind seems to create better backtraces. While x86 and
ARM processors have support for linking with libunwind but Power does not.
This patchset is an RFC for linking with libunwind.

With this patchset and running:

	/tmp/perf record --call-graph=dwarf,8192 /tmp/sprintft

the backtrace is:

    14.94%  sprintft  libc-2.18.so       [.] __random                            
            |
            --- __random
                rand
                do_my_sprintf
                main
                generic_start_main.isra.0
                __libc_start_main
                (nil)

This appears better.

One downside is that we now need the kernel to save the entire user stack
(the 8192 in the command line is the default user stack size).

A second issue is that this invocation of perf (with --call-graph=dwarf,8192)
seems to fail for backtraces involving tail-calls[2]

	/tmp/perf record -g ./tailcall
gives 

    20.00%  tailcall  tailcall           [.] work2
            |
            --- work2
                work

shows the tail function 'work2' as "called from" 'work()'

But with libunwind:

	/tmp/perf record --call-graph=dwarf,8192 ./tailcall
we get:

   20.50%  tailcall  tailcall           [.] work2
            |
            --- work2

the caller of 'work' is not shown.

I am debugging this, but would appreciate any feedback/pointers on the
patchset/direction:

	- Does libunwind need the entire user stack to work or are there
	  optimizations we can do to save the minimal entries for it to
	  perform the unwind.

	- Does libunwind work with tailcalls like the one above ?

	- Are there benefits to linking with libunwind (even if it does not
	  yet solve the tailcall problem)

	- Are there any examples of using libdwarf to solve the tailcall
	  issue ?

[1] sprintft (excerpt from a test program by Maynard Johnson).

	char * do_my_sprintf(char * strx, int num)
	{
		int i;
		for (i = 0; i < inner_iterations; i++) {
			int r = rand() % 10;
			sprintf(my_string, "%s ...%d\n", strx+r, num);
			if (strlen(my_string) > 15)
				num = 15;
		}
		return my_string;
	}

[2] tailcall (Powerpc assembly, from Anton Blanchard)

    Build with: gcc -O2 --static -nostdlib -o tailcall tailcall.S

	#define ITERATIONS 1000000000

		.align 2
		.globl _start
		.globl ._start
		.section ".opd","aw"
	_start:
		.quad ._start
		.quad .TOC.@tocbase
		.quad 0;

		.text;
	._start:
		lis     4,ITERATIONS@h
		ori     4,4,ITERATIONS@l
		mtctr   4

	1:      bl      work
		bdnz    1b

		li 0,1  /* sys_exit */
		sc

	work:
		mflr    30
		bl      work2
		mtlr    30
		blr

	work2:
		blr


Sukadev Bhattiprolu (3):
  power: perf: Enable saving the user stack in a sample.
  power: perf tool: Add libunwind support for Power
  perf: Use 64-bit value when comparing sample_regs

 arch/powerpc/Kconfig                        |    2 +
 arch/powerpc/include/uapi/asm/perf_regs.h   |   70 ++++++++++++++++++
 arch/powerpc/perf/Makefile                  |    1 +
 arch/powerpc/perf/perf-regs.c               |  104 +++++++++++++++++++++++++++
 tools/perf/arch/powerpc/Makefile            |    5 ++
 tools/perf/arch/powerpc/include/perf_regs.h |   69 ++++++++++++++++++
 tools/perf/arch/powerpc/util/unwind.c       |   63 ++++++++++++++++
 tools/perf/config/Makefile                  |    7 ++
 tools/perf/util/unwind.c                    |    4 +-
 9 files changed, 323 insertions(+), 2 deletions(-)
 create mode 100644 arch/powerpc/include/uapi/asm/perf_regs.h
 create mode 100644 arch/powerpc/perf/perf-regs.c
 create mode 100644 tools/perf/arch/powerpc/include/perf_regs.h
 create mode 100644 tools/perf/arch/powerpc/util/unwind.c

-- 
1.7.9.5
