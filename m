Return-Path: <michaelellerman@internode.on.net>
Received: from mail.internode.on.net (bld-mail01.adl2.internode.on.net
	[203.16.214.65]) by ozlabs.org (Postfix) with ESMTP id E7A6867DFA
	for <linuxppc-dev@ozlabs.org>; Fri, 14 Apr 2006 00:34:11 +1000 (EST)
Subject: Re: [patch][rfc]flattened device tree: Passing a dtb (blob) to Linux.
From: Michael Ellerman <michaelellerman@internode.on.net>
To: Jimi Xenidis <jimix@watson.ibm.com>
In-Reply-To: <2A70CBD7-4A52-4599-8BEF-6AC633F62C83@watson.ibm.com>
References: <5148225C-AE27-4365-A1C2-40C46491AF0D@watson.ibm.com>
	<9B2C87C5-0B69-46E7-B48B-9CDB882836B2@watson.ibm.com>
	<20060413053614.2648467DE3@ozlabs.org>
	<C67D530F-2629-4D6B-986B-0FC7CFE525BF@watson.ibm.com>
	<1144926434.7777.5.camel@localhost.localdomain>
	<2A70CBD7-4A52-4599-8BEF-6AC633F62C83@watson.ibm.com>
Content-Type: text/plain
Date: Thu, 13 Apr 2006 16:34:04 +0200
Message-Id: <1144938844.7777.16.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Michael Neuling <mikey@neuling.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 2006-04-13 at 09:19 -0400, Jimi Xenidis wrote:
> Actually, is this even an issue? can the LMB handle repeated  
> reservations?

It can, but we were thinking about adding code to check and warn if
reservations overlap, because it usually indicates a bug. Although
that's probably ok in this case, as long as dtc gets fixed eventually.
Another option would be to not warn for identical reservations.

cheers

> On Apr 13, 2006, at 7:07 AM, Michael Ellerman wrote:
> 
> > On Thu, 2006-04-13 at 06:37 -0400, Jimi Xenidis wrote:
> >> On Apr 13, 2006, at 1:36 AM, Michael Neuling wrote:
> >>
> >>> Hey Jimi,
> >>>
> >>>>> NOTE: that the dtc must also not generate the blob reservation
> >>>>> entry.
> >>>>
> >>>> This reservation is only generated for "asm" dtc targets so it is
> >>>> only that case that need to be changed.
> >>>
> >>> The user space kexec tools create a reserve map entry for the  
> >>> blob as
> >>> well.
> >> good point, but I thought the kexec tools used dtc, no?
> >
> > No, but they should.
> >
> >> looking passed my own world I see:
> >>    - iSeries: not reserving the blob at all
> >
> > That sounds right. I think having the kernel do it is definitely the
> > right option.
> >
> > cheers
> >
> > -- 
> > Michael Ellerman
> > IBM OzLabs
> >
> > wwweb: http://michael.ellerman.id.au
> > phone: +61 2 6212 1183 (tie line 70 21183)
> >
> > We do not inherit the earth from our ancestors,
> > we borrow it from our children. - S.M.A.R.T Person
> >
> 
-- 
Michael Ellerman
IBM OzLabs

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person
