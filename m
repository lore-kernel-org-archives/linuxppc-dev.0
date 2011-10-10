Return-Path: <joakim.tjernlund@transmode.se>
Received: from gw1.transmode.se (gw1.transmode.se [195.58.98.146])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id B238CB70BC
 for <linuxppc-dev@ozlabs.org>; Mon, 10 Oct 2011 22:30:33 +1100 (EST)
From: Joakim Tjernlund <Joakim.Tjernlund@transmode.se>
To: linuxppc-dev <linuxppc-dev@ozlabs.org>,
 Scott Wood <scottwood@freescale.com>, Willy Tarreau <w@1wt.eu>,
 Dan Malek <ppc6dev@digitaldans.com>
Subject: [PATCH 00/14] Backport 8xx TLB to 2.4
Date: Mon, 10 Oct 2011 13:30:06 +0200
Message-Id: <1318246220-4839-1-git-send-email-Joakim.Tjernlund@transmode.se>
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

V2:
 - Remove mandatory pinning of kernel ITLB. It is not
   needed in 2.4

8 MB Large page support will follow.

Joakim Tjernlund (14):
  8xx: Use a macro to simpliy CPU6 errata code.
  8xx: Tag DAR with 0x00f0 to catch buggy instructions.
  8xx: invalidate non present TLBs
  8xx: Fix CONFIG_PIN_TLB
  8xx: Update TLB asm so it behaves as linux mm expects.
  8xx: Fixup DAR from buggy dcbX instructions.
  8xx: CPU6 errata make DTLB error too big to fit.
  8xx: Add missing Guarded setting in DTLB Error.
  8xx: Restore _PAGE_WRITETHRU
  8xx: Set correct HW pte flags in DTLB Error too
  8xx: start using dcbX instructions in various copy routines
  8xx: Use symbolic constants in TLB asm
  8xx: Optimize TLB Miss handlers
  8xx: The TLB miss handler manages ACCESSED correctly.

 arch/ppc/kernel/head_8xx.S |  367 ++++++++++++++++++++++++++++++-------------
 arch/ppc/kernel/misc.S     |   18 --
 arch/ppc/lib/string.S      |   17 --
 include/asm-ppc/pgtable.h  |   26 +--
 4 files changed, 264 insertions(+), 164 deletions(-)

-- 
1.7.3.4
