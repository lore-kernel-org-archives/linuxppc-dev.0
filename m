Return-Path: <hemant@linux.vnet.ibm.com>
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4526B1A1E4C
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 31 Aug 2015 16:55:27 +1000 (AEST)
Received: from /spool/local
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <hemant@linux.vnet.ibm.com>;
 Mon, 31 Aug 2015 16:55:25 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 085723578053
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 31 Aug 2015 16:55:23 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t7V6tFwD55836792
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 31 Aug 2015 16:55:23 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t7V6soGb026085
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 31 Aug 2015 16:54:50 +1000
From: Hemant Kumar <hemant@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: linux-kernel@vger.kernel.org, scottwood@freescale.com, acme@kernel.org,
 mingo@kernel.org, mpe@ellerman.id.au, sukadev@linux.vnet.ibm.com,
 maddy@linux.vnet.ibm.com, warrier@linux.vnet.ibm.com,
 srikar@linux.vnet.ibm.com, paulus@samba.org,
 Hemant Kumar <hemant@linux.vnet.ibm.com>
Subject: [PATCH v6 1/3] perf,kvm/powerpc: Remove const from kvm_events_tp
Date: Mon, 31 Aug 2015 12:24:26 +0530
Message-Id: <1441004068-11306-1-git-send-email-hemant@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch removes the "const" qualifier from kvm_events_tp declaration
to account for the fact that powerpc will need to update this variable
dynamically depending on the machine type.

Signed-off-by: Hemant Kumar <hemant@linux.vnet.ibm.com>
---
 tools/perf/arch/s390/util/kvm-stat.c | 2 +-
 tools/perf/arch/x86/util/kvm-stat.c  | 2 +-
 tools/perf/util/kvm-stat.h           | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/perf/arch/s390/util/kvm-stat.c b/tools/perf/arch/s390/util/kvm-stat.c
index a5dbc07..488a8c7 100644
--- a/tools/perf/arch/s390/util/kvm-stat.c
+++ b/tools/perf/arch/s390/util/kvm-stat.c
@@ -73,7 +73,7 @@ static struct kvm_events_ops exit_events = {
 	.name = "VM-EXIT"
 };
 
-const char * const kvm_events_tp[] = {
+const char *kvm_events_tp[] = {
 	"kvm:kvm_s390_sie_enter",
 	"kvm:kvm_s390_sie_exit",
 	"kvm:kvm_s390_intercept_instruction",
diff --git a/tools/perf/arch/x86/util/kvm-stat.c b/tools/perf/arch/x86/util/kvm-stat.c
index 14e4e66..11188d5 100644
--- a/tools/perf/arch/x86/util/kvm-stat.c
+++ b/tools/perf/arch/x86/util/kvm-stat.c
@@ -121,7 +121,7 @@ static struct kvm_events_ops ioport_events = {
 	.name = "IO Port Access"
 };
 
-const char * const kvm_events_tp[] = {
+const char *kvm_events_tp[] = {
 	"kvm:kvm_entry",
 	"kvm:kvm_exit",
 	"kvm:kvm_mmio",
diff --git a/tools/perf/util/kvm-stat.h b/tools/perf/util/kvm-stat.h
index ae825d4..6384672 100644
--- a/tools/perf/util/kvm-stat.h
+++ b/tools/perf/util/kvm-stat.h
@@ -133,7 +133,7 @@ bool kvm_entry_event(struct perf_evsel *evsel);
  */
 int cpu_isa_init(struct perf_kvm_stat *kvm, const char *cpuid);
 
-extern const char * const kvm_events_tp[];
+extern const char *kvm_events_tp[];
 extern struct kvm_reg_events_ops kvm_reg_events_ops[];
 extern const char * const kvm_skip_events[];
 
-- 
1.9.3
