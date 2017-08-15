Return-Path: <npiggin@gmail.com>
Received: from mail-pg0-x244.google.com (mail-pg0-x244.google.com
 [IPv6:2607:f8b0:400e:c05::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xWxlJ2lCxzDqkv
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Aug 2017 01:50:36 +1000 (AEST)
Received: by mail-pg0-x244.google.com with SMTP id 83so2035922pgb.4
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Aug 2017 08:50:36 -0700 (PDT)
Date: Wed, 16 Aug 2017 01:50:21 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: kvm-ppc@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH v2 8/9] powerpc/64: Use a table of paca pointers and
 allocate pacas individually
Message-ID: <20170816015021.60c19579@roar.ozlabs.ibm.com>
In-Reply-To: <20170813013346.14002-8-npiggin@gmail.com>
References: <20170812113416.15978-1-npiggin@gmail.com>
 <20170813013346.14002-8-npiggin@gmail.com>
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

On Sun, 13 Aug 2017 11:33:45 +1000
Nicholas Piggin <npiggin@gmail.com> wrote:

> Change the paca array into an array of pointers to pacas. Allocate
> pacas individually.
> 
> This allows flexibility in where the PACAs are allocated. Future work
> will allocate them node-local. Platforms that don't have address limits
> on PACAs would be able to defer PACA allocations until later in boot
> rather than allocate all possible ones up-front then freeing unused.
> 
> This is slightly more overhead (one additional indirection) for cross
> CPU paca references, but those aren't too common.
> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>

Incremental fix required for this. A !SMP typo bug, and pmac
init code that was not switched from paca array to paca_ptrs
array.

In the first case I just got rid of the r13 thing completely.
I think the idea of the code was to give secondaries a different
r13 so they wouldn't overwrite CPU0's paca if they accidentally
used it.

---
 arch/powerpc/kernel/head_64.S | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/arch/powerpc/kernel/head_64.S b/arch/powerpc/kernel/head_64.S
index f71f468ebe7f..9db29719fc32 100644
--- a/arch/powerpc/kernel/head_64.S
+++ b/arch/powerpc/kernel/head_64.S
@@ -386,12 +386,11 @@ generic_secondary_common_init:
 	 * physical cpu id in r24, we need to search the pacas to find
 	 * which logical id maps to our physical one.
 	 */
-	LOAD_REG_ADDR(r8, paca_ptrs)	/* Load paca_ptrs pointe	 */
-	ld	r8,0(r8)		/* Get base vaddr of array	 */
 #ifndef CONFIG_SMP
-	li	r13,r13,0		/* kill r13 if used accidentally */
 	b	kexec_wait		/* wait for next kernel if !SMP	 */
 #else
+	LOAD_REG_ADDR(r8, paca_ptrs)	/* Load paca_ptrs pointe	 */
+	ld	r8,0(r8)		/* Get base vaddr of array	 */
 	LOAD_REG_ADDR(r7, nr_cpu_ids)	/* Load nr_cpu_ids address       */
 	lwz	r7,0(r7)		/* also the max paca allocated 	 */
 	li	r5,0			/* logical cpu id                */
@@ -752,10 +751,10 @@ _GLOBAL(pmac_secondary_start)
 	mtmsrd	r3			/* RI on */
 
 	/* Set up a paca value for this processor. */
-	LOAD_REG_ADDR(r4,paca)		/* Load paca pointer		*/
-	ld	r4,0(r4)		/* Get base vaddr of paca array	*/
-	mulli	r13,r24,PACA_SIZE	/* Calculate vaddr of right paca */
-	add	r13,r13,r4		/* for this processor.		*/
+	LOAD_REG_ADDR(r4,paca_ptrs)	/* Load paca pointer		*/
+	ld	r4,0(r4)		/* Get base vaddr of paca_ptrs array */
+	sldi	r5,r24,3		/* get paca_ptrs[] index from cpu id */
+	ldx	r13,r4,r5		/* r13 = paca_ptrs[cpu id]       */
 	SET_PACA(r13)			/* Save vaddr of paca in an SPRG*/
 
 	/* Mark interrupts soft and hard disabled (they might be enabled
-- 
2.13.3
