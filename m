Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e33.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 87268DDEA2
	for <linuxppc-dev@ozlabs.org>; Thu, 18 Oct 2007 22:01:47 +1000 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e33.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l9IC1gNc009026
	for <linuxppc-dev@ozlabs.org>; Thu, 18 Oct 2007 08:01:42 -0400
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v8.5) with ESMTP id
	l9IC1fb6356126
	for <linuxppc-dev@ozlabs.org>; Thu, 18 Oct 2007 06:01:41 -0600
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l9IC1fBl013456
	for <linuxppc-dev@ozlabs.org>; Thu, 18 Oct 2007 06:01:41 -0600
Date: Thu, 18 Oct 2007 07:01:39 -0500
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: benh@kernel.crashing.org
Subject: Re: [PATCH] ppc44x: support for 256K PAGE_SIZE
Message-ID: <20071018070139.339e2efb@weaponx.rchland.ibm.com>
In-Reply-To: <1192707914.12879.51.camel@pasglop>
References: <200710181108.19413.yur@emcraft.com>
	<1192704248.13993.36.camel@localhost.localdomain>
	<1192707914.12879.51.camel@pasglop>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 18 Oct 2007 21:45:14 +1000
Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:

> 
> On Thu, 2007-10-18 at 05:44 -0500, Josh Boyer wrote:
> > On Thu, 2007-10-18 at 11:08 +0400, Yuri Tikhonov wrote:
> > >  Hello,
> > > 
> > >  The following patch adds support for 256KB PAGE_SIZE on ppc44x-based boards. 
> > > The applications to be run on the kernel with 256KB PAGE_SIZE have to be 
> > > built using the modified version of binutils, where the MAXPAGESIZE 
> > > definition is set to 0x40000 (as opposite to standard 0x10000).
> > 
> > Sorry, this is against arch/ppc which is bug fix only.  New features
> > should be done against arch/powerpc.  Also, I'd rather see something
> > along the lines of hugetlbfs support instead.
> 
> I slightly disagree on that one. It does make sense in embedded
> applications to use larger page sizes like that to compensate for small
> TLBs, and hugetlbfs has serious constraints that may well make it
> impractical.

Out of curiosity, what constraints are those?

> Based on that, I'd be tempted to let that in provided it doesn't
> requires ugly hacks, which seems to be the case. It still needs to be
> adapted to arch/powerpc however, and get closer scrutiny that I didn't
> have time to do yet.
> 
> You are the maintainer, so you decide, but my opinion here is that
> wanting that is fair enough.

I always reserve the right to change my mind.  If something makes sense
and the code is decent enough then it might very well be acceptable.
Requiring a modified binutils makes me a bit nervous though.

josh
