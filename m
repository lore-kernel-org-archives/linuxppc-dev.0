Return-Path: <dale@farnsworth.org>
Received: from xyzzy.farnsworth.org (xyzzy.farnsworth.org [65.39.95.219])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 85D08DE0DF
	for <linuxppc-dev@ozlabs.org>; Tue,  8 Apr 2008 02:21:54 +1000 (EST)
Date: Mon, 7 Apr 2008 09:21:26 -0700
From: Dale Farnsworth <dale@farnsworth.org>
To: Johannes Berg <johannes@sipsolutions.net>
Message-ID: <20080407162126.GC9912@farnsworth.org>
References: <20080404213932.GA15847@farnsworth.org>
	<1207543791.10388.468.camel@pasglop>
	<1207573809.12481.6.camel@johannes.berg>
MIME-Version: 1.0
In-Reply-To: <1207573809.12481.6.camel@johannes.berg>
Subject: Re: [PATCH v2] powerpc: Add irqtrace support for 32-bit powerpc
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Apr 07, 2008 at 03:10:09PM +0200, Johannes Berg wrote:
> > Note that I've been wondering wether we should attempt to trace all
> > those IRQ state change internally to the exception code. I've looked at
> > not doing it, which simplifies things a bit.
> > 
> > Unfortunately, that will make us occasionally trace redundant
> > enable/disable (which isn't a big problem per-se, just counters).
> 
> We already have a huge number of redundant enable/disable, about 40% of
> all events on both 32 and 64-bit.

Yes, but there is a big difference between the large number of actual
redundant enables and disables we now have, and introducing miscounts
of them in the measurement code.  That we have so many might mean that
we shouldn't bother to count them at all, but I don't think it's an
excuse for not counting them accurately.

-Dale
