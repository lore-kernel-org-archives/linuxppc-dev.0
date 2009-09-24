Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 16B72B7B72
	for <linuxppc-dev@ozlabs.org>; Thu, 24 Sep 2009 12:53:45 +1000 (EST)
Subject: Re: [PATCH] powerpc/mm: Fix 40x and 8xx vs. _PAGE_SPECIAL
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Rex Feany <RFeany@mrv.com>
In-Reply-To: <20090924023840.GA16381@compile2.chatsunix.int.mrv.com>
References: <1253679146.7103.270.camel@pasglop>
	<20090924005300.GB11737@compile2.chatsunix.int.mrv.com>
	<1253756434.7103.377.camel@pasglop>
	<20090924023840.GA16381@compile2.chatsunix.int.mrv.com>
Content-Type: text/plain
Date: Thu, 24 Sep 2009 12:53:35 +1000
Message-Id: <1253760815.7103.379.camel@pasglop>
Mime-Version: 1.0
Cc: Scott Wood <scottwood@freescale.com>,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>, "Weirich,
	Bernhard" <Bernhard.Weirich@riedel.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2009-09-23 at 19:38 -0700, Rex Feany wrote:
> Thus spake Benjamin Herrenschmidt (benh@kernel.crashing.org):
> 
> > Hrm. This is really strange...
> 
> Is this a problem? in pte-8xx.h you added:
> 
> +#define _PAGE_SPECIAL  0x0008  /* SW entry, forced to 0 by the TLB miss */
> 
> but there is already this:
> 
> #define _PAGE_EXEC      0x0008  /* software: i-cache coherency required */

Ohhh... you aren't using upstream ! That explains :-)

I removed _PAGE_EXEC from 8xx (since it doesn't use it for anything)
recently.

I think the best option is to go for Bernhard's patch for "stable" and
my patch for upstream, so that "stable" gets the bug fix without the
feature of _PAGE_SPECIAL and upstream gets it both.

Cheers,
Ben.
