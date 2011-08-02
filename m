Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 0C0F3B70C7
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue,  2 Aug 2011 11:29:13 +1000 (EST)
Subject: Re: kvm PCI assignment & VFIO ramblings
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Alex Williamson <alex.williamson@redhat.com>
In-Reply-To: <1312216847.2653.258.camel@bling.home>
References: <1311983933.8793.42.camel@pasglop>
	<1312064479.8793.739.camel@pasglop>
	<1312216847.2653.258.camel@bling.home>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 02 Aug 2011 11:29:00 +1000
Message-ID: <1312248540.8793.828.camel@pasglop>
Mime-Version: 1.0
Cc: Alexey Kardashevskiy <aik@au1.ibm.com>, kvm@vger.kernel.org,
	Paul Mackerras <pmac@au1.ibm.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	David Gibson <dwg@au1.ibm.com>, Anthony Liguori <anthony@codemonkey.ws>,
	linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2011-08-01 at 10:40 -0600, Alex Williamson wrote:
> On Sun, 2011-07-31 at 08:21 +1000, Benjamin Herrenschmidt wrote:
> > On Sat, 2011-07-30 at 09:58 +1000, Benjamin Herrenschmidt wrote:
> > > Hi folks !
> > > 
> > > So I promised Anthony I would try to summarize some of the comments &
> > > issues we have vs. VFIO after we've tried to use it for PCI pass-through
> > > on POWER. It's pretty long, there are various items with more or less
> > > impact, some of it is easily fixable, some are API issues, and we'll
> > > probably want to discuss them separately, but for now here's a brain
> > > dump.
> > > 
> > > David, Alexei, please make sure I haven't missed anything :-)
> > 
> > And I think I have :-)
> > 
> >   * Config space
> > 
> > VFIO currently handles that as a byte stream. It's quite gross to be
> > honest and it's not right. You shouldn't lose access size information
> > between guest and host when performing real accesses.
> > 
> > Some config space registers can have side effects and not respecting
> > access sizes can be nasty.
> 
> It's a bug, let's fix it.

Right. I was just trying to be exhaustive :-) If you don't beat us to
it, we'll eventually submit patches to fix it, we haven't fixed it yet
either, just something I noticed (because this byte-transport also makes
handling of endianess clumsly).

Cheers,
Ben.
