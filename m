Return-Path: <srs0=g6dx=3t=gmail.com=bsingharora@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w2Fp72JCHzDq5W
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Apr 2017 15:23:43 +1000 (AEST)
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 3w2Fp71W3Bz8swH
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Apr 2017 15:23:43 +1000 (AEST)
Received: from mail-pg0-x243.google.com (mail-pg0-x243.google.com
 [IPv6:2607:f8b0:400e:c05::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3w2Fp63ssyz9sNV
 for <linuxppc-dev@ozlabs.org>; Tue, 11 Apr 2017 15:23:42 +1000 (AEST)
Received: by mail-pg0-x243.google.com with SMTP id g2so28308380pge.2
 for <linuxppc-dev@ozlabs.org>; Mon, 10 Apr 2017 22:23:42 -0700 (PDT)
From: Balbir Singh <bsingharora@gmail.com>
To: mpe@ellerman.id.au,
	linuxppc-dev@ozlabs.org
Subject: [PATCH 1/2] powerpc/tracing: Trace TLBIE(L)
Date: Tue, 11 Apr 2017 15:23:25 +1000
Message-Id: <20170411052325.20206-1-bsingharora@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Just a quick patch to trace tlbie(l)'s. The idea being that it can be
enabled when we suspect corruption or when we need to see if we are doing
the right thing during flush. I think the format can be enhanced to
make it nicer (expand the RB/RS/IS/L cases in more detail if we ever
need that level of details).

A typical trace might look like this

<...>-5141  [062]  1354.486693: tlbie:
	tlbie with lpid 0, local 0, rb=7b5d0ff874f11f1, rs=0, ric=0 prs=0 r=0
systemd-udevd-2584  [018]  1354.486772: tlbie:
	tlbie with lpid 0, local 0, rb=17be1f421adc10c1, rs=0, ric=0 prs=0 r=0
...

qemu-system-ppc-5371  [016]  1412.369519: tlbie:
	tlbie with lpid 0, local 1, rb=67bd8900174c11c1, rs=0, ric=0 prs=0 r=0
qemu-system-ppc-5377  [056]  1421.687262: tlbie:
	tlbie with lpid 1, local 0, rb=5f04edffa00c11c1, rs=1, ric=0 prs=0 r=0

Signed-off-by: Balbir Singh <bsingharora@gmail.com>
---

 NOTES: Did not implement the count suggestion to see individual flushes
 The calls are always outside of ptesync, except for when in a loop in do_tlbies

 arch/powerpc/include/asm/trace.h    | 33 +++++++++++++++++++++++++++++++++
 arch/powerpc/kvm/book3s_hv_rm_mmu.c | 11 +++++++++--
 arch/powerpc/mm/hash_native_64.c    |  3 +++
 arch/powerpc/mm/tlb-radix.c         |  9 +++++++++
 4 files changed, 54 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/include/asm/trace.h b/arch/powerpc/include/asm/trace.h
index c05cef6..18f168a 100644
--- a/arch/powerpc/include/asm/trace.h
+++ b/arch/powerpc/include/asm/trace.h
@@ -168,6 +168,39 @@ TRACE_EVENT(hash_fault,
 		      __entry->addr, __entry->access, __entry->trap)
 );
 
+
+TRACE_EVENT(tlbie,
+
+	TP_PROTO(unsigned long lpid, unsigned long local, unsigned long rb,
+		unsigned long rs, unsigned long ric, unsigned long prs,
+		unsigned long r),
+	TP_ARGS(lpid, local, rb, rs, ric, prs, r),
+	TP_STRUCT__entry(
+		__field(unsigned long, lpid)
+		__field(unsigned long, local)
+		__field(unsigned long, rb)
+		__field(unsigned long, rs)
+		__field(unsigned long, ric)
+		__field(unsigned long, prs)
+		__field(unsigned long, r)
+		),
+
+	TP_fast_assign(
+		__entry->lpid = lpid;
+		__entry->local = local;
+		__entry->rb = rb;
+		__entry->rs = rs;
+		__entry->ric = ric;
+		__entry->prs = prs;
+		__entry->r = r;
+		),
+
+	TP_printk("lpid=%ld, local=%ld, rb=0x%lx, rs=0x%lx, ric=0x%lx, "
+		"prs=0x%lx, r=0x%lx", __entry->lpid, __entry->local,
+		__entry->rb, __entry->rs, __entry->ric, __entry->prs,
+		__entry->r)
+);
+
 #endif /* _TRACE_POWERPC_H */
 
 #undef TRACE_INCLUDE_PATH
diff --git a/arch/powerpc/kvm/book3s_hv_rm_mmu.c b/arch/powerpc/kvm/book3s_hv_rm_mmu.c
index ce6f212..584c74c 100644
--- a/arch/powerpc/kvm/book3s_hv_rm_mmu.c
+++ b/arch/powerpc/kvm/book3s_hv_rm_mmu.c
@@ -15,6 +15,7 @@
 #include <linux/log2.h>
 
 #include <asm/tlbflush.h>
+#include <asm/trace.h>
 #include <asm/kvm_ppc.h>
 #include <asm/kvm_book3s.h>
 #include <asm/book3s/64/mmu-hash.h>
@@ -443,17 +444,23 @@ static void do_tlbies(struct kvm *kvm, unsigned long *rbvalues,
 			cpu_relax();
 		if (need_sync)
 			asm volatile("ptesync" : : : "memory");
-		for (i = 0; i < npages; ++i)
+		for (i = 0; i < npages; ++i) {
 			asm volatile(PPC_TLBIE_5(%0,%1,0,0,0) : :
 				     "r" (rbvalues[i]), "r" (kvm->arch.lpid));
+			trace_tlbie(kvm->arch.lpid, 0, rbvalues[i],
+				kvm->arch.lpid, 0, 0, 0);
+		}
 		asm volatile("eieio; tlbsync; ptesync" : : : "memory");
 		kvm->arch.tlbie_lock = 0;
 	} else {
 		if (need_sync)
 			asm volatile("ptesync" : : : "memory");
-		for (i = 0; i < npages; ++i)
+		for (i = 0; i < npages; ++i) {
 			asm volatile(PPC_TLBIEL(%0,%1,0,0,0) : :
 				     "r" (rbvalues[i]), "r" (0));
+			trace_tlbie(kvm->arch.lpid, 1, rbvalues[i],
+				0, 0, 0, 0);
+		}
 		asm volatile("ptesync" : : : "memory");
 	}
 }
