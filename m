Return-Path: <imunsie@au1.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id EEC941A0B68
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  8 Dec 2014 19:18:47 +1100 (AEDT)
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 7FE761400E7
 for <linuxppc-dev@ozlabs.org>; Mon,  8 Dec 2014 19:18:47 +1100 (AEDT)
Received: from /spool/local
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <imunsie@au1.ibm.com>;
 Mon, 8 Dec 2014 18:18:46 +1000
From: "Ian Munsie" <imunsie@au1.ibm.com>
To: mpe <mpe@ellerman.id.au>
Subject: [PATCH 5/7] CXL: Disable AFU debug flag
Date: Mon,  8 Dec 2014 19:17:59 +1100
Message-Id: <1418026681-14787-5-git-send-email-imunsie@au.ibm.com>
In-Reply-To: <1418026681-14787-1-git-send-email-imunsie@au.ibm.com>
References: <1418026681-14787-1-git-send-email-imunsie@au.ibm.com>
Cc: cbe-oss-dev <cbe-oss-dev@lists.ozlabs.org>, mikey <mikey@neuling.org>,
 arnd <arnd@arndb.de>, "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 greg <greg@kroah.com>, linux-kernel <linux-kernel@vger.kernel.org>,
 linuxppc-dev <linuxppc-dev@ozlabs.org>, anton <anton@samba.org>,
 imunsie <imunsie@au1.ibm.com>, jk <jk@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Ian Munsie <imunsie@au1.ibm.com>

Upon inspection of the implementation specific registers, it was
discovered that the high bit of the implementation specific RXCTL
register was enabled, which enables the DEADB00F debug feature.

The debug feature causes MMIO reads to a disabled AFU to respond with
0xDEADB00F instead of all Fs. In general this should not be visible as
the kernel will only allow MMIO access to enabled AFUs, but there may be
some circumstances where an AFU may become disabled while it is use.
One such case would be an AFU designed to only be used in the dedicated
process mode and to disable itself after it has completed it's work
(however even in that case the effects of this debug flag would be
limited as the userspace application must have completed any required
MMIO accesses before the AFU disables itself with or without the flag).

This patch removes the debug flag and replaces the magic value
programmed into this register with a preprocessor define so it is
clearer what the rest of this initialisation does.

Signed-off-by: Ian Munsie <imunsie@au1.ibm.com>
---
 drivers/misc/cxl/cxl.h | 7 +++++++
 drivers/misc/cxl/pci.c | 2 +-
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/misc/cxl/cxl.h b/drivers/misc/cxl/cxl.h
index 7c05239..c1f8aa6 100644
--- a/drivers/misc/cxl/cxl.h
+++ b/drivers/misc/cxl/cxl.h
@@ -287,6 +287,13 @@ static const cxl_p2n_reg_t CXL_PSL_WED_An     = {0x0A0};
 #define CXL_PE_SOFTWARE_STATE_S (1ul << (31 - 30)) /* Suspend */
 #define CXL_PE_SOFTWARE_STATE_T (1ul << (31 - 31)) /* Terminate */
 
+/****** CXL_PSL_RXCTL_An (Implementation Specific) **************************
+ * Controls AFU Hang Pulse, which sets the timeout for the AFU to respond to
+ * the PSL for any response (except MMIO). Timeouts will occur between 1x to 2x
+ * of the hang pulse frequency.
+ */
+#define CXL_PSL_RXCTL_AFUHP_4S      0x7000000000000000ULL
+
 /* SPA->sw_command_status */
 #define CXL_SPA_SW_CMD_MASK         0xffff000000000000ULL
 #define CXL_SPA_SW_CMD_TERMINATE    0x0001000000000000ULL
diff --git a/drivers/misc/cxl/pci.c b/drivers/misc/cxl/pci.c
index 0f2cc9f..2ccd0a9 100644
--- a/drivers/misc/cxl/pci.c
+++ b/drivers/misc/cxl/pci.c
@@ -348,7 +348,7 @@ static int init_implementation_afu_regs(struct cxl_afu *afu)
 	cxl_p1n_write(afu, CXL_PSL_COALLOC_A, 0xFF000000FEFEFEFEULL);
 	/* for debugging with trace arrays */
 	cxl_p1n_write(afu, CXL_PSL_SLICE_TRACE, 0x0000FFFF00000000ULL);
-	cxl_p1n_write(afu, CXL_PSL_RXCTL_A, 0xF000000000000000ULL);
+	cxl_p1n_write(afu, CXL_PSL_RXCTL_A, CXL_PSL_RXCTL_AFUHP_4S);
 
 	return 0;
 }
-- 
2.1.3
