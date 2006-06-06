Return-Path: <hch@lst.de>
Received: from mail.lst.de (verein.lst.de [213.95.11.210])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 0F31F67A73
	for <linuxppc-dev@ozlabs.org>; Wed,  7 Jun 2006 00:09:47 +1000 (EST)
Received: from verein.lst.de (localhost [127.0.0.1])
	by mail.lst.de (8.12.3/8.12.3/Debian-7.1) with ESMTP id k56E9gRT007293
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO)
	for <linuxppc-dev@ozlabs.org>; Tue, 6 Jun 2006 16:09:42 +0200
Received: (from hch@localhost)
	by verein.lst.de (8.12.3/8.12.3/Debian-6.6) id k56E9deg007289
	for linuxppc-dev@ozlabs.org; Tue, 6 Jun 2006 16:09:39 +0200
Date: Tue, 6 Jun 2006 16:09:39 +0200
From: Christoph Hellwig <hch@lst.de>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 1/2] powerpc: implement pcibus_to_node and pcibus_to_cpumask
Message-ID: <20060606140939.GA6974@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 64bit powerpc we can find out what node a pci bus hangs off, so
implement the topology.h macros that export this information.

For 32bit this seems a little more difficult, but I don't know of 32bit
powerpc NUMA machines either, so let's leave it out for now.


Signed-off-by: Christoph Hellwig <hch@lst.de>

Index: linux-2.6/include/asm-powerpc/topology.h
===================================================================
--- linux-2.6.orig/include/asm-powerpc/topology.h	2006-05-02 16:26:14.000000000 +0200
+++ linux-2.6/include/asm-powerpc/topology.h	2006-05-30 14:42:18.000000000 +0200
@@ -32,8 +32,13 @@
 
 int of_node_to_nid(struct device_node *device);
 
+#ifdef CONFIG_PPC64
+#define pcibus_to_node(bus)	(of_node_to_nid(bus->sysdata))
+#define pcibus_to_cpumask(bus)	(node_to_cpumask(of_node_to_nid(bus->sysdata)))
+#else
 #define pcibus_to_node(node)    (-1)
 #define pcibus_to_cpumask(bus)	(cpu_online_map)
+#endif
 
 /* sched_domains SD_NODE_INIT for PPC64 machines */
 #define SD_NODE_INIT (struct sched_domain) {		\
