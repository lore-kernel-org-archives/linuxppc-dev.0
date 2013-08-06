Return-Path: <anton@ozlabs.org>
From: Anton Blanchard <anton@samba.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>
Subject: [PATCH 44/63] powerpc: Include the appropriate endianness header
Date: Wed,  7 Aug 2013 02:02:01 +1000
Message-Id: <1375804940-22050-45-git-send-email-anton@samba.org>
In-Reply-To: <1375804940-22050-1-git-send-email-anton@samba.org>
References: <1375804940-22050-1-git-send-email-anton@samba.org>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Ian Munsie <imunsie@au1.ibm.com>

This patch will have powerpc include the appropriate generic endianness
header depending on what the compiler reports.

Signed-off-by: Ian Munsie <imunsie@au1.ibm.com>
Signed-off-by: Anton Blanchard <anton@samba.org>
---
 arch/powerpc/include/uapi/asm/byteorder.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/powerpc/include/uapi/asm/byteorder.h b/arch/powerpc/include/uapi/asm/byteorder.h
index aa6cc4f..ca931d0 100644
--- a/arch/powerpc/include/uapi/asm/byteorder.h
+++ b/arch/powerpc/include/uapi/asm/byteorder.h
@@ -7,6 +7,10 @@
  * as published by the Free Software Foundation; either version
  * 2 of the License, or (at your option) any later version.
  */
+#ifdef __LITTLE_ENDIAN__
+#include <linux/byteorder/little_endian.h>
+#else
 #include <linux/byteorder/big_endian.h>
+#endif
 
 #endif /* _ASM_POWERPC_BYTEORDER_H */
-- 
1.8.1.2
