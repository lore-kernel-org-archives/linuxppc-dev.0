Return-Path: <ard.biesheuvel@linaro.org>
Received: from mail-wm0-x22e.google.com (mail-wm0-x22e.google.com
 [IPv6:2a00:1450:400c:c09::22e])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vFBzW1mZxzDqBX
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  3 Feb 2017 20:54:31 +1100 (AEDT)
Received: by mail-wm0-x22e.google.com with SMTP id b65so20303010wmf.0
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 03 Feb 2017 01:54:31 -0800 (PST)
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
To: linux-kbuild@vger.kernel.org, linux-arch@vger.kernel.org,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 jeyu@redhat.com, rusty@rustcorp.com.au, mmarek@suse.com, mpe@ellerman.id.au
Cc: torvalds@linux-foundation.org, arnd@arndb.de, viro@zeniv.linux.org.uk,
 linux-arm-kernel@lists.infradead.org,
 Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: [PATCH v5 0/3] modversions: redefine kcrctab entries as 32-bit values
Date: Fri,  3 Feb 2017 09:54:04 +0000
Message-Id: <1486115647-27680-1-git-send-email-ard.biesheuvel@linaro.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This v4 is a followup to [0] 'modversions: redefine kcrctab entries as
relative CRC pointers', but since relative CRC pointers do not work in
modules, and are actually only needed by powerpc with CONFIG_RELOCATABLE=y,
I have made it a Kconfig selectable feature instead.

Patch #1 introduces the MODULE_REL_CRCS Kconfig symbol, and adds the kbuild
handling of it, i.e., modpost, genksyms and kallsyms.

Patch #2 switches all architectures to 32-bit CRC entries in kcrctab, where
all architectures except powerpc with CONFIG_RELOCATABLE=y use absolute ELF
symbol references as before.

v5: make MODULE_REL_CRCS apply to both vmlinux and modules when selected
    reinstate Rusty's ack on #2, given that it is now mostly identical again
    to the patch he acked 3 months ago

v4: make relative CRCs kconfig selectable
    use absolute CRC symbols in modules regardless of kconfig selection
    split into two patches

v3: emit CRCs into .rodata rather than .rodata.modver, given that the latter
    will be emitted with read-write permissions, making the CRCs end up in a
    writable module segment.

    fold the modpost fix to ensure that the section address is only substracted
    from the symbol address when the ELF object in question is fully linked
    (i.e., ET_DYN or ET_EXEC, and not ET_REL)

v2: update modpost as well, so that genksyms no longer has to emit symbols
    for both the actual CRC value and the reference to where it is stored
    in the image

[0] http://marc.info/?l=linux-arch&m=148493613415294&w=2

Ard Biesheuvel (3):
  kbuild: modversions: add infrastructure for emitting relative CRCs
  modversions: treat symbol CRCs as 32 bit quantities
  module: unify absolute krctab definitions for 32-bit and 64-bit

 arch/powerpc/Kconfig              |  1 +
 arch/powerpc/include/asm/module.h |  4 --
 arch/powerpc/kernel/module_64.c   |  8 ---
 include/asm-generic/export.h      | 11 ++--
 include/linux/export.h            | 17 +++++--
 include/linux/module.h            | 14 +++---
 init/Kconfig                      |  4 ++
 kernel/module.c                   | 53 +++++++++-----------
 scripts/Makefile.build            |  2 +
 scripts/genksyms/genksyms.c       | 19 +++++--
 scripts/kallsyms.c                | 12 +++++
 scripts/mod/modpost.c             | 10 ++++
 12 files changed, 93 insertions(+), 62 deletions(-)

-- 
2.7.4
