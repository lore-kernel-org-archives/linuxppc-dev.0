Return-Path: <joe@perches.com>
Received: from smtprelay.hostedemail.com (smtprelay0214.hostedemail.com
 [216.40.44.214])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3t9Tjj1jkCzDt1W
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  5 Nov 2016 04:44:23 +1100 (AEDT)
Message-ID: <1478281455.1924.41.camel@perches.com>
Subject: Re: Coding Style: Reverse XMAS tree declarations ?
From: Joe Perches <joe@perches.com>
To: David Miller <davem@davemloft.net>, lsanfil@marvell.com
Cc: madalin.bucur@nxp.com, akpm@linux-foundation.org, corbet@lwn.net,
 netdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, oss@buserror.net, ppc@mindchasers.com,
 pebolle@tiscali.nl, joakim.tjernlund@transmode.se, Randy Dunlap
 <rdunlap@infradead.org>
Date: Fri, 04 Nov 2016 10:44:15 -0700
In-Reply-To: <20161104.110759.1093635654135143910.davem@davemloft.net>
References: <20161103.155816.642712588084106823.davem@davemloft.net>
 <1478242438.1924.31.camel@perches.com> <581C6A7D.8030704@marvell.com>
 <20161104.110759.1093635654135143910.davem@davemloft.net>
Content-Type: text/plain; charset="ISO-8859-1"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2016-11-04 at 11:07 -0400, David Miller wrote:
> From: Lino Sanfilippo <lsanfil@marvell.com>
> > On 04.11.2016 07:53, Joe Perches wrote:
> >> CHECK:REVERSE_XMAS_TREE: Prefer ordering declarations longest to
> >> shortest
> >> #446: FILE: drivers/net/ethernet/ethoc.c:446:
> >> +                    int size = bd.stat >> 16;
> >> +                    struct sk_buff *skb;
> > should not this case be valid? Optically the longer line is already
> > before the shorter.
> > I think that the whole point in using this reverse xmas tree ordering
> > is to have
> > the code optically tidied up and not to enforce ordering between
> > variable name lengths.
> 
> That's correct.

And also another reason the whole reverse xmas tree
automatic declaration layout concept is IMO dubious.

Basically, you're looking not at the initial ordering
of automatics as important, but helping find a specific
automatic when reversing from reading code is not always
correct.

Something like:

static void function{args,...)
{
	[longish list of reverse xmas tree identifiers...]
	struct foo *bar = longish_function(args, ...);
	struct foobarbaz *qux;
	[more identifers]

	[multiple screenfuls of code later...)

	new_function(..., bar, ...);

	[more code...]
}

and the reverse xmas tree helpfulness of looking up the
type of bar is neither obvious nor easy.

My preference would be for a bar that serves coffee and alcohol.
