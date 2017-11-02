Return-Path: <npiggin@gmail.com>
Received: from mail-pf0-x244.google.com (mail-pf0-x244.google.com
 [IPv6:2607:f8b0:400e:c00::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yS7Tb3M98zDqlM
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  2 Nov 2017 12:55:46 +1100 (AEDT)
Received: by mail-pf0-x244.google.com with SMTP id x7so3389392pfa.1
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 01 Nov 2017 18:55:46 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>
Subject: [PATCH v2 0/2] Add POWER9 DD2.0 feature,
 remove idle workarounds in DD2.1
Date: Thu,  2 Nov 2017 12:55:33 +1100
Message-Id: <20171102015535.30843-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Chnages since v1:
- Change unnecessarily 'inverted else' conditions for the DD2.0
  feature workarounds, noted by mpe.
- One of the cases was incorrect, removing the code in for DD2.0 and
  leaving it in for 2.1. Performance is further slightly improved with
  this case fixed.
  

Nicholas Piggin (2):
  powerpc: add POWER9_DD20 feature
  powerpc/64s: idle skip POWER9 DD1 and DD2.0 specific workarounds on
    DD2.1

 arch/powerpc/include/asm/cputable.h |  5 ++++-
 arch/powerpc/kernel/cputable.c      | 20 ++++++++++++++++++++
 arch/powerpc/kernel/dt_cpu_ftrs.c   |  2 ++
 arch/powerpc/kernel/idle_book3s.S   | 31 ++++++++++++++++++++-----------
 4 files changed, 46 insertions(+), 12 deletions(-)

-- 
2.15.0
