Return-Path: <geert@linux-m68k.org>
Received: from witte.sonytel.be (witte.sonytel.be [80.88.33.193])
	by ozlabs.org (Postfix) with ESMTP id 71CE767A66
	for <linuxppc-dev@ozlabs.org>; Tue, 18 Jan 2005 23:34:40 +1100 (EST)
Date: Tue, 18 Jan 2005 10:20:34 +0100 (MET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
Sender: geert@sonycom.com
To: "Mark A. Greer" <mgreer@mvista.com>
In-Reply-To: <41EC29A8.1040703@mvista.com>
Message-ID: <Pine.GSO.4.61.0501181017110.20681@waterleaf.sonytel.be>
References: <41EC29A8.1040703@mvista.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Linux/PPC Development <linuxppc-dev@ozlabs.org>
Subject: Re: [RFC] Option to disable mapping genrtc calls to ppc_md calls
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 17 Jan 2005, Mark A. Greer wrote:
> I have a platform with an i2c rtc chip.  Since much of the code for an rtc
> driver is already in drivers/char/genrtc.c, I would like to reuse that code
> and directly implement get_rtc_time(), et. al. in the rtc driver.  The problem
> is that include/asm-ppc/rtc.h assumes that get_rtc_time(), et. al. should be
> mapped to ppc_md.get_rtc_time() et. al.  To work around this, I made an option
> to turn off that assumption.  The patch is included.
> 
> There are 2 reasons to not use the ppc_md.get_rtc_time() et. al. interfaces:
> 1) They are called before the i2c driver is initialized and even loaded if its
> a module.

How is this solved by your patch if genrtc is builtin? How is your solution
different from setting ppc_md.get_rtc_time to your get_rtc_time routine?

> 2) Its ppc-specific.  Implementing get_rtc_time() et. al. directly makes it
> generic across all architectures.

... but prevents you from building a kernel that supports both normal RTCs and
your i2c RTC.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
