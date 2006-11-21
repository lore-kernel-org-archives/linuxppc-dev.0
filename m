Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id AE29668476
	for <linuxppc-dev@ozlabs.org>; Tue, 21 Nov 2006 17:33:12 +1100 (EST)
Received: from [127.0.0.1] (localhost.localdomain [127.0.0.1])
	by gate.crashing.org (8.13.8/8.13.8) with ESMTP id kAL6X75l015134
	for <linuxppc-dev@ozlabs.org>; Tue, 21 Nov 2006 00:33:08 -0600
Subject: [RFC] making phandle's mandatory for of_platform_device
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Content-Type: text/plain
Date: Tue, 21 Nov 2006 17:33:47 +1100
Message-Id: <1164090827.5597.14.camel@localhost.localdomain>
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Folks !

I'd like to start a discussion about possibly making phandle's mandatory
to use the new facility to automatically create of_platform_device's
from the device-tree...

The problem I'm having is to makeup the "bus_id" name of the
of_platform_device's. sysfs forces us to use unique names for a given
bus type here since links in /sys/bus/<bus_type/ are all at the same
level.

Right now, I'm making something up based on the "reg" or "dcr-reg"
property and device name, though because of the risk of collision, I
also had to add a bogo counter for nodes with no "reg" nor "dcr-reg" and
I had to fully translate those addresses as well to make them as unique
as possible. It's fairly hairy and with 64 bits platforms, the address
is getting pretty big for the little space we have for bus-id thus
leaving not much room for the name...

When porting some of our OF stuff to sparc64, Dave Miller used a
different approach which is to use instead the phandle, which is
guaranteed to be at most 8 characters (32 bits hex number).

That would be a good option for us as well... if we didn't make
phandle's optional with the flat device-tree definition...

Thus I'm asking wether it would be ok with you guys to make it mandatory
again under some circumstances. There are several options there:

 1 - Stick to my current hairy stuff and plaster on possible new
problems popping up with it, and live with the uglyness on 64 bits
platforms
 2 - Make it mandatory for all nodes to have a phandle (all of them)
 3 - Make it mandatory for nodes that can be declared as
of_platform_device to have a phandle
 4 - Make it mandatory for nodes that can be declared as any child of
of_device to have a phandle (and use a consistent naming accross all
childs of of_device, like macio_device, of_platform_device, etc...)
 5 - Make it mandatory for nodes using the new automatic generation of
of_platform_devices from the device-tree to have phandles.


Option 5 is the less invasive since nobody uses my new mecanism yet
except IBM Cell blades and they have a real OF, thus phandles for all
nodes. 

Option 2 is the most invasive and would require current platforms to
change their trees

Option 4 sounds like the cleanest "in between" option to me though it
will need some changes to some code like the macio device stuff.

Comments ?

In any case, I can simply make the code refuse to register the
of_platform_device (ignore it) if the phandle is not there.

Cheers,
Ben.
