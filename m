Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3r1VSD5vVyzDq5f
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  6 May 2016 21:49:32 +1000 (AEST)
Message-ID: <1462535365.13173.1.camel@ellerman.id.au>
Subject: Re: [PATCH V10 00/28] Add new powerpc specific ELF core notes
From: Michael Ellerman <mpe@ellerman.id.au>
To: Anshuman Khandual <khandual@linux.vnet.ibm.com>,
 linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org
Cc: mikey@neuling.org, benh@kernel.crashing.org, sukadev@linux.vnet.ibm.com,
 sam.bobroff@au1.ibm.com, emachado@linux.vnet.ibm.com
Date: Fri, 06 May 2016 21:49:25 +1000
In-Reply-To: <1455613198-5113-1-git-send-email-khandual@linux.vnet.ibm.com>
References: <1455613198-5113-1-git-send-email-khandual@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2016-02-16 at 14:29 +0530, Anshuman Khandual wrote:

> 	This patch series adds twelve new ELF core note sections which can
> be used with existing ptrace request PTRACE_GETREGSET-SETREGSET for accessing
> various transactional memory and other miscellaneous debug register sets on
> powerpc platform.
> 
> Test Result (All tests pass on both BE and LE)
> ----------------------------------------------
> ptrace-ebb		PASS
> ptrace-gpr		PASS
> ptrace-tm-gpr		PASS
> ptrace-tm-spd-gpr	PASS
> ptrace-tar		PASS
> ptrace-tm-tar		PASS
> ptrace-tm-spd-tar	PASS
> ptrace-vsx		PASS
> ptrace-tm-vsx		PASS
> ptrace-tm-spd-vsx	PASS
> ptrace-tm-spr		PASS

