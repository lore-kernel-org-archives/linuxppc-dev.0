Return-Path: <anton@samba.org>
Date: Mon, 16 Dec 2013 18:58:22 +1100
From: Anton Blanchard <anton@samba.org>
To: Rajesh B Prathipati <rprathip@linux.vnet.ibm.com>,
 benh@kernel.crashing.org, paulus@samba.org
Subject: [PATCH] powerpc: Make unaligned accesses endian-safe for powerpc
Message-ID: <20131216185822.368c29d1@kryten>
In-Reply-To: <52A9DA34.40905@linux.vnet.ibm.com>
References: <52A9DA34.40905@linux.vnet.ibm.com>
Mime-Version: 1.0
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

From: Rajesh B Prathipati <rprathip@linux.vnet.ibm.com>

The generic put_unaligned/get_unaligned macros were made endian-safe by 
calling the appropriate endian dependent macros based on the endian type 
of the powerpc processor.

Signed-off-by: Rajesh B Prathipati <rprathip@linux.vnet.ibm.com>
Signed-off-by: Anton Blanchard <anton@samba.org>
---

diff --git a/arch/powerpc/include/asm/unaligned.h b/arch/powerpc/include/asm/unaligned.h
index 5f1b1e3..8296381 100644
--- a/arch/powerpc/include/asm/unaligned.h
+++ b/arch/powerpc/include/asm/unaligned.h
@@ -4,13 +4,18 @@
 #ifdef __KERNEL__
 
 /*
- * The PowerPC can do unaligned accesses itself in big endian mode.
+ * The PowerPC can do unaligned accesses itself based on its endian mode.
  */
 #include <linux/unaligned/access_ok.h>
 #include <linux/unaligned/generic.h>
 
+#ifdef __LITTLE_ENDIAN__
+#define get_unaligned	__get_unaligned_le
+#define put_unaligned	__put_unaligned_le
+#else
 #define get_unaligned	__get_unaligned_be
 #define put_unaligned	__put_unaligned_be
+#endif
 
 #endif	/* __KERNEL__ */
 #endif	/* _ASM_POWERPC_UNALIGNED_H */
