Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id C7DBDDDEF1
	for <linuxppc-dev@ozlabs.org>; Tue,  7 Oct 2008 20:26:08 +1100 (EST)
Date: Tue, 7 Oct 2008 13:26:05 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] pata_of_platform: fix no irq handling
Message-ID: <20081007092605.GA28907@oksana.dev.rtsoft.ru>
References: <20081006172653.GA26427@oksana.dev.rtsoft.ru>
	<48EA77EF.6080502@genesi-usa.com>
	<20081006213209.GA13072@oksana.dev.rtsoft.ru>
	<48EABBD3.1010401@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=windows-1251
In-Reply-To: <48EABBD3.1010401@kernel.org>
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org,
	linux-ide@vger.kernel.org, Li Yang <leoli@freescale.com>,
	Jeff Garzik <jgarzik@pobox.com>, Wang Jian <lark@linux.net.cn>
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Oct 07, 2008 at 10:30:59AM +0900, Tejun Heo wrote:
> Anton Vorontsov wrote:
> > On Mon, Oct 06, 2008 at 03:41:19PM -0500, Matt Sealey wrote:
> >> There is a simple problem with the patch which is that an "IRQ 0" can and does
> >> actually exist on a bunch of platforms, at least to the best of my knowledge.
> >>
> >> Checking for -1 (which means for definite, no irq at all, because it is
> >> totally unambiguous, as a -1 IRQ numbering is "impossible") is more correct.
> > 
> > This was discussed years ago.
> > 
> > http://lkml.org/lkml/2005/11/22/159
> > http://lkml.org/lkml/2005/11/22/227
> > 
> 
> Would this break any existing platforms?

Nope.

The driver is only available for PPC platforms.

As time goes by one can change `depend on PPC_OF' to just `depends on
OF', so that the driver will be also available for SPARC. And still
it will work, because SPARC also understands VIRQ0 as invalid VIRQ.


Thanks,

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
