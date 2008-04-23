Return-Path: <jochen@scram.de>
Received: from mail.scram.de (mail0.scram.de [78.47.204.202])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail.scram.de", Issuer "scram e.V. CA" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id C188ADE339
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Apr 2008 23:26:53 +1000 (EST)
Message-ID: <480F390A.90707@scram.de>
Date: Wed, 23 Apr 2008 15:26:34 +0200
From: Jochen Friedrich <jochen@scram.de>
MIME-Version: 1.0
To: Jean Delvare <khali@linux-fr.org>
Subject: Re: [PATCH] rtc-pcf8563: Add device ids table
References: <200804171708.32847.laurentp@cse-semaphore.com>	<200804221612.06745.laurentp@cse-semaphore.com>	<20080423131657.71d6312f@hyperion.delvare>	<200804231412.40038.laurentp@cse-semaphore.com>
	<20080423144756.3fc9b1bf@hyperion.delvare>
In-Reply-To: <20080423144756.3fc9b1bf@hyperion.delvare>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Alessandro Zummo <alessandro.zummo@towertech.it>,
	rtc-linux@googlegroups.com,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>, i2c@lm-sensors.org,
	Andrew Morton <akpm@linux-foundation.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Jean,

> Jochen, I'm a bit confused by the dependencies that exist - or not -
> between these 7 patches you sent at once. I thought they had to be
> applied in sequence but it seems not? And some of them should
> apparently go through me i2c tree but others (e.g. [7/7]) not?

[1/7] and [2/7] are forward ports of patches from you. I'm currently
just running a make allmodconfig compile to check if it really caught
all affected i2c drivers.

These are the patches we are talking about.

[3/7] is the OF helper stuff which translates between OF names and
i2c types. It does NOT translate OF names to module names, but relies
on [1/7] to do so. Without [1/7], [3/7] still applies, but module
auto loading won't work.

This has been applied to 2.6.26.

> I would appreciate if you could summarize quickly which patches depend
> on others in which way. If we can make smaller subsets of patches, that
> will be easier for me to review and push upstream on my limited time.

[4/7] is the patch from Jon Smirl to convert i2c-mpc to OF. This relies
on [3/7] instead of Jons initial OF-autoloading patches you didn't like.
As there were no comments at all, I would however postpone this to 2.6.27.

[5/7] is the cleanup patch (originating from you) which completely removes
old driver matching scheme. This should probably wait until 2.6.27, as well.
This relies on [1/7] and [2/7].

[6/7] and [7/7] are a new driver and depend on [3/7]. This can wait for 2.6.27,
as well (i would rather like to see those in -mm to get more testing, though).

Thanks,
Jochen
