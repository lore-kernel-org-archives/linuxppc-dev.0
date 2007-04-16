Return-Path: <glikely@gmail.com>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.171])
	by ozlabs.org (Postfix) with ESMTP id 94B69DDE0F
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 16 Apr 2007 15:40:55 +1000 (EST)
Received: by ug-out-1314.google.com with SMTP id k3so781194ugf
	for <linuxppc-embedded@ozlabs.org>;
	Sun, 15 Apr 2007 22:40:53 -0700 (PDT)
Message-ID: <528646bc0704152240u60bf24dbx6a1ca8dd15aaaf53@mail.gmail.com>
Date: Sun, 15 Apr 2007 23:40:53 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@gmail.com
To: "Domen Puncer" <domen.puncer@telargo.com>
Subject: Re: [PATCH 4/5] mpc52xx suspend: deep-sleep
In-Reply-To: <20070404073755.GE18236@moe.telargo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
References: <20070315103959.GA22215@moe.telargo.com>
	<20070315104307.GE22215@moe.telargo.com>
	<528646bc0703230858h237237c2t5b7bedca6e42cddd@mail.gmail.com>
	<20070404073755.GE18236@moe.telargo.com>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On 4/4/07, Domen Puncer <domen.puncer@telargo.com> wrote:
> Hi!
>
> How about something like the following.
> Changes:
> - lots of code moved from asm to C
> - add compatible "mpc5200" to lite5200x soc (already is this
>   way on efika). And change Efika's soc device_type to "soc".
> - add wakeup supported with RTC (1 to 24*60-1 minutes)
> - each board now configures it's wakeup mode and possibly
>   board suspend and resume functions it needs to call (USB on lite)

Sorry it took so long for me to review and get back to you on this
patch.  I got wrapped up in other tasks.

I mostly like the approach that you're taking here to allow each board
to select it's own wakeup method, but I think it should be taken a
step farther.  Instead of providing a set of stock
mpc52xx_set_wakeup_*() functions, I think it would make for simpler
and more flexible code if each board takes care of its own wakeup
configuration in the board_suspend_prepare hook.  In fact, the
mpc52xx_set_wakeup_*() functions themselves make a lot of sense, and
are useful utility functions.  But rather than trying to codify which
pins/rtc to configure for wakeup via the .mask, .level, .pin and
.delay items, those functions should be called directly by
lite5200_suspend_prepare() and efika_suspend_prepare().  Doing this
will drop 19 lines of common code in exchange for adding 2 lines to
each board port.

As an added bonus, doing it this way allows multiple pins to be used
for wakeup.  :-)

> This code survived > 70k suspend/resume cycles :-)

That's pretty good evidence.  :-)

> Comments?

A few more comments below

> --- /dev/null
> +++ grant.git/arch/powerpc/platforms/52xx/mpc52xx_pm.c
<snip>
> +extern void mpc52xx_ds_sram(void);
> +extern const long mpc52xx_ds_sram_size;
> +extern void mpc52xx_ds_cached(void);
> +extern const long mpc52xx_ds_cached_size;

This *looks* like dangerous code (function prototypes not in a shared
header).  You should add a big comment here to the fact that these are
assembly functions that are only ever referenced in this file.

===================================================================
> --- grant.git.orig/arch/powerpc/boot/dts/lite5200.dts
> +++ grant.git/arch/powerpc/boot/dts/lite5200.dts
> @@ -49,6 +49,7 @@
>
>         soc5200@f0000000 {
>                 model = "fsl,mpc5200";
> +               compatible = "mpc5200";
>                 revision = ""                   // from bootloader
>                 #interrupt-cells = <3>;
>                 device_type = "soc";
> Index: grant.git/arch/powerpc/boot/dts/lite5200b.dts
> ===================================================================
> --- grant.git.orig/arch/powerpc/boot/dts/lite5200b.dts
> +++ grant.git/arch/powerpc/boot/dts/lite5200b.dts
> @@ -49,6 +49,7 @@
>
>         soc5200@f0000000 {
>                 model = "fsl,mpc5200b";
> +               compatible = "mpc5200";
>                 revision = "";                  // from bootloader
>                 #interrupt-cells = <3>;
>                 device_type = "soc";

Put these two changes in a seperate patch, and I'll ACK them right away

===================================================================
> --- grant.git.orig/arch/powerpc/kernel/prom_init.c
> +++ grant.git/arch/powerpc/kernel/prom_init.c
> @@ -2142,7 +2142,7 @@ static void __init fixup_device_tree_efi
>                                      3,12,0, 3,13,0, 3,14,0, 3,15,0 };
>         struct subst_entry efika_subst_table[] = {
>                 { "/",                  "device_type",  prop_cstr("efika") },
> -               { "/builtin",           "compatible",   prop_cstr("soc") },
> +               { "/builtin",           "device_type",  prop_cstr("soc") },
>                 { "/builtin/ata",       "compatible",   prop_cstr("mpc5200b-ata\0mpc5200-ata"), },
>                 { "/builtin/bestcomm",  "compatible",   prop_cstr("mpc5200b-bestcomm\0mpc5200-bestcomm") },
>                 { "/builtin/bestcomm",  "interrupts",   prop_bcomm_irq, sizeof(prop_bcomm_irq) },
>

This should also be a seperate patch.

Cheers,
g.

-- 
Grant Likely, B.Sc. P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
