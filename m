Return-Path: <arndbergmann@gmail.com>
Received: from mail-qt0-x243.google.com (mail-qt0-x243.google.com
 [IPv6:2607:f8b0:400d:c0d::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40B3Cl3mpKzF2KH
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Mar 2018 20:55:31 +1100 (AEDT)
Received: by mail-qt0-x243.google.com with SMTP id f16so1892184qth.3
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Mar 2018 02:55:31 -0700 (PDT)
MIME-Version: 1.0
Sender: arndbergmann@gmail.com
In-Reply-To: <1522230616.21446.1.camel@kernel.crashing.org>
References: <CAK8P3a3a+zUNLjqw9CL5rYkXhJ-GMVTVnBU2XUu2f3njZfrqKw@mail.gmail.com>
 <1522141019.7364.43.camel@kernel.crashing.org>
 <20180327095745.GB29373@arm.com>
 <CAK8P3a0s+kP5=qEqTqAHGwB7j9ydaXD+oQJdLrFz=8swuWaDBg@mail.gmail.com>
 <20180327100944.GD29373@arm.com>
 <CAK8P3a0Xep0-EpGS9jnjUf1iJhRxH1WRztGQrvkdrLVaxBPT1w@mail.gmail.com>
 <20180327110258.GF2464@arm.com>
 <bba5ebd8-0643-6f09-9367-419b49e53535@codeaurora.org>
 <20180327143628.GA10642@arm.com>
 <1522186185.7364.59.camel@kernel.crashing.org>
 <20180328085338.GA28871@arm.com>
 <1522230616.21446.1.camel@kernel.crashing.org>
From: Arnd Bergmann <arnd@arndb.de>
Date: Wed, 28 Mar 2018 11:55:27 +0200
Message-ID: <CAK8P3a1E54K2pxw-9J5NazF2xNFNvOY1JsGr5C727zAxaz0K5g@mail.gmail.com>
Subject: Re: RFC on writel and writel_relaxed
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Will Deacon <will.deacon@arm.com>, Sinan Kaya <okaya@codeaurora.org>,
 Jason Gunthorpe <jgg@ziepe.ca>, David Laight <David.Laight@aculab.com>,
 Oliver <oohall@gmail.com>,
 "open list:LINUX FOR POWERPC (32-BIT AND 64-BIT)"
 <linuxppc-dev@lists.ozlabs.org>,
 "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
 "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
 Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>, Jonathan Corbet <corbet@lwn.net>
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Mar 28, 2018 at 11:50 AM, Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:
> On Wed, 2018-03-28 at 09:53 +0100, Will Deacon wrote:
>> For arm/arm64 these end up behaving exactly the same as readX/writeX, but
>> I'm nervous about changing the documentation without understanding why it's
>> like it is currently. Maybe another ia64 thing?.
>
> I doubt it ... the Intel ancestry here would make me think they are
> completely ordered there too.
>
> powerpc and ARM can't quite make them synchronous I think, but at least
> they should have the same semantics as writel.

One thing that ARM does IIRC is that it only guarantees to order writel() within
one device, and the memory mapped PCI I/O space window almost certainly
counts as a separate device to the CPU.

In the absence of an enforced global synchronization during an I/O port
access, that means writel() and outb() can be reordered before they arrive
at a device in theory. Again, this rarely matters in practice, but I think it
makes sense to document the less strict behavior here, given that we have
common hardware that can't provide x86 compatible semantics.

       Arnd
