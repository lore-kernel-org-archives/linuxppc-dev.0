Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 6E680DDE24
	for <linuxppc-dev@ozlabs.org>; Sun, 14 Sep 2008 03:56:16 +1000 (EST)
Subject: Re: [PATCH v4 1/4] powerpc: Introduce local (non-broadcast) forms
	of tlb invalidates
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1221253688-25864-1-git-send-email-galak@kernel.crashing.org>
References: <1221253688-25864-1-git-send-email-galak@kernel.crashing.org>
Content-Type: text/plain
Date: Sat, 13 Sep 2008 10:56:11 -0700
Message-Id: <1221328571.7675.29.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


>  static inline void flush_tlb_range(struct vm_area_struct *vma,
>  				   unsigned long start, unsigned long end)
>  {
> -	_tlbia();
> +	_tlbil_all();
>  }

Why not the _pid() variant here ?

> +/*
> + * Flush MMU TLB for a particular process id, but only on the local processor
> + * (no broadcast)
> + */
> +_GLOBAL(_tlbil_pid)
> +	li	r3,(MMUCSR0_TLBFI)@l
> +	mtspr	SPRN_MMUCSR0, r3
> +1:
> +	mfspr	r3,SPRN_MMUCSR0
> +	andi.	r3,r3,MMUCSR0_TLBFI@l
> +	bne	1b
> +	blr

This will do a full inval of the TLB right ? Might be worth mentioning
this implementation limitation in a comment..

Cheers,
Ben.
