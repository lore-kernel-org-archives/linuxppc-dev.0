Return-Path: <khandual@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id E21591A0CDD
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Jan 2015 18:09:50 +1100 (AEDT)
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 7AF1A140280
 for <linuxppc-dev@ozlabs.org>; Wed, 14 Jan 2015 18:09:50 +1100 (AEDT)
Received: from /spool/local
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Wed, 14 Jan 2015 17:09:49 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 9A29C2BB003F
 for <linuxppc-dev@ozlabs.org>; Wed, 14 Jan 2015 18:09:47 +1100 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t0E79kEJ50004094
 for <linuxppc-dev@ozlabs.org>; Wed, 14 Jan 2015 18:09:47 +1100
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t0E79h62006685
 for <linuxppc-dev@ozlabs.org>; Wed, 14 Jan 2015 18:09:46 +1100
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
To: linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org
Subject: [PATCH V7 8/8] selftests: Make GIT ignore all binaries in powerpc
 test suite
Date: Wed, 14 Jan 2015 12:38:50 +0530
Message-Id: <1421219330-19984-9-git-send-email-khandual@linux.vnet.ibm.com>
In-Reply-To: <1421219330-19984-1-git-send-email-khandual@linux.vnet.ibm.com>
References: <1421219330-19984-1-git-send-email-khandual@linux.vnet.ibm.com>
Cc: shuahkh@osg.samsung.com, mikey@neuling.org, james.hogan@imgtec.com,
 avagin@openvz.org, Paul.Clothier@imgtec.com, peterz@infradead.org,
 palves@redhat.com, oleg@redhat.com, davem@davemloft.net, dhowells@redhat.com,
 kirjanov@gmail.com, davej@redhat.com, akpm@linux-foundation.org,
 sukadev@linux.vnet.ibm.com, tglx@linutronix.de, sam.bobroff@au1.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch includes all of the powerpc test binaries into the
.gitignore file listing in their respective directories. This
will make sure that GIT ignores all of these test binaries while
displaying status.

Signed-off-by: Anshuman Khandual <khandual@linux.vnet.ibm.com>
---
NOTE: As Michael had mentioned (https://lkml.org/lkml/2015/1/13/868)
adding binaries into different .gitignore file in their respective
test directories under powerpc.

 .../testing/selftests/powerpc/copyloops/.gitignore |  4 ++++
 tools/testing/selftests/powerpc/mm/.gitignore      |  1 +
 tools/testing/selftests/powerpc/pmu/.gitignore     |  3 +++
 tools/testing/selftests/powerpc/pmu/ebb/.gitignore | 22 ++++++++++++++++++++++
 .../selftests/powerpc/primitives/.gitignore        |  1 +
 tools/testing/selftests/powerpc/tm/.gitignore      |  2 ++
 6 files changed, 33 insertions(+)
 create mode 100644 tools/testing/selftests/powerpc/copyloops/.gitignore
 create mode 100644 tools/testing/selftests/powerpc/mm/.gitignore
 create mode 100644 tools/testing/selftests/powerpc/pmu/.gitignore
 create mode 100644 tools/testing/selftests/powerpc/pmu/ebb/.gitignore
 create mode 100644 tools/testing/selftests/powerpc/primitives/.gitignore
 create mode 100644 tools/testing/selftests/powerpc/tm/.gitignore

diff --git a/tools/testing/selftests/powerpc/copyloops/.gitignore b/tools/testing/selftests/powerpc/copyloops/.gitignore
new file mode 100644
index 0000000..25a192f
--- /dev/null
+++ b/tools/testing/selftests/powerpc/copyloops/.gitignore
@@ -0,0 +1,4 @@
+copyuser_64
+copyuser_power7
+memcpy_64
+memcpy_power7
diff --git a/tools/testing/selftests/powerpc/mm/.gitignore b/tools/testing/selftests/powerpc/mm/.gitignore
new file mode 100644
index 0000000..156f4e8
--- /dev/null
+++ b/tools/testing/selftests/powerpc/mm/.gitignore
@@ -0,0 +1 @@
+hugetlb_vs_thp_test
diff --git a/tools/testing/selftests/powerpc/pmu/.gitignore b/tools/testing/selftests/powerpc/pmu/.gitignore
new file mode 100644
index 0000000..e748f33
--- /dev/null
+++ b/tools/testing/selftests/powerpc/pmu/.gitignore
@@ -0,0 +1,3 @@
+count_instructions
+l3_bank_test
+per_event_excludes
diff --git a/tools/testing/selftests/powerpc/pmu/ebb/.gitignore b/tools/testing/selftests/powerpc/pmu/ebb/.gitignore
new file mode 100644
index 0000000..42bddbe
--- /dev/null
+++ b/tools/testing/selftests/powerpc/pmu/ebb/.gitignore
@@ -0,0 +1,22 @@
+reg_access_test
+event_attributes_test
+cycles_test
+cycles_with_freeze_test
+pmc56_overflow_test
+ebb_vs_cpu_event_test
+cpu_event_vs_ebb_test
+cpu_event_pinned_vs_ebb_test
+task_event_vs_ebb_test
+task_event_pinned_vs_ebb_test
+multi_ebb_procs_test
+multi_counter_test
+pmae_handling_test
+close_clears_pmcc_test
+instruction_count_test
+fork_cleanup_test
+ebb_on_child_test
+ebb_on_willing_child_test
+back_to_back_ebbs_test
+lost_exception_test
+no_handler_test
+cycles_with_mmcr2_test
diff --git a/tools/testing/selftests/powerpc/primitives/.gitignore b/tools/testing/selftests/powerpc/primitives/.gitignore
new file mode 100644
index 0000000..4cc4e31
--- /dev/null
+++ b/tools/testing/selftests/powerpc/primitives/.gitignore
@@ -0,0 +1 @@
+load_unaligned_zeropad
diff --git a/tools/testing/selftests/powerpc/tm/.gitignore b/tools/testing/selftests/powerpc/tm/.gitignore
new file mode 100644
index 0000000..71f9f9d
--- /dev/null
+++ b/tools/testing/selftests/powerpc/tm/.gitignore
@@ -0,0 +1,2 @@
+tm-ptrace
+tm-resched-dscr
-- 
1.9.3
