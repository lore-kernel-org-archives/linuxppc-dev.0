Return-Path: <imunsie@au1.ibm.com>
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp04.au.ibm.com",
	Issuer "GeoTrust SSL CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 63937B711A
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu,  3 Feb 2011 14:27:42 +1100 (EST)
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [202.81.31.245])
	by e23smtp04.au.ibm.com (8.14.4/8.13.1) with ESMTP id p133MK2d024882
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 3 Feb 2011 14:22:20 +1100
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
	by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	p133Rfj02134066
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 3 Feb 2011 14:27:41 +1100
Received: from d23av03.au.ibm.com (loopback [127.0.0.1])
	by d23av03.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	p133Rejq008990
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 3 Feb 2011 14:27:41 +1100
From: "Ian Munsie" <imunsie@au1.ibm.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 2/6] ftrace syscalls: Convert redundant syscall_nr checks into
	WARN_ON
Date: Thu,  3 Feb 2011 14:27:21 +1100
Message-Id: <1296703645-18718-3-git-send-email-imunsie@au1.ibm.com>
In-Reply-To: <1296703645-18718-1-git-send-email-imunsie@au1.ibm.com>
References: <1296703645-18718-1-git-send-email-imunsie@au1.ibm.com>
Cc: Andreas Dilger <adilger@dilger.ca>, Andreas Schwab <schwab@linux-m68k.org>,
	Dave Kleikamp <shaggy@linux.vnet.ibm.com>,
	Namhyung Kim <namhyung@gmail.com>, Jiri Kosina <jkosina@suse.cz>,
	Jason Baron <jbaron@redhat.com>, Alexander Graf <agraf@suse.de>,
	Steven Rostedt <rostedt@goodmis.org>,
	David Gibson <dwg@au1.ibm.com>, Ingo Molnar <mingo@redhat.com>,
	Paul Mackerras <paulus@samba.org>, Ian Munsie <imunsie@au1.ibm.com>,
	KOSAKI Motohiro <kosaki.motohiro@jp.fujitsu.com>,
	Frederic Weisbecker <fweisbec@gmail.com>,
	Scott Wood <scottwood@freescale.com>, Nathan Lynch <ntl@pobox.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
	Avantika Mathur <mathur@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Ian Munsie <imunsie@au1.ibm.com>

With the ftrace events now checking if the syscall_nr is valid upon
initialisation it should no longer be possible to register or unregister
a syscall event without a valid syscall_nr since they should not be
created. This adds a WARN_ON_ONCE in the register and unregister
functions to locate potential regressions in the future.

Signed-off-by: Ian Munsie <imunsie@au1.ibm.com>
---
 kernel/trace/trace_syscalls.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/trace/trace_syscalls.c b/kernel/trace/trace_syscalls.c
index a66bc13..1a6e8dd 100644
--- a/kernel/trace/trace_syscalls.c
+++ b/kernel/trace/trace_syscalls.c
@@ -358,7 +358,7 @@ int reg_event_syscall_enter(struct ftrace_event_call *call)
 	int num;
 
 	num = ((struct syscall_metadata *)call->data)->syscall_nr;
-	if (num < 0 || num >= NR_syscalls)
+	if (WARN_ON_ONCE(num < 0 || num >= NR_syscalls))
 		return -ENOSYS;
 	mutex_lock(&syscall_trace_lock);
 	if (!sys_refcount_enter)
@@ -376,7 +376,7 @@ void unreg_event_syscall_enter(struct ftrace_event_call *call)
 	int num;
 
 	num = ((struct syscall_metadata *)call->data)->syscall_nr;
-	if (num < 0 || num >= NR_syscalls)
+	if (WARN_ON_ONCE(num < 0 || num >= NR_syscalls))
 		return;
 	mutex_lock(&syscall_trace_lock);
 	sys_refcount_enter--;
@@ -392,7 +392,7 @@ int reg_event_syscall_exit(struct ftrace_event_call *call)
 	int num;
 
 	num = ((struct syscall_metadata *)call->data)->syscall_nr;
-	if (num < 0 || num >= NR_syscalls)
+	if (WARN_ON_ONCE(num < 0 || num >= NR_syscalls))
 		return -ENOSYS;
 	mutex_lock(&syscall_trace_lock);
 	if (!sys_refcount_exit)
@@ -410,7 +410,7 @@ void unreg_event_syscall_exit(struct ftrace_event_call *call)
 	int num;
 
 	num = ((struct syscall_metadata *)call->data)->syscall_nr;
-	if (num < 0 || num >= NR_syscalls)
+	if (WARN_ON_ONCE(num < 0 || num >= NR_syscalls))
 		return;
 	mutex_lock(&syscall_trace_lock);
 	sys_refcount_exit--;
-- 
1.7.2.3
