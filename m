Return-Path: <David.Laight@ACULAB.COM>
Received: from mx0.aculab.com (mx0.aculab.com [213.249.233.131])
	by ozlabs.org (Postfix) with SMTP id 7CE7EB70DF
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon,  6 Dec 2010 23:18:45 +1100 (EST)
Received: from mx0.aculab.com ([127.0.0.1])
	by localhost (mx0.aculab.com [127.0.0.1]) (amavisd-new,
	port 10024) with SMTP
	id 32632-06 for <linuxppc-dev@lists.ozlabs.org>;
	Mon,  6 Dec 2010 12:18:39 +0000 (GMT)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: Getting the IRQ number (Was: Basic driver devel questions ?)
Date: Mon, 6 Dec 2010 12:17:23 -0000
Message-ID: <AE90C24D6B3A694183C094C60CF0A2F6D8ABE8@saturn3.aculab.com>
In-Reply-To: <201012061058.37612.dargaud@lpsc.in2p3.fr>
From: "David Laight" <David.Laight@ACULAB.COM>
To: <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

=20

> That's the idea. Communication between usermode and the driver is
limited to=20
> simple ioctl calls and the driver receives an interrupt when certain
data has=20
> been placed in memory blocks by the hardware (like a DMA).=20
> Then the user prog figures out where that latest data buffer is (mmap)
and saves it.=20

I've used pread() and pwrite() to directly copy data to/from a devices
PCI memory space.
The driver just verifies the offset and calls copy_to/from_user() [1].
High offsets can be used to access driver specific data.
The userspace code for pread/write is less painful than using ioctl()
for everything.
This also lets you dump the device memory space with hexdump.

I also made the device interrupt generate POLLIN (this needs a bit of
care since the interrupt can arrive before poll() is called).

	David

[1] I actually had to use the PCIe dma controller to get adequate
throughput.
