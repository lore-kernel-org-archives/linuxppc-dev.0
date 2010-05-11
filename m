Return-Path: <sonny@us.ibm.com>
Received: from e6.ny.us.ibm.com (e6.ny.us.ibm.com [32.97.182.146])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e6.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id C6232B7D77
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 11 May 2010 11:13:48 +1000 (EST)
Received: from d01relay07.pok.ibm.com (d01relay07.pok.ibm.com [9.56.227.147])
	by e6.ny.us.ibm.com (8.14.3/8.13.1) with ESMTP id o4B1BhiR010581
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 May 2010 21:11:43 -0400
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay07.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o4B1DgKx2089082
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 May 2010 21:13:44 -0400
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP id
	o4B1DgjP027470
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 May 2010 21:13:42 -0400
Date: Mon, 10 May 2010 20:13:41 -0500
From: Sonny Rao <sonnyrao@us.ibm.com>
To: benh@kernel.crashing.org
Subject: [PATCH] need check for devices with bad status status property in
	__of_scan_bus()
Message-ID: <20100511011341.GO4036@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: sonnyrao@us.ibm.com, linuxppc-dev@lists.ozlabs.org, anton@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Ben, we ran into an issue where it looks like we're not
properly ignoring a pci device with a non-good status property
when we walk the device tree and create our device nodes.

However, the EEH init code does look for the property and 
disables EEH on these devices.   This leaves us in an
inconsistent where we are poking at a supposedly bad
piece of hardware and RTAS will block our config cycles 
because EEH isn't enabled anyway.

This has only been compile tested.

Signed-of-by: Sonny Rao <sonnyrao@linux.vnet.ibm.com>

Index: common/arch/powerpc/kernel/pci_of_scan.c
===================================================================
--- common/arch/powerpc/kernel.orig/pci_of_scan.c	2010-05-10 20:00:40.000000000 -0500
+++ common/arch/powerpc/kernel/pci_of_scan.c	2010-05-10 20:03:04.000000000 -0500
@@ -310,6 +310,8 @@ static void __devinit __of_scan_bus(stru
 	/* Scan direct children */
 	for_each_child_of_node(node, child) {
 		pr_debug("  * %s\n", child->full_name);
+		if (!of_device_is_available(child))
+			continue;
 		reg = of_get_property(child, "reg", &reglen);
 		if (reg == NULL || reglen < 20)
 			continue;


-- 
Sonny Rao, LTC OzLabs, BML team
