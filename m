Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40B4983DbfzF2KY
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Mar 2018 21:38:20 +1100 (AEDT)
Message-ID: <1522232416.21446.10.camel@kernel.crashing.org>
Subject: Re: Aw: Re: RFC on writel and writel_relaxed
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Lino Sanfilippo <LinoSanfilippo@gmx.de>
Cc: Will Deacon <will.deacon@arm.com>, Linus Torvalds
 <torvalds@linux-foundation.org>, Alexander Duyck
 <alexander.duyck@gmail.com>, Sinan Kaya <okaya@codeaurora.org>, Arnd
 Bergmann <arnd@arndb.de>, Jason Gunthorpe <jgg@ziepe.ca>, David Laight
 <David.Laight@aculab.com>, Oliver <oohall@gmail.com>, "open list:LINUX FOR
 POWERPC (32-BIT AND 64-BIT)" <linuxppc-dev@lists.ozlabs.org>,
 "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>, "Paul E.
 McKenney" <paulmck@linux.vnet.ibm.com>, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>
Date: Wed, 28 Mar 2018 21:20:16 +1100
In-Reply-To: <trinity-2ee224b5-cbac-415e-9f8c-305e802b5369-1522232002354@3c-app-gmx-bs61>
References: <1e077f6a-90b6-cce9-6f0f-a8c003fec850@codeaurora.org>
 <20180327151029.GB17494@arm.com>
 <CAKgT0Uem6HT-Z=HBnSVcC4rnDL0yFyXEbr+FN3YYkJ=ExZpUPQ@mail.gmail.com>
 <1522186396.7364.61.camel@kernel.crashing.org>
 <CA+55aFw2R4pirO0m+jtj4F8AF2-tVi3guEaWOA-EBqNyFmh29w@mail.gmail.com>
 <1522198981.7364.81.camel@kernel.crashing.org>
 <CA+55aFyTeuXPmC5-1JGh2ow-rf5wMA6Vcv0aeS_q0_EnptSK9Q@mail.gmail.com>
 <1522211620.7364.94.camel@kernel.crashing.org>
 <CA+55aFw24R3YAujir59GdG+sBBQOA9WyXySEN3AcEYK99ZHuwQ@mail.gmail.com>
 <1522219376.7364.109.camel@kernel.crashing.org>
 <20180328090710.GB28871@arm.com>
 <1522230988.21446.7.camel@kernel.crashing.org>
 <trinity-2ee224b5-cbac-415e-9f8c-305e802b5369-1522232002354@3c-app-gmx-bs61>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2018-03-28 at 12:13 +0200, Lino Sanfilippo wrote:
> Hi,
> 
> 
> > 
> > Yeah so that other trick I'm talking about is also used for timing
> > accuracy.
> > 
> > For example, let's say I have a device with a reset bit and the spec
> > says the reset bit needs to be set for at least 10us.
> > 
> > This is wrong:
> > 
> > 	writel(1, RESET_REG);
> > 	usleep(10);
> > 	writel(0, RESET_REG);
> > 
> > Because of write posting, the first write might arrive to the device
> > right before the second one.
> > 
> 
> Does not write posting only concern PCI? This seems to be a different topic. Furthermore
> write posting should not include write reordering...

Nobody's talking about re-ordering and no, write posting is rather
common practice on a whole lot of different busses, not just PCI(e).

Cheers,
Ben.
