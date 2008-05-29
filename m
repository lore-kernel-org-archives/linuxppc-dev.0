Return-Path: <tpiepho@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 10C37DDE45
	for <linuxppc-dev@ozlabs.org>; Fri, 30 May 2008 08:27:31 +1000 (EST)
Date: Thu, 29 May 2008 15:25:31 -0700 (PDT)
From: Trent Piepho <tpiepho@freescale.com>
To: Roland Dreier <rdreier@cisco.com>
Subject: Re: MMIO and gcc re-ordering issue
In-Reply-To: <adawslcojdg.fsf@cisco.com>
Message-ID: <Pine.LNX.4.64.0805291517140.18832@t2.domain.actdsltmp>
References: <1211852026.3286.36.camel@pasglop>
	<20080526.184047.88207142.davem@davemloft.net>
	<1211854540.3286.42.camel@pasglop>
	<20080526.192812.184590464.davem@davemloft.net>
	<20080526204233.75b71bb8@infradead.org>
	<1211872130.3286.64.camel@pasglop>
	<adaprr721c6.fsf@cisco.com> <1211922696.3286.82.camel@pasglop>
	<adaiqwzsa83.fsf@cisco.com> <yq0iqwxrwuh.fsf@jaguar.mkp.net>
	<adawslcojdg.fsf@cisco.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: linux-arch@vger.kernel.org, Jes Sorensen <jes@sgi.com>,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	scottwood@freescale.com, torvalds@linux-foundation.org,
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

On Thu, 29 May 2008, Roland Dreier wrote:
> > The problem is that your two writel's, despite being both issued on
> > cpu X, due to the spin lock, in your example, can end up with the
> > first one going through NR 1 and the second one going through NR 2. If
> > there's contention on NR 1, the write going via NR 2 may hit the PCI
> > bridge prior to the one going via NR 1.
>
> Really??  I can't see how you can expect any drivers to work reliably if
> simple code like
>
> 	writel(reg1);
> 	writel(reg2);
>
> might end up with the write to reg2 hitting the device before the write
> to reg1.  Almost all MMIO stuff has ordering requirements and will

This is how powerpc is natively (the linux accessors have extra ordering to
not allow this of course), and there are non-Linux drivers that are written
for this ordering model.

I think what makes altix so hard is that writes to the _same_ register may be
be re-ordered.  Re-ordering writes to the same address is much less common
than allowing writes to different addresses to be re-ordered.
