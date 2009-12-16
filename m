Return-Path: <mjw@linux.vnet.ibm.com>
Received: from e9.ny.us.ibm.com (e9.ny.us.ibm.com [32.97.182.139])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e9.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 62987B6F2B
	for <linuxppc-dev@ozlabs.org>; Thu, 17 Dec 2009 04:53:30 +1100 (EST)
Received: from d01relay05.pok.ibm.com (d01relay05.pok.ibm.com [9.56.227.237])
	by e9.ny.us.ibm.com (8.14.3/8.13.1) with ESMTP id nBGHkoIp024215
	for <linuxppc-dev@ozlabs.org>; Wed, 16 Dec 2009 12:46:50 -0500
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
	by d01relay05.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	nBGHrRQF140988
	for <linuxppc-dev@ozlabs.org>; Wed, 16 Dec 2009 12:53:27 -0500
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
	by d01av03.pok.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP id
	nBGHrRKp021453
	for <linuxppc-dev@ozlabs.org>; Wed, 16 Dec 2009 15:53:27 -0200
Received: from [9.65.3.128] (sig-9-65-3-128.mts.ibm.com [9.65.3.128])
	by d01av03.pok.ibm.com (8.14.3/8.13.1/NCO v10.0 AVin) with ESMTP id
	nBGHrQd2021387
	for <linuxppc-dev@ozlabs.org>; Wed, 16 Dec 2009 15:53:26 -0200
Subject: [PATCH] powerpc: fix cpu name in show-cpuinfo
From: Michael Wolf <mjw@linux.vnet.ibm.com>
To: linuxppc-dev@ozlabs.org
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 16 Dec 2009 11:53:23 -0600
Message-ID: <1260986003.14960.4.camel@mx3>
Mime-Version: 1.0
Reply-To: mjw@us.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

When looking at /proc/cpuinfo the cpuname will be 'unknown"
if the pvr mask is 0.  This is the case for the kernel running
on new or unknown hardware.  However the cpuname is always specified
so use the name regardless of the pvr mask.

Signed-off-by: Mike Wolf <mjw@us.ibm.com>
---
--- mainline.orig/arch/powerpc/kernel/setup-common.c	2009-12-15
11:33:36.000000000 -0600
+++ mainline/arch/powerpc/kernel/setup-common.c	2009-12-16
11:26:26.000000000 -0600
@@ -219,7 +219,7 @@
 	seq_printf(m, "processor\t: %lu\n", cpu_id);
 	seq_printf(m, "cpu\t\t: ");
 
-	if (cur_cpu_spec->pvr_mask)
+	if (cur_cpu_spec->cpu_name)
 		seq_printf(m, "%s", cur_cpu_spec->cpu_name);
 	else
 		seq_printf(m, "unknown (%08x)", pvr);
