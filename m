Return-Path: <ddaney.cavm@gmail.com>
Received: from mail-pa0-x232.google.com (mail-pa0-x232.google.com
 [IPv6:2607:f8b0:400e:c03::232])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 9AB811A03D5
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Feb 2016 11:02:49 +1100 (AEDT)
Received: by mail-pa0-x232.google.com with SMTP id fl4so21327339pad.0
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Feb 2016 16:02:49 -0800 (PST)
From: David Daney <ddaney.cavm@gmail.com>
To: Will Deacon <will.deacon@arm.com>, linux-arm-kernel@lists.infradead.org,
 Mark Rutland <mark.rutland@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Tony Luck <tony.luck@intel.com>, Fenghua Yu <fenghua.yu@intel.com>,
 James Hogan <james.hogan@imgtec.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Martin Schwidefsky <schwidefsky@de.ibm.com>,
 Heiko Carstens <heiko.carstens@de.ibm.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 Rich Felker <dalias@libc.org>, "David S. Miller" <davem@davemloft.net>,
 Chris Metcalf <cmetcalf@ezchip.com>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
 Arnd Bergmann <arnd@arndb.de>, linux-ia64@vger.kernel.org,
 linux-metag@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
 sparclinux@vger.kernel.org, linux-arch@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, David Daney <david.daney@cavium.com>
Subject: [PATCH 0/2] NUMA related header file cleanups.
Date: Wed, 24 Feb 2016 16:02:06 -0800
Message-Id: <1456358528-24213-1-git-send-email-ddaney.cavm@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: David Daney <david.daney@cavium.com>

Refactor many architectures' cpumask_of_pcibus and NODE_DATA definitions
by moving them to asm-generic.

Tested on arm64.

Build tested on ia64, m32r, powerpc, s390, sh, sparc(64), tile, x86

This patch set (arm64 portion) depends on this one:

https://lkml.org/lkml/2016/2/22/1066

Earler versions of these patches were part of the arm64 NUMA patch
set.  They have been split out here into a separate set.

Ganapatrao Kulkarni (2):
  topology, cleanup: Avoid redefinition of cpumask_of_pcibus in asm
    header files.
  numa, mm, cleanup: remove redundant NODE_DATA macro from asm header
    files.

 arch/arm64/include/asm/mmzone.h     |  4 +---
 arch/arm64/include/asm/topology.h   |  3 ---
 arch/ia64/include/asm/topology.h    |  4 ----
 arch/m32r/include/asm/mmzone.h      |  4 +---
 arch/metag/include/asm/mmzone.h     |  4 +---
 arch/metag/include/asm/topology.h   |  3 ---
 arch/powerpc/include/asm/mmzone.h   |  8 ++------
 arch/powerpc/include/asm/topology.h |  4 ----
 arch/s390/include/asm/mmzone.h      |  6 +-----
 arch/s390/include/asm/pci.h         |  2 +-
 arch/s390/include/asm/topology.h    |  1 +
 arch/sh/include/asm/mmzone.h        |  4 +---
 arch/sh/include/asm/topology.h      |  3 ---
 arch/sparc/include/asm/mmzone.h     |  6 ++----
 arch/tile/include/asm/pci.h         |  2 --
 arch/tile/include/asm/topology.h    |  3 +++
 arch/x86/include/asm/mmzone.h       |  3 +--
 arch/x86/include/asm/mmzone_32.h    |  5 -----
 arch/x86/include/asm/mmzone_64.h    | 17 -----------------
 arch/x86/include/asm/pci.h          |  2 +-
 arch/x86/include/asm/topology.h     |  1 +
 include/asm-generic/mmzone.h        | 24 ++++++++++++++++++++++++
 include/asm-generic/topology.h      |  4 ++--
 23 files changed, 43 insertions(+), 74 deletions(-)
 delete mode 100644 arch/x86/include/asm/mmzone_64.h
 create mode 100644 include/asm-generic/mmzone.h

-- 
1.8.3.1
