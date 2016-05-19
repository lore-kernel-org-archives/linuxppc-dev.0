Return-Path: <boqun.feng@gmail.com>
Received: from mail-ig0-x241.google.com (mail-ig0-x241.google.com
 [IPv6:2607:f8b0:4001:c05::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3r9GzC3L66zDqM1
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 May 2016 13:39:51 +1000 (AEST)
Received: by mail-ig0-x241.google.com with SMTP id jn6so6360011igb.2
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 May 2016 20:39:51 -0700 (PDT)
From: Boqun Feng <boqun.feng@gmail.com>
To: linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org
Cc: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
 Josh Triplett <josh@joshtriplett.org>,
 Steven Rostedt <rostedt@goodmis.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Lai Jiangshan <jiangshanlai@gmail.com>, Boqun Feng <boqun.feng@gmail.com>
Subject: [PATCH 2/4] rcutorture: Use vmlinux as the fallback kernel image
Date: Thu, 19 May 2016 11:42:22 +0800
Message-Id: <1463629344-20471-3-git-send-email-boqun.feng@gmail.com>
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

vmlinux is available for all the architectures, and suitable for running
a KVM guest by QEMU, besides, we used to copy the vmlinux to $resdir
anyway. Therefore it makes sense to use it as the fallback kernel image
for rcutorture KVM tests.

This patch makes identify_boot_image() return vmlinux if
${TORTURE_BOOT_IMAGE} is not set on non-x86 architectures, also fixes
several places that hard-code "bzImage" as $KERNEL.

This also fixes a problem that PPC doesn't have a bzImage file as build
results.

Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
---
 tools/testing/selftests/rcutorture/bin/functions.sh      | 10 ++++------
 tools/testing/selftests/rcutorture/bin/kvm-test-1-run.sh |  5 +++--
 2 files changed, 7 insertions(+), 8 deletions(-)

diff --git a/tools/testing/selftests/rcutorture/bin/functions.sh b/tools/testing/selftests/rcutorture/bin/functions.sh
index b325470c01b3..616180153208 100644
--- a/tools/testing/selftests/rcutorture/bin/functions.sh
+++ b/tools/testing/selftests/rcutorture/bin/functions.sh
@@ -99,8 +99,9 @@ configfrag_hotplug_cpu () {
 # identify_boot_image qemu-cmd
 #
 # Returns the relative path to the kernel build image.  This will be
-# arch/<arch>/boot/bzImage unless overridden with the TORTURE_BOOT_IMAGE
-# environment variable.
+# arch/<arch>/boot/bzImage or vmlinux if bzImage is not a target for the
+# architecture, unless overridden with the TORTURE_BOOT_IMAGE environment
+# variable.
 identify_boot_image () {
 	if test -n "$TORTURE_BOOT_IMAGE"
 	then
@@ -110,11 +111,8 @@ identify_boot_image () {
 		qemu-system-x86_64|qemu-system-i386)
 			echo arch/x86/boot/bzImage
 			;;
-		qemu-system-ppc64)
-			echo arch/powerpc/boot/bzImage
-			;;
 		*)
-			echo ""
+			echo vmlinux
 			;;
 		esac
 	fi
diff --git a/tools/testing/selftests/rcutorture/bin/kvm-test-1-run.sh b/tools/testing/selftests/rcutorture/bin/kvm-test-1-run.sh
index 4109f306d855..46cb6bc098bd 100755
--- a/tools/testing/selftests/rcutorture/bin/kvm-test-1-run.sh
+++ b/tools/testing/selftests/rcutorture/bin/kvm-test-1-run.sh
@@ -96,7 +96,8 @@ if test "$base_resdir" != "$resdir" -a -f $base_resdir/bzImage -a -f $base_resdi
 then
 	# Rerunning previous test, so use that test's kernel.
 	QEMU="`identify_qemu $base_resdir/vmlinux`"
-	KERNEL=$base_resdir/bzImage
+	BOOT_IMAGE="`identify_boot_image $QEMU`"
+	KERNEL=$base_resdir/${BOOT_IMAGE##*/} # use the last component of ${BOOT_IMAGE}
 	ln -s $base_resdir/Make*.out $resdir  # for kvm-recheck.sh
 	ln -s $base_resdir/.config $resdir  # for kvm-recheck.sh
 elif kvm-build.sh $config_template $builddir $T
@@ -110,7 +111,7 @@ then
 	if test -n "$BOOT_IMAGE"
 	then
 		cp $builddir/$BOOT_IMAGE $resdir
-		KERNEL=$resdir/bzImage
+		KERNEL=$resdir/${BOOT_IMAGE##*/}
 	else
 		echo No identifiable boot image, not running KVM, see $resdir.
 		echo Do the torture scripts know about your architecture?
-- 
2.8.0
