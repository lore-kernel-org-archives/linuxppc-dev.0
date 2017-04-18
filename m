Return-Path: <tyreld@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w6QrF65GBzDq7Z
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Apr 2017 10:25:01 +1000 (AEST)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v3I0NbN3145144
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 17 Apr 2017 20:24:46 -0400
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
 by mx0a-001b2d01.pphosted.com with ESMTP id 29w0p6grx6-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 17 Apr 2017 20:24:46 -0400
Received: from localhost
 by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <tyreld@linux.vnet.ibm.com>;
 Mon, 17 Apr 2017 18:24:45 -0600
From: Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
To: mpe@ellerman.id.au
Cc: benh@kernel.crashing.org, linuxppc-dev@lists.ozlabs.org,
 nfont@linux.vnet.ibm.com, bharata@linux.vnet.ibm.com,
 sachinp@linux.vnet.ibm.com, devicetree@vger.kernel.org,
 robh+dt@kernel.org, sudeep.karkadanagesha@arm.com,
 Tyrel Datwyler <tyreld@linux.vnet.ibm.com>, stable@vger.kernel.org
Subject: [PATCH 2/2] powerpc/sysfs: fix reference leak of cpu device_nodes
 present at boot
Date: Mon, 17 Apr 2017 20:24:39 -0400
In-Reply-To: <1492474900-10658-1-git-send-email-tyreld@linux.vnet.ibm.com>
References: <1492474900-10658-1-git-send-email-tyreld@linux.vnet.ibm.com>
Message-Id: <1492475079-10740-1-git-send-email-tyreld@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

For cpus present at boot each logical cpu acquires a reference to the
associated device node of the core. This happens in register_cpu() which
is called by topology_init(). The result of this is that we end up with
a reference held by each thread of the core. However, these references
are never freed if the cpu core is dlpar removed.

This patch fixes the reference leaks by acquiring and releasing the
references in the cpu hotplug callbacks un/register_cpu_online().
With this patch symmetric reference counting is observed with both cpus
present at boot, and those dlpar added after boot.

Cc: stable@vger.kernel.org
fixes: f86e4718f24b ("driver/core: cpu: initialize of_node in cpu's device struture")
Signed-off-by: Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
---
 arch/powerpc/kernel/sysfs.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/powerpc/kernel/sysfs.c b/arch/powerpc/kernel/sysfs.c
index c1fb255..949957b 100644
--- a/arch/powerpc/kernel/sysfs.c
+++ b/arch/powerpc/kernel/sysfs.c
@@ -710,6 +710,10 @@ static int register_cpu_online(unsigned int cpu)
 	struct device_attribute *attrs, *pmc_attrs;
 	int i, nattrs;
 
+	/* For cpus present at boot a reference was already grabbed in register_cpu() */
+	if (!s->of_node)
+		s->of_node = of_get_cpu_node(cpu, NULL);
+
 #ifdef CONFIG_PPC64
 	if (cpu_has_feature(CPU_FTR_SMT))
 		device_create_file(s, &dev_attr_smt_snooze_delay);
@@ -864,6 +868,8 @@ static int unregister_cpu_online(unsigned int cpu)
 	}
 #endif
 	cacheinfo_cpu_offline(cpu);
+	of_node_put(s->of_node);
+	s->of_node = NULL;
 #endif /* CONFIG_HOTPLUG_CPU */
 	return 0;
 }
-- 
1.8.3.1
