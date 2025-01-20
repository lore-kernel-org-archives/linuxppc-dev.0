Return-Path: <linuxppc-dev+bounces-5410-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88EC1C02181
	for <linuxppc-dev@archiver.kernel.org>; Mon, 20 Jan 2025 16:45:07 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YcGQc6b2Vz30H7;
	Tue, 21 Jan 2025 03:44:40 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1737391480;
	cv=none; b=IEDjtwzf0BgRWydS1dKHgtiUYZKCIZGZ4BMXjf5owCxsiPpwoRMXS6dx0GMnZqGUPBE01hv+HMOwfT2IRQPC5XCvUCn8gbeg71CJFSs8/dwmX0dz+MPFK6ks9EOHOikKu3jB4jkDUAxV8sncwGM4opVqDVmB9NM3Q8osO91goThCSBWx7Tg9Z5xu49dM2/ZAPRsmVWgqnmNF7cnEkEublxfRvRAre9Us3XlUsTtvTPxnpOtcaztq5oSJY5gALGDZ4IzEGasQiMHF4SGAg3B8sluN/zQTnLFvuXvpl/8RcZ1EHddDt+qX4gf1myC2/ZlJye/rtxBaKL3LvWPJYoL4Wg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1737391480; c=relaxed/relaxed;
	bh=hXd14BMu1Xt8zqO2XUDjftVp36kI58kCOz0K3Waa6K8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eF/ArxRHK3yjs0xGHYfz3v5Paklk5sU0EJk0Z8lfwdXOYFtFaAGKkjai8EuxbqXISNmosURItF4fe4TqheoI6ku5vYaMxP20c+gsu+lDO1XG6CY4ncKyz3BZ5EdUrcIF8NDcDoJz6FJ3/sq4+XMEO2J6notkOV2t+1qWCQRgfLVaxruBTrptt/par0+QvqNVleXeRE+BhAcSTPh/SLChXfu0P33P88EAaaQrB2w7FCEkX2/C6sdmurkVmlJLhFPAfwKVNJVz4NY1FYAcC2tse0cWr4JZ5nndG0Bzpi4t8K3bRJouYrJwzr5+DVTxK6GUazql8V1eSupfA5Eqk0vu8w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass (client-ip=217.140.110.172; helo=foss.arm.com; envelope-from=alexandru.elisei@arm.com; receiver=lists.ozlabs.org) smtp.mailfrom=arm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=arm.com (client-ip=217.140.110.172; helo=foss.arm.com; envelope-from=alexandru.elisei@arm.com; receiver=lists.ozlabs.org)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YcGQZ4j3Wz30MR
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Jan 2025 03:44:38 +1100 (AEDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3B32F1CE2;
	Mon, 20 Jan 2025 08:44:25 -0800 (PST)
Received: from localhost.localdomain (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 99F273F5A1;
	Mon, 20 Jan 2025 08:43:53 -0800 (PST)
From: Alexandru Elisei <alexandru.elisei@arm.com>
To: andrew.jones@linux.dev,
	eric.auger@redhat.com,
	lvivier@redhat.com,
	thuth@redhat.com,
	frankja@linux.ibm.com,
	imbrenda@linux.ibm.com,
	nrb@linux.ibm.com,
	david@redhat.com,
	pbonzini@redhat.com
Cc: kvm@vger.kernel.org,
	kvmarm@lists.linux.dev,
	linuxppc-dev@lists.ozlabs.org,
	kvm-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org,
	will@kernel.org,
	julien.thierry.kdev@gmail.com,
	maz@kernel.org,
	oliver.upton@linux.dev,
	suzuki.poulose@arm.com,
	yuzenghui@huawei.com,
	joey.gouly@arm.com,
	andre.przywara@arm.com
Subject: [kvm-unit-tests PATCH v2 07/18] scripts: Introduce kvmtool_opts
Date: Mon, 20 Jan 2025 16:43:05 +0000
Message-ID: <20250120164316.31473-8-alexandru.elisei@arm.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250120164316.31473-1-alexandru.elisei@arm.com>
References: <20250120164316.31473-1-alexandru.elisei@arm.com>
X-Mailing-List: linuxppc-dev@lists.ozlabs.org
List-Id: <linuxppc-dev.lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev+help@lists.ozlabs.org>
List-Owner: <mailto:linuxppc-dev+owner@lists.ozlabs.org>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>,
  <https://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Subscribe: <mailto:linuxppc-dev+subscribe@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-digest@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linuxppc-dev+unsubscribe@lists.ozlabs.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In preparation for supporting kvmtool, create and pass the variable
'kvmtool_opts' to the arch run script $RUNTIME_arch_run.

Signed-off-by: Alexandru Elisei <alexandru.elisei@arm.com>
---
 scripts/common.bash  |  6 ++++--
 scripts/runtime.bash | 14 +++++++++++---
 2 files changed, 15 insertions(+), 5 deletions(-)

diff --git a/scripts/common.bash b/scripts/common.bash
index a40c28121b6a..1b5e0d667841 100644
--- a/scripts/common.bash
+++ b/scripts/common.bash
@@ -37,6 +37,7 @@ function for_each_unittest()
 	local check
 	local accel
 	local timeout
+	local kvmtool_opts
 	local rematch
 
 	exec {fd}<"$unittests"
@@ -45,7 +46,7 @@ function for_each_unittest()
 		if [[ "$line" =~ ^\[(.*)\]$ ]]; then
 			rematch=${BASH_REMATCH[1]}
 			if [ -n "${testname}" ]; then
-				$(arch_cmd) "$cmd" "$testname" "$groups" "$smp" "$kernel" "$qemu_opts" "$arch" "$machine" "$check" "$accel" "$timeout"
+				$(arch_cmd) "$cmd" "$testname" "$groups" "$smp" "$kernel" "$qemu_opts" "$arch" "$machine" "$check" "$accel" "$timeout" "$kvmtool_opts"
 			fi
 			testname=$rematch
 			smp=1
@@ -57,6 +58,7 @@ function for_each_unittest()
 			check=""
 			accel=""
 			timeout=""
+			kvmtool_opts=""
 		elif [[ $line =~ ^file\ *=\ *(.*)$ ]]; then
 			kernel=$TEST_DIR/${BASH_REMATCH[1]}
 		elif [[ $line =~ ^smp\ *=\ *(.*)$ ]]; then
@@ -80,7 +82,7 @@ function for_each_unittest()
 		fi
 	done
 	if [ -n "${testname}" ]; then
-		$(arch_cmd) "$cmd" "$testname" "$groups" "$smp" "$kernel" "$qemu_opts" "$arch" "$machine" "$check" "$accel" "$timeout"
+		$(arch_cmd) "$cmd" "$testname" "$groups" "$smp" "$kernel" "$qemu_opts" "$arch" "$machine" "$check" "$accel" "$timeout" "$kvmtool_opts"
 	fi
 	exec {fd}<&-
 }
diff --git a/scripts/runtime.bash b/scripts/runtime.bash
index a89f2d10ab78..451b5585f010 100644
--- a/scripts/runtime.bash
+++ b/scripts/runtime.bash
@@ -35,7 +35,7 @@ get_cmdline()
 {
     local kernel=$1
 
-    echo "TESTNAME=$testname TIMEOUT=$timeout MACHINE=$machine ACCEL=$accel $RUNTIME_arch_run $kernel $qemu_opts"
+    echo "TESTNAME=$testname TIMEOUT=$timeout MACHINE=$machine ACCEL=$accel $RUNTIME_arch_run $kernel $opts"
 }
 
 skip_nodefault()
@@ -87,8 +87,16 @@ function run()
     local check="${CHECK:-$8}"
     local accel="$9"
     local timeout="${10:-$TIMEOUT}" # unittests.cfg overrides the default
-
-    qemu_opts="-smp $smp $qemu_opts"
+    local kvmtool_opts="${11}"
+
+    case "$TARGET" in
+    qemu)
+        opts="-smp $smp $qemu_opts"
+        ;;
+    kvmtool)
+        opts="--cpus $smp $kvmtool_opts"
+        ;;
+    esac
 
     if [ "${CONFIG_EFI}" == "y" ]; then
         kernel=${kernel/%.flat/.efi}
-- 
2.47.1


