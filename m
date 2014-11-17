Return-Path: <nfont@linux.vnet.ibm.com>
Received: from e9.ny.us.ibm.com (e9.ny.us.ibm.com [32.97.182.139])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 62A711A0035
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Nov 2014 08:50:20 +1100 (AEDT)
Received: from /spool/local
 by e9.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <nfont@linux.vnet.ibm.com>;
 Mon, 17 Nov 2014 16:50:18 -0500
Received: from b01cxnp22035.gho.pok.ibm.com (b01cxnp22035.gho.pok.ibm.com
 [9.57.198.25])
 by d01dlp01.pok.ibm.com (Postfix) with ESMTP id 35F6738C8026
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 17 Nov 2014 16:48:40 -0500 (EST)
Received: from d01av05.pok.ibm.com (d01av05.pok.ibm.com [9.56.224.195])
 by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 sAHLoELp27066610
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 17 Nov 2014 21:50:14 GMT
Received: from d01av05.pok.ibm.com (localhost [127.0.0.1])
 by d01av05.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 sAHLoD75004657
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 17 Nov 2014 16:50:14 -0500
Message-ID: <546A6D94.2040207@linux.vnet.ibm.com>
Date: Mon, 17 Nov 2014 15:50:12 -0600
From: Nathan Fontenot <nfont@linux.vnet.ibm.com>
MIME-Version: 1.0
To: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH v2 2/6] pseries: Update of_drconf_cell struct for endian-ness
References: <546A6C23.1080800@linux.vnet.ibm.com>
In-Reply-To: <546A6C23.1080800@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The of_drconf_cell defines each LMB for a system in the device tree property
ibm,dynamic-reconfiguration-memory/ibm,dynamic-memory. The values are
in BE format by definition, this patch updates the of_drconf_cell struct
to reflect the proper endian-ness.

Signed-off-by: Nathan Fontenot <nfont@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/prom.h |   10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/include/asm/prom.h b/arch/powerpc/include/asm/prom.h
index 7f436ba..6f1cbe3 100644
--- a/arch/powerpc/include/asm/prom.h
+++ b/arch/powerpc/include/asm/prom.h
@@ -85,11 +85,11 @@ extern int of_get_ibm_chip_id(struct device_node *np);
  * ibm,dynamic-reconfiguration-memory/ibm,dynamic-memory
  */
 struct of_drconf_cell {
-	u64	base_addr;
-	u32	drc_index;
-	u32	reserved;
-	u32	aa_index;
-	u32	flags;
+	__be64	base_addr;
+	__be32	drc_index;
+	__be32	reserved;
+	__be32	aa_index;
+	__be32	flags;
 };
 
 #define DRCONF_MEM_ASSIGNED	0x00000008
