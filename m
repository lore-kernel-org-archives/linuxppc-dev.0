Return-Path: <SRS0=HkGh=QW=denx.de=sr@srs.kundenserver.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.188]) by ozlabs.org (Postfix) with ESMTP id 994D5DDDEC
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 29 Nov 2007 18:00:17 +1100 (EST)
From: Stefan Roese <sr@denx.de>
To: Dell Query <dell.query@yahoo.com>
Subject: Re: Unable to Read PPC440EPx Board ID thru Board Control and Status
	Registers (BCSR)
Date: Thu, 29 Nov 2007 07:56:32 +0100
References: <772588.56121.qm@web45611.mail.sp1.yahoo.com>
In-Reply-To: <772588.56121.qm@web45611.mail.sp1.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Message-Id: <200711290756.32565.sr@denx.de>
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

On Thursday 29 November 2007, Dell Query wrote:
> I see. No wonder I couldn't get more information on BCSR. I should contact
> sequoia to get the proper details like the correct addresses.
>
> I already used ioremap64(), remapping 0x1c0002000. I got a hex value for
> the Board ID but could figure out what it means. So I tried the
> USER_LED0/USER_LED1 (base address+0x2), to see if I could turn on/off the
> user LEDS, but still no luck. I think I am accessing the wrong addresses so
> I need to verify it with them.

Why do think you need the offset 0x2000? I just tested on my Sequoia under 
U-Boot and "see" the CPLD at address 0xc000.0000:

=> md.b c0000000 20
c0000000: 0f 00 c0 07 00 80 00 80 00 20 00 00 00 00 00 00    ......... ......
c0000010: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................

So you should map not 0x1.c000.2000 but 0x1.c000.0000 under Linux. Please let 
me know if this works.

Best regards,
Stefan

=====================================================================
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-0 Fax: +49-8142-66989-80  Email: office@denx.de
=====================================================================
