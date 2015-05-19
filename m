Return-Path: <christophe.leroy@c-s.fr>
Received: from mailhub1.si.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 by lists.ozlabs.org (Postfix) with ESMTP id 2C6511A0017
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 May 2015 20:07:53 +1000 (AEST)
Message-Id: <cover.1432012060.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v2 0/6] powerpc32: replace memcpy and memset by cacheable
 alternatives
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 scottwood@freescale.com
Date: Tue, 19 May 2015 12:07:44 +0200 (CEST)
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patchset implements use of cacheable versions of memset and
memcpy since when the destination is not cacheable, memset_io
and memcpy_toio are used.

On MPC885, we observe a 7% rate increase on FTP transfer

Christophe Leroy (6):
  powerpc: use memset_io() to clear CPM Muram
  Partially revert "powerpc: Remove duplicate cacheable_memcpy/memzero
    functions"
  powerpc32: memset(0): use cacheable_memzero
  powerpc32: Merge the new memset() with the old one
  powerpc32: cacheable_memcpy becomes memcpy
  powerpc32: Few optimisations in memcpy

 arch/powerpc/lib/copy_32.S       | 109 ++++++++++++++++++++++++++++++++++++++-
 arch/powerpc/sysdev/cpm_common.c |   2 +-
 2 files changed, 109 insertions(+), 2 deletions(-)

-- 
2.1.0
