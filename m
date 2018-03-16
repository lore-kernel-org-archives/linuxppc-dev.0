Return-Path: <mathieu.malaterre@gmail.com>
Received: from mail-wr0-x241.google.com (mail-wr0-x241.google.com
 [IPv6:2a00:1450:400c:c0c::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 402jH856s6zDrJK
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Mar 2018 22:03:00 +1100 (AEDT)
Received: by mail-wr0-x241.google.com with SMTP id m12so11203817wrm.13
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Mar 2018 04:03:00 -0700 (PDT)
Sender: Mathieu Malaterre <mathieu.malaterre@gmail.com>
From: Mathieu Malaterre <malat@debian.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
 Mathieu Malaterre <malat@debian.org>
Subject: [PATCH 12/19] ppc64: change %lx into %llx
Date: Fri, 16 Mar 2018 12:02:17 +0100
Message-Id: <20180316110224.12260-13-malat@debian.org>
In-Reply-To: <20180316110224.12260-1-malat@debian.org>
References: <20180316110224.12260-1-malat@debian.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

  CC      arch/powerpc/xmon/xmon.o
../arch/powerpc/xmon/xmon.c: In function ‘dump_one_paca’:
../arch/powerpc/xmon/xmon.c:2339:9: error: format ‘%lx’ expects argument of type ‘long unsigned int’, but argument 5 has type ‘u64 {aka long long unsigned int}’ [-Werror=format=]
  printf(" %-*s = %#-*"format"\t(0x%lx)\n", 20, #name, 18, paca->name, \
         ^
../arch/powerpc/xmon/xmon.c:2347:2: note: in expansion of macro ‘DUMP’
  DUMP(p, kernel_toc, "lx");
  ^~~~
cc1: all warnings being treated as errors

Signed-off-by: Mathieu Malaterre <malat@debian.org>
---
 arch/powerpc/xmon/xmon.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/arch/powerpc/xmon/xmon.c b/arch/powerpc/xmon/xmon.c
index 7eb656274ea7..96247ac91a86 100644
--- a/arch/powerpc/xmon/xmon.c
+++ b/arch/powerpc/xmon/xmon.c
@@ -2341,9 +2341,9 @@ static void dump_one_paca(int cpu)
 
 	DUMP(p, lock_token, "x");
 	DUMP(p, paca_index, "x");
-	DUMP(p, kernel_toc, "lx");
-	DUMP(p, kernelbase, "lx");
-	DUMP(p, kernel_msr, "lx");
+	DUMP(p, kernel_toc, "llx");
+	DUMP(p, kernelbase, "llx");
+	DUMP(p, kernel_msr, "llx");
 	DUMP(p, emergency_sp, "px");
 #ifdef CONFIG_PPC_BOOK3S_64
 	DUMP(p, nmi_emergency_sp, "px");
@@ -2352,7 +2352,7 @@ static void dump_one_paca(int cpu)
 	DUMP(p, in_mce, "x");
 	DUMP(p, hmi_event_available, "x");
 #endif
-	DUMP(p, data_offset, "lx");
+	DUMP(p, data_offset, "llx");
 	DUMP(p, hw_cpu_id, "x");
 	DUMP(p, cpu_start, "x");
 	DUMP(p, kexec_state, "x");
@@ -2367,7 +2367,7 @@ static void dump_one_paca(int cpu)
 		vsid = be64_to_cpu(p->slb_shadow_ptr->save_area[i].vsid);
 
 		if (esid || vsid) {
-			printf(" slb_shadow[%d]:       = 0x%016lx 0x%016lx\n",
+			printf(" slb_shadow[%d]:       = 0x%016llx 0x%016llx\n",
 				i, esid, vsid);
 		}
 	}
@@ -2388,10 +2388,10 @@ static void dump_one_paca(int cpu)
 	DUMP(p, dbg_kstack, "px");
 #endif
 	DUMP(p, __current, "px");
-	DUMP(p, kstack, "lx");
-	printf(" kstack_base          = 0x%016lx\n", p->kstack & ~(THREAD_SIZE - 1));
-	DUMP(p, stab_rr, "lx");
-	DUMP(p, saved_r1, "lx");
+	DUMP(p, kstack, "llx");
+	printf(" kstack_base          = 0x%016llx\n", p->kstack & ~(THREAD_SIZE - 1));
+	DUMP(p, stab_rr, "llx");
+	DUMP(p, saved_r1, "llx");
 	DUMP(p, trap_save, "x");
 	DUMP(p, irq_soft_mask, "x");
 	DUMP(p, irq_happened, "x");
@@ -3848,9 +3848,9 @@ static void dump_spu_fields(struct spu *spu)
 	DUMP_FIELD(spu, "0x%x", node);
 	DUMP_FIELD(spu, "0x%lx", flags);
 	DUMP_FIELD(spu, "%d", class_0_pending);
-	DUMP_FIELD(spu, "0x%lx", class_0_dar);
-	DUMP_FIELD(spu, "0x%lx", class_1_dar);
-	DUMP_FIELD(spu, "0x%lx", class_1_dsisr);
+	DUMP_FIELD(spu, "0x%llx", class_0_dar);
+	DUMP_FIELD(spu, "0x%llx", class_1_dar);
+	DUMP_FIELD(spu, "0x%llx", class_1_dsisr);
 	DUMP_FIELD(spu, "0x%x", irqs[0]);
 	DUMP_FIELD(spu, "0x%x", irqs[1]);
 	DUMP_FIELD(spu, "0x%x", irqs[2]);
-- 
2.11.0
