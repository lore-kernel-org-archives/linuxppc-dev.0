Return-Path: <anton@ozlabs.org>
From: Anton Blanchard <anton@samba.org>
To: benh@kernel.crashing.org, paulus@samba.org, rusty@rustcorp.com.au,
 ulrich.weigand@de.ibm.com, amodra@gmail.com, mikey@neuling.org,
 mjw@linux.vnet.ibm.com
Subject: [PATCH 21/33] powerpc: Fix ABIv2 issue with
 dereference_function_descriptor
Date: Tue, 25 Mar 2014 22:44:27 +1100
Message-Id: <1395747879-5948-22-git-send-email-anton@samba.org>
In-Reply-To: <1395747879-5948-1-git-send-email-anton@samba.org>
References: <1395747879-5948-1-git-send-email-anton@samba.org>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Don't try and dereference a function descriptor on ABIv2.

Signed-off-by: Anton Blanchard <anton@samba.org>
---
 arch/powerpc/include/asm/sections.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/powerpc/include/asm/sections.h b/arch/powerpc/include/asm/sections.h
index d0e784e..d1bb96d 100644
--- a/arch/powerpc/include/asm/sections.h
+++ b/arch/powerpc/include/asm/sections.h
@@ -39,6 +39,7 @@ static inline int overlaps_kernel_text(unsigned long start, unsigned long end)
 		(unsigned long)_stext < end;
 }
 
+#if !defined(_CALL_ELF) || _CALL_ELF != 2
 #undef dereference_function_descriptor
 static inline void *dereference_function_descriptor(void *ptr)
 {
@@ -49,6 +50,7 @@ static inline void *dereference_function_descriptor(void *ptr)
 		ptr = p;
 	return ptr;
 }
+#endif
 
 #endif
 
-- 
1.8.3.2
