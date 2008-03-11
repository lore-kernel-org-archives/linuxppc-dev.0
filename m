Return-Path: <John.Linn@xilinx.com>
Received: from outbound6-dub-R.bigfish.com (outbound-dub.frontbridge.com
	[213.199.154.16])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 85D03DDF2F
	for <linuxppc-dev@ozlabs.org>; Wed, 12 Mar 2008 09:23:32 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Subject: RE: of_serial vs legacy serial support with powerpc arch on 405
Date: Tue, 11 Mar 2008 16:23:22 -0600
In-Reply-To: <20080311170255.4866e51a@zod.rchland.ibm.com>
References: <20080311150430.153AD3D8066@mail134-sin.bigfish.com>
	<20080311170255.4866e51a@zod.rchland.ibm.com>
From: "John Linn" <John.Linn@xilinx.com>
To: "Josh Boyer" <jwboyer@linux.vnet.ibm.com>
Message-Id: <20080311222326.1A544A90088@mail53-dub.bigfish.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Thanks for the help Josh.  I made some comments in-line.


-----Original Message-----
From: Josh Boyer [mailto:jwboyer@linux.vnet.ibm.com]=20
Sent: Tuesday, March 11, 2008 4:03 PM
To: John Linn
Cc: linuxppc-dev@ozlabs.org
Subject: Re: of_serial vs legacy serial support with powerpc arch on 405

On Tue, 11 Mar 2008 09:04:27 -0600
"John Linn" <John.Linn@xilinx.com> wrote:

> I've searched and found some threads, but it's still not clear to me.
> I'm working on 405 with powerpc and trying to get UART550 working.

Walnut works.  So do Halakeau and Kilauea.  Is your serial port
significantly different from those?

>> Requires a shift as the regs are farther apart.

> I know that I need speed, freq, and reg-shift properties in the device
> tree and I have found patches for of_serial.c.

Patches for of_serial.c for what?

>> There was a patch to correct where the spd was assumed to be in the=20
>> device tree and it would bomb out if it wasn't. I was thinking there
was
>> a patch for the reg-shift value also.
=20
> I still don't understand when to use of_serial.c (SERIAL_OF_PLATFORM)
vs
> the legacy support for serial ports.  Is there any docs that I'm not
> finding that I should read?

There are no docs.  At one time, of_serial was declared as the one true
serial driver, but these days either will do.  The benefit of
legacy_serial is that output is enabled earlier in the boot.

> I don't see a way to configure in the legacy support, but I'm using
> SERIAL_OF and having problems. I don't see the console getting enabled
> even though it found the serial port driver.

You need to have CONFIG_PPC_UDBG_16550 set to bring in legacy_serial.

>> Thanks got it working with some mods.

josh
