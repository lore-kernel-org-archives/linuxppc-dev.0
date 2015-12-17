Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 139E31A127F
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Dec 2015 22:57:35 +1100 (AEDT)
In-Reply-To: <1450163354-16894-1-git-send-email-dja@axtens.net>
To: Daniel Axtens <dja@axtens.net>, linuxppc-dev@ozlabs.org
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: Alessandro Zummo <a.zummo@towertech.it>, rtc-linux@googlegroups.com,
 Alexandre Belloni <alexandre.belloni@free-electrons.com>,
 Andrey Ryabinin <aryabinin@virtuozzo.com>, akpm@linux-foundation.org,
 Daniel Axtens <dja@axtens.net>
Subject: Re: powerpc: Remove broken GregorianDay()
Message-Id: <20151217115734.A5AAB14030D@ozlabs.org>
Date: Thu, 17 Dec 2015 22:57:34 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2015-15-12 at 07:09:14 UTC, Daniel Axtens wrote:
> GregorianDay() is supposed to calculate the day of the week
> (tm->tm_wday) for a given day/month/year. In that calcuation it
> indexed into an array called MonthOffset using tm->tm_mon-1. However
> tm_mon is zero-based, not one-based, so this is off-by-one. It also
> means that every January, GregoiranDay() will access element -1 of
> the MonthOffset array.
> 
> It also doesn't appear to be a correct algorithm either: see in
> contrast kernel/time/timeconv.c's time_to_tm function.
> 
> It's been broken forever, which suggests no-one in userland uses
> this. It looks like no-one in the kernel uses tm->tm_wday either
> (see e.g. drivers/rtc/rtc-ds1305.c:319).
> 
> tm->tm_wday is conventionally set to -1 when not available in
> hardware so we can simply set it to -1 and drop the function.
> (There are over a dozen other drivers in drivers/rtc that do
> this.)
> 
> Found using UBSAN.
> 
> Cc: Andrey Ryabinin <aryabinin@virtuozzo.com>
> Cc: Andrew Morton <akpm@linux-foundation.org> # as an example of what UBSan finds.
> Cc: Alessandro Zummo <a.zummo@towertech.it>
> Cc: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> Cc: rtc-linux@googlegroups.com
> Signed-off-by: Daniel Axtens <dja@axtens.net>
> Acked-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/00b912b0c88e690b1662067497

cheers
