Return-Path: <nfont@austin.ibm.com>
Received: from e39.co.us.ibm.com (e39.co.us.ibm.com [32.97.110.160])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e39.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 44115B7067
	for <linuxppc-dev@ozlabs.org>; Wed, 25 Nov 2009 12:54:04 +1100 (EST)
Received: from d03relay01.boulder.ibm.com (d03relay01.boulder.ibm.com
	[9.17.195.226])
	by e39.co.us.ibm.com (8.14.3/8.13.1) with ESMTP id nAP1lbWv026503
	for <linuxppc-dev@ozlabs.org>; Tue, 24 Nov 2009 18:47:37 -0700
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by d03relay01.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	nAP1rv3o154236
	for <linuxppc-dev@ozlabs.org>; Tue, 24 Nov 2009 18:53:57 -0700
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP
	id nAOJkVFO000649
	for <linuxppc-dev@ozlabs.org>; Tue, 24 Nov 2009 12:46:31 -0700
Message-ID: <4B0C8E31.9040608@austin.ibm.com>
Date: Tue, 24 Nov 2009 19:53:53 -0600
From: Nathan Fontenot <nfont@austin.ibm.com>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] CPU DLPAR  handling
References: <4B0C8B45.6080804@austin.ibm.com>
In-Reply-To: <4B0C8B45.6080804@austin.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Register the pseries specific handlers for the powerpc architecture handlers
for the cpu probe and release files.  This also implements the cpu DLPAR
addition and removal of CPUS from the system.

Signed-off-by: Nathan Fontenot <nfont@austin.ibm.com>
---

arch/powerpc/platforms/pseries/dlpar.c |   88 +++++++++++++++++++++++++++++++++
 1 file changed, 88 insertions(+)

Index: powerpc/arch/powerpc/platforms/pseries/dlpar.c
===================================================================
--- powerpc.orig/arch/powerpc/platforms/pseries/dlpar.c	2009-11-24 23:29:12.000000000 -0600
+++ powerpc/arch/powerpc/platforms/pseries/dlpar.c	2009-11-24 23:29:24.000000000 -0600
@@ -321,4 +321,92 @@
 	return 0;
 }
 
+#ifdef CONFIG_ARCH_CPU_PROBE_RELEASE
 
+static ssize_t dlpar_cpu_probe(const char *buf, size_t count)
+{
+	struct device_node *dn;
+	unsigned long drc_index;
+	char *cpu_name;
+	int rc;
+
+	rc = strict_strtoul(buf, 0, &drc_index);
+	if (rc)
+		return -EINVAL;
+
+	dn = dlpar_configure_connector(drc_index);
+	if (!dn)
+		return -EINVAL;
+
+	/* configure-connector reports cpus as living in the base
+	 * directory of the device tree.  CPUs actually live in the
+	 * cpus directory so we need to fixup the full_name.
+	 */
+	cpu_name = kzalloc(strlen(dn->full_name) + strlen("/cpus/") + 1,
+			   GFP_KERNEL);
+	if (!cpu_name) {
+		dlpar_free_cc_nodes(dn);
+		return -ENOMEM;
+	}
+
+	sprintf(cpu_name, "/cpus/%s", dn->full_name);
+	kfree(dn->full_name);
+	dn->full_name = cpu_name;
+
+	rc = dlpar_acquire_drc(drc_index);
+	if (rc) {
+		dlpar_free_cc_nodes(dn);
+		return -EINVAL;
+	}
+
+	rc = dlpar_attach_node(dn);
+	if (rc) {
+		dlpar_release_drc(drc_index);
+		dlpar_free_cc_nodes(dn);
+	}
+
+	return rc ? rc : count;
+}
+
+static ssize_t dlpar_cpu_release(const char *buf, size_t count)
+{
+	struct device_node *dn;
+	const u32 *drc_index;
+	int rc;
+
+	dn = of_find_node_by_path(buf);
+	if (!dn)
+		return -EINVAL;
+
+	drc_index = of_get_property(dn, "ibm,my-drc-index", NULL);
+	if (!drc_index) {
+		of_node_put(dn);
+		return -EINVAL;
+	}
+
+	rc = dlpar_release_drc(*drc_index);
+	if (rc) {
+		of_node_put(dn);
+		return -EINVAL;
+	}
+
+	rc = dlpar_detach_node(dn);
+	if (rc) {
+		dlpar_acquire_drc(*drc_index);
+		return rc;
+	}
+
+	of_node_put(dn);
+	return count;
+}
+
+static int __init pseries_dlpar_init(void)
+{
+	ppc_md.cpu_probe = dlpar_cpu_probe;
+	ppc_md.cpu_release = dlpar_cpu_release;
+
+	return 0;
+}
+machine_device_initcall(pseries, pseries_dlpar_init);
+
+#endif /* CONFIG_ARCH_CPU_PROBE_RELEASE */
