Return-Path: <marcelo.tosatti@cyclades.com>
Received: from hera.kernel.org (hera.kernel.org [140.211.167.34])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 18CDD685C4
	for <linuxppc-dev@ozlabs.org>; Thu, 27 Oct 2005 07:13:04 +1000 (EST)
Date: Wed, 26 Oct 2005 14:08:59 -0200
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Andreas Schwab <schwab@suse.de>
Message-ID: <20051026160859.GA10688@logos.cnet>
References: <20051026133648.GA10373@logos.cnet> <jezmow3v8n.fsf@sykes.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <jezmow3v8n.fsf@sykes.suse.de>
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

On Wed, Oct 26, 2005 at 09:59:20PM +0200, Andreas Schwab wrote:
> Marcelo Tosatti <marcelo.tosatti@cyclades.com> writes:
> 
> > Anyway, surrounding the verification command around an eval expression
> > does the trick correcting the situation. Is it any good? 
> 
> Not at all.  You have effectively disabled the check completely.
> 
> > diff --git a/arch/ppc/Makefile b/arch/ppc/Makefile
> > index 0432a25..cdd9250 100644
> > --- a/arch/ppc/Makefile
> > +++ b/arch/ppc/Makefile
> > @@ -126,7 +126,7 @@ checkbin:
> >  			false; \
> >  		fi ; \
> >  	fi
> > -	@if ! /bin/echo dssall | $(AS) -many -o $(TOUT) >/dev/null 2>&1 ; then \
> > +	@if ! [[ "/bin/echo dssall | $(AS) -many -o $(TOUT) >/dev/null 2>&1" ]] ; then \
> 
> A non-empty string is always true.

Doh - it seemed too easy. I'll go search for some clue (and buy a shell book).

I bet either Make or bash is screwing up.

Thanks