diff --git a/arch/powerpc/mm/hash_native_64.c b/arch/powerpc/mm/hash_native_64.c
index 65bb8f3..bdaac28 100644
--- a/arch/powerpc/mm/hash_native_64.c
+++ b/arch/powerpc/mm/hash_native_64.c
@@ -23,6 +23,7 @@
 #include <asm/mmu_context.h>
 #include <asm/pgtable.h>
 #include <asm/tlbflush.h>
+#include <asm/trace.h>
 #include <asm/tlb.h>
 #include <asm/cputable.h>
 #include <asm/udbg.h>
@@ -98,6 +99,7 @@ static inline void __tlbie(unsigned long vpn, int psize, int apsize, int ssize)
 			     : "memory");
 		break;
 	}
+	trace_tlbie(0, 0, va, 0, 0, 0, 0);
 }
 
 static inline void __tlbiel(unsigned long vpn, int psize, int apsize, int ssize)
@@ -147,6 +149,7 @@ static inline void __tlbiel(unsigned long vpn, int psize, int apsize, int ssize)
 			     : "memory");
 		break;
 	}
+	trace_tlbie(0, 1, va, 0, 0, 0, 0);
 
 }
 
diff --git a/arch/powerpc/mm/tlb-radix.c b/arch/powerpc/mm/tlb-radix.c
index 83dc1cc..c320f1d 100644
--- a/arch/powerpc/mm/tlb-radix.c
+++ b/arch/powerpc/mm/tlb-radix.c
@@ -16,6 +16,7 @@
 
 #include <asm/tlb.h>
 #include <asm/tlbflush.h>
+#include <asm/trace.h>
 
 static DEFINE_RAW_SPINLOCK(native_tlbie_lock);
 
