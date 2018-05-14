Return-Path: <npiggin@gmail.com>
Received: from mail-pl0-x243.google.com (mail-pl0-x243.google.com
 [IPv6:2607:f8b0:400e:c01::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40l54b30ZGzF37v
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 May 2018 01:59:59 +1000 (AEST)
Received: by mail-pl0-x243.google.com with SMTP id c41-v6so2411101plj.10
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 May 2018 08:59:59 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>
Subject: [PATCH 0/2] sleeping functions in invalid context on panic fixes 
Date: Tue, 15 May 2018 01:59:45 +1000
Message-Id: <20180514155947.22753-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Here's a couple of fixes which seem to solve a problem where
panics can hang forever rather than reboot after 10 seconds. The
symptoms are that a CPU calls panic(), but later it is found in
idle.

Nicholas Piggin (2):
  powerpc/powernv: Fix opal_event_shutdown() called with interrupts
    disabled
  powerpc/powernv: Fix NVRAM sleep in invalid context when crashing

 arch/powerpc/platforms/powernv/opal-irqchip.c |  2 +-
 arch/powerpc/platforms/powernv/opal-nvram.c   | 14 ++++++++++++--
 2 files changed, 13 insertions(+), 3 deletions(-)

-- 
2.17.0
