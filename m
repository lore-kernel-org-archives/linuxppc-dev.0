Return-Path: <joakim.tjernlund@transmode.com>
Received: from gw1.transmode.se (gw1.transmode.se [213.115.205.20])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 93339B7BCB
	for <linuxppc-dev@ozlabs.org>; Thu,  5 Nov 2009 00:38:49 +1100 (EST)
From: Joakim Tjernlund <Joakim.Tjernlund@transmode.se>
To: Scott Wood <scottwood@freescale.com>, Rex Feany <RFeany@mrv.com>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	"linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
Subject: [PATCH 0/8] 8xx: Misc fixes for buggy insn
Date: Wed, 4 Nov 2009 14:38:32 +0100
Message-Id: <1257341920-29277-1-git-send-email-Joakim.Tjernlund@transmode.se>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Here is the latest(last?) round of this series. I
hope I got everything right now.
Scott and Rex, please test and send ACK/NACK.

  Jocke

Joakim Tjernlund (8):
  8xx: invalidate non present TLBs
  8xx: Update TLB asm so it behaves as linux mm expects.
  8xx: Tag DAR with 0x00f0 to catch buggy instructions.
  8xx: Fixup DAR from buggy dcbX instructions.
  8xx: Add missing Guarded setting in DTLB Error.
  8xx: Restore _PAGE_WRITETHRU
  8xx: start using dcbX instructions in various copy routines
  8xx: Remove DIRTY pte handling in DTLB Error.

 arch/powerpc/include/asm/pte-8xx.h |   14 +-
 arch/powerpc/kernel/head_8xx.S     |  308 ++++++++++++++++++++++--------------
 arch/powerpc/kernel/misc_32.S      |   18 --
 arch/powerpc/lib/copy_32.S         |   24 ---
 arch/powerpc/mm/fault.c            |    8 +-
 5 files changed, 205 insertions(+), 167 deletions(-)
