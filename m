Return-Path: <davem@davemloft.net>
Date: Tue, 22 Jul 2008 16:07:18 -0700 (PDT)
Message-Id: <20080722.160718.122532549.davem@davemloft.net>
To: jonsmirl@gmail.com
Subject: Re: netif_schedule and mpc5200_fec
From: David Miller <davem@davemloft.net>
In-Reply-To: <9e4733910807221554j451019a0sa711541e97fbf0aa@mail.gmail.com>
References: <9e4733910807221403g512f6e37s6722c7950f881224@mail.gmail.com>
	<20080722.154201.234654750.davem@davemloft.net>
	<9e4733910807221554j451019a0sa711541e97fbf0aa@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: davem@redhat.com, Linuxppc-dev@ozlabs.org, netdev@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: "Jon Smirl" <jonsmirl@gmail.com>
Date: Tue, 22 Jul 2008 18:54:18 -0400

> On 7/22/08, David Miller <davem@davemloft.net> wrote:
> > From: "Jon Smirl" <jonsmirl@gmail.com>
> >  Date: Tue, 22 Jul 2008 17:03:32 -0400
> >
> >
> > > On 7/22/08, Jon Smirl <jonsmirl@gmail.com> wrote:
> >  > > I just updated to linus/master and mpc5200_fec won't boot.
> >  >
> >  > It does boot, but this badness looks like it is coming from this
> >  > patch. I don't know enough about networking to debug it.
> >
> >
> > I just applied the following patch from Anton Vorontsov which
> >  will fix this.
> 
> I applied this piece and still have the same error.

There are no calls to functions in mpc52xx_fec_adjust_link that
can lead to __netif_schedule() any more.

Therefore I can't see how your backtrace is even possible.

Please double check that you've really applied the patch
and that mpc52xx_fec_adjust_link lacks any calls to
netif_*_queue() and *netif_schedule().

Thanks.
