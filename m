Return-Path: <boqun.feng@gmail.com>
Received: from mail-io0-x242.google.com (mail-io0-x242.google.com
 [IPv6:2607:f8b0:4001:c06::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3r9GzP1SYNzDqNX
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 May 2016 13:40:01 +1000 (AEST)
Received: by mail-io0-x242.google.com with SMTP id i75so12975168ioa.2
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 May 2016 20:40:01 -0700 (PDT)
From: Boqun Feng <boqun.feng@gmail.com>
To: linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org
Cc: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
 Josh Triplett <josh@joshtriplett.org>,
 Steven Rostedt <rostedt@goodmis.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Lai Jiangshan <jiangshanlai@gmail.com>, Boqun Feng <boqun.feng@gmail.com>
Subject: [PATCH 4/4] rcutorture: Don't specify the cpu type of QEMU on PPC
Date: Thu, 19 May 2016 11:42:24 +0800
Message-Id: <1463629344-20471-5-git-send-email-boqun.feng@gmail.com>
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

Do not restrict the cpu type to POWER7 for QEMU as we have POWER8 now.

Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
---
 tools/testing/selftests/rcutorture/bin/functions.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/rcutorture/bin/functions.sh b/tools/testing/selftests/rcutorture/bin/functions.sh
index 77fdb46cc65a..56ac202859eb 100644
--- a/tools/testing/selftests/rcutorture/bin/functions.sh
+++ b/tools/testing/selftests/rcutorture/bin/functions.sh
@@ -174,7 +174,7 @@ identify_qemu_args () {
 		echo -soundhw pcspk
 		;;
 	qemu-system-ppc64)
-		echo -enable-kvm -M pseries -cpu POWER7 -nodefaults
+		echo -enable-kvm -M pseries -nodefaults
 		echo -device spapr-vscsi
 		if test -n "$TORTURE_QEMU_INTERACTIVE" -a -n "$TORTURE_QEMU_MAC"
 		then
-- 
2.8.0
