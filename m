Return-Path: <anton@ozlabs.org>
From: Anton Blanchard <anton@samba.org>
To: benh@kernel.crashing.org, paulus@samba.org, rusty@rustcorp.com.au,
 ulrich.weigand@de.ibm.com, amodra@gmail.com, mikey@neuling.org,
 mjw@linux.vnet.ibm.com
Subject: [PATCH 19/33] powerpc/tracing: TRACE_WITH_FRAME_BUFFER creates
 invalid stack frames
Date: Tue, 25 Mar 2014 22:44:25 +1100
Message-Id: <1395747879-5948-20-git-send-email-anton@samba.org>
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

TRACE_WITH_FRAME_BUFFER creates 32 byte stack frames. On ppc64
ABIv1 this is too small and a callee could corrupt the stack by
writing to the parameter save area (starting at offset 48).

Signed-off-by: Anton Blanchard <anton@samba.org>
---
 arch/powerpc/include/asm/irqflags.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/include/asm/irqflags.h b/arch/powerpc/include/asm/irqflags.h
index f62c056..e20eb95 100644
--- a/arch/powerpc/include/asm/irqflags.h
+++ b/arch/powerpc/include/asm/irqflags.h
@@ -20,9 +20,9 @@
  */
 #define TRACE_WITH_FRAME_BUFFER(func)		\
 	mflr	r0;				\
-	stdu	r1, -32(r1);			\
+	stdu	r1, -STACK_FRAME_OVERHEAD(r1);	\
 	std	r0, 16(r1);			\
-	stdu	r1, -32(r1);			\
+	stdu	r1, -STACK_FRAME_OVERHEAD(r1);	\
 	bl func;				\
 	ld	r1, 0(r1);			\
 	ld	r1, 0(r1);
-- 
1.8.3.2
