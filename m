Return-Path: <cody@linux.vnet.ibm.com>
Received: from e9.ny.us.ibm.com (e9.ny.us.ibm.com [32.97.182.139])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 70F6C2C00AB
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 22 Feb 2014 11:14:59 +1100 (EST)
Received: from /spool/local
 by e9.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <cody@linux.vnet.ibm.com>;
 Fri, 21 Feb 2014 19:14:56 -0500
Received: from b01cxnp23033.gho.pok.ibm.com (b01cxnp23033.gho.pok.ibm.com
 [9.57.198.28])
 by d01dlp02.pok.ibm.com (Postfix) with ESMTP id 463846E8040
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Feb 2014 19:14:49 -0500 (EST)
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
 by b01cxnp23033.gho.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s1M0EsXD59506910
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 22 Feb 2014 00:14:54 GMT
Received: from d01av01.pok.ibm.com (localhost [127.0.0.1])
 by d01av01.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s1M0ErJ8014087
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Feb 2014 19:14:53 -0500
From: Cody P Schafer <cody@linux.vnet.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Cody P Schafer <cody@linux.vnet.ibm.com>,
 Madhavan Srinivasan <maddy@linux.vnet.ibm.com>,
 Olof Johansson <olof@lixom.net>,
 Paul Gortmaker <paul.gortmaker@windriver.com>,
 Wang Dongsheng <dongsheng.wang@freescale.com>
Subject: [PATCH] powerpc: warn users of smt-snooze-delay that the API isn't
 there anymore
Date: Fri, 21 Feb 2014 16:14:31 -0800
Message-Id: <1393028074-26797-1-git-send-email-cody@linux.vnet.ibm.com>
Cc: Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

/sys/devices/system/cpu/cpu*/smt-snooze-delay was converted into a NOP
in commit 3fa8cad82b94d0bed002571bd246f2299ffc876b, and now does
nothing. Add a pr_warn() to convince any users that they should stop
using it.

The commit message from the removing commit notes that this
functionality should move into the cpuidle driver, essentially by
adjusting target_residency to the specified value. At the moment,
target_residency is not exposed by cpuidle's sysfs, so there isn't a
drop in replacement for this.

Signed-off-by: Cody P Schafer <cody@linux.vnet.ibm.com>
---
 arch/powerpc/kernel/sysfs.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/powerpc/kernel/sysfs.c b/arch/powerpc/kernel/sysfs.c
index 97e1dc9..84097b4 100644
--- a/arch/powerpc/kernel/sysfs.c
+++ b/arch/powerpc/kernel/sysfs.c
@@ -50,6 +50,9 @@ static ssize_t store_smt_snooze_delay(struct device *dev,
 	if (ret != 1)
 		return -EINVAL;
 
+	pr_warn_ratelimited("%s (%d): /sys/devices/system/cpu/cpu%d/smt-snooze-delay is deprecated and is a NOP\n",
+		  current->comm, task_pid_nr(current), cpu->dev.id);
+
 	per_cpu(smt_snooze_delay, cpu->dev.id) = snooze;
 	return count;
 }
@@ -60,6 +63,9 @@ static ssize_t show_smt_snooze_delay(struct device *dev,
 {
 	struct cpu *cpu = container_of(dev, struct cpu, dev);
 
+	pr_warn_ratelimited("%s (%d): /sys/devices/system/cpu/cpu%d/smt-snooze-delay is deprecated and is a NOP\n",
+		  current->comm, task_pid_nr(current), cpu->dev.id);
+
 	return sprintf(buf, "%ld\n", per_cpu(smt_snooze_delay, cpu->dev.id));
 }
 
-- 
1.9.0
