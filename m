Return-Path: <key@linux.vnet.ibm.com>
Received: from e9.ny.us.ibm.com (e9.ny.us.ibm.com [32.97.182.139])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e9.ny.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 9A485B6FDE
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Apr 2012 01:42:47 +1000 (EST)
Received: from /spool/local
 by e9.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <key@linux.vnet.ibm.com>;
 Tue, 10 Apr 2012 11:42:44 -0400
Received: from d01relay03.pok.ibm.com (d01relay03.pok.ibm.com [9.56.227.235])
 by d01dlp01.pok.ibm.com (Postfix) with ESMTP id D52C138C8086
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Apr 2012 11:42:41 -0400 (EDT)
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
 by d01relay03.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 q3AFQ92U199232
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Apr 2012 11:42:41 -0400
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
 by d03av03.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 q3AF74vI016009
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Apr 2012 09:07:04 -0600
Message-ID: <1334070489.16827.3.camel@key-ThinkPad-W510>
Subject: [PATCH v2 01/17] powerpc: Add new hvcall constants to support PFO
From: Kent Yoder <key@linux.vnet.ibm.com>
To: linux-kernel@vger.kernel.org
Date: Tue, 10 Apr 2012 10:08:09 -0500
In-Reply-To: <1334070249.16827.1.camel@key-ThinkPad-W510>
References: <1334070249.16827.1.camel@key-ThinkPad-W510>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: key@linux.vnet.ibm.com, rcj@linux.vnet.ibm.com,
 linuxppc-dev@lists.ozlabs.org, linux-crypto@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The Platform Facilities Option (PFO) adds several new h_calls and
more return codes.

Signed-off-by: Robert Jennings <rcj@linux.vnet.ibm.com>
Signed-off-by: Kent Yoder <key@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/hvcall.h |   25 +++++++++++++++++++++++--
 1 files changed, 23 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/include/asm/hvcall.h b/arch/powerpc/include/asm/hvcall.h
index 1c324ff..6122523 100644
--- a/arch/powerpc/include/asm/hvcall.h
+++ b/arch/powerpc/include/asm/hvcall.h
@@ -77,8 +77,27 @@
 #define H_MR_CONDITION  -43
 #define H_NOT_ENOUGH_RESOURCES -44
 #define H_R_STATE       -45
-#define H_RESCINDEND    -46
-#define H_MULTI_THREADS_ACTIVE -9005
+#define H_RESCINDED     -46
+#define H_P2		-55
+#define H_P3		-56
+#define H_P4		-57
+#define H_P5		-58
+#define H_P6		-59
+#define H_P7		-60
+#define H_P8		-61
+#define H_P9		-62
+#define H_TOO_BIG	-64
+#define H_OVERLAP	-68
+#define H_INTERRUPT	-69
+#define H_BAD_DATA	-70
+#define H_NOT_ACTIVE	-71
+#define H_SG_LIST	-72
+#define H_OP_MODE	-73
+#define H_COP_HW	-74
+#define H_UNSUPPORTED_FLAG_START	-256
+#define H_UNSUPPORTED_FLAG_END		-511
+#define H_MULTI_THREADS_ACTIVE	-9005
+#define H_OUTSTANDING_COP_OPS	-9006
 

 /* Long Busy is a condition that can be returned by the firmware
@@ -240,6 +259,8 @@
 #define H_GET_MPP		0x2D4
 #define H_HOME_NODE_ASSOCIATIVITY 0x2EC
 #define H_BEST_ENERGY		0x2F4
+#define H_RANDOM		0x300
+#define H_COP			0x304
 #define H_GET_MPP_X		0x314
 #define MAX_HCALL_OPCODE	H_GET_MPP_X
 
-- 
1.7.1
