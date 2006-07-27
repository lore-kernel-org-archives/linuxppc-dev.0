Return-Path: <haren@us.ibm.com>
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e32.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 7B34E67A2E
	for <linuxppc-dev@ozlabs.org>; Fri, 28 Jul 2006 07:29:12 +1000 (EST)
Received: from westrelay02.boulder.ibm.com (westrelay02.boulder.ibm.com
	[9.17.195.11])
	by e32.co.us.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id
	k6RLT9bJ012953
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL)
	for <linuxppc-dev@ozlabs.org>; Thu, 27 Jul 2006 17:29:09 -0400
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by westrelay02.boulder.ibm.com (8.13.6/NCO/VER7.0) with ESMTP id
	k6RLT9D8214114
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linuxppc-dev@ozlabs.org>; Thu, 27 Jul 2006 15:29:09 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	k6RLT8ZS029161
	for <linuxppc-dev@ozlabs.org>; Thu, 27 Jul 2006 15:29:08 -0600
Message-ID: <44C9301C.7080300@us.ibm.com>
Date: Thu, 27 Jul 2006 14:29:00 -0700
From: Haren Myneni <haren@us.ibm.com>
MIME-Version: 1.0
To: Paul Mackerras <paulus@samba.org>
Subject: [PATCH] Add rtas_set_indicator_fast() for RTAS call without extended
	delay
References: <44C6F521.8040609@us.ibm.com> <20060726220441.GZ19076@localdomain>
In-Reply-To: <20060726220441.GZ19076@localdomain>
Content-Type: multipart/mixed; boundary="------------040303090205050100080504"
Cc: External List <linuxppc-dev@ozlabs.org>, Nathan Lynch <ntl@pobox.com>,
	Milton Miller <miltonm@bga.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.
--------------040303090205050100080504
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Nathan Lynch wrote:

>Looks fine to me from a quick look, but we need to use
>rtas_set_indicator_fast in xics_setup_cpu as well (I think I neglected
>to mention I saw the warning in the cpu up path, sorry).
>
>  
>
Posting the modified patch based on Nathan's comment - using 
rtas_set_indicator_fast() in xics_setup_cpu(). If Ok, please send it to 
upstream.

Thanks
Haren

Noticing the following might_sleep warning (dump_stack()) during kdump 
testing when CONFIG_DEBUG_SPINLOCK_SLEEP is enabled. All secondary CPUs 
will be calling rtas_set_indicator with interrupts disabled to remove 
them from global interrupt queue.
BUG: sleeping function called from invalid context at 
arch/powerpc/kernel/rtas.c:463
in_atomic():1, irqs_disabled():1
Call Trace:
[C00000000FFFB970] [C000000000010234] .show_stack+0x68/0x1b0 (unreliable)
[C00000000FFFBA10] [C000000000059354] .__might_sleep+0xd8/0xf4
[C00000000FFFBA90] [C00000000001D1BC] .rtas_busy_delay+0x20/0x5c
[C00000000FFFBB20] [C00000000001D8A8] .rtas_set_indicator+0x6c/0xcc
[C00000000FFFBBC0] [C000000000048BF4] .xics_teardown_cpu+0x118/0x134
[C00000000FFFBC40] [C00000000004539C] 
.pseries_kexec_cpu_down_xics+0x74/0x8c
[C00000000FFFBCC0] [C00000000002DF08] .crash_ipi_callback+0x15c/0x188
[C00000000FFFBD50] [C0000000000296EC] .smp_message_recv+0x84/0xdc
[C00000000FFFBDC0] [C000000000048E08] .xics_ipi_dispatch+0xf0/0x130
[C00000000FFFBE50] [C00000000009EF10] .handle_IRQ_event+0x7c/0xf8
[C00000000FFFBF00] [C0000000000A0A14] .handle_percpu_irq+0x90/0x10c
[C00000000FFFBF90] [C00000000002659C] .call_handle_irq+0x1c/0x2c
[C00000000058B9C0] [C00000000000CA10] .do_IRQ+0xf4/0x1a4
[C00000000058BA50] [C0000000000044EC] hardware_interrupt_entry+0xc/0x10
--- Exception: 501 at .plpar_hcall_norets+0x14/0x1c
   LR = .pseries_dedicated_idle_sleep+0x190/0x1d4
[C00000000058BD40] [C00000000058BDE0] 0xc00000000058bde0 (unreliable)
[C00000000058BDF0] [C00000000001270C] .cpu_idle+0x10c/0x1e0
[C00000000058BE70] [C000000000009274] .rest_init+0x44/0x5c

