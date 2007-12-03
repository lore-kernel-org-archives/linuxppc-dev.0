Return-Path: <SRS0+0172f75cf8e7244956cd+1562+infradead.org+dwmw2@pentafluge.srs.infradead.org>
Received: from pentafluge.infradead.org (pentafluge.infradead.org
	[213.146.154.40])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 72DE3DDDF9
	for <linuxppc-dev@ozlabs.org>; Tue,  4 Dec 2007 09:44:28 +1100 (EST)
Subject: Re: [PATCH] Generic RTC class support for ppc_md.[gs]et_rtc_time
From: David Woodhouse <dwmw2@infradead.org>
To: benh@kernel.crashing.org
In-Reply-To: <1196721397.13230.236.camel@pasglop>
References: <1196701493.13978.163.camel@pmac.infradead.org>
	<1196714722.13230.224.camel@pasglop>
	<1196715974.13978.176.camel@pmac.infradead.org>
	<1196721397.13230.236.camel@pasglop>
Content-Type: text/plain
Date: Mon, 03 Dec 2007 22:44:22 +0000
Message-Id: <1196721862.13978.190.camel@pmac.infradead.org>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 2007-12-04 at 09:36 +1100, Benjamin Herrenschmidt wrote:
> Worst one is time_init :-) Way too early to do any i2c babbling. Then
> there used to be something with the NTP writeback, dunno if it's
> changed.

Setting the system time seems to be done in the new RTC class by a
late_initcall() in drivers/rtc/hctosys.c. In fact, it could even be done
in userspace.

NTP uses update_persistent_clock() and doesn't seem to have been
'solved' yet for the new RTC class. I don't think there's any particular
reason for it to do i2c stuff in that context though.

-- 
dwmw2
