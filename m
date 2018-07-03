Return-Path: <wak@google.com>
Received: from mail-lf0-x230.google.com (mail-lf0-x230.google.com
 [IPv6:2a00:1450:4010:c07::230])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41KszM6j20zF1QL
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  4 Jul 2018 04:27:10 +1000 (AEST)
Received: by mail-lf0-x230.google.com with SMTP id n24-v6so2381010lfh.3
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 03 Jul 2018 11:27:10 -0700 (PDT)
MIME-Version: 1.0
From: William Kennington <wak@google.com>
Date: Tue, 3 Jul 2018 11:26:55 -0700
Message-ID: <CAPnigKnVTg5UiEfou=ABL2DH31rFyGZ_1qtqevJqPPw-V-E6-A@mail.gmail.com>
Subject: GCC strcmp optimizations causing valgrind uninitialized conditional
 jumps
To: linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,

I've noticed while trying to do some valgrind testing on code linked
against system libraries that have inlined strcmps that valgrind is
unhappy about branches depending on uninitialized memory. I've read
through the generated inline assembly, and it looks like the assembly
will always produce the correct result regardless of the intermediate
compare using uninitialized data. I'm trying to figure out what to do
as next steps since it's non-trivial to suppress this inlined code.

Using the following simple test case which generates the optmizations
using gcc 7.3.0 and gcc 9 devel. This is reproducible using `gcc -O2
-o test test.c` with the following code.

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int main()
{
        char *heap_str = malloc(16);
        strcpy(heap_str, "RandString");
        int res = strcmp("RandString", heap_str) == 0;
        free(heap_str);
        return res;
}

A snippet of the inline assembly causing issues is, valgrind correctly
identifies a branch taken based on uninitialized memory for the first
`bne` in `.L7` since it's reading bytes 8-16 from the 11 byte string:
 # test.c:9:    int res = strcmp("RandString", heap_str) == 0;
        .loc 1 9 12 view .LVU20
        li 8,0           # tmp172,
        cmpb 3,9,10      # tmp169, tmp133, tmp134
        cmpb 8,9,8       # tmp170, tmp133, tmp172
        orc 3,8,3        #, tmp169, tmp170, tmp169
        cntlzd 3,3       # tmp171, tmp169
        addi 3,3,8       # tmp171, tmp171,
        rldcl 9,9,3,56   # tmp171, tmp174, tmp133,
        rldcl 3,10,3,56  # tmp171, tmp176, tmp134,
        subf 3,3,9       # tmp132, tmp176, tmp174
        b .L2            #
.L7:
        addi 9,5,8       # tmp190, tmp126,
        addi 10,30,8     # tmp191, heap_str,
        ldbrx 9,0,9      # tmp133, MEM[(void *)"RandString"]
        ldbrx 10,0,10    # tmp134, MEM[(void *)heap_str_5]
        subf. 3,10,9     # tmp132, tmp134, tmp133
        bne 0,.L4        #
        cmpb 10,9,3      # tmp140, tmp133, tmp132
        cmpdi 7,10,0     #, tmp141, tmp140
        bne 7,.L2

Sample valgrind output looks like:
==63162== Memcheck, a memory error detector
==63162== Copyright (C) 2002-2017, and GNU GPL'd, by Julian Seward et al.
==63162== Using Valgrind-3.13.0 and LibVEX; rerun with -h for copyright info
==63162== Command: ./test
==63162==
==63162== Conditional jump or move depends on uninitialised value(s)
==63162==    at 0x100005D4: main (test.c:9)
==63162==  Uninitialised value was created by a heap allocation
==63162==    at 0x4093F00: malloc (in
/usr/lib/valgrind/vgpreload_memcheck-ppc64le-linux.so)
==63162==    by 0x10000513: main (test.c:7)
==63162==
==63162== Conditional jump or move depends on uninitialised value(s)
==63162==    at 0x100005E0: main (test.c:9)
==63162==  Uninitialised value was created by a heap allocation
==63162==    at 0x4093F00: malloc (in
/usr/lib/valgrind/vgpreload_memcheck-ppc64le-linux.so)
==63162==    by 0x10000513: main (test.c:7)
==63162==
==63162== Syscall param exit_group(status) contains uninitialised byte(s)
==63162==    at 0x41E8C2C: _Exit (_exit.c:31)
==63162==    by 0x4132C67: __run_exit_handlers (exit.c:132)
==63162==    by 0x4104423: generic_start_main.isra.0 (libc-start.c:344)
==63162==    by 0x4104617: (below main) (libc-start.c:116)
==63162==  Uninitialised value was created by a heap allocation
==63162==    at 0x4093F00: malloc (in
/usr/lib/valgrind/vgpreload_memcheck-ppc64le-linux.so)
==63162==    by 0x10000513: main (test.c:7)
==63162==
==63162==
==63162== HEAP SUMMARY:
==63162==     in use at exit: 0 bytes in 0 blocks
==63162==   total heap usage: 1 allocs, 1 frees, 16 bytes allocated
==63162==
==63162== All heap blocks were freed -- no leaks are possible
==63162==
==63162== For counts of detected and suppressed errors, rerun with: -v
==63162== ERROR SUMMARY: 3 errors from 3 contexts (suppressed: 0 from 0)

Any ideas on how to workaround / fix this?

Best,
William
