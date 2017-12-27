Return-Path: <ard.biesheuvel@linaro.org>
Received: from mail-wr0-x243.google.com (mail-wr0-x243.google.com
 [IPv6:2a00:1450:400c:c0c::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3z665B0mPnzDqZg
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Dec 2017 19:50:52 +1100 (AEDT)
Received: by mail-wr0-x243.google.com with SMTP id o2so36218602wro.5
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Dec 2017 00:50:52 -0800 (PST)
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
To: linux-kernel@vger.kernel.org
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>,
 "H. Peter Anvin" <hpa@zytor.com>, Ralf Baechle <ralf@linux-mips.org>,
 Arnd Bergmann <arnd@arndb.de>, Heiko Carstens <heiko.carstens@de.ibm.com>,
 Kees Cook <keescook@chromium.org>, Will Deacon <will.deacon@arm.com>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Thomas Garnier <thgarnie@google.com>, Thomas Gleixner <tglx@linutronix.de>,
 "Serge E. Hallyn" <serge@hallyn.com>, Bjorn Helgaas <bhelgaas@google.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Russell King <linux@armlinux.org.uk>, Paul Mackerras <paulus@samba.org>,
 Catalin Marinas <catalin.marinas@arm.com>,
 "David S. Miller" <davem@davemloft.net>, Petr Mladek <pmladek@suse.com>,
 Ingo Molnar <mingo@redhat.com>, James Morris <james.l.morris@oracle.com>,
 Andrew Morton <akpm@linux-foundation.org>, Nicolas Pitre <nico@linaro.org>,
 Josh Poimboeuf <jpoimboe@redhat.com>, Steven Rostedt <rostedt@goodmis.org>,
 Martin Schwidefsky <schwidefsky@de.ibm.com>,
 Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Jessica Yu <jeyu@kernel.org>, linux-arm-kernel@lists.infradead.org,
 linux-mips@linux-mips.org, linuxppc-dev@lists.ozlabs.org,
 linux-s390@vger.kernel.org, sparclinux@vger.kernel.org, x86@kernel.org
Subject: [PATCH v6 0/8] add support for relative references in special sections
Date: Wed, 27 Dec 2017 08:50:25 +0000
Message-Id: <20171227085033.22389-1-ard.biesheuvel@linaro.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This adds support for emitting special sections such as initcall arrays,
PCI fixups and tracepoints as relative references rather than absolute
references. This reduces the size by 50% on 64-bit architectures, but
more importantly, it removes the need for carrying relocation metadata
for these sections in relocatables kernels (e.g., for KASLR) that need
to fix up these absolute references at boot time. On arm64, this reduces
the vmlinux footprint of such a reference by 8x (8 byte absolute reference
+ 24 byte RELA entry vs 4 byte relative reference)

Patch #2 was sent out before as a single patch. This series supersedes
the previous submission. This version makes relative ksymtab entries
dependent on the new Kconfig symbol HAVE_ARCH_PREL32_RELOCATIONS rather
than trying to infer from kbuild test robot replies for which architectures
it should be blacklisted.

Patch #1 introduces the new Kconfig symbol HAVE_ARCH_PREL32_RELOCATIONS,
and sets it for the main architectures that are expected to benefit the
most from this feature, i.e., 64-bit architectures or ones that use
runtime relocations.

Patches #3 - #5 implement relative references for initcalls, PCI fixups
and tracepoints, respectively, all of which produce sections with order
~1000 entries on an arm64 defconfig kernel with tracing enabled. This
means we save about 28 KB of vmlinux space for each of these patches.

Patches #6 - #8 have been added in v5, and implement relative references
in jump tables for arm64 and x86. On arm64, this results in significant
space savings (650+ KB on a typical distro kernel). On x86, the savings
are not as impressive, but still worthwhile. (Note that these patches
do not rely on CONFIG_HAVE_ARCH_PREL32_RELOCATIONS, given that the
inline asm that is emitted is already per-arch)

For the arm64 kernel, all patches combined reduce the memory footprint of
vmlinux by about 1.3 MB (using a config copied from Ubuntu that has KASLR
enabled), of which ~1 MB is the size reduction of the RELA section in .init,
and the remaining 300 KB is reduction of .text/.data.

Branch:
git://git.kernel.org/pub/scm/linux/kernel/git/ardb/linux.git relative-special-sections-v6

Changes since v5:
- add missing jump_label prototypes to s390 jump_label.h (#6)
- fix inverted condition in call to jump_entry_is_module_init() (#6)

Changes since v4:
- add patches to convert x86 and arm64 to use relative references for jump
  tables (#6 - #8)
- rename PCI patch and add Bjorn's ack (#4)
- rebase onto v4.15-rc5

Changes since v3:
- fix module unload issue in patch #5 reported by Jessica, by reusing the
  updated routine for_each_tracepoint_range() for the quiescent check at
  module unload time; this requires this routine to be moved before
  tracepoint_module_going() in kernel/tracepoint.c
- add Jessica's ack to #2
- rebase onto v4.14-rc1

Changes since v2:
- Revert my slightly misguided attempt to appease checkpatch, which resulted
  in needless churn and worse code. This v3 is based on v1 with a few tweaks
  that were actually reasonable checkpatch warnings: unnecessary braces (as
  pointed out by Ingo) and other minor whitespace misdemeanors.

Changes since v1:
- Remove checkpatch errors to the extent feasible: in some cases, this
  involves moving extern declarations into C files, and switching to
  struct definitions rather than typedefs. Some errors are impossible
  to fix: please find the remaining ones after the diffstat.
- Used 'int' instead if 'signed int' for the various offset fields: there
  is no ambiguity between architectures regarding its signedness (unlike
  'char')
- Refactor the different patches to be more uniform in the way they define
  the section entry type and accessors in the .h file, and avoid the need to
  add #ifdefs to the C code.

Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Thomas Garnier <thgarnie@google.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: "Serge E. Hallyn" <serge@hallyn.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Russell King <linux@armlinux.org.uk>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Petr Mladek <pmladek@suse.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: James Morris <james.l.morris@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Nicolas Pitre <nico@linaro.org>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Jessica Yu <jeyu@kernel.org>

Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-mips@linux-mips.org
Cc: linuxppc-dev@lists.ozlabs.org
Cc: linux-s390@vger.kernel.org
Cc: sparclinux@vger.kernel.org
Cc: x86@kernel.org

Ard Biesheuvel (8):
  arch: enable relative relocations for arm64, power, x86, s390 and x86
  module: use relative references for __ksymtab entries
  init: allow initcall tables to be emitted using relative references
  PCI: Add support for relative addressing in quirk tables
  kernel: tracepoints: add support for relative references
  kernel/jump_label: abstract jump_entry member accessors
  arm64/kernel: jump_label: use relative references
  x86/kernel: jump_table: use relative references

 arch/Kconfig                          | 10 ++++
 arch/arm/include/asm/jump_label.h     | 27 +++++++++
 arch/arm64/Kconfig                    |  1 +
 arch/arm64/include/asm/jump_label.h   | 48 +++++++++++++---
 arch/arm64/kernel/jump_label.c        | 22 +++++++-
 arch/arm64/kernel/vmlinux.lds.S       |  2 +-
 arch/mips/include/asm/jump_label.h    | 27 +++++++++
 arch/powerpc/Kconfig                  |  1 +
 arch/powerpc/include/asm/jump_label.h | 27 +++++++++
 arch/s390/Kconfig                     |  1 +
 arch/s390/include/asm/jump_label.h    | 20 +++++++
 arch/sparc/include/asm/jump_label.h   | 27 +++++++++
 arch/tile/include/asm/jump_label.h    | 27 +++++++++
 arch/x86/Kconfig                      |  1 +
 arch/x86/include/asm/Kbuild           |  1 +
 arch/x86/include/asm/export.h         |  5 --
 arch/x86/include/asm/jump_label.h     | 56 +++++++++++++++----
 arch/x86/kernel/jump_label.c          | 59 ++++++++++++++------
 drivers/pci/quirks.c                  | 13 ++++-
 include/asm-generic/export.h          | 12 +++-
 include/linux/compiler.h              | 11 ++++
 include/linux/export.h                | 46 +++++++++++----
 include/linux/init.h                  | 44 +++++++++++----
 include/linux/pci.h                   | 20 +++++++
 include/linux/tracepoint.h            | 19 +++++--
 init/main.c                           | 32 +++++------
 kernel/jump_label.c                   | 38 ++++++-------
 kernel/module.c                       | 33 +++++++++--
 kernel/printk/printk.c                |  4 +-
 kernel/tracepoint.c                   | 50 +++++++++--------
 security/security.c                   |  4 +-
 tools/objtool/special.c               |  4 +-
 32 files changed, 544 insertions(+), 148 deletions(-)
 delete mode 100644 arch/x86/include/asm/export.h

-- 
2.11.0
