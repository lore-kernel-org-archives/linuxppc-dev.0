Return-Path: <ldufour@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41vGRH6VbyzDqp5
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Aug 2018 00:29:47 +1000 (AEST)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w7KETVwA139129
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Aug 2018 10:29:45 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2kyvpb73rs-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Aug 2018 10:29:44 -0400
Received: from localhost
 by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ldufour@linux.vnet.ibm.com>;
 Mon, 20 Aug 2018 15:29:43 +0100
From: Laurent Dufour <ldufour@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Cc: aneesh.kumar@linux.ibm.com, mpe@ellerman.id.au, benh@kernel.crashing.org,
 paulus@samba.org, npiggin@gmail.com
Subject: [PATCH v2 1/3] powerpc/pseries/mm: Introducing FW_FEATURE_BLOCK_REMOVE
Date: Mon, 20 Aug 2018 16:29:34 +0200
In-Reply-To: <1534775376-22480-1-git-send-email-ldufour@linux.vnet.ibm.com>
References: <1534775376-22480-1-git-send-email-ldufour@linux.vnet.ibm.com>
Message-Id: <1534775376-22480-2-git-send-email-ldufour@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This feature tells if the hcall H_BLOCK_REMOVE is available.

Cc: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Cc: Nicholas Piggin <npiggin@gmail.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Reviewed-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
Signed-off-by: Laurent Dufour <ldufour@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/firmware.h       | 3 ++-
 arch/powerpc/platforms/pseries/firmware.c | 1 +
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/firmware.h b/arch/powerpc/include/asm/firmware.h
index 7a051bd21f87..2aca2655fe30 100644
--- a/arch/powerpc/include/asm/firmware.h
+++ b/arch/powerpc/include/asm/firmware.h
@@ -52,6 +52,7 @@
 #define FW_FEATURE_PRRN		ASM_CONST(0x0000000200000000)
 #define FW_FEATURE_DRMEM_V2	ASM_CONST(0x0000000400000000)
 #define FW_FEATURE_DRC_INFO	ASM_CONST(0x0000000800000000)
+#define FW_FEATURE_BLOCK_REMOVE ASM_CONST(0x0000001000000000)
 
 #ifndef __ASSEMBLY__
 
@@ -69,7 +70,7 @@ enum {
 		FW_FEATURE_SET_MODE | FW_FEATURE_BEST_ENERGY |
 		FW_FEATURE_TYPE1_AFFINITY | FW_FEATURE_PRRN |
 		FW_FEATURE_HPT_RESIZE | FW_FEATURE_DRMEM_V2 |
-		FW_FEATURE_DRC_INFO,
+		FW_FEATURE_DRC_INFO | FW_FEATURE_BLOCK_REMOVE,
 	FW_FEATURE_PSERIES_ALWAYS = 0,
 	FW_FEATURE_POWERNV_POSSIBLE = FW_FEATURE_OPAL,
 	FW_FEATURE_POWERNV_ALWAYS = 0,
diff --git a/arch/powerpc/platforms/pseries/firmware.c b/arch/powerpc/platforms/pseries/firmware.c
index a3bbeb43689e..1624501386f4 100644
--- a/arch/powerpc/platforms/pseries/firmware.c
+++ b/arch/powerpc/platforms/pseries/firmware.c
@@ -65,6 +65,7 @@ hypertas_fw_features_table[] = {
 	{FW_FEATURE_SET_MODE,		"hcall-set-mode"},
 	{FW_FEATURE_BEST_ENERGY,	"hcall-best-energy-1*"},
 	{FW_FEATURE_HPT_RESIZE,		"hcall-hpt-resize"},
+	{FW_FEATURE_BLOCK_REMOVE,	"hcall-block-remove"},
 };
 
 /* Build up the firmware features bitmask using the contents of
-- 
2.7.4
