Date: Sun, 24 Mar 2002 12:09:30 -0700
From: Val Henson <val@nmt.edu>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: EV-64260-BP & GT64260 bi_recs
Message-ID: <20020324120930.A14640@boardwalk>
References: <20020322210103.C3363@boardwalk> <20020324122048.8670@smtp.wanadoo.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20020324122048.8670@smtp.wanadoo.fr>; from benh@kernel.crashing.org on Sun, Mar 24, 2002 at 01:20:48PM +0100
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sun, Mar 24, 2002 at 01:20:48PM +0100, Benjamin Herrenschmidt wrote:
>
> We define a special BI_DEVICE type of bi_rec that represents
> a HW device for which the firmware provides some informations. Since
> the firmware is free to provide whatever informations it want (that
> set is not fully defined), the content of the BI_DEVICE record is itself
> a list of bi_recs.
<snip>
> The "standard" kernel only define a few BI_DEV_TYPE's (like PCI,
> 4xx OCP, 8xx OCP). Drivers define attributes they can read from the
> BI_DEVICE (4xx ethernet can read a HW eth adress for example).
> Board vendors are free to provide additional information in the
> BI_DEVICE, and add the ability to the driver (patches welcome) to
> make good use of that information ;) (Could be, for example, wiring
> of the PHY since it may not use MII, etc...).
>
> What do you think ?

I had an amazing and brilliant insight (which I'm sure everyone else
has already had). :) The kernel just ignores bi_recs it doesn't
understand.  Really, you don't need any BI_DEV_TYPE's for non-core
kernel code - just a type that the kernel is guaranteed never to use
for any other bi_rec type.

How about one BI_IGNORE type, and driver writers and firmware authors
can put whatever they feel like inside that bi_rec?  The BI_IGNORE
bi_rec can contain whatever you want - more bi_recs, object code,
random data - and it would be the driver and firmware writers'
responsibility to make them match up.  I personally think this is an
awful idea, but it would give everyone the freedom they want while
staying within the very nice bi_rec interface.  The rest of the
bi_recs, the ones that the core kernel code will interpret, can be
simple, one-dimensional bi_recs.  What do you think, Ben?

I really agree with Dan Malek on this - we shouldn't use bi_recs as a
way to reimplement methods of passing information that already exist,
for example, the __setup() functions.  It should be a way of passing
information that only a bootloader can know, such as the location of a
ramdisk, or the command line that the user typed into the bootloader.
People who don't agree with this philosophy can shove whatever they
like into the BI_IGNORE record type, and suffer the consequences. :)

-VAL

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
