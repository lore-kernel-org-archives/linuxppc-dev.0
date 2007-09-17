Return-Path: <satyam@infradead.org>
Received: from pentafluge.infradead.org (pentafluge.infradead.org
	[213.146.154.40])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 5CF2BDDE1C
	for <linuxppc-dev@ozlabs.org>; Tue, 18 Sep 2007 09:40:55 +1000 (EST)
Date: Tue, 18 Sep 2007 05:13:40 +0530 (IST)
From: Satyam Sharma <satyam@infradead.org>
To: Paul Mackerras <paulus@samba.org>
Subject: [PATCH] powerpc: Avoid pointless WARN_ON(irqs_disabled()) from panic
	codepath
In-Reply-To: <a781481a0709140337u2c26f770h2af6d457bc39f280@mail.gmail.com>
Message-ID: <alpine.LFD.0.999.0709180511070.8863@enigma.security.iitk.ac.in>
References: <46EA5CEB.7020104@linux.vnet.ibm.com>
	<a781481a0709140337u2c26f770h2af6d457bc39f280@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=UTF-8
Cc: linuxppc-dev@ozlabs.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> ------------[ cut here ]------------
> Badness at arch/powerpc/kernel/smp.c:202

comes when smp_call_function_map() has been called with irqs disabled,
which is illegal. However, there is a special case, the panic() codepath,
when we do not want to warn about this -- warning at that time is pointless
anyway, and only serves to scroll away the *real* cause of the panic and
distracts from the real bug.

* So let's extract the WARN_ON() from smp_call_function_map() into all its
  callers -- smp_call_function() and smp_call_function_single()

* Also, introduce another caller of smp_call_function_map(), namely
  __smp_call_function() (and make smp_call_function() a wrapper over this)
  which does *not* warn about disabled irqs

* Use this __smp_call_function() from the panic codepath's smp_send_stop()

We also end having to move code of smp_send_stop() below the definition
of __smp_call_function().

Signed-off-by: Satyam Sharma <satyam@infradead.org>

---

Untested (not even compile-tested) patch.
Could someone point me to ppc32/64 cross-compilers for i386?

 arch/powerpc/kernel/smp.c |   27 ++++++++++++++++++---------
 1 files changed, 18 insertions(+), 9 deletions(-)

diff --git a/arch/powerpc/kernel/smp.c b/arch/powerpc/kernel/smp.c
index 1ea4316..b24dcba 100644
--- a/arch/powerpc/kernel/smp.c
+++ b/arch/powerpc/kernel/smp.c
@@ -152,11 +152,6 @@ static void stop_this_cpu(void *dummy)
 		;
 }
 
-void smp_send_stop(void)
-{
-	smp_call_function(stop_this_cpu, NULL, 1, 0);
-}
-
 /*
  * Structure and data for smp_call_function(). This is designed to minimise
  * static memory requirements. It also looks cleaner.
@@ -198,9 +193,6 @@ int smp_call_function_map(void (*func) (void *info), void *info, int nonatomic,
 	int cpu;
 	u64 timeout;
 
-	/* Can deadlock when called with interrupts disabled */
-	WARN_ON(irqs_disabled());
-
 	if (unlikely(smp_ops == NULL))
 		return ret;
 
@@ -270,10 +262,19 @@ int smp_call_function_map(void (*func) (void *info), void *info, int nonatomic,
 	return ret;
 }
 
+static int __smp_call_function(void (*func)(void *info), void *info,
+			       int nonatomic, int wait)
+{
+	return smp_call_function_map(func,info,nonatomic,wait,cpu_online_map);
+}
+
 int smp_call_function(void (*func) (void *info), void *info, int nonatomic,
 			int wait)
 {
-	return smp_call_function_map(func,info,nonatomic,wait,cpu_online_map);
+	/* Can deadlock when called with interrupts disabled */
+	WARN_ON(irqs_disabled());
+
+	return __smp_call_function(func, info, nonatomic, wait);
 }
 EXPORT_SYMBOL(smp_call_function);
 
@@ -283,6 +284,9 @@ int smp_call_function_single(int cpu, void (*func) (void *info), void *info, int
 	cpumask_t map = CPU_MASK_NONE;
 	int ret = 0;
 
+	/* Can deadlock when called with interrupts disabled */
+	WARN_ON(irqs_disabled());
+
 	if (!cpu_online(cpu))
 		return -EINVAL;
 
@@ -299,6 +303,11 @@ int smp_call_function_single(int cpu, void (*func) (void *info), void *info, int
 }
 EXPORT_SYMBOL(smp_call_function_single);
 
+void smp_send_stop(void)
+{
+	__smp_call_function(stop_this_cpu, NULL, 1, 0);
+}
+
 void smp_call_function_interrupt(void)
 {
 	void (*func) (void *info);
