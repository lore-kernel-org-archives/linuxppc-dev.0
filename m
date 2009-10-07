Return-Path: <joakim.tjernlund@transmode.com>
Received: from gw1.transmode.se (gw1.transmode.se [213.115.205.20])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 4347BB7B84
	for <linuxppc-dev@ozlabs.org>; Thu,  8 Oct 2009 07:46:12 +1100 (EST)
From: Joakim Tjernlund <Joakim.Tjernlund@transmode.se>
To: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
	Rex Feany <RFeany@mrv.com>, Scott Wood <scottwood@freescale.com>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH 0/6] 8xx TLB fixes.
Date: Wed, 7 Oct 2009 22:45:58 +0200
Message-Id: <1254948364-30074-1-git-send-email-Joakim.Tjernlund@transmode.se>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

OK, here is the next try att fixing the MPC8xx MMU
problems. Pleas add one(or two) patches at a time and
test.

Expect some trivial merge conflicts in 8xx header file, sorry
about that.

Joakim Tjernlund (6):
  8xx: DTLB Error must check for more errors.
  8xx: get rid of _PAGE_HWWRITE dependency in MMU.
  8xx: invalidate non present TLBs
  8xx: Tag DAR with 0x00f0 to catch buggy instructions.
  8xx: Fixup DAR from buggy dcbX instructions.
  8xx: start using dcbX instructions in various copy routines

 arch/powerpc/include/asm/pte-8xx.h |   13 +-
 arch/powerpc/kernel/head_8xx.S     |  243 +++++++++++++++++++++++++++++-------
 arch/powerpc/kernel/misc_32.S      |   18 ---
 arch/powerpc/lib/copy_32.S         |   24 ----
 arch/powerpc/mm/fault.c            |    8 +-
 5 files changed, 209 insertions(+), 97 deletions(-)
