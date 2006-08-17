Return-Path: <ntl@pobox.com>
Received: from rune.pobox.com (rune.pobox.com [208.210.124.79])
	by ozlabs.org (Postfix) with ESMTP id 4C92767BA7
	for <linuxppc-dev@ozlabs.org>; Thu, 17 Aug 2006 10:18:19 +1000 (EST)
Date: Wed, 16 Aug 2006 19:18:07 -0500
From: Nathan Lynch <ntl@pobox.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] fix gettimeofday vs. update_gtod race
Message-ID: <20060817001807.GB354@localdomain>
References: <20060811204105.GK3233@localdomain>
	<1155772134.11312.119.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1155772134.11312.119.camel@localhost.localdomain>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Benjamin Herrenschmidt wrote:
> On Fri, 2006-08-11 at 15:41 -0500, Nathan Lynch wrote:
> 
> > +	/* Sampling the time base must be done after loading
> > +	 * do_gtod.varp in order to avoid racing with update_gtod.
> > +	 */
> > +	rmb();
> > +	tb_ticks = get_tb() - temp_varp->tb_orig_stamp;
> 
> The barrier isn't necessary

No?  I didn't find anything about mftb having synchronizing
behavior.  How should we ensure that temp_varp is assigned before
reading the timebase?

Surely at least a compiler barrier is needed?

> and the race not completely closed imho... 

How so?  I could've missed something, but I've hammered the patch
pretty hard, fwiw.

> I need to think about it a bit more closely but what about instead
> just check if tb_ticks goes negative, and if yes, just do get_tb()
> again ?  That might be faster than having a sync in there and should
> still be correct.

I did try something like that but found that a loop (i.e. multiple
get_tb's to "catch up") was necessary.
