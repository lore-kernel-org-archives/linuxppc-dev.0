Return-Path: <sergey.senozhatsky@gmail.com>
Received: from mail-pg0-x243.google.com (mail-pg0-x243.google.com
 [IPv6:2607:f8b0:400e:c05::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yY0KG1WxtzDrKG
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Nov 2017 10:50:25 +1100 (AEDT)
Received: by mail-pg0-x243.google.com with SMTP id s2so5995115pge.10
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 09 Nov 2017 15:50:25 -0800 (PST)
From: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
To: Tony Luck <tony.luck@intel.com>, Fenghua Yu <fenghua.yu@intel.com>,
 Helge Deller <deller@gmx.de>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 James Bottomley <jejb@parisc-linux.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Jessica Yu <jeyu@kernel.org>,
 Petr Mladek <pmladek@suse.com>, Steven Rostedt <rostedt@goodmis.org>,
 linux-ia64@vger.kernel.org, linux-parisc@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
 Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Subject: [PATCHv4 0/6] printk/ia64/ppc64/parisc64: let's deprecate %pF/%pf
 printk specifiers
Date: Fri, 10 Nov 2017 08:48:24 +0900
Message-Id: <20171109234830.5067-1-sergey.senozhatsky@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

	Hello,

	A reworked version. There is a new dereference_symbol_descriptor()
function now, where "the magic happens", so I don't touch kallsyms_lookup()
and module_address_lookup() anymore.

	All Ack-s/Tested-by-s were dropped, since the patch set has been
reworked. I'm kindly asking arch-s maintainers and developers to test it
once again. Sorry for any inconveniences and thanks for your help in
advance.

===========================================================================

	On some arches C function pointers are indirect and point to
a function descriptor, which contains the actual pointer to the code.
This mostly doesn't matter, except for cases when people want to print
out function pointers in symbolic format, because the usual '%pS/%ps'
does not work on those arches as expected. That's the reason why we
have '%pF/%pf', but since it's here because of a subtle ABI detail
specific to some arches (ppc64/ia64/parisc64) it's easy to misuse
'%pF/%pf' and '%pS/%ps' (see [1], for example).

	This patch set attempts to move ia64/ppc64/parisc64 C function
pointer ABI details out of printk() to arch code. Function dereference
code now checks if a pointer belongs to a .opd ELF section and dereferences
that pointer only if it does. The kernel and modules have their own .opd
sections that's why I use two different ARCH functions: for kernel and
for module pointer dereference.

	I planned to remove dereference_function_descriptor() entirely,
but then I discovered a bunch other uses cases (kgdbts, init/main.c,
extable, etc.), so I decided to keep dereference_function_descriptor()
around because the main point of this patch set is to deprecate %pF/%pf.
But at the same time, I think I can go further and handle both kernel
and module descriptor dereference in dereference_function_descriptor().
We need a module pointer for module .opd check, so that will come at an
extra cost of module lookup (may be there will some other issues along
the way, haven't checked it).

Right now we've got:

- dereference_function_descriptor(addr)
        a generic (old) function. it simply attempts to dereference
        whatever pointer we give it.

- dereference_kernel_function_descriptor(addr)
        dereferences a kernel pointer if it's within the kernel's .opd
        section.

- dereference_module_function_descriptor(module, addr)
        dereference a module pointer if it's within the module's .opd
        section.

v4:
-- don't switch to ulong in derefence functions, keep using void pointer
-- introduce dereference_symbol_descriptor() function
-- avoid any dereference in kallsyms lookup/module address lookup
-- improved documentation
-- since this is a new version, I dropped all the the Ack-s and Tested-by-s

v3:
-- picked up ACKs and Tested-by
-- tweaked checkpatch warning (Joe)
-- updated Documentation

v2:
-- convert dereference_function_descriptor() to unsigned long
-- fix kernel descriptor range checks (Helge)
-- fix parisc module descriptor range check (Helge)
-- fix ppc64 module range check
-- add checkpatch patch

Sergey Senozhatsky (6):
  sections: split dereference_function_descriptor()
  ia64: Add .opd based function descriptor dereference
  powerpc64: Add .opd based function descriptor dereference
  parisc64: Add .opd based function descriptor dereference
  symbol lookup: introduce dereference_symbol_descriptor()
  checkpatch: add pF/pf deprecation warning

 Documentation/printk-formats.txt          | 49 ++++++++++++-------------------
 arch/ia64/include/asm/sections.h          | 10 ++++++-
 arch/ia64/kernel/module.c                 | 12 ++++++++
 arch/ia64/kernel/vmlinux.lds.S            |  2 ++
 arch/parisc/boot/compressed/vmlinux.lds.S |  2 ++
 arch/parisc/include/asm/sections.h        |  6 ++++
 arch/parisc/kernel/module.c               | 16 ++++++++++
 arch/parisc/kernel/process.c              |  9 ++++++
 arch/parisc/kernel/vmlinux.lds.S          |  2 ++
 arch/powerpc/include/asm/module.h         |  3 ++
 arch/powerpc/include/asm/sections.h       | 12 ++++++++
 arch/powerpc/kernel/module_64.c           | 14 +++++++++
 arch/powerpc/kernel/vmlinux.lds.S         |  2 ++
 include/asm-generic/sections.h            |  8 +++--
 include/linux/kallsyms.h                  |  2 ++
 include/linux/module.h                    |  3 ++
 kernel/kallsyms.c                         | 19 ++++++++++++
 kernel/module.c                           |  6 ++++
 lib/vsprintf.c                            |  5 ++--
 scripts/checkpatch.pl                     | 11 +++++--
 20 files changed, 155 insertions(+), 38 deletions(-)

-- 
2.15.0
