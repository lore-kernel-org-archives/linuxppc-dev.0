Message-ID: <410F05EC.1040405@realitydiluted.com>
Date: Mon, 02 Aug 2004 22:26:36 -0500
From: "Steven J. Hill" <sjhill@realitydiluted.com>
MIME-Version: 1.0
To: linuxppc-dev@lists.linuxppc.org
Subject: 750 and Discovery II coherency with PCI....
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Greetings.

I am writing a device driver for a PMC card that is nothing
fancy. It is not a PCI-X card though. My Linux driver properly
detects the device, 'ioremaps' the PCI IO and MEM regions then
attempts to start writing the devices registers for setup
and configuration. I am not getting valid reads and there
appears to be some coherency issues. I have verified that no
other drivers or resources in the system are utilizing the
addresses that are returned to me from 'ioremap'. I have the
following code snippet:

#define shunt_read_8(offset)		\
	*((volatile u8 *) (shunt_dev->ctrl_base + offset))
[SNIP]
		svalue[0] = shunt_read_8(SHUNT_ADDRESS + 0x220);
		svalue[1] = shunt_read_8(SHUNT_ADDRESS + 0x221);
		svalue[2] = shunt_read_8(SHUNT_ADDRESS + 0x222);
		svalue[3] = shunt_read_8(SHUNT_ADDRESS + 0x223);

		printk("0x%02x\n", svalue[0]);
		printk("0x%02x\n", svalue[1]);
		printk("0x%02x\n", svalue[2]);
		printk("0x%02x\n", svalue[3]);

If I read the byte addresses above, which are in the remapped PCI I/O address
space and I get the following output:

0x00
0x00
0x00
0x00

which is of course, incorrect. I even tried using the 'in_8' macro functions
in 'asm-ppc/io.h'. I get the same results. Now, if I instead do the following
code snippet:

		printk("0x%02x\n", shunt_read_8(SHUNT_ADDRESS + 0x220));
		printk("0x%02x\n", shunt_read_8(SHUNT_ADDRESS + 0x220));
		printk("0x%02x\n", shunt_read_8(SHUNT_ADDRESS + 0x220));
		printk("0x%02x\n", shunt_read_8(SHUNT_ADDRESS + 0x221));
		printk("0x%02x\n", shunt_read_8(SHUNT_ADDRESS + 0x222));
		printk("0x%02x\n", shunt_read_8(SHUNT_ADDRESS + 0x223));

I now get the output of:

0x00
0x81
0x81
0x02
0x0e
0x0e

The first time I read 0x220, it is incorrect, but the following two times and
the other remaining values are now correct. Unfortunately, this device is the
only PMC device that I have to test. I do not have any other PMC cards. This
behavior exists in both the 2.4 kernel and in my 2.6 kernel. The virtual
addresses received from the 'ioremap' call are identical on both 2.4 and 2.6,
just for reference. I tried adding in memory barriers and 'eieio' calls, but
I did not expect those to make a difference...and it did not. Has anyone ever
seen similar behavior? Preferably I would like to hear from people working
with Discovery II parts. I have documentation under NDA, but I am still working
my way through it. Thanks in advance.

-Steve

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
