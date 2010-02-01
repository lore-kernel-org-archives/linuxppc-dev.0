Return-Path: <jschopp@austin.ibm.com>
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e31.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 547BBB7D67
	for <linuxppc-dev@ozlabs.org>; Tue,  2 Feb 2010 09:51:20 +1100 (EST)
Received: from d03relay03.boulder.ibm.com (d03relay03.boulder.ibm.com
	[9.17.195.228])
	by e31.co.us.ibm.com (8.14.3/8.13.1) with ESMTP id o11MgvwY020435
	for <linuxppc-dev@ozlabs.org>; Mon, 1 Feb 2010 15:42:57 -0700
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay03.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o11Mp3jP078944
	for <linuxppc-dev@ozlabs.org>; Mon, 1 Feb 2010 15:51:04 -0700
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP
	id o11Mp3E0002162
	for <linuxppc-dev@ozlabs.org>; Mon, 1 Feb 2010 15:51:03 -0700
Received: from [9.53.41.167] (jschopp-laptop-009053041167.austin.ibm.com
	[9.53.41.167])
	by d03av02.boulder.ibm.com (8.14.3/8.13.1/NCO v10.0 AVin) with ESMTP id
	o11Mp3vu002140
	for <linuxppc-dev@ozlabs.org>; Mon, 1 Feb 2010 15:51:03 -0700
Subject: [PATCHv2 2/2] Update ibm,client-architecture call field based on
	device tree
From: Joel Schopp <jschopp@austin.ibm.com>
To: linuxppc-dev@ozlabs.org
In-Reply-To: <1263501674.4869.142.camel@jschopp-laptop>
References: <1263501508.4869.133.camel@jschopp-laptop>
	<1263501674.4869.142.camel@jschopp-laptop>
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 01 Feb 2010 16:51:02 -0600
Message-ID: <1265064662.5391.19.camel@jschopp-laptop>
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

In the previous patch the client-architecture field for the number of
cores supported is set statically as high as is possible.  However, that
static setting could be too high if the system supports smt, resulting
in cpus assigned to Linux that are not booted.  This patch reads the
device tree (before it is unflattened) to determine the amount of smt.
It then dynamically updates the entires in the array with the proper
number of cores supported.  Tests show this correctly detecting SMT4 on
a Power7 and still booting all the supported cores on a large machine.

Signed-off-by: Joel Schopp <jschopp@austin.ibm.com> 
---
Index: linux-2.6.git/arch/powerpc/kernel/prom_init.c
===================================================================
--- linux-2.6.git.orig/arch/powerpc/kernel/prom_init.c
+++ linux-2.6.git/arch/powerpc/kernel/prom_init.c
@@ -807,13 +807,55 @@ static struct fake_elf {
 	}
 };
 
+static int __init prom_smt_way(void)
+{
+	phandle node;
+	char type[64];
+	unsigned int plen;
+
+	for (node = 0; prom_next_node(&node); ) {
+		type[0] = 0;
+		prom_getprop(node, "device_type", type, sizeof(type));
+
+		if (strcmp(type, RELOC("cpu")))
+			continue;
+
+		/*
+		 * There is an entry for each smt thread, each entry being
+		 * 4 bytes long.  All cpus should have the same number of
+		 * smt threads, so return after finding the first.
+		 */
+		plen = prom_getproplen(node, "ibm,ppc-interrupt-server#s");
+		prom_printf("smt threads per core %x\n", (unsigned long) plen);
+		if (plen >= 4)
+			return plen / 4;
+	}
+	/*
+	 * If things go wrong and we get here fallback to SMT1
+	 */
+	prom_debug("unable to determine smt from device tree, guessing smt1\n");
+	return 1;
+
+}
+
+
 static void __init prom_send_capabilities(void)
 {
 	ihandle elfloader, root;
 	prom_arg_t ret;
+	u32 *cores;
 
 	root = call_prom("open", 1, 1, ADDR("/"));
 	if (root != 0) {
+		/*
+		 * If you add to the struct, please be sure the 100 index
+		 * didn't change.  The BUILD_BUG_ON is a reminder.
+		 */
+		cores = (u32 *) &ibm_architecture_vec[100];
+		if(*cores != NR_CPUS)
+			prom_printf("client-architecture structure corrupted\n");
+		*cores = (NR_CPUS / prom_smt_way());
+		prom_printf("setting client-architecture cores to %x\n", *cores);
 		/* try calling the ibm,client-architecture-support method */
 		prom_printf("Calling ibm,client-architecture-support...");
 		if (call_prom_ret("call-method", 3, 2, &ret,
