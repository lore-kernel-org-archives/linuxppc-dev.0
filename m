Return-Path: <scottwood@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1bon0134.outbound.protection.outlook.com [157.56.111.134])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id CFE4B1A1781
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Oct 2014 15:01:23 +1100 (AEDT)
Message-ID: <1413518464.7417.23.camel@aoeu.buserror.net>
Subject: Re: [PATCH 1/3] qe-uart: modify qe-uart to adapt both powerpc and arm
From: Scott Wood <scottwood@freescale.com>
To: Timur Tabi <timur@tabi.org>
Date: Fri, 17 Oct 2014 06:01:04 +0200
In-Reply-To: <CAOZdJXUvqzex6oFTEoFRAXUCMfYHZ4GzSESQOvhx_9-vCC_C3Q@mail.gmail.com>
References: <1412923663-4374-1-git-send-email-B45475@freescale.com>
 <1412964307.13320.603.camel@snotra.buserror.net>
 <CAOZdJXUvqzex6oFTEoFRAXUCMfYHZ4GzSESQOvhx_9-vCC_C3Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: Scott Wood <B07421@freescale.com>, Zhao Qiang <B45475@freescale.com>,
 linux-serial@vger.kernel.org, R63061@freescale.com,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2014-10-13 at 11:30 -0500, Timur Tabi wrote:
> On Fri, Oct 10, 2014 at 1:05 PM, Scott Wood <scottwood@freescale.com> wrote:
> > There are many changes in here that ought to be separate patches with
> > separate justification.
> >
> > Also, some of the QE changes seem to be reasonable cleanup, but not
> > related to making the code work on ARM.
> 
> I agree with Scott.  This patch already makes significant code
> changes, so you should have one patch that just makes the
> out_be32->iowrite32be changes.  Changes to the QE library should NOT
> be in the same patch as changes to ucc_uart.c.
> 
> In addition, changes like this:
> 
> -       iprop = of_get_property(np, "port-number", NULL);
> -       if (!iprop) {
> +       ret = of_property_read_u32_index(np, "port-number", 0, &val);
> +       if (ret) {
> 
> should be changed to remove the OF dependency.  If you're going to
> replace of_get_property, replace it with device_property_read_u32(),
> to remove the OF dependency.
> 
> >> diff --git a/arch/arm/include/asm/delay.h b/arch/arm/include/asm/delay.h
> >> index dff714d..a932f99 100644
> >> --- a/arch/arm/include/asm/delay.h
> >> +++ b/arch/arm/include/asm/delay.h
> >> @@ -57,6 +57,22 @@ extern void __bad_udelay(void);
> >>                       __const_udelay((n) * UDELAY_MULT)) :            \
> >>         __udelay(n))
> >>
> >> +#define spin_event_timeout(condition, timeout, delay)                          \
> >> +({                                                                             \
> >> +     typeof(condition) __ret;                                               \
> >> +     int i = 0;                                                             \
> >> +     while (!(__ret = (condition)) && (i++ < timeout)) {                    \
> >> +             if (delay)                                                     \
> >> +                     udelay(delay);                                         \
> >> +             else                                                           \
> >> +                     cpu_relax();                                           \
> >> +             udelay(1);                                                     \
> >> +     }                                                                      \
> >
> > This will delay too long if "delay" is used.
> 
> Shouldn't ARM have a version of tb_ticks_since() by now?

There's get_cycles(), but it's not clear to me whether loops_per_jiffy
is OK to use with get_cycles() on 32-bit ARM.  Is avoiding the udelay
worth making this non-generic?

> 
> >> +     if (!__ret)                                                            \
> >> +             __ret = (condition);                                           \
> >> +     __ret;                                                                 \
> >
> > Timur, do you remember why that final "if (!__ret) __ret = (condition);"
> > is needed?
> 
>     powerpc: Fix spin_event_timeout() to be robust over context switches
> 
>     Current implementation of spin_event_timeout can be interrupted by an
>     IRQ or context switch after testing the condition, but before checking
>     the timeout.  This can cause the loop to report a timeout when the
>     condition actually became true in the middle.
> 
>     This patch adds one final check of the condition upon exit of the loop
>     if the last test of the condition was still false.

OK, so this shouldn't be needed in the udelay version, since an
interrupt shouldn't cause a significant difference in the timeout count.

-Scott
