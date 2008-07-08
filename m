Return-Path: <John.Linn@xilinx.com>
Received: from SG2EHSOBE005.bigfish.com (outbound-sin.frontbridge.com
	[207.46.51.80]) by ozlabs.org (Postfix) with ESMTP id BE200DE107
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  9 Jul 2008 00:58:33 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Subject: RE: booting an ML405
Date: Tue, 8 Jul 2008 08:58:27 -0600
In-Reply-To: <486D774A.7000102@alphagolf.com>
References: <486D774A.7000102@alphagolf.com>
From: John Linn <John.Linn@xilinx.com>
To: "Lorenzo T. Flores" <lorenzo@alphagolf.com>, <linuxppc-embedded@ozlabs.org>
Message-ID: <20080708145828.79C291550056@mail189-sin.bigfish.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi Lorenzo,

I'm assuming you're trying to use the reference design bit stream for
the ML405 that we have had out on the http://git.xilinx.com site?

Since the bootstrap loader is working, the UART appears to be OK.
Assuming you have the kernel configuration right with the 8250 driver
and the console, it sounds like something else must be wrong and you're
headed in the right direction with using the __log_buf.

The __log_buf should tell you if the kernel is really hung, or if it
booted and you just don't have a console working.

The ml405_defconfig sets up the kernel configuration so it should work
on the board just building it for the reference design.

One thing I notice is the available ram looks wrong to me for the ML405
based on my notes.
 =

> avail ram:     005B0000 80000000

I had a problem once with the kernel and I found the DDR_SIZE in
xparameters.h (arch/ppc/platforms/40x/xparameters) was not right, and
this does hang the kernel in my experience.

My old kernel output shows

> avail ram:     00519000 04000000

Hope that might help,
John


> -----Original Message-----
> From: linuxppc-embedded-bounces+john.linn=3Dxilinx.com@ozlabs.org
[mailto:linuxppc-embedded-
> bounces+john.linn=3Dxilinx.com@ozlabs.org] On Behalf Of Lorenzo T.
Flores
> Sent: Thursday, July 03, 2008 7:05 PM
> To: linuxppc-embedded@ozlabs.org
> Subject: booting an ML405
> =

> Hey all,
> =

> I did a little preliminary poking through the thread archives, but
> didn't turn anything up. I anyone could just point me in the right
> direction as far as troubleshooting, that would be great!
> =

> I'm trying to compile the Xilinx patched kernel tree (v2.6.25-rc9) and
> run it on an ML405
> =

> So far, I get to the following point in the boot sequence:
> =

> loaded at:     00400000 005AF5A0
> board data at: 005AD524 005AD5A0
> relocated to:  00405058 004050D4
> zimage at:     00405E90 0051D6CC
> initrd at:     0051E000 005ACC0D
> avail ram:     005B0000 80000000
> =

> Linux/PPC load: console=3DttyS0,9600 ip=3Don root=3D/dev/ram rw
> Uncompressing Linux...done.
> Now booting the kernel
> =

> The system hangs after it says "Now booting the kernel."
> =

> Once again, any input would be appreciated.
> =

> thank you,
> Lorenzo
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded


This email and any attachments are intended for the sole use of the named r=
ecipient(s) and contain(s) confidential information that may be proprietary=
, privileged or copyrighted under applicable law. If you are not the intend=
ed recipient, do not read, copy, or forward this email message or any attac=
hments. Delete this email message and any attachments immediately.
