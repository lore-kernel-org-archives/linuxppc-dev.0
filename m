Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 665EADDEDA
	for <linuxppc-dev@ozlabs.org>; Fri, 10 Oct 2008 14:54:16 +1100 (EST)
Subject: Re: [RFC] powerpc: add kexec support on Book-E
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Sebastian Andrzej Siewior <sebastian@breakpoint.cc>
In-Reply-To: <1222896024-22172-2-git-send-email-sebastian@breakpoint.cc>
References: <1222896024-22172-1-git-send-email-sebastian@breakpoint.cc>
	<1222896024-22172-2-git-send-email-sebastian@breakpoint.cc>
Content-Type: text/plain
Date: Fri, 10 Oct 2008 14:53:46 +1100
Message-Id: <1223610826.8157.142.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	kexec@lists.infradead.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 2008-10-01 at 23:20 +0200, Sebastian Andrzej Siewior wrote:

> +#define KEXEC_MODE_NOMMU 1
> +#define KEXEC_MODE_BOOKE 2

No need for runtime detection here, you cannot and likely never will be
able to build a kernel that does bot BookE and real mode...

> +
> +/* 1. Find the index of the entry we're executing in */
> +	bl	invstr			/* Find our address */
> +invstr:
> +	mflr	r6			/* Make it accessible */
> +	mfmsr	r7
> +	rlwinm	r4,r7,27,31,31		/* extract MSR[IS] */
> +	mfspr	r7, SPRN_PID0
> +	slwi	r7,r7,16
> +	or	r7,r7,r4
> +	mtspr	SPRN_MAS6,r7
> +	tlbsx	0,r6			/* search MSR[IS], SPID=PID0 */
> +	mfspr	r7,SPRN_MAS1
> +	andis.	r7,r7,MAS1_VALID@h
> +	bne	match_TLB

This isn't just BookE .. it's specifically FSL BookE (or "merged"
architecture). This isn't going to work on 44x for example. You need to
make it clearer.

Cheers,
Ben.
