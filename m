Return-Path: <davem@davemloft.net>
Received: from sunset.davemloft.net
	(74-93-104-97-Washington.hfc.comcastbusiness.net [74.93.104.97])
	by ozlabs.org (Postfix) with ESMTP id DD896B7B94
	for <linuxppc-dev@ozlabs.org>; Tue, 13 Oct 2009 17:57:32 +1100 (EST)
Date: Mon, 12 Oct 2009 23:57:47 -0700 (PDT)
Message-Id: <20091012.235747.195783342.davem@davemloft.net>
To: avorontsov@ru.mvista.com
Subject: Re: [PATCH 0/8] gianfar: Add support for hibernation
From: David Miller <davem@davemloft.net>
In-Reply-To: <20091012160000.GA32406@oksana.dev.rtsoft.ru>
References: <20091012160000.GA32406@oksana.dev.rtsoft.ru>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: scottwood@freescale.com, linuxppc-dev@ozlabs.org, netdev@vger.kernel.org,
	afleming@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Anton Vorontsov <avorontsov@ru.mvista.com>
Date: Mon, 12 Oct 2009 20:00:00 +0400

> Here are few patches that add support for hibernation for gianfar
> driver.
> 
> Technically, we could just do gfar_close() and then gfar_enet_open()
> sequence to restore gianfar functionality after hibernation, but
> close/open does so many unneeded things (e.g. BDs buffers freeing and
> allocation, IRQ freeing and requesting), that I felt it would be much
> better to cleanup and refactor some code to make the hibernation [and
> not only hibernation] code a little bit prettier.

I applied all of this, it's a really nice patch set.  If there are any
problems we can deal with it using follow-on fixups.

I noticed something, in patch #3 where you remove the spurious wrap
bit setting in startup_gfar().  It looks like that was not only
spurious but it was doing it wrong too.

It's writing garbage into the status word, because it's not using the
BD_LFLAG() macro to shift the value up 16 bits.
