Return-Path: <naveen.n.rao@linux.vnet.ibm.com>
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qbMgN3rWFzDq6W
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 31 Mar 2016 22:27:28 +1100 (AEDT)
Received: from localhost
 by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Thu, 31 Mar 2016 21:27:27 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 4224A2BB0055
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 31 Mar 2016 22:27:25 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u2VBRGM54063576
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 31 Mar 2016 22:27:25 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u2VBQpJ8024838
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 31 Mar 2016 22:26:52 +1100
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Cc: Alexei Starovoitov <ast@fb.com>, "David S . Miller" <davem@davemloft.net>,
 Ananth N Mavinakayanahalli <ananth@in.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH 3/4] samples/bpf: Simplify building BPF samples
Date: Thu, 31 Mar 2016 16:55:43 +0530
Message-Id: <0ce1c8bdff478db55490a90db6732c4db9de6f22.1459423412.git.naveen.n.rao@linux.vnet.ibm.com>
In-Reply-To: <922f95fb5d16686367a66d2d4bd176149a87e9ad.1459423412.git.naveen.n.rao@linux.vnet.ibm.com>
References: <922f95fb5d16686367a66d2d4bd176149a87e9ad.1459423412.git.naveen.n.rao@linux.vnet.ibm.com>
In-Reply-To: <922f95fb5d16686367a66d2d4bd176149a87e9ad.1459423412.git.naveen.n.rao@linux.vnet.ibm.com>
References: <922f95fb5d16686367a66d2d4bd176149a87e9ad.1459423412.git.naveen.n.rao@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Make BPF samples build depend on CONFIG_SAMPLE_BPF. We still don't add a
Kconfig option since that will add a dependency on llvm for allyesconfig
builds which may not be desirable.

Those who need to build the BPF samples can now just do:

make CONFIG_SAMPLE_BPF=y

or:

export CONFIG_SAMPLE_BPF=y
make

Cc: Alexei Starovoitov <ast@fb.com>
Cc: David S. Miller <davem@davemloft.net>
Cc: Ananth N Mavinakayanahalli <ananth@in.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
---
 samples/Makefile     |  2 +-
 samples/bpf/Makefile | 39 ++++++++++++++++++++-------------------
 2 files changed, 21 insertions(+), 20 deletions(-)

diff --git a/samples/Makefile b/samples/Makefile
index 48001d7..3c77fc8 100644
--- a/samples/Makefile
+++ b/samples/Makefile
@@ -2,4 +2,4 @@
 
 obj-$(CONFIG_SAMPLES)	+= kobject/ kprobes/ trace_events/ livepatch/ \
 			   hw_breakpoint/ kfifo/ kdb/ hidraw/ rpmsg/ seccomp/ \
-			   configfs/
+			   configfs/ bpf/
diff --git a/samples/bpf/Makefile b/samples/bpf/Makefile
index 88bc5a0..bc5b675 100644
--- a/samples/bpf/Makefile
+++ b/samples/bpf/Makefile
@@ -2,23 +2,23 @@
 obj- := dummy.o
 
 # List of programs to build
-hostprogs-y := test_verifier test_maps
-hostprogs-y += sock_example
-hostprogs-y += fds_example
-hostprogs-y += sockex1
-hostprogs-y += sockex2
-hostprogs-y += sockex3
-hostprogs-y += tracex1
-hostprogs-y += tracex2
-hostprogs-y += tracex3
-hostprogs-y += tracex4
-hostprogs-y += tracex5
-hostprogs-y += tracex6
-hostprogs-y += trace_output
-hostprogs-y += lathist
-hostprogs-y += offwaketime
-hostprogs-y += spintest
-hostprogs-y += map_perf_test
+hostprogs-$(CONFIG_SAMPLE_BPF) := test_verifier test_maps
+hostprogs-$(CONFIG_SAMPLE_BPF) += sock_example
+hostprogs-$(CONFIG_SAMPLE_BPF) += fds_example
+hostprogs-$(CONFIG_SAMPLE_BPF) += sockex1
+hostprogs-$(CONFIG_SAMPLE_BPF) += sockex2
+hostprogs-$(CONFIG_SAMPLE_BPF) += sockex3
+hostprogs-$(CONFIG_SAMPLE_BPF) += tracex1
+hostprogs-$(CONFIG_SAMPLE_BPF) += tracex2
+hostprogs-$(CONFIG_SAMPLE_BPF) += tracex3
+hostprogs-$(CONFIG_SAMPLE_BPF) += tracex4
+hostprogs-$(CONFIG_SAMPLE_BPF) += tracex5
+hostprogs-$(CONFIG_SAMPLE_BPF) += tracex6
+hostprogs-$(CONFIG_SAMPLE_BPF) += trace_output
+hostprogs-$(CONFIG_SAMPLE_BPF) += lathist
+hostprogs-$(CONFIG_SAMPLE_BPF) += offwaketime
+hostprogs-$(CONFIG_SAMPLE_BPF) += spintest
+hostprogs-$(CONFIG_SAMPLE_BPF) += map_perf_test
 
 test_verifier-objs := test_verifier.o libbpf.o
 test_maps-objs := test_maps.o libbpf.o
@@ -39,8 +39,8 @@ offwaketime-objs := bpf_load.o libbpf.o offwaketime_user.o
 spintest-objs := bpf_load.o libbpf.o spintest_user.o
 map_perf_test-objs := bpf_load.o libbpf.o map_perf_test_user.o
 
-# Tell kbuild to always build the programs
-always := $(hostprogs-y)
+ifdef CONFIG_SAMPLE_BPF
+always := $(hostprogs-$(CONFIG_SAMPLE_BPF))
 always += sockex1_kern.o
 always += sockex2_kern.o
 always += sockex3_kern.o
@@ -56,6 +56,7 @@ always += lathist_kern.o
 always += offwaketime_kern.o
 always += spintest_kern.o
 always += map_perf_test_kern.o
+endif
 
 HOSTCFLAGS += -I$(objtree)/usr/include
 
-- 
2.7.4