@@ -38,6 +39,7 @@ static inline void __tlbiel_pid(unsigned long pid, int set,
 	asm volatile(PPC_TLBIEL(%0, %4, %3, %2, %1)
 		     : : "r"(rb), "i"(r), "i"(prs), "i"(ric), "r"(rs) : "memory");
 	asm volatile("ptesync": : :"memory");
+	trace_tlbie(0, 1, rb, rs, ric, prs, r);
 }
 
 /*
@@ -66,6 +68,7 @@ static inline void _tlbie_pid(unsigned long pid, unsigned long ric)
 	asm volatile(PPC_TLBIE_5(%0, %4, %3, %2, %1)
 		     : : "r"(rb), "i"(r), "i"(prs), "i"(ric), "r"(rs) : "memory");
 	asm volatile("eieio; tlbsync; ptesync": : :"memory");
+	trace_tlbie(0, 0, rb, rs, ric, prs, r);
 }
 
 static inline void _tlbiel_va(unsigned long va, unsigned long pid,
@@ -83,6 +86,7 @@ static inline void _tlbiel_va(unsigned long va, unsigned long pid,
 	asm volatile(PPC_TLBIEL(%0, %4, %3, %2, %1)
 		     : : "r"(rb), "i"(r), "i"(prs), "i"(ric), "r"(rs) : "memory");
 	asm volatile("ptesync": : :"memory");
+	trace_tlbie(0, 1, rb, rs, ric, prs, r);
 }
 
 static inline void _tlbie_va(unsigned long va, unsigned long pid,
@@ -100,6 +104,7 @@ static inline void _tlbie_va(unsigned long va, unsigned long pid,
 	asm volatile(PPC_TLBIE_5(%0, %4, %3, %2, %1)
 		     : : "r"(rb), "i"(r), "i"(prs), "i"(ric), "r"(rs) : "memory");
 	asm volatile("eieio; tlbsync; ptesync": : :"memory");
+	trace_tlbie(0, 0, rb, rs, ric, prs, r);
 }
 
 /*
@@ -374,6 +379,7 @@ void radix__flush_tlb_lpid_va(unsigned long lpid, unsigned long gpa,
 	asm volatile(PPC_TLBIE_5(%0, %4, %3, %2, %1)
 		     : : "r"(rb), "i"(r), "i"(prs), "i"(ric), "r"(rs) : "memory");
 	asm volatile("eieio; tlbsync; ptesync": : :"memory");
+	trace_tlbie(lpid, 0, rb, rs, ric, prs, r);
 }
 EXPORT_SYMBOL(radix__flush_tlb_lpid_va);
 
@@ -391,6 +397,7 @@ void radix__flush_tlb_lpid(unsigned long lpid)
 	asm volatile(PPC_TLBIE_5(%0, %4, %3, %2, %1)
 		     : : "r"(rb), "i"(r), "i"(prs), "i"(ric), "r"(rs) : "memory");
 	asm volatile("eieio; tlbsync; ptesync": : :"memory");
+	trace_tlbie(lpid, 0, rb, rs, ric, prs, r);
 }
 EXPORT_SYMBOL(radix__flush_tlb_lpid);
 
@@ -417,12 +424,14 @@ void radix__flush_tlb_all(void)
 	 */
 	asm volatile(PPC_TLBIE_5(%0, %4, %3, %2, %1)
 		     : : "r"(rb), "i"(r), "i"(1), "i"(ric), "r"(rs) : "memory");
+	trace_tlbie(0, 0, rb, rs, ric, prs, r);
 	/*
 	 * now flush host entires by passing PRS = 0 and LPID == 0
 	 */
 	asm volatile(PPC_TLBIE_5(%0, %4, %3, %2, %1)
 		     : : "r"(rb), "i"(r), "i"(prs), "i"(ric), "r"(0) : "memory");
 	asm volatile("eieio; tlbsync; ptesync": : :"memory");
+	trace_tlbie(0, 0, rb, 0, ric, prs, r);
 }
 
 void radix__flush_tlb_pte_p9_dd1(unsigned long old_pte, struct mm_struct *mm,
-- 
2.9.3
