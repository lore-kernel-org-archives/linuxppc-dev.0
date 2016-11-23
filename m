Return-Path: <bsingharora@gmail.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tNw0C0kSbzDvgt
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Nov 2016 19:06:35 +1100 (AEDT)
Received: from mail-pf0-x244.google.com (mail-pf0-x244.google.com
 [IPv6:2607:f8b0:400e:c00::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3tNw0B2wcpz9s3s
 for <linuxppc-dev@ozlabs.org>; Wed, 23 Nov 2016 19:06:34 +1100 (AEDT)
Received: by mail-pf0-x244.google.com with SMTP id y68so366022pfb.1
 for <linuxppc-dev@ozlabs.org>; Wed, 23 Nov 2016 00:06:34 -0800 (PST)
To: Michael Ellerman <mpe@ellerman.id.au>,
 linuxppc-dev <linuxppc-dev@ozlabs.org>
Subject: [RFC] [PATCH] Trace TLBIE's
Cc: Paul Mackerras <paulus@samba.org>, Nicholas Piggin <npiggin@gmail.com>
From: Balbir Singh <bsingharora@gmail.com>
Message-ID: <3dcd0c76-46fd-cb7a-945d-4b5a679fa544@gmail.com>
Date: Wed, 23 Nov 2016 19:06:27 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
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
make it nicer (expand the RB/RS/IS/L cases in more detail). For now I am
sharing the idea to get inputs

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


diff --git a/arch/powerpc/include/asm/trace.h b/arch/powerpc/include/asm/trace.h
index 32e36b1..b4e02ba 100644
--- a/arch/powerpc/include/asm/trace.h
+++ b/arch/powerpc/include/asm/trace.h
@@ -168,6 +168,38 @@ TRACE_EVENT(hash_fault,
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
+		"prs=0x%lx, r=0x%lx", __entry->lpid, __entry->local, __entry->rb,
+		__entry->rs, __entry->ric, __entry->prs, __entry->r)
+);
+
 #endif /* _TRACE_POWERPC_H */
 
 #undef TRACE_INCLUDE_PATH
diff --git a/arch/powerpc/kvm/book3s_hv_rm_mmu.c b/arch/powerpc/kvm/book3s_hv_rm_mmu.c
index 99b4e9d..5b032e9 100644
--- a/arch/powerpc/kvm/book3s_hv_rm_mmu.c
+++ b/arch/powerpc/kvm/book3s_hv_rm_mmu.c
@@ -15,6 +15,7 @@
 #include <linux/log2.h>
 
 #include <asm/tlbflush.h>
+#include <asm/trace.h>
 #include <asm/kvm_ppc.h>
 #include <asm/kvm_book3s.h>
 #include <asm/book3s/64/mmu-hash.h>
@@ -414,16 +415,22 @@ static void do_tlbies(struct kvm *kvm, unsigned long *rbvalues,
 			cpu_relax();
 		if (need_sync)
 			asm volatile("ptesync" : : : "memory");
-		for (i = 0; i < npages; ++i)
+		for (i = 0; i < npages; ++i) {
 			asm volatile(PPC_TLBIE(%1,%0) : :
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
 			asm volatile("tlbiel %0" : : "r" (rbvalues[i]));
+			trace_tlbie(kvm->arch.lpid, 1, rbvalues[i],
+				0, 0, 0, 0);
+		}
 		asm volatile("ptesync" : : : "memory");
 	}
 }
diff --git a/arch/powerpc/mm/hash_native_64.c b/arch/powerpc/mm/hash_native_64.c
index 9d9b3ef..a31ff2b 100644
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
index bda8c43..933b373 100644
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
 
@@ -417,10 +424,12 @@ void radix__flush_tlb_all(void)
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
