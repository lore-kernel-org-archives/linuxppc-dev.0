Return-Path: <hemant@linux.vnet.ibm.com>
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 10F751A005A
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  7 Oct 2015 13:26:25 +1100 (AEDT)
Received: from /spool/local
 by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <hemant@linux.vnet.ibm.com>;
 Wed, 7 Oct 2015 12:26:23 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 8D40C3578053
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  7 Oct 2015 13:26:22 +1100 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t972QFRW65208390
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 7 Oct 2015 13:26:24 +1100
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t972Pnb4016271
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 7 Oct 2015 13:25:50 +1100
From: Hemant Kumar <hemant@linux.vnet.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: linuxppc-dev@lists.ozlabs.org, acme@kernel.org, scottwood@freescale.com,
 sukadev@linux.vnet.ibm.com, naveen.n.rao@linux.vnet.ibm.com,
 mpe@ellerman.id.au, paulus@samba.org, mingo@redhat.com,
 yarygin@linux.vnet.ibm.com, borntraeger@de.ibm.com,
 srikar@linux.vnet.ibm.com, dsahern@gmail.com, hemant@linux.vnet.ibm.com
Subject: [PATCH v9 2/4] perf,kvm/{x86,s390}: Remove const from kvm_events_tp
Date: Wed,  7 Oct 2015 07:55:09 +0530
Message-Id: <1444184711-8559-2-git-send-email-hemant@linux.vnet.ibm.com>
In-Reply-To: <1444184711-8559-1-git-send-email-hemant@linux.vnet.ibm.com>
References: <1444184711-8559-1-git-send-email-hemant@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch removes the "const" qualifier from kvm_events_tp declaration
to account for the fact that some architectures may need to update this
variable dynamically. For instance, powerpc will need to update this
variable dynamically depending on the machine type.

Signed-off-by: Hemant Kumar <hemant@linux.vnet.ibm.com>
---
 tools/perf/arch/s390/util/kvm-stat.c | 2 +-
 tools/perf/arch/x86/util/kvm-stat.c  | 2 +-
 tools/perf/util/kvm-stat.h           | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/perf/arch/s390/util/kvm-stat.c b/tools/perf/arch/s390/util/kvm-stat.c
index b85a94b..ed57df2 100644
--- a/tools/perf/arch/s390/util/kvm-stat.c
+++ b/tools/perf/arch/s390/util/kvm-stat.c
@@ -79,7 +79,7 @@ static struct kvm_events_ops exit_events = {
 	.name = "VM-EXIT"
 };
 
-const char * const kvm_events_tp[] = {
+const char *kvm_events_tp[] = {
 	"kvm:kvm_s390_sie_enter",
 	"kvm:kvm_s390_sie_exit",
 	"kvm:kvm_s390_intercept_instruction",
diff --git a/tools/perf/arch/x86/util/kvm-stat.c b/tools/perf/arch/x86/util/kvm-stat.c
index babefda..b63d4be 100644
--- a/tools/perf/arch/x86/util/kvm-stat.c
+++ b/tools/perf/arch/x86/util/kvm-stat.c
@@ -129,7 +129,7 @@ static struct kvm_events_ops ioport_events = {
 	.name = "IO Port Access"
 };
 
-const char * const kvm_events_tp[] = {
+const char *kvm_events_tp[] = {
 	"kvm:kvm_entry",
 	"kvm:kvm_exit",
 	"kvm:kvm_mmio",
diff --git a/tools/perf/util/kvm-stat.h b/tools/perf/util/kvm-stat.h
index dd55548..c965dc8 100644
--- a/tools/perf/util/kvm-stat.h
+++ b/tools/perf/util/kvm-stat.h
@@ -133,7 +133,7 @@ bool kvm_entry_event(struct perf_evsel *evsel);
  */
 int cpu_isa_init(struct perf_kvm_stat *kvm, const char *cpuid);
 
-extern const char * const kvm_events_tp[];
+extern const char *kvm_events_tp[];
 extern struct kvm_reg_events_ops kvm_reg_events_ops[];
 extern const char * const kvm_skip_events[];
 extern const char *vcpu_id_str;
-- 
1.9.3
