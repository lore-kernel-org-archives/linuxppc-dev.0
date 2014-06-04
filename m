Return-Path: <anton@samba.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 017541A06FA
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  4 Jun 2014 14:48:49 +1000 (EST)
Date: Wed, 4 Jun 2014 14:48:48 +1000
From: Anton Blanchard <anton@samba.org>
To: benh@kernel.crashing.org, paulus@samba.org, mahesh@linux.vnet.ibm.com
Subject: [PATCH] powerpc/powernv: Fix endian issues in memory error handling
 code
Message-ID: <20140604144848.459a15e5@kryten>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

struct OpalMemoryErrorData is passed to us from firmware, so we
have to byteswap it.

Signed-off-by: Anton Blanchard <anton@samba.org>
---

Having enums in a firmware interface concerns me, but that cleanup
can be in a subsequent patch.

Mahesh, could you give this a test to see if it works?

Index: b/arch/powerpc/include/asm/opal.h
===================================================================
--- a/arch/powerpc/include/asm/opal.h
+++ b/arch/powerpc/include/asm/opal.h
@@ -482,7 +482,7 @@ enum OpalMemErr_DynErrType {
 struct OpalMemoryErrorData {
 	enum OpalMemErr_Version	version:8;	/* 0x00 */
 	enum OpalMemErrType	type:8;		/* 0x01 */
-	uint16_t		flags;		/* 0x02 */
+	__be16			flags;		/* 0x02 */
 	uint8_t			reserved_1[4];	/* 0x04 */
 
 	union {
@@ -490,15 +490,15 @@ struct OpalMemoryErrorData {
 		struct {
 			enum OpalMemErr_ResilErrType resil_err_type:8;
 			uint8_t		reserved_1[7];
-			uint64_t	physical_address_start;
-			uint64_t	physical_address_end;
+			__be64		physical_address_start;
+			__be64		physical_address_end;
 		} resilience;
 		/* Dynamic memory deallocation error info */
 		struct {
 			enum OpalMemErr_DynErrType dyn_err_type:8;
 			uint8_t		reserved_1[7];
-			uint64_t	physical_address_start;
-			uint64_t	physical_address_end;
+			__be64		physical_address_start;
+			__be64		physical_address_end;
 		} dyn_dealloc;
 	} u;
 };
Index: b/arch/powerpc/platforms/powernv/opal-memory-errors.c
===================================================================
--- a/arch/powerpc/platforms/powernv/opal-memory-errors.c
+++ b/arch/powerpc/platforms/powernv/opal-memory-errors.c
@@ -47,12 +47,12 @@ static void handle_memory_error_event(st
 		  __func__, merr_evt->type);
 	switch (merr_evt->type) {
 	case OPAL_MEM_ERR_TYPE_RESILIENCE:
-		paddr_start = merr_evt->u.resilience.physical_address_start;
-		paddr_end = merr_evt->u.resilience.physical_address_end;
+		paddr_start = be64_to_cpu(merr_evt->u.resilience.physical_address_start);
+		paddr_end = be64_to_cpu(merr_evt->u.resilience.physical_address_end);
 		break;
 	case OPAL_MEM_ERR_TYPE_DYN_DALLOC:
-		paddr_start = merr_evt->u.dyn_dealloc.physical_address_start;
-		paddr_end = merr_evt->u.dyn_dealloc.physical_address_end;
+		paddr_start = be64_to_cpu(merr_evt->u.dyn_dealloc.physical_address_start);
+		paddr_end = be64_to_cpu(merr_evt->u.dyn_dealloc.physical_address_end);
 		break;
 	default:
 		return;
