Return-Path: <jonsmirl@gmail.com>
Received: from wa-out-1112.google.com (wa-out-1112.google.com [209.85.146.177])
	by ozlabs.org (Postfix) with ESMTP id 5DC3FDE19D
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Apr 2008 23:46:34 +1000 (EST)
Received: by wa-out-1112.google.com with SMTP id m28so4324059wag.13
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Apr 2008 06:46:34 -0700 (PDT)
Message-ID: <9e4733910804230646r2364ee0ct2c35549f6e6d1aaa@mail.gmail.com>
Date: Wed, 23 Apr 2008 09:46:33 -0400
From: "Jon Smirl" <jonsmirl@gmail.com>
To: "Jochen Friedrich" <jochen@scram.de>
Subject: Re: [PATCH] rtc-pcf8563: Add device ids table
In-Reply-To: <480F390A.90707@scram.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <200804171708.32847.laurentp@cse-semaphore.com>
	<200804221612.06745.laurentp@cse-semaphore.com>
	<20080423131657.71d6312f@hyperion.delvare>
	<200804231412.40038.laurentp@cse-semaphore.com>
	<20080423144756.3fc9b1bf@hyperion.delvare> <480F390A.90707@scram.de>
Cc: Alessandro Zummo <alessandro.zummo@towertech.it>,
	rtc-linux@googlegroups.com,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>, i2c@lm-sensors.org,
	Jean Delvare <khali@linux-fr.org>,
	Andrew Morton <akpm@linux-foundation.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 4/23/08, Jochen Friedrich <jochen@scram.de> wrote:
> Hi Jean,
>
>
>  > Jochen, I'm a bit confused by the dependencies that exist - or not -
>  > between these 7 patches you sent at once. I thought they had to be
>  > applied in sequence but it seems not? And some of them should
>  > apparently go through me i2c tree but others (e.g. [7/7]) not?
>
>
> [1/7] and [2/7] are forward ports of patches from you. I'm currently
>  just running a make allmodconfig compile to check if it really caught
>  all affected i2c drivers.
>
>  These are the patches we are talking about.
>
>  [3/7] is the OF helper stuff which translates between OF names and
>  i2c types. It does NOT translate OF names to module names, but relies
>  on [1/7] to do so. Without [1/7], [3/7] still applies, but module
>  auto loading won't work.
>
>  This has been applied to 2.6.26.
>
>
>  > I would appreciate if you could summarize quickly which patches depend
>  > on others in which way. If we can make smaller subsets of patches, that
>  > will be easier for me to review and push upstream on my limited time.
>
>
> [4/7] is the patch from Jon Smirl to convert i2c-mpc to OF. This relies
>  on [3/7] instead of Jons initial OF-autoloading patches you didn't like.
>  As there were no comments at all, I would however postpone this to 2.6.27.

This is why we chose to ignore mainline and do these changes in our
own tree. There is no certainty when or if these patches will ever go
in. This has also caused us to stop submitting code in other areas.
It's all intertwined and too much work to break up.


>  [5/7] is the cleanup patch (originating from you) which completely removes
>  old driver matching scheme. This should probably wait until 2.6.27, as well.
>  This relies on [1/7] and [2/7].
>
>  [6/7] and [7/7] are a new driver and depend on [3/7]. This can wait for 2.6.27,
>  as well (i would rather like to see those in -mm to get more testing, though).
>
>  Thanks,
>
> Jochen
>
> _______________________________________________
>  Linuxppc-dev mailing list
>  Linuxppc-dev@ozlabs.org
>  https://ozlabs.org/mailman/listinfo/linuxppc-dev
>


-- 
Jon Smirl
jonsmirl@gmail.com
