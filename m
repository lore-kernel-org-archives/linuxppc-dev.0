Return-Path: <sfalco@harris.com>
Received: from mlbe2k2.cs.myharris.net (mlbe2k2.cs.myharris.net
	[137.237.90.89]) by ozlabs.org (Postfix) with ESMTP id 5F943DDE9F
	for <linuxppc-dev@ozlabs.org>; Thu,  5 Feb 2009 01:26:29 +1100 (EST)
Message-ID: <4989A591.8090807@harris.com>
Date: Wed, 04 Feb 2009 09:26:25 -0500
From: "Steven A. Falco" <sfalco@harris.com>
MIME-Version: 1.0
To: Lixin Yao <Lixin.Yao@HSTX.com>
Subject: Re: Can not get PATA to work for Compact Flash with 2.6.28 kernel
References: <03D77CA4AC7F4D48A6AB5DA3F1001B3F10A4B2@exchtxus2.HSTX.global.vpn>
	<49870A66.8030302@harris.com>
	<03D77CA4AC7F4D48A6AB5DA3F1001B3F10A4B7@exchtxus2.HSTX.global.vpn>
	<49872152.1050902@harris.com>
	<03D77CA4AC7F4D48A6AB5DA3F1001B3F10A4B9@exchtxus2.HSTX.global.vpn>
	<49876AFB.3060207@harris.com>
	<03D77CA4AC7F4D48A6AB5DA3F1001B3F10A4BC@exchtxus2.HSTX.global.vpn>
In-Reply-To: <03D77CA4AC7F4D48A6AB5DA3F1001B3F10A4BC@exchtxus2.HSTX.global.vpn>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, Aaron Pace <kodiakuppercut@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Lixin Yao wrote:
> I redefined io functions in libata-sff.c, byte operations are converted
> to 16bit word operations. Maybe I should ask for HW changes in new
> revisions of the board.
> 

I do recommend that.  We got it wrong on our first board too. :-)  It
is much better to get the hardware right than to carry your endian SW
patch forever.

Two other potential issues: 1) making sure the "most significant
byte enable" is used, so that byte writes work correctly.  You most
likely have this correct already, or you would not have gotten this
far.

And 2) make sure you allow for the hold time / turn-off time of the
CF.  We use a 440EPx, and cannot set up the external bus controller
to generate valid cycles in all cases.  So, we added some flip-flops
to stretch the rising edge of the chip select, which guarantees proper
timing.  (I'm going a bit far afield from the purpose of this mailing
list, so if you want more details, please contact me directly.)

	Steve
