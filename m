Return-Path: <David.Laight@ACULAB.COM>
Received: from smtp-out4.electric.net (smtp-out4.electric.net
 [192.162.216.187])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 409Wp51sYRzF2Ch
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Mar 2018 00:19:55 +1100 (AEDT)
From: David Laight <David.Laight@ACULAB.COM>
To: 'Will Deacon' <will.deacon@arm.com>, Arnd Bergmann <arnd@arndb.de>
CC: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Jason Gunthorpe
 <jgg@ziepe.ca>, Sinan Kaya <okaya@codeaurora.org>, Oliver <oohall@gmail.com>,
 "open list:LINUX FOR POWERPC (32-BIT AND 64-BIT)"
 <linuxppc-dev@lists.ozlabs.org>, "linux-rdma@vger.kernel.org"
 <linux-rdma@vger.kernel.org>, "Paul E. McKenney"
 <paulmck@linux.vnet.ibm.com>, Peter Zijlstra <peterz@infradead.org>, "Ingo
 Molnar" <mingo@redhat.com>, Jonathan Corbet <corbet@lwn.net>
Subject: RE: RFC on writel and writel_relaxed
Date: Tue, 27 Mar 2018 13:20:44 +0000
Message-ID: <6179a46115f54162b350fa54505b033d@AcuMS.aculab.com>
References: <CAK8P3a2UU1xAM0NLo7Q4-Xgo1SzY3De1uqpFudr+2ZW7nHEPmA@mail.gmail.com>
 <ebb36fd4-62e2-394a-219f-686c45a6dc75@codeaurora.org>
 <1522101717.7364.14.camel@kernel.crashing.org>
 <20180326222756.GJ15554@ziepe.ca>
 <CAK8P3a3a+zUNLjqw9CL5rYkXhJ-GMVTVnBU2XUu2f3njZfrqKw@mail.gmail.com>
 <1522141019.7364.43.camel@kernel.crashing.org>
 <20180327095745.GB29373@arm.com>
 <CAK8P3a0s+kP5=qEqTqAHGwB7j9ydaXD+oQJdLrFz=8swuWaDBg@mail.gmail.com>
 <20180327100944.GD29373@arm.com>
 <CAK8P3a0Xep0-EpGS9jnjUf1iJhRxH1WRztGQrvkdrLVaxBPT1w@mail.gmail.com>
 <20180327110258.GF2464@arm.com>
In-Reply-To: <20180327110258.GF2464@arm.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> Fair enough. I'd rather people used _relaxed by default, but I have to ad=
mit
> that it will probably just result in them getting things wrong...

Certainly requiring the driver writes use explicit barriers should make
them understand when and why they are needed - and then put in the correct =
ones.

The problem I've had is that I have a good idea which barriers are needed
but find that readl/writel seem to contain a lot of extra ones.
Maybe the are required in some places, but the extra synchronising
instructions could easily have measureable performance effects on
hot paths.

Drivers are likely to contain sequences like:
	read_io
	if (...) return
	write_mem
	...
	write_mem
	barrier
	write_mem
	barrier
	write_io
for things like ring updates.
Where the 'mem' might actually be in io space.
In such sequences not all the synchronising instructions are needed.
I'm not at all sure it is easy to get the right set.

	David
