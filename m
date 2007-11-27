Return-Path: <khali@linux-fr.org>
Received: from kraid.nerim.net (smtp-102-tuesday.nerim.net [62.4.16.102])
	by ozlabs.org (Postfix) with ESMTP id C9999DDD0A
	for <linuxppc-dev@ozlabs.org>; Tue, 27 Nov 2007 21:19:37 +1100 (EST)
Date: Tue, 27 Nov 2007 11:19:34 +0100
From: Jean Delvare <khali@linux-fr.org>
To: linuxppc-dev@ozlabs.org, Kumar Gala <galak@kernel.crashing.org>, Paul
	Mackerras <paulus@samba.org>
Subject: Re: [2.6 patch] the scheduled I2C RTC driver removal
Message-ID: <20071127111934.12c76cdd@hyperion.delvare>
In-Reply-To: <20071102231243.61c39d23@hyperion.delvare>
References: <20071031230357.GW7227@stusta.de>
	<20071102231243.61c39d23@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Adrian Bunk <bunk@kernel.org>, linux-kernel@vger.kernel.org,
	rtc-linux@googlegroups.com, i2c@lm-sensors.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 2 Nov 2007 23:12:43 +0100, Jean Delvare wrote:
> Hi Adrian,
> 
> On Thu, 1 Nov 2007 00:03:58 +0100, Adrian Bunk wrote:
> > This patch contains the scheduled removal of legacy I2C RTC drivers with 
> > replacement drivers.
> > (...)
> >  Documentation/feature-removal-schedule.txt |    7 
> >  arch/powerpc/platforms/83xx/mpc832x_mds.c  |   24 -
> >  arch/powerpc/platforms/83xx/mpc834x_mds.c  |   24 -
> >  arch/powerpc/platforms/83xx/mpc836x_mds.c  |   24 -
> >  arch/ppc/platforms/83xx/mpc834x_sys.c      |   20 -
> >  arch/ppc/platforms/85xx/tqm85xx.c          |   21 -
> >  arch/ppc/platforms/katana.c                |   21 -
> >  drivers/i2c/chips/Kconfig                  |   38 -
> >  drivers/i2c/chips/Makefile                 |    3 
> >  drivers/i2c/chips/ds1337.c                 |  410 --------------------
> >  drivers/i2c/chips/ds1374.c                 |  267 -------------
> >  drivers/i2c/chips/m41t00.c                 |  413 ---------------------
> >  include/linux/m41t00.h                     |   50 --
> >  13 files changed, 1322 deletions(-)
> 
> Obviously we're not yet ready to remove the drivers, as some platforms
> still use them! The remaining platforms need to be updated to use the
> new RTC drivers first. The mapping is as follows:
> 
> chip       | old driver | new driver   |
> -----------+------------+--------------+
> DS1337     | ds1337     | rtc-ds1307   |
> DS1339     | ds1337     | rtc-ds1307   |
> DS1374     | ds1374     | rtc-ds1374   |
> M41T00     | m41t00     | rtc-ds1307   |
> M41T81     | m41t00     | rtc-m41t80   |
> M41ST85    | m41t00     | rtc-m41t80   |
> 
> So, PPC people, please update your platform code to make use of the new
> drivers now, and let me know when you're done. As soon as all platforms
> are converted, I'll apply Adrian's patch.

As of 2.6.24-rc3-git2, I see that the references to the obsolete
drivers have been removed from arch/powerpc/*. Great, I'll update
Adrian's patch. This leaves only 3 platforms under arch/ppc (83xx, 85xx
and katana) that still need updating. Kumar, Paul, what's the status?

Thanks,
-- 
Jean Delvare
