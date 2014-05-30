Return-Path: <ralf@linux-mips.org>
Received: from git.linux-mips.org (marvin.linux-mips.org [78.24.191.183])
 by lists.ozlabs.org (Postfix) with ESMTP id 5E0461A06CD
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 31 May 2014 01:49:24 +1000 (EST)
Received: from localhost.localdomain ([127.0.0.1]:33465 "EHLO linux-mips.org"
 rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
 id S6825887AbaE3PtT13Thq (ORCPT
 <rfc822;linuxppc-dev@lists.ozlabs.org>);
 Fri, 30 May 2014 17:49:19 +0200
Date: Fri, 30 May 2014 17:48:59 +0200
From: Ralf Baechle <ralf@linux-mips.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 2/2] gpio: gpiolib: set gpiochip_remove retval to void
Message-ID: <20140530154859.GK17197@linux-mips.org>
References: <20140530094025.3b78301e@canb.auug.org.au>
 <1401449454-30895-1-git-send-email-berthe.ab@gmail.com>
 <1401449454-30895-2-git-send-email-berthe.ab@gmail.com>
 <CAMuHMdV6AtjD2aqO3buzj8Eo7A7xc_+ROYnxEi2sdjMaqFiAuA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAMuHMdV6AtjD2aqO3buzj8Eo7A7xc_+ROYnxEi2sdjMaqFiAuA@mail.gmail.com>
Cc: platform-driver-x86@vger.kernel.org, Alexandre Courbot <gnurou@gmail.com>,
 patches@opensource.wolfsonmicro.com,
 Linux MIPS Mailing List <linux-mips@linux-mips.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 Linus Walleij <linus.walleij@linaro.org>,
 Linux-sh list <linux-sh@vger.kernel.org>,
 linux-wireless <linux-wireless@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 spear-devel@list.st.com, linux-samsungsoc@vger.kernel.org,
 "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
 "linux-leds@vger.kernel.org" <linux-leds@vger.kernel.org>, m@bues.ch,
 "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
 driverdevel <devel@driverdev.osuosl.org>,
 Linux Media Mailing List <linux-media@vger.kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 abdoulaye berthe <berthe.ab@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, May 30, 2014 at 01:39:15PM +0200, Geert Uytterhoeven wrote:

> > +               if (test_bit(FLAG_REQUESTED, &chip->desc[id].flags))
> > +                       panic("gpio: removing gpiochip with gpios still requested\n");
> 
> panic?
> 
> Is this likely to happen?

And while we're at it - panic() is going to add a \n itself so don't pass a
string ending in \n to panic().

  Ralf