How are you building the tests? On BE I get:


  In file included from ptrace-tm-gpr.c:12:0:
  ptrace-tm-gpr.c: In function ‘trace_tm_gpr’:
  In file included from ptrace.h:31:0,
                   from ptrace-tm-vsx.c:11:
  ptrace-tm-vsx.c: In function ‘ptrace_tm_vsx’:
  ptrace-gpr.h:20:19: error: large integer implicitly truncated to unsigned type [-Werror=overflow]
   #define FPR_2_REP 0x3f60624de0000000
                     ^
  ptrace-tm-gpr.c:209:26: note: in expansion of macro ‘FPR_2_REP’
    ret = validate_fpr(fpr, FPR_2_REP);
                            ^
  ptrace-tm-vsx.c:150:46: error: ‘PPC_FEATURE2_HTM’ undeclared (first use in this function)
    SKIP_IF(!((long)get_auxv_entry(AT_HWCAP2) & PPC_FEATURE2_HTM));
                                                ^
  /home/kerkins/workspace/kernel-build-selftests/arch/powerpc/compiler/gcc_ubuntu_be/linux/tools/testing/selftests/powerpc/utils.h:49:7: note: in definition of macro ‘SKIP_IF’
    if ((x)) {      \
         ^
  ptrace-gpr.h:19:19: error: large integer implicitly truncated to unsigned type [-Werror=overflow]
   #define FPR_1_REP 0x3f50624de0000000
                     ^
  ptrace-tm-gpr.c:217:26: note: in expansion of macro ‘FPR_1_REP’
    ret = validate_fpr(fpr, FPR_1_REP);
                            ^
  ptrace-tm-vsx.c:150:46: note: each undeclared identifier is reported only once for each function it appears in
    SKIP_IF(!((long)get_auxv_entry(AT_HWCAP2) & PPC_FEATURE2_HTM));
                                                ^
  /home/kerkins/workspace/kernel-build-selftests/arch/powerpc/compiler/gcc_ubuntu_be/linux/tools/testing/selftests/powerpc/utils.h:49:7: note: in definition of macro ‘SKIP_IF’
    if ((x)) {      \
         ^
  ptrace-gpr.h:21:19: error: large integer implicitly truncated to unsigned type [-Werror=overflow]
   #define FPR_3_REP 0x3f689374c0000000
                     ^
  ptrace-tm-gpr.c:233:30: note: in expansion of macro ‘FPR_3_REP’
    ret = write_ckpt_fpr(child, FPR_3_REP);
                                ^
  In file included from ptrace.h:31:0,
                   from ptrace-tm-gpr.c:11:
  ptrace-tm-gpr.c: In function ‘ptrace_tm_gpr’:
  ptrace-tm-gpr.c:249:46: error: ‘PPC_FEATURE2_HTM’ undeclared (first use in this function)
    SKIP_IF(!((long)get_auxv_entry(AT_HWCAP2) & PPC_FEATURE2_HTM));
                                                ^
  /home/kerkins/workspace/kernel-build-selftests/arch/powerpc/compiler/gcc_ubuntu_be/linux/tools/testing/selftests/powerpc/utils.h:49:7: note: in definition of macro ‘SKIP_IF’
    if ((x)) {      \
         ^
  ptrace-tm-gpr.c:249:46: note: each undeclared identifier is reported only once for each function it appears in
    SKIP_IF(!((long)get_auxv_entry(AT_HWCAP2) & PPC_FEATURE2_HTM));
                                                ^
  /home/kerkins/workspace/kernel-build-selftests/arch/powerpc/compiler/gcc_ubuntu_be/linux/tools/testing/selftests/powerpc/utils.h:49:7: note: in definition of macro ‘SKIP_IF’
    if ((x)) {      \
         ^
  cc1: all warnings being treated as errors
  In file included from ../pmu/ebb/ebb.h:12:0,
                   from ptrace-ebb.c:11:
  ptrace-ebb.h: In function ‘reset_ebb_with_clear_mask’:
  ../pmu/ebb/../../reg.h:49:31: error: left shift count >= width of type [-Werror=shift-count-overflow]
   #define BESCR_PME      (0x1ul << 32) /* PMU Event-based exception Enable */
                                 ^
  ../pmu/ebb/../../reg.h:16:60: note: in definition of macro ‘mtspr’
                                       : "r" ((unsigned long)(v)) \
                                                              ^
  ptrace-ebb.h:73:28: note: in expansion of macro ‘BESCR_PME’
           mtspr(SPRN_BESCRS, BESCR_PME);
                              ^
  In file included from ptrace-tm-tar.c:12:0:
  ptrace-tm-tar.c: In function ‘tm_tar’:
  ptrace-tar.h:24:17: error: large integer implicitly truncated to unsigned type [-Werror=overflow]
   #define PPR_4   0x10000000000000        /* or 2,2,2 */
                   ^
  ptrace-tm-tar.c:78:45: note: in expansion of macro ‘PPR_4’
     ret = validate_tar_registers(regs, TAR_4, PPR_4, DSCR_4);
                                               ^
  In file included from ptrace-tm-spd-tar.c:12:0:
  ptrace-tm-spd-tar.c: In function ‘tm_spd_tar’:
  ptrace-tm-tar.c: In function ‘trace_tm_tar’:
  ptrace-tar.h:22:17: error: large integer implicitly truncated to unsigned type [-Werror=overflow]
   #define PPR_2   0x8000000000000         /* or 1,1,1 */
                   ^
  ptrace-tm-tar.c:103:44: note: in expansion of macro ‘PPR_2’
    ret = validate_tar_registers(regs, TAR_2, PPR_2, DSCR_2);
                                              ^
  In file included from ptrace-gpr.c:12:0:
  ptrace-gpr.c: In function ‘trace_gpr’:
  ptrace-tar.h:21:17: error: large integer implicitly truncated to unsigned type [-Werror=overflow]
   #define PPR_1   0x4000000000000         /* or 31,31,31*/
                   ^
  ptrace-tm-tar.c:113:44: note: in expansion of macro ‘PPR_1’
    ret = validate_tar_registers(regs, TAR_1, PPR_1, DSCR_1);
                                              ^
  ptrace-tar.h:24:17: error: large integer implicitly truncated to unsigned type [-Werror=overflow]
   #define PPR_4   0x10000000000000        /* or 2,2,2 */
                   ^
  ptrace-tm-spd-tar.c:89:45: note: in expansion of macro ‘PPR_4’
     ret = validate_tar_registers(regs, TAR_4, PPR_4, DSCR_4);
                                               ^
  ptrace-tar.h:24:17: error: large integer implicitly truncated to unsigned type [-Werror=overflow]
   #define PPR_4   0x10000000000000        /* or 2,2,2 */
                   ^
  ptrace-tm-tar.c:117:47: note: in expansion of macro ‘PPR_4’
    ret = write_ckpt_tar_registers(child, TAR_4, PPR_4, DSCR_4);
                                                 ^
  ptrace-tm-tar.c:121:9: error: format ‘%lx’ expects argument of type ‘long unsigned int’, but argument 4 has type ‘long long int’ [-Werror=format=]
    printf("%-30s TAR: %u PPR: %lx DSCR: %u\n", ptrace_write_ckpt, TAR_4, PPR_4, DSCR_4);
           ^
  ptrace-gpr.h:19:19: error: large integer implicitly truncated to unsigned type [-Werror=overflow]
   #define FPR_1_REP 0x3f50624de0000000
                     ^
  ptrace-gpr.c:129:26: note: in expansion of macro ‘FPR_1_REP’
    ret = validate_fpr(fpr, FPR_1_REP);
                            ^
  ptrace-tm-spd-tar.c: In function ‘trace_tm_spd_tar’:
  ptrace-tar.h:23:17: error: large integer implicitly truncated to unsigned type [-Werror=overflow]
   #define PPR_3   0xc000000000000         /* or 6,6,6 */
                   ^
  ptrace-tm-spd-tar.c:114:44: note: in expansion of macro ‘PPR_3’
    ret = validate_tar_registers(regs, TAR_3, PPR_3, DSCR_3);
                                              ^
  In file included from ptrace.h:31:0,
                   from ptrace-tm-tar.c:11:
  ptrace-tm-tar.c: In function ‘ptrace_tm_tar’:
  ptrace-gpr.h:21:19: error: large integer implicitly truncated to unsigned type [-Werror=overflow]
   #define FPR_3_REP 0x3f689374c0000000
                     ^
  ptrace-gpr.c:137:25: note: in expansion of macro ‘FPR_3_REP’
    ret = write_fpr(child, FPR_3_REP);
                           ^
  ptrace-tm-tar.c:134:46: error: ‘PPC_FEATURE2_HTM’ undeclared (first use in this function)
    SKIP_IF(!((long)get_auxv_entry(AT_HWCAP2) & PPC_FEATURE2_HTM));
                                                ^
  /home/kerkins/workspace/kernel-build-selftests/arch/powerpc/compiler/gcc_ubuntu_be/linux/tools/testing/selftests/powerpc/utils.h:49:7: note: in definition of macro ‘SKIP_IF’
    if ((x)) {      \
         ^
  ptrace-tm-tar.c:134:46: note: each undeclared identifier is reported only once for each function it appears in
    SKIP_IF(!((long)get_auxv_entry(AT_HWCAP2) & PPC_FEATURE2_HTM));
                                                ^
  /home/kerkins/workspace/kernel-build-selftests/arch/powerpc/compiler/gcc_ubuntu_be/linux/tools/testing/selftests/powerpc/utils.h:49:7: note: in definition of macro ‘SKIP_IF’
    if ((x)) {      \
         ^
  ptrace-tar.h:21:17: error: large integer implicitly truncated to unsigned type [-Werror=overflow]
   #define PPR_1   0x4000000000000         /* or 31,31,31*/
                   ^
  ptrace-tm-spd-tar.c:124:44: note: in expansion of macro ‘PPR_1’
    ret = validate_tar_registers(regs, TAR_1, PPR_1, DSCR_1);
                                              ^
  In file included from ptrace-tm-spd-gpr.c:12:0:
  ptrace-tm-spd-gpr.c: In function ‘trace_tm_spd_gpr’:
  ptrace-tar.h:24:17: error: large integer implicitly truncated to unsigned type [-Werror=overflow]
   #define PPR_4   0x10000000000000        /* or 2,2,2 */
                   ^
  ptrace-tm-spd-tar.c:128:47: note: in expansion of macro ‘PPR_4’
    ret = write_ckpt_tar_registers(child, TAR_4, PPR_4, DSCR_4);
                                                 ^
  ptrace-tm-spd-tar.c:132:9: error: format ‘%lx’ expects argument of type ‘long unsigned int’, but argument 4 has type ‘long long int’ [-Werror=format=]
    printf("%-30s TAR: %u PPR: %lx DSCR: %u\n", ptrace_write_ckpt, TAR_4, PPR_4, DSCR_4);
           ^
  ptrace-gpr.h:22:19: error: large integer implicitly truncated to unsigned type [-Werror=overflow]
   #define FPR_4_REP 0x3f70624de0000000
                     ^
  ptrace-tm-spd-gpr.c:235:26: note: in expansion of macro ‘FPR_4_REP’
    ret = validate_fpr(fpr, FPR_4_REP);
                            ^
  In file included from ptrace.h:31:0,
                   from ptrace-tm-spd-tar.c:11:
  ptrace-tm-spd-tar.c: In function ‘ptrace_tm_spd_tar’:
  ptrace-gpr.h:19:19: error: large integer implicitly truncated to unsigned type [-Werror=overflow]
   #define FPR_1_REP 0x3f50624de0000000
                     ^
  ptrace-tm-spd-gpr.c:243:26: note: in expansion of macro ‘FPR_1_REP’
    ret = validate_fpr(fpr, FPR_1_REP);
                            ^
  ptrace-tm-spd-tar.c:145:46: error: ‘PPC_FEATURE2_HTM’ undeclared (first use in this function)
    SKIP_IF(!((long)get_auxv_entry(AT_HWCAP2) & PPC_FEATURE2_HTM));
                                                ^
  /home/kerkins/workspace/kernel-build-selftests/arch/powerpc/compiler/gcc_ubuntu_be/linux/tools/testing/selftests/powerpc/utils.h:49:7: note: in definition of macro ‘SKIP_IF’
    if ((x)) {      \
         ^
  ptrace-tm-spd-tar.c:145:46: note: each undeclared identifier is reported only once for each function it appears in
    SKIP_IF(!((long)get_auxv_entry(AT_HWCAP2) & PPC_FEATURE2_HTM));
                                                ^
  /home/kerkins/workspace/kernel-build-selftests/arch/powerpc/compiler/gcc_ubuntu_be/linux/tools/testing/selftests/powerpc/utils.h:49:7: note: in definition of macro ‘SKIP_IF’
    if ((x)) {      \
         ^
  ptrace-gpr.h:21:19: error: large integer implicitly truncated to unsigned type [-Werror=overflow]
   #define FPR_3_REP 0x3f689374c0000000
                     ^
  ptrace-tm-spd-gpr.c:259:30: note: in expansion of macro ‘FPR_3_REP’
    ret = write_ckpt_fpr(child, FPR_3_REP);
                                ^
  In file included from ptrace.h:31:0,
                   from ptrace-tm-spd-vsx.c:11:
  ptrace-tm-spd-vsx.c: In function ‘ptrace_tm_spd_vsx’:
  In file included from ptrace.h:31:0,
                   from ptrace-tm-spd-gpr.c:11:
  ptrace-tm-spd-gpr.c: In function ‘ptrace_tm_spd_gpr’:
  ptrace-tm-spd-gpr.c:275:46: error: ‘PPC_FEATURE2_HTM’ undeclared (first use in this function)
    SKIP_IF(!((long)get_auxv_entry(AT_HWCAP2) & PPC_FEATURE2_HTM));
                                                ^
  /home/kerkins/workspace/kernel-build-selftests/arch/powerpc/compiler/gcc_ubuntu_be/linux/tools/testing/selftests/powerpc/utils.h:49:7: note: in definition of macro ‘SKIP_IF’
    if ((x)) {      \
         ^
  ptrace-tm-spd-gpr.c:275:46: note: each undeclared identifier is reported only once for each function it appears in
    SKIP_IF(!((long)get_auxv_entry(AT_HWCAP2) & PPC_FEATURE2_HTM));
                                                ^
  /home/kerkins/workspace/kernel-build-selftests/arch/powerpc/compiler/gcc_ubuntu_be/linux/tools/testing/selftests/powerpc/utils.h:49:7: note: in definition of macro ‘SKIP_IF’
    if ((x)) {      \
         ^
  ptrace-tm-spd-vsx.c:164:46: error: ‘PPC_FEATURE2_HTM’ undeclared (first use in this function)
    SKIP_IF(!((long)get_auxv_entry(AT_HWCAP2) & PPC_FEATURE2_HTM));
                                                ^
  /home/kerkins/workspace/kernel-build-selftests/arch/powerpc/compiler/gcc_ubuntu_be/linux/tools/testing/selftests/powerpc/utils.h:49:7: note: in definition of macro ‘SKIP_IF’
    if ((x)) {      \
         ^
  ptrace-tm-spd-vsx.c:164:46: note: each undeclared identifier is reported only once for each function it appears in
    SKIP_IF(!((long)get_auxv_entry(AT_HWCAP2) & PPC_FEATURE2_HTM));
                                                ^
  /home/kerkins/workspace/kernel-build-selftests/arch/powerpc/compiler/gcc_ubuntu_be/linux/tools/testing/selftests/powerpc/utils.h:49:7: note: in definition of macro ‘SKIP_IF’
    if ((x)) {      \
         ^
  cc1: all warnings being treated as errors
  cc1: all warnings being treated as errors
  cc1: all warnings being treated as errors
  In file included from ptrace.h:31:0,
                   from ptrace-tm-spr.c:11:
  ptrace-tm-spr.c: In function ‘ptrace_tm_spr’:
  ptrace-tm-spr.c:118:46: error: ‘PPC_FEATURE2_HTM’ undeclared (first use in this function)
    SKIP_IF(!((long)get_auxv_entry(AT_HWCAP2) & PPC_FEATURE2_HTM));
                                                ^
  /home/kerkins/workspace/kernel-build-selftests/arch/powerpc/compiler/gcc_ubuntu_be/linux/tools/testing/selftests/powerpc/utils.h:49:7: note: in definition of macro ‘SKIP_IF’
    if ((x)) {      \
         ^
  ptrace-tm-spr.c:118:46: note: each undeclared identifier is reported only once for each function it appears in
    SKIP_IF(!((long)get_auxv_entry(AT_HWCAP2) & PPC_FEATURE2_HTM));
                                                ^
  /home/kerkins/workspace/kernel-build-selftests/arch/powerpc/compiler/gcc_ubuntu_be/linux/tools/testing/selftests/powerpc/utils.h:49:7: note: in definition of macro ‘SKIP_IF’
    if ((x)) {      \
         ^
  ptrace-tar.c: In function ‘tar’:
  ptrace-tar.c:25:9: error: format ‘%lx’ expects argument of type ‘long unsigned int’, but argument 4 has type ‘long long int’ [-Werror=format=]
    printf("%-30s TAR: %u PPR: %lx DSCR: %u\n", user_write, TAR_1, PPR_1, DSCR_1);
           ^
  In file included from ptrace-tar.c:12:0:
  ptrace-tar.h:22:17: error: large integer implicitly truncated to unsigned type [-Werror=overflow]
   #define PPR_2   0x8000000000000         /* or 1,1,1 */
                   ^
  ptrace-tar.c:44:43: note: in expansion of macro ‘PPR_2’
    ret = validate_tar_registers(reg, TAR_2, PPR_2, DSCR_2);
                                             ^
  ptrace-tar.c: In function ‘trace_tar’:
  ptrace-tar.h:21:17: error: large integer implicitly truncated to unsigned type [-Werror=overflow]
   #define PPR_1   0x4000000000000         /* or 31,31,31*/
                   ^
  ptrace-tar.c:66:43: note: in expansion of macro ‘PPR_1’
    ret = validate_tar_registers(reg, TAR_1, PPR_1, DSCR_1);
                                             ^
  ptrace-tar.c: In function ‘trace_tar_write’:
  ptrace-tar.h:22:17: error: large integer implicitly truncated to unsigned type [-Werror=overflow]
   #define PPR_2   0x8000000000000         /* or 1,1,1 */
                   ^
  ptrace-tar.c:85:42: note: in expansion of macro ‘PPR_2’
    ret = write_tar_registers(child, TAR_2, PPR_2, DSCR_2);
                                            ^
  ptrace-tar.c:89:9: error: format ‘%lx’ expects argument of type ‘long unsigned int’, but argument 4 has type ‘long long int’ [-Werror=format=]
    printf("%-30s TAR: %u PPR: %lx DSCR: %u\n", ptrace_write_running, TAR_2, PPR_2, DSCR_2);
           ^
  cc1: all warnings being treated as errors
  cc1: all warnings being treated as errors
  cc1: all warnings being treated as errors
  <builtin>: recipe for target 'ptrace-tm-spd-tar' failed
  make[1]: *** [ptrace-tm-spd-tar] Error 1
  <builtin>: recipe for target 'ptrace-tm-tar' failed
  make[1]: *** [ptrace-tm-tar] Error 1
  <builtin>: recipe for target 'ptrace-tm-vsx' failed
  make[1]: *** [ptrace-tm-vsx] Error 1
  <builtin>: recipe for target 'ptrace-tm-spd-gpr' failed
  make[1]: *** [ptrace-tm-spd-gpr] Error 1
  <builtin>: recipe for target 'ptrace-tm-spr' failed
  make[1]: *** [ptrace-tm-spr] Error 1
  <builtin>: recipe for target 'ptrace-tm-gpr' failed
  make[1]: *** [ptrace-tm-gpr] Error 1
  <builtin>: recipe for target 'ptrace-tm-spd-vsx' failed
  make[1]: *** [ptrace-tm-spd-vsx] Error 1
  <builtin>: recipe for target 'ptrace-tar' failed
  make[1]: *** [ptrace-tar] Error 1
  <builtin>: recipe for target 'ptrace-gpr' failed
  make[1]: *** [ptrace-gpr] Error 1
  ../pmu/ebb/ebb_handler.S: Assembler messages:
  ../pmu/ebb/ebb_handler.S:242: Error: syntax error; found `@', expected `,'
  ../pmu/ebb/ebb_handler.S:242: Error: junk at end of line: `@highest'
  ../pmu/ebb/ebb_handler.S:242: Error: syntax error; found `@', expected `,'
  ../pmu/ebb/ebb_handler.S:242: Error: junk at end of line: `@higher'
  <builtin>: recipe for target 'ptrace-ebb' failed
