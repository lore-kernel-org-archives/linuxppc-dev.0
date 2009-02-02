Return-Path: <sfalco@harris.com>
Received: from mlbe2k2.cs.myharris.net (mlbe2k2.cs.myharris.net
	[137.237.90.89]) by ozlabs.org (Postfix) with ESMTP id F06A1DDDFA
	for <linuxppc-dev@ozlabs.org>; Tue,  3 Feb 2009 08:51:59 +1100 (EST)
Message-ID: <49876AFB.3060207@harris.com>
Date: Mon, 02 Feb 2009 16:51:55 -0500
From: "Steven A. Falco" <sfalco@harris.com>
MIME-Version: 1.0
To: Lixin Yao <Lixin.Yao@HSTX.com>
Subject: Re: Can not get PATA to work for Compact Flash with 2.6.28 kernel
References: <03D77CA4AC7F4D48A6AB5DA3F1001B3F10A4B2@exchtxus2.HSTX.global.vpn>
	<49870A66.8030302@harris.com>
	<03D77CA4AC7F4D48A6AB5DA3F1001B3F10A4B7@exchtxus2.HSTX.global.vpn>
	<49872152.1050902@harris.com>
	<03D77CA4AC7F4D48A6AB5DA3F1001B3F10A4B9@exchtxus2.HSTX.global.vpn>
In-Reply-To: <03D77CA4AC7F4D48A6AB5DA3F1001B3F10A4B9@exchtxus2.HSTX.global.vpn>
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
> Steven/Aaron,
> 
> I found the problem. On my board, the CF is on a 16 bit interface on bus
> of MPC8248. The HW is connected in Big Endian format. PPC Bit D0 is
> connected to CF Bit D15, and PPC D1 to CF Bit D14, till PPC D0 to CF
> D15. I had to swap the bytes in u-boot. I forgot to do it in Kernel. 
> 
> After making the change, CF is detected. But I can not access /dev/hda
> or any scsi/sda devices under /dev. 
> 

How did you swap the bytes?  The CF will be accessed both in byte mode
and in 16-bit mode.  So this is tricky to do in software.  When we
wired our CF, we deliberately swapped the bytes in hardware.  So the
processor bus MSB goes to pin 6 of the CF.

	Steve
