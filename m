Return-Path: <deller@gmx.de>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by ozlabs.org (Postfix) with SMTP id 71A9DDDDF0
	for <linuxppc-dev@ozlabs.org>; Wed, 25 Feb 2009 05:46:18 +1100 (EST)
Message-ID: <49A4406F.2010407@gmx.de>
Date: Tue, 24 Feb 2009 19:46:07 +0100
From: Helge Deller <deller@gmx.de>
MIME-Version: 1.0
To: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Subject: Re: [PATCH/RFC 0/5] Generic RTC class driver
References: <1235144809-32468-1-git-send-email-Geert.Uytterhoeven@sonycom.com>
In-Reply-To: <1235144809-32468-1-git-send-email-Geert.Uytterhoeven@sonycom.com>
Content-Type: text/plain; charset=UTF-8
Cc: Alessandro Zummo <a.zummo@towertech.it>,
	Richard Zidlicky <rz@linux-m68k.org>, rtc-linux@googlegroups.com,
	linux-parisc@vger.kernel.org, linux-kernel@vger.kernel.org,
	Kyle McMartin <kyle@mcmartin.ca>, linuxppc-dev@ozlabs.org,
	linux-m68k@lists.linux-m68k.org, David Woodhouse <dwmw2@infradead.org>,
	dann frazier <dannf@dannf.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Geert Uytterhoeven wrote:
> I've been looking into problems with auto-loading the RTC driver on PPC (more
> specifically on PS3):
>   - The recent "rtc-ppc" RTC class driver is not autoloaded by udev because
>     it's an old style platform driver that contains its own platform device.
>   - The alternative old "genrtc" driver is autoloaded on non-udev systems only
>     because it contains the module alias char-major-10-135. However, it's not
>     a new-style RTC class driver.
> 
> Fortunately there already exists a generic RTC class driver: "rtc-parisc".
> Despite it's name, it's platform-independent, as it's build on top of the RTC
> abstraction used by "genrtc".
> 
> This patch series
>   - adds a missing module alias to rtc-parisc,
>   - renames rtc-parisc to rtc-generic,
>   - converts the architectures that currently have CONFIG_GEN_RTC enabled in
>     their defconfig (m68k, parisc, powerpc) to rtc-generic,
>   - removes the obsolete rtc-ppc driver,
>   - removes the old genrtc driver.
>   
> Note that genrtc may be used on other archictectures as well: at least alpha
> has the required infrastructure ([gs]et_rtc_time()). The Kconfig rules allow
> genrtc to be enabled on several others (cris, h8300, mn10300, um, x86, xtensa).
> 
> Furthermore genrtc and rtc-generic are not 100% userspace compatible:
>   - /dev/rtc provided by genrtc uses a misc character device (10:135),
>   - /dev/rtc provided by rtc-generic uses a dynamic character device.
>   
> So perhaps we don't want to kill gen-rtc yet?
> 
> Any comments are welcomed!

Hi Geert,
FYI, I didn't followed any discussions or changes around the RTC drivers for parisc,
but Dann Frazier did some work on the parisc RTC driver as well.
His patches were merged (not upstream yet!) in Kyle's "rtc-parisc" branch at:
http://git.kernel.org/?p=linux/kernel/git/kyle/parisc-2.6.git;a=shortlog;h=rtc-parisc

Not sure if they conflict (or are in sync) with your patches...

Helge
