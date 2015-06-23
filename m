Return-Path: <christophe.leroy@c-s.fr>
Received: from mailhub1.si.c-s.fr (2.236.17.93.rev.sfr.net [93.17.236.2])
 by lists.ozlabs.org (Postfix) with ESMTP id 574811A0018
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Jun 2015 15:38:27 +1000 (AEST)
Message-Id: <cover.1435036849.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v2 0/2] powerpc32: optimisation of csum_partial_copy_generic()
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 scottwood@freescale.com
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 Joakim Tjernlund <joakim.tjernlund@transmode.se>
Date: Tue, 23 Jun 2015 07:38:23 +0200 (CEST)
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

v2 is just a new issue with format-patch -M -C, other changes.

Christophe Leroy (2):
  powerpc32: checksum_wrappers_64 becomes checksum_wrappers
  powerpc32: rewrite of csum_partial_copy_generic based of copy_tofrom_user

 arch/powerpc/include/asm/checksum.h                |   9 -
 arch/powerpc/lib/Makefile                          |   3 +-
 arch/powerpc/lib/checksum_32.S                     | 320 ++++++++++++++-------
 ...{checksum_wrappers_64.c => checksum_wrappers.c} |   0
 4 files changed, 210 insertions(+), 122 deletions(-)
 rename arch/powerpc/lib/{checksum_wrappers_64.c => checksum_wrappers.c} (100%)

-- 
2.1.0
