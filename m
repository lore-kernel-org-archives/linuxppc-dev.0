Return-Path: <mathieu.malaterre@gmail.com>
Received: from mail-wr0-x244.google.com (mail-wr0-x244.google.com
 [IPv6:2a00:1450:400c:c0c::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zqBcB0swDzF1Mn
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Feb 2018 04:22:48 +1100 (AEDT)
Received: by mail-wr0-x244.google.com with SMTP id k9so18845849wre.9
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 25 Feb 2018 09:22:48 -0800 (PST)
Sender: Mathieu Malaterre <mathieu.malaterre@gmail.com>
From: Mathieu Malaterre <malat@debian.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Jiri Slaby <jslaby@suse.com>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 Mathieu Malaterre <malat@debian.org>
Subject: [PATCH 00/21] powerpc/gamecube: make W=1 compilation errors free
Date: Sun, 25 Feb 2018 18:22:15 +0100
Message-Id: <20180225172236.29650-1-malat@debian.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

I started working on warnings treated as error on ppc32. As a first step,
here is a set of patches to make gamecube error free when using W=1:

$ make ARCH=powerpc gamecube_defconfig
$ make -j8 ARCH=powerpc CROSS_COMPILE=powerpc-linux-gnu- W=1

Using:

$ powerpc-linux-gnu-gcc --version
powerpc-linux-gnu-gcc (Debian 6.3.0-18) 6.3.0 20170516


Mathieu Malaterre (21):
  powerpc: Remove warning on array size when empty
  powerpc: Move the inline keyword at the beginning of function
    declaration
  powerpc: Mark the variable earlycon_acpi_spcr_enable maybe_unused
  powerpc: Mark both tmp variables as unused
  powerpc: Avoid comparison of unsigned long >= 0 in pfn_valid
  powerpc: Avoid comparison of unsigned long >= 0 in __access_ok
  powerpc: Make functions flipper_pic_init & ug_udbg_putc static
  powerpc: Make function __giveup_fpu static
  powerpc: Make function save_all static
  powerpc: Add missing prototype for slb_miss_bad_addr
  powerpc: Add missing prototype for hdec_interrupt
  powerpc: Add missing prototype for time_init
  powerpc: Add missing prototype for arch_dup_task_struct
  powerpc: Add missing prototype for arch_irq_work_raise
  powerpc: Add missing prototype for MMU_setup
  powerpc: Add missing prototype for init_IRQ
  powerpc: Add missing prototype for sys_debug_setcontext
  powerpc: Add missing prototypes for sys_sigreturn & sys_rt_sigreturn
  powerpc: Add missing prototypes for hw_breakpoint_handler &
    arch_unregister_hw_breakpoint
  powerpc: Add missing prototypes for ppc_select & ppc_fadvise64_64
  powerpc: Add missing prototypes in setup_32.c

 arch/powerpc/include/asm/asm-prototypes.h          | 9 +++++++++
 arch/powerpc/include/asm/hw_breakpoint.h           | 2 ++
 arch/powerpc/include/asm/irq.h                     | 1 +
 arch/powerpc/include/asm/irq_work.h                | 1 +
 arch/powerpc/include/asm/page.h                    | 3 ++-
 arch/powerpc/include/asm/thread_info.h             | 1 +
 arch/powerpc/include/asm/time.h                    | 2 ++
 arch/powerpc/include/asm/uaccess.h                 | 2 +-
 arch/powerpc/kernel/process.c                      | 4 ++--
 arch/powerpc/kernel/prom.c                         | 3 +--
 arch/powerpc/kernel/setup.h                        | 5 +++++
 arch/powerpc/kernel/setup_32.c                     | 2 ++
 arch/powerpc/kernel/signal.h                       | 5 +++++
 arch/powerpc/kernel/signal_32.c                    | 4 ++--
 arch/powerpc/lib/sstep.c                           | 4 ++--
 arch/powerpc/mm/init_32.c                          | 1 +
 arch/powerpc/platforms/embedded6xx/flipper-pic.c   | 2 +-
 arch/powerpc/platforms/embedded6xx/usbgecko_udbg.c | 2 +-
 include/linux/serial_core.h                        | 1 +
 19 files changed, 42 insertions(+), 12 deletions(-)

-- 
2.11.0
