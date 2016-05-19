Return-Path: <boqun.feng@gmail.com>
Received: from mail-io0-x242.google.com (mail-io0-x242.google.com
 [IPv6:2607:f8b0:4001:c06::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3r9GzJ0BXzzDqLj
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 May 2016 13:39:56 +1000 (AEST)
Received: by mail-io0-x242.google.com with SMTP id i75so12974964ioa.2
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 May 2016 20:39:55 -0700 (PDT)
From: Boqun Feng <boqun.feng@gmail.com>
To: linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org
Cc: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
 Josh Triplett <josh@joshtriplett.org>,
 Steven Rostedt <rostedt@goodmis.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Lai Jiangshan <jiangshanlai@gmail.com>, Boqun Feng <boqun.feng@gmail.com>
Subject: [PATCH 3/4] rcutorture: Make -soundhw a x86 specific option
Date: Thu, 19 May 2016 11:42:23 +0800
Message-Id: <1463629344-20471-4-git-send-email-boqun.feng@gmail.com>
In-Reply-To: <1463629344-20471-1-git-send-email-boqun.feng@gmail.com>
References: <1463629344-20471-1-git-send-email-boqun.feng@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The option "-soundhw pcspk" gives me a error on PPC as follow:

qemu-system-ppc64: ISA bus not available for pcspk

, which means this option doesn't work on ppc by default. So simply make
this an x86-specific option via identify_qemu_args().

Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
---
 tools/testing/selftests/rcutorture/bin/functions.sh      | 1 +
 tools/testing/selftests/rcutorture/bin/kvm-test-1-run.sh | 8 ++++----
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/rcutorture/bin/functions.sh b/tools/testing/selftests/rcutorture/bin/functions.sh
index 616180153208..77fdb46cc65a 100644
--- a/tools/testing/selftests/rcutorture/bin/functions.sh
+++ b/tools/testing/selftests/rcutorture/bin/functions.sh
@@ -171,6 +171,7 @@ identify_qemu_append () {
 identify_qemu_args () {
 	case "$1" in
 	qemu-system-x86_64|qemu-system-i386)
+		echo -soundhw pcspk
 		;;
 	qemu-system-ppc64)
 		echo -enable-kvm -M pseries -cpu POWER7 -nodefaults
diff --git a/tools/testing/selftests/rcutorture/bin/kvm-test-1-run.sh b/tools/testing/selftests/rcutorture/bin/kvm-test-1-run.sh
index 46cb6bc098bd..d7a3de26dd11 100755
--- a/tools/testing/selftests/rcutorture/bin/kvm-test-1-run.sh
+++ b/tools/testing/selftests/rcutorture/bin/kvm-test-1-run.sh
@@ -8,9 +8,9 @@
 #
 # Usage: kvm-test-1-run.sh config builddir resdir seconds qemu-args boot_args
 #
-# qemu-args defaults to "-enable-kvm -soundhw pcspk -nographic", along with
-#			arguments specifying the number of CPUs and other
-#			options generated from the underlying CPU architecture.
+# qemu-args defaults to "-enable-kvm -nographic", along with arguments
+#			specifying the number of CPUs and other options
+#			generated from the underlying CPU architecture.
 # boot_args defaults to value returned by the per_version_boot_params
 #			shell function.
 #
@@ -148,7 +148,7 @@ then
 fi
 
 # Generate -smp qemu argument.
-qemu_args="-enable-kvm -soundhw pcspk -nographic $qemu_args"
+qemu_args="-enable-kvm -nographic $qemu_args"
 cpu_count=`configNR_CPUS.sh $config_template`
 cpu_count=`configfrag_boot_cpus "$boot_args" "$config_template" "$cpu_count"`
 vcpus=`identify_qemu_vcpus`
-- 
2.8.0
