Message-ID: <20040110182613.32309.qmail@web40412.mail.yahoo.com>
Date: Sat, 10 Jan 2004 10:26:13 -0800 (PST)
From: Todd <to_dd@yahoo.com>
Subject: unmapping PCI Device / <BAD> iomem
To: linuxppc-embedded@lists.linuxppc.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello:

I am working on a kernel module in Linux 2.4.18 to
talk to a cPCI board.  Allocating memory has not been
a problem, and IO with the board works fine.  When I
try to remove the module and unmap the memory for the
board, I get the following messages:

00:01:23 ssu40:module_cleanup() cleanup_module entered
Trying to vfree() nonexistent vm area (c9031000)
Trying to vfree() nonexistent vm area (c9031000)
Trying to free nonexistent resource
<00000000-000fffff>
Trying to free nonexistent resource
<00000000-0000007f>

I also noticed an entry in /proc/iomem called <BAD>,
along with the entries for PCI_BASE[0] and PCI_BASE[2]
of my board:
cat /proc/iomem
00000000-ffffffff : <BAD>
  f7e00000-f7efffff : ssu40
  f7ffff80-f7ffffff : ssu40

I'm guessing this could be related to the following
messages at startup:
PCI: Cannot allocate resource region 0 of PCI bridge 1
PCI: resource is fc000000..ffffffff (100), parent
c0170ccc
PCI: Cannot allocate resource region 1 of PCI bridge 1
PCI: resource is 0..ffffffff (200), parent c0170ce8
PCI:00:01.0: Resource 0: fe000000-fe00ffff (f=101)

I have included a more broad message listing below.
Can anyone let me know what possible actions might
resolve this issue.

best regards,

Todd




==========================================================
Startup Messages:

PCI: Probing PCI hardware
Fixup res 0 (101) of dev 00:01.0: 4000000 -> fe000000
Fixup res 1 (200) of dev 00:01.0: 40000000 -> f8000000
Fixup res 0 (200) of dev 00:02.0: 43fff000 -> fbfff000
Fixup res 1 (101) of dev 00:02.0: 4ffffc0 -> feffffc0
Fixup res 2 (200) of dev 00:02.0: 43fc0000 -> fbfc0000
Fixup CPC710 resources
Fixup res 0 (200) of dev 01:11.0: 7ffff80 -> f7ffff80
Fixup res 1 (101) of dev 01:11.0: 1ffff80 -> fdffff80
Fixup res 2 (200) of dev 01:11.0: 7e00000 -> f7e00000
PCI: Cannot allocate resource region 0 of PCI bridge 1
PCI: resource is fc000000..ffffffff (100), parent
c0170ccc
PCI: Cannot allocate resource region 1 of PCI bridge 1
PCI: resource is 0..ffffffff (200), parent c0170ce8
PCI:00:01.0: Resource 0: fe000000-fe00ffff (f=101)
PCI:00:01.0: Resource 1: f8000000-f800ffff (f=200)
PCI:00:02.0: Resource 0: fbfff000-fbffffff (f=200)
PCI:00:02.0: Resource 1: feffffc0-feffffff (f=101)
PCI:00:02.0: Resource 2: fbfc0000-fbfdffff (f=200)
PCI:01:11.0: Resource 0: f7ffff80-f7ffffff (f=200)
PCI:01:11.0: Resource 1: fdffff80-fdffffff (f=101)
PCI:01:11.0: Resource 2: f7e00000-f7efffff (f=200)
Linux NET4.0 for Linux 2.4
============================================================

messages from driver:

00:00:00 ssu40:probe_device() PCIBAR[0]  Addr =
0xF7FFFF80  Size = 0x00000080
00:00:01 ssu40:probe_device() PCIBAR[2]  Addr =
0xF7E00000  Size = 0x00100000
00:00:01 ssu40:probe_device() PCIBAR[0] Kernel VA:
f7ffff80
00:00:01 ssu40:probe_device() PCIBAR[2] Kernel VA:
f7e00000
00:00:01 ssu40:probe_device() Device is not using an
interrupt resource
00:00:01 ssu40:probe_device() u32reg = 0x00000000
00:00:01 ssu40:driverInit() driver registered
successfully with the PCI subsystem
00:00:01 ssu40:driverInit() 1 cPCI devices claimed by
the driver
00:00:01 ssu40:registerChrdrv() major number is being
dynamically assigned
00:00:01 ssu40:registerChrdrv() registering the char
driver PASSED. Major# = 254
00:00:01 ssu40:registerChrdrv() creating ssu_mgmt node
at minor number: 37
00:00:01 ssu40:registerChrdrv() creating ssu_00.05
node at minor number: 5
00:00:01 ssu40:module_initialization() MGMT Handle
open flag = 0
00:00:02 ssu40:module_initialization() Initialization
completed successfully.

cat /proc/iomem
00000000-ffffffff : <BAD>
  f7e00000-f7efffff : ssu40
  f7ffff80-f7ffffff : ssu40
  f8000000-f800ffff : PCI device 1310:000d (Gespac)
  fbfc0000-fbfdffff : Intel Corp. 82559ER
  fbfff000-fbffffff : Intel Corp. 82559ER
    fbfff000-fbffffff : eepro100
bash-2.05#

==========================================================

removing the driver:

bash-2.05# rmmod ssuMod

00:01:23 ssu40:module_cleanup() cleanup_module
entered...
Trying to vfree() nonexistent vm area (c9031000)
Trying to vfree() nonexistent vm area (c9031000)
Trying to free nonexistent resource
<00000000-000fffff>
Trying to free nonexistent resource
<00000000-0000007f>
00:01:23 ssu40:remove_device() running.... stop()
00:01:24 ssu40:unregisterChrdrv() started...
00:01:24 ssu40:unregisterChrdrv()
devfs_unregister_chrdev SUCCESS
00:01:24 ssu40:module_cleanup() goodbye!


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
