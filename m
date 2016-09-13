Return-Path: <npiggin@gmail.com>
Received: from mail-pa0-x244.google.com (mail-pa0-x244.google.com
 [IPv6:2607:f8b0:400e:c03::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sY8lh0ZfyzDrp5
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Sep 2016 13:09:04 +1000 (AEST)
Received: by mail-pa0-x244.google.com with SMTP id h5so8597885pao.0
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Sep 2016 20:09:03 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org, Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>
Cc: Nicholas Piggin <npiggin@gmail.com>
Subject: [PATCH 0/8] powerpc/64: use asm sections for head/exception layout
Date: Tue, 13 Sep 2016 13:08:38 +1000
Message-Id: <20160913030846.29790-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,

This patch uses asm/ld sections and macro wrappers to hide the details
of placing exception vectors at the correct location.

Currently we lay out everything in head_64.S as it is to appear in
the output, starting from physical 0, and uses '.' location counter
directives to place vectors correctly.

After this series, sections are created for real and virtual
exceptions, and trampoline/helper spaces, and "common" handlers
are put into .text section. Exception handlers are specified with
macros that define type, name, and locations.

  /* This is the entirity of the decrementer handlers */
  VECTOR_HANDLER_REAL_MASKABLE(decrementer, 0x900, 0x980)
  VECTOR_HANDLER_VIRT_MASKABLE(decrementer, 0x4900, 0x4980, 0x900)
  TRAMP_KVM(PACA_EXGEN, 0x900)
  COMMON_HANDLER_ASYNC(decrementer_common, 0x900, timer_interrupt)

  /* Although not all handlers come out quite so neatly */

Benefits:
* All handler code for a given exception can be grouped together
  in the file.
* Important head sections can be identified and handled by the
  linker. This can be used to prevent branch stubs from being
  placed inside fixed section code, for example.
* Most overflows can be caught at compile-time.
* Shuffling handlers around or making extra space for vectors
  becomes much simpler.

However there are some negatives:
* Another layer of macros in exception-64s.S
* asm/linker sections are not trivial to use, taking addresses
  can require a helper in some cases because the assembler can't
  calculate deltas between sections itself.

Intermediate steps of this patch are quite painful due to lots of
shuffling. I have tried to verify before/after equivalence of
compiled binary using objdump diffs, although it's not always
easy to verify completely (due to offsets and labels and padding
changing).

Vectors do not have to specify exact implementation details,
only requirements, which makes changes easier. For example,
an "inline" handler can be made OOL easily, because the macro
can emit the trampoline code into the correct section:

-VECTOR_HANDLER_REAL_MASKABLE(decrementer, 0x900, 0x980)
+VECTOR_HANDLER_REAL_OOL_MASKABLE(decrementer, 0x900, 0x980)

If 0x3000-0x4000 is required for new hardware exceptions, then
it's a simple change:

OPEN_FIXED_SECTION(real_vectors,        0x0100, 0x1900)
-OPEN_FIXED_SECTION(real_trampolines,    0x1900, 0x4000)
+OPEN_FIXED_SECTION(real_trampolines,    0x1900, 0x3000)
-OPEN_FIXED_SECTION(virt_vectors,        0x4000, 0x6000)
+OPEN_FIXED_SECTION(virt_vectors,        0x3000, 0x6000)
OPEN_FIXED_SECTION(virt_trampolines,    0x6000, 0x7000)

(This does also require sufficient space in real_trampolines)

I posted this series a while ago, but didn't have much feedback.
This one is significantly trimmed down with fewer
unrelated/unnecessary changes.

Comments?

Thanks,
Nick

Nicholas Piggin (8):
  powerpc/pseries: hypervisor facility unavailable use correct handler
  powerpc/pseries: syscall remove trampoline
  powerpc/pseries: exception vector macros
  powerpc/pseries: consolidate exception handler alignment
  powerpc/64: use gas sections for arranging exception vectors
  powerpc/pseries: move related exception code together
  powerpc/pseries: use single macro for both parts of OOL exception
  powerpc/pseries: remove unused exception code, small cleanups

 arch/powerpc/include/asm/exception-64s.h |  135 +-
 arch/powerpc/include/asm/head-64.h       |  348 +++++
 arch/powerpc/kernel/exceptions-64s.S     | 2135 ++++++++++++++----------------
 arch/powerpc/kernel/head_64.S            |   58 +-
 arch/powerpc/kernel/vmlinux.lds.S        |   45 +-
 5 files changed, 1510 insertions(+), 1211 deletions(-)
 create mode 100644 arch/powerpc/include/asm/head-64.h

-- 
2.9.3
