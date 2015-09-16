Return-Path: <christophe.leroy@c-s.fr>
Received: from mailhub1.si.c-s.fr (2.236.17.93.rev.sfr.net [93.17.236.2])
 by lists.ozlabs.org (Postfix) with ESMTP id 1E1E31A04B3
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Sep 2015 20:05:18 +1000 (AEST)
Message-Id: <cover.1442335197.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v4 0/2] powerpc32: memcpy/memset: only use dcbz once cache is
 enabled
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 scottwood@freescale.com, sojkam1@fel.cvut.cz
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date: Wed, 16 Sep 2015 12:04:48 +0200 (CEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

memcpy() and memset() use instruction dcbz to speed up copy by not
wasting time loading cache lines with data that will be overwritten.
Some platform like mpc52xx do no have cache active at startup and
can therefore not use memcpy(). Allthough no part of the code
explicitly uses memcpy() and memset(), GCC makes calls to them.

Christophe Leroy (2):
  powerpc32: memcpy: only use dcbz once cache is enabled
  powerpc32: memset: only use dcbz once cache is enabled

 arch/powerpc/kernel/setup_32.c |  6 ++++++
 arch/powerpc/lib/copy_32.S     | 11 +++++++++++
 2 files changed, 17 insertions(+)

-- 
2.1.0
