Return-Path: <schihei@de.ibm.com>
Received: from mtagate1.de.ibm.com (mtagate1.de.ibm.com [195.212.29.150])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate1.de.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 184B667D96
	for <linuxppc-dev@ozlabs.org>; Thu, 27 Apr 2006 20:49:38 +1000 (EST)
Received: from d12nrmr1607.megacenter.de.ibm.com
	(d12nrmr1607.megacenter.de.ibm.com [9.149.167.49])
	by mtagate1.de.ibm.com (8.13.6/8.13.6) with ESMTP id k3RAnTeU082540
	for <linuxppc-dev@ozlabs.org>; Thu, 27 Apr 2006 10:49:29 GMT
Received: from d12av03.megacenter.de.ibm.com (d12av03.megacenter.de.ibm.com
	[9.149.165.213])
	by d12nrmr1607.megacenter.de.ibm.com (8.12.10/NCO/VER6.8) with ESMTP id
	k3RAoZXl118170
	for <linuxppc-dev@ozlabs.org>; Thu, 27 Apr 2006 12:50:35 +0200
Received: from d12av03.megacenter.de.ibm.com (loopback [127.0.0.1])
	by d12av03.megacenter.de.ibm.com (8.12.11/8.13.3) with ESMTP id
	k3RAnSTE018637
	for <linuxppc-dev@ozlabs.org>; Thu, 27 Apr 2006 12:49:28 +0200
Message-ID: <4450A1D4.3030200@de.ibm.com>
Date: Thu, 27 Apr 2006 12:49:56 +0200
From: Heiko J Schick <schihei@de.ibm.com>
MIME-Version: 1.0
To: openib-general@openib.org, Christoph Raisch <RAISCH@de.ibm.com>,
	Hoang-Nam Nguyen <HNGUYEN@de.ibm.com>, Marcus Eder <MEDER@de.ibm.com>,
	schihei@de.ibm.com, linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org
Subject: [PATCH 16/16] ehca: PHYP abstraction layer
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Signed-off-by: Heiko J Schick <schickhj@de.ibm.com>


  hcp_phyp.c |   97 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
  hcp_phyp.h |   97 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
  2 files changed, 194 insertions(+)



