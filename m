Return-Path: <ego@in.ibm.com>
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp09.au.ibm.com", Issuer "Equifax" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id BF0B1B7E28
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu,  6 Aug 2009 00:26:10 +1000 (EST)
Received: from d23relay02.au.ibm.com (d23relay02.au.ibm.com [202.81.31.244])
	by e23smtp09.au.ibm.com (8.14.3/8.13.1) with ESMTP id n75EPTnK020527
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 6 Aug 2009 00:25:29 +1000
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
	by d23relay02.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	n75EQ6MU1097736
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 6 Aug 2009 00:26:06 +1000
Received: from d23av04.au.ibm.com (loopback [127.0.0.1])
	by d23av04.au.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n75EQ5Y9008390
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 6 Aug 2009 00:26:06 +1000
Subject: [PATCH 2/3] cpu: Implement cpu-offline-state callbacks for pSeries.
To: Joel Schopp <jschopp@austin.ibm.com>, len.brown@intel.com,
	Peter Zijlstra <a.p.zijlstra@chello.nl>, Balbir Singh <balbir@in.ibm.com>,
	Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	shaohua.li@intel.com, Ingo Molnar <mingo@elte.hu>,
	Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>,
	Dipankar Sarma <dipankar@in.ibm.com>, "Darrick J. Wong" <djwong@us.ibm.com>
From: Gautham R Shenoy <ego@in.ibm.com>
Date: Wed, 05 Aug 2009 19:56:03 +0530
Message-ID: <20090805142603.553.55888.stgit@sofia.in.ibm.com>
In-Reply-To: <20090805142311.553.78286.stgit@sofia.in.ibm.com>
References: <20090805142311.553.78286.stgit@sofia.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch implements the callbacks to handle the reads/writes into the sysfs
interfaces

/sys/devices/system/cpu/cpu<number>/available_offline_states
and
/sys/devices/system/cpu/cpu<number>/preferred_offline_state

Currently, the patch defines two states which the processor can go to when it
is offlined. They are

- deallocate: The current behaviour when the cpu is offlined.
  The CPU would call make an rtas_stop_self() call and hand over the
  CPU back to the resource pool, thereby effectively deallocating
  that vCPU from the LPAR.

- deactivate: This is expected to cede the processor to the hypervisor, so
  that on processors which support appropriate low-power states, they can
  be exploited. This can be considered as an extended tickless idle state.

The patch only implements the callbacks which will display the available
states, and record the preferred states. The code bits to call
rtas_stop_self() or H_CEDE, depending on the preferred_offline_state is
implemented in the next patch.

Signed-off-by: Gautham R Shenoy <ego@in.ibm.com>
---
 arch/powerpc/platforms/pseries/hotplug-cpu.c    |   90 +++++++++++++++++++++++
 arch/powerpc/platforms/pseries/offline_driver.h |   16 ++++
 2 files changed, 106 insertions(+), 0 deletions(-)
 create mode 100644 arch/powerpc/platforms/pseries/offline_driver.h

diff --git a/arch/powerpc/platforms/pseries/hotplug-cpu.c b/arch/powerpc/platforms/pseries/hotplug-cpu.c
index a20ead8..f15de99 100644
--- a/arch/powerpc/platforms/pseries/hotplug-cpu.c
+++ b/arch/powerpc/platforms/pseries/hotplug-cpu.c
@@ -30,6 +30,95 @@
 #include <asm/pSeries_reconfig.h>
 #include "xics.h"
 #include "plpar_wrappers.h"
