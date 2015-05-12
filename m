Return-Path: <christophe.leroy@c-s.fr>
Received: from mailhub1.si.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 by lists.ozlabs.org (Postfix) with ESMTP id E01131A0008
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 May 2015 23:32:52 +1000 (AEST)
Message-Id: <cover.1431436210.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH 0/4] powerpc32: use cacheable alternatives of memcpy and memset
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 scottwood@freescale.com
Date: Tue, 12 May 2015 15:32:47 +0200 (CEST)
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 Kyle Moffett <Kyle.D.Moffett@boeing.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patchset implements use of cacheable versions of memset and
memcpy when the len is greater than the cacheline size and the
destination is in RAM.

On MPC885, we observe a 7% rate increase on FTP transfer

Christophe Leroy (4):
  Partially revert "powerpc: Remove duplicate cacheable_memcpy/memzero
    functions"
  powerpc32: swap r4 and r5 in cacheable_memzero
  powerpc32: memset(0): use cacheable_memzero
  powerpc32: memcpy: use cacheable_memcpy

 arch/powerpc/lib/copy_32.S | 148 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 148 insertions(+)

-- 
2.1.0
