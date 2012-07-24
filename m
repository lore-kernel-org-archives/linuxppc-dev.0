Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp05.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id D27A72C008A
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Jul 2012 19:15:11 +1000 (EST)
Received: from /spool/local
 by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Tue, 24 Jul 2012 19:15:01 +1000
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay04.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 q6O96Ywi59900148
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Jul 2012 19:06:35 +1000
Received: from d23av03.au.ibm.com (loopback [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 q6O9EfGw002828
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Jul 2012 19:14:41 +1000
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH -V3 11/11] arch/powerpc: Add 64TB support
In-Reply-To: <87eho1o8pv.fsf@skywalker.in.ibm.com>
References: <1341839621-28332-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1341839621-28332-12-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <20120723093951.GB29264@bloggs.ozlabs.ibm.com>
 <87txwyhj5e.fsf@skywalker.in.ibm.com>
 <20120723110654.GC29264@bloggs.ozlabs.ibm.com>
 <87eho1o8pv.fsf@skywalker.in.ibm.com>
Date: Tue, 24 Jul 2012 14:44:38 +0530
Message-ID: <87boj5o70h.fsf@skywalker.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

"Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com> writes:

> Paul Mackerras <paulus@samba.org> writes:
>
>> On Mon, Jul 23, 2012 at 03:52:05PM +0530, Aneesh Kumar K.V wrote:
>>> Paul Mackerras <paulus@samba.org> writes:
>>> 
>>> > On Mon, Jul 09, 2012 at 06:43:41PM +0530, Aneesh Kumar K.V wrote:
>>> >
>>> >> -#define USER_ESID_BITS		16
>>> >> -#define USER_ESID_BITS_1T	4
>>> >> +#define USER_ESID_BITS		18
>>> >> +#define USER_ESID_BITS_1T	6
>>> >
>>> > You also need to change the proto-VSID generation for kernel addresses
>>> > when you do this.  If you don't you'll end up with some user processes
>>> > using the same VSIDs as we use for the kernel addresses, meaning that
>>> > those processes won't run very well...
>>> >
>>> 
>>> Can you explain this more. right now we generate vsid as below
>>> 
>>> vsid_scramble(ea >> SID_SHIFT, 256M) for kernel
>>> 
>>> vsid_scramble((context << USER_ESID_BITS) | (ea >> SID_SHIFT), 256M);
>>> for user
>>> 
>>> what changes are you suggesting ?
>>
>> Think about it.  With the current values of USER_ESID_BITS and
>> CONTEXT_BITS, and the addresses we use for kernel mappings, there are
>> no values of context, user_ea and kernel_ea for which
>>
>> kernel_ea >> SID_SHIFT == (context << USER_ESID_BITS) | (user_ea >> SID_SHIFT)
>>
>> If you increase USER_ESID_BITS, then there will be some context values
>> for which that equation becomes true.  For example, if you increase
>> USER_ESID_BITS to 18, then context 0x30000 will generate the same
>> proto-VSIDs as the kernel linear mapping.  Since we can hand out
>> contexts up to 0x7ffff (with CONTEXT_BITS = 19), there is a collision.
>>
>> In other words, the proto-VSID space (the space of values that are
>> input to vsid_scramble) is currently divided into two mutually
>> exclusive regions: from 0 to 2^35 - 1 for user processes, and from
>> 2^35 to 2^36 - 1 for kernel addresses.  You are wanting to expand the
>> amount of proto-VSID space that user processes can use, but you need
>> either to move the kernel portion of the space, or to make sure that
>> the context allocator doesn't hand out context values that would
>> collide with the kernel portion of the space (or both).
>
> How about this ?. There is a FIXME in there which is not related.

Updated one with both the fixes. Let me know what you think

>From f04a505be381b9c162fa41bda5df4a1a9edfdeb9 Mon Sep 17 00:00:00 2001
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Date: Tue, 24 Jul 2012 14:22:15 +0530
Subject: [PATCH 1/2] arch/powerpc: properly offset the context bits for 1T
 segemnts

We should do rldimi r10,r9,USER_ESID_BITS,0 only after populating
r10 with ESID bits.

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 arch/powerpc/mm/slb_low.S |   12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/mm/slb_low.S b/arch/powerpc/mm/slb_low.S
index db2cb3f..7bd8438 100644
--- a/arch/powerpc/mm/slb_low.S
+++ b/arch/powerpc/mm/slb_low.S
@@ -59,6 +59,7 @@ _GLOBAL(slb_miss_kernel_load_linear)
 BEGIN_FTR_SECTION
 	b	slb_finish_load
 END_MMU_FTR_SECTION_IFCLR(MMU_FTR_1T_SEGMENT)
+	srdi	r10,r10,40-28		/* get 1T ESID */
 	b	slb_finish_load_1T
 
 1:
@@ -88,6 +89,7 @@ _GLOBAL(slb_miss_kernel_load_vmemmap)
 BEGIN_FTR_SECTION
 	b	slb_finish_load
 END_MMU_FTR_SECTION_IFCLR(MMU_FTR_1T_SEGMENT)
+	srdi	r10,r10,40-28		/* get 1T ESID */
 	b	slb_finish_load_1T
 
 0:	/* user address: proto-VSID = context << 15 | ESID. First check
@@ -155,13 +157,16 @@ END_MMU_FTR_SECTION_IFCLR(MMU_FTR_1T_SEGMENT)
 	ld	r9,PACACONTEXTID(r13)
 BEGIN_FTR_SECTION
 	cmpldi	r10,0x1000
+	bge	9f
 END_MMU_FTR_SECTION_IFSET(MMU_FTR_1T_SEGMENT)
 	rldimi	r10,r9,USER_ESID_BITS,0
+	b	slb_finish_load
 BEGIN_FTR_SECTION
-	bge	slb_finish_load_1T
+9:
+	srdi	r10,r10,40-28		/* get 1T ESID */
+	rldimi	r10,r9,USER_ESID_BITS,0
+	b	slb_finish_load_1T
 END_MMU_FTR_SECTION_IFSET(MMU_FTR_1T_SEGMENT)
-	b	slb_finish_load
-
 8:	/* invalid EA */
 	li	r10,0			/* BAD_VSID */
 	li	r11,SLB_VSID_USER	/* flags don't much matter */
@@ -292,7 +297,6 @@ _GLOBAL(slb_compare_rr_to_size)
  * r3 = EA, r10 = proto-VSID, r11 = flags, clobbers r9
  */
 slb_finish_load_1T:
-	srdi	r10,r10,40-28		/* get 1T ESID */
 	ASM_VSID_SCRAMBLE(r10,r9,1T)
 	/*
 	 * bits above VSID_BITS_1T need to be ignored from r10
-- 
1.7.10


>From 43792d9e2c394370c71623f2769d11ff98090918 Mon Sep 17 00:00:00 2001
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Date: Tue, 24 Jul 2012 11:40:29 +0530
Subject: [PATCH 2/2] arch/powerpc: properly isolate kernel and user
 proto-VSID

The proto-VSID space is divided into two class
User: 0 to 2^(CONTEXT_BITS + USER_ESID_BITS) -1
kernel: 2^(CONTEXT_BITS + USER_ESID_BITS) to 2^(VSID_BITS) - 1

This patch does above isolation

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/mmu-hash64.h |   32 ++++++++++++++++++++++++--------
 arch/powerpc/kernel/exceptions-64s.S  |    4 +++-
 arch/powerpc/mm/slb_low.S             |   10 ++++++++++
 3 files changed, 37 insertions(+), 9 deletions(-)

diff --git a/arch/powerpc/include/asm/mmu-hash64.h b/arch/powerpc/include/asm/mmu-hash64.h
index daa3e4b..736df15 100644
--- a/arch/powerpc/include/asm/mmu-hash64.h
+++ b/arch/powerpc/include/asm/mmu-hash64.h
@@ -516,9 +516,19 @@ typedef struct {
 /* This is only valid for addresses >= PAGE_OFFSET */
 static inline unsigned long get_kernel_vsid(unsigned long ea, int ssize)
 {
-	if (ssize == MMU_SEGSIZE_256M)
-		return vsid_scramble(ea >> SID_SHIFT, 256M);
-	return vsid_scramble(ea >> SID_SHIFT_1T, 1T);
+	unsigned long proto_vsid;
+	/*
+	 * We need to make sure proto_vsid for the kernel is
+	 * >= 2^(CONTEXT_BITS + USER_ESID_BITS[_1T])
+	 */
+	if (ssize == MMU_SEGSIZE_256M) {
+		proto_vsid = ea >> SID_SHIFT;
+		proto_vsid |= (1UL << (CONTEXT_BITS + USER_ESID_BITS));
+		return vsid_scramble(proto_vsid, 256M);
+	}
+	proto_vsid = ea >> SID_SHIFT_1T;
+	proto_vsid |= (1UL << (CONTEXT_BITS + USER_ESID_BITS_1T));
+	return vsid_scramble(proto_vsid, 1T);
 }
 
 /* Returns the segment size indicator for a user address */
@@ -534,11 +544,17 @@ static inline int user_segment_size(unsigned long addr)
 static inline unsigned long get_vsid(unsigned long context, unsigned long ea,
 				     int ssize)
 {
-	if (ssize == MMU_SEGSIZE_256M)
-		return vsid_scramble((context << USER_ESID_BITS)
-				     | (ea >> SID_SHIFT), 256M);
-	return vsid_scramble((context << USER_ESID_BITS_1T)
-			     | (ea >> SID_SHIFT_1T), 1T);
+	unsigned long proto_vsid;
+	if (ssize == MMU_SEGSIZE_256M) {
+		proto_vsid = ((context << USER_ESID_BITS) |(ea >> SID_SHIFT));
+		/* truncate this to 37 bits */
+		proto_vsid &= (1UL << (CONTEXT_BITS + USER_ESID_BITS)) - 1;
+		return vsid_scramble(proto_vsid, 256M);
+	}
+	proto_vsid = ((context << USER_ESID_BITS_1T) | (ea >> SID_SHIFT_1T));
+	/* truncate this to 25 bits */
+	proto_vsid &= (1UL << (CONTEXT_BITS + USER_ESID_BITS_1T)) - 1;
+	return vsid_scramble( proto_vsid, 1T);
 }
 
 #endif /* __ASSEMBLY__ */
diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
index 1c06d29..40ed208 100644
--- a/arch/powerpc/kernel/exceptions-64s.S
+++ b/arch/powerpc/kernel/exceptions-64s.S
@@ -958,7 +958,9 @@ _GLOBAL(do_stab_bolted)
 	rldimi	r10,r11,7,52	/* r10 = first ste of the group */
 
 	/* Calculate VSID */
-	/* This is a kernel address, so protovsid = ESID */
+	/* This is a kernel address, so protovsid = ESID | 1 << 37 */
+	li	r9,0x1
+	rldimi  r11,r9,(CONTEXT_BITS + USER_ESID_BITS),0
 	ASM_VSID_SCRAMBLE(r11, r9, 256M)
 	rldic	r9,r11,12,16	/* r9 = vsid << 12 */
 
diff --git a/arch/powerpc/mm/slb_low.S b/arch/powerpc/mm/slb_low.S
index 7bd8438..e6bace3 100644
--- a/arch/powerpc/mm/slb_low.S
+++ b/arch/powerpc/mm/slb_low.S
@@ -57,9 +57,13 @@ _GLOBAL(slb_allocate_realmode)
 _GLOBAL(slb_miss_kernel_load_linear)
 	li	r11,0
 BEGIN_FTR_SECTION
+	li	r9,0x1
+	rldimi  r10,r9,(CONTEXT_BITS + USER_ESID_BITS),0
 	b	slb_finish_load
 END_MMU_FTR_SECTION_IFCLR(MMU_FTR_1T_SEGMENT)
 	srdi	r10,r10,40-28		/* get 1T ESID */
+	li	r9,0x1
+	rldimi  r10,r9,(CONTEXT_BITS + USER_ESID_BITS_1T),0
 	b	slb_finish_load_1T
 
 1:
@@ -87,9 +91,13 @@ _GLOBAL(slb_miss_kernel_load_vmemmap)
 	li	r11,0
 6:
 BEGIN_FTR_SECTION
+	li	r9,0x1
+	rldimi  r10,r9,(CONTEXT_BITS + USER_ESID_BITS),0
 	b	slb_finish_load
 END_MMU_FTR_SECTION_IFCLR(MMU_FTR_1T_SEGMENT)
 	srdi	r10,r10,40-28		/* get 1T ESID */
+	li	r9,0x1
+	rldimi  r10,r9,(CONTEXT_BITS + USER_ESID_BITS_1T),0
 	b	slb_finish_load_1T
 
 0:	/* user address: proto-VSID = context << 15 | ESID. First check
@@ -160,11 +168,13 @@ BEGIN_FTR_SECTION
 	bge	9f
 END_MMU_FTR_SECTION_IFSET(MMU_FTR_1T_SEGMENT)
 	rldimi	r10,r9,USER_ESID_BITS,0
+	clrldi	r10,r10,(64 - (CONTEXT_BITS + USER_ESID_BITS))
 	b	slb_finish_load
 BEGIN_FTR_SECTION
 9:
 	srdi	r10,r10,40-28		/* get 1T ESID */
 	rldimi	r10,r9,USER_ESID_BITS,0
+	clrldi	r10,r10,(64 - (CONTEXT_BITS + USER_ESID_BITS_1T))
 	b	slb_finish_load_1T
 END_MMU_FTR_SECTION_IFSET(MMU_FTR_1T_SEGMENT)
 8:	/* invalid EA */
-- 
1.7.10
