Return-Path: <ravi.bangoria@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zVN7L4ZvyzDr5P
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 29 Jan 2018 19:33:02 +1100 (AEDT)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w0T8OFbZ011271
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 29 Jan 2018 03:33:00 -0500
Received: from e06smtp13.uk.ibm.com (e06smtp13.uk.ibm.com [195.75.94.109])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2fsx6tmtfd-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 29 Jan 2018 03:32:59 -0500
Received: from localhost
 by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ravi.bangoria@linux.vnet.ibm.com>;
 Mon, 29 Jan 2018 08:32:57 -0000
From: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
To: acme@kernel.org
Cc: alexander.shishkin@linux.intel.com, jolsa@redhat.com, namhyung@kernel.org,
 linux-kernel@vger.kernel.org, brueckner@linux.vnet.ibm.com,
 tmricht@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org,
 mpe@ellerman.id.au, Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
Subject: [PATCH 2/3] perf powerpc: Generate system call table from asm/unistd.h
Date: Mon, 29 Jan 2018 14:04:16 +0530
In-Reply-To: <20180129083417.31240-1-ravi.bangoria@linux.vnet.ibm.com>
References: <20180129083417.31240-1-ravi.bangoria@linux.vnet.ibm.com>
Message-Id: <20180129083417.31240-3-ravi.bangoria@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This should speed up accessing new system calls introduced with
the kernel rather than waiting for libaudit updates to include
them.

Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
---
 tools/perf/arch/powerpc/Makefile                   | 21 +++++++++++++
 .../perf/arch/powerpc/entry/syscalls/mksyscalltbl  | 35 ++++++++++++++++++++++
 2 files changed, 56 insertions(+)
 create mode 100755 tools/perf/arch/powerpc/entry/syscalls/mksyscalltbl

diff --git a/tools/perf/arch/powerpc/Makefile b/tools/perf/arch/powerpc/Makefile
index 42dab7c..c93e8f4 100644
--- a/tools/perf/arch/powerpc/Makefile
+++ b/tools/perf/arch/powerpc/Makefile
@@ -6,3 +6,24 @@ endif
 HAVE_KVM_STAT_SUPPORT := 1
 PERF_HAVE_ARCH_REGS_QUERY_REGISTER_OFFSET := 1
 PERF_HAVE_JITDUMP := 1
+
+#
+# Syscall table generation for perf
+#
+
+out    := $(OUTPUT)arch/powerpc/include/generated/asm
+header := $(out)/syscalls_64.c
+sysdef := $(srctree)/tools/arch/powerpc/include/uapi/asm/unistd.h
+sysprf := $(srctree)/tools/perf/arch/powerpc/entry/syscalls/
+systbl := $(sysprf)/mksyscalltbl
+
+# Create output directory if not already present
+_dummy := $(shell [ -d '$(out)' ] || mkdir -p '$(out)')
+
+$(header): $(sysdef) $(systbl)
+	$(Q)$(SHELL) '$(systbl)' '$(CC)' $(sysdef) > $@
+
+clean::
+	$(call QUIET_CLEAN, powerpc) $(RM) $(header)
+
+archheaders: $(header)
diff --git a/tools/perf/arch/powerpc/entry/syscalls/mksyscalltbl b/tools/perf/arch/powerpc/entry/syscalls/mksyscalltbl
new file mode 100755
index 0000000..975947c
--- /dev/null
+++ b/tools/perf/arch/powerpc/entry/syscalls/mksyscalltbl
@@ -0,0 +1,35 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+#
+# Generate system call table for perf. Derived from
+# s390 script.
+#
+# Copyright IBM Corp. 2017
+# Author(s):  Hendrik Brueckner <brueckner@linux.vnet.ibm.com>
+# Changed by: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
+
+gcc=$1
+input=$2
+
+if ! test -r $input; then
+	echo "Could not read input file" >&2
+	exit 1
+fi
+
+create_table()
+{
+	local max_nr
+
+	echo 'static const char *syscalltbl_powerpc_64[] = {'
+	while read sc nr; do
+		printf '\t[%d] = "%s",\n' $nr $sc
+		max_nr=$nr
+	done
+	echo '};'
+	echo "#define SYSCALLTBL_POWERPC_64_MAX_ID $max_nr"
+}
+
+$gcc -m64 -E -dM -x c  $input	       \
+	|sed -ne 's/^#define __NR_//p' \
+	|sort -t' ' -k2 -nu	       \
+	|create_table
-- 
1.8.3.1
