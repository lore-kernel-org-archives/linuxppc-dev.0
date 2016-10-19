Return-Path: <npiggin@gmail.com>
Received: from mail-pf0-x242.google.com (mail-pf0-x242.google.com
 [IPv6:2607:f8b0:400e:c00::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3szHCP5HFZzDt1c
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Oct 2016 14:16:17 +1100 (AEDT)
Received: by mail-pf0-x242.google.com with SMTP id i85so1092341pfa.0
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Oct 2016 20:16:17 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Stephen Rothwell <sfr@canb.auug.org.au>
Subject: [PATCH 0/7] build updates
Date: Wed, 19 Oct 2016 14:15:53 +1100
Message-Id: <20161019031600.17933-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,

I was hoping to get these posted earlier, but they had a dependency
on the kbuild tree which took a while to merge. Hopefully we can get
at least the first 4 patches in, which are just sanity checks on the
final binary.

With this series applied, I'm able to build[*] and boot a 64-bit
book3s allyesconfig kernel, a 200MB vmlinux (although today's tree
breaks in some random driver initcall in late boot). That's largely
a culmination of Stephen Rothwell's work (including the kbuild changes
that were merged earlier in 4.9), I just picked up some of his patches
so attributions may not be 100% reflective of reality.

[*] Building allyesconfig still requires KALLSYMS_EXTRA_PASS=1, which
    I'm yet to look into.

Thanks,
Nick

Nicholas Piggin (7):
  powerpc: use the new post-link pass to check relocations
  powerpc: add arch/powerpc/tools directory
  powerpc/64s: tool to flag direct branches from unrelocated interrupt
    vectors
  powerpc/64: tool to check head sections location sanity
  powerpc/64: handle linker stubs in low .text code
  powerpc: switch to using thin archives if COMPILE_TEST is set
  powerpc/64: allow CONFIG_RELOCATABLE if COMPILE_TEST

 arch/powerpc/Kconfig                               |  5 +-
 arch/powerpc/Makefile                              | 17 +----
 arch/powerpc/Makefile.postlink                     | 48 ++++++++++++++
 arch/powerpc/include/asm/head-64.h                 | 20 ++++--
 arch/powerpc/kernel/vmlinux.lds.S                  | 28 ++------
 .../gcc-check-mprofile-kernel.sh                   |  0
 arch/powerpc/tools/head_check.sh                   | 74 ++++++++++++++++++++++
 arch/powerpc/{ => tools}/relocs_check.sh           |  0
 arch/powerpc/tools/unrel_branch_check.sh           | 56 ++++++++++++++++
 9 files changed, 203 insertions(+), 45 deletions(-)
 create mode 100644 arch/powerpc/Makefile.postlink
 rename arch/powerpc/{scripts => tools}/gcc-check-mprofile-kernel.sh (100%)
 create mode 100755 arch/powerpc/tools/head_check.sh
 rename arch/powerpc/{ => tools}/relocs_check.sh (100%)
 create mode 100755 arch/powerpc/tools/unrel_branch_check.sh

-- 
2.9.3
