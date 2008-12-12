Return-Path: <dhlii@dlasys.net>
Received: from outbound-mail-141.bluehost.com (outbound-mail-141.bluehost.com
	[67.222.38.31]) by ozlabs.org (Postfix) with SMTP id AED53DE03C
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 12 Dec 2008 18:15:00 +1100 (EST)
Message-ID: <49420F72.40106@dlasys.net>
Date: Fri, 12 Dec 2008 02:14:58 -0500
From: "David H. Lynch Jr." <dhlii@dlasys.net>
MIME-Version: 1.0
To: linuxppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: Re: Is anyone using the C67x00 USB Host ?
References: <49394978.10905@dlasys.net>
	<493D2B22.4000601@seznam.cz>	<493ED4B6.7010605@dlasys.net>
	<493F89F2.60702@seznam.cz>	<87iqpsme9j.fsf@macbook.be.48ers.dk>
	<493FD3EC.3060305@seznam.cz> <87wse8m6p0.fsf@macbook.be.48ers.dk>
	<493FEFA7.9050703@seznam.cz>
In-Reply-To: <493FEFA7.9050703@seznam.cz>
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

   More info.

    there are 3 USB connectors on this board
    Host 1 - SIE1a
    Host 2 - SIE1b  
    Peripheral 1 SIE2a

    At the moment I do nto care about Peripheral 1.

    I am virtually certain A0 and A1 are not switched.

    with no USB devices plugged in
    The status port is returning a value of 0x30 if I read it
immediately after iomapping the device.
    It returns a value of 0x20 after calling c67x00_ll_init() and
c67x00_ll_hpi_reg_init()

  
    The instant request_irq() is called before a single subsequent  line
in the driver executes c67x00_irq() is called.
    at that point  c67x00_ll_hpi_status(c67x00); returns 0x20
     the remainder of the interrupt handle is called and the status
changes to 0x0 - and remains there.
    Howevr USB interrupts continue to occur until the kernel gets ticked
and turns them off.




   

-- 
Dave Lynch 					  	    DLA Systems
Software Development:  				         Embedded Linux
717.627.3770 	       dhlii@dlasys.net 	  http://www.dlasys.net
fax: 1.253.369.9244 			           Cell: 1.717.587.7774
Over 25 years' experience in platforms, languages, and technologies too numerous to list.

"Any intelligent fool can make things bigger and more complex... It takes a touch of genius - and a lot of courage to move in the opposite direction."
Albert Einstein
