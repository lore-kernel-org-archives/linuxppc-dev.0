Return-Path: <BATV+f69834103652f40a0a8f+4541+infradead.org+acme@casper.srs.infradead.org>
Received: from casper.infradead.org (casper.infradead.org
 [IPv6:2001:770:15f::2])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3561B1A01C4
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 30 Jan 2016 08:18:17 +1100 (AEDT)
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, Hemant Kumar <hemant@linux.vnet.ibm.com>,
 Alexander Yarygin <yarygin@linux.vnet.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>,
 "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
 Paul Mackerras <paulus@samba.org>, Scott  Wood <scottwood@freescale.com>,
 Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 13/16] perf kvm/{x86,s390}: Remove const from kvm_events_tp
Date: Fri, 29 Jan 2016 18:17:50 -0300
Message-Id: <1454102273-16431-14-git-send-email-acme@kernel.org>
In-Reply-To: <1454102273-16431-1-git-send-email-acme@kernel.org>
References: <1454102273-16431-1-git-send-email-acme@kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

See http://www.infradead.org/rpr.html

From: Hemant Kumar <hemant@linux.vnet.ibm.com>

This patch removes the "const" qualifier from kvm_events_tp declaration
to account for the fact that some architectures may need to update this
variable dynamically. For instance, powerpc will need to update this
variable dynamically depending on the machine type.

Signed-off-by: Hemant Kumar <hemant@linux.vnet.ibm.com>
Acked-by: David Ahern <dsahern@gmail.com>
Cc: Alexander Yarygin <yarygin@linux.vnet.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Scott  Wood <scottwood@freescale.com>
Cc: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org
Link: http://lkml.kernel.org/r/1453962787-15376-2-git-send-email-hemant@linux.vnet.ibm.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/arch/s390/util/kvm-stat.c | 2 +-
 tools/perf/arch/x86/util/kvm-stat.c  | 2 +-
 tools/perf/util/kvm-stat.h           | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/perf/arch/s390/util/kvm-stat.c b/tools/perf/arch/s390/util/kvm-stat.c
index b85a94b19c25..ed57df2e6d68 100644
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
index babefda4c862..b63d4be655a2 100644
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
index dd55548ef66a..c965dc844df3 100644
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
2.5.0
