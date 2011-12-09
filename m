Return-Path: <jeremy@goop.org>
Received: from claw.goop.org (unknown [IPv6:2001:470:1f05:bb::8])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "*.goop.org", Issuer "Goop.org CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id B232E1007D6
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  9 Dec 2011 16:43:20 +1100 (EST)
Message-ID: <4EE19DA0.5010705@goop.org>
Date: Thu, 08 Dec 2011 21:33:20 -0800
From: Jeremy Fitzhardinge <jeremy@goop.org>
MIME-Version: 1.0
To: Jiri Kosina <jkosina@suse.cz>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 LinuxPPC-dev <linuxppc-dev@lists.ozlabs.org>,
 Linux Kernel ML <linux-kernel@vger.kernel.org>
Subject: Re: linux-next bad Kconfig for drivers/hid
References: <20111209012746.GC20353@thor.bakeyournoodle.com>
In-Reply-To: <20111209012746.GC20353@thor.bakeyournoodle.com>
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 12/08/2011 05:27 PM, Tony Breeds wrote:
> Commit 4f5ca836bef3 (HID: hid-input: add support for HID devices
> reporting Battery Strength) went into linux-next on Dec 1st since then a
> ppc6xx_defconfig has been failing with:
>
> ---
> drivers/built-in.o: In function `hidinput_cleanup_battery':
> /scratch/tony/working/drivers/hid/hid-input.c:351: undefined reference to `power_supply_unregister'
> drivers/built-in.o: In function `hidinput_setup_battery':
> /scratch/tony/working/drivers/hid/hid-input.c:338: undefined reference to `power_supply_register'
> make[1]: *** [.tmp_vmlinux1] Error 1
> ---
>
> http://kisskb.ellerman.id.au/kisskb/buildresult/5012563/
> vs
> http://kisskb.ellerman.id.au/kisskb/buildresult/5017366/
>
> The defconfig in question doens't mention either option
> (CONFIG_POWER_SUPPLY or CONFIG_HID_BATTERY_STRENGTH) and kbuild is
> genertaing
> CONFIG_HID_BATTERY_STRENGTH=y
> CONFIG_POWER_SUPPLY=m
> which clearly isn't going to work.
>
> The following change to HID_BATTERY_STRENGTH Kconfig "works" but seems a
> little gross.
>
> diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
> index 5ed64f6..d2a94e6 100644
> --- a/drivers/hid/Kconfig
> +++ b/drivers/hid/Kconfig
> @@ -33,7 +33,7 @@ config HID
>  
>  config HID_BATTERY_STRENGTH
>         bool
> -       depends on POWER_SUPPLY
> +       depends on POWER_SUPPLY=y
>         default y
>  
>  config HIDRAW
>
> Any chance we can get a fix into linux-next?

Hm.  How about making it "depends on HID && POWER_SUPPLY"?  I think that
would needlessly disable it if HID is also modular, but I'm not sure how
to fix that.  "depends on HID && POWER_SUPPLY && HID == POWER_SUPPLY"?

    J
