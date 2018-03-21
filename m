Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 405sLm3p7fzDqJ8
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Mar 2018 01:17:03 +1100 (AEDT)
Message-Id: <af14d8ac7ed21a3271da6e4767a0277c16fd100e.1521641523.git.christophe.leroy@c-s.fr>
In-Reply-To: <7c34db8eca67beefa7ec8243bc07135b4dff4440.1521641523.git.christophe.leroy@c-s.fr>
References: <7c34db8eca67beefa7ec8243bc07135b4dff4440.1521641523.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v2 2/2] powerpc/mm: Trace tlbia instruction
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Scott Wood <oss@buserror.net>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 Balbir Singh <bsingharora@gmail.com>
Date: Wed, 21 Mar 2018 15:17:00 +0100 (CET)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Add a trace point for tlbia (Translation Lookaside Buffer Invalidate
All) instruction.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/include/asm/trace.h | 15 +++++++++++++++
 arch/powerpc/mm/mmu_decl.h       |  2 ++
 2 files changed, 17 insertions(+)

diff --git a/arch/powerpc/include/asm/trace.h b/arch/powerpc/include/asm/trace.h
index 33f3b479138b..0165a424308d 100644
--- a/arch/powerpc/include/asm/trace.h
+++ b/arch/powerpc/include/asm/trace.h
@@ -202,6 +202,21 @@ TRACE_EVENT(tlbie,
 		__entry->r)
 );
 
+TRACE_EVENT(tlbia,
+
+	TP_PROTO(unsigned long id),
+	TP_ARGS(id),
+	TP_STRUCT__entry(
+		__field(unsigned long, id)
+		),
+
+	TP_fast_assign(
+		__entry->id = id;
+		),
+
+	TP_printk("ctx.id=0x%lx", __entry->id)
+);
+
 #endif /* _TRACE_POWERPC_H */
 
 #undef TRACE_INCLUDE_PATH
diff --git a/arch/powerpc/mm/mmu_decl.h b/arch/powerpc/mm/mmu_decl.h
index 107033cc4dcf..8f5483e415dd 100644
--- a/arch/powerpc/mm/mmu_decl.h
+++ b/arch/powerpc/mm/mmu_decl.h
@@ -32,10 +32,12 @@
 static inline void _tlbil_all(void)
 {
 	asm volatile ("sync; tlbia; isync" : : : "memory");
+	trace_tlbia(MMU_NO_CONTEXT);
 }
 static inline void _tlbil_pid(unsigned int pid)
 {
 	asm volatile ("sync; tlbia; isync" : : : "memory");
+	trace_tlbia(pid);
 }
 #define _tlbil_pid_noind(pid)	_tlbil_pid(pid)
 
-- 
2.13.3
