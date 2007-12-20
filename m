Return-Path: <estarkov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 0AAD4DDE18
	for <linuxppc-dev@ozlabs.org>; Fri, 21 Dec 2007 01:23:02 +1100 (EST)
Message-ID: <476A790A.2060203@ru.mvista.com>
Date: Thu, 20 Dec 2007 17:15:38 +0300
From: Egor Starkov <estarkov@ru.mvista.com>
MIME-Version: 1.0
To: mingo@elte.hu
Subject: PPC64 doesn't compile with CONFIG_SMP=n
Content-Type: multipart/mixed; boundary="------------090808080300070509010501"
Cc: linuxppc-dev@ozlabs.org, linux-rt-users@vger.kernel.org,
	rostedt@goodmis.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.
--------------090808080300070509010501
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hello Ingo

I've found out that real-time tree doesn't compile for PPC64 with 
CONFIG_SMP=n.

Think this is due to patch-2.6.21.4-rt10 patch. It has
definitions of following symbols missing: __get_cpu_lock,
__get_cpu_var_locked.

I've attached the patch to fix the problem.

Egor Starkov

--------------090808080300070509010501
Content-Type: text/plain;
 name="powerpc_smp_bugfix"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="powerpc_smp_bugfix"

Signed-off-by: Egor Starkov <estarkov@ru.mvista.com>

Index: linux-2.6.21/include/asm-powerpc/percpu.h
===================================================================
--- linux-2.6.21.orig/include/asm-powerpc/percpu.h
+++ linux-2.6.21/include/asm-powerpc/percpu.h
@@ -61,6 +61,8 @@ extern void setup_per_cpu_areas(void);
 
 #define __get_cpu_var(var)			per_cpu__##var
 #define __raw_get_cpu_var(var)			per_cpu__##var
+#define __get_cpu_lock(var, cpu)		per_cpu_lock__##var##_locked
+#define __get_cpu_var_locked(var, cpu)		per_cpu__##var##_locked
 
 #endif	/* SMP */
 

--------------090808080300070509010501--
