Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id BBF6ADE339
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 23 Aug 2008 03:07:16 +1000 (EST)
Message-ID: <48AEF220.7080506@freescale.com>
Date: Fri, 22 Aug 2008 12:06:40 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: skepper@ukf.net
Subject: Re: Early boot problem with MPC8247 and Linux 2.6.26
References: <Pine.LNX.4.62.0808221515450.31216@chara.vm.bytemark.co.uk>
In-Reply-To: <Pine.LNX.4.62.0808221515450.31216@chara.vm.bytemark.co.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Chris Skepper wrote:
> Using code to flash an LED I have traced execution from the entry point 
> in head_32.S, through to call_setup_cpu in misc.S, __setup_cpu_603 and 
> into setup_common_caches in cpu_setup_6xx.S.  It appears to reset when 
> enabling the cache on the CPU:
> 
> setup_common_caches:
>     mfspr    r11,SPRN_HID0
>     andi.    r0,r11,HID0_DCE
>     ori    r11,r11,HID0_ICE|HID0_DCE
>     ori    r8,r11,HID0_ICFI
>     bne    1f            /* don't invalidate the D-cache */
>     ori    r8,r8,HID0_DCI        /* unless it wasn't enabled */
> 1:    sync
>     /* Chris: Reaches here. */
>     mtspr    SPRN_HID0,r8        /* enable and invalidate caches */
>     sync
>     mtspr    SPRN_HID0,r11        /* enable caches */
>     sync
>     isync
>     /* Chris: Never gets to here. */
>     blr
> 
> FWIW, commenting out the lines above causes it to hang when attempting 
> to enable the MMU, which is the next step in the process.

How are you determining that it never gets to that point?  If it's via 
serial I/O or similar, be aware that I/O isn't going to work when caches 
are enabled but the MMU is not.

> Also, can anyone confirm that the MPC8247 is supported by a 2.6.26 
> kernel with ARCH=powerpc mode?  I think it should be, but it would be 
> good to know that someone has tried it.

I've booted an MPC8248 (and some other 82xx) on 2.6.26.  MPC8247 should 
work.

-Scott
