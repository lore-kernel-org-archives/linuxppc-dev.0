Return-Path: <matt@genesi-usa.com>
Received: from mail.genesi-usa.com (mithrandir.softwarenexus.net
	[66.98.186.96])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id C13DCDDF0C
	for <linuxppc-dev@ozlabs.org>; Thu, 12 Apr 2007 04:42:26 +1000 (EST)
Message-ID: <461D2C26.1000209@genesi-usa.com>
Date: Wed, 11 Apr 2007 19:42:46 +0100
From: Matt Sealey <matt@genesi-usa.com>
MIME-Version: 1.0
To: Olaf Hering <olaf@aepfle.de>
Subject: Re: [PATCH] autodetect serial console on efika
References: <20070331150823.GA25421@aepfle.de>
	<461A3817.8080303@genesi-usa.com> <20070410165246.GC508@aepfle.de>
In-Reply-To: <20070410165246.GC508@aepfle.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: linuxppc-dev@ozlabs.org, Paul Mackeras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


There are 5 pins on the motherboard for PSC6, which if a driver is enabled for it
(and it's put into UART mode) would become a two-wire serial port (it is intended
for IrDA though in the current board revision).

In this case, you set the firmware console to this and the early init will redirect
the Linux console back to the serial port on the back of the case, just because it
shares a serial device type.

There is a big chance that USB serial drivers will be in a later firmware revision,
at which point this will redirect any USB serial output desired to the serial port
on the back of the system.

Both of these are *wrong* and counter-intuitive.

The only safe serial ports to force "ttyPSC" unit 0 onto are /failsafe (although
this may change!) and /builtin/serial. Otherwise you are second-guessing the user's
preferences in the firmware.

I would in theory recommend against doing it on /failsafe as it is NOT a predictable
device. It simply throws output there in the case of a gross exception and lack of
preferred devices, it just happens that this is and always has been the serial port
on the Pegasos and Efika. It could be an nvram buffer, a PCI card, a special OLED
display, or anything we want it to be depending on the configuration of the Efika
and the revision of the firmware. The intention of /failsafe is that the output
goes SOMEWHERE, rather than to the Open Firmware equivalent of /dev/null, and there
is no special significance to the fact that it is marked as a serial device (i.e.
it may not be connected to a serial port, it is just presented as a serial
interface).

However, on the current Efikas, it does go to the back serial port, so in this case
I would set it to ttyPSC0 anyway. But only in the case of /failsafe and /builtin/serial,
any other port present (remember our device tree is dynamically generated on boot,
and it maps *ALL* present devices capable of detection - not just the ones in the
SoC. Get out of the FDT mindset) should not be redirected using this heuristic
unless it gets vastly more intelligent.

-- 
Matt Sealey <matt@genesi-usa.com>
Genesi, Manager, Developer Relations

Olaf Hering wrote:
> On Mon, Apr 09, Matt Sealey wrote:
> 
>> It is entirely possible that a user may redirect the OF console output to
>> the PSC6 controller or another internal or external serial device (PCI
>> serial controller or so). In this case, the boot console will simply switch
>> to the UART on the back, which may be some other custom device and not a
>> valid console.
> 
> How many serial drivers are enabled in the public Efika firmware?
> With my change, both /failsafe and the /builtin/serial work.
> Both have device_type == "serial"
