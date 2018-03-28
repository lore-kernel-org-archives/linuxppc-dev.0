Return-Path: <LinoSanfilippo@gmx.de>
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40B3lH2WF0zF2Jd
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Mar 2018 21:19:22 +1100 (AEDT)
MIME-Version: 1.0
Message-ID: <trinity-2ee224b5-cbac-415e-9f8c-305e802b5369-1522232002354@3c-app-gmx-bs61>
From: "Lino Sanfilippo" <LinoSanfilippo@gmx.de>
To: "Benjamin Herrenschmidt" <benh@kernel.crashing.org>
Cc: "Will Deacon" <will.deacon@arm.com>, "Linus Torvalds"
 <torvalds@linux-foundation.org>, "Alexander Duyck"
 <alexander.duyck@gmail.com>, "Sinan Kaya" <okaya@codeaurora.org>, "Arnd
 Bergmann" <arnd@arndb.de>, "Jason Gunthorpe" <jgg@ziepe.ca>, "David Laight"
 <David.Laight@aculab.com>, Oliver <oohall@gmail.com>, "open list:LINUX FOR
 POWERPC (32-BIT AND 64-BIT)" <linuxppc-dev@lists.ozlabs.org>,
 "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>, "Paul E.
 McKenney" <paulmck@linux.vnet.ibm.com>, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>
Subject: Aw: Re: RFC on writel and writel_relaxed
Content-Type: text/plain; charset=UTF-8
Date: Wed, 28 Mar 2018 12:13:22 +0200
In-Reply-To: <1522230988.21446.7.camel@kernel.crashing.org>
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
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,


> 
> Yeah so that other trick I'm talking about is also used for timing
> accuracy.
> 
> For example, let's say I have a device with a reset bit and the spec
> says the reset bit needs to be set for at least 10us.
> 
> This is wrong:
> 
> 	writel(1, RESET_REG);
> 	usleep(10);
> 	writel(0, RESET_REG);
> 
> Because of write posting, the first write might arrive to the device
> right before the second one.
> 

Does not write posting only concern PCI? This seems to be a different topic. Furthermore
write posting should not include write reordering...

Regards,
Lino
