Return-Path: <lists@petig-baender.de>
Received: from e.frontend.um.mediaways.net (e.frontend.um.mediaways.net
	[62.53.231.247]) by ozlabs.org (Postfix) with SMTP id 10D802BF0B
	for <linuxppc-dev@ozlabs.org>; Mon, 29 Nov 2004 18:31:53 +1100 (EST)
Message-ID: <41AA7128.2020907@petig-baender.de>
Date: Mon, 29 Nov 2004 01:45:28 +0100
From: Christof Petig <lists@petig-baender.de>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
References: <200411232008.16854.murphyf+xfree86@f-m.fm>	
	<41A70567.8050000@petig-baender.de>
	<1101517373.4668.2.camel@gaston>
In-Reply-To: <1101517373.4668.2.camel@gaston>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Frank Murphy <murphyf+xfree86@f-m.fm>, debian-x@lists.debian.org
Subject: Re: G3 iBook LCD brightness in X under kernel 2.4.25 and 2.6.8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Benjamin Herrenschmidt schrieb:
> What machine model precisely ? If it's an iBook, only the very first one
> had a mach64 based chip and indeed used atyfb-based brightness control,
> that might have been broken...

My machine is an orange iBook (300MHz), lspci:
0000:00:0b.0 Host bridge: Apple Computer Inc. UniNorth AGP
0000:00:10.0 VGA compatible controller: ATI Technologies Inc Rage 
Mobility L AGP 2x (rev 64)
0000:10:0b.0 Host bridge: Apple Computer Inc. UniNorth PCI
0000:10:17.0 ff00: Apple Computer Inc. KeyLargo Mac I/O (rev 02)
0000:10:18.0 USB Controller: Apple Computer Inc. KeyLargo USB
0000:10:19.0 USB Controller: Apple Computer Inc. KeyLargo USB
0000:20:0b.0 Host bridge: Apple Computer Inc. UniNorth Internal PCI
0000:20:0f.0 ffff: Apple Computer Inc. UniNorth GMAC (Sun GEM) (rev ff)

> Some earlier models have PMU-controlled brightness, independently on the
> video card...

I don't think this is the case for us.

>>Your mouse pointer might get some noisy spots on brightness change, ever 
>>noticed? I would blame the kernel first (since 2.4 works well).
> 
> 
> Ah ? Haven't noticed that ? what machine ? 

I would blame X to leaving the mach64 in a 'strange' state which makes 
the kernel unable to set the brightness the way it uses to do. Since 2.4 
was able to do it, it must be possible (might be less efficient).

>>>The reason this is important for me is that the LCD is not dimmed when I close 
>>>the lid for sleep, which kind of ruins the point of sleep.
>>>
>>>Does anyone have an idea of what else I need to do to get screen dimming to 
>>>work under X with Linux 2.6?
> 
> 
> You may be missing the atyfb kernel driver.

CONFIG_ADB=y
# CONFIG_ADB_CUDA is not set
CONFIG_ADB_PMU=y
CONFIG_PMAC_PBOOK=y
CONFIG_PMAC_APM_EMU=y
CONFIG_PMAC_BACKLIGHT=y
# CONFIG_ADB_MACIO is not set

# CONFIG_FB_ATY128 is not set
CONFIG_FB_ATY=y
CONFIG_FB_ATY_CT=y
# CONFIG_FB_ATY_GX is not set
# CONFIG_FB_ATY_XL_INIT is not set

>>Try to ask on the ppc-kernel list (CCed). I suspect that nobody has 
>>reimplemented power management for mach64 in 2.6. The fact that lid 
>>closing does not put the display to sleep keeps me locked in 2.4, too 
>>(though I experienced that 2.6 is way faster).
> 
> 
> It is, provided you have the right driver.

I really would like to work this out.

Yours
    Christof
