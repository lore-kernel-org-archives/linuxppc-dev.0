Return-Path: <ddstreet@gmail.com>
Received: from mail-ie0-x22c.google.com (mail-ie0-x22c.google.com
 [IPv6:2607:f8b0:4001:c03::22c])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 88E821A01B8
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  1 Nov 2014 06:41:54 +1100 (AEDT)
Received: by mail-ie0-f172.google.com with SMTP id at20so1989968iec.3
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 31 Oct 2014 12:41:52 -0700 (PDT)
Sender: Dan Streetman <ddstreet@gmail.com>
From: Dan Streetman <ddstreet@ieee.org>
To: Nathan Fontenot <nfont@linux.vnet.ibm.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
Subject: [PATCH] powerpc: use device_online/offline() instead of cpu_up/down()
Date: Fri, 31 Oct 2014 15:41:34 -0400
Message-Id: <1414784494-12573-1-git-send-email-ddstreet@ieee.org>
In-Reply-To: <CALZtONCwrBb+HPY7j7x4R-xmyhajFNCwaS3sns50RMDxHxyiEQ@mail.gmail.com>
References: <CALZtONCwrBb+HPY7j7x4R-xmyhajFNCwaS3sns50RMDxHxyiEQ@mail.gmail.com>
Cc: Thomas Falcon <tlfalcon@linux.vnet.ibm.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
 "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-kernel@vger.kernel.org,
 Paul Mackerras <paulus@samba.org>, Daniel Walter <dwalter@google.com>,
 Bharata B Rao <bharata@linux.vnet.ibm.com>,
 Grant Likely <grant.likely@linaro.org>,
 Andrew Morton <akpm@linux-foundation.org>, Neil Zhang <zhangwm@marvell.com>,
 linuxppc-dev@lists.ozlabs.org, Dan Streetman <ddstreet@ieee.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

In powerpc pseries platform dlpar operations, Use device_online() and
device_offline() instead of cpu_up() and cpu_down().

Calling cpu_up/down directly does not update the cpu device offline
field, which is used to online/offline a cpu from sysfs.  Calling
device_online/offline instead keeps the sysfs cpu online value correct.
The hotplug lock, which is required to be held when calling
device_online/offline, is already held when dlpar_online/offline_cpu
are called, since they are called only from cpu_probe|release_store.

This patch fixes errors on PowerVM systems that have cpu(s) added/removed
using dlpar operations; without this patch, the
/sys/devices/system/cpu/cpuN/online nodes do not correctly show the
online state of added/removed cpus.

Signed-off-by: Dan Streetman <ddstreet@ieee.org>
Cc: Nathan Fontenot <nfont@linux.vnet.ibm.com>
---

Previous discussion for this:
https://lkml.org/lkml/2014/10/29/839

 arch/powerpc/platforms/pseries/dlpar.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/dlpar.c b/arch/powerpc/platforms/pseries/dlpar.c
index 6ad83bd..c22bb1b 100644
--- a/arch/powerpc/platforms/pseries/dlpar.c
+++ b/arch/powerpc/platforms/pseries/dlpar.c
@@ -382,7 +382,7 @@ static int dlpar_online_cpu(struct device_node *dn)
 			BUG_ON(get_cpu_current_state(cpu)
 					!= CPU_STATE_OFFLINE);
 			cpu_maps_update_done();
-			rc = cpu_up(cpu);
+			rc = device_online(get_cpu_device(cpu));
 			if (rc)
 				goto out;
 			cpu_maps_update_begin();
@@ -467,7 +467,7 @@ static int dlpar_offline_cpu(struct device_node *dn)
 			if (get_cpu_current_state(cpu) == CPU_STATE_ONLINE) {
 				set_preferred_offline_state(cpu, CPU_STATE_OFFLINE);
 				cpu_maps_update_done();
-				rc = cpu_down(cpu);
+				rc = device_offline(get_cpu_device(cpu));
 				if (rc)
 					goto out;
 				cpu_maps_update_begin();
-- 
1.8.3.1
