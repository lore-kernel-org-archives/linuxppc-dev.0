Return-Path: <tnt@246tNt.com>
Received: from outmx020.isp.belgacom.be (outmx020.isp.belgacom.be
	[195.238.4.201])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 3B73D679E2
	for <linuxppc-embedded@ozlabs.org>;
	Sat,  6 May 2006 05:28:19 +1000 (EST)
Received: from outmx020.isp.belgacom.be (localhost [127.0.0.1])
	by outmx020.isp.belgacom.be (8.12.11.20060308/8.12.11/Skynet-OUT-2.22)
	with ESMTP id k45JS7Ed026455
	for <linuxppc-embedded@ozlabs.org>; Fri, 5 May 2006 21:28:08 +0200
	(envelope-from <tnt@246tNt.com>)
Message-ID: <445BA736.30208@246tNt.com>
Date: Fri, 05 May 2006 21:27:50 +0200
From: Sylvain Munaut <tnt@246tNt.com>
MIME-Version: 1.0
To: Chris Dumoulin <cdumoulin@ics-ltd.com>, linuxppc-embedded@ozlabs.org
Subject: Re: Calculating virtual address from physical address
References: <445B6A80.2090202@ics-ltd.com>
In-Reply-To: <445B6A80.2090202@ics-ltd.com>
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Chris Dumoulin wrote:
> I'm using a Virtex II Pro-based board with a PPC405. The board is 
> hanging somewhere very early in the kernel boot process. I believe it 
> may be dying at the point where the MMU is enabled. In order to 
> determine the exact point at which my board hangs, I'm blinking two LEDs 
> in the assembly code found in arch/ppc/kernel/head_4xx.S, . Currently I 
> am only able to successfully access the LEDs before the MMU is turned 
> on, but I can't be sure that I'm calculating the virtual address 
> properly when I try to access the LED after the MMU is turned on.

Typical when trying to bring up board ...

Once the MMU is turned on, you leds register are most likely ... nowhere
... i.e.
if you don't create a mapping your self there is just no virtual address
that will
access your leds physical address.

What I did on some ppc work was tu use a quick BAT mapping to map some leds.
It's pretty easy to setup. Be aware though that this mapping will get
wiped out when
the kernel sets up the BAT for itself.


    Sylvain
