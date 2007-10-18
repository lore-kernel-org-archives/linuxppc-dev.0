Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 86D62DDE98
	for <linuxppc-dev@ozlabs.org>; Thu, 18 Oct 2007 21:45:39 +1000 (EST)
Subject: Re: [PATCH] ppc44x: support for 256K PAGE_SIZE
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
In-Reply-To: <1192704248.13993.36.camel@localhost.localdomain>
References: <200710181108.19413.yur@emcraft.com>
	<1192704248.13993.36.camel@localhost.localdomain>
Content-Type: text/plain
Date: Thu, 18 Oct 2007 21:45:14 +1000
Message-Id: <1192707914.12879.51.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Thu, 2007-10-18 at 05:44 -0500, Josh Boyer wrote:
> On Thu, 2007-10-18 at 11:08 +0400, Yuri Tikhonov wrote:
> >  Hello,
> > 
> >  The following patch adds support for 256KB PAGE_SIZE on ppc44x-based boards. 
> > The applications to be run on the kernel with 256KB PAGE_SIZE have to be 
> > built using the modified version of binutils, where the MAXPAGESIZE 
> > definition is set to 0x40000 (as opposite to standard 0x10000).
> 
> Sorry, this is against arch/ppc which is bug fix only.  New features
> should be done against arch/powerpc.  Also, I'd rather see something
> along the lines of hugetlbfs support instead.

I slightly disagree on that one. It does make sense in embedded
applications to use larger page sizes like that to compensate for small
TLBs, and hugetlbfs has serious constraints that may well make it
impractical.

Based on that, I'd be tempted to let that in provided it doesn't
requires ugly hacks, which seems to be the case. It still needs to be
adapted to arch/powerpc however, and get closer scrutiny that I didn't
have time to do yet.

You are the maintainer, so you decide, but my opinion here is that
wanting that is fair enough.

Cheers,
Ben.
