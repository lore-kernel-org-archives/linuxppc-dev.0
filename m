Return-Path: <npiggin@gmail.com>
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com
 [IPv6:2607:f8b0:4864:20::641])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41zRBJ2cKZzDqSL
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Aug 2018 19:17:59 +1000 (AEST)
Received: by mail-pl1-x641.google.com with SMTP id g23-v6so3898855plq.9
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Aug 2018 02:17:59 -0700 (PDT)
Date: Mon, 27 Aug 2018 19:17:51 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linuxppc-dev@lists.ozlabs.org, Paul Mackerras <pmac@au1.ibm.com>
Subject: Re: [PATCH 2/2] powerpc/64s/radix: Explicitly flush ERAT with local
 LPID invalidation
Message-ID: <20180827191751.6f4075ac@roar.ozlabs.ibm.com>
In-Reply-To: <9fd2cb24976fc3b4534d7ab6186032ac4e27c9d5.camel@kernel.crashing.org>
References: <20180827030302.17541-1-npiggin@gmail.com>
 <20180827030302.17541-3-npiggin@gmail.com>
 <9fd2cb24976fc3b4534d7ab6186032ac4e27c9d5.camel@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 27 Aug 2018 18:16:05 +1000
Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:

> On Mon, 2018-08-27 at 13:03 +1000, Nicholas Piggin wrote:
> > Local radix TLB flush operations that operate on congruence classes
> > have explicit ERAT flushes for POWER9. The process scoped LPID flush
> > did not have a flush, so add it.  
> 
> Paul, is that an actual bug ? I think the ERAT is flushed on LPID
> changes...

FWIW I'd like to add the following patch after these fixes. While I
have your attention...

[PATCH] powerpc/64s/radix: keep kernel ERAT over local process/guest
 invalidates

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/include/asm/ppc-opcode.h | 10 +++++++++-
 arch/powerpc/mm/tlb-radix.c           |  6 +++---
 2 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/include/asm/ppc-opcode.h b/arch/powerpc/include/asm/ppc-opcode.h
index 665af14850e4..5fe617ab680a 100644
--- a/arch/powerpc/include/asm/ppc-opcode.h
+++ b/arch/powerpc/include/asm/ppc-opcode.h
@@ -568,7 +568,15 @@
 
 #define PPC_SLBIA(IH)	stringify_in_c(.long PPC_INST_SLBIA | \
 				       ((IH & 0x7) << 21))
-#define PPC_INVALIDATE_ERAT	PPC_SLBIA(7)
+
+/*
+ * These may only be used by ARCH_300.
+ * GUEST/USER invalidates should only be used by radix mode, on HPT they also
+ * invalidate SLBs so the SLBIA instruction should be used directly.
+ */
+#define PPC_INVALIDATE_ERAT		PPC_SLBIA(7)
+#define PPC_INVALIDATE_GUEST_ERAT	PPC_SLBIA(6)
+#define PPC_INVALIDATE_USER_ERAT	PPC_SLBIA(3)
 
 #define VCMPEQUD_RC(vrt, vra, vrb)	stringify_in_c(.long PPC_INST_VCMPEQUD | \
 			      ___PPC_RT(vrt) | ___PPC_RA(vra) | \
diff --git a/arch/powerpc/mm/tlb-radix.c b/arch/powerpc/mm/tlb-radix.c
index 4e798f33c530..6887e4b2568b 100644
--- a/arch/powerpc/mm/tlb-radix.c
+++ b/arch/powerpc/mm/tlb-radix.c
@@ -262,7 +262,7 @@ static inline void _tlbiel_pid(unsigned long pid, unsigned long ric)
 		__tlbiel_pid(pid, set, RIC_FLUSH_TLB);
 
 	asm volatile("ptesync": : :"memory");
-	asm volatile(PPC_INVALIDATE_ERAT "; isync" : : :"memory");
+	asm volatile(PPC_INVALIDATE_USER_ERAT "; isync" : : :"memory");
 }
 
 static inline void _tlbie_pid(unsigned long pid, unsigned long ric)
@@ -314,7 +314,7 @@ static inline void _tlbiel_lpid(unsigned long lpid, unsigned long ric)
 		__tlbiel_lpid(lpid, set, RIC_FLUSH_TLB);
 
 	asm volatile("ptesync": : :"memory");
-	asm volatile(PPC_INVALIDATE_ERAT "; isync" : : :"memory");
+	asm volatile(PPC_INVALIDATE_GUEST_ERAT "; isync" : : :"memory");
 }
 
 static inline void _tlbie_lpid(unsigned long lpid, unsigned long ric)
@@ -366,7 +366,7 @@ static inline void _tlbiel_lpid_guest(unsigned long lpid, unsigned long ric)
 		__tlbiel_lpid_guest(lpid, set, RIC_FLUSH_TLB);
 
 	asm volatile("ptesync": : :"memory");
-	asm volatile(PPC_INVALIDATE_ERAT : : :"memory");
+	asm volatile(PPC_INVALIDATE_GUEST_ERAT : : :"memory");
 }
 
 
-- 
