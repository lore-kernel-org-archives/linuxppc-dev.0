Return-Path: <joakim.tjernlund@transmode.se>
Received: from gw1.transmode.se (gw1.transmode.se [195.58.98.146])
	(using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 9A840B709E
	for <linuxppc-dev@ozlabs.org>; Wed, 15 Jun 2011 00:05:41 +1000 (EST)
From: Joakim Tjernlund <Joakim.Tjernlund@transmode.se>
To: Willy Tarreau <w@1wt.eu>, Scott Wood <scottwood@freescale.com>,
	linuxppc-dev <linuxppc-dev@ozlabs.org>
Subject: [PATCH 00/15]  Backport 8xx TLB to 2.4
Date: Tue, 14 Jun 2011 15:54:45 +0200
Message-Id: <1308059700-10839-1-git-send-email-Joakim.Tjernlund@transmode.se>
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

Addendum:
I have now ported our 8xx custom board to 2.4.37.11 and
tested these patches there.

Joakim Tjernlund (15):
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
  8xx: Set correct HW pte flags in DTLB Error too
  8xx: start using dcbX instructions in various copy routines
  8xx: Use symbolic constants in TLB asm
  8xx: Optimize ITLBMiss handler.
  8xx: Optimize TLB Miss handlers

 arch/ppc/kernel/head_8xx.S |  381 ++++++++++++++++++++++++++++++-------------
 arch/ppc/kernel/misc.S     |   18 --
 arch/ppc/lib/string.S      |   17 --
 include/asm-ppc/pgtable.h  |   16 +-
 4 files changed, 274 insertions(+), 158 deletions(-)

-- 
1.7.3.4
