Return-Path: <joakim.tjernlund@transmode.com>
Received: from gw1.transmode.se (gw1.transmode.se [213.115.205.20])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 3DD42B70B3
	for <linuxppc-dev@ozlabs.org>; Fri,  9 Oct 2009 00:25:06 +1100 (EST)
From: Joakim Tjernlund <Joakim.Tjernlund@transmode.se>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	"linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
	Rex Feany <RFeany@mrv.com>, Scott Wood <scottwood@freescale.com>
Subject: [PATCH 0/6] 8xx MMU fixes
Date: Thu, 8 Oct 2009 15:24:52 +0200
Message-Id: <1255008298-19949-1-git-send-email-Joakim.Tjernlund@transmode.se>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

So here we go again. This time I am
fairly confindent I got most things correct :)
Also manged to use even less instructions in the
TLB Miss handlers.

Scott and Rex, forget previous versions and
try this one out.

Once this works we can discuss further enchantments.

Joakim Tjernlund (6):
  8xx: DTLB Error must check for more errors.
  8xx: Update TLB asm so it behaves as linux mm expects.
  8xx: invalidate non present TLBs
  8xx: Tag DAR with 0x00f0 to catch buggy instructions.
  8xx: Fixup DAR from buggy dcbX instructions.
  8xx: start using dcbX instructions in various copy routines

 arch/powerpc/include/asm/pte-8xx.h |   13 +-
 arch/powerpc/kernel/head_8xx.S     |  252 +++++++++++++++++++++++++++++-------
 arch/powerpc/kernel/misc_32.S      |   18 ---
 arch/powerpc/lib/copy_32.S         |   24 ----
 arch/powerpc/mm/fault.c            |    8 +-
 5 files changed, 217 insertions(+), 98 deletions(-)
