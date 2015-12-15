Return-Path: <alexandre.belloni@free-electrons.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 1C6351A0271
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Dec 2015 20:01:58 +1100 (AEDT)
Received: from mail.free-electrons.com (down.free-electrons.com
 [37.187.137.238]) by ozlabs.org (Postfix) with ESMTP id A969A1402ED
 for <linuxppc-dev@ozlabs.org>; Tue, 15 Dec 2015 20:01:57 +1100 (AEDT)
Date: Tue, 15 Dec 2015 09:53:32 +0100
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Daniel Axtens <dja@axtens.net>
Cc: linuxppc-dev@ozlabs.org, mpe@ellerman.id.au, akpm@linux-foundation.org,
 Andrey Ryabinin <aryabinin@virtuozzo.com>,
 Alessandro Zummo <a.zummo@towertech.it>, rtc-linux@googlegroups.com
Subject: Re: [PATCH] powerpc: Remove broken GregorianDay()
Message-ID: <20151215085332.GH11209@piout.net>
References: <1450163354-16894-1-git-send-email-dja@axtens.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1450163354-16894-1-git-send-email-dja@axtens.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 15/12/2015 at 18:09:14 +1100, Daniel Axtens wrote :
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
> 
Acked-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>

> ---
> This is almost entirely a powerpc patch, but it also touches
> the OPAL rtc driver. Alessandro, Alexandre, RTC folk, would
> you be OK with mpe taking this through the powerpc tree?
> 

Sure.

I have a plan to actually correct tm_wday before sending it to user
space when it is -1.
I may as well calculate it every time but I'm not sure the extra
calculation is actually worth it because as you mention it, it is not
used by anybody.

-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
