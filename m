Return-Path: <maddy@linux.vnet.ibm.com>
Received: from e28smtp02.in.ibm.com (e28smtp02.in.ibm.com [122.248.162.2])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 608C51A0A9C
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Jun 2015 18:44:01 +1000 (AEST)
Received: from /spool/local
 by e28smtp02.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <maddy@linux.vnet.ibm.com>;
 Thu, 11 Jun 2015 14:13:59 +0530
Received: from d28relay05.in.ibm.com (d28relay05.in.ibm.com [9.184.220.62])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id 3118AE0045
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Jun 2015 14:17:21 +0530 (IST)
Received: from d28av04.in.ibm.com (d28av04.in.ibm.com [9.184.220.66])
 by d28relay05.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t5B8htIF9109732
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Jun 2015 14:13:55 +0530
Received: from d28av04.in.ibm.com (localhost [127.0.0.1])
 by d28av04.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t5B8hrbF016084
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Jun 2015 14:13:55 +0530
From: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 sukadev@linux.vnet.ibm.com, eranian@google.com,
 khandual@linux.vnet.ibm.com, rusty@rustcorp.com.au,
 Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Subject: [PATCH 4/8]powerpc/perf: Add Power8 mem_access event to sysfs
Date: Thu, 11 Jun 2015 14:13:33 +0530
Message-Id: <1434012217-9776-5-git-send-email-maddy@linux.vnet.ibm.com>
In-Reply-To: <1434012217-9776-1-git-send-email-maddy@linux.vnet.ibm.com>
References: <1434012217-9776-1-git-send-email-maddy@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Patch add "mem_access" event to sysfs. This as-is not a raw event
supported by Power8 pmu. Instead, it is formed based on
raw event encoding specificed in Power8-pmu.c.

Primary PMU event used here is PM_MRK_INST_CMPL.
This event tracks only the completed marked instructions.

Random sampling mode (MMCRA[SM]) with Random Load/Store
Facility Sampling (RLS) is enabled to mark type of instructions.

With Random sampling in RLS mode with PM_MRK_INST_CMPL event
on Power8, the LDST field in SIER identifies the memory
hierarchy level (eg: L1, L2 etc), from which a data-cache
miss for a marked instruction are satisfied.

Reviewed-by: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
Signed-off-by: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
---
 arch/powerpc/perf/power8-events-list.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/powerpc/perf/power8-events-list.h b/arch/powerpc/perf/power8-events-list.h
index 1368547..fdb8ce2 100644
--- a/arch/powerpc/perf/power8-events-list.h
+++ b/arch/powerpc/perf/power8-events-list.h
@@ -18,3 +18,4 @@ EVENT(PM_CMPLU_STALL,			0x4000a)
 EVENT(PM_INST_CMPL,			0x00002)
 EVENT(PM_BRU_FIN,			0x10068)
 EVENT(PM_BR_MPRED_CMPL,			0x400f6)
+EVENT(mem_access,			0x100010401e0)
-- 
1.9.1
