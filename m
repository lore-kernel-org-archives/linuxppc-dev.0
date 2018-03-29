Return-Path: <David.Laight@ACULAB.COM>
Received: from smtp-out6.electric.net (smtp-out6.electric.net
 [192.162.217.191])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40Bnt03cpSzDqph
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 30 Mar 2018 01:57:43 +1100 (AEDT)
From: David Laight <David.Laight@ACULAB.COM>
To: 'Jason Gunthorpe' <jgg@ziepe.ca>, Will Deacon <will.deacon@arm.com>
CC: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Arnd Bergmann
 <arnd@arndb.de>, Sinan Kaya <okaya@codeaurora.org>, Oliver
 <oohall@gmail.com>, "open list:LINUX FOR POWERPC (32-BIT AND 64-BIT)"
 <linuxppc-dev@lists.ozlabs.org>, "linux-rdma@vger.kernel.org"
 <linux-rdma@vger.kernel.org>, "Paul E. McKenney"
 <paulmck@linux.vnet.ibm.com>, Peter Zijlstra <peterz@infradead.org>, "Ingo
 Molnar" <mingo@redhat.com>, Jonathan Corbet <corbet@lwn.net>
Subject: RE: RFC on writel and writel_relaxed
Date: Thu, 29 Mar 2018 14:58:34 +0000
Message-ID: <4ce6f0338fe04574bd3c0633c522a1c7@AcuMS.aculab.com>
References: <bba5ebd8-0643-6f09-9367-419b49e53535@codeaurora.org>
 <20180327143628.GA10642@arm.com>
 <1522186185.7364.59.camel@kernel.crashing.org>
 <20180328085338.GA28871@arm.com>
 <1522230616.21446.1.camel@kernel.crashing.org>
 <CAK8P3a1E54K2pxw-9J5NazF2xNFNvOY1JsGr5C727zAxaz0K5g@mail.gmail.com>
 <1522231287.21446.9.camel@kernel.crashing.org>
 <20180328101345.GA30850@arm.com> <20180328165732.GA4546@ziepe.ca>
 <20180329091941.GA22926@arm.com> <20180329144515.GA13656@ziepe.ca>
In-Reply-To: <20180329144515.GA13656@ziepe.ca>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Jason Gunthorpe
> Sent: 29 March 2018 15:45
...
> > > When talking about ordering between the devices, the relevant questio=
n
> > > is what happens if the writel(DEVICE_BAR) triggers DEVICE_BAR to DMA
> > > from the DEVICE_FOO. 'ordered' means that in this case
> > > writel(DEVICE_FOO) must be presented to FOO before anything generated
> > > by BAR.
> >
> > Yes, and that isn't the case for arm because the writes can still be
> > buffered.
>=20
> The statement is not about buffering, or temporal completion order, or
> the order of acks returning to the CPU. It is about pure transaction
> ordering inside the interconnect.
>=20
> Can write BAR -> FOO pass write CPU -> FOO?

Almost certainly.
The first cpu write can almost certainly be 'stalled' at the shared PCIe br=
idge.
The second cpu write then completes (to a different target).
That target then issues a peer to peer transfer that reaches the shared bri=
dge.
I doubt the order of the transactions is guaranteed when it becomes 'un-sta=
lled'.

Of course, these are peer to peer transfers, and strange ones at that.
Normally you'd not be doing peer to peer transfers that access 'memory'
the cpu has just written to.

Requiring extra barriers in this case, or different functions for WC access=
es
shouldn't really be an issue.

Even requiring a barrier between a write to dma coherent memory and a write
that starts dma isn't really onerous.
Even if it is a nop on all current architectures it is a good comment in th=
e code.
It could even have a 'dev' argument.

	David
