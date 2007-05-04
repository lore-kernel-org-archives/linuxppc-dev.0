Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id 7B6A0DDFF1
	for <linuxppc-dev@ozlabs.org>; Fri,  4 May 2007 14:37:57 +1000 (EST)
Date: Thu, 3 May 2007 23:39:21 -0500
To: Paul Mackerras <paulus@samba.org>
Subject: [PATCH] pasemi: update ppc_proc_freq from cpufreq driver
Message-ID: <20070504043921.GA6022@lixom.net>
References: <20070427084118.GA8842@lixom.net>
	<20070430035339.GA15771@lixom.net>
	<20070504031611.GB5567@lixom.net>
	<17978.45028.471162.619967@cargo.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <17978.45028.471162.619967@cargo.ozlabs.ibm.com>
From: olof@lixom.net (Olof Johansson)
Cc: linuxppc-dev@ozlabs.org, arnd@arndb.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Update the global cpu speed variable according to current cpufreq speed,
/proc/cpuinfo reports the actual speed.


Signed-off-by: Olof Johansson <olof@lixom.net>

---

On Fri, May 04, 2007 at 02:00:36PM +1000, Paul Mackerras wrote:
> Olof Johansson writes:
> 
> > On other architectures, the frequency in /proc/cpuinfo moves with cpufreq
> > changes. It makes sense to do the same on powerpc to keep users from
> > getting confused.
> 
> Well, it does on powermac already, because ppc_proc_freq gets
> adjusted...  So at the very least, your patch description needs to be
> changed.
> 
> Do you have a situation where the CPUs in a system can have different
> clock frequencies?  If not, why not just set ppc_proc_freq when the
> frequency changes?

Sure. I'll let the cell guys do the equivalent change on their own.


Index: 2.6.21/arch/powerpc/platforms/pasemi/cpufreq.c
===================================================================
--- 2.6.21.orig/arch/powerpc/platforms/pasemi/cpufreq.c
+++ 2.6.21/arch/powerpc/platforms/pasemi/cpufreq.c
@@ -31,6 +31,7 @@
 #include <asm/hw_irq.h>
 #include <asm/io.h>
 #include <asm/prom.h>
+#include <asm/time.h>
 
 #define SDCASR_REG		0x0100
 #define SDCASR_REG_STRIDE	0x1000
@@ -204,6 +205,8 @@ static int pas_cpufreq_cpu_init(struct c
 	policy->cur = pas_freqs[cur_astate].frequency;
 	policy->cpus = cpu_online_map;
 
+	ppc_proc_freq = policy->cur * 1000ul;
+
 	cpufreq_frequency_table_get_attr(pas_freqs, policy->cpu);
 
 	/* this ensures that policy->cpuinfo_min and policy->cpuinfo_max
@@ -270,6 +273,7 @@ static int pas_cpufreq_target(struct cpu
 	cpufreq_notify_transition(&freqs, CPUFREQ_POSTCHANGE);
 	mutex_unlock(&pas_switch_mutex);
 
+	ppc_proc_freq = freqs.new * 1000ul;
 	return 0;
 }
 
