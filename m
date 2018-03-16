Return-Path: <npiggin@gmail.com>
Received: from mail-pf0-x242.google.com (mail-pf0-x242.google.com
 [IPv6:2607:f8b0:400e:c00::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 402gxD3CW3zF09v
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Mar 2018 21:02:23 +1100 (AEDT)
Received: by mail-pf0-x242.google.com with SMTP id y186so3968347pfb.2
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Mar 2018 03:02:23 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>
Subject: [RFC PATCH 0/4] more sreset debugging improvements
Date: Fri, 16 Mar 2018 20:02:08 +1000
Message-Id: <20180316100212.5110-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This code seems to never end. This series attempts to make sreset
debugging more robust, particularly I'm looking at taking exceptions
from CPUs within OPAL. This is starting to work to a degree now (with
some skiboot patches I'll post in a minute). At least we can examine
registers of the CPU from xmon, can print to console, and sanely
crash rather than recover with a trashed OPAL stack.

After this and the skiboot series, we can take a 0x100 and get to
xmon like this:

(initramfs) WARNING: cpu 0x0 stopped in OPAL, cannot recover
cpu 0x0: Vector: 100 (System Reset) at [c0000000fffcfd80]
    pc: 000000003001b708
    lr: 000000003000515c
    sp: 31c03d20
   msr: 9000000002803000
  current = 0xc0000000fd862600
  paca    = 0xc00000000fff0000   softe: 3        irq_happened: 0x01
    pid   = 16, comm = kopald
Linux version 4.16.0-rc2-00004-g86f2ceed5cac (npiggin@roar) (gcc version 7.3.0 (Debian 7.3.0-1)) #1638 SMP Fri Mar 16 19:53:12 AEST 2018
WARNING: exception is not recoverable, can't continue
enter ? for help
SP (31c03d20) is in userspace
0:mon> x
[   45.426677142,5] CPU ATTEMPT TO RE-ENTER FIRMWARE! PIR=0000 cpu @0x31c00000 -> pir=0000 token=8
Kernel panic - not syncing: Unrecoverable System Reset
CPU: 0 PID: 16 Comm: kopald Not tainted 4.16.0-rc2-00004-g86f2ceed5cac #1638
Call Trace:
nvram_write_os_partition: Failed nvram_write (-5)

Without the series we end up in a big mess.

Of course it's best not to sreset a CPU that's in OPAL in the
first place. I have another few patches for Linux to take a target
out of OPAL with quiesce API before sending a sreset. But someitmes
a CPU will get stuck in OPAL or we could hit it with pdbg etc.

Thanks,
Nick

Nicholas Piggin (4):
  powerpc/64s: return more carefully from sreset NMI
  powerpc/64s: sreset panic if there is no debugger or crash dump
    handlers
  powerpc/powernv/nvram: opal_nvram_write handle unknown OPAL errors
  powerpc/xmon: Detect if OPAL was interrupted and mark unrecoverable

 arch/powerpc/include/asm/opal.h             |  2 +
 arch/powerpc/kernel/exceptions-64s.S        | 61 +++++++++++++++++++++++++++--
 arch/powerpc/kernel/traps.c                 | 15 ++++++-
 arch/powerpc/platforms/powernv/opal-nvram.c |  2 +
 arch/powerpc/platforms/powernv/opal.c       |  5 +++
 arch/powerpc/xmon/xmon.c                    | 14 +++++++
 6 files changed, 94 insertions(+), 5 deletions(-)

-- 
2.16.1
