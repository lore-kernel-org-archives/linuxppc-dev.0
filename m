Return-Path: <david-b@pacbell.net>
Received: from smtp121.sbc.mail.sp1.yahoo.com (smtp121.sbc.mail.sp1.yahoo.com
	[69.147.64.94]) by ozlabs.org (Postfix) with SMTP id AFBA5DDED0
	for <linuxppc-dev@ozlabs.org>; Sun, 25 Nov 2007 04:50:44 +1100 (EST)
From: David Brownell <david-b@pacbell.net>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [linux-usb-devel] [PATCH 1/5] USB: Make usb_hcd_irq work for
	multi-role =?iso-8859-1?q?USB=09controllers_w/_shared?= irq
Date: Sat, 24 Nov 2007 09:50:40 -0800
References: <20071124001203.25361.99294.stgit@trillian.cg.shawcable.net>
	<20071124051039.GA11029@suse.de>
	<20071124170307.773d7317@the-village.bc.nu>
In-Reply-To: <20071124170307.773d7317@the-village.bc.nu>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200711240950.41235.david-b@pacbell.net>
Cc: akpm@osdl.org, Greg KH <gregkh@suse.de>,
	linux-usb-devel@lists.sourceforge.net, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Saturday 24 November 2007, Alan Cox wrote:
> > 
> > What about for platforms where irq 0 is a valid irq?
> 
> There are no such platforms. Linus made that absolutely clear every time
> this came up before
> 
>         0       -       No IRQ
> 
> A platform with a physical or bus IRQ of 0 needs to remap it to a
> different constant.

However it's also common practice to use negative numbers to
flag "this is no IRQ" ... avoiding all confusions with zero.

  - platform_get_irq(), platform_get_irq_byname() ... never
    return zero, they return irq (positive) or errno

  - PNP initializes invalid IRQs to "-1", and pnp_check_irq()
    handles irq zero as in-range

  - I'm sure I've seen negative numbers used elsewhere too

Something like

  #define is_valid_irq(x) ((x) >= 0)

would work better than expecting sudden agreement everywhere
about a single number representing "this is not an IRQ".

- Dave
