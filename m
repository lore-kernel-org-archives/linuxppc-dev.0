Date: Wed, 4 Apr 2001 15:01:32 +0200 (CEST)
From: Geir Frode Raanes <geirfrs@invalid.ed.ntnu.no>
To: linuxppc-embedded@lists.linuxppc.org
Subject: PCMCIA-ATA DMA and Minix/FATxx
Message-ID: <Pine.BSF.4.21.0104041359250.64110-100000@invalid.ed.ntnu.no>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


[System description]
We have designed a MPC855T system hooked up to an Altera '400 EPLD.
The FPGA perform the realtime JPEG compression of the image data
stream, piping it directly to ATA disk by means of DMA.

The Altera EPLD is interfaced to the PowerPC through the PCMCIA
port A, and is designed to present itself as a multifunctional
PCMCIA device of which the first is the ATA disk (controller)
connected to another port of the EPLD.

The ATA disk is in other words connected to a switched bus (MUX)
internal to the EPLD and at one time either connected to the PCMCIA
(PowerPC) interface or to the JPEG compression block but never both.



[Actual question]
It would be beneficial to have a filesystem that allows for linear
write of large files (~20-50GB) and a partitioning scheme that allows
the ATA disk to be removed and later plugged into an IBM PC.

The partitioning and formatting must be possible to perform over the
MPC855T PCMCIA interface by PowerPC/Linux. The free space must be
absolutely free (no interspaced file system nodes) since the EPLD
will perform raw write form start LBA outwards. Upon completion the
data will be backannotated into the file system by means of patching
file tables with start LBA and end LBA. No CRC/ECC.

FAT16 is well documented and would have been a perfect solution.
But 2GB partition size is unfortunately unacceptable. FAT32 seems
more obscure and is not so well documented. Any good references?
Minix is told to be simple but where is it documented?
Any other filesystems w/docs? (MAC/SUN/ISO filesystems&partitioning?)



Also, does PPC/Linux now detect PCMCIA ATA drives out of the box
without any resort to interrupt rerouting and the like? (The system
will - when the HW will arrive in three weeks time - boot from Flash
with initrd, not from the PCMCIA ATA disk.)

--

Geir Frode Raanes
Norsk Elektro Optikk A/S
[www.neo.no]


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
