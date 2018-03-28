Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40BC4F4wFxzF2DM
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Mar 2018 02:49:33 +1100 (AEDT)
Message-ID: <1522249996.21446.25.camel@kernel.crashing.org>
Subject: Re: RFC on writel and writel_relaxed
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: okaya@codeaurora.org, Linus Torvalds <torvalds@linux-foundation.org>
Cc: Alexander Duyck <alexander.duyck@gmail.com>, Will Deacon
 <will.deacon@arm.com>, Arnd Bergmann <arnd@arndb.de>, Jason Gunthorpe
 <jgg@ziepe.ca>, David Laight <David.Laight@aculab.com>, Oliver
 <oohall@gmail.com>, "open list:LINUX FOR POWERPC (32-BIT AND 64-BIT)"
 <linuxppc-dev@lists.ozlabs.org>, linux-rdma@vger.kernel.org, Alexander
 Duyck <alexander.h.duyck@redhat.com>, "Paul E. McKenney"
 <paulmck@linux.vnet.ibm.com>, netdev@vger.kernel.org, linus971@gmail.com
Date: Thu, 29 Mar 2018 02:13:16 +1100
In-Reply-To: <b02cc752d90c5e5ae2cc8cc4f67429a7@codeaurora.org>
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
 <bf77be28-051d-79c8-9b65-948c8a254d6d@codeaurora.org>
 <CA+55aFxULkhZGhg-tTBBxBBvXbL7QV7f6zvwW7U2wHFijqGEqw@mail.gmail.com>
 <b02cc752d90c5e5ae2cc8cc4f67429a7@codeaurora.org>
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

On Wed, 2018-03-28 at 07:41 -0400, okaya@codeaurora.org wrote:
> Yes, we want to get there indeed. It is because of some arch not 
> implementing writel properly. Maintainers want to play safe.
> 
> That is why I asked if IA64 and other well known archs follow the 
> strongly ordered rule at this moment like PPC and ARM.
> 
> Or should we go and inform every arch about this before yanking wmb()?
> 
> Maintainers are afraid of introducing a regression.

Let's fix all archs, it's way easier than fixing all drivers. Half of
the archs are unused or dead anyway.

> > 
> > The above code makes no sense, and just looks stupid to me. It also
> > generates pointlessly bad code on x86, so it's bad there too.
> > 
> >                 Linus
