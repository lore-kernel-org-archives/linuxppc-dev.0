Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id B4AFEDDFF2
	for <linuxppc-dev@ozlabs.org>; Sat, 14 Mar 2009 00:22:09 +1100 (EST)
Message-Id: <9223B51A-4340-4636-B1F8-6D49A5F8833A@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: David Jander <david.jander@protonic.nl>
In-Reply-To: <200903131121.00077.david.jander@protonic.nl>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v930.3)
Subject: Re: [RFC] [PATCH v2] MPC5121 TLB errata workaround
Date: Fri, 13 Mar 2009 08:21:57 -0500
References: <200903131121.00077.david.jander@protonic.nl>
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>, Paul Mackerras <paulus@samba.org>,
	Wolfgang Denk <wd@denx.de>, Gunnar Von Boehn <gunnar@genesi-usa.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>

What does cat /proc/cpuinfo show on this board?

> +#ifdef CONFIG_PPC_MPC512x
> +/* MPC512x: workaround for errata in die M36P and earlier:
> + * Implement LRW for TLB way.
> + */

This errata impacts a number of cores and so we should make this a CPU  
feature fixup rather than #ifdef code.

> +       mfspr   r3,SPRN_DMISS
> +       rlwinm  r3,r3,19,25,29 /* Get Address bits 19:15 */
> +       lis     r2,lrw@ha       /* Search index in lrw[] */
> +       addi    r2,r2,lrw@l
> +       tophys(r2,r2)
> +       lwzx    r1,r3,r2       /* Get item from lrw[] */
> +       cmpwi   0,r1,0         /* Was it way 0 last time? */

Why not use a bit vector since we only need one bit of information.   
Additionally we can use a single SPRG at that point instead to keep  
track of the LRU information.

> +       beq-    0,113f         /* Then goto 113: */
> +
> +       mfspr   r1,SPRN_SRR1
> +       rlwinm  r1,r1,0,15,13  /* Mask out SRR1[WAY] */
> +       mtspr   SPRN_SRR1,r1
> +
> +       li      r0,0
> +       stwx    r0,r3,r2       /* Make lrw[] entry 0 */
> +       b       114f
> +113:
> +       li      r0,1
> +       stwx    r0,r3,r2       /* Make lrw[] entry 1 */
> +114:
> +#endif
>        mfctr   r0
>        /* Get PTE (linux-style) and check access */
>        mfspr   r3,SPRN_DMISS
> @@ -688,6 +717,34 @@ DataStoreTLBMiss:
>        .globl mol_trampoline
>        .set mol_trampoline, i0x2f00
>
> +#ifdef CONFIG_PPC_MPC512x
> +TlbWo:
> +/* MPC512x: workaround for errata in die M36P and earlier:
> + * Implement LRW for TLB way.
> + */
> +       mfspr   r3,SPRN_DMISS
> +       rlwinm  r3,r3,19,25,29 /* Get Address bits 19:15 */
> +       lis     r2,lrw@ha       /* Search index in lrw[] */
> +       addi    r2,r2,lrw@l
> +       tophys(r2,r2)
> +       lwzx    r1,r3,r2       /* Get item from lrw[] */
> +       cmpwi   0,r1,0         /* Was it way 0 last time? */
> +       beq-    0,113f         /* Then goto 113: */
> +
> +       mfspr   r1,SPRN_SRR1
> +       rlwinm  r1,r1,0,15,13  /* Mask out SRR1[WAY] */
> +       mtspr   SPRN_SRR1,r1
> +
> +       li      r0,0
> +       stwx    r0,r3,r2       /* Make lrw[] entry 0 */
> +       b       114f
> +113:
> +       li      r0,1
> +       stwx    r0,r3,r2       /* Make lrw[] entry 1 */
> +114:
> +       b       RFTlbWo
> +#endif
> +
>        . = 0x3000
>
> AltiVecUnavailable:
> @@ -1321,6 +1378,14 @@ intercept_table:
>        .long 0, 0, 0, 0, 0, 0, 0, 0
>        .long 0, 0, 0, 0, 0, 0, 0, 0
>        .long 0, 0, 0, 0, 0, 0, 0, 0
> +
> +#ifdef CONFIG_PPC_MPC512x
> +lrw:
> +       .long 0, 0, 0, 0, 0, 0, 0, 0
> +       .long 0, 0, 0, 0, 0, 0, 0, 0
> +       .long 0, 0, 0, 0, 0, 0, 0, 0
> +       .long 0, 0, 0, 0, 0, 0, 0, 0
> +#endif
>
> /* Room for two PTE pointers, usually the kernel and current user  
> pointers
>  * to their respective root page table.
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
