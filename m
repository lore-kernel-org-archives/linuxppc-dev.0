Return-Path: <mb@bu3sch.de>
Received: from vs166246.vserver.de
	(static-ip-62-75-166-246.inaddr.intergenia.de [62.75.166.246])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id DDBABDDE11
	for <linuxppc-dev@ozlabs.org>; Sun, 30 Sep 2007 07:56:31 +1000 (EST)
From: Michael Buesch <mb@bu3sch.de>
To: benh@kernel.crashing.org
Subject: Re: Powerbook shuts down hard when hot, patch found
Date: Sat, 29 Sep 2007 23:53:06 +0200
References: <200709282332.52819.mb@bu3sch.de> <200709291322.59607.mb@bu3sch.de>
	<1191102715.28637.0.camel@pasglop>
In-Reply-To: <1191102715.28637.0.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Message-Id: <200709292353.06476.mb@bu3sch.de>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Saturday 29 September 2007 23:51:55 Benjamin Herrenschmidt wrote:
> 
> On Sat, 2007-09-29 at 13:22 +0200, Michael Buesch wrote:
> > On Saturday 29 September 2007 13:06:59 Michael Buesch wrote:
> > > > This is very strange... Can you try also clearing VGA_DDC_CLK_OUT_EN and
> > > > VGA_DDC_DATA_OUT_EN and the same time and see if that helps ?
> > > 
> > > It still triggers the bug then.
> > 
> > I tried something else.
> > I removed the write and only added a printk with a register read
> > to print the contents (DDC REG IS 0x...) . This is the result:
> > 
> > [    0.431304] PCI: Enabling device 0000:00:10.0 (0006 -> 0007)
> > [    0.626866] radeonfb (0000:00:10.0): Invalid ROM signature 303 should be 0xaa55
> > [    0.626877] radeonfb: Retrieved PLL infos from Open Firmware
> > [    0.626887] radeonfb: Reference=27.00 MHz (RefDiv=12) Memory=203.00 Mhz, System=392.00 MHz
> > [    0.626897] radeonfb: PLL min 12000 max 35000
> > [    0.627194] DDC REG IS 0x00000303
> > [    0.763751] i2c-adapter i2c-2: unable to read EDID block.
> > [    0.983746] i2c-adapter i2c-2: unable to read EDID block.
> > [    1.203745] i2c-adapter i2c-2: unable to read EDID block.
> > [    1.280001] DDC REG IS 0x00000000
> > [    1.620189] ieee1394: Host added: ID:BUS[0-00:1023]  GUID[001124fffed98036]
> > [    1.670984] radeonfb: Monitor 1 type LCD found
> > [    1.670992] radeonfb: EDID probed
> > [    1.670997] radeonfb: Monitor 2 type no found
> > [    1.671012] radeonfb: Using Firmware dividers 0x0002008e from PPLL 0
> > [    1.671075] radeonfb: Dynamic Clock Power Management enabled
> > [    1.712658] Console: switching to colour frame buffer device 160x53
> > [    1.735555] radeonfb: Backlight initialized (radeonbl0)
> > [    1.735746] radeonfb (0000:00:10.0): ATI Radeon NP 
> > [    1.738776] Generic RTC Driver v1.07
> > [    1.738995] Macintosh non-volatile memory driver v1.1
> > ...
> > 
> > Note that the function is called twice. Is that correct?
> 
> Yes. That's expected, with different registers though.
> 
> I don't quite get what's going on. I'll have to figure that out with ATI
> if they bother helping...

This all smells to me like a silicon bug, so I'd start searching
in the silicon erratas. But I'm not sure, of course. It's also strange
that it depends on temperature. (That's why I first expected the PMU
would cause this).

Thanks for your help.

-- 
Greetings Michael.
