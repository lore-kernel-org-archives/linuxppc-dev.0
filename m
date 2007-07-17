Return-Path: <g.liakhovetski@gmx.de>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by ozlabs.org (Postfix) with SMTP id CE8C0DDE30
	for <linuxppc-dev@ozlabs.org>; Wed, 18 Jul 2007 05:58:26 +1000 (EST)
Date: Tue, 17 Jul 2007 21:58:22 +0200 (CEST)
From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
To: Vitaly Bordug <vitb@kernel.crashing.org>
Subject: Re: [PATCH] POWERPC: Added RTC support for mpc8313RDB and utilize
	"clock-frequency"
In-Reply-To: <20070717214824.04db9e88@vitb.ru.mvista.com>
Message-ID: <Pine.LNX.4.60.0707172154190.3535@poirot.grange>
References: <20070717004913.21682.50282.stgit@localhost.localdomain>
	<20070717163645.GB7347@ld0162-tx32.am.freescale.net>
	<20070717214824.04db9e88@vitb.ru.mvista.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 17 Jul 2007, Vitaly Bordug wrote:

> > Please don't do this; drivers/i2c/chips/ds1337.c is deprecated.  You
> > should be using the RTC-class driver in drivers/rtc/rtc-ds1307.c, which
> > has a non-device-specific API that can be used.
> > 
> > The ppc_md RTC functions should really just go away, though -- setting
> > the clock on bootup can be done by generic code, and periodically
> > updating the RTC when using NTP can be done from userspace.
> 
> If those ppc_md hookups would be declared deprecated, there's no much sense in the upper,
> apparently. But I am not sure they will be... I'm inclined to let this patch floating since
> interacting with rtc class from within BSP code just does not worth it.

Exactly! Don't interact with it. Just leave it alone. No need to re-write 
[sg]et_rtc_time, bother with setting system time on bootup... Just let the 
rtc driver and framework do it for you.

Thanks
Guennadi
---
Guennadi Liakhovetski
