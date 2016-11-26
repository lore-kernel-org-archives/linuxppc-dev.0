Return-Path: <npiggin@gmail.com>
Received: from mail-pg0-x242.google.com (mail-pg0-x242.google.com
 [IPv6:2607:f8b0:400e:c05::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tQddY3SgqzDsxh
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 26 Nov 2016 14:26:25 +1100 (AEDT)
Received: by mail-pg0-x242.google.com with SMTP id e9so6987673pgc.1
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 Nov 2016 19:26:25 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Nicholas Piggin <npiggin@gmail.com>,
	linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 0/4] resend build sanity checking additions
Date: Sat, 26 Nov 2016 14:26:08 +1100
Message-Id: <20161126032612.13559-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

I've updated these in response to feedback and some wider testing
(that uncovered a few other issues).

Thanks,
Nick

Nicholas Piggin (4):
  powerpc: use the new post-link pass to check relocations
  powerpc: add arch/powerpc/tools directory
  powerpc/64s: tool to flag direct branches from unrelocated interrupt
    vectors
  powerpc/64: tool to check head sections location sanity

 arch/powerpc/Makefile                              | 13 +---
 arch/powerpc/Makefile.postlink                     | 47 +++++++++++++++
 arch/powerpc/include/asm/head-64.h                 |  4 +-
 arch/powerpc/kernel/vmlinux.lds.S                  | 22 -------
 .../gcc-check-mprofile-kernel.sh                   |  0
 arch/powerpc/tools/head_check.sh                   | 70 ++++++++++++++++++++++
 arch/powerpc/{ => tools}/relocs_check.sh           |  0
 arch/powerpc/tools/unrel_branch_check.sh           | 57 ++++++++++++++++++
 8 files changed, 177 insertions(+), 36 deletions(-)
 create mode 100644 arch/powerpc/Makefile.postlink
 rename arch/powerpc/{scripts => tools}/gcc-check-mprofile-kernel.sh (100%)
 create mode 100755 arch/powerpc/tools/head_check.sh
 rename arch/powerpc/{ => tools}/relocs_check.sh (100%)
 create mode 100755 arch/powerpc/tools/unrel_branch_check.sh

-- 
2.10.2
