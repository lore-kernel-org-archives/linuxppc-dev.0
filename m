Date: Wed, 17 Nov 1999 12:27:15 +0100
To: linuxppc-dev@lists.linuxppc.org
CC: paulus@linuxcare.com
From: Benjamin Herrenschmidt <bh40@calva.net>
Subject: OF boot and kernel devices
Message-Id: <19991117122715.032511@mailhost.mipsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi !

I'm working on an OF bootloader (mostly made from quik and poof code with
a slice of Darwin's SecondaryLoader) that will do everything we have ever
wanted from an OF bootloader. (My goal is to be able to definitely get
rid of BootX for newworld machines so that the kernel can rely on the
phandle values of the device tree and RTAS).

In order for such a bootloader to work as transparently as possible, the
kernel should be able to correctly configure various OF device path (so
that, after installation, there's no need to go to OF user interface and
edit the path by hand which is a real pain).

This involves several things for which I'd like your points of view:

 - We need to be able to match a given Linux block device with it's Open
Firmware device-tree full path and unit number (when possible). I'm still
wondering what is the best way to do that. I can't think of a solution
that would work without adding a bit of code to every driver, but it
could be a single function call in most cases.
I'm still wondering if we can have the driver somewhat add those infos to
the device tree (we can add a few slots in the device_node structure or
simply add properties, which is probably better). We should then provide
a helper function for ordinary PCI devices that just takes the pci_dev
and major/minor as parameters and which will do the device-tree lookup to
find the device node automatically.
We can also maintain a separate table, and we can have a /proc like
inteface to drivers (seems more complex).
We may also have a separate table in the form of new nodes added the the
kenrel's device tree (may be easier for devices with several units).
We need to retreive those infos from userland, that's why I think adding
things to the device tree.

 - We need to fix the devices names when booting from BootX so that the
device tree contains the full names with the @xxxxxxxx address appended,
like it does with OF.
This is important since the current implementation does weird things when
several devices have the same name. (iBooks for example have 3 "pci"
nodes). I didn't yet find the info about how to build this name
extension, I think it's done from the reg property but there are a few
things to take into account in order to do it right, I would appreciate
some advice.

 - The bootloader will probably have to reside on an HFS partition (at
least for PowerMacs). This would be a small bootstrap partition,
invisible to MacOS, like MacOS X/Darwin uses. The kernel, of course, can
be on an ext2 volume (and I'm also thinking about iso for CD booting).
I'm thinking about putting also the booter config file there, this would
probably be more coherent since the booter won't rely on a specific linux
installation (you can have several roots and choose which one to boot).
Kernel HFS support may have trouble in the near future (2.3.x) but hfs
utils still work fine, don't they ?
Also, I'm thinking about an algorith similar to the one used by Darwin's
bootloader that could scan available devices for bootable partitions. I
still have to experiment a bit with this however.

I'm waiting for your advice, I have done some rought experiments for now,
I'll start real coding on this by this week end.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
