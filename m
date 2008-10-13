Return-Path: <scottwood@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 7EE4ADE708
	for <linuxppc-dev@ozlabs.org>; Tue, 14 Oct 2008 03:15:55 +1100 (EST)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by de01egw01.freescale.net (8.12.11/az33egw01) with ESMTP id
	m9DGFnTF000571
	for <linuxppc-dev@ozlabs.org>; Mon, 13 Oct 2008 09:15:49 -0700 (MST)
Received: from ld0162-tx32.am.freescale.net (ld0162-tx32.am.freescale.net
	[10.82.19.112])
	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id m9DGFmrc010152
	for <linuxppc-dev@ozlabs.org>; Mon, 13 Oct 2008 11:15:48 -0500 (CDT)
Date: Mon, 13 Oct 2008 11:15:47 -0500
From: Scott Wood <scottwood@freescale.com>
To: Nick Piggin <npiggin@suse.de>
Subject: Re: [patch] powerpc: implement optimised mutex fastpaths
Message-ID: <20081013161547.GB19080@ld0162-tx32.am.freescale.net>
References: <20081012054634.GA12535@wotan.suse.de>
	<20081012054732.GB12535@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20081012054732.GB12535@wotan.suse.de>
Cc: linux-arch@vger.kernel.org, linuxppc-dev@ozlabs.org,
	Ingo Molnar <mingo@elte.hu>, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sun, Oct 12, 2008 at 07:47:32AM +0200, Nick Piggin wrote:
> +static inline int __mutex_cmpxchg_lock(atomic_t *v, int old, int new)
> +{
> +	int t;
> +
> +	__asm__ __volatile__ (
> +"1:	lwarx	%0,0,%1		# mutex trylock\n\
> +	cmpw	0,%0,%2\n\
> +	bne-	2f\n"
> +	PPC405_ERR77(0,%1)
> +"	stwcx.	%3,0,%1\n\
> +	bne-	1b"
> +	ISYNC_ON_SMP
> +	"\n\
> +2:"
> +	: "=&r" (t)
> +	: "r" (&v->counter), "r" (old), "r" (new)
> +	: "cc", "memory");

This will break if the compiler picks r0 for &v->counter.  Use "b" as the
constraint, or better yet do "lwarx %0, %y1", with a "Z" (v->counter)
constraint.

-Scott
