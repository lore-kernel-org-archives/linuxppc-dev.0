Return-Path: <SRS0=/s0T=TW=denx.de=sr@srs.kundenserver.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.186]) by ozlabs.org (Postfix) with ESMTP id 1B330DDE0D
	for <linuxppc-dev@ozlabs.org>; Tue,  4 Mar 2008 17:21:01 +1100 (EST)
From: Stefan Roese <sr@denx.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: Bamboo PCI interrupt issues
Date: Tue, 4 Mar 2008 07:15:21 +0100
References: <1204588953.7921.13.camel@basalt>
	<20080303213718.12291eee@zod.rchland.ibm.com>
In-Reply-To: <20080303213718.12291eee@zod.rchland.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200803040715.22301.sr@denx.de>
Cc: kvm-ppc-devel <kvm-ppc-devel@lists.sourceforge.net>,
	Hollis Blanchard <hollisb@us.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tuesday 04 March 2008, Josh Boyer wrote:
> > Is anybody using Bamboo PCI support right now? Does it actually work?
>
> I plugged in an old 3Com ethernet card tonight.  Slot 0.  It was
> assigned dev #4 IRQ 25.  Using the device tree as-is, I could see
> interrupts happening in /proc/interrupts but ethernet traffic failed.
>
> Then I changed the sense level to 4 as you suggested, and my card hung
> hard on the first ethernet traffic.

Using '8' is correct. PCI interrupts are *always* level sensitive and active 
low.

> I've no idea if we're dealing with 
> a crappy card or a crappy driver but the device tree seems to be
> working ok.  If I can find a different card to test with I will.

One thing always worth to check on 4xx IRQ problems is, if the external IRQ 
pins are configured correctly for IRQ usage. Most of the times, the external 
IRQ's are shared with other peripheral pins and/or GPIO pins. This 
configuration is done in the GPIO core (and sometimes SDR PFCx registers). 
This should be done correctly by the bootloader but sometimes the 
configuration is wrong. I have to admit that I probably never tested PCI on 
Bamboo. Just a thought.

Best regards,
Stefan
