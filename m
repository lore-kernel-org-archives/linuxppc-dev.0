Return-Path: <mb@bu3sch.de>
Received: from vs166246.vserver.de (vs166246.vserver.de [62.75.166.246])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id AD0E4DDE02
	for <linuxppc-dev@ozlabs.org>; Fri, 28 Dec 2007 05:14:21 +1100 (EST)
From: Michael Buesch <mb@bu3sch.de>
To: Wolfgang Denk <wd@denx.de>
Subject: Re: [PATCH v2] powerpc: Do not fail build if mkimage is not available
Date: Thu, 27 Dec 2007 19:13:10 +0100
References: <20071227101404.2C05F2405E@gemini.denx.de>
In-Reply-To: <20071227101404.2C05F2405E@gemini.denx.de>
MIME-Version: 1.0
Message-Id: <200712271913.10433.mb@bu3sch.de>
Content-Type: text/plain;
  charset="iso-8859-1"
Cc: Andrew Morton <akpm@osdl.org>, paulus@au.ibm.com, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thursday 27 December 2007 11:14:04 Wolfgang Denk wrote:
> In message <200712261708.51432.mb@bu3sch.de> you wrote:
> > On Wednesday 26 December 2007 17:03:43 Andreas Schwab wrote:
> > > Michael Buesch <mb@bu3sch.de> writes:
> > > 
> > > > +    set +e
> > > >      mkimage -A ppc -O linux -T kernel -C gzip -a 00000000 -e 00000000 \
> > > >  	$uboot_version -d "$vmz" "$ofile"
> > > > +    [ $? -eq 0 ] || exit 0
> > > > +    set -e
> > > 
> > > mkimage ... || exit 0
> > 
> > Could you PLEASE increase your verbosity?
> > Why is mkimage || exit 0 any better than my test?
> 
> Because it works, while your's doesn't.
> 
> Make runs each command in a new shell. Your "set +e" is in vain,  and
> so is your test of the return code.
> 
> Um... doesn't make throw  an  error  anyway  when  the  execution  of
> mkimage fails?

I'm not sure what you are talking about at all, sorry.
set +e simply disables the abortion of the shell script if
the mkimage command fails. The test after that checks whether it failed
and returns success in that event, so the calling makefile does
_not_ interrupt. It only gives you a mkimage not found message.

I did test this patch on my machine where there is no mkimage
and it correctly aborts the shell script and throws an error,
while it does not abort the makefile process. And that is what we want.

-- 
Greetings Michael.
