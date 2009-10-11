Return-Path: <joakim.tjernlund@transmode.com>
Received: from gw1.transmode.se (gw1.transmode.se [213.115.205.20])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 7D7E0B7B74
	for <linuxppc-dev@ozlabs.org>; Mon, 12 Oct 2009 03:35:22 +1100 (EST)
From: Joakim Tjernlund <Joakim.Tjernlund@transmode.se>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	"linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
	Rex Feany <RFeany@mrv.com>, Scott Wood <scottwood@freescale.com>
Subject: [PATCH 0/8] Fix 8xx MMU/TLB.
Date: Sun, 11 Oct 2009 18:35:04 +0200
Message-Id: <1255278912-8042-1-git-send-email-Joakim.Tjernlund@transmode.se>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This is the latest batch of mu 8xx MMU/TLB rework.
I think this is complete now and will relax with
other work the next few days. I hope I can get some
testing from Scott and Rex during this time.

Joakim Tjernlund (8):
  8xx: invalidate non present TLBs
  8xx: Update TLB asm so it behaves as linux mm expects.
  8xx: Tag DAR with 0x00f0 to catch buggy instructions.
  8xx: Fixup DAR from buggy dcbX instructions.
  8xx: dcbst sets store bit in DTLB error, workaround.
  8xx: Add missing Guarded setting in DTLB Error.
  8xx: Restore _PAGE_WRITETHRU
  8xx: start using dcbX instructions in various copy routines

 arch/powerpc/include/asm/pte-8xx.h |   14 +-
 arch/powerpc/kernel/head_8xx.S     |  307 ++++++++++++++++++++++++++++++------
 arch/powerpc/kernel/misc_32.S      |   18 --
 arch/powerpc/lib/copy_32.S         |   24 ---
 arch/powerpc/mm/fault.c            |    8 +-
 5 files changed, 269 insertions(+), 102 deletions(-)
