Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18495.31442.198759.80890@cargo.ozlabs.ibm.com>
Date: Fri, 30 May 2008 13:56:02 +1000
From: Paul Mackerras <paulus@samba.org>
To: Trent Piepho <tpiepho@freescale.com>
Subject: Re: MMIO and gcc re-ordering issue
In-Reply-To: <Pine.LNX.4.64.0805291517140.18832@t2.domain.actdsltmp>
References: <1211852026.3286.36.camel@pasglop>
	<20080526.184047.88207142.davem@davemloft.net>
	<1211854540.3286.42.camel@pasglop>
	<20080526.192812.184590464.davem@davemloft.net>
	<20080526204233.75b71bb8@infradead.org>
	<1211872130.3286.64.camel@pasglop> <adaprr721c6.fsf@cisco.com>
	<1211922696.3286.82.camel@pasglop> <adaiqwzsa83.fsf@cisco.com>
	<yq0iqwxrwuh.fsf@jaguar.mkp.net> <adawslcojdg.fsf@cisco.com>
	<Pine.LNX.4.64.0805291517140.18832@t2.domain.actdsltmp>
Cc: linux-arch@vger.kernel.org, Roland Dreier <rdreier@cisco.com>,
	Jes Sorensen <jes@sgi.com>, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org, scottwood@freescale.com,
	torvalds@linux-foundation.org,
	David Miller <davem@davemloft.net>, alan@lxorguk.ukuu.org.uk,
	Arjan van de Ven <arjan@infradead.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Trent Piepho writes:

> On Thu, 29 May 2008, Roland Dreier wrote:
> > > The problem is that your two writel's, despite being both issued on
> > > cpu X, due to the spin lock, in your example, can end up with the
> > > first one going through NR 1 and the second one going through NR 2. If
> > > there's contention on NR 1, the write going via NR 2 may hit the PCI
> > > bridge prior to the one going via NR 1.
> >
> > Really??  I can't see how you can expect any drivers to work reliably if
> > simple code like
> >
> > 	writel(reg1);
> > 	writel(reg2);
> >
> > might end up with the write to reg2 hitting the device before the write
> > to reg1.  Almost all MMIO stuff has ordering requirements and will
> 
> This is how powerpc is natively (the linux accessors have extra ordering to
> not allow this of course), and there are non-Linux drivers that are written
> for this ordering model.

In fact stores to non-cacheable locations have to be kept in order,
according to the Power architecture.  But you're correct in that
non-cacheable loads can in principle be reordered w.r.t. each other
and to stores.

> I think what makes altix so hard is that writes to the _same_ register may be
> be re-ordered.  Re-ordering writes to the same address is much less common
> than allowing writes to different addresses to be re-ordered.

Indeed.

Paul.
