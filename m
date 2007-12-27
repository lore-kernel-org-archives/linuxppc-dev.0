Return-Path: <wd@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id C830FDDE06
	for <linuxppc-dev@ozlabs.org>; Thu, 27 Dec 2007 21:14:06 +1100 (EST)
To: Michael Buesch <mb@bu3sch.de>
From: Wolfgang Denk <wd@denx.de>
Subject: Re: [PATCH v2] powerpc: Do not fail build if mkimage is not available
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Wed, 26 Dec 2007 17:08:51 +0100."
	<200712261708.51432.mb@bu3sch.de>
Date: Thu, 27 Dec 2007 11:14:04 +0100
Sender: wd@denx.de
Message-Id: <20071227101404.2C05F2405E@gemini.denx.de>
Cc: Andrew Morton <akpm@osdl.org>, paulus@au.ibm.com, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

In message <200712261708.51432.mb@bu3sch.de> you wrote:
> On Wednesday 26 December 2007 17:03:43 Andreas Schwab wrote:
> > Michael Buesch <mb@bu3sch.de> writes:
> > 
> > > +    set +e
> > >      mkimage -A ppc -O linux -T kernel -C gzip -a 00000000 -e 00000000 \
> > >  	$uboot_version -d "$vmz" "$ofile"
> > > +    [ $? -eq 0 ] || exit 0
> > > +    set -e
> > 
> > mkimage ... || exit 0
> 
> Could you PLEASE increase your verbosity?
> Why is mkimage || exit 0 any better than my test?

Because it works, while your's doesn't.

Make runs each command in a new shell. Your "set +e" is in vain,  and
so is your test of the return code.

Um... doesn't make throw  an  error  anyway  when  the  execution  of
mkimage fails?

Best regards,

Wolfgang Denk

-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
Success in marriage is not so much finding the right person as it  is
being the right person.
