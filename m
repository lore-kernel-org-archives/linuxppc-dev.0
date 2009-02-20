Return-Path: <alessandro.zummo@towertech.it>
Received: from mx0.towertech.it (mx0.towertech.it [213.215.222.73])
	by ozlabs.org (Postfix) with SMTP id 2D7C7DDDF9
	for <linuxppc-dev@ozlabs.org>; Sat, 21 Feb 2009 03:10:03 +1100 (EST)
Date: Fri, 20 Feb 2009 17:04:54 +0100
From: Alessandro Zummo <alessandro.zummo@towertech.it>
To: rtc-linux@googlegroups.com
Subject: Re: [rtc-linux] [PATCH/RFC 0/5] Generic RTC class driver
Message-ID: <20090220170454.04382e9e@i1501.lan.towertech.it>
In-Reply-To: <1235144809-32468-1-git-send-email-Geert.Uytterhoeven@sonycom.com>
References: <1235144809-32468-1-git-send-email-Geert.Uytterhoeven@sonycom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Richard Zidlicky <rz@linux-m68k.org>, linux-parisc@vger.kernel.org,
	linux-kernel@vger.kernel.org, David,
	Kyle McMartin <kyle@mcmartin.ca>, linuxppc-dev@ozlabs.org,
	linux-m68k@lists.linux-m68k.org, Geert.Uytterhoeven@sonycom.com,
	Woodhouse <dwmw2@infradead.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 20 Feb 2009 16:46:44 +0100
Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com> wrote:

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

 Hello,

   my opinion on this kind of stuff is that I want to avoid the layering
 of implementations under the rtc subsystem. I'd rather prefer that each
 rtc device had its own driver. 
 
  I've made error in the past, by accepting such kind of drivers, and
 would like to avoid that it happens again.

  Regarding the user space, the assumption that a device has
 a fixed major:minor number should be dropped as well.

-- 

 Best regards,

 Alessandro Zummo,
  Tower Technologies - Torino, Italy

  http://www.towertech.it
