Return-Path: <christophe.leroy@c-s.fr>
Received: from mailhub1.si.c-s.fr (2.236.17.93.rev.sfr.net [93.17.236.2])
 by lists.ozlabs.org (Postfix) with ESMTP id 26D631A03ED
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Jun 2015 03:01:39 +1000 (AEST)
Message-Id: <cover.1434978970.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH 0/2] powerpc32: optimisation of csum_partial_copy_generic()
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 scottwood@freescale.com
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 Joakim Tjernlund <joakim.tjernlund@transmode.se>
Date: Mon, 22 Jun 2015 19:01:05 +0200 (CEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch optimises csum_partial_copy_generic() by making use of cache
instructions (dcbt/dcbz) just like copy_tofrom_user() does

On a TCP benchmark using socklib on the loopback interface on which checksum
offload and scatter/gather have been deactivated, we get about 20% performance
increase.


Christophe Leroy (2):
  powerpc32: checksum_wrappers_64 becomes checksum_wrappers
  powerpc32: rewrite of csum_partial_copy_generic based of copy_tofrom_user

 arch/powerpc/include/asm/checksum.h     |   9 -
 arch/powerpc/lib/Makefile               |   3 +-
 arch/powerpc/lib/checksum_32.S          | 320 +++++++++++++++++++++-----------
 arch/powerpc/lib/checksum_wrappers.c    | 102 ++++++++++
 arch/powerpc/lib/checksum_wrappers_64.c | 102 ----------
 5 files changed, 312 insertions(+), 224 deletions(-)
 create mode 100644 arch/powerpc/lib/checksum_wrappers.c
 delete mode 100644 arch/powerpc/lib/checksum_wrappers_64.c

-- 
2.1.0
