Return-Path: <joakim.tjernlund@transmode.se>
Received: from gw1.transmode.se (gw1.transmode.se [195.58.98.146])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 939B9B70FE
 for <linuxppc-dev@ozlabs.org>; Mon, 10 Oct 2011 22:38:38 +1100 (EST)
From: Joakim Tjernlund <Joakim.Tjernlund@transmode.se>
To: Dan Malek <ppc6dev@digitaldans.com>,
 linuxppc-dev <linuxppc-dev@ozlabs.org>,
 Scott Wood <scottwood@freescale.com>, Willy Tarreau <w@1wt.eu>
Subject: [PATCH 0/3] 8xx: Large page(8MB) support for 2.4
Date: Mon, 10 Oct 2011 13:38:31 +0200
Message-Id: <1318246714-5015-1-git-send-email-Joakim.Tjernlund@transmode.se>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This adds Large page support for 8xx and uses it
for all kernel RAM.

Further usage is possible, IMAP_ADDR and on board
flash comes to mind.

There is one bit free the pte which could be used for
selecting different large page sizes but that is for another
day.

- Dan, what do you think :)

Joakim Tjernlund (3):
  8xx: replace _PAGE_EXEC with _PAGE_PSE
  8xx: Support LARGE pages in TLB code.
  8xx: Use LARGE pages for kernel RAM.

 arch/ppc/kernel/head_8xx.S |   30 +++++++++++++++++++-----------
 arch/ppc/mm/pgtable.c      |    4 +++-
 include/asm-ppc/pgtable.h  |    6 +++++-
 3 files changed, 27 insertions(+), 13 deletions(-)

-- 
1.7.3.4
