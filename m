Return-Path: <glikely@secretlab.ca>
Received: from mail-gx0-f157.google.com (mail-gx0-f157.google.com
	[209.85.217.157]) by ozlabs.org (Postfix) with ESMTP id D74BDDE050
	for <linuxppc-dev@ozlabs.org>; Tue, 21 Apr 2009 16:09:59 +1000 (EST)
Received: by gxk1 with SMTP id 1so5265196gxk.9
	for <linuxppc-dev@ozlabs.org>; Mon, 20 Apr 2009 23:09:58 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20090226214919.GA19959@ovro.caltech.edu>
References: <20090224000002.GA578@ovro.caltech.edu>
	<200902261715.28440.arnd@arndb.de>
	<20090226200110.GA19523@ovro.caltech.edu>
	<200902262137.15169.arnd@arndb.de>
	<20090226214919.GA19959@ovro.caltech.edu>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Tue, 21 Apr 2009 00:09:43 -0600
Message-ID: <fa686aa40904202309m1ce37e9dse38725e49c395852@mail.gmail.com>
Subject: Re: [RFC v2] virtio: add virtio-over-PCI driver
To: Ira Snyder <iws@ovro.caltech.edu>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Arnd Bergmann <arnd@arndb.de>, Jan-Bernd Themann <THEMANN@de.ibm.com>,
	netdev@vger.kernel.org, Rusty Russell <rusty@rustcorp.com.au>,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Feb 26, 2009 at 3:49 PM, Ira Snyder <iws@ovro.caltech.edu> wrote:
> On Thu, Feb 26, 2009 at 09:37:14PM +0100, Arnd Bergmann wrote:
>> If the registers for setting up this window don't logically fit
>> into the same device as the one you already use, the cleanest
>> solution would be to have another device just for this and then
>> make a function call into that driver to set up the window.
>
> The registers are part of the board control registers. They don't fit at
> all in the message unit. Doing this in the bootloader seems like a
> logical place, but that would require any testers to flash a new U-Boot
> image into their mpc8349emds boards.

Alternately, the board platform code (arch/powerpc/platforms/83xx) is
an ideal place for 'fixups'.  ie. to setup things that the firmware
really should be do, but doesn't.

>> > Now, I wouldn't need to access these registers at all if the bootloade=
r
>> > could handle it. I just don't know if it is possible to have Linux not
>> > use some memory that the bootloader allocated, other than with the
>> > mem=3DXXX trick, which I'm sure wouldn't be acceptable. I've just used
>> > regular RAM so this is portable to my custom board (mpc8349emds based)
>> > and a regular mpc8349emds. I didn't want to change anything board
>> > specific.
>> >
>> > I would love to have the bootloader allocate (or reserve somewhere in
>> > the memory map) 16K of RAM, and not be required to allocate it with
>> > dma_alloc_coherent(). It would save me plenty of headaches.
>>
>> I believe you can do that through the "memory" devices in the
>> device tree, by leaving out a small part of the description of
>> main memory, at putting it into the "reg" property of your own
>> device.
>>
>
> I'll explore this option. I didn't even know you could do this. =A0Is a
> driver that requires the trick acceptable for mainline inclusion? Just
> like setting up the 16K PCI window, this is very platform specific.

Yup.  You wouldn't even need to write any code to do this.  Just
reduce the memory node's RAM size listed in the .dts file by 16k and
add a 16K region to the reg property for the messaging region.

Speaking of which, the device tree changes should be adding 2 nodes; 1
node to describe the messaging unit, and 1 node to describe the virtio
instance.  The messaging unit is a general purpose piece of hardware,
so it is not appropriate to write a usage-specific device driver that
binds against it.  I'm kind of working on this right now, so I'll show
you what I mean in patch form when I actually get things running.

g.

--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
