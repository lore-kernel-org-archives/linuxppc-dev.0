Return-Path: <SRS0=HkGh=QW=denx.de=sr@srs.kundenserver.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.174]) by ozlabs.org (Postfix) with ESMTP id 25171DDD0A
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 29 Nov 2007 21:13:17 +1100 (EST)
From: Stefan Roese <sr@denx.de>
To: Dell Query <dell.query@yahoo.com>
Subject: Re: Unable to Read PPC440EPx Board ID thru Board Control and Status
	Registers (BCSR)
Date: Thu, 29 Nov 2007 11:13:10 +0100
References: <539126.37238.qm@web45608.mail.sp1.yahoo.com>
In-Reply-To: <539126.37238.qm@web45608.mail.sp1.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Message-Id: <200711291113.10356.sr@denx.de>
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

Hi Dell (???),

On Thursday 29 November 2007, Dell Query wrote:
> 1. I used the 0x1c0002000 offset because I was referring to the first reply
> that I received. Now, I used the address 0x1c0002000 and tried to read from
> it. I retrieved 0x0f01c087. May I know what does this mean? How does this
> data relate to Board ID?

Please refer to the document describing the CPLD registers. They are byte 
registers and not 32bit lword registers (see below).

> 2. Referring back to "Embedded Planet 440xC" document, I tried to activate
> the USER_LED0/USER_LED1 (with new address 0x1c0000000 + 0x2 offset) by
> setting it to 0. But didn't see the led turned on. Did some experiments and
> tried 0x1c0000000 without offset, sent 0, and found that USER_LED0 (CR3)
> and USER_LED1 (CR4) are activated! This got me confused. May I know why is
> this so? Could you please refer me to some documents?

The address of the CPLD is without this 0x2000 offset as it seems. Maybe the 
Sequoia users manual is incorrect here.

Make sure that you address these registers with the correct functions. That is 
in_8()/out_8(). Here a log from U-Boot:

=> md.l c0000000 1
c0000000: 0f00c007    ....
=> md.b c0000000 4
c0000000: 0f 00 c0 07    ....

By writing 0x00 to offset 0x02 (LED control) I am able to set the user led's. 
This should work in Linux the same way:

=> mw.b c0000002 00

Best regards,
Stefan

=====================================================================
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-0 Fax: +49-8142-66989-80  Email: office@denx.de
=====================================================================
