Return-Path: <linux@rasmusvillemoes.dk>
Received: from mail-lf0-x232.google.com (mail-lf0-x232.google.com
 [IPv6:2a00:1450:4010:c07::232])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 0C5761A01E3
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Nov 2015 06:52:05 +1100 (AEDT)
Received: by lfaz4 with SMTP id z4so117507837lfa.0
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Nov 2015 11:51:59 -0800 (PST)
From: Rasmus Villemoes <linux@rasmusvillemoes.dk>
To: Rusty Russell <rusty@rustcorp.com.au>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Oleg Nesterov <oleg@redhat.com>, Thomas Gleixner <tglx@linutronix.de>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>,
 Rasmus Villemoes <linux@rasmusvillemoes.dk>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH v2, resend 0/6] kernel/cpu.c: eliminate some indirection
Date: Mon, 23 Nov 2015 20:51:34 +0100
Message-Id: <1448308300-22582-1-git-send-email-linux@rasmusvillemoes.dk>
In-Reply-To: <1444144919-25143-1-git-send-email-linux@rasmusvillemoes.dk>
References: <1444144919-25143-1-git-send-email-linux@rasmusvillemoes.dk>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Andrew, can I get you to take these through -mm? Noone else seems to
want to pick them up. They're rebased on top of 4.4-rc2 (and applied
cleanly), but otherwise identical to what I've sent previously.

=====

v2: fix build failure on ppc, add acks.

The four cpumasks cpu_{possible,online,present,active}_bits are
exposed readonly via the corresponding const variables
cpu_xyz_mask. But they are also accessible for arbitrary writing via
the exposed functions set_cpu_xyz. There's quite a bit of code
throughout the kernel which iterates over or otherwise accesses these
bitmaps, and having the access go via the cpu_xyz_mask variables is
nowadays [1] simply a useless indirection.

It may be that any problem in CS can be solved by an extra level of
indirection, but that doesn't mean every extra indirection solves a
problem. In this case, it even necessitates some minor ugliness (see
4/6).

Patch 1/6 is new in v2, and fixes a build failure on ppc by renaming a
struct member, to avoid problems when the identifier cpu_online_mask
becomes a macro later in the series. The next four patches eliminate
the cpu_xyz_mask variables by simply exposing the actual bitmaps,
after renaming them to discourage direct access - that still happens
through cpu_xyz_mask, which are now simply macros with the same type
and value as they used to have.

After that, there's no longer any reason to have the setter functions
be out-of-line: The boolean parameter is almost always a literal true
or false, so by making them static inlines they will usually compile
to one or two instructions.

For a defconfig build on x86_64, bloat-o-meter says we save ~3000
bytes. We also save a little stack (stackdelta says 127 functions have
a 16 byte smaller stack frame, while two grow by that amount). Mostly
because, when iterating over the mask, gcc typically loads the value
of cpu_xyz_mask into a callee-saved register and from there into %rdi
before each find_next_bit call - now it can just load the appropriate
immediate address into %rdi before each call.

[1] See Rusty's kind explanation
http://thread.gmane.org/gmane.linux.kernel/2047078/focus=2047722 for
some historic context.

Rasmus Villemoes (6):
  powerpc/fadump: rename cpu_online_mask member of struct
    fadump_crash_info_header
  kernel/cpu.c: change type of cpu_possible_bits and friends
  kernel/cpu.c: export __cpu_*_mask
  drivers/base/cpu.c: use __cpu_*_mask directly
  kernel/cpu.c: eliminate cpu_*_mask
  kernel/cpu.c: make set_cpu_* static inlines

 arch/powerpc/include/asm/fadump.h |  2 +-
 arch/powerpc/kernel/fadump.c      |  4 +--
 drivers/base/cpu.c                | 10 +++---
 include/linux/cpumask.h           | 55 ++++++++++++++++++++++++++++-----
 kernel/cpu.c                      | 64 ++++++++-------------------------------
 5 files changed, 68 insertions(+), 67 deletions(-)

-- 
2.6.1
