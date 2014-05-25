Return-Path: <lists@nerdbynature.de>
Received: from trent.utfs.org (trent.utfs.org [94.185.90.103])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 884401A05A6
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 25 May 2014 10:42:34 +1000 (EST)
Date: Sat, 24 May 2014 17:35:31 -0700 (PDT)
From: Christian Kujau <lists@nerdbynature.de>
To: linuxppc-dev@lists.ozlabs.org, geert@linux-m68k.org
Subject: Section mismatch in reference from the variable via_pmu_driver
Message-ID: <alpine.DEB.2.19.4.1405241720190.7552@trent.utfs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,

while compiling 3.15-rc6 for powerpc (gcc-4.8.1 crosscompiler on x86_64), 
a warning popped up:

   WARNING: modpost: Found 1 section mismatch(es).

Compiling with CONFIG_DEBUG_SECTION_MISMATCH=y gives:

-----------------------------------
  LD      drivers/macintosh/built-in.o
  CC [M]  fs/hfsplus/inode.o
WARNING: drivers/macintosh/built-in.o(.data+0x184): Section mismatch in 
reference from the variable via_pmu_driver to the function 
.init.text:pmu_init()
The variable via_pmu_driver references
the function __init pmu_init()
If the reference is valid then annotate the
variable with __init* or __refdata (see linux/init.h) or name the 
variable:
*_template, *_timer, *_sht, *_ops, *_probe, *_probe_one, *_console
-----------------------------------

...and, later on:

-----------------------------------
  LD      drivers/built-in.o
WARNING: drivers/built-in.o(.data+0x488c): Section mismatch in reference 
from the variable via_pmu_driver to the function .init.text:pmu_init()
The variable via_pmu_driver references
the function __init pmu_init()
If the reference is valid then annotate the
variable with __init* or __refdata (see linux/init.h) or name the 
variable:
*_template, *_timer, *_sht, *_ops, *_probe, *_probe_one, *_console

  LINK    vmlinux
  LD      vmlinux.o
  MODPOST vmlinux.o
WARNING: vmlinux.o(.data+0x1ff44): Section mismatch in reference from the 
variable via_pmu_driver to the function .init.text:pmu_init()
The variable via_pmu_driver references
the function __init pmu_init()
If the reference is valid then annotate the
variable with __init* or __refdata (see linux/init.h) or name the 
variable:
*_template, *_timer, *_sht, *_ops, *_probe, *_probe_one, *_console
-----------------------------------

This had been reported [0] by Geert for v3.3-rc1 back in 2012, and maybe 
the warning was always there, but I didn't notice it until now.

Oh, and after everything has been built, this happens:

-----------------------------------
INFO: Uncompressed kernel (size 0x6714a0) overlaps the address of the wrapper(0x400000)
INFO: Fixing the link_address of wrapper to (0x700000)
-----------------------------------

...but I think this was always printed after compiling a kernel for 
PowerPC, I just just I should mention it (again [1]).

Thanks,
Christian.

[0] https://lkml.org/lkml/2012/1/22/17
[1] https://lkml.org/lkml/2012/4/4/140
-- 
BOFH excuse #30:

positron router malfunction
