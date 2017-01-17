Return-Path: <ard.biesheuvel@linaro.org>
Received: from mail-wm0-x229.google.com (mail-wm0-x229.google.com
 [IPv6:2a00:1450:400c:c09::229])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3v30TF13W7zDqKV
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Jan 2017 06:26:25 +1100 (AEDT)
Received: by mail-wm0-x229.google.com with SMTP id r126so215155208wmr.0
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Jan 2017 11:26:25 -0800 (PST)
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
To: linux-kernel@vger.kernel.org,
	mpe@ellerman.id.au,
	jeyu@redhat.com
Cc: rusty@rustcorp.com.au, suzuki.poulose@arm.com, will.deacon@arm.com,
 akpm@linux-foundation.org, benh@kernel.crashing.org, paulus@samba.org,
 arnd@arndb.de, torvalds@linux-foundation.org, viro@zeniv.linux.org.uk,
 linuxppc-dev@lists.ozlabs.org, Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: [PATCH v4 0/3] modversions: Fix CRC mangling under
 CONFIG_RELOCATABLE=y
Date: Tue, 17 Jan 2017 19:26:10 +0000
Message-Id: <1484681173-11644-1-git-send-email-ard.biesheuvel@linaro.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This series is a followup to the single patch 'modversions: treat symbol
CRCs as 32 bit quantities on 64 bit archs', of which three versions have
been sent out so far [0][1][2]

Given the recent issues regarding modversions, I have added some more
people to cc this time.

As pointed out by Michael, GNU ld behaves a bit differently between arm64
and PowerPC64, and where the former gets rid of all runtime relocations
related to CRCs, the latter is not as easily convinced.

Patch #1 fixes the issue where CRCs are corrupted by the runtime relocation
routines for 32-bit PowerPC, for which the original fix was effectively
reverted by commit 0e0ed6406e61 ("powerpc/modules: Module CRC relocation fix
causes perf issues")

Patch #2 adds handling of R_PPC64_ADDR32 relocations against the NULL .dynsym
symbol entry to the PPC64 runtime relocation routines, so it is prepared to
deal with CRCs being emitted as 32-bit quantities.

Patch #3 is the original patch from the v1 and v2 submissions.

Changes since v3:
- rebased onto v4.10-rc
- add Suzuki's ack to patch #1
- update patch #2 to work around the binutils-powerpc behavior to only
  account for R_PPC64_RELATIVE relocations in the RELACOUNT entry in
  .dynamic

Changes since v2:
- added #1 and #2
- updated #3 to deal with CRC entries being emitted from assembler
- added Rusty's ack (#3)

Branch can be found here:
https://git.kernel.org/cgit/linux/kernel/git/ardb/linux.git/log/?h=kcrctab-reloc

[0] http://marc.info/?l=linux-kernel&m=147652300207369&w=2
[1] http://marc.info/?l=linux-kernel&m=147695629614409&w=2
[2] http://marc.info/?l=linux-kernel&m=147758564705776&w=2

Ard Biesheuvel (3):
  powerpc/reloc32: fix corrupted modversion CRCs
  powerpc/reloc64: add support for 32-bit CRC pseudo-symbols
  modversions: treat symbol CRCs as 32 bit quantities on 64 bit archs

 arch/powerpc/include/asm/module.h |  4 --
 arch/powerpc/kernel/module_64.c   |  8 ---
 arch/powerpc/kernel/reloc_32.S    | 36 ++++++++++--
 arch/powerpc/kernel/reloc_64.S    | 60 ++++++++++++--------
 arch/powerpc/kernel/vmlinux.lds.S |  1 +
 arch/powerpc/relocs_check.sh      |  5 +-
 include/asm-generic/export.h      |  7 +--
 include/linux/export.h            |  8 +++
 include/linux/module.h            | 14 ++---
 kernel/module.c                   | 47 ++++++---------
 10 files changed, 105 insertions(+), 85 deletions(-)

-- 
2.7.4
