Return-Path: <mb@bu3sch.de>
Received: from vs166246.vserver.de
	(static-ip-62-75-166-246.inaddr.intergenia.de [62.75.166.246])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id D93E1DDE0A
	for <linuxppc-dev@ozlabs.org>; Sun, 30 Sep 2007 20:20:10 +1000 (EST)
From: Michael Buesch <mb@bu3sch.de>
To: benh@kernel.crashing.org
Subject: Re: Powerbook shuts down hard when hot, patch found
Date: Sun, 30 Sep 2007 12:16:54 +0200
References: <200709282332.52819.mb@bu3sch.de>
	<1191106145.28637.11.camel@pasglop>
	<200709301213.36821.mb@bu3sch.de>
In-Reply-To: <200709301213.36821.mb@bu3sch.de>
MIME-Version: 1.0
Message-Id: <200709301216.55123.mb@bu3sch.de>
Content-Type: text/plain;
  charset="iso-8859-15"
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sunday 30 September 2007 12:13:36 Michael Buesch wrote:
> On Sunday 30 September 2007 00:49:05 Benjamin Herrenschmidt wrote:
> > Well, it's possible that they have a too weak pull-up resistor on those
> > lines, and thus when asserted to 0, a significant current goes through
> > causing the whole thing to heat up. That heat added to the residual heat
> > of a hot boot becomes then enough to trigger the temperature sensor
> > threshold... just one possible explanation.
> 
> Possible, yes.
> 
> > > That's why I thought about some silicon bug. Why only when it's hot? :)
> > > 
> > > > Also, the other change I made you do turns these into inputs, thus the
> > > 
> > > The _EN bits are already all cleared, as you can see in my printk dump.
> > > So clearing them has no effect, of course.
> > > So the ports are Inputs as default on boot.
> > 
> > Hrm, that's weird then, because in that case, changing the output bits
> > shouldn't have any effect, unless maybe on some chips, the EN bits are
> > flipped. I don't have anything specific about the rv350 tho.
> > 
> > Can you print which specific DDC register is doing that (it's called
> > twice right ?) and maybe do a patch preventing that write only for one
> > of them and let me know if it makes a difference.
> 
> Here's the log of a working kernel.
> As you can see, I only removed the write for register 0x60 here.
> So it only crashes when I clear the bits in this register.
> (makes sense, as there's nothing to clear in the other one).
> 
> [    0.453703] PCI: Enabling device 0000:00:10.0 (0006 -> 0007)
> [    0.649319] radeonfb (0000:00:10.0): Invalid ROM signature 303 should be 0xaa55
> [    0.649329] radeonfb: Retrieved PLL infos from Open Firmware
> [    0.649340] radeonfb: Reference=27.00 MHz (RefDiv=12) Memory=203.00 Mhz, System=392.00 MHz
> [    0.649350] radeonfb: PLL min 12000 max 35000
> [    0.650146] DDC REG 0x00000060 IS 0x00000303
> [    0.793754] i2c-adapter i2c-2: unable to read EDID block.
> [    1.013748] i2c-adapter i2c-2: unable to read EDID block.
> [    1.233748] i2c-adapter i2c-2: unable to read EDID block.
> [    1.310002] DDC REG 0x0000006C IS 0x00000000
> [    1.310007] WRITING
> [    1.650506] ieee1394: Host added: ID:BUS[0-00:1023]  GUID[001124fffed98036]
> [    1.700986] radeonfb: Monitor 1 type LCD found
> [    1.700995] radeonfb: EDID probed
> [    1.701001] radeonfb: Monitor 2 type no found
> [    1.701015] radeonfb: Using Firmware dividers 0x0002008e from PPLL 0
> [    1.701130] radeonfb: Dynamic Clock Power Management enabled
> [    1.742608] Console: switching to colour frame buffer device 160x53
> [    1.765577] radeonfb: Backlight initialized (radeonbl0)
> [    1.765767] radeonfb (0000:00:10.0): ATI Radeon NP 
> [    1.776757] Generic RTC Driver v1.07
> [    1.777085] Macintosh non-volatile memory driver v1.1
> [    1.777429] Linux agpgart interface v0.102
> [    1.777739] agpgart: Detected Apple UniNorth 2 chipset
> 

Ah, forgot to say.
It does not crash immediately when the register is written. It takes about two seconds
to crash. And when the machine is colder to begin with, it takes slightly
longer to trigger. That _might_ support your overheating theory.

Though, it does not trigger when it's up and running, no matter how hot you drive it.

-- 
Greetings Michael.
