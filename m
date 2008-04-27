Return-Path: <glikely@secretlab.ca>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.247])
	by ozlabs.org (Postfix) with ESMTP id 75320DDE1A
	for <linuxppc-embedded@ozlabs.org>;
	Sun, 27 Apr 2008 15:01:25 +1000 (EST)
Received: by an-out-0708.google.com with SMTP id c37so1105080anc.78
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 26 Apr 2008 22:01:24 -0700 (PDT)
Message-ID: <fa686aa40804262201i158a9c63pf8fdfd766ba3d0@mail.gmail.com>
Date: Sat, 26 Apr 2008 23:01:24 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: mtwallet <mike_timmons@trimble.com>
Subject: Re: mpc5200 arch=powerpc kernel=2.6.24: how do I request external
	IRQ0-3?
In-Reply-To: <16918127.post@talk.nabble.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <161B3BAD77161449A144FF054231C3D60206D6DC@uss-am-xch-01.am.trimblecorp.net>
	<16918127.post@talk.nabble.com>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Sat, Apr 26, 2008 at 7:58 PM, mtwallet <mike_timmons@trimble.com> wrote:
>
>  I got something working. I created a "device" child in the DTS file and used
>  th platform driver subsystem to register my module and get the virtual IRQ
>  as derived from the interrupt triplet-style spec in the dts file.

Sorry I didn't get back to you right away.  Yes, the best/right thing
to do is put a node in your device tree to capture the interrupt and
other interfaces to your custom device.

You should consider using the of_platform infrastructure for
registering your device.  Your driver code can extract its register
locations and interrupts directly from a device tree node.  For an
example, look at the ulite_of_probe and ulite_of_driver in
driver/serial/uartlite.c.

>  I'm still not real content as my child is nested with the SOC peripherals,
>  but this is more of a style/readability hang-up for me, for now. At least
>  now I can get the virtual irq by registering a platform driver, requesting
>  the irq number, and successfully requesting the irq.
>
>  I welcome any advice if I have used the dts file in an unintended fashion,
>  but it feels like the right place to specify a "device", even if all the
>  device embodies is an IRQ. Newbie conceptual difficulty overcome.

Your part of the way there.  Your node should be a child of the device
that it is connected to.  Is it attached to the local bus?  or i2c?
It should have a "compatible" property so that your device driver can
find it (in the form 'compatible = "<manufacturer>,<device>";').  It
should have both an 'interrupt-parent' and an 'interrupts' property
for specifying the interrupt.  If the device is addressable, it should
have a 'reg' property.

You're right that it shouldn't be mixed in with the SoC nodes because
that doesn't accurately describe your platform.  But, it is perfectly
fine for it to be a child of one of the SoC nodes (for example if it
is attached to one of the i2c busses).

Cheers,
g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
