Return-Path: <alexander.duyck@gmail.com>
Received: from mail-wm0-x232.google.com (mail-wm0-x232.google.com
 [IPv6:2a00:1450:400c:c09::232])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 409lCV1NKSzF28W
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Mar 2018 08:54:13 +1100 (AEDT)
Received: by mail-wm0-x232.google.com with SMTP id b127so518984wmf.5
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Mar 2018 14:54:13 -0700 (PDT)
MIME-Version: 1.0
From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Tue, 27 Mar 2018 14:54:09 -0700
Message-ID: <CAKgT0UfZKBTYPCqWtBF=N5TPFrbsv0ZU+2GHMqF3J4BM9Hw4yw@mail.gmail.com>
Subject: Re: RFC on writel and writel_relaxed
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Sinan Kaya <okaya@codeaurora.org>, Arnd Bergmann <arnd@arndb.de>,
 Jason Gunthorpe <jgg@ziepe.ca>,
 David Laight <David.Laight@aculab.com>, Oliver <oohall@gmail.com>,
 "open list:LINUX FOR POWERPC (32-BIT AND 64-BIT)"
 <linuxppc-dev@lists.ozlabs.org>,
 "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
 Will Deacon <will.deacon@arm.com>,
 "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Mar 27, 2018 at 2:35 PM, Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:
> On Tue, 2018-03-27 at 10:46 -0400, Sinan Kaya wrote:
>>  combined buffers.
>>
>> Alex:
>> "Don't bother. I can tell you right now that for x86 you have to have a
>> wmb() before the writel().
>
> No, this isn't the semantics of writel. You shouldn't need it unless
> something changed and we need to revisit our complete understanding of
> *all* MMIO accessor semantics.

The issue seems to be that there have been two different ways of
dealing with this. There has historically been a number of different
drivers that have been carrying this wmb() workaround since something
like 2002. I get that the semantics for writel might have changed
since then, but those of us who already have the wmb() in our drivers
will be very wary of anyone wanting to go through and remove them
since writel is supposed to be "good enough". I would much rather err
on the side of caution here.

I view the wmb() + writel_relaxed() as more of a driver owning and
handling this itself. Besides in the Intel Ethernet driver case it is
better performance as our wmb() placement for us also provides a
secondary barrier so we don't need to add a separate smp_wmb() to deal
with a potential race we have with the Tx cleanup.

> At least for UC space, it has always been accepted (and enforced) that
> writel would not require any other barrier to order vs. previous stores
> to memory.

So the one thing I would question here is if this is UC vs UC or if
this extends to other types as well? So for x86 we could find
references to Write Combining being flushed by a write to UC memory,
however I have yet to find a clear explanation of what a write to UC
does to WB. My personal inclination would be to err on the side of
caution. I just don't want us going through and removing the wmb()
calls because it "should" work. I would want to know for certain it
will work.

- Alex
