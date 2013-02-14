Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp06.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 2DBB12C0085
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Feb 2013 04:21:35 +1100 (EST)
Received: from /spool/local
 by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Fri, 15 Feb 2013 03:17:06 +1000
Received: from d23relay04.au.ibm.com (d23relay04.au.ibm.com [9.190.234.120])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 07E782CE804A
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Feb 2013 04:21:30 +1100 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay04.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r1EH9HkO12124634
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Feb 2013 04:09:17 +1100
Received: from d23av04.au.ibm.com (loopback [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r1EHLTii012919
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Feb 2013 04:21:29 +1100
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, phileas-fogg@mail.ru,
 geoff@infradead.org
Subject: Re: [PATCH 2/4] powerpc: Update kernel VSID range
In-Reply-To: <1360830983-1812-2-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1360830983-1812-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1360830983-1812-2-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Date: Thu, 14 Feb 2013 22:51:26 +0530
Message-ID: <87liaqzu95.fsf@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
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

> From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
>
> This patch change the kernel VSID range so that we limit VSID_BITS to 37.
> This enables us to support 64TB with 65 bit VA (37+28). Without this patch
> we have boot hangs on platforms that only support 65 bit VA.
>
> With this patch we now have proto vsid generated as below:
>
> We first generate a 37-bit "proto-VSID". Proto-VSIDs are generated
> from mmu context id and effective segment id of the address.
>
> For user processes max context id is limited to ((1ul << 19) - 6)
> for kernel space, we use the top 4 context ids to map address as below
> 0x7fffb -  [ 0xc000000000000000 - 0xcfffffffffffffff ]
> 0x7fffc -  [ 0xd000000000000000 - 0xdfffffffffffffff ]
> 0x7fffd -  [ 0xe000000000000000 - 0xefffffffffffffff ]
> 0x7fffe -  [ 0xf000000000000000 - 0xffffffffffffffff ]

I guess we can do this as below

 0x7fffc -  [ 0xc000000000000000 - 0xcfffffffffffffff ]
 0x7fffd -  [ 0xd000000000000000 - 0xdfffffffffffffff ]
 0x7fffe -  [ 0xe000000000000000 - 0xefffffffffffffff ]
 0x7ffff -  [ 0xf000000000000000 - 0xffffffffffffffff ]

Will update this as part of next revision after I get full review.

diff --git a/arch/powerpc/include/asm/mmu-hash64.h b/arch/powerpc/include/asm/mmu-hash64.h
index 3e297ea..71c69e6 100644
--- a/arch/powerpc/include/asm/mmu-hash64.h
+++ b/arch/powerpc/include/asm/mmu-hash64.h
@@ -355,10 +355,10 @@ extern void slb_set_size(u16 size);
  *
  * For user processes max context id is limited to ((1ul << 19) - 6)
  * for kernel space, we use the top 4 context ids to map address as below
- * 0x7fffb -  [ 0xc000000000000000 - 0xcfffffffffffffff ]
- * 0x7fffc -  [ 0xd000000000000000 - 0xdfffffffffffffff ]
- * 0x7fffd -  [ 0xe000000000000000 - 0xefffffffffffffff ]
- * 0x7fffe -  [ 0xf000000000000000 - 0xffffffffffffffff ]
+ * 0x7fffc -  [ 0xc000000000000000 - 0xcfffffffffffffff ]
+ * 0x7fffd -  [ 0xd000000000000000 - 0xdfffffffffffffff ]
+ * 0x7fffe -  [ 0xe000000000000000 - 0xefffffffffffffff ]
+ * 0x7ffff -  [ 0xf000000000000000 - 0xffffffffffffffff ]
  *
  * The proto-VSIDs are then scrambled into real VSIDs with the
  * multiplicative hash:
@@ -561,10 +561,10 @@ static inline unsigned long get_vsid(unsigned long context, unsigned long ea,
  * This is only valid for addresses >= PAGE_OFFSET
  *
  * For kernel space, we use the top 4 context ids to map address as below
- * 0x7fffb -  [ 0xc000000000000000 - 0xcfffffffffffffff ]
- * 0x7fffc -  [ 0xd000000000000000 - 0xdfffffffffffffff ]
- * 0x7fffd -  [ 0xe000000000000000 - 0xefffffffffffffff ]
- * 0x7fffe -  [ 0xf000000000000000 - 0xffffffffffffffff ]
+ * 0x7fffc -  [ 0xc000000000000000 - 0xcfffffffffffffff ]
+ * 0x7fffd -  [ 0xd000000000000000 - 0xdfffffffffffffff ]
+ * 0x7fffe -  [ 0xe000000000000000 - 0xefffffffffffffff ]
+ * 0x7ffff -  [ 0xf000000000000000 - 0xffffffffffffffff ]
  */
 static inline unsigned long get_kernel_vsid(unsigned long ea, int ssize)
 {
@@ -574,7 +574,7 @@ static inline unsigned long get_kernel_vsid(unsigned long ea, int ssize)
 	 * kernel take the top 4 context from the available range
 	 */
 	c_index =   ((ea >> 60) - 0xc);
-	context = (MAX_CONTEXT - 4) + c_index;
+	context = (MAX_CONTEXT - 3) + c_index;
 #ifdef CONFIG_DEBUG_VM
 	/*
 	 * Drop the c_index related bits from ea, so we get
diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
index d8f6804..cb6404b 100644
--- a/arch/powerpc/kernel/exceptions-64s.S
+++ b/arch/powerpc/kernel/exceptions-64s.S
@@ -1273,10 +1273,10 @@ _GLOBAL(do_stab_bolted)
 	/*
 	 * Calculate VSID:
 	 * This is the kernel vsid, we take the top for context from
-	 * the range. context = (MAX_CONTEXT - 4) + ((ea >> 60) - 0xc)
+	 * the range. context = (MAX_CONTEXT - 3) + ((ea >> 60) - 0xc)
 	 */
 	srdi	r9,r11,60
-	subi	r9,r9,(0xc + 4 + 1)
+	subi	r9,r9,(0xc + 3 + 1)
 	lis	r10,8
 	add	r9,r9,r10		/* context */
 
diff --git a/arch/powerpc/mm/mmu_context_hash64.c b/arch/powerpc/mm/mmu_context_hash64.c
index 9c84b16..59cd773 100644
--- a/arch/powerpc/mm/mmu_context_hash64.c
+++ b/arch/powerpc/mm/mmu_context_hash64.c
@@ -48,6 +48,7 @@ again:
 		return err;
 
 	if (index > (MAX_CONTEXT - 4)) {
+		/* Top 4 context id values are used for kernel */
 		spin_lock(&mmu_context_lock);
 		ida_remove(&mmu_context_ida, index);
 		spin_unlock(&mmu_context_lock);
diff --git a/arch/powerpc/mm/slb_low.S b/arch/powerpc/mm/slb_low.S
index 2a233cb..2c9524b 100644
--- a/arch/powerpc/mm/slb_low.S
+++ b/arch/powerpc/mm/slb_low.S
@@ -56,10 +56,10 @@ _GLOBAL(slb_allocate_realmode)
 _GLOBAL(slb_miss_kernel_load_linear)
 	li	r11,0
 	/*
-	 * context = (MAX_CONTEXT - 4) + ((ea >> 60) - 0xc)
+	 * context = (MAX_CONTEXT - 3) + ((ea >> 60) - 0xc)
 	 */
 	srdi	r9,r3,60
-	subi	r9,r9,(0xc + 4 + 1)
+	subi	r9,r9,(0xc + 3 + 1)
 	lis	r10, 8
 	add	r9,r9,r10
 	srdi	r10,r3,SID_SHIFT	/* get esid */
@@ -99,10 +99,10 @@ _GLOBAL(slb_miss_kernel_load_vmemmap)
 	li	r11,0
 6:
 	/*
-	 * context = (MAX_CONTEXT - 4) + ((ea >> 60) - 0xc)
+	 * context = (MAX_CONTEXT - 3) + ((ea >> 60) - 0xc)
 	 */
 	srdi	r9,r3,60
-	subi	r9,r9,(0xc + 4 + 1)
+	subi	r9,r9,(0xc + 3 + 1)
 	lis	r10,8
 	add	r9,r9,r10
 	srdi	r10,r3,28 /* FIXME!! doing it twice */
