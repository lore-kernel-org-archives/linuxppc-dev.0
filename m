Return-Path: <david-b@pacbell.net>
Received: from smtp115.sbc.mail.sp1.yahoo.com (smtp115.sbc.mail.sp1.yahoo.com
	[69.147.64.88]) by ozlabs.org (Postfix) with SMTP id 687C4DE291
	for <linuxppc-dev@ozlabs.org>; Sat, 19 Apr 2008 15:55:53 +1000 (EST)
From: David Brownell <david-b@pacbell.net>
To: Anton Vorontsov <avorontsov@ru.mvista.com>,
	Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH 4/5] [POWERPC] QE: implement support for the GPIO LIB API
Date: Fri, 18 Apr 2008 22:49:10 -0700
References: <20080418190632.GA32204@polina.dev.rtsoft.ru>
	<20080418190959.GD4407@polina.dev.rtsoft.ru>
In-Reply-To: <20080418190959.GD4407@polina.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200804182249.11580.david-b@pacbell.net>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Friday 18 April 2008, Anton Vorontsov wrote:
> On Thu, Apr 17, 2008 at 09:21:40PM -0500, Kumar Gala wrote:
> > On Apr 17, 2008, at 5:41 PM, Anton Vorontsov wrote:
> >> 
> >> No problem. Would you prefer this to go under drivers/gpio/ ?
> >
> > Yes that would be better.  We actively worked on pull drivers out of  
> > arch/ppc back in the day.

I'm not sure I see the problem here.  This is precisely
the kind of *non-driver* code that normally (i.e. for
all other Linux platforms I've looked at) *belongs* in
the arch code ... what's the objection to doing it the
same way other platforms do?

And for that matter, why make it optional, via Kconfig,
instead of always configuring it in, along with the GPIO
interrupt support?  A quick glance at one of the MPC83xx
chips suggested that QE port IRQ capabilities would be
very chip specific, so I'd expect that GPIO IRQ support
wouldn't naturally move out of the arch tree.

- Dave


> Hi David,
> 
> Do we need your Ack to go this through powerpc tree, and if so, could
> you provide one?
> 
> Thanks.
> 
>  Documentation/powerpc/booting-without-of.txt |   34 ++++---
>  arch/powerpc/platforms/Kconfig               |    2 +
>  drivers/gpio/Kconfig                         |    9 ++
>  drivers/gpio/Makefile                        |    1 +
>  drivers/gpio/qe.c                            |  147 ++++++++++++++++++++++++++
>  5 files changed, 180 insertions(+), 13 deletions(-)
>  create mode 100644 drivers/gpio/qe.c
