Return-Path: <jpoimboe@linux.vnet.ibm.com>
Received: from e4.ny.us.ibm.com (e4.ny.us.ibm.com [32.97.182.144])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e4.ny.us.ibm.com", Issuer "Equifax" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id 90AEDB6F86
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  3 Nov 2011 10:36:44 +1100 (EST)
Received: from /spool/local
 by e4.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <jpoimboe@linux.vnet.ibm.com>;
 Wed, 2 Nov 2011 19:36:39 -0400
Received: from d03av05.boulder.ibm.com (d03av05.boulder.ibm.com [9.17.195.85])
 by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 pA2NabYG317606
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 2 Nov 2011 19:36:38 -0400
Received: from d03av05.boulder.ibm.com (loopback [127.0.0.1])
 by d03av05.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 pA2NaamX008904
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 2 Nov 2011 17:36:37 -0600
Subject: Re: [PATCH v2 1/5] [ppc] Process dynamic relocations for kernel
From: Josh Poimboeuf <jpoimboe@linux.vnet.ibm.com>
To: "Suzuki K. Poulose" <suzuki@in.ibm.com>
In-Reply-To: <20111025115354.8183.48237.stgit@suzukikp.in.ibm.com>
References: <20111025114829.8183.1725.stgit@suzukikp.in.ibm.com>
 <20111025115354.8183.48237.stgit@suzukikp.in.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 02 Nov 2011 18:36:09 -0500
Message-ID: <1320276969.3309.3.camel@treble>
Mime-Version: 1.0
Cc: Nathan Miller <nathanm2@us.ibm.com>, Josh Poimboeuf <jpoimboe@us.ibm.com>,
 Dave Hansen <dave@linux.vnet.ibm.com>, Alan Modra <amodra@au1.ibm.com>,
 Scott Wood <scottwood@freescale.com>, Paul Mackerras <paulus@samba.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2011-10-25 at 17:23 +0530, Suzuki K. Poulose wrote: 
> The following patch implements the dynamic relocation processing for
> PPC32 kernel. relocate() accepts the target virtual address and relocates
>  the kernel image to the same.

Hi Suzuki,

Thanks for the patches.  I've been testing them on a 440-based card, and
encountered TLB error exceptions because the BSS section wasn't getting
properly cleared in early_init().

It turns out that some of the instructions which were modified in
relocate() weren't then getting flushed out of the d-cache into memory.
After that, early_init() executed the stale (non-modified) instructions
for the BSS area.  Those instructions just accessed offset 0 instead of
the actual BSS-related offsets.  That resulted in BSS not getting`
zeroed.

I was able to verify this on my 440 by comparing the d-cache and i-cache
entries for the BSS-accessing instructions in early_init() using a
RISCWatch.  As I suspected, the instructions in the d-cache showed the
corrected offsets, but the i-cache showed the old, non-relocated
offsets.

To fix the issue, I wrote the following patch, applied on top of your
patches.  Suggestions and comments are welcome.



>From c88ae39da0c0352f411aca8d9636990a442d47da Mon Sep 17 00:00:00 2001
From: Josh Poimboeuf <jpoimboe@linux.vnet.ibm.com>
Date: Wed, 2 Nov 2011 16:41:24 -0500
Subject: [PATCH] Flush relocated instructions from data cache

After updating instructions with relocated addresses, flush them from
the data cache and invalidate the icache line so we don't execute stale
instructions.

Signed-off-by: Josh Poimboeuf <jpoimboe@linux.vnet.ibm.com>
---
 arch/powerpc/kernel/reloc_32.S |   11 ++++++++++-
 1 files changed, 10 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/kernel/reloc_32.S
b/arch/powerpc/kernel/reloc_32.S
index 045d61e..a92857d 100644
--- a/arch/powerpc/kernel/reloc_32.S
+++ b/arch/powerpc/kernel/reloc_32.S
@@ -137,6 +137,9 @@ get_type:
 	lwz	r0, 8(r9)	/* r_addend */
 	add	r0, r0, r3	/* final addend */
 	stwx	r0, r4, r7	/* memory[r4+r7]) = (u32)r0 */
+	dcbst	r4,r7		/* flush dcache line to memory */
+	sync			/* wait for flush to complete */
+	icbi	r4,r7		/* invalidate icache line */
 	b	nxtrela		/* continue */
 
 	/* R_PPC_ADDR16_HI */
@@ -177,6 +180,9 @@ lo16:
 	/* Store half word */
 store_half:
 	sthx	r0, r4, r7	/* memory[r4+r7] = (u16)r0 */
+	dcbst	r4,r7		/* flush dcache line to memory */
+	sync			/* wait for flush to complete */
+	icbi	r4,r7		/* invalidate icache line */
 
 nxtrela:
 	cmpwi	r8, 0		/* relasz = 0 ? */
@@ -185,7 +191,10 @@ nxtrela:
 	subf	r8, r6, r8	/* relasz -= relaent */
 	b	applyrela
 
-done:	blr
+done:
+	sync			/* wait for icache invalidates to complete */
+	isync			/* discard any prefetched instructions */
+	blr
 
 
 p_dyn:		.long	__dynamic_start - 0b
-- 
1.7.4.1
