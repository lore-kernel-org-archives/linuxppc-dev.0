Return-Path: <anton@scarybugs.org>
Received: from mail-pa0-f41.google.com (mail-pa0-f41.google.com
 [209.85.220.41])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 2CB882C0345
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 13 Jul 2013 04:35:09 +1000 (EST)
Received: by mail-pa0-f41.google.com with SMTP id bj3so9293655pad.0
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Jul 2013 11:35:06 -0700 (PDT)
Sender: Anton Vorontsov <anton@scarybugs.org>
Date: Fri, 12 Jul 2013 11:35:03 -0700
From: Anton Vorontsov <anton@enomsg.org>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 3/4 V2] mmc: esdhc: Add quirks to support T4240QDS board
Message-ID: <20130712183503.GA24689@teo>
References: <1373267764-6364-1-git-send-email-Haijun.Zhang@freescale.com>
 <1373267764-6364-2-git-send-email-Haijun.Zhang@freescale.com>
 <1373303919.8183.164@snotra>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <1373303919.8183.164@snotra>
Cc: linux-mmc@vger.kernel.org, r39252@freescale.com, AFLEMING@freescale.com,
 cjb@laptop.org, linuxppc-dev@lists.ozlabs.org,
 Haijun Zhang <Haijun.Zhang@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Jul 08, 2013 at 12:18:39PM -0500, Scott Wood wrote:
> On 07/08/2013 02:16:04 AM, Haijun Zhang wrote:
> >On T4240QDS board controllers has an unusable ADMA engine, so use
> >SDMA instead.
> >Also 3.0v is support on T4240QDS board even if the capacity
> >detailed only 1.8v
> >support. Without this quirk SD card will declare voltage not
> >support and
> >
> >Signed-off-by: Haijun Zhang <haijun.zhang@freescale.com>
> 
> ...and what?
> 
> Why is this board-specific?  Isn't the controller part of the SoC,
> not part of the board?  If it really is board-specific, could you be
> more detailed about why (ideally with an erratum number), and check
> the toplevel board compatible (or get the information from platform
> code) rather than modify the device tree?

Yup, and if anything, I would recommend to reuse voltage-ranges property,
it is already implemented for mmc spi driver,

drivers/mmc/host/of_mmc_spi.c
Documentation/devicetree/bindings/mmc/mmc-spi-slot.txt

Thanks,

Anton
