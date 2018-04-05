Return-Path: <npiggin@gmail.com>
Received: from mail-pl0-x244.google.com (mail-pl0-x244.google.com
 [IPv6:2607:f8b0:400e:c01::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40GsZ86Z7zzF1w6
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  5 Apr 2018 15:58:08 +1000 (AEST)
Received: by mail-pl0-x244.google.com with SMTP id bj1-v6so15266680plb.8
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 04 Apr 2018 22:58:08 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
	Ram Pai <linuxram@us.ibm.com>
Subject: [PATCH 1/2] powerpc/64s: Fix pkey support in dt_cpu_ftrs,
 add CPU_FTR_PKEY bit
Date: Thu,  5 Apr 2018 15:57:54 +1000
Message-Id: <20180405055755.30090-2-npiggin@gmail.com>
In-Reply-To: <20180405055755.30090-1-npiggin@gmail.com>
References: <20180405055755.30090-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The pkey code added a CPU_FTR_PKEY bit, but did not add it to the
dt_cpu_ftrs feature set. Although capability is supported by all
processors in the base dt_cpu_ftrs set for 64s, it's a significant
and sufficiently well defined feature to make it optional. So add
it as a quirk for now, which can be versioned out then controlled
by the firmware (once dt_cpu_ftrs gains versioning support).

Fixes: cf43d3b264 ("powerpc: Enable pkey subsystem ")
Cc: Ram Pai <linuxram@us.ibm.com>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/kernel/dt_cpu_ftrs.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/powerpc/kernel/dt_cpu_ftrs.c b/arch/powerpc/kernel/dt_cpu_ftrs.c
index ed7605d8fd2d..e88fbb1fdb8f 100644
--- a/arch/powerpc/kernel/dt_cpu_ftrs.c
+++ b/arch/powerpc/kernel/dt_cpu_ftrs.c
@@ -729,6 +729,13 @@ static __init void cpufeatures_cpu_quirks(void)
 		cur_cpu_spec->cpu_features &= ~(CPU_FTR_DAWR);
 		cur_cpu_spec->cpu_features |= CPU_FTR_P9_TLBIE_BUG;
 	}
+
+	/*
+	 * PKEY was not in the initial base or feature node
+	 * specification, but it should become optional in the next
+	 * cpu feature version sequence.
+	 */
+	cur_cpu_spec->cpu_features |= CPU_FTR_PKEY;
 }
 
 static void __init cpufeatures_setup_finished(void)
-- 
2.16.3
