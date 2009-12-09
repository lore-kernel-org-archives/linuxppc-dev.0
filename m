Return-Path: <glikely@secretlab.ca>
MIME-Version: 1.0
Sender: glikely@secretlab.ca
From: Grant Likely <grant.likely@secretlab.ca>
Date: Wed, 9 Dec 2009 15:06:29 -0700
Message-ID: <fa686aa40912091406i2ef4e1b2u25c9f46b20786245@mail.gmail.com>
Subject: Deprecating of_platform, the path from here...
To: devicetree-discuss <devicetree-discuss@lists.ozlabs.org>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Josh Boyer <jwboyer@linux.vnet.ibm.com>, Jeremy Kerr <jk@ozlabs.org>,
	Segher Boessenkool <segher@kernel.crashing.org>,
	Paul Mackerras <paulus@samba.org>, linuxppc-dev <linuxppc-dev@ozlabs.org>,
	David Miller <davem@davemloft.net>
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi all,

This is a summary of a discussion we had on #mklinux last night.

On PowerPC, SPARC and Microblaze, most system (non-discoverable)
devices are registered on the of_platform bus.  In the rest of the
kernel, the same kind of devices are registered on the platform bus.
The of_platform and platform busses essentially perform the same task;
proved a method for platform code to register a device that will be
bound to a driver at a later point in time.  The most significant
difference is that the of_platform bus understands how probe drivers
The OF Way using the 'compatible' property.  In the OF way, more than
one driver could match the device and the OS is responsible to choose
the best one.

The platform bus only supports matching a device to a driver based on
the device's name.  It has no mechanism for capturing the OF binding
model.

Maintaining of_platform comes at a cost.  Many device drivers end up
with two bus bindings, both of_platform_driver and platform_driver.
In practice this means a bunch of duplicated boilerplate and some ugly
#ifdef blocks.  Device driver authors don't seem thrilled to have
of_platform stuff "invade" their platform drivers.  Also, the
of_platform/platform split doesn't match the pattern used for other
bus subsystems (i2c, spi, mdio, etc).  On other busses, the same
driver is used regardless of whether the device was allocated
statically in platform code, obtained from the device tree, or
something else entirely.

So, the desire is to deprecate of_platform bus and use platform bus
for system devices in the device tree.  However, doing this requires
two problems to be solved:

1) device to driver matching - Given an OF style compatible list, how
is the device matched to the correct platform driver?
2) data translation - how and where is the device tree data
transformed into something usable by the platform driver?

The 2nd problem is the easy one to solve.  In most cases, any code to
translate device tree data into a driver platform_data structure is
driver specific.  A hook can be added to the top of the driver's
.probe() routine.  If no pdata pointer is set in the driver structure,
then it can call out to a helper function to create one from the
device tree data.  Something along the lines of:

pdata = pdev->dev.platform_data;
if (!pdata)
        pdata = pdriver_get_of_pdata(pdev);

It makes sense for this code to be called from the driver itself so
that the translation code only gets run when the device is actually
used.  By running the translators at probe time (instead of device
registration time) it means the translators don't need to be built
into the kernel.  On a kernel config with a lot of of-enabled drivers
this would be significant.

To solve the 1st problem the possibility was discussed is to add
compatible list parsing to both the platform bus and modutils.  Doing
so would make it easy to create platform devices from nodes in the
device tree, but it would be hard to get 'right'.  There is a risk
that it would break existing modutils (completely unacceptable).  It
is unclear how to make sure Linux probes the correct driver.  ie.  If
a compatible driver is loaded, but a 'better' driver is available,
then how is the kernel prevented from binding against the 'worse'
driver before the better driver is loaded?  Finally, while it may
solve the problem for the platform bus, the exact same problem needs
to also be solved for i2c, spi, mdio, etc.

In the end, the decision was to just use a simple lookup table of
compatible values to driver names.  When registering devices, platform
code will use the table to choose the best name.  Existing platform
devices can then bind against them as-is.  The downside is that the
table must be statically compiled into the kernel.  However, the
solution is simple and the table can probably be put into an initdata
section to be discarded after boot.  At a later date something more
sophisticated can be designed.

So, to summarize the decisions made:

1) of_platform will be deprecated in preference of the platform bus.
2) platform code will register platform devices at boot time
 - A lookup table will be used to translate 'compatible' values to
driver names used by the kernel
 - If no suitable compatible values exist in the table, then choose a
name programatically (ie. of_modalias_node()).  Userspace can force
bind to a driver after boot if desirable.
 - helper functions to be written to make registration simple (ie.
of_platform_bus_probe())
 - helper functions will fill in common resources (memory ranges and
irqs) but leave complex stuff to the driver
3) platform drivers will probe the same way they are probed now.  No
changes to the platform bus.
4) If drivers needs extra platform_data, then a call will be added to
the top of the .probe() hook to go and create one.

Cheers,
g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
