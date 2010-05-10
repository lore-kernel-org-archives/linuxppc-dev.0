Return-Path: <brking@linux.vnet.ibm.com>
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e34.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 52AFFB7F4C
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 11 May 2010 06:53:41 +1000 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e34.co.us.ibm.com (8.14.3/8.13.1) with ESMTP id o4AKk9AS009647
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 May 2010 14:46:09 -0600
Received: from d03av05.boulder.ibm.com (d03av05.boulder.ibm.com [9.17.195.85])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP
	id o4AKrGR4025696
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 May 2010 14:53:19 -0600
Received: from d03av05.boulder.ibm.com (loopback [127.0.0.1])
	by d03av05.boulder.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP
	id o4AKrGYs017826
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 May 2010 14:53:16 -0600
Message-Id: <201005102053.o4AKrFJL017810@d03av05.boulder.ibm.com>
Subject: [PATCHv2 2/3] powerpc: Add power management support to VIO bus
To: benh@kernel.crashing.org
From: Brian King <brking@linux.vnet.ibm.com>
Date: Mon, 10 May 2010 15:53:12 -0500
Cc: brking@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


Adds support for suspend/resume for VIO devices. This is needed for
support for HMC initiated hibernation.

Signed-off-by: Brian King <brking@linux.vnet.ibm.com>
---

 arch/powerpc/kernel/vio.c |    1 +
 1 file changed, 1 insertion(+)

diff -puN arch/powerpc/kernel/vio.c~powerpc_vio_bus_pm arch/powerpc/kernel/vio.c
--- linux-2.6/arch/powerpc/kernel/vio.c~powerpc_vio_bus_pm	2010-05-10 11:12:15.000000000 -0500
+++ linux-2.6-bjking1/arch/powerpc/kernel/vio.c	2010-05-10 11:12:15.000000000 -0500
@@ -1365,6 +1365,7 @@ static struct bus_type vio_bus_type = {
 	.match = vio_bus_match,
 	.probe = vio_bus_probe,
 	.remove = vio_bus_remove,
+	.pm = GENERIC_SUBSYS_PM_OPS,
 };
 
 /**
_
