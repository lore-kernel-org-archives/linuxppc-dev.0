Return-Path: <cthomas@Soneticom.com>
Received: from Soneticom.com (soneticom.com [209.114.210.150])
	by ozlabs.org (Postfix) with ESMTP id BCB0467C17
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 22 Aug 2006 06:45:30 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: Linux hanging on Xilinx SystemACE
Date: Mon, 21 Aug 2006 16:45:27 -0400
Message-ID: <3C02138692C13C4BB675FE7EA240952918DE10@bluefin.Soneticom.local>
In-Reply-To: <OF66C0423D.E933F8BD-ON072571CC.0077CC69-072571CC.007906BE@mck.us.ray.com>
From: "Clint Thomas" <cthomas@Soneticom.com>
To: "Keith J Outwater" <kjoutwater@raytheon.com>,
	<linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

The adapter.c file fixed the problem, however running in polling I/O
mode is far too slow. Since this is not an option for successful
operation of our machine, do you know of a driver fix for this problem?
Perhaps a newer version of the linux source tree is necessary. I'm using
the Linuxppc_2_4_devel tree available from bkbits/mvista. Thanks for the
help so far!

Clint Thomas

-----Original Message-----
From: linuxppc-embedded-bounces+cthomas=3Dsoneticom.com@ozlabs.org
[mailto:linuxppc-embedded-bounces+cthomas=3Dsoneticom.com@ozlabs.org] On
Behalf Of Keith J Outwater
Sent: Wednesday, August 16, 2006 6:02 PM
To: linuxppc-embedded@ozlabs.org
Subject: Re: Linux hanging on Xilinx SystemACE

Clint,

> Using the powerpc development tree of Linux 2.4, I am trying to boot=20
> my
system from CompactFlash using Xilinx SystemACE. My compact flash card
has two partitions, a 16MB FAT16 that holds the combination FPGA image /
Linux Kernel ELF file, and an Ext2 partition that holds the root file
system.=20
The system starts the boot process, uncompresses the Linux kernel and
begins loading drivers. Part way into this process, it conducts a
partition check of the drive being reported to it by SystemACE, however,
it hangs at that point. No kernel panic, no error message, it simply
hangs. Here is the output at that point...
>=20
> Partition check:
>  xsysacea:
>=20
> what I am trying to find out is if this problem has been seen/fixed in
the past? or did I format the CF card incorrectly?
>=20

I have a system that uses the SystemAce in a similar way.  I was also
having lockups.  After a lot of digging, I found a patch by John Masters
(e-mail unknown) to the MontaVista SystemAce driver in the 2.4 kernel
that disables the use of interrupts and runs the SystemAce in a polled
mode.=20
Performance is not that great, but at least it does not crash with the
patch.  As I recall, the reason that the unpatched driver crashed is
that the SystemAce is issuing more than one interrupt upon completion of
a sector read or write.  Apparently, the Xilinx ML300 board works fine
without this patch while other eval boards like the Memec DS-BD-2VPxx
crash without the patch.

This still may not be your problem, but the patch may help later on.

I've attached the patched file.  The file is from
./drivers/block/xilinx_sysace/adapter.c in the 2.4.30 from MontaVista.

Keith
