Return-Path: <will_schmidt@vnet.ibm.com>
Received: from e1.ny.us.ibm.com (e1.ny.us.ibm.com [32.97.182.141])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e1.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 1182FDDFB2
	for <linuxppc-dev@ozlabs.org>; Thu,  8 Mar 2007 02:29:14 +1100 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e1.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id l27FT8ZE023038
	for <linuxppc-dev@ozlabs.org>; Wed, 7 Mar 2007 10:29:08 -0500
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id
	l27FT8Vr142900
	for <linuxppc-dev@ozlabs.org>; Wed, 7 Mar 2007 10:29:09 -0500
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l27FT8oV026537
	for <linuxppc-dev@ozlabs.org>; Wed, 7 Mar 2007 10:29:08 -0500
Subject: Re: [PATCH] [POWERPC] fix up log_plpar_hcall_return
From: Will Schmidt <will_schmidt@vnet.ibm.com>
To: Stephen Rothwell <sfr@canb.auug.org.au>
In-Reply-To: <20070307111246.79afc104.sfr@canb.auug.org.au>
References: <1173222701.13165.9.camel@localhost>
	<20070307111246.79afc104.sfr@canb.auug.org.au>
Content-Type: text/plain
Date: Wed, 07 Mar 2007 09:29:05 -0600
Message-Id: <1173281345.13165.76.camel@localhost>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
Reply-To: will_schmidt@vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 2007-07-03 at 11:12 +1100, Stephen Rothwell wrote: 
> [sfr done Blue Hair]

Hi Stephen, 

/me looks for blue spraypaint..

> Hi Will,
> 
> On Tue, 06 Mar 2007 17:11:41 -0600 Will Schmidt <will_schmidt@vnet.ibm.com> wrote:
> >
> > This is mostly cosmetic.  This updates log_plpar_hcall_return() to use a
> > case statement rather than an if-then-else jumble, and moves it to
> > rtas.c where it can be near the other rtas related functions.
> 
> You are moving a static function from the only file that calls it.  You
> are exporting it when the only callers are in a file that cannot be part
> of a module and you are (maybe) optimizing something that is only used in
> error paths.

> Sorry, but unless you are doing to introduce others uses, that I don't
> see that this change helps.

Yes.  This moves the function to somewhere a bit more accessible so
others *can* call it.   The comment at the top of the function being
replaced even says something like "find a better place for me...".  

Lparcfg *did* begin it's life as a module, and I'm sure I've turned it
back into a module at least once.   I dont know when it was last
reverted, but suspect it was done by someone who didnt know about
EXPORT_PER_CPU_SYMBOL_GPL, but I digress.. 
I've got a patch to turn lparcfg back into a module, but wanted to start
with this simpler cleanup patch first.

All that, and I've wanted to get rid of that particular if-else mess for
a while.  You are right that it's an error path optimization, though
this change isn't meant as much for optimization as fixing up the horrid
coding style that was initially used.

> [sfr redons normal hair]
How about Purple?  :-)

> 
> I don't mean to sound harsh  :-)
Not a problem.    depending on what other comments I get back, I'll
reorganize a bit and submit a larger patchset with other changes too. 

-Will

> 
> --
> Cheers,
> Stephen Rothwell                    sfr@canb.auug.org.au
> http://www.canb.auug.org.au/~sfr/
