Return-Path: <Martin.Krause@tqs.de>
Received: from mail.tqs.de (mail.tqs.de [62.157.136.17])
	by ozlabs.org (Postfix) with ESMTP id 5680468621
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  3 Nov 2005 19:46:32 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Date: Thu, 3 Nov 2005 09:19:08 +0100
Message-ID: <47F3F98010FF784EBEE6526EAAB078D1C05E66@tq-mailsrv.tq-net.de>
From: "Martin Krause" <Martin.Krause@tqs.de>
To: "Absolut Hunter" <absoluthunter@comcast.net>,
	<linuxppc-embedded@ozlabs.org>
Subject: RE: SM501 Frame Buffer driver on PPC
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi Russell,

Absolut Hunter wrote on Thursday, November 03, 2005 2:40 AM:=20
> The TQM5200 Board uses this driver, but I am gathering this is a PCI
> based=20
> video setup?; Our board uses a local bus memory interface. I.e. we
> have=20
> setup the SM501 to be in the SH-3/4 Slave mode.

On the TQM5200 the SM501 is connected over the local bus, not over
PCI. The SH-4 Interface is used.

> We have dedicated 32Megs of Video memory to be local only to the
> SM501, and mapped it to 0xF8000000 on /CS6, placing the registers at
> 0xFBE00000=20
>=20
> Anyway, I have the UPMA machine setup to communicate with the SM501
> and have verified basic communication with registers, etc.. When
> using Linux the=20
> kernel Oops's when register_framebuffer is called. I have setup the
> voyager.h file to use the correct addresses.

Yes,

#define FB_PHYSICAL_ADDR	0xF8000000
#define REG_PHYSICAL_ADDR	0xFBE00000=20

should do the job (if the addresses are correct).

> Has anyone used the SM501 driver with this type of NON-Unified memory
> architecture? I am guessing this can be confusing to the driver since
> the=20
> frame buffer registers inside the SM501 need to be using offset ZERO
> instead=20
> of the 0xF8000000 like the MPC8280 sees.

I'm not sure, what you mean with NON-Unified memory. Note that the
TQM5200 uses the memory integrated in the SM501 as framebuffer. So
the SM501 is configured to use internal memory. If you want to use=20
external memory, you have to change the SM501 initialisation. Take
a look at the DRAM Control register of the SM501. Pin GPIO12 is
used during reset to enable or disable "Embedded Memory Control".

Please note, that the framebuffer driver does all register accesses
32-bit wide. Make sure your hardware supports this.

Maybe you have to change endianness (little/big).

Regards,
Martin
