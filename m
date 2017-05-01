Return-Path: <npiggin@gmail.com>
Received: from mail-pf0-x243.google.com (mail-pf0-x243.google.com
 [IPv6:2607:f8b0:400e:c00::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wGjgl1kryzDq7Z
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  1 May 2017 22:01:23 +1000 (AEST)
Received: by mail-pf0-x243.google.com with SMTP id o68so8457007pfj.2
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 01 May 2017 05:01:23 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH 0/2] non maskable interrupt reentrancy fixes for OPAL
Date: Mon,  1 May 2017 22:01:08 +1000
Message-Id: <20170501120110.21888-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,

These fixes are more minimal, and split up properly since last post.
Also accounted for Ben's comment of using HSRRs rather than disabling
RI for OPAL_CALL.

This will still increase cost of opal calls a bit due to new mtmsr in
FIXUP_ENDIAN return.

I have a few more patches that reduce overhead quite a bit, but they
won't be suitable for 4.12, so I'll send those out after merge window.

Thanks,
Nick

Nicholas Piggin (2):
  powerpc/64s: Fix FIXUP_ENDIAN non-maskable interrupt reentrancy
  powerpc/64s: Fix OPAL_CALL non-maskable interrupt reentrancy

 arch/powerpc/boot/ppc_asm.h                    | 12 +++++++-----
 arch/powerpc/include/asm/ppc_asm.h             | 11 +++++++----
 arch/powerpc/platforms/powernv/opal-wrappers.S |  6 +++---
 3 files changed, 17 insertions(+), 12 deletions(-)

-- 
2.11.0
