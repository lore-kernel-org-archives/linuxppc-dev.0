Return-Path: <schwab@suse.de>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx2.suse.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 7F3DE67B62
	for <linuxppc-dev@ozlabs.org>; Tue, 28 Mar 2006 00:48:16 +1100 (EST)
From: Andreas Schwab <schwab@suse.de>
To: Laurent MEYER <meyerlau@fr.ibm.com>
Subject: Re: [PATCH] sigaltstack bad behavior on powerpc64
References: <1143452261.3911.16.camel@localhost.localdomain>
Date: Mon, 27 Mar 2006 15:48:10 +0200
In-Reply-To: <1143452261.3911.16.camel@localhost.localdomain> (Laurent MEYER's
	message of "Mon, 27 Mar 2006 11:37:41 +0200")
Message-ID: <jey7yw9exx.fsf@sykes.suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Laurent MEYER <meyerlau@fr.ibm.com> writes:

> Index: linux-2.6.16-mcr/arch/powerpc/kernel/signal_64.c
> ===================================================================
> --- linux-2.6.16-mcr.orig/arch/powerpc/kernel/signal_64.c	2006-03-27 11:09:02.000000000 +0200
> +++ linux-2.6.16-mcr/arch/powerpc/kernel/signal_64.c	2006-03-27 11:14:16.986879573 +0200
> @@ -213,7 +213,7 @@
>          /* Default to using normal stack */
>          newsp = regs->gpr[1];
>  
> -	if (ka->sa.sa_flags & SA_ONSTACK) {
> +	if ((ka->sa.sa_flags & SA_ONSTACK) && current->sas_ss_size) {
>  		if (! on_sig_stack(regs->gpr[1]))

This should use sas_ss_flags.

Andreas.

-- 
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE Linux Products GmbH, Maxfeldstraße 5, 90409 Nürnberg, Germany
PGP key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
