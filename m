Return-Path: <alexs@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id E58B4B7085
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed,  8 Jul 2009 00:08:03 +1000 (EST)
Received: from mtagate6.de.ibm.com (mtagate6.de.ibm.com [195.212.29.155])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate6.de.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 3E2ECDDD1B
	for <linuxppc-dev@ozlabs.org>; Wed,  8 Jul 2009 00:08:02 +1000 (EST)
Received: from d12nrmr1607.megacenter.de.ibm.com
	(d12nrmr1607.megacenter.de.ibm.com [9.149.167.49])
	by mtagate6.de.ibm.com (8.14.3/8.13.8) with ESMTP id n67E71WQ611976
	for <linuxppc-dev@ozlabs.org>; Tue, 7 Jul 2009 14:07:02 GMT
Received: from d12av02.megacenter.de.ibm.com (d12av02.megacenter.de.ibm.com
	[9.149.165.228])
	by d12nrmr1607.megacenter.de.ibm.com (8.13.8/8.13.8/NCO v9.2) with
	ESMTP id n67E6uds2367668
	for <linuxppc-dev@ozlabs.org>; Tue, 7 Jul 2009 16:06:59 +0200
Received: from d12av02.megacenter.de.ibm.com (loopback [127.0.0.1])
	by d12av02.megacenter.de.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id n67E6ha4007227
	for <linuxppc-dev@ozlabs.org>; Tue, 7 Jul 2009 16:06:44 +0200
Date: Tue, 7 Jul 2009 16:06:39 +0200
From: Alexander Schmidt <alexs@linux.vnet.ibm.com>
To: Roland Dreier <rolandd@cisco.com>
Subject: [PATCH] ehca: use port autodetect mode as default
Message-ID: <20090707160639.6b45bf4d@BL3D1974.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: of-ewg <ewg@lists.openfabrics.org>, lkml <linux-kernel@vger.kernel.org>,
	linuxppc-dev <linuxppc-dev@ozlabs.org>,
	Christoph Raisch <raisch@de.ibm.com>,
	of-general <general@lists.openfabrics.org>,
	Hoang-Nam Nguyen <HNGUYEN@linux.vnet.ibm.com>,
	Stefan Roscher <stefan.roscher@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch sets the port autodetect mode as default for the ehca driver. The
autodetect code has been in the kernel for several releases now and has
proved to be stable.

---
Roland, please queue this change for 2.6.32 if you are okay with it.

 drivers/infiniband/hw/ehca/ehca_main.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

--- infiniband.git.orig/drivers/infiniband/hw/ehca/ehca_main.c
+++ infiniband.git/drivers/infiniband/hw/ehca/ehca_main.c
@@ -52,7 +52,7 @@
 #include "ehca_tools.h"
 #include "hcp_if.h"
 
-#define HCAD_VERSION "0028"
+#define HCAD_VERSION "0029"
 
 MODULE_LICENSE("Dual BSD/GPL");
 MODULE_AUTHOR("Christoph Raisch <raisch@de.ibm.com>");
@@ -64,7 +64,7 @@ static int ehca_hw_level      = 0;
 static int ehca_poll_all_eqs  = 1;
 
 int ehca_debug_level   = 0;
-int ehca_nr_ports      = 2;
+int ehca_nr_ports      = -1;
 int ehca_use_hp_mr     = 0;
 int ehca_port_act_time = 30;
 int ehca_static_rate   = -1;
@@ -95,8 +95,8 @@ MODULE_PARM_DESC(hw_level,
 		 "Hardware level (0: autosensing (default), "
 		 "0x10..0x14: eHCA, 0x20..0x23: eHCA2)");
 MODULE_PARM_DESC(nr_ports,
-		 "number of connected ports (-1: autodetect, 1: port one only, "
-		 "2: two ports (default)");
+		 "number of connected ports (-1: autodetect (default), "
+		 "1: port one only, 2: two ports)");
 MODULE_PARM_DESC(use_hp_mr,
 		 "Use high performance MRs (default: no)");
 MODULE_PARM_DESC(port_act_time,
