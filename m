Return-Path: <sbajaj@tsi-telsys.com>
Received: from exchange.tsi-telsys.com (unknown [205.230.130.11])
	by ozlabs.org (Postfix) with ESMTP id 2FDCD67B19
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 19 Apr 2005 03:02:08 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Date: Mon, 18 Apr 2005 13:02:08 -0400
Message-ID: <0007F077BB3476449151699150E8FEA21A7B95@exchange.tsi-telsys.com>
From: "Sanjay Bajaj" <sbajaj@tsi-telsys.com>
To: "Eugene Surovegin" <ebs@ebshome.net>
Cc: linuxppc-embedded@ozlabs.org
Subject: RE: Unable to capture device interrupts on ppc440gx?
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Eugene,

That did help. I was using the Interrupt Line D, whereas hardware is =
generating interrupt on Interrupt Line A. Correcting the IRQ number to =
the one specified in the arch/platforms file captured the interrupt in =
the device driver.

Thanks for the help.
Have a nice day.
Sanjay

-----Original Message-----
From: Eugene Surovegin [mailto:ebs@ebshome.net]
Sent: Monday, April 18, 2005 12:14 PM
To: Sanjay Bajaj
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: Unable to capture device interrupts on ppc440gx?


On Mon, Apr 18, 2005 at 12:02:52PM -0400, Sanjay Bajaj wrote:
> In the device driver open function, I call request_irq() to register=20
> my interrupt handler function to a specified IRQ number. It=20
> succeeds.=20
> But when I enable the interrupt (and we can detect the hardware line=20
> is active) on the hardware, the interrupt handler in NOT invoked. Is=20
> there something I am missing? Any help or pointers are appreciated.

Did you configure polarity and triggering settings for this IRQ=20
source? If not, look for example at ebony.c (ppc4xx_uic_ext_irq_cfg)=20
keeping in mind, that Ebony has 440GP CPU. 440GX has 5 additional=20
IRQ lines.

--=20
Eugene
