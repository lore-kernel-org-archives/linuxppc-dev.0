Return-Path: <npiggin@gmail.com>
Received: from mail-pf0-x243.google.com (mail-pf0-x243.google.com
 [IPv6:2607:f8b0:400e:c00::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3ydg2Z3yLzzDrSK
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 18 Nov 2017 01:08:54 +1100 (AEDT)
Received: by mail-pf0-x243.google.com with SMTP id i15so2035299pfa.3
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Nov 2017 06:08:54 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>,
 "Gautham R . Shenoy" <ego@linux.vnet.ibm.com>,
 Paul Mackerras <paulus@ozlabs.org>
Subject: [PATCH 0/3] one more try at idle improvements
Date: Sat, 18 Nov 2017 00:08:04 +1000
Message-Id: <20171117140807.22105-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The recent KVM work clashed with a couple of my patches, so they were
reverted/dropped for this merge window.

I've made another attempt at them, hopefully done in a way that is
more compatible with KVM requirements and in a bit nicer way (POWER8
contex switching should speed up a bit too). I'm not completely sure I
got patch 2 right. It works on POWER8, but haven't been able to get
POWER9 running with hash on radix.

Thanks,
Nick

Nicholas Piggin (3):
  powerpc/64s/idle: POWER9 implement a separate idle stop function for
    hotplug
  powerpc/64s/idle: avoid sync for KVM state when waking from idle
  powerpc/64s/idle: POWER9 ESL=0 stop avoid save/restore overhead

 arch/powerpc/include/asm/processor.h  |  1 +
 arch/powerpc/kernel/idle_book3s.S     | 62 +++++++++++++++++------------------
 arch/powerpc/platforms/powernv/idle.c |  9 +++--
 3 files changed, 38 insertions(+), 34 deletions(-)

-- 
2.15.0
