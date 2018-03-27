Return-Path: <arndbergmann@gmail.com>
Received: from mail-qt0-x244.google.com (mail-qt0-x244.google.com
 [IPv6:2607:f8b0:400d:c0d::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 409R1Q2dBBzF22T
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Mar 2018 20:44:25 +1100 (AEDT)
Received: by mail-qt0-x244.google.com with SMTP id f8so23066573qtg.12
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Mar 2018 02:44:25 -0700 (PDT)
MIME-Version: 1.0
Sender: arndbergmann@gmail.com
In-Reply-To: <1522141019.7364.43.camel@kernel.crashing.org>
References: <1521854626.16434.359.camel@kernel.crashing.org>
 <58ce5b83f40f4775bec1be8db66adb0d@AcuMS.aculab.com>
 <20180326165425.GA15554@ziepe.ca>
 <CAK8P3a1zeMyj+Z-y4ER4moY6Zip9EWNOinf+VnboGOrgiwbBZA@mail.gmail.com>
 <20180326202545.GB15554@ziepe.ca>
 <CAK8P3a3fc43ZcW626hmsd3DVcLw7hGkdUMxp7s4Rn3mdkziwMQ@mail.gmail.com>
 <20180326210951.GD15554@ziepe.ca>
 <CAK8P3a2UU1xAM0NLo7Q4-Xgo1SzY3De1uqpFudr+2ZW7nHEPmA@mail.gmail.com>
 <ebb36fd4-62e2-394a-219f-686c45a6dc75@codeaurora.org>
 <1522101717.7364.14.camel@kernel.crashing.org>
 <20180326222756.GJ15554@ziepe.ca>
 <CAK8P3a3a+zUNLjqw9CL5rYkXhJ-GMVTVnBU2XUu2f3njZfrqKw@mail.gmail.com>
 <1522141019.7364.43.camel@kernel.crashing.org>
From: Arnd Bergmann <arnd@arndb.de>
Date: Tue, 27 Mar 2018 11:44:22 +0200
Message-ID: <CAK8P3a0gCYjw78snni_1Jkk5uA5a-j0x-XZDrN=RaZfXctOSoA@mail.gmail.com>
Subject: Re: RFC on writel and writel_relaxed
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, Sinan Kaya <okaya@codeaurora.org>,
 David Laight <David.Laight@aculab.com>, Oliver <oohall@gmail.com>,
 "open list:LINUX FOR POWERPC (32-BIT AND 64-BIT)"
 <linuxppc-dev@lists.ozlabs.org>,
 "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
 Alexander Duyck <alexander.h.duyck@redhat.com>,
 Will Deacon <will.deacon@arm.com>,
 "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Mar 27, 2018 at 10:56 AM, Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:
> On Tue, 2018-03-27 at 09:56 +0200, Arnd Bergmann wrote:
>> On Tue, Mar 27, 2018 at 12:27 AM, Jason Gunthorpe <jgg@ziepe.ca> wrote:
>>
>> I'm pretty sure I've never seen
>> any bug reports pointing to a missing wmb() between memory
>> and MMIO write accesses, but if you remember seeing them in the
>> list, maybe you can look again for some evidence of something going
>> wrong on x86 without it?
>
> The interesting thing is that we do seem to have a whole LOT of these
> spurrious wmb before writel all over the tree, I suspect because of
> that incorrect recommendation in memory-barriers.txt.
>
> We should fix that.

Maybe the problem is just that it's so counter-intuitive that we don't
need that barrier in Linux, when the hardware does need one on some
architectures.

How about we define a barrier type instruction specifically for this
purpose, something like wmb_before_mmio() and have all architectures
define that to an empty macro?

That way, having correct code using wmb_before_mmio() will not
trigger an incorrect review comment that leads to extra wmb(). ;-)

       Arnd
