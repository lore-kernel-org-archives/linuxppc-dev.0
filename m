Return-Path: <leonro@mellanox.com>
Received: from EUR04-VI1-obe.outbound.protection.outlook.com
 (mail-eopbgr80080.outbound.protection.outlook.com [40.107.8.80])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 424rfN3v6szDqSL
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  5 Sep 2018 14:42:33 +1000 (AEST)
Date: Wed, 5 Sep 2018 07:42:21 +0300
From: Leon Romanovsky <leonro@mellanox.com>
To: Nicholas Piggin <npiggin@gmail.com>
Cc: Jason Gunthorpe <jgg@mellanox.com>, Michael Ellerman <mpe@ellerman.id.au>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: Regression from patch 'tty: hvc: hvc_poll() break hv read loop'
Message-ID: <20180905044221.GB2977@mtr-leonro.mtl.com>
References: <20180904174808.GS335@mellanox.com>
 <20180905071529.3b7a09c4@roar.ozlabs.ibm.com>
 <20180904211635.GD335@mellanox.com>
 <20180905135156.7ac7727b@roar.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180905135156.7ac7727b@roar.ozlabs.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Sep 05, 2018 at 01:51:56PM +1000, Nicholas Piggin wrote:
> On Tue, 4 Sep 2018 15:16:35 -0600
> Jason Gunthorpe <jgg@mellanox.com> wrote:
>
> > On Wed, Sep 05, 2018 at 07:15:29AM +1000, Nicholas Piggin wrote:
> > > On Tue, 4 Sep 2018 11:48:08 -0600
> > > Jason Gunthorpe <jgg@mellanox.com> wrote:
> > >
> > > > Hi Nicholas,
> > > >
> > > > I am testing 4.19-rc2 and I see bad behavior with my qemu hvc0
> > > > console..
> > > >
> > > > Running interactive with qemu (qemu-2.11.2-1.fc28) on the console
> > > > providing hvc0, using options like:
> > > >
> > > >         -nographic
> > > >         -chardev stdio,id=stdio,mux=on,signal=off
> > > >         -mon chardev=stdio
> > > > 	-device isa-serial,chardev=stdio
> > > >         -device virtio-serial-pci
> > > > 	-device virtconsole,chardev=stdio
> > > >
> > > > I see the hvc0 console hang regularly, ie doing something like 'up
> > > > arrow' in bash causes the hvc0 console to hang. Prior kernels worked
> > > > OK.
> > > >
> > > > Any ideas? I'm not familiar with this code.. Thanks!
> > >
> > > Yes I have had another report, I'm working on a fix. Sorry it has taken
> > > a while and thank you for the report.
> >
> > Okay, let me know when you have a fix and I will be able to test it
> > for you!
>
> Can you try this?

It worked for me, so it will work for Jason too (we have same setup).

Tested-by: Leon Romanovsky <leonro@mellanox.com>

Thanks
