Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xRXM1425RzDqp8
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  8 Aug 2017 21:32:45 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Andreas Schwab <schwab@linux-m68k.org>, linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] powerpc: fix invalid use of register expressions
In-Reply-To: <878tixj3wg.fsf@linux-m68k.org>
References: <878tixj3wg.fsf@linux-m68k.org>
Date: Tue, 08 Aug 2017 21:32:44 +1000
Message-ID: <87poc6mh0j.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Andreas Schwab <schwab@linux-m68k.org> writes:

> binutils >= 2.26 now warns about misuse of register expressions in
> assembler operands that are actually literals, for example:
>
> arch/powerpc/kernel/entry_64.S:535: Warning: invalid register expression
>
> Signed-off-by: Andreas Schwab <schwab@linux-m68k.org>
> ---
>  arch/powerpc/include/asm/ppc_asm.h |  2 +-
>  arch/powerpc/kernel/swsusp_asm64.S |  2 +-
>  arch/powerpc/kvm/book3s_64_slb.S   |  2 +-
>  arch/powerpc/lib/copypage_power7.S | 14 ++++----
>  arch/powerpc/lib/copyuser_power7.S | 66 +++++++++++++++++++-------------------
>  arch/powerpc/lib/memcpy_power7.S   | 66 +++++++++++++++++++-------------------
>  arch/powerpc/lib/string_64.S       |  2 +-
>  7 files changed, 77 insertions(+), 77 deletions(-)

Thanks. I updated the change log to mention that it's almost always
s/r0/0/.

And I folded in:

diff --git a/arch/powerpc/purgatory/trampoline.S b/arch/powerpc/purgatory/trampoline.S
index 3696ea6c4826..30277446892c 100644
--- a/arch/powerpc/purgatory/trampoline.S
+++ b/arch/powerpc/purgatory/trampoline.S
@@ -67,7 +67,7 @@ master:
 	mr	%r16,%r3	/* save dt address in reg16 */
 	li	%r4,20
 	LWZX_BE	%r6,%r3,%r4	/* fetch __be32 version number at byte 20 */
-	cmpwi	%r0,%r6,2	/* v2 or later? */
+	cmpwi	%cr0,%r6,2	/* v2 or later? */
 	blt	1f
 	li	%r4,28
 	STWX_BE	%r17,%r3,%r4	/* Store my cpu as __be32 at byte 28 */

cheers
