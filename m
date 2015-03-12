Return-Path: <duwe@lst.de>
Received: from newverein.lst.de (verein.lst.de [213.95.11.211])
 (using TLSv1 with cipher DHE-RSA-CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 269571A09D4
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Mar 2015 02:31:03 +1100 (AEDT)
Date: Thu, 12 Mar 2015 16:24:10 +0100
From: Torsten Duwe <duwe@lst.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [RFC] powerpc: use ticket spin lock for !CONFIG_PPC_SPLPAR
Message-ID: <20150312152410.GA12372@lst.de>
References: <1426157723-28548-1-git-send-email-haokexin@gmail.com>
 <1426158807.17565.131.camel@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1426158807.17565.131.camel@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>, Kevin Hao <haokexin@gmail.com>,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Mar 12, 2015 at 10:13:27PM +1100, Benjamin Herrenschmidt wrote:
> On Thu, 2015-03-12 at 18:55 +0800, Kevin Hao wrote:
> > I know Torsten Duwe has tried to add the ticket spinlock for powerpc
> > one year ago [1]. But it make no progress due to the conflict between

OMG, time flies.

> > PPC_SPLPAR and lockref. We still don't find a better way to handle
> > this. But instead of waiting forever for a perfect solution, can't we
> > just use the ticket spinlock for the !CONFIG_PPC_SPLPAR?

I was actually thinking about squeezing it all (incl. lockref) into 64 bits,
or making it a bit larger, keeping the holder outside the cache line, or ...
Then priorities shifted.

> I would do the ifdef'ing differently, something like
> 
> CONFIG_PPC_HAS_LOCK_OWNER
> 
> CONFIG_PPC_TICKET_LOCKS depends on !PPC_HAS_LOCK_OWNER
> 
> and use these two in the code... with SPLPAR select'ing HAS_LOCK_OWNER

Or avoid ifdef'ing and give pseries its own, platform-specific lock implementation?
It's more work in the build framework but clearer in the C source. Just a though.

But generally, which platforms would benefit most from this change?
I must admit my access to hardware variety is somewhat limited ;-)

	Torsten
