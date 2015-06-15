Return-Path: <geert.uytterhoeven@gmail.com>
Received: from mail-ob0-x22c.google.com (mail-ob0-x22c.google.com
 [IPv6:2607:f8b0:4003:c01::22c])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3F02D1A06F8
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Jun 2015 18:23:19 +1000 (AEST)
Received: by obpc2 with SMTP id c2so30447970obp.3
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Jun 2015 01:23:17 -0700 (PDT)
MIME-Version: 1.0
Sender: geert.uytterhoeven@gmail.com
In-Reply-To: <20150614074613.054681242@telegraphics.com.au>
References: <20150614074607.242676098@telegraphics.com.au>
 <20150614074613.054681242@telegraphics.com.au>
Date: Mon, 15 Jun 2015 10:23:17 +0200
Message-ID: <CAMuHMdWzKvWjAE3u54E4xewEDX+zJqEDEvRmO2twpeD2vmBzog@mail.gmail.com>
Subject: Re: [RFC v2 23/24] m68k/mac: Fix PRAM accessors
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Finn Thain <fthain@telegraphics.com.au>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "Linux/m68k" <linux-m68k@vger.kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Finn,

On Sun, Jun 14, 2015 at 9:46 AM, Finn Thain <fthain@telegraphics.com.au> wrote:
> --- linux.orig/arch/m68k/mac/misc.c     2015-06-14 17:46:02.000000000 +1000
> +++ linux/arch/m68k/mac/misc.c  2015-06-14 17:46:03.000000000 +1000
> @@ -284,11 +287,31 @@ static void via_pram_command(int command
>
>  static unsigned char via_pram_read_byte(int offset)
>  {
> -       return 0;
> +       unsigned char temp;
> +       int addr = ((offset & 0xE0) << 3) | ((offset & 0x1F) << 2);

Can you please add #defines for the magic values?

> +
> +       /* Use RTC command 0x38 for XPRAM access, as per MESS source code */
> +       via_pram_command(addr | 0x3800 | 0x8001, &temp);

It seems 0x38 is already documented in <linux/pmu.h> (see below), or not (it's
shifted left by 8 bits?)?

> +
> +       return temp;
>  }
>
>  static void via_pram_write_byte(unsigned char data, int offset)
>  {
> +       unsigned char temp;
> +       int addr = ((offset & 0xE0) << 3) | ((offset & 0x1F) << 2);
> +
> +       /* Clear the write protect bit */
> +       temp = 0x55;
> +       via_pram_command(0x34 | 0x01, &temp);
> +
> +       /* Write the byte to XPRAM */
> +       temp = data;
> +       via_pram_command(0x3800 | 0x0001 | addr, &temp);
> +
> +       /* Set the write protect bit */
> +       temp = 0xD5;
> +       via_pram_command(0x34 | 0x01, &temp);

More magic values...

>  }
>
>  /*
> Index: linux/include/uapi/linux/pmu.h
> ===================================================================
> --- linux.orig/include/uapi/linux/pmu.h 2015-06-14 17:45:34.000000000 +1000
> +++ linux/include/uapi/linux/pmu.h      2015-06-14 17:46:03.000000000 +1000
> @@ -18,7 +18,9 @@
>  #define PMU_POWER_CTRL         0x11    /* control power of some devices */
>  #define PMU_ADB_CMD            0x20    /* send ADB packet */
>  #define PMU_ADB_POLL_OFF       0x21    /* disable ADB auto-poll */
> +#define PMU_WRITE_XPRAM                0x32    /* write eXtended Parameter RAM */
>  #define PMU_WRITE_NVRAM                0x33    /* write non-volatile RAM */
> +#define PMU_READ_XPRAM         0x3a    /* read eXtended Parameter RAM */
>  #define PMU_READ_NVRAM         0x3b    /* read non-volatile RAM */
>  #define PMU_SET_RTC            0x30    /* set real-time clock */
>  #define PMU_READ_RTC           0x38    /* read real-time clock */

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
