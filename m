Return-Path: <wim@iguana.be>
Received: from mailrelay011.isp.belgacom.be (mailrelay011.isp.belgacom.be
	[195.238.6.178]) by ozlabs.org (Postfix) with ESMTP id 6F909B6F2B
	for <linuxppc-dev@ozlabs.org>; Fri, 13 Nov 2009 08:36:33 +1100 (EST)
Date: Thu, 12 Nov 2009 22:36:30 +0100
From: Wim Van Sebroeck <wim@iguana.be>
To: Albrecht =?iso-8859-1?Q?Dre=DF?= <albrecht.dress@arcor.de>
Subject: Re: [PATCH 3/3] mpc52xx/wdt: WDT uses GPT api
Message-ID: <20091112213630.GE19336@infomag.iguana.be>
References: <fa686aa40911101159y7bef3f9bte74e9aeb5c6e864b@mail.gmail.com>
	<1257884778.14374.5@antares>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1257884778.14374.5@antares>
Cc: Linux PPC Development <linuxppc-dev@ozlabs.org>,
	devicetree-discuss@lists.ozlabs.org, Wim Van Sebroeck <wim@iguana.be>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi All,

>> Can the WDT functionality just be merged entirely into
>> arch/powerpc/platforms/52xx/mpc52xx_gpt.c, eliminating the need for
>> this file entirely?  I think I'd rather have all the GPT "built in"
>> behaviour handled by a single driver.
>
> I also thought about it, as it has IMHO the cleaner code, and it would have the extra benefit that the gpt-wdt api doesn't need to be public.
>
> However, the reasons I hesitated to do so are:
> - I don't want to remove a file someone else wrote (even it doesn't work);
> - WDT code is shifted from drivers/watchdog to arch/powerpc/platforms/52xx which might not be the "logical" place from the directory layout's pov;
> - a file living in arch/powerpc/platforms/52xx depends upon config options set from drivers/watchdog/Kconfig which may be confusing.
>
> You see these are more political/cosmetical questions, so I would prefer to leave the decision to the maintainers (i.e. you and Wim).  Preparing a fully merged driver is actually a matter of minutes!

My opinion: it is harder to maintain the watchdog code if it is being moved away from drivers/watchdog.
I need to check the code before I comment any further on this, but my first thought is: why don't you do it with platform resources like other devices are doing? This way you can keep the platform code under arch and the watchdog itself under drivers/watchdog/. You can look at the following drivers as an example: adx_wdt.c ar7_wdt.c at32ap700x_wdt.c coh901327_wdt.c davinci_wdt.c mpcore_wdt.c mv64x60_wdt.c nuc900_wdt.c omap_wdt.c pnx4008_wdt.c rc32434_wdt.c s3c2410_wdt.c txx9wdt.c .

Kind regards,
Wim.
