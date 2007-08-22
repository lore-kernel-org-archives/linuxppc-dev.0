Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e36.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id B8276DDE18
	for <linuxppc-dev@ozlabs.org>; Thu, 23 Aug 2007 00:03:43 +1000 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e36.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l7ME3J5P009117
	for <linuxppc-dev@ozlabs.org>; Wed, 22 Aug 2007 10:03:19 -0400
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.5) with ESMTP id
	l7ME3HF7247014
	for <linuxppc-dev@ozlabs.org>; Wed, 22 Aug 2007 08:03:18 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l7ME3GtZ026905
	for <linuxppc-dev@ozlabs.org>; Wed, 22 Aug 2007 08:03:16 -0600
Date: Wed, 22 Aug 2007 09:03:15 -0500
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: RFC: [PATCH v2] Fixup modpost warnings in head*.S for ppc32
Message-ID: <20070822090315.7e0010c4@weaponx.rchland.ibm.com>
In-Reply-To: <Pine.LNX.4.64.0708220856530.31744@blarg.am.freescale.net>
References: <Pine.LNX.4.64.0708220856530.31744@blarg.am.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 22 Aug 2007 08:58:31 -0500 (CDT)
Kumar Gala <galak@kernel.crashing.org> wrote:

> Addess the following modpost warnings we get out of the ppc32 head
> files:
> 
> WARNING: vmlinux.o(.text+0x358): Section mismatch: reference to .init.text:early_init (between 'skpinv' and 'interrupt_base')
> WARNING: vmlinux.o(.text+0x380): Section mismatch: reference to .init.text:machine_init (between 'skpinv' and 'interrupt_base')
> WARNING: vmlinux.o(.text+0x384): Section mismatch: reference to .init.text:MMU_init (between 'skpinv' and 'interrupt_base')
> WARNING: vmlinux.o(.text+0x3aa): Section mismatch: reference to .init.text:start_kernel (between 'skpinv' and 'interrupt_base')
> WARNING: vmlinux.o(.text+0x3ae): Section mismatch: reference to .init.text:start_kernel (between 'skpinv' and 'interrupt_base')
> 
> Does anyone have any issues with this?  This version cleans up 40x based
> on the latest for-2.6.24 tree and removes the stabs defn from _ENTRY.

No signed-off-by on purpose?

> diff --git a/arch/powerpc/kernel/head_40x.S b/arch/powerpc/kernel/head_40x.S
> index a8e0457..00bdb6d 100644
> --- a/arch/powerpc/kernel/head_40x.S
> +++ b/arch/powerpc/kernel/head_40x.S
> @@ -52,9 +52,9 @@
>   *
>   * This is all going to change RSN when we add bi_recs.......  -- Dan
>   */
> -	.text
> -_GLOBAL(_stext)
> -_GLOBAL(_start)
> +	.section	.text.head, "ax"
> +_ENTRY(_stext);
> +_ENTRY(_start);
> 
>  	/* Save parameters we are passed.
>  	*/
> @@ -89,9 +89,9 @@ turn_on_mmu:
>   */
>  	. = 0xc0
>  crit_save:
> -_GLOBAL(crit_r10)
> +_ENTRY(crit_r10)
>  	.space	4
> -_GLOBAL(crit_r11)
> +_ENTRY(crit_r11)
>  	.space	4
> 
>  /*
> @@ -814,7 +814,7 @@ finish_tlb_load:
>   * The PowerPC 4xx family of processors do not have an FPU, so this just
>   * returns.
>   */
> -_GLOBAL(giveup_fpu)
> +_ENTRY(giveup_fpu)
>  	blr

I had moved this bit below initial_mmu instead in my version.  I
realize there isn't much difference from a technical point of view, but
it seems misleading to label this one as _ENTRY.

josh
