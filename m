Return-Path: <imunsie@au1.ibm.com>
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp03.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 69788B7705
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Jun 2010 20:04:30 +1000 (EST)
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [202.81.31.245])
	by e23smtp03.au.ibm.com (8.14.4/8.13.1) with ESMTP id o5NA0woi020456
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Jun 2010 20:00:58 +1000
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
	by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o5NA4U041814572
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Jun 2010 20:04:30 +1000
Received: from d23av04.au.ibm.com (loopback [127.0.0.1])
	by d23av04.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	o5NA4TSF007737
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Jun 2010 20:04:29 +1000
From: "Ian Munsie" <imunsie@au1.ibm.com>
To: linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org
Subject: [PATCH 27/40] trace syscalls: Add COMPAT_SYSCALL_DEFINE0 macro
Date: Wed, 23 Jun 2010 20:03:08 +1000
Message-Id: <1277287401-28571-28-git-send-email-imunsie@au1.ibm.com>
In-Reply-To: <1277287401-28571-1-git-send-email-imunsie@au1.ibm.com>
References: <1277287401-28571-1-git-send-email-imunsie@au1.ibm.com>
Cc: Frederic Weisbecker <fweisbec@gmail.com>, Jason Baron <jbaron@redhat.com>,
	Steven Rostedt <rostedt@goodmis.org>, Ingo Molnar <mingo@redhat.com>,
	Paul Mackerras <paulus@samba.org>,
	Ian Munsie <imunsie@au1.ibm.com>, Ingo Molnar <mingo@elte.hu>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Ian Munsie <imunsie@au1.ibm.com>

This patchs adds the COMPAT_SYSCALL_DEFINE0 macros for compat syscalls
that do not take any arguments.

Signed-off-by: Ian Munsie <imunsie@au1.ibm.com>
---
 include/linux/syscalls.h |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index a608565..1076ae8 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -220,6 +220,10 @@ extern struct trace_event_functions exit_syscall_print_funcs;
 	SYSCALL_METADATAx(syscall, compat_sys_##sname, x, compat_syscall, __VA_ARGS__);\
 	asmlinkage long syscall(__SC_DECL##x(__VA_ARGS__))
 
+#define COMPAT_SYSCALL_DEFINE0(name)					\
+	SYSCALL_METADATA0(compat_sys_##name, name, compat_syscall)	\
+	asmlinkage long compat_sys_##name()
+
 #endif /* CONFIG_COMPAT */
 
 
-- 
1.7.1
