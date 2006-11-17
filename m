Return-Path: <scottwood@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102]) by ozlabs.org (Postfix) with ESMTP id D73D267B77
	for <linuxppc-dev@ozlabs.org>; Sat, 18 Nov 2006 04:44:26 +1100 (EST)
Message-ID: <455DF4F5.9030201@freescale.com>
Date: Fri, 17 Nov 2006 11:44:21 -0600
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: RTC , ds1307 I2C driver and NTP does not work.
References: <1163781539.21518.27.camel@gentoo-jocke.transmode.se>
	<A4DE4C29-34A0-4C57-BA16-659F89DD0D6D@kernel.crashing.org>
In-Reply-To: <A4DE4C29-34A0-4C57-BA16-659F89DD0D6D@kernel.crashing.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Kumar Gala wrote:
> On Nov 17, 2006, at 10:38 AM, Joakim Tjernlund wrote:
> 
> 
>>I get this when I activathte NTP and ntp "sync" the time the I2C HW  
>>clock.
> 
> 
> You may be better off posting this to lkml and copy the i2c list (and  
> rtc if one exists).  Since its more a driver issue than anything  
> really ppc specific.  Clearly we are doing schedules() in mpc_xfer()  
> and maybe we shouldn't be.

It's interrupt unsafe before that; rtc_set_time calls 
mutex_lock_interruptible.  If the RTC must be set from an interrupt, it 
should be via a workqueue.

-Scott
