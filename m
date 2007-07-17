Return-Path: <linas@austin.ibm.com>
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e35.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 89F13DDDCA
	for <linuxppc-dev@ozlabs.org>; Wed, 18 Jul 2007 02:09:41 +1000 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e35.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l6HG9bT9020292
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Jul 2007 12:09:37 -0400
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v8.4) with ESMTP id
	l6HG9aq4196852
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Jul 2007 10:09:36 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l6HG9aTi014478
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Jul 2007 10:09:36 -0600
Date: Tue, 17 Jul 2007 11:09:35 -0500
To: paulus@samba.org
Subject: [PATCH] iommu virtual merge no longer experimental
Message-ID: <20070717160935.GE5771@austin.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: linas@austin.ibm.com (Linas Vepstas)
Cc: linuxppc-dev@ozlabs.org, Benjamin Herrenschmidt <benh@au1.ibm.com>,
	Arnd Bergmann <arnd.bergmann@de.ibm.com>, Tim Schimke <tschimke@us.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Per conversations with BenH, iommu virtual merging should no longer
be considered to be an "experimental" feature. In particular, 
CONFIG_VMERGE has been set to "y" in te defconfigs for quite a while.

Signed-off-by: Linas Vepstas <linas@austin.ibm.com>

----
 arch/powerpc/Kconfig |   11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

Index: linux-2.6.22-git2/arch/powerpc/Kconfig
===================================================================
--- linux-2.6.22-git2.orig/arch/powerpc/Kconfig	2007-07-08 18:32:17.000000000 -0500
+++ linux-2.6.22-git2/arch/powerpc/Kconfig	2007-07-17 11:08:18.000000000 -0500
@@ -430,16 +430,17 @@ config MATH_EMULATION
 	  instructions to run.
 
 config IOMMU_VMERGE
-	bool "Enable IOMMU virtual merging (EXPERIMENTAL)"
-	depends on EXPERIMENTAL && PPC64
-	default n
+	bool "Enable IOMMU virtual merging"
+	depends on PPC64
+	default y
 	help
 	  Cause IO segments sent to a device for DMA to be merged virtually
 	  by the IOMMU when they happen to have been allocated contiguously.
 	  This doesn't add pressure to the IOMMU allocator. However, some
 	  drivers don't support getting large merged segments coming back
-	  from *_map_sg(). Say Y if you know the drivers you are using are
-	  properly handling this case.
+	  from *_map_sg().
+
+	  Most drivers don't have this problem; it is safe to say Y here.
 
 config HOTPLUG_CPU
 	bool "Support for enabling/disabling CPUs"
