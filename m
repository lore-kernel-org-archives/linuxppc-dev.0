Return-Path: <wd@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id 4B3E7DDDE4
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 12 Mar 2007 10:46:54 +1100 (EST)
To: melinda develey <melinda.develey70@yahoo.com>
From: Wolfgang Denk <wd@denx.de>
Subject: Re: Xenomai real time driver and normal linux driver mutual exclusion
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Sun, 11 Mar 2007 14:57:05 MST."
	<20070311215705.59806.qmail@web63001.mail.re1.yahoo.com>
Date: Mon, 12 Mar 2007 00:46:49 +0100
Sender: wd@denx.de
Message-Id: <20070311234649.69284352676@atlas.denx.de>
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

In message <20070311215705.59806.qmail@web63001.mail.re1.yahoo.com> you wrote:
>
> I have an I2C bus, some devices should be controlled by a normal
> linux driver but an ADC and a DAC on this bus should be controlled by
> a real time xenomai driver because, after a READ from the DAC I have
> to write to the ADC every 500 usec. I tried to use the normal linux
> driver from a xenomai real time user mode task but reading DAC, doing
> some computations, and writing to the ADC takes more than 500 usec. I

And what makes you think that a real-time driver would be any faster?
Real-time does not mean speed,  it  means  reliable  and  predictable
deadlines.

Do some basic calculations. You have a ADC plus  a  DAC,  that's  two
devices.  You  need  to  read and write both? Assume the read needs 2
bytes addressing and returns 4 bytes of data, and the write  needs  6
bytes, too. That's 12 bytes per device, or 24 bytes in total.
How fast is your I2C bus? 400 kHz?
2 devices * 12 bytes * 8 Bit / 400 kHz = 480 usec.

And you got 500 usec in total? On a 8xx? Arghhhh...

And this does not include *any* delays caused by your ADC and DAC, it
does  not  include  any  latencies  and  time  needed  for  interrupt
processing  (assume  50...100  usec  on a 8xx - or more), it does not
consider that you probably have to transfer more bytes, etc.

In short: this looks much like a "can't be done" situation.

> thought to write both a RTDM driver for my 8xx I2C controller and a
> normal linux driver, but, how may I serialize access to the 8xx I2C
> controller from these drivers?

That would just slow down things even more.

Best regards,

Wolfgang Denk

-- 
DENX Software Engineering GmbH, HRB 165235 Munich, CEO: Wolfgang Denk
Office:  Kirchenstr. 5,       D-82194 Groebenzell,            Germany
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
The greatest threat towards future is indifference.
