Return-Path: <scottwood@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 157ABDDFC2
	for <linuxppc-dev@ozlabs.org>; Wed, 30 Apr 2008 04:39:40 +1000 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw01.freescale.net (8.12.11/az33egw01) with ESMTP id
	m3TIa0uT010536
	for <linuxppc-dev@ozlabs.org>; Tue, 29 Apr 2008 11:36:00 -0700 (MST)
Received: from ld0162-tx32.am.freescale.net (ld0162-tx32.am.freescale.net
	[10.82.19.112])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id m3TIZxpc018262
	for <linuxppc-dev@ozlabs.org>; Tue, 29 Apr 2008 13:35:59 -0500 (CDT)
Date: Tue, 29 Apr 2008 13:35:59 -0500
From: Scott Wood <scottwood@freescale.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] [POWERPC] convert transfer_to_handler into a macro
Message-ID: <20080429183559.GE6561@ld0162-tx32.am.freescale.net>
References: <Pine.LNX.4.64.0804290856210.9230@blarg.am.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.LNX.4.64.0804290856210.9230@blarg.am.freescale.net>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Apr 29, 2008 at 08:56:56AM -0500, Kumar Gala wrote:
> +#if defined(CONFIG_40x) || defined(CONFIG_BOOKE)
> +#ifdef CONFIG_SMP
> +#define SMP_ADJUST_GLOBAL_DBCR0						       \
> +	rlwinm	r9,r1,0,0,(31-THREAD_SHIFT);				       \
> +	lwz	r9,TI_CPU(r9);						       \
> +	slwi	r9,r9,3;						       \
> +	add	r11,r11,r9;
> +#else
> +#define SMP_ADJUST_GLOBAL_DBCR0
> +#endif
> +#define HANDLE_DBCR							       \
> +	/* Check to see if the dbcr0 register is set up to debug.  Use the     \
> +	   internal debug mode bit to do this. */			       \
> +	lwz	r12,THREAD_DBCR0(r12);					       \
> +	andis.	r12,r12,DBCR0_IDM@h;					       \

Can we use assembler macros rather than preprocessor macros to get rid of
the backslashes?

-Scott
