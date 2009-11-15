Return-Path: <joakim.tjernlund@transmode.com>
Received: from gw1.transmode.se (gw1.transmode.se [213.115.205.20])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id B87BC1007D1
	for <linuxppc-dev@ozlabs.org>; Mon, 16 Nov 2009 04:09:54 +1100 (EST)
From: Joakim Tjernlund <Joakim.Tjernlund@transmode.se>
To: Scott Wood <scottwood@freescale.com>,
	"linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
	Rex Feany <RFeany@mrv.com>
Subject: [PATCH 00/10] Fix 8xx MMU/TLB
Date: Sun, 15 Nov 2009 18:09:27 +0100
Message-Id: <1258304977-11760-1-git-send-email-Joakim.Tjernlund@transmode.se>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

[I used the wrong branch, this will hopefully not conflict]

This is hopfully the last iteration of the series.
Rex & Scott, please test and signoff.
Changes since last version:
 - Added mandatory pinning of iTLB
 - Added "DTLB Miss cleanup"

Joakim Tjernlund (10):
  8xx: invalidate non present TLBs
  8xx: Update TLB asm so it behaves as linux mm expects.
  8xx: Tag DAR with 0x00f0 to catch buggy instructions.
  8xx: Always pin kernel instruction TLB
  8xx: Fixup DAR from buggy dcbX instructions.
  8xx: Add missing Guarded setting in DTLB Error.
  8xx: Restore _PAGE_WRITETHRU
  8xx: start using dcbX instructions in various copy routines
  8xx: Remove DIRTY pte handling in DTLB Error.
  8xx: DTLB Miss cleanup

 arch/powerpc/include/asm/pte-8xx.h |   14 +-
 arch/powerpc/kernel/head_8xx.S     |  315 ++++++++++++++++++++++--------------
 arch/powerpc/kernel/misc_32.S      |   18 --
 arch/powerpc/lib/copy_32.S         |   24 ---
 arch/powerpc/mm/fault.c            |    8 +-
 5 files changed, 211 insertions(+), 168 deletions(-)