+#include "offline_driver.h"
+
+struct cpu_offline_state {
+	enum cpu_state_vals state_val;
+	const char *state_name;
+} pSeries_cpu_offline_states[] = {
+	{CPU_DEACTIVATE, "deactivate"},
+	{CPU_DEALLOCATE, "deallocate"},
+};
+
+DEFINE_PER_CPU(enum cpu_state_vals, preferred_offline_state) = CPU_DEALLOCATE;
+
+ssize_t pSeries_show_available_states(struct sys_device *dev,
+			struct sysdev_attribute *attr, char *buf)
+{
+	int state;
+	ssize_t ret = 0;
+
+	for (state = CPU_DEACTIVATE; state < CPU_MAX_OFFLINE_STATES; state++) {
+		if (state == CPU_STATE_ONLINE)
+			continue;
+
+		if (ret >= (ssize_t) ((PAGE_SIZE / sizeof(char))
+					- (CPU_STATES_LEN + 2)))
+			goto out;
+		ret += scnprintf(&buf[ret], CPU_STATES_LEN, "%s ",
+				pSeries_cpu_offline_states[state].state_name);
+	}
+
+out:
+	ret += sprintf(&buf[ret], "\n");
+	return ret;
+}
+
+ssize_t pSeries_show_preferred_state(struct sys_device *dev,
+			struct sysdev_attribute *attr, char *buf)
+{
+	struct cpu *cpu = container_of(dev, struct cpu, sysdev);
+	int state = per_cpu(preferred_offline_state, cpu->sysdev.id);
+
+	return scnprintf(buf, CPU_STATES_LEN, "%s\n",
+			pSeries_cpu_offline_states[state].state_name);
+}
+
+ssize_t pSeries_store_preferred_state(struct sys_device *dev,
+			struct sysdev_attribute *attr,
+			const char *buf, size_t count)
+{
+	struct cpu *cpu = container_of(dev, struct cpu, sysdev);
+	unsigned int ret = -EINVAL;
+	char state_name[CPU_STATES_LEN];
+	int i;
+	cpu_maps_update_begin();
+	ret = sscanf(buf, "%15s", state_name);
+
+	if (ret != 1) {
+		ret = -EINVAL;
+		goto out_unlock;
+	}
+
+	for (i = CPU_DEACTIVATE; i < CPU_MAX_OFFLINE_STATES; i++)
+		if (!strnicmp(state_name,
+				pSeries_cpu_offline_states[i].state_name,
+				CPU_STATES_LEN))
+			break;
+
+	if (i == CPU_MAX_OFFLINE_STATES) {
+		ret = -EINVAL;
+		goto out_unlock;
+	}
+
+	per_cpu(preferred_offline_state, cpu->sysdev.id) =
+				pSeries_cpu_offline_states[i].state_val;
+	ret = 0;
+
+out_unlock:
+	cpu_maps_update_done();
+
+	if (ret)
+		return ret;
+	else
+		return count;
+}
+
+struct cpu_offline_driver pSeries_offline_driver = {
+	.show_available_states = pSeries_show_available_states,
+	.show_preferred_state = pSeries_show_preferred_state,
+	.store_preferred_state = pSeries_store_preferred_state,
+};
 
 /* This version can't take the spinlock, because it never returns */
 static struct rtas_args rtas_stop_self_args = {
@@ -281,6 +370,7 @@ static int __init pseries_cpu_hotplug_init(void)
 	ppc_md.cpu_die = pseries_mach_cpu_die;
 	smp_ops->cpu_disable = pseries_cpu_disable;
 	smp_ops->cpu_die = pseries_cpu_die;
+	register_cpu_offline_driver(&pSeries_offline_driver);
 
 	/* Processors can be added/removed only on LPAR */
 	if (firmware_has_feature(FW_FEATURE_LPAR))
diff --git a/arch/powerpc/platforms/pseries/offline_driver.h b/arch/powerpc/platforms/pseries/offline_driver.h
new file mode 100644
index 0000000..bdae76a
--- /dev/null
+++ b/arch/powerpc/platforms/pseries/offline_driver.h
@@ -0,0 +1,16 @@
+#ifndef _OFFLINE_DRIVER_H_
+#define _OFFLINE_DRIVER_H_
+
+#define CPU_STATES_LEN	16
+
+/* Cpu offline states go here */
+enum cpu_state_vals {
+	CPU_DEACTIVATE,
+	CPU_DEALLOCATE,
+	CPU_STATE_ONLINE,
+	CPU_MAX_OFFLINE_STATES
+};
+
+DECLARE_PER_CPU(enum cpu_state_vals, preferred_offline_state);
+
+#endif
