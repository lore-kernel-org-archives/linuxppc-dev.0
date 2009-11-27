Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [213.79.90.228])
	by ozlabs.org (Postfix) with ESMTP id CCC1D1009C5
	for <linuxppc-dev@ozlabs.org>; Sat, 28 Nov 2009 09:33:45 +1100 (EST)
Date: Sat, 28 Nov 2009 01:33:44 +0300
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: systemtap@sourceware.org
Subject: [PATCH 4/8] Implement ppc32 variant of __is_user_regs
Message-ID: <20091127223344.GD21805@oksana.dev.rtsoft.ru>
References: <20091127223251.GA17065@oksana.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20091127223251.GA17065@oksana.dev.rtsoft.ru>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

* tapset/nd_syscalls.stp: Implement ppc32 variant of __is_user_regs.
* tapset/syscalls.stp: Ditto.

Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
---
 tapset/nd_syscalls.stp |    3 +++
 tapset/syscalls.stp    |    3 +++
 2 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/tapset/nd_syscalls.stp b/tapset/nd_syscalls.stp
index f9a6ffc..e7492a1 100644
--- a/tapset/nd_syscalls.stp
+++ b/tapset/nd_syscalls.stp
@@ -1320,6 +1320,9 @@ function __is_user_regs:long (regs:long)
 #elif defined(__powerpc64__)
 	unsigned long msr = kread(&regs->msr);
 	THIS->__retvalue = ((msr >> MSR_PR_LG) & 0x1);
+#elif defined(__powerpc__)
+	unsigned long msr = kread(&regs->msr);
+	THIS->__retvalue = ((msr >> MSR_PR) != 0);
 #elif defined(__arm__)
 	long cpsr = kread(&regs->ARM_cpsr);
 	THIS->__retvalue = ((cpsr & 0xf) == 0);
diff --git a/tapset/syscalls.stp b/tapset/syscalls.stp
index dde0ca9..430d37f 100644
--- a/tapset/syscalls.stp
+++ b/tapset/syscalls.stp
@@ -1093,6 +1093,9 @@ function __is_user_regs:long (regs:long)
 #elif defined(__powerpc64__)
 	unsigned long msr = kread(&regs->msr);
 	THIS->__retvalue = ((msr >> MSR_PR_LG) & 0x1);
+#elif defined(__powerpc__)
+	unsigned long msr = kread(&regs->msr);
+	THIS->__retvalue = ((msr >> MSR_PR) != 0);
 #elif defined(__arm__)
 	long cpsr = kread(&regs->ARM_cpsr);
 	THIS->__retvalue = ((cpsr & 0xf) == 0);
-- 
1.6.3.3
