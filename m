Return-Path: <alexandre.belloni@free-electrons.com>
Received: from mail.free-electrons.com (down.free-electrons.com
 [37.187.137.238])
 by lists.ozlabs.org (Postfix) with ESMTP id 3rJSwF0RKhzDqX1
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 31 May 2016 06:32:11 +1000 (AEST)
Date: Mon, 30 May 2016 22:32:07 +0200
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: geert@linux-m68k.org, gregkh@linuxfoundation.org, deller@gmx.de,
 benh@kernel.crashing.org, mpe@ellerman.id.au, dalias@libc.org,
 dhowells@redhat.com, linux-alpha@vger.kernel.org,
 a.zummo@towertech.it, linux-kernel@vger.kernel.org,
 linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-sh@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
 rtc-linux@googlegroups.com, linux-arch@vger.kernel.org
Subject: Re: [PATCH v4 00/16] genrtc removal
Message-ID: <20160530203207.GY3451@piout.net>
References: <1464634684-1248135-1-git-send-email-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1464634684-1248135-1-git-send-email-arnd@arndb.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,

On 30/05/2016 at 20:57:48 +0200, Arnd Bergmann wrote :
> This is the promised resend of the removal of the genrtc driver and some
> related code, now that we are at a good time to merge this for the coming
> merge window.
> 

Thanks a lot!

I'm applying the series right now so it sits in linux-next for a while
before the next merge window.

I would still happily take any acks, Reviewed-by or Tested-by tags.


> - CONFIG_EFI_RTC is actively used on all six Itanium configurations,
>   though the CONFIG_RTC_DRV_EFI replacement driver is also available
>   there (and has been Itanium-only until ARM64 support for EFI was
>   merged). I suspect it's just a matter of getting an Ack from the
>   Itanium maintainers to remove it and change the defconfigs.
> 

I have that one on my radar. There was an impressive number of separate
drivers for EFI and CMOS...

> - the last remaining legacy RTC driver after those is CONFIG_DS1302,
>   which has a slightly nonstandard ioctl interface and is only used
>   on arch/m32r. I have experimented with this a bit and think it
>   can be converted in a backward-compatible way as well.
> 

That one has been converted to a standard SPI driver in v4.6. Following
some discussion, driving it using gpios will be added. m32r will have to
use one of those two interfaces. It is broken on that architecture for
now but we never got any reply from maintainers.


-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
