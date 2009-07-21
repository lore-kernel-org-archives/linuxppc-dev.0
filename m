Return-Path: <sr@denx.de>
Received: from mo-p05-ob.rzone.de (mo-p05-ob.rzone.de [81.169.146.181])
	by bilbo.ozlabs.org (Postfix) with ESMTP id 0AB7DB70B0
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 22 Jul 2009 00:06:59 +1000 (EST)
From: Stefan Roese <sr@denx.de>
To: linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] PowerPC 440EPx: Sequoia bootwrapper
Date: Tue, 21 Jul 2009 16:06:52 +0200
References: <2C7DE72B9BD00F44BAECA5B0CBB873956CDC2B@hermes.terascala.com>
In-Reply-To: <2C7DE72B9BD00F44BAECA5B0CBB873956CDC2B@hermes.terascala.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Message-Id: <200907211606.52572.sr@denx.de>
Cc: Bob Burke <Bob.Burke@terascala.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tuesday 21 July 2009 15:33:20 Bob Burke wrote:
> The system clock frequency on the Sequoia board is 33.000000 MHz not
> 33.333333 MHz; this causes the system time to drift more than 30 seconds
> per hour.
>
> diff -ruN a/arch/powerpc/boot/cuboot-sequoia.c
> b/arch/powerpc/boot/cuboot-sequoia.c
> --- a/arch/powerpc/boot/cuboot-sequoia.c        2009-05-18
> 19:52:34.000000000 -0400
> +++ b/arch/powerpc/boot/cuboot-sequoia.c        2009-07-21
> 09:13:13.000000000 -0400
> @@ -37,7 +37,7 @@
>
>  static void sequoia_fixups(void)
>  {
> -       unsigned long sysclk = 33333333;
> +       unsigned long sysclk = 33000000;
>
>         ibm440ep_fixup_clocks(sysclk, 11059200, 50000000);
>         ibm4xx_fixup_ebc_ranges("/plb/opb/ebc");

Unfortunately it's not that easy. Earlier Sequoia board revisions are equipped 
with an 33.333MHz oscillator. This can be detected via a CPLD register though. 
Here the "code" from U-Boot (just as an example):

/* Detect Sequoia PLL input clock automatically via CPLD bit            */
#define CONFIG_SYS_BCSR_BASE            0xc0000000
#define CONFIG_SYS_CLK_FREQ    ((in8(CONFIG_SYS_BCSR_BASE + 3) & 0x80) ? \
                                33333333 : 33000000)

But why are you using the boot wrapper? If your U-Boot isn't too old, you can 
boot uImage directly (with dtb of course). No need for the wrapper.

Thanks,
Stefan
