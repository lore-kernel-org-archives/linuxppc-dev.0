Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e1.ny.us.ibm.com (e1.ny.us.ibm.com [32.97.182.141])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e1.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id DF64ADDED6
	for <linuxppc-dev@ozlabs.org>; Fri, 19 Dec 2008 23:38:46 +1100 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e1.ny.us.ibm.com (8.13.1/8.13.1) with ESMTP id mBJCbosc016987
	for <linuxppc-dev@ozlabs.org>; Fri, 19 Dec 2008 07:37:50 -0500
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v9.1) with ESMTP id
	mBJCcdok114930
	for <linuxppc-dev@ozlabs.org>; Fri, 19 Dec 2008 07:38:39 -0500
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	mBJCc3Pe003299
	for <linuxppc-dev@ozlabs.org>; Fri, 19 Dec 2008 07:38:04 -0500
Date: Fri, 19 Dec 2008 07:38:23 -0500
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 10/10] powerpc/44x: 44x TLB doesn't need "Guarded" set
	for all pages
Message-ID: <20081219123823.GC2721@zod.rchland.ibm.com>
References: <1229663599.904385.502157196243.qpush@grosgo>
	<20081219051458.5995DDDFAD@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20081219051458.5995DDDFAD@ozlabs.org>
Cc: linuxppc-dev@ozlabs.org, Kumar Gala <kumar.gala@freescale.com>,
	Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Dec 19, 2008 at 04:13:54PM +1100, Benjamin Herrenschmidt wrote:
>After discussing with chip designers, it appears that it's not
>necessary to set G everywhere on 440 cores. The various core
>errata related to prefetch should be sorted out by firmware by
>disabling icache prefetching in CCR0. We add the workaround to
>the kernel however just in case oooold firmwares don't do it.
>
>This is valid for -all- 4xx core variants. Later ones hard wire
>the absence of prefetch but it doesn't harm to clear the bits
>in CCR0 (they should already be cleared anyway).
>
>We still leave G=1 on the linear mapping for now, we need to
>stop over-mapping RAM to be able to remove it.
>
>Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

I've been testing this for the past couple of days and it has been
working generally well on large process and heavy threaded workloads.

I'd like to get better testcases, but that's an on-going need so:

Acked-by: Josh Boyer <jwboyer@linux.vnet.ibm.com>

>---
>
> arch/powerpc/kernel/head_44x.S |   12 +++++++++++-
> 1 file changed, 11 insertions(+), 1 deletion(-)
>
>--- linux-work.orig/arch/powerpc/kernel/head_44x.S	2008-12-10 16:11:35.000000000 +1100
>+++ linux-work/arch/powerpc/kernel/head_44x.S	2008-12-10 16:29:08.000000000 +1100
>@@ -69,6 +69,17 @@ _ENTRY(_start);
> 	li	r24,0		/* CPU number */
>
> /*
>+ * In case the firmware didn't do it, we apply some workarounds
>+ * that are good for all 440 core variants here
>+ */
>+	mfspr	r3,SPRN_CCR0
>+	rlwinm	r3,r3,0,0,27	/* disable icache prefetch */
>+	isync
>+	mtspr	SPRN_CCR0,r3
>+	isync
>+	sync
>+
>+/*
>  * Set up the initial MMU state
>  *
>  * We are still executing code at the virtual address
>@@ -570,7 +581,6 @@ finish_tlb_load:
> 	rlwimi	r10,r12,29,30,30		/* DIRTY -> SW position */
> 	and	r11,r12,r10			/* Mask PTE bits to keep */
> 	andi.	r10,r12,_PAGE_USER		/* User page ? */
>-	ori	r11,r11,_PAGE_GUARDED		/* 440 errata, needs G set */
> 	beq	1f				/* nope, leave U bits empty */
> 	rlwimi	r11,r11,3,26,28			/* yes, copy S bits to U */
> 1:	tlbwe	r11,r13,PPC44x_TLB_ATTRIB	/* Write ATTRIB */
