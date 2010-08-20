Return-Path: <sonny@us.ibm.com>
Received: from e5.ny.us.ibm.com (e5.ny.us.ibm.com [32.97.182.145])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e5.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 733BDB70DF
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 20 Aug 2010 14:06:20 +1000 (EST)
Received: from d01relay01.pok.ibm.com (d01relay01.pok.ibm.com [9.56.227.233])
	by e5.ny.us.ibm.com (8.14.4/8.13.1) with ESMTP id o7K3lOIh023950
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Aug 2010 23:47:24 -0400
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
	by d01relay01.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o7K46Gl1366522
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Aug 2010 00:06:16 -0400
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
	by d01av03.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	o7K46GcJ011775
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Aug 2010 01:06:16 -0300
Date: Thu, 19 Aug 2010 23:08:09 -0500
From: Sonny Rao <sonnyrao@us.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 1/2]: Powerpc: Fix EHCA driver on relocatable kernel
Message-ID: <20100820040809.GS16505@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-rdma@vger.kernel.org, fenkes@de.ibm.com, raisch@de.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Some modules (like eHCA) want to map all of kernel memory, for this to
work with a relocated kernel, we need to export kernstart_addr so
modules can use PHYSICAL_START and memstart_addr so they could use
MEMORY_START.  Note that the 32bit code already exports these symbols.

Signed-off-By: Sonny Rao <sonnyrao@us.ibm.com>

Index: common/arch/powerpc/mm/init_64.c
===================================================================
--- common.orig/arch/powerpc/mm/init_64.c	2010-08-16 02:38:33.000000000 -0500
+++ common/arch/powerpc/mm/init_64.c	2010-08-16 02:39:25.000000000 -0500
@@ -79,7 +79,9 @@
 #endif /* CONFIG_PPC_STD_MMU_64 */
 
 phys_addr_t memstart_addr = ~0;
+EXPORT_SYMBOL(memstart_addr);
 phys_addr_t kernstart_addr;
+EXPORT_SYMBOL(kernstart_addr);
 
 void free_initmem(void)
 {
