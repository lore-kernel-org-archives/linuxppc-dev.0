Return-Path: <schwab@suse.de>
Received: from mx1.suse.de (ns.suse.de [195.135.220.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx1.suse.de", Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 31037DDE27
	for <linuxppc-dev@ozlabs.org>; Mon, 28 May 2007 21:01:06 +1000 (EST)
From: Andreas Schwab <schwab@suse.de>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: Please pull powerpc.git for_paulus branch (fwd)
References: <Pine.LNX.4.64.0705270856560.4113@gate.crashing.org>
Date: Mon, 28 May 2007 13:00:50 +0200
In-Reply-To: <Pine.LNX.4.64.0705270856560.4113@gate.crashing.org> (Kumar
	Gala's message of "Sun\, 27 May 2007 08\:58\:20 -0500 \(CDT\)")
Message-ID: <jesl9hgql9.fsf@sykes.suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Cc: linuxppc-dev@ozlabs.org, Linus Torvalds <torvalds@osdl.org>,
	Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Kumar Gala <galak@kernel.crashing.org> writes:

> diff --git a/arch/ppc/kernel/entry.S b/arch/ppc/kernel/entry.S
> index ab64256..fba7ca1 100644
> --- a/arch/ppc/kernel/entry.S
> +++ b/arch/ppc/kernel/entry.S
> @@ -596,7 +596,11 @@ fast_exception_return:
>  	mr	r12,r4		/* restart at exc_exit_restart */
>  	b	2b
>
> -	.comm	fee_restarts,4
> +	.section .bss
> +	.align	2
> +fee_restarts:
> +	.space	4
> +	.previous

This is equivalent to .lcomm.

Andreas.

-- 
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE Linux Products GmbH, Maxfeldstraße 5, 90409 Nürnberg, Germany
PGP key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
