Return-Path: <arnd@arndb.de>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.131])
 (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qwWxn1HcMzDqB9
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Apr 2016 19:39:24 +1000 (AEST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@lists.ozlabs.org
Cc: Rich Felker <dalias@libc.org>, linux-arch@vger.kernel.org,
 a.zummo@towertech.it, rtc-linux@googlegroups.com, linux-parisc@vger.kernel.org,
 linux-sh@vger.kernel.org, deller@gmx.de, linux-alpha@vger.kernel.org,
 linux-kernel@vger.kernel.org, dhowells@redhat.com,
 linux-m68k@lists.linux-m68k.org, geert@linux-m68k.org,
 Alexandre Belloni <alexandre.belloni@free-electrons.com>
Subject: Re: [PATCH v3 04/16] rtc: sh: provide rtc_class_ops directly
Date: Thu, 28 Apr 2016 11:38:47 +0200
Message-ID: <5905519.cjzepiYx4I@wuerfel>
In-Reply-To: <2582931.5Q3899gsIm@wuerfel>
References: <1461796470-1291527-1-git-send-email-arnd@arndb.de>
 <20160427232122.GW21636@brightrain.aerifal.cx> <2582931.5Q3899gsIm@wuerfel>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thursday 28 April 2016 11:08:41 Arnd Bergmann wrote:
> I only see two of them anyway (dreamcast and sh03), so that should
> be easy enough to do. For instance in arch/sh/boards/mach-sh03/rtc.c,
> the sh03_time_init() function should register a platform driver,
> whose probe function calls devm_rtc_device_register() to register
> with the rtc subsystem. Then you move the entire file to drivers/rtc/
> and change the callers of sh03_time_init() to create the device
> manually (for the classic board file) or drop it (for DT).

Just FYI:

Another look at the sh03_rtc_settimeofday function shows that it's
always been wrong: unlike the set_mmss() function it calls, it should
set all the time fields, not just minutes and seconds.

	Arnd
