Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 0AC141007D5
	for <linuxppc-dev@ozlabs.org>; Wed, 18 Nov 2009 17:01:50 +1100 (EST)
Subject: Re: [PATCH 0/4] powerpc: Fix minor build issues on 2.6.32-rc7
	without CONFIG_XICS set
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: michael@ellerman.id.au
In-Reply-To: <1258462358.24093.83.camel@concordia>
References: <1258459659-11770-1-git-send-email-mel@csn.ul.ie>
	<1258461544.24093.72.camel@concordia>
	<1258462358.24093.83.camel@concordia>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 18 Nov 2009 17:00:56 +1100
Message-ID: <1258524056.2140.662.camel@pasglop>
Mime-Version: 1.0
Cc: Mel Gorman <mel@csn.ul.ie>, linuxppc-dev@ozlabs.org,
	Michael Neuling <mikey@neuling.org>,
	Paul Mackerras <paulus@samba.org>, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2009-11-17 at 23:52 +1100, Michael Ellerman wrote:
> 
> In fact this series makes me wonder whether we can drop support for a
> single kernel image with pseries XICS & MPIC support.

Nope. Not happening. We should just hide CONFIG_XICS just like
CONFIG_MPIC, it should be select'ed by the platform (which today is only
pseries but that might change).

> If we could drop that requirement we could have a single set of names,
> ie. API, for the irq routines and build either the XICS or MPIC
> versions.

And so we would have the ability to build a kernel that supports in a
single binary every platform, as is the case today, ie, pseries,
powermac, pa6t, cell, etc... _BUT_ for pseries support, we would have to
choose at compile time whether to support old or new machines ? Sounds
backward to me :-)

> That would avoid all the code that needs a setup_foo_xics() and
> setup_foo_mpic() - it'd just be setup_foo(), implemented by either the
> XICS or MPIC code.

And that would save us what ? one page on a pSeries machine ? yeah !

Cheers,
Ben.
