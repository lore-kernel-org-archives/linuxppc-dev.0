Return-Path: <schwab@suse.de>
Received: from mx1.suse.de (ns.suse.de [195.135.220.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx1.suse.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id B30D9685CF
	for <linuxppc-dev@ozlabs.org>; Thu, 27 Oct 2005 05:59:27 +1000 (EST)
From: Andreas Schwab <schwab@suse.de>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
References: <20051026133648.GA10373@logos.cnet>
Date: Wed, 26 Oct 2005 21:59:20 +0200
In-Reply-To: <20051026133648.GA10373@logos.cnet> (Marcelo Tosatti's message of
	"Wed, 26 Oct 2005 11:36:48 -0200")
Message-ID: <jezmow3v8n.fsf@sykes.suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Cc: linuxppc-dev@ozlabs.org
Subject: Re: Makefile check for older binutils broken?
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Marcelo Tosatti <marcelo.tosatti@cyclades.com> writes:

> Anyway, surrounding the verification command around an eval expression
> does the trick correcting the situation. Is it any good? 

Not at all.  You have effectively disabled the check completely.

> diff --git a/arch/ppc/Makefile b/arch/ppc/Makefile
> index 0432a25..cdd9250 100644
> --- a/arch/ppc/Makefile
> +++ b/arch/ppc/Makefile
> @@ -126,7 +126,7 @@ checkbin:
>  			false; \
>  		fi ; \
>  	fi
> -	@if ! /bin/echo dssall | $(AS) -many -o $(TOUT) >/dev/null 2>&1 ; then \
> +	@if ! [[ "/bin/echo dssall | $(AS) -many -o $(TOUT) >/dev/null 2>&1" ]] ; then \

A non-empty string is always true.

Andreas.

-- 
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE Linux Products GmbH, Maxfeldstraße 5, 90409 Nürnberg, Germany
Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
