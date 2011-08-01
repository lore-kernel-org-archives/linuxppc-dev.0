Return-Path: <alex.williamson@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
	by ozlabs.org (Postfix) with ESMTP id E22D1B6F85
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue,  2 Aug 2011 04:00:25 +1000 (EST)
Subject: Re: kvm PCI assignment & VFIO ramblings
From: Alex Williamson <alex.williamson@redhat.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Mon, 01 Aug 2011 10:40:46 -0600
In-Reply-To: <1312064479.8793.739.camel@pasglop>
References: <1311983933.8793.42.camel@pasglop>
	<1312064479.8793.739.camel@pasglop>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <1312216847.2653.258.camel@bling.home>
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

On Sun, 2011-07-31 at 08:21 +1000, Benjamin Herrenschmidt wrote:
> On Sat, 2011-07-30 at 09:58 +1000, Benjamin Herrenschmidt wrote:
> > Hi folks !
> > 
> > So I promised Anthony I would try to summarize some of the comments &
> > issues we have vs. VFIO after we've tried to use it for PCI pass-through
> > on POWER. It's pretty long, there are various items with more or less
> > impact, some of it is easily fixable, some are API issues, and we'll
> > probably want to discuss them separately, but for now here's a brain
> > dump.
> > 
> > David, Alexei, please make sure I haven't missed anything :-)
> 
> And I think I have :-)
> 
>   * Config space
> 
> VFIO currently handles that as a byte stream. It's quite gross to be
> honest and it's not right. You shouldn't lose access size information
> between guest and host when performing real accesses.
> 
> Some config space registers can have side effects and not respecting
> access sizes can be nasty.

It's a bug, let's fix it.

Alex
