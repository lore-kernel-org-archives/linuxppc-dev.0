Return-Path: <scottwood@freescale.com>
Received: from va3outboundpool.messaging.microsoft.com
 (va3ehsobe001.messaging.microsoft.com [216.32.180.11])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id A89182C00BA
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 23 Nov 2013 10:21:33 +1100 (EST)
Date: Fri, 22 Nov 2013 17:21:08 -0600
From: Scott Wood <scottwood@freescale.com>
To: <benh@kernel.crashing.org>
Subject: Pull request: scottwood/linux.git
Message-ID: <20131122232108.GA32600@home.buserror.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The corenet64 patch fixes a regression introduced in 3.13-rc1 (commit
ef1313deafb7baa6d3382044e962d5ad5e8c8dd6, "powerpc: Add VMX optimised xor
for RAID5").

The 8xx patch fixes a regression introduced in 3.12 (commit
beb2dc0a7a84be003ce54e98b95d65cc66e6e536, "powerpc: Convert some
mftb/mftbu into mfspr").

The other two patches are fixes for minor, long standing bugs.

The following changes since commit 6ce4eac1f600b34f2f7f58f9cd8f0503d79e42ae:

  Linux 3.13-rc1 (2013-11-22 11:30:55 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/scottwood/linux.git 

for you to fetch changes up to d742aa152f27448d39ce65fb829e396d10cd63a9:

  powerpc/booke: Only check for hugetlb in flush if vma != NULL (2013-11-22 16:57:29 -0600)

----------------------------------------------------------------
Adam Borowski (1):
      powerpc/85xx: typo in dts: "interupt" (four devices)

LEROY Christophe (1):
      powerpc/8xx: mfspr SPRN_TBRx in lieu of mftb/mftbu is not supported

Scott Wood (1):
      powerpc/booke: Only check for hugetlb in flush if vma != NULL

Tiejun Chen (1):
      powerpc/corenet64: compile with CONFIG_E{5,6}500_CPU well

 arch/powerpc/Makefile                     |  5 +++++
 arch/powerpc/boot/dts/xcalibur1501.dts    |  4 ++--
 arch/powerpc/boot/dts/xpedite5301.dts     |  4 ++--
 arch/powerpc/boot/dts/xpedite5330.dts     |  4 ++--
 arch/powerpc/boot/dts/xpedite5370.dts     |  4 ++--
 arch/powerpc/boot/util.S                  | 14 ++++++++++++++
 arch/powerpc/include/asm/ppc_asm.h        |  2 ++
 arch/powerpc/include/asm/reg.h            |  7 +++++++
 arch/powerpc/include/asm/timex.h          |  8 ++++++++
 arch/powerpc/kernel/vdso32/gettimeofday.S |  6 ++++++
 arch/powerpc/mm/hugetlbpage-book3e.c      |  3 +--
 arch/powerpc/mm/tlb_nohash.c              |  2 +-
 12 files changed, 52 insertions(+), 11 deletions(-)
