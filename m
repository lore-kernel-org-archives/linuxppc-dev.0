Return-Path: <linus971@gmail.com>
Received: from mail-it0-x22b.google.com (mail-it0-x22b.google.com
 [IPv6:2607:f8b0:4001:c0b::22b])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 409yJN2K3VzF28X
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Mar 2018 17:14:11 +1100 (AEDT)
Received: by mail-it0-x22b.google.com with SMTP id r19-v6so2274152itc.0
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Mar 2018 23:14:11 -0700 (PDT)
MIME-Version: 1.0
Sender: linus971@gmail.com
In-Reply-To: <bf77be28-051d-79c8-9b65-948c8a254d6d@codeaurora.org>
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
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 27 Mar 2018 20:14:07 -1000
Message-ID: <CA+55aFxULkhZGhg-tTBBxBBvXbL7QV7f6zvwW7U2wHFijqGEqw@mail.gmail.com>
Subject: Re: RFC on writel and writel_relaxed
To: Sinan Kaya <okaya@codeaurora.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Alexander Duyck <alexander.duyck@gmail.com>,
 Will Deacon <will.deacon@arm.com>, Arnd Bergmann <arnd@arndb.de>,
 Jason Gunthorpe <jgg@ziepe.ca>,
 David Laight <David.Laight@aculab.com>, Oliver <oohall@gmail.com>,
 "open list:LINUX FOR POWERPC (32-BIT AND 64-BIT)"
 <linuxppc-dev@lists.ozlabs.org>,
 "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
 Alexander Duyck <alexander.h.duyck@redhat.com>,
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

On Tue, Mar 27, 2018 at 5:24 PM, Sinan Kaya <okaya@codeaurora.org> wrote:
>
> Basically changing it to
>
> dma_buffer->foo = 1;                    /* WB */
> wmb()
> writel_relaxed(KICK, DMA_KICK_REGISTER);        /* UC */
> mmiowb()

Why?

Why not  just remove the wmb(), and keep the barrier in the writel()?

The above code makes no sense, and just looks stupid to me. It also
generates pointlessly bad code on x86, so it's bad there too.

               Linus
