Return-Path: <joakim.tjernlund@transmode.se>
Received: from gw1.transmode.se (gw1.transmode.se [213.115.205.20])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 34746B70B3
	for <linuxppc-dev@ozlabs.org>; Tue, 11 Jan 2011 08:38:09 +1100 (EST)
From: Joakim Tjernlund <Joakim.Tjernlund@transmode.se>
To: Willy Tarreau <w@1wt.eu>, Scott Wood <scottwood@freescale.com>,
	linuxppc-dev <linuxppc-dev@ozlabs.org>
Subject: [PATCH 00/13] powerpc: Backport 8xx TLB to 2.4
Date: Mon, 10 Jan 2011 22:37:46 +0100
Message-Id: <1294695479-344-1-git-send-email-Joakim.Tjernlund@transmode.se>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This is a backport from 2.6 which I did to overcome 8xx CPU
bugs. 8xx does not update the DAR register when taking a TLB
error caused by dcbX and icbi insns which makes it very
tricky to use these insns. Also the dcbst wrongly sets the
the store bit when faulting into DTLB error.
A few more bugs very found during development.

I know 2.4 is in strict maintenance mode and 8xx is obsolete
but as it is still in use I wanted 8xx to age with grace.

Joakim Tjernlund (13):
  8xx: Use a macro to simpliy CPU6 errata code.
  8xx: Tag DAR with 0x00f0 to catch buggy instructions.
  8xx: invalidate non present TLBs
  8xx: Fix CONFIG_PIN_TLB
  8xx: Update TLB asm so it behaves as linux mm expects.
  8xx: Always pin kernel instruction TLB
  8xx: Fixup DAR from buggy dcbX instructions.
  8xx: CPU6 errata make DTLB error too big to fit.
  8xx: Add missing Guarded setting in DTLB Error.
  8xx: Restore _PAGE_WRITETHRU
  8xx: start using dcbX instructions in various copy routines
  8xx: Optimize ITLBMiss handler.
  8xx: Optimize TLB Miss handlers

 arch/ppc/kernel/head_8xx.S |  364 ++++++++++++++++++++++++++++++--------------
 arch/ppc/kernel/misc.S     |   18 ---
 arch/ppc/lib/string.S      |   17 --
 arch/ppc/mm/fault.c        |    8 +-
 include/asm-ppc/pgtable.h  |   16 +-
 5 files changed, 266 insertions(+), 157 deletions(-)

-- 
1.7.3.4
