Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e32.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id D68B2DDFBA
	for <linuxppc-dev@ozlabs.org>; Tue, 20 May 2008 12:09:06 +1000 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e32.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id m4K25ZY3028615
	for <linuxppc-dev@ozlabs.org>; Mon, 19 May 2008 22:05:35 -0400
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	m4K293Fc108356
	for <linuxppc-dev@ozlabs.org>; Mon, 19 May 2008 20:09:03 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m4K293Z1026240
	for <linuxppc-dev@ozlabs.org>; Mon, 19 May 2008 20:09:03 -0600
Date: Mon, 19 May 2008 21:04:52 -0500
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH v3 3/3] [POWERPC] 40x/Book-E: Save/restore volatile
	exception registers
Message-ID: <20080519210452.28e8805c@zod.rchland.ibm.com>
In-Reply-To: <Pine.LNX.4.64.0805161407440.6286@blarg.am.freescale.net>
References: <Pine.LNX.4.64.0805161404410.6286@blarg.am.freescale.net>
	<Pine.LNX.4.64.0805161406100.6286@blarg.am.freescale.net>
	<Pine.LNX.4.64.0805161407440.6286@blarg.am.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 16 May 2008 14:08:00 -0500 (CDT)
Kumar Gala <galak@kernel.crashing.org> wrote:

> On machines with more than one exception level any system register that
> might be modified by the "normal" exception level needs to be saved and
> restored on taking a higher level exception.  We already are saving
> and restoring ESR and DEAR.
> 
> For critical level add SRR0/1.
> For debug level add CSRR0/1 and SRR0/1.
> For machine check level add DSRR0/1, CSRR0/1, and SRR0/1.
> 
> On FSL Book-E parts we always save/restore the MAS registers for critical,
> debug, and machine check level exceptions.  On 44x we always save/restore
> the MMUCR.
> 
> Additionally, we save and restore the ksp_limit since we have to adjust it
> for each exception level.
> 
> Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
> ---

<snip>

> --- a/arch/powerpc/kernel/entry_32.S
> +++ b/arch/powerpc/kernel/entry_32.S

<snip>

> +#ifdef CONFIG_40x
>  	.globl	ret_from_crit_exc
>  ret_from_crit_exc:
> +	mfspr	r9,SPRN_SPRG3
	lis 	r10,saved_ksp_limit@ha;
	lwz	r10,saved_ksp_limit@l(r10);
	tovirt(r9,r9);
> +	stw	r10,KSP_LIMIT(r9)
	lis	r9, crit_srr0@ha;
	lwz	r9, crit_srr0@l(r9);
	lis	r10, crit_srr1@ha;
	lwz	r10, crit_srr1@l(r10);
> +	mtspr	SPRN_SRR0,r9;
> +	mtspr	SPRN_SRR1,r10;
>  	RET_FROM_EXC_LEVEL(SPRN_CSRR0, SPRN_CSRR1, RFCI)
> +#endif /* CONFIG_40x */

With the above changes, I no longer get kernel panics on returning from
critical exceptions.  Breakpoints and single stepping worked on my
405GP board.

Again, not stress tested but it's looking much better.

josh
