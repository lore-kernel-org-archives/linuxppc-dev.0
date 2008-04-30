Return-Path: <randy.dunlap@oracle.com>
Received: from rgminet01.oracle.com (rgminet01.oracle.com [148.87.113.118])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 9A692DDF23
	for <linuxppc-dev@ozlabs.org>; Thu,  1 May 2008 09:47:09 +1000 (EST)
Date: Wed, 30 Apr 2008 16:45:58 -0700
From: Randy Dunlap <randy.dunlap@oracle.com>
To: lkml <linux-kernel@vger.kernel.org>
Subject: [PATCH] rapidio: fix current kernel-doc notation
Message-Id: <20080430164558.03b5f517.randy.dunlap@oracle.com>
In-Reply-To: <4818EFEC.4080003@oracle.com>
References: <Pine.LNX.4.64.0804292009000.18219@shark.he.net>
	<20080430113500.dfe21880.akpm@linux-foundation.org>
	<51A34080-7981-4958-B225-4921FC95B84A@kernel.crashing.org>
	<20080430121239.28492328.akpm@linux-foundation.org>
	<18456.60948.463017.139935@cargo.ozlabs.ibm.com>
	<20080430151149.063920cf.randy.dunlap@oracle.com>
	<63DC9937-3C82-4744-8281-B9FDB941FEE1@kernel.crashing.org>
	<4818EFEC.4080003@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	torvalds@linux-foundation.org, Wei.Zhang@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Randy Dunlap <randy.dunlap@oracle.com>

Fix current (-git16) missing docbook/kernel-doc notation in RapidIO files.

Warning(linux-2.6.25-git16//include/linux/rio.h:187): No description found for parameter 'sys_size'
Warning(linux-2.6.25-git16//include/linux/rio.h:187): No description found for parameter 'phy_type'

Warning(linux-2.6.25-git16//arch/powerpc/sysdev/fsl_rio.c:188): No description found for parameter 'mport'
Warning(linux-2.6.25-git16//arch/powerpc/sysdev/fsl_rio.c:224): No description found for parameter 'mport'
Warning(linux-2.6.25-git16//arch/powerpc/sysdev/fsl_rio.c:245): No description found for parameter 'mport'
Warning(linux-2.6.25-git16//arch/powerpc/sysdev/fsl_rio.c:270): No description found for parameter 'mport'
Warning(linux-2.6.25-git16//arch/powerpc/sysdev/fsl_rio.c:311): No description found for parameter 'mport'
Warning(linux-2.6.25-git16//arch/powerpc/sysdev/fsl_rio.c:996): No description found for parameter 'dev'

Signed-off-by: Randy Dunlap <randy.dunlap@oracle.com>
---
 arch/powerpc/sysdev/fsl_rio.c |    9 +++++++--
 include/linux/rio.h           |    2 ++
 2 files changed, 9 insertions(+), 2 deletions(-)

--- linux-2.6.25-git16.orig/include/linux/rio.h
+++ linux-2.6.25-git16/include/linux/rio.h
@@ -161,6 +161,8 @@ enum rio_phy_type {
  * @ops: configuration space functions
  * @id: Port ID, unique among all ports
  * @index: Port index, unique among all port interfaces of the same type
+ * @sys_size: RapidIO common transport system size
+ * @phy_type: RapidIO phy type
  * @name: Port name string
  * @priv: Master port private data
  */
--- linux-2.6.25-git16.orig/arch/powerpc/sysdev/fsl_rio.c
+++ linux-2.6.25-git16/arch/powerpc/sysdev/fsl_rio.c
@@ -176,6 +176,7 @@ struct rio_priv {
 
 /**
  * fsl_rio_doorbell_send - Send a MPC85xx doorbell message
+ * @mport: RapidIO master port info
  * @index: ID of RapidIO interface
  * @destid: Destination ID of target device
  * @data: 16-bit info field of RapidIO doorbell message
@@ -211,6 +212,7 @@ static int fsl_rio_doorbell_send(struct 
 
 /**
  * fsl_local_config_read - Generate a MPC85xx local config space read
+ * @mport: RapidIO master port info
  * @index: ID of RapdiIO interface
  * @offset: Offset into configuration space
  * @len: Length (in bytes) of the maintenance transaction
@@ -232,6 +234,7 @@ static int fsl_local_config_read(struct 
 
 /**
  * fsl_local_config_write - Generate a MPC85xx local config space write
+ * @mport: RapidIO master port info
  * @index: ID of RapdiIO interface
  * @offset: Offset into configuration space
  * @len: Length (in bytes) of the maintenance transaction
@@ -254,6 +257,7 @@ static int fsl_local_config_write(struct
 
 /**
  * fsl_rio_config_read - Generate a MPC85xx read maintenance transaction
+ * @mport: RapidIO master port info
  * @index: ID of RapdiIO interface
  * @destid: Destination ID of transaction
  * @hopcount: Number of hops to target device
@@ -295,6 +299,7 @@ fsl_rio_config_read(struct rio_mport *mp
 
 /**
  * fsl_rio_config_write - Generate a MPC85xx write maintenance transaction
+ * @mport: RapidIO master port info
  * @index: ID of RapdiIO interface
  * @destid: Destination ID of transaction
  * @hopcount: Number of hops to target device
@@ -985,8 +990,8 @@ static inline void fsl_rio_info(struct d
 }
 
 /**
- * fsl_rio_setup - Setup MPC85xx RapidIO interface
- * @fsl_rio_setup - Setup Freescale PowerPC RapidIO interface
+ * fsl_rio_setup - Setup Freescale PowerPC RapidIO interface
+ * @dev: of_device pointer
  *
  * Initializes MPC85xx RapidIO hardware interface, configures
  * master port with system-specific info, and registers the
