Return-Path: <joakim.tjernlund@transmode.com>
Received: from gw1.transmode.se (gw1.transmode.se [213.115.205.20])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id B960BB7BB7
	for <linuxppc-dev@ozlabs.org>; Mon,  5 Oct 2009 23:16:49 +1100 (EST)
From: Joakim Tjernlund <Joakim.Tjernlund@transmode.se>
To: Scott Wood <scottwood@freescale.com>, Rex Feany <RFeany@mrv.com>,
	"linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH 0/6] PowerPc 8xx TLB/MMU fixes
Date: Mon, 5 Oct 2009 14:16:33 +0200
Message-Id: <1254744999-3158-1-git-send-email-Joakim.Tjernlund@transmode.se>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Here are my latest code to fixup 8xx's TLB code.
This code needs some serious testing before it
can be commited.
The "8xx, fault: Add some debug code to do_page_fault()" is
purely a debug check and will be removed/disabled when
this series appear stable.

Scott and Rex, please disregard other patches from me and
try these out instead.

Joakim Tjernlund (6):
  8xx: DTLB Error must check for more errors.
  8xx, fault: Add some debug code to do_page_fault()
  8xx: get rid of _PAGE_HWWRITE dependency in MMU.
  8xx: Tag DAR with 0x00f0 to catch buggy instructions.
  8xx: Fixup DAR from buggy dcbX instructions.
  8xx: start using dcbX instructions in various copy routines

 arch/powerpc/include/asm/pte-8xx.h |    9 +-
 arch/powerpc/kernel/head_8xx.S     |  324 ++++++++++++++++++++++++++++++-----
 arch/powerpc/kernel/misc_32.S      |   18 --
 arch/powerpc/lib/copy_32.S         |   24 ---
 arch/powerpc/mm/fault.c            |   82 +++++++++
 5 files changed, 363 insertions(+), 94 deletions(-)
