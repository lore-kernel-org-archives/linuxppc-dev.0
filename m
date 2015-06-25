Return-Path: <maddy@linux.vnet.ibm.com>
Received: from e28smtp01.in.ibm.com (e28smtp01.in.ibm.com [122.248.162.1])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 971381A0FD8
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Jun 2015 19:57:11 +1000 (AEST)
Received: from /spool/local
 by e28smtp01.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <maddy@linux.vnet.ibm.com>;
 Thu, 25 Jun 2015 15:27:09 +0530
Received: from d28relay01.in.ibm.com (d28relay01.in.ibm.com [9.184.220.58])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id C6A7AE005B
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Jun 2015 15:30:42 +0530 (IST)
Received: from d28av04.in.ibm.com (d28av04.in.ibm.com [9.184.220.66])
 by d28relay01.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t5P9uuv433685606
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Jun 2015 15:26:56 +0530
Received: from d28av04.in.ibm.com (localhost [127.0.0.1])
 by d28av04.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t5P9utC1003254
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Jun 2015 15:26:56 +0530
From: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Cc: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>,
 Stewart Smith <stewart@linux.vnet.ibm.com>, Jeremy Kerr <jk@ozlabs.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Paul Mackerras <paulus@samba.org>, Anton Blanchard <anton@samba.org>,
 Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>,
 Anshuman Khandual <khandual@linux.vnet.ibm.com>,
 Stephane Eranian <eranian@google.com>
Subject: [PATCH v3 2/7]powerpc/powernv: Add OPAL support for Nest PMU
Date: Thu, 25 Jun 2015 15:26:14 +0530
Message-Id: <1435226179-28618-3-git-send-email-maddy@linux.vnet.ibm.com>
In-Reply-To: <1435226179-28618-1-git-send-email-maddy@linux.vnet.ibm.com>
References: <1435226179-28618-1-git-send-email-maddy@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Nest Counters can be configured via PORE Engine and OPAL
provides an interface to start/stop it.

OPAL side patches are posted in the skiboot mailing.

Cc: Stewart Smith <stewart@linux.vnet.ibm.com>
Cc: Jeremy Kerr <jk@ozlabs.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Anton Blanchard <anton@samba.org>
Cc: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
Cc: Anshuman Khandual <khandual@linux.vnet.ibm.com>
Cc: Stephane Eranian <eranian@google.com>
Signed-off-by: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/opal-api.h            | 3 ++-
 arch/powerpc/include/asm/opal.h                | 2 ++
 arch/powerpc/platforms/powernv/opal-wrappers.S | 1 +
 3 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/opal-api.h b/arch/powerpc/include/asm/opal-api.h
index 0321a90..8011a75 100644
--- a/arch/powerpc/include/asm/opal-api.h
+++ b/arch/powerpc/include/asm/opal-api.h
@@ -153,7 +153,8 @@
 #define OPAL_FLASH_READ				110
 #define OPAL_FLASH_WRITE			111
 #define OPAL_FLASH_ERASE			112
-#define OPAL_LAST				112
+#define OPAL_NEST_IMA_CONTROL			116
+#define OPAL_LAST				116
 
 /* Device tree flags */
 
diff --git a/arch/powerpc/include/asm/opal.h b/arch/powerpc/include/asm/opal.h
index 042af1a..f86e5e9 100644
--- a/arch/powerpc/include/asm/opal.h
+++ b/arch/powerpc/include/asm/opal.h
@@ -201,6 +201,8 @@ int64_t opal_flash_write(uint64_t id, uint64_t offset, uint64_t buf,
 int64_t opal_flash_erase(uint64_t id, uint64_t offset, uint64_t size,
 		uint64_t token);
 
+int64_t opal_nest_ima_control(uint32_t value);
+
 /* Internal functions */
 extern int early_init_dt_scan_opal(unsigned long node, const char *uname,
 				   int depth, void *data);
diff --git a/arch/powerpc/platforms/powernv/opal-wrappers.S b/arch/powerpc/platforms/powernv/opal-wrappers.S
index a7ade94..ce36a68 100644
--- a/arch/powerpc/platforms/powernv/opal-wrappers.S
+++ b/arch/powerpc/platforms/powernv/opal-wrappers.S
@@ -295,3 +295,4 @@ OPAL_CALL(opal_i2c_request,			OPAL_I2C_REQUEST);
 OPAL_CALL(opal_flash_read,			OPAL_FLASH_READ);
 OPAL_CALL(opal_flash_write,			OPAL_FLASH_WRITE);
 OPAL_CALL(opal_flash_erase,			OPAL_FLASH_ERASE);
+OPAL_CALL(opal_nest_ima_control,		OPAL_NEST_IMA_CONTROL);
-- 
1.9.1