To fix this issue, rtas_set_indicator_fast() is added so that will not 
wait for RTAS 'busy' delay and this new function is used for kdump (in 
xics_teardown_cpu()) and for CPU hotplug ( xics_migrate_irqs_away() and 
xics_setup_cpu()).

Signed-off-by: Haren Myneni <haren@us.ibm.com>


--------------040303090205050100080504
Content-Type: text/x-patch;
 name="ppc64-add-rtas-set-indicator-fast.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ppc64-add-rtas-set-indicator-fast.patch"

diff -Naurp 2618-rc2.orig/arch/powerpc/kernel/rtas.c 2618-rc2/arch/powerpc/kernel/rtas.c
--- 2618-rc2.orig/arch/powerpc/kernel/rtas.c	2006-07-25 19:34:11.000000000 -0700
+++ 2618-rc2/arch/powerpc/kernel/rtas.c	2006-07-25 19:33:16.000000000 -0700
@@ -569,6 +569,27 @@ int rtas_set_indicator(int indicator, in
 }
 EXPORT_SYMBOL(rtas_set_indicator);
 
+/*
+ * Ignoring RTAS extended delay
+ */
+int rtas_set_indicator_fast(int indicator, int index, int new_value)
+{
+	int rc;
+	int token = rtas_token("set-indicator");
+
+	if (token == RTAS_UNKNOWN_SERVICE)
+		return -ENOENT;
+
+	rc = rtas_call(token, 3, 1, NULL, indicator, index, new_value);
+
+	WARN_ON(rc == -2 || (rc >= 9900 && rc <= 9905));
+
+	if (rc < 0)
+		return rtas_error_rc(rc);
+
+	return rc;
+}
+
 void rtas_restart(char *cmd)
 {
 	if (rtas_flash_term_hook)
diff -Naurp 2618-rc2.orig/arch/powerpc/platforms/pseries/xics.c 2618-rc2/arch/powerpc/platforms/pseries/xics.c
--- 2618-rc2.orig/arch/powerpc/platforms/pseries/xics.c	2006-07-25 19:34:41.000000000 -0700
+++ 2618-rc2/arch/powerpc/platforms/pseries/xics.c	2006-07-26 16:30:16.000000000 -0700
@@ -467,7 +467,7 @@ void xics_setup_cpu(void)
 	 *
 	 * XXX: undo of teardown on kexec needs this too, as may hotplug
 	 */
-	rtas_set_indicator(GLOBAL_INTERRUPT_QUEUE,
+	rtas_set_indicator_fast(GLOBAL_INTERRUPT_QUEUE,
 		(1UL << interrupt_server_size) - 1 - default_distrib_server, 1);
 }
 
@@ -796,7 +796,7 @@ void xics_teardown_cpu(int secondary)
 	 * so leave the master cpu in the group.
 	 */
 	if (secondary)
-		rtas_set_indicator(GLOBAL_INTERRUPT_QUEUE,
+		rtas_set_indicator_fast(GLOBAL_INTERRUPT_QUEUE,
 				   (1UL << interrupt_server_size) - 1 -
 				   default_distrib_server, 0);
 }
@@ -813,7 +813,7 @@ void xics_migrate_irqs_away(void)
 	xics_set_cpu_priority(cpu, 0);
 
 	/* remove ourselves from the global interrupt queue */
-	status = rtas_set_indicator(GLOBAL_INTERRUPT_QUEUE,
+	status = rtas_set_indicator_fast(GLOBAL_INTERRUPT_QUEUE,
 		(1UL << interrupt_server_size) - 1 - default_distrib_server, 0);
 	WARN_ON(status < 0);
 
diff -Naurp 2618-rc2.orig/include/asm-powerpc/rtas.h 2618-rc2/include/asm-powerpc/rtas.h
--- 2618-rc2.orig/include/asm-powerpc/rtas.h	2006-07-25 19:34:27.000000000 -0700
+++ 2618-rc2/include/asm-powerpc/rtas.h	2006-07-25 19:33:57.000000000 -0700
@@ -170,6 +170,7 @@ extern int rtas_get_sensor(int sensor, i
 extern int rtas_get_power_level(int powerdomain, int *level);
 extern int rtas_set_power_level(int powerdomain, int level, int *setlevel);
 extern int rtas_set_indicator(int indicator, int index, int new_value);
+extern int rtas_set_indicator_fast(int indicator, int index, int new_value);
 extern void rtas_progress(char *s, unsigned short hex);
 extern void rtas_initialize(void);
 

--------------040303090205050100080504--
