Return-Path: <michael@ozlabs.org>
From: Michael Ellerman <michael@ellerman.id.au>
To: <linuxppc-dev@ozlabs.org>
Subject: [PATCH 6/8] powerpc/perf: Drop MMCRA from thread_struct
Date: Mon, 24 Jun 2013 21:28:54 +1000
Message-Id: <1372073336-8189-6-git-send-email-michael@ellerman.id.au>
In-Reply-To: <1372073336-8189-1-git-send-email-michael@ellerman.id.au>
References: <1372073336-8189-1-git-send-email-michael@ellerman.id.au>
Cc: sukadev@linux.vnet.ibm.com, Paul Mackerras <paulus@samba.org>,
 khandual@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

In commit 59affcd "Context switch more PMU related SPRs" I added more
PMU SPRs to thread_struct, later modified in commit b11ae95. To add
insult to injury it turns out we don't need to switch MMCRA as it's
only user readable, and the value is recomputed by the PMU code.

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---
 arch/powerpc/include/asm/processor.h |    1 -
 arch/powerpc/kernel/asm-offsets.c    |    1 -
 2 files changed, 2 deletions(-)

diff --git a/arch/powerpc/include/asm/processor.h b/arch/powerpc/include/asm/processor.h
index 14a6583..48af5d7 100644
--- a/arch/powerpc/include/asm/processor.h
+++ b/arch/powerpc/include/asm/processor.h
@@ -289,7 +289,6 @@ struct thread_struct {
 	unsigned long	sier;
 	unsigned long	mmcr0;
 	unsigned long	mmcr2;
-	unsigned long	mmcra;
 #endif
 };
 
diff --git a/arch/powerpc/kernel/asm-offsets.c b/arch/powerpc/kernel/asm-offsets.c
index 6f16ffa..2f066ef 100644
--- a/arch/powerpc/kernel/asm-offsets.c
+++ b/arch/powerpc/kernel/asm-offsets.c
@@ -132,7 +132,6 @@ int main(void)
 	DEFINE(THREAD_SIER, offsetof(struct thread_struct, sier));
 	DEFINE(THREAD_MMCR0, offsetof(struct thread_struct, mmcr0));
 	DEFINE(THREAD_MMCR2, offsetof(struct thread_struct, mmcr2));
-	DEFINE(THREAD_MMCRA, offsetof(struct thread_struct, mmcra));
 #endif
 #ifdef CONFIG_PPC_TRANSACTIONAL_MEM
 	DEFINE(PACATMSCRATCH, offsetof(struct paca_struct, tm_scratch));
-- 
1.7.10.4
