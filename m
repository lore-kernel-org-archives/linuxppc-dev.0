Return-Path: <ntl@pobox.com>
Received: from rune.pobox.com (rune.pobox.com [208.210.124.79])
	by ozlabs.org (Postfix) with ESMTP id A7A2767BDF
	for <linuxppc-dev@ozlabs.org>; Fri, 18 Aug 2006 06:47:25 +1000 (EST)
Date: Thu, 17 Aug 2006 15:47:12 -0500
From: Nathan Lynch <ntl@pobox.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] fix gettimeofday vs. update_gtod race
Message-ID: <20060817204712.GD354@localdomain>
References: <20060811204105.GK3233@localdomain>
	<1155772134.11312.119.camel@localhost.localdomain>
	<20060817001807.GB354@localdomain>
	<1155774477.11312.137.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1155774477.11312.137.camel@localhost.localdomain>
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
> On Wed, 2006-08-16 at 19:18 -0500, Nathan Lynch wrote:
> 
> > No?  I didn't find anything about mftb having synchronizing
> > behavior.  How should we ensure that temp_varp is assigned before
> > reading the timebase?
> 
> I sync an isync would be enough.

I see, thanks.

> > > I need to think about it a bit more closely but what about instead
> > > just check if tb_ticks goes negative, and if yes, just do get_tb()
> > > again ?  That might be faster than having a sync in there and should
> > > still be correct.
> > 
> > I did try something like that but found that a loop (i.e. multiple
> > get_tb's to "catch up") was necessary.
> 
> Hrm... even with an isync ?

No, sorry, I was confusing this with a different bug (cpu
hotplug-related, separate patch for that forthcoming).
