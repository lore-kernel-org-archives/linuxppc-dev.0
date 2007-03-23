Return-Path: <tnt@246tNt.com>
Received: from outmx011.isp.belgacom.be (outmx011.isp.belgacom.be
	[195.238.5.3])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 9F033DE02A
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 23 Mar 2007 23:03:02 +1100 (EST)
Received: from outmx011.isp.belgacom.be (localhost [127.0.0.1])
	by outmx011.isp.belgacom.be (8.12.11.20060308/8.12.11/Skynet-OUT-2.22)
	with ESMTP id l2NC2kbu015188
	for <linuxppc-embedded@ozlabs.org>; Fri, 23 Mar 2007 13:02:46 +0100
	(envelope-from <tnt@246tNt.com>)
Message-ID: <4603C1E8.5030600@246tNt.com>
Date: Fri, 23 Mar 2007 13:02:48 +0100
From: Sylvain Munaut <tnt@246tNt.com>
MIME-Version: 1.0
To: Steven Kaiser <skaiser.uci@gmail.com>
Subject: Re: Howto set DIO on MPC-5200 Lite
References: <918EB199DDDFFA42BEA2EB3A1C6021F360C085@CORREO>	<20070322200453.GA76755@server.idefix.lan>
	<000401c76cd4$40805fd0$6e4ec880@volt>
In-Reply-To: <000401c76cd4$40805fd0$6e4ec880@volt>
Content-Type: text/plain; charset=ISO-8859-1
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

Steven Kaiser wrote:
> EFIKA seems to have some sort of battery backed RTC to keep date and time,
> but without a schematic I can't be sure what it is.  Would be nice if the
> LITE500B had something like this.  What 5200B chip pins does EFIKA use for
> this?  Maybe should reserve these pins for a future RTC in the EFIKA
> tradition.
>   
The EFIKA has a small PIC that serves for power up / down and to keep time.
I think it's on a I2C bus but I don't know if they implemented it with
the embedded I2C controller or by bitbanging some GPIO.
(never saw the schema so that's and educated guess ...)
> So my general question is this: What pins on the 5200B are free for external
> use by the user (i.e. what pins are reserved by the linux 2.4 and 2.6 stock
> kernels for internal use)?
>   
I can only speak for 2.6 and AFAIK it's none ...

Anyway you will need to write your own board file and your own device
tree and have your boot loader set port_config appropriatly. From there
you can free any pin you want (provided  that pin is not used by a
function you want of course ...)

The lines used for PCI IRQ are specified for the Lite5200 and Lite5200B
in their device tree (or in the board file if you still use arch/ppc).
So when you write those files for your board, just make sure it match
your board.

    Sylvain
