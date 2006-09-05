Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 7C3C967BB7
	for <linuxppc-dev@ozlabs.org>; Tue,  5 Sep 2006 15:40:06 +1000 (EST)
Date: Tue, 5 Sep 2006 15:39:52 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: David Woodhouse <dwmw2@infradead.org>
Subject: Re: [POWERPC] merge iSeries i/o operations with the rest
Message-Id: <20060905153952.89ea3479.sfr@canb.auug.org.au>
In-Reply-To: <1157432871.2413.9.camel@shinybook.infradead.org>
References: <20060905120817.e52857ee.sfr@canb.auug.org.au>
	<1157432871.2413.9.camel@shinybook.infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: ppc-dev <linuxppc-dev@ozlabs.org>, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi David,

On Mon, 04 Sep 2006 22:07:50 -0700 David Woodhouse <dwmw2@infradead.org> wrote:
>
> On Tue, 2006-09-05 at 12:08 +1000, Stephen Rothwell wrote:
> > The low level i/o operations are now handled in iSeires by taking a
> > trap when we access the (inaccessible) io memory region and calling
> > the Hypervisor from the trap code.  
> 
> There was some discussion of the possibility of using the 'alternatives'
> mechanism to patch the I/O instructions at run-time when we find we've
> booted on iSeries -- just turning each one into a jump to a trampoline
> which does the appropriate hypervisor calls, thus avoiding the overhead
> of the trap each time.
> 
> Was that approach not viable, or not noticeably less of a performance
> hit on iSeries?

It has not been tried, yet, as I need to hone my PPC assembler skills :-)
If the performance on iSeries is unacceptably worse (we need to get some
more testing done), then it would probably be worth while doing as you
suggested (or, equivalently, patching on first trap).  This patch just
gets us along the way and may prove sufficient.

Note that the overhead of the trapping may not be as much as expected
since all i/o on iSeries has to be done with Hypervisor calls.

I have another version coming that modifies the inline assembler much
less, but may make the runtime patching approach slightly harder.

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/
