Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 404XSr69q2zF0cy
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Mar 2018 21:32:44 +1100 (AEDT)
Message-Id: <cccc5b8516ce8cb57bedf2c51cf67f9a2ca95242.1521452718.git.christophe.leroy@c-s.fr>
In-Reply-To: <4ffd3d6143f991615ffe07f43952cbc62163d319.1521452718.git.christophe.leroy@c-s.fr>
References: <4ffd3d6143f991615ffe07f43952cbc62163d319.1521452718.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH  2/2] powerpc/mm: Trace tlbia instruction
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Scott Wood <oss@buserror.net>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 Balbir Singh <bsingharora@gmail.com>
Date: Mon, 19 Mar 2018 11:32:40 +0100 (CET)
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
index 33f3b479138b..d1d63b173dd7 100644
--- a/arch/powerpc/include/asm/trace.h
+++ b/arch/powerpc/include/asm/trace.h
@@ -202,6 +202,21 @@ TRACE_EVENT(tlbie,
 		__entry->r)
 );
 
+TRACE_EVENT(tlbia,
+
+	TP_PROTO(unsigned long lpid),
+	TP_ARGS(lpid),
+	TP_STRUCT__entry(
+		__field(unsigned long, lpid)
+		),
+
+	TP_fast_assign(
+		__entry->lpid = lpid;
+		),
+
+	TP_printk("lpid=%ld", __entry->lpid)
+);
+
 #endif /* _TRACE_POWERPC_H */
 
 #undef TRACE_INCLUDE_PATH
diff --git a/arch/powerpc/mm/mmu_decl.h b/arch/powerpc/mm/mmu_decl.h
index b9991e0c61a2..d4ae7b5d45fe 100644
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
