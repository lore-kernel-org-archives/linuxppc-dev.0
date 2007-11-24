Return-Path: <glikely@secretlab.ca>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.242])
	by ozlabs.org (Postfix) with ESMTP id 20FC6DDE47
	for <linuxppc-embedded@ozlabs.org>;
	Sun, 25 Nov 2007 04:12:51 +1100 (EST)
Received: by an-out-0708.google.com with SMTP id c37so19707anc
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 24 Nov 2007 09:12:49 -0800 (PST)
Message-ID: <fa686aa40711240912r192aba72o2cbdb798370e7b7c@mail.gmail.com>
Date: Sat, 24 Nov 2007 10:12:49 -0700
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "David H. Lynch Jr." <dhlii@dlasys.net>
Subject: Re: Xilinx devicetrees
In-Reply-To: <47480CF0.7090105@dlasys.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <47480CF0.7090105@dlasys.net>
Cc: linuxppc-embedded <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On 11/24/07, David H. Lynch Jr. <dhlii@dlasys.net> wrote:
>     I am following developments regarding device trees for xilinx boards
> both here and on the microblaze list.
>
>     I am trying to get a grasp on what they will really do for me and
> what using them will demand.
>
>     Please correct any misperceptions:
>
>      As I understand it devicetrees are basically just a tree structured
> binary  database describing the hardware.
>     They have some heritage in OpenFirmware.
>     There are tools to convert  some human readable representations into
> the binary form.
>     There appear to be tools to take xilinx firmware projects and create
> a devicetree database from it
>     A BSP using devicetree's configures its hardware, drivers etc, by
> querying the devicetree database.
>     It it possible to pass the device tree database independent of the
> kernel itself some what similar to the way many bootloaders pass initrd
> filesystems.

Yes, you are correct in all of the above.

One more point; it is also possible to bind the device tree up with
the kernel so you've got a single image just like old times.  :-)

>
>     So in the end I write a BSP that could support a wide variety of
> hardware and compile a single kernel that could be passed different
> devicetree databases representing different xilinx firmware, and still
> hope to work.
>     But in return for making the BSP more generic (sort of), I now have
> to somehow get the correct devicetree database passed for each different
> firmware set that I load.

Yes; either by changes the device tree blob; or having a different
kernel+device tree image for each FPGA bitstream.  In the later case,
the kernel can be compiled once and then bound to multiple dt blobs
(creating multiple images)

>
>     I am having some difficulty grasping the significant advantages to
> this.
>     If the firmware for a given target is not fairly static - and I load
> different firmware depending on what I am doing all the time, then I
> know have to manage both a bit file for the firmware, and a devicetree
> file describing it to the kernel.
>     Currently for base hardware we maintain as much design consistancy
> as possible accross all our different cards/firmware.
>     particular hardware/firmware blocks/IP's may or may not be present -
> but if present they are always the same - the Same Uartlite at the same
> location, on the same irq, same for PIC's, TEMAC's ...
>     For the most part it makes the most sense for us to use code to
> detect the presence/absence of specific baseline hardware and then to
> load non-base custom drivers after boot.

The board description has to live *somewhere*.  For powerpc (and
microblaze) we've decided that for generic stuff, it makes sense to
use the device tree data structure to describe the hardware.  It makes
the platform code simpler because the platform code no longer needs to
explicitly instantiate drivers for each device on the board.  Instead
it registers part of the device tree with the of_platform bus and lets
the drivers handle binding themselves.

That being said, using the device tree does not preclude using
platform code to setup devices *where it makes sense to do so*.  Many
things are one-off board specific things that are not well described
with the device tree.  For example, we've been debating how to handle
on board sound which use common codec chips, but have custom wireup.
The codec chip can use a common driver, but the wireup is handled with
an ALSA 'fabric' driver that is pretty much a one-off for the board.
It probably makes more sense for the fabric driver to be instantiated
by the platform code rather than trying to do a full device tree
representation.

>
>     What am  missing about devicetrees that would make me more
> interested in them ?

To put it all in perspective, for Virtex support in arch/ppc
registration of devices is data driven.  Look at
arch/ppc/syslib/virtex_devices.c which contains a table of platform
devices which the Virtex platform code iterates over.  In arch/powerpc
we're *still* data driven; it's just that the data is no longer
compiled into a static structure.  Plus, in the transition we've moved
from needed per-device platform data structures to a more expressive
format.  Also, per-board platform support code has become much simpler
(compare ml300.c in arch/ppc with platforms/40x/virtex.c)

Cheers,
g.


-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
