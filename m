Return-Path: <maddy@linux.vnet.ibm.com>
Received: from e28smtp05.in.ibm.com (e28smtp05.in.ibm.com [122.248.162.5])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 924891A0BB3
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Jul 2015 21:13:46 +1000 (AEST)
Received: from /spool/local
 by e28smtp05.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <maddy@linux.vnet.ibm.com>;
 Thu, 16 Jul 2015 16:43:44 +0530
Received: from d28relay03.in.ibm.com (d28relay03.in.ibm.com [9.184.220.60])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id C6B661258044
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Jul 2015 16:46:35 +0530 (IST)
Received: from d28av04.in.ibm.com (d28av04.in.ibm.com [9.184.220.66])
 by d28relay03.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t6GBDd3J28901522
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Jul 2015 16:43:39 +0530
Received: from d28av04.in.ibm.com (localhost [127.0.0.1])
 by d28av04.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t6GBDVAM000338
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Jul 2015 16:43:33 +0530
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
Subject: [PATCH v5 2/7] powerpc/powernv: Add OPAL support for Nest PMU
Date: Thu, 16 Jul 2015 16:43:21 +0530
Message-Id: <1437045206-7491-3-git-send-email-maddy@linux.vnet.ibm.com>
In-Reply-To: <1437045206-7491-1-git-send-email-maddy@linux.vnet.ibm.com>
References: <1437045206-7491-1-git-send-email-maddy@linux.vnet.ibm.com>
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
 arch/powerpc/include/asm/opal.h                | 1 +
 arch/powerpc/platforms/powernv/opal-wrappers.S | 1 +
 3 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/opal-api.h b/arch/powerpc/include/asm/opal-api.h
index e9e4c52f3685..4cd8128c6ebc 100644
--- a/arch/powerpc/include/asm/opal-api.h
+++ b/arch/powerpc/include/asm/opal-api.h
@@ -154,7 +154,8 @@
 #define OPAL_FLASH_WRITE			111
 #define OPAL_FLASH_ERASE			112
 #define OPAL_PRD_MSG				113
-#define OPAL_LAST				113
+#define OPAL_NEST_IMA_CONTROL			116
+#define OPAL_LAST				116
 
 /* Device tree flags */
 
diff --git a/arch/powerpc/include/asm/opal.h b/arch/powerpc/include/asm/opal.h
index 958e941c0cda..7c813ed52ab4 100644
--- a/arch/powerpc/include/asm/opal.h
+++ b/arch/powerpc/include/asm/opal.h
@@ -202,6 +202,7 @@ int64_t opal_flash_write(uint64_t id, uint64_t offset, uint64_t buf,
 		uint64_t size, uint64_t token);
 int64_t opal_flash_erase(uint64_t id, uint64_t offset, uint64_t size,
 		uint64_t token);
+int64_t opal_nest_ima_control(uint64_t mode, uint64_t value);
 
 /* Internal functions */
 extern int early_init_dt_scan_opal(unsigned long node, const char *uname,
diff --git a/arch/powerpc/platforms/powernv/opal-wrappers.S b/arch/powerpc/platforms/powernv/opal-wrappers.S
index d6a7b8252e4d..c475c04468fb 100644
--- a/arch/powerpc/platforms/powernv/opal-wrappers.S
+++ b/arch/powerpc/platforms/powernv/opal-wrappers.S
@@ -297,3 +297,4 @@ OPAL_CALL(opal_flash_read,			OPAL_FLASH_READ);
 OPAL_CALL(opal_flash_write,			OPAL_FLASH_WRITE);
 OPAL_CALL(opal_flash_erase,			OPAL_FLASH_ERASE);
 OPAL_CALL(opal_prd_msg,				OPAL_PRD_MSG);
+OPAL_CALL(opal_nest_ima_control,		OPAL_NEST_IMA_CONTROL);
-- 
1.9.1
