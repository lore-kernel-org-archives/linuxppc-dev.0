Return-Path: <msalter@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 by ozlabs.org (Postfix) with ESMTP id 2EFBF2C0345
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Nov 2013 03:14:52 +1100 (EST)
From: Mark Salter <msalter@redhat.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH v2 00/11] Consolidate asm/fixmap.h files
Date: Mon, 25 Nov 2013 11:13:54 -0500
Message-Id: <1385396045-15852-1-git-send-email-msalter@redhat.com>
Cc: linux-arch@vger.kernel.org, linux-mips@linux-mips.org,
 Michal Simek <monstr@monstr.eu>, James Hogan <james.hogan@imgtec.com>,
 Russell King <linux@arm.linux.org.uk>, Arnd Bergmann <arnd@arndb.de>,
 linux-hexagon@vger.kernel.org, microblaze-uclinux@itee.uq.edu.au,
 Ralf Baechle <ralf@linux-mips.org>, Richard Kuo <rkuo@codeaurora.org>,
 Mark Salter <msalter@redhat.com>, Paul Mackerras <paulus@samba.org>,
 linuxppc-dev@lists.ozlabs.org, linux-metag@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Many architectures provide an asm/fixmap.h which defines support for
compile-time 'special' virtual mappings which need to be made before
paging_init() has run. This suport is also used for early ioremap
on x86. Much of this support is identical across the architectures.
This patch consolidates all of the common bits into asm-generic/fixmap.h
which is intended to be included from arch/*/include/asm/fixmap.h.

This has been compiled on x86, arm, powerpc, and sh, but tested
on x86 only.

This is version two of the patch series:

   git://github.com/mosalter/linux.git#fixmap-v2

Version 1 is here:

   git://github.com/mosalter/linux.git#fixmap

Changes from v1:

  * Added acks from feedback.
  * Use BUILD_BUG_ON in fix_to_virt()
  * Fixed ARM patch to make FIXMAP_TOP inclusive of fixmap
    range as is the case in the other architectures.

Mark Salter (11):
  Add generic fixmap.h
  x86: use generic fixmap.h
  arm: use generic fixmap.h
  hexagon: use generic fixmap.h
  metag: use generic fixmap.h
  microblaze: use generic fixmap.h
  mips: use generic fixmap.h
  powerpc: use generic fixmap.h
  sh: use generic fixmap.h
  tile: use generic fixmap.h
  um: use generic fixmap.h

 arch/arm/include/asm/fixmap.h        | 29 +++--------
 arch/arm/mm/init.c                   |  2 +-
 arch/hexagon/include/asm/fixmap.h    | 40 +--------------
 arch/metag/include/asm/fixmap.h      | 32 +-----------
 arch/microblaze/include/asm/fixmap.h | 44 +---------------
 arch/mips/include/asm/fixmap.h       | 33 +-----------
 arch/powerpc/include/asm/fixmap.h    | 44 +---------------
 arch/sh/include/asm/fixmap.h         | 39 +--------------
 arch/tile/include/asm/fixmap.h       | 33 +-----------
 arch/um/include/asm/fixmap.h         | 40 +--------------
 arch/x86/include/asm/fixmap.h        | 59 +---------------------
 include/asm-generic/fixmap.h         | 97 ++++++++++++++++++++++++++++++++++++
 12 files changed, 118 insertions(+), 374 deletions(-)
 create mode 100644 include/asm-generic/fixmap.h

-- 
1.8.3.1
