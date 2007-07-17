Return-Path: <scottwood@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 1523BDE094
	for <linuxppc-dev@ozlabs.org>; Wed, 18 Jul 2007 03:53:18 +1000 (EST)
Message-ID: <469D0206.3000804@freescale.com>
Date: Tue, 17 Jul 2007 12:53:10 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Vitaly Bordug <vitb@kernel.crashing.org>
Subject: Re: [PATCH] POWERPC: Added RTC support for mpc8313RDB and utilize
	"clock-frequency"
References: <20070717004913.21682.50282.stgit@localhost.localdomain>	<20070717163645.GB7347@ld0162-tx32.am.freescale.net>
	<20070717214824.04db9e88@vitb.ru.mvista.com>
In-Reply-To: <20070717214824.04db9e88@vitb.ru.mvista.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Vitaly Bordug wrote:
> On Tue, 17 Jul 2007 11:36:45 -0500
> Scott Wood <scottwood@freescale.com> wrote:
>>We should be removing this from board files that have it, not adding it
>>to ones that don't.
> 
> Yet many boards still have this stuff (like pretty recent 86xx) - should
> we at least add some comments or clean that up?

See above. :-)

AFAICT, it's just copied from board to board without thought.  It should 
be removed.

>>The ppc_md RTC functions should really just go away, though -- setting
>>the clock on bootup can be done by generic code, and periodically
>>updating the RTC when using NTP can be done from userspace.
> 
> If those ppc_md hookups would be declared deprecated, there's no much sense in the upper,
> apparently. But I am not sure they will be... I'm inclined to let this patch floating since
> interacting with rtc class from within BSP code just does not worth it.

I'm not sure they will either; I just wish they would be. :-)

In the meantime, some sort of workqueue-based hookup to the RTC class 
API should be used.  I believe there have been patches along those lines 
posted in the past.

-Scott
