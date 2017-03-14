Return-Path: <npiggin@gmail.com>
Received: from mail-pg0-x243.google.com (mail-pg0-x243.google.com
 [IPv6:2607:f8b0:400e:c05::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vjDl13rNBzDr1W
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Mar 2017 23:37:01 +1100 (AEDT)
Received: by mail-pg0-x243.google.com with SMTP id 25so24276691pgy.3
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Mar 2017 05:37:01 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>
Subject: [PATCH 0/6] table-based machine check handlers
Date: Tue, 14 Mar 2017 22:36:42 +1000
Message-Id: <20170314123648.26068-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,

This is a rebase of the table based MCE patches on top of the POWER9
handler that was merged upstream. Plus a couple of misc things (patches
1 and 6).

The plan is to have OPAL firmware do most of this recovery and parsing
in future, but I think it's worth tidying this up. IMO it's easier to
see what's going on and less error prone to change or add things.

Thanks,
Nick

Nicholas Piggin (6):
  powerpc/64s: machine check print NIP
  powerpc/64s: clean up machine check recovery flushing
  powerpc/64s: move POWER machine check defines into mce_power.c
  powerpc/64s: data driven machine check evaluation
  powerpc/64s: data driven machine check handling
  powerpc/64s: POWER8 add missing machine check definitions

 arch/powerpc/include/asm/mce.h  |  91 -----
 arch/powerpc/kernel/mce.c       |   3 +-
 arch/powerpc/kernel/mce_power.c | 776 +++++++++++++++++++---------------------
 3 files changed, 369 insertions(+), 501 deletions(-)

-- 
2.11.0
