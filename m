Return-Path: <arndbergmann@gmail.com>
Received: from mail-it0-x242.google.com (mail-it0-x242.google.com
 [IPv6:2607:f8b0:4001:c0b::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 409zZB3WJ3zF2Bp
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Mar 2018 18:11:13 +1100 (AEDT)
Received: by mail-it0-x242.google.com with SMTP id z7-v6so18498109iti.1
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Mar 2018 00:11:13 -0700 (PDT)
MIME-Version: 1.0
Sender: arndbergmann@gmail.com
In-Reply-To: <1522220165.7364.110.camel@kernel.crashing.org>
References: <1521854626.16434.359.camel@kernel.crashing.org>
 <58ce5b83f40f4775bec1be8db66adb0d@AcuMS.aculab.com>
 <20180326165425.GA15554@ziepe.ca>
 <CAK8P3a1zeMyj+Z-y4ER4moY6Zip9EWNOinf+VnboGOrgiwbBZA@mail.gmail.com>
 <20180326202545.GB15554@ziepe.ca>
 <CAK8P3a3fc43ZcW626hmsd3DVcLw7hGkdUMxp7s4Rn3mdkziwMQ@mail.gmail.com>
 <20180326210951.GD15554@ziepe.ca>
 <CAK8P3a2UU1xAM0NLo7Q4-Xgo1SzY3De1uqpFudr+2ZW7nHEPmA@mail.gmail.com>
 <1522101616.7364.13.camel@kernel.crashing.org>
 <1e077f6a-90b6-cce9-6f0f-a8c003fec850@codeaurora.org>
 <20180327151029.GB17494@arm.com>
 <CAKgT0Uem6HT-Z=HBnSVcC4rnDL0yFyXEbr+FN3YYkJ=ExZpUPQ@mail.gmail.com>
 <1522186396.7364.61.camel@kernel.crashing.org>
 <CA+55aFw2R4pirO0m+jtj4F8AF2-tVi3guEaWOA-EBqNyFmh29w@mail.gmail.com>
 <1522198981.7364.81.camel@kernel.crashing.org>
 <CA+55aFyTeuXPmC5-1JGh2ow-rf5wMA6Vcv0aeS_q0_EnptSK9Q@mail.gmail.com>
 <1522211620.7364.94.camel@kernel.crashing.org>
 <CA+55aFw24R3YAujir59GdG+sBBQOA9WyXySEN3AcEYK99ZHuwQ@mail.gmail.com>
 <1522219376.7364.109.camel@kernel.crashing.org>
 <CA+55aFyaZ=WEXFg4KZ0yCWaR=8Dm_FPK-xcA0EYi3fEzm+KZkA@mail.gmail.com>
 <1522220165.7364.110.camel@kernel.crashing.org>
From: Arnd Bergmann <arnd@arndb.de>
Date: Wed, 28 Mar 2018 09:11:10 +0200
Message-ID: <CAK8P3a1QTjCtJMAv1RSN5ReiOShZ_ygkCXY484OJUvn6r+1mbg@mail.gmail.com>
Subject: Re: RFC on writel and writel_relaxed
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
 Alexander Duyck <alexander.duyck@gmail.com>, Will Deacon <will.deacon@arm.com>,
 Sinan Kaya <okaya@codeaurora.org>, Jason Gunthorpe <jgg@ziepe.ca>,
 David Laight <David.Laight@aculab.com>, Oliver <oohall@gmail.com>,
 "open list:LINUX FOR POWERPC (32-BIT AND 64-BIT)"
 <linuxppc-dev@lists.ozlabs.org>,
 "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
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

On Wed, Mar 28, 2018 at 8:56 AM, Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:
> On Wed, 2018-03-28 at 06:53 +0000, Linus Torvalds wrote:
>> On Tue, Mar 27, 2018, 20:43 Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
>> That's why in/out were *so* slow, and why nobody uses them any more
>> (well, the address size limitations and the lack of any remapping of
>> the address obviously also are a reason).
>
> All true indeed, though a lot of other archs never quite made them
> fully synchronous, which was another can of worms ... oh well.

Many architectures have no way of providing PCI compliant semantics
for outb, as their instruction set and/or bus interconnect lacks a
method of waiting for completion of an outb.

In practice, it doesn't seem to matter for any of the devices one would
encounter these days: very few use I/O space, and those that do don't
actually rely on the strict ordering. Some architectures (in particular
s390, but I remember seeing the same thing elsewhere) explicitly
disallow I/O space access on PCI because of this. On ARM, the typical
PCI implementations have other problems that are worse than this
one, so most drivers are fine with the almost-working semantics.

        Arnd
