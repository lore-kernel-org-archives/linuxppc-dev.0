Return-Path: <npiggin@gmail.com>
Received: from mail-pg0-x242.google.com (mail-pg0-x242.google.com
 [IPv6:2607:f8b0:400e:c05::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vRvGj5l5fzDqC0
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Feb 2017 06:44:45 +1100 (AEDT)
Received: by mail-pg0-x242.google.com with SMTP id 1so6988385pgz.2
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Feb 2017 11:44:45 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>,
 Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
Subject: [PATCH 0/9] MCE handler for POWER9
Date: Tue, 21 Feb 2017 05:44:21 +1000
Message-Id: <20170220194430.32602-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,

The first part of this series up to patch 5 includes MCE handler
definitions for POWER9. Probably the biggest concern is the new
MCE types and how they are recorded and reported, so comments on
that would be welcome.

Patches 6 onward change the MCE parsing into a table base approach.
Note, those later changes are not functionally identical (as noted
in comments, e.g. effective address and ERAT flushing changes slightly).

This has had some testing with a userspace harness, as well as some
tests in mambo.

Thanks,
Nick

Nicholas Piggin (9):
  powerpc/64s: machine check print NIP
  powerpc/64s: allow machine check handler to set severity and initiator
  powerpc/64s: clean up machine check recovery flushing
  powerpc/64s: cope with non-synchronous machine checks
  powerpc/64s: POWER9 machine check handler
  powerpc/64s: move POWER machine check defines into mce_power.c
  powerpc/64s: data driven machine check evaluation
  powerpc/64s: data driven machine check handling
  powerpc/64s: POWER8 add missing machine check definitions

 arch/powerpc/include/asm/bitops.h     |   4 +
 arch/powerpc/include/asm/mce.h        | 101 +++---
 arch/powerpc/kernel/cputable.c        |   3 +
 arch/powerpc/kernel/mce.c             |  91 +++++-
 arch/powerpc/kernel/mce_power.c       | 590 +++++++++++++++++++++++-----------
 arch/powerpc/platforms/powernv/opal.c |  20 +-
 6 files changed, 564 insertions(+), 245 deletions(-)

-- 
2.11.0
