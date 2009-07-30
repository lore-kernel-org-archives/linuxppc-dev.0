Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e6.ny.us.ibm.com (e6.ny.us.ibm.com [32.97.182.146])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e6.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id CFDF1B7BC7
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 31 Jul 2009 06:08:58 +1000 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e6.ny.us.ibm.com (8.14.3/8.13.1) with ESMTP id n6UKCWmS014879
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Jul 2009 16:12:32 -0400
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	n6UK8qXJ253202
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Jul 2009 16:08:52 -0400
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
	by d01av03.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n6UK8qUb011539
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Jul 2009 16:08:52 -0400
Date: Thu, 30 Jul 2009 16:08:49 -0400
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Solomon Peachy <solomon@linux-wlan.com>
Subject: Re: [PATCH] Add support for the ESTeem 195E (PPC405EP) SBC
Message-ID: <20090730200848.GF10244@zod.rchland.ibm.com>
References: <1248448916-29473-1-git-send-email-solomon@linux-wlan.com>
	<20090730140630.GD10244@zod.rchland.ibm.com>
	<20090730194506.GA30066@linux-wlan.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20090730194506.GA30066@linux-wlan.com>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Jul 30, 2009 at 03:45:06PM -0400, Solomon Peachy wrote:
>On Thu, Jul 30, 2009 at 10:06:30AM -0400, Josh Boyer wrote:
>> >+		devp = finddevice("/plb/opb/serial@ef600300");
>> >+		if (!devp)
>> >+			fatal("Can't find node for /plb/opb/serial@ef600300");
>> >+		del_node(devp);
>> 
>> Slightly confused here.  You delete the first serial node in the single eth
>> case?
>
>The board is actually single eth/serial or dual eth/serial. And strictly 
>speaking, this serial port is the second one in the devicetree...

Maybe a brief comment in the code explaining that would help.  Also, I did
notice the DTS had them in the order you mention, and I forgot to come back
and correct my question there.

>> >+
>> >+		devp = finddevice("/plb/opb/ethernet@ef600900");
>> >+		if (!devp)
>> >+			fatal("Can't find node for /plb/opb/ethernet@ef600900");
>> >+		del_node(devp);
>> >+	}
>> >+
>> >+	ibm4xx_quiesce_eth((u32 *)0xef600800, (u32 *)0xef600900);
>> 
>> Shouldn't you do the quiesce conditionally if the other eth port doesn't
>> exist?
>
>I don't know if this is strictly necessary with the modern ibm_emac 
>driver, but it's certainly safe to call because all 405EPs have dual 
>ethernet controllers.
>
>From the (pre-dts) driver perspecive, the only way to tell if the 
>hotfoot had one ethernet port or two was that the second PHY failed to 
>initialize.
>
>Additionally, the production bootloader (u-boot 1.2.0.x) isn't terribly 
>smart and tries to drive the second controller if the first one doesn't 
>have a cable plugged in, so it's possible the second controller is 
>running when control is handed over to Linux, even on single ethernet 
>boards.

OK, that makes sense.

>
>> >+			UART0: serial@ef600400 {
>> >+				device_type = "serial";
>> >+				compatible = "ns16550";
>> >+				reg = <0xef600400 0x00000008>;
>> >+				virtual-reg = <0xef600400>;
>> >+				clock-frequency = <0>; /* Filled in by zImage */
>> >+				current-speed = <0x9600>;
>> 
>> Just a question, but is the baud supposed to be 38400 or 9600?  At first glance
>> it almost seems like a typo :).
>
>It's supposed to be 38400 baud, hence the explicit 0x in front.  (I lost 
>count of the number of times I saw '38400' listed in various dts 
>files...)

Cool.  Just checking.

>> >+			gpio-leds {
>> >+			     compatible = "gpio-leds";
>> >+			     status {
>> >+			     	    label = "Status";
>> >+			     	    gpios = <&GPIO 1 0>;
>> >+				    /* linux,default=trigger = ".."; */
>> >+			     };
>>
>> What does that comment mean?
>
>Whoops, it's supposed to read 'linux,default-trigger', but the LEDs are 
>manually twiddled for the time being.  I'd forgotten to strip that out.  
>
>(see linux/Documentation/powerpc/dts-bindings/gpio/led.txt)

OK.  If it's not needed just yank it.

>
>> Ok.  So I'm not really all that thrilled with changes to ppcboot.h.  
>> We try to keep this file as much in-sync with U-Boot as we can.  Did 
>> your HOTFOOT changes get pulled into upstream U-Boot?
>
>Yeah, I thought this may be a problem, but I didn't know a better way to 
>go about this and still maintain compatibility with the many thousands 
>of boards already in the field.  I mean, I could strip out the ppcboot.h 
>changes and maintain that as an out-of-tree patch, but without that 
>patch, the kernel won't boot on in-the-field boards, rendering the 
>upstreaming of support for this board kinda pointless.
>
>I haven't tried to push anything to upstream u-boot, given how ancient 
>the in-production bootloader is.  The guy who originally mangled u-boot 
>for this board did so before the "standard" 405EP dual ethernet layout 
>was added, and never tried to push it upstream.  Any upstream uboot work 
>will take the form of a native dts/fdt port that probably won't use 
>ppcboot.h anyway, which brings us full circle...

There is another way.  Perhaps you could just copy ppcboot.h to a new file
called "hotfoot.h" and just use that.  It's a duplication of ppcboot.h to
some degree, but it seems to make sense for your board and it helps preserve
the "stock" ppcboot.h for other boards.

josh