--- linux-2.6.17-rc2-orig/drivers/infiniband/hw/ehca/hcp_phyp.h	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.17-rc2/drivers/infiniband/hw/ehca/hcp_phyp.h	2006-03-09 15:05:14.000000000 +0100
@@ -0,0 +1,97 @@
+/*
+ *  IBM eServer eHCA Infiniband device driver for Linux on POWER
+ *
+ *  Firmware calls
+ *
+ *  Authors: Christoph Raisch <raisch@de.ibm.com>
+ *           Hoang-Nam Nguyen <hnguyen@de.ibm.com>
+ *           Waleri Fomin <fomin@de.ibm.com>
+ *           Gerd Bayer <gerd.bayer@de.ibm.com>
+ *
+ *  Copyright (c) 2005 IBM Corporation
+ *
+ *  All rights reserved.
+ *
+ *  This source code is distributed under a dual license of GPL v2.0 and OpenIB
+ *  BSD.
+ *
+ * OpenIB BSD License
+ *
+ * Redistribution and use in source and binary forms, with or without
+ * modification, are permitted provided that the following conditions are met:
+ *
+ * Redistributions of source code must retain the above copyright notice, this
+ * list of conditions and the following disclaimer.
+ *
+ * Redistributions in binary form must reproduce the above copyright notice,
+ * this list of conditions and the following disclaimer in the documentation
+ * and/or other materials
+ * provided with the distribution.
+ *
+ * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
+ * AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
+ * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
+ * ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE
+ * LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
+ * CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
+ * SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR
+ * BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER
+ * IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
+ * ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
+ * POSSIBILITY OF SUCH DAMAGE.
+ *
+ *  $Id: hcp_phyp.h,v 1.5 2006/03/09 14:05:14 schickhj Exp $
+ */
+
+#ifndef __HCP_PHYP_H__
+#define __HCP_PHYP_H__
+
+
+/* eHCA page (mapped into memory)
+    resource to access eHCA register pages in CPU address space
+*/
+struct h_galpa {
+	u64 fw_handle;
+	/* for pSeries this is a 64bit memory address where
+	   I/O memory is mapped into CPU address space (kv) */
+};
+
+/*
+   resource to access eHCA address space registers, all types
+*/
+struct h_galpas {
+	u32 pid;		/*PID of userspace galpa checking */
+	struct h_galpa user;	/* user space accessible resource,
+				   set to 0 if unused */
+	struct h_galpa kernel;	/* kernel space accessible resource,
+				   set to 0 if unused */
+};
+
+inline static u64 hipz_galpa_load(struct h_galpa galpa, u32 offset)
+{
+	u64 addr = galpa.fw_handle + offset;
+	u64 out;
+	EDEB_EN(7, "addr=%lx offset=%x ", addr, offset);
+	out = *(u64 *) addr;
+	EDEB_EX(7, "addr=%lx value=%lx", addr, out);
+	return out;
+};
+
+inline static void hipz_galpa_store(struct h_galpa galpa, u32 offset, u64 value)
+{
+	u64 addr = galpa.fw_handle + offset;
+	EDEB(7, "addr=%lx offset=%x value=%lx", addr,
+	     offset, value);
+	*(u64 *) addr = value;
+};
+
+int hcp_galpas_ctor(struct h_galpas *galpas,
+		    u64 paddr_kernel, u64 paddr_user);
+
+int hcp_galpas_dtor(struct h_galpas *galpas);
+
+int hcall_map_page(u64 physaddr, u64 * mapaddr);
+
+int hcall_unmap_page(u64 mapaddr);
+
+#endif
--- linux-2.6.17-rc2-orig/drivers/infiniband/hw/ehca/hcp_phyp.c	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.17-rc2/drivers/infiniband/hw/ehca/hcp_phyp.c	2006-03-17 13:31:35.000000000 +0100
@@ -0,0 +1,97 @@
+/*
+ *  IBM eServer eHCA Infiniband device driver for Linux on POWER
+ *
+ *   load store abstraction for ehca register access with tracing
+ *
+ *  Authors: Christoph Raisch <raisch@de.ibm.com>
+ *           Hoang-Nam Nguyen <hnguyen@de.ibm.com>
+ *
+ *  Copyright (c) 2005 IBM Corporation
+ *
+ *  All rights reserved.
+ *
+ *  This source code is distributed under a dual license of GPL v2.0 and OpenIB
+ *  BSD.
+ *
+ * OpenIB BSD License
+ *
+ * Redistribution and use in source and binary forms, with or without
+ * modification, are permitted provided that the following conditions are met:
+ *
+ * Redistributions of source code must retain the above copyright notice, this
+ * list of conditions and the following disclaimer.
+ *
+ * Redistributions in binary form must reproduce the above copyright notice,
+ * this list of conditions and the following disclaimer in the documentation
+ * and/or other materials
+ * provided with the distribution.
+ *
+ * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
+ * AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
+ * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
+ * ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE
+ * LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
+ * CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
+ * SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR
+ * BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER
+ * IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
+ * ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
+ * POSSIBILITY OF SUCH DAMAGE.
+ *
+ *  $Id: hcp_phyp.c,v 1.7 2006/03/17 12:31:35 nguyen Exp $
+ */
+
+#define DEB_PREFIX "PHYP"
+
+#include "ehca_kernel.h"
+#include "ehca_classes.h"
+#include "hipz_hw.h"
+
+int hcall_map_page(u64 physaddr, u64 * mapaddr)
+{
+	*mapaddr = (u64)(ioremap(physaddr, 4096));
+
+	EDEB(7, "ioremap physaddr=%lx mapaddr=%lx", physaddr, *mapaddr);
+	return 0;
+}
+
+int hcall_unmap_page(u64 mapaddr)
+{
+	EDEB(7, "mapaddr=%lx", mapaddr);
+	iounmap((volatile void __iomem*)mapaddr);
+	return 0;
+}
+
+int hcp_galpas_ctor(struct h_galpas *galpas,
+		    u64 paddr_kernel, u64 paddr_user)
+{
+	int rc = 0;
+
+	rc = hcall_map_page(paddr_kernel, &galpas->kernel.fw_handle);
+	if (rc != 0)
+		return (rc);
+
+	galpas->user.fw_handle = paddr_user;
+
+	EDEB(7, "paddr_kernel=%lx paddr_user=%lx galpas->kernel=%lx"
+	     " galpas->user=%lx",
+	     paddr_kernel, paddr_user, galpas->kernel.fw_handle,
+	     galpas->user.fw_handle);
+
+	return (rc);
+}
+
+int hcp_galpas_dtor(struct h_galpas *galpas)
+{
+	int rc = 0;
+
+	if (galpas->kernel.fw_handle != 0)
+		rc = hcall_unmap_page(galpas->kernel.fw_handle);
+
+	if (rc != 0)
+		return (rc);
+
+	galpas->user.fw_handle = galpas->kernel.fw_handle = 0;
+
+	return rc;
+}
