Date: Fri, 8 Feb 2002 10:36:00 -0700
From: Val Henson <val@nmt.edu>
To: linuxppc-dev@lists.linuxppc.org
Subject: Re: Highmem on PPC?
Message-ID: <20020208103600.B24460@boardwalk>
References: <20020205115618.D6834@boardwalk> <20020205193316.19866@smtp.wanadoo.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20020205193316.19866@smtp.wanadoo.fr>; from benh@kernel.crashing.org on Tue, Feb 05, 2002 at 08:33:16PM +0100
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, Feb 05, 2002 at 08:33:16PM +0100, Benjamin Herrenschmidt wrote:
>
> And let me know if you find something ;)

In my quest for a non-SCSI block device, I tried using loopback over
NFS. :) Okay, loopback doesn't normally work, and it's not surprising
that it doesn't work over NFS with highmem enabled.  If anyone is
interested, this script immediately crashes on the latest 2_4_devel,
only with NFS mounted root and with some memory in highmem:

#!/bin/bash
dd if=/dev/zero of=file bs=1024 count=10000
losetup /dev/loop0 file
mke2fs /dev/loop0

Exception info and backtrace from xmon (I have sysmap included on
Gemini):

1:mon> e
cpu 1: vector: 300 at pc = c001239c (T memcpy+0x24), lr = c00d5b9c (t transfer_none+0x40)
msr = 9032, sp = df9fdf60 [df9fdeb0]
dar = 0, dsisr = 42000000
current = df9fc000, pid = 426, comm = loop0
1:mon> t
backtrace:
c00899e4 (t nfs_prepare_write+0x10)
c00d5e5c (t lo_send+0x13c)
c00d6278 (t do_bh_filebacked+0x98)
c00d6ba0 (t loop_thread+0x194)
c00076b8 (T kernel_thread+0x2c)

I suspect that nfs_prepare_write is not properly kmapping/kunmapping
something.

If anyone else feels like fixing this, feel free... It's not high on
my list of priorities. :)

-VAL

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
