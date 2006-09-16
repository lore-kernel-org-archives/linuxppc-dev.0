Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 43A7D67B97
	for <linuxppc-dev@ozlabs.org>; Sun, 17 Sep 2006 08:57:00 +1000 (EST)
Subject: Re: [PATCH 3/7] POWERPC: Move generic cpm2 stuff to powerpc
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Dan Malek <dan@embeddedalley.com>
In-Reply-To: <FF0EF221-284E-4E0A-8576-EFC7E1CE0DE4@embeddedalley.com>
References: <20060915213751.128e85f3@localhost.localdomain>
	<20060915173912.7984.40164.stgit@localhost.localdomain>
	<20060916183607.94d6facc.sfr@canb.auug.org.au>
	<FF0EF221-284E-4E0A-8576-EFC7E1CE0DE4@embeddedalley.com>
Content-Type: text/plain
Date: Sun, 17 Sep 2006 08:55:51 +1000
Message-Id: <1158447351.14473.233.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, Paul Mackerras <paulus@samba.org>,
	linuxppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat, 2006-09-16 at 12:09 -0400, Dan Malek wrote:
> On Sep 16, 2006, at 4:36 AM, Stephen Rothwell wrote:
> 
> >
> >> +	if (brg < 4) {
> >> +		bp = (uint *)&cpm2_immr->im_brgc1;
> >> +	}
> >> +	else {
> >
> > Normally:
> > 	if (brg < 4)
> > 		bp = (uint *)&cpm2_immr->im_brgc1;
> > 	else {
> 
> Sorry, I'm going to nit-pick right back.  This isn't
> "normal", it's just your preference.  :-)

Nothing is "normal" in C coding style, it's all a matter of preference.
Not having braces around a single-line statement is indeed a preference
shared by the majority of the kernel maintainers, and thus becomes
de-facto the rule, which we can then qualify as "normal" in the context
of the linux kernel :)

> When the "else" part contains braces, the "if"
> part should as well.  If this get modified and
> nested some day in the future, this can cause
> a very subtle coding error.
> 
> No one should ever be criticized for using too
> many braces, provided it is artistically pleasing.
> 
> "Normally," the if-else without braces is only
> used when there are single statements on
> both paths of the logic.  The only exception
> is the else-if that emulates a case statement
> (when other exceptions also apply, see K&R).
> 
> Thanks.
> 
> 	-- Dan
> 
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
