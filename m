Return-Path: <imunsie@au1.ibm.com>
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp09.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 5C0A7B7366
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Jun 2010 20:04:34 +1000 (EST)
Received: from d23relay04.au.ibm.com (d23relay04.au.ibm.com [202.81.31.246])
	by e23smtp09.au.ibm.com (8.14.4/8.13.1) with ESMTP id o5NA4UHZ025291
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Jun 2010 20:04:30 +1000
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
	by d23relay04.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o5NA4XOY1552638
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Jun 2010 20:04:33 +1000
Received: from d23av03.au.ibm.com (loopback [127.0.0.1])
	by d23av03.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	o5NA4VUh028265
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Jun 2010 20:04:33 +1000
From: "Ian Munsie" <imunsie@au1.ibm.com>
To: linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org
Subject: [PATCH 30/40] trace syscalls: Convert remaining kernel/compat.c
	syscalls to COMPAT_SYSCALL_DEFINE
Date: Wed, 23 Jun 2010 20:03:11 +1000
Message-Id: <1277287401-28571-31-git-send-email-imunsie@au1.ibm.com>
In-Reply-To: <1277287401-28571-1-git-send-email-imunsie@au1.ibm.com>
References: <1277287401-28571-1-git-send-email-imunsie@au1.ibm.com>
Cc: Frederic Weisbecker <fweisbec@gmail.com>, Jason Baron <jbaron@redhat.com>,
	Rusty Russell <rusty@rustcorp.com.au>,
	Steven Rostedt <rostedt@goodmis.org>, Ingo Molnar <mingo@redhat.com>,
	Paul Mackerras <paulus@samba.org>, Ian Munsie <imunsie@au1.ibm.com>,
	KOSAKI Motohiro <kosaki.motohiro@jp.fujitsu.com>, Tejun Heo <tj@kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Ian Munsie <imunsie@au1.ibm.com>

This patch converts the remaining system calls from kernel/compat.c to
use the COMPAT_SYSCALL_DEFINE family of macros.

The particular system calls in question did not originally have the
asmlinkage tag which will be added by this conversion.

Signed-off-by: Ian Munsie <imunsie@au1.ibm.com>
---
 kernel/compat.c |   34 +++++++++++++++++-----------------
 1 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/kernel/compat.c b/kernel/compat.c
index 7ab99e1..81762e4 100644
--- a/kernel/compat.c
+++ b/kernel/compat.c
@@ -535,9 +535,9 @@ int put_compat_itimerspec(struct compat_itimerspec __user *dst,
 	return 0;
 }
 
-long compat_sys_timer_create(clockid_t which_clock,
-			struct compat_sigevent __user *timer_event_spec,
-			timer_t __user *created_timer_id)
+COMPAT_SYSCALL_DEFINE3(timer_create, clockid_t, which_clock,
+			struct compat_sigevent __user *, timer_event_spec,
+			timer_t __user *, created_timer_id)
 {
 	struct sigevent __user *event = NULL;
 
@@ -553,9 +553,9 @@ long compat_sys_timer_create(clockid_t which_clock,
 	return sys_timer_create(which_clock, event, created_timer_id);
 }
 
-long compat_sys_timer_settime(timer_t timer_id, int flags,
-			  struct compat_itimerspec __user *new,
-			  struct compat_itimerspec __user *old)
+COMPAT_SYSCALL_DEFINE4(timer_settime, timer_t, timer_id, int, flags,
+			  struct compat_itimerspec __user *, new,
+			  struct compat_itimerspec __user *, old)
 {
 	long err;
 	mm_segment_t oldfs;
@@ -576,8 +576,8 @@ long compat_sys_timer_settime(timer_t timer_id, int flags,
 	return err;
 }
 
-long compat_sys_timer_gettime(timer_t timer_id,
-		struct compat_itimerspec __user *setting)
+COMPAT_SYSCALL_DEFINE2(timer_gettime, timer_t, timer_id,
+		struct compat_itimerspec __user *, setting)
 {
 	long err;
 	mm_segment_t oldfs;
@@ -593,8 +593,8 @@ long compat_sys_timer_gettime(timer_t timer_id,
 	return err;
 }
 
-long compat_sys_clock_settime(clockid_t which_clock,
-		struct compat_timespec __user *tp)
+COMPAT_SYSCALL_DEFINE2(clock_settime, clockid_t, which_clock,
+		struct compat_timespec __user *, tp)
 {
 	long err;
 	mm_segment_t oldfs;
@@ -610,8 +610,8 @@ long compat_sys_clock_settime(clockid_t which_clock,
 	return err;
 }
 
-long compat_sys_clock_gettime(clockid_t which_clock,
-		struct compat_timespec __user *tp)
+COMPAT_SYSCALL_DEFINE2(clock_gettime, clockid_t, which_clock,
+		struct compat_timespec __user *, tp)
 {
 	long err;
 	mm_segment_t oldfs;
@@ -627,8 +627,8 @@ long compat_sys_clock_gettime(clockid_t which_clock,
 	return err;
 }
 
-long compat_sys_clock_getres(clockid_t which_clock,
-		struct compat_timespec __user *tp)
+COMPAT_SYSCALL_DEFINE2(clock_getres, clockid_t, which_clock,
+		struct compat_timespec __user *, tp)
 {
 	long err;
 	mm_segment_t oldfs;
@@ -668,9 +668,9 @@ static long compat_clock_nanosleep_restart(struct restart_block *restart)
 	return err;
 }
 
-long compat_sys_clock_nanosleep(clockid_t which_clock, int flags,
-			    struct compat_timespec __user *rqtp,
-			    struct compat_timespec __user *rmtp)
+COMPAT_SYSCALL_DEFINE4(clock_nanosleep, clockid_t, which_clock, int, flags,
+			    struct compat_timespec __user *, rqtp,
+			    struct compat_timespec __user *, rmtp)
 {
 	long err;
 	mm_segment_t oldfs;
-- 
1.7.1
