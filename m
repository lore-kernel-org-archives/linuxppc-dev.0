Return-Path: <scottwood@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 06A27DE350
	for <linuxppc-dev@ozlabs.org>; Wed, 21 May 2008 01:41:07 +1000 (EST)
Message-ID: <4832F139.1020502@freescale.com>
Date: Tue, 20 May 2008 10:41:45 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Rune Torgersen <runet@innovsys.com>
Subject: Re: Oops in fs_enet driver with preempt-rt
References: <DCEAAC0833DD314AB0B58112AD99B93B046E728C@ismail.innsys.innovsys.com>
	<DCEAAC0833DD314AB0B58112AD99B93B046E72C3@ismail.innsys.innovsys.com>
In-Reply-To: <DCEAAC0833DD314AB0B58112AD99B93B046E72C3@ismail.innsys.innovsys.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Rune Torgersen wrote:
> 0xc0196d84 is in fs_enet_interrupt
> (drivers/net/fs_enet/fs_enet-main.c:473).
> 468                     if (fpi->use_napi)
> 469                             int_clr_events &= ~fep->ev_napi_rx;
> 470
> 471                     (*fep->ops->clear_int_events)(dev,
> int_clr_events);
> 472
> 473                     if (int_events & fep->ev_err)
> 474                             (*fep->ops->ev_error)(dev, int_events);
> 475
> 476                     if (int_events & fep->ev_rx) {
> 477                             if (!fpi->use_napi)
> (gdb)     

Do you have shared interrupt debugging turned on?  That breaks this 
driver, and a patch to remove the shared flag was nacked in favor of 
actually fixing the driver, which I haven't gotten around to.

-Scott
